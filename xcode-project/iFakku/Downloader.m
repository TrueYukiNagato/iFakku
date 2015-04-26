//
//  Downloader.m
//  iFakku
//
//  Created by Yuki Nagato on 2/25/15.
//  Copyright (c) 2015 SOS Brigade. All rights reserved.
//

#import "Downloader.h"

@implementation Downloader {
    NSMutableDictionary *downloadQueue; // Dictionary because download tasks identifier causes problems in NSMutableArray, can keep track of QueueID
    NSMutableDictionary *downloadTasks; // Dictionary because download tasks identifier causes problems in NSMutableArray
    NSMutableDictionary *downloadTasksOld; // Dictionary because download tasks identifier causes problems in NSMutableArray
    NSMutableArray *downloadTasksPaused; // Dictionary because download tasks identifier causes problems in NSMutableArray
    NSURLSession *session;
    BOOL isPaused;
}

static Downloader *DownloaderInstance;

+ (Downloader*)getInstance {
    if (DownloaderInstance == nil) {
        DownloaderInstance = [[super alloc] init];
    }
    
    return DownloaderInstance;
}

- (NSURLSession*)safeGetSession {
    if(!session) {
        // Ignore to support iOS7+ instead of iOS8+
        NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration backgroundSessionConfiguration:@"com.iFak"];
        sessionConfiguration.HTTPMaximumConnectionsPerHost = 3;
        session = [NSURLSession sessionWithConfiguration:sessionConfiguration delegate:self delegateQueue:nil];
    }
    return session;
}

- (NSDictionary*)getDownloadQueue {
    return downloadQueue;
}

- (BOOL)getIsPaused {
    return isPaused;
}


-(void)saveLoadedDownloadMangaModel:(DownloadMangaModel*)downloadMangaModel {
    int pageId = 0;
    for(MangaPage *mangePage in downloadMangaModel.manga.mangaPages) {
        [FileSystemHelper saveDownloadMangaModel:downloadMangaModel UIImage:mangePage.mangaPageImage OfPage:pageId];
        NSLog(@"<%@> Page %d saved.", downloadMangaModel.manga.mangaTitleDigitized, pageId);
        pageId++;
    }
    [downloadMangaModel handleDownloadCompletion];
}

-(void)addDownloadMangaModelToDownloadQueue:(DownloadMangaModel*)downloadMangaModel {
    if(!downloadQueue) {
        downloadQueue = [[NSMutableDictionary alloc]init];
    }
    if(!downloadTasks) {
        downloadTasks = [[NSMutableDictionary alloc]init];
    }
    if(!downloadTasksPaused) {
        downloadTasksPaused = [[NSMutableArray alloc]init];
    }

    int queueId = downloadQueue.count; // Just a unique identifier that is reused everytime a download completes. Does not infinitely autoincrement.
    NSString *queueIdAsString = [NSString stringWithFormat:@"queue%d", queueId];
    
    [downloadQueue setObject:downloadMangaModel forKey:queueIdAsString];
    [self startQueueOfId:queueId];
}

- (void)startQueueOfId:(int)queueId {
    NSString *queueIdAsString = [NSString stringWithFormat:@"queue%d", queueId];
    DownloadMangaModel *downloadMangaModel = [downloadQueue objectForKey:queueIdAsString];
    int pageId = 0;
    for(NSString *pageUrlAsString in downloadMangaModel.manga.mangaExternalPageListing) {
        NSURL *pageUrl = [NSURL URLWithString:pageUrlAsString];
        NSURLSessionDownloadTask *downloadTask = [[self safeGetSession] downloadTaskWithURL:pageUrl];
        NSMutableDictionary *downloadTaskMeta = [[NSMutableDictionary alloc] initWithDictionary:@{@"downloadTask": downloadTask, @"pageId": [NSString stringWithFormat:@"%d", pageId], @"pageUrl":pageUrl, @"queueIdAsString": queueIdAsString, @"resumeData":[NSNull null]}];
        
        if(![NetworkHelper isNetworkAvailable]) {
            [self pauseAllTransfers];
        }
        
        if(isPaused) {
            [downloadTasksPaused addObject:downloadTaskMeta];
        } else {
            NSString *downloadTaskIdentifierAsString = [NSString stringWithFormat:@"task%lu", (unsigned long)downloadTask.taskIdentifier];
            [downloadTasks setObject:downloadTaskMeta forKey:downloadTaskIdentifierAsString];

            [downloadTask resume];
        }
        pageId++;
    }
}

-(void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location{
    NSString *downloadTaskIdentifierAsString = [NSString stringWithFormat:@"task%lu", (unsigned long)downloadTask.taskIdentifier];
    NSDictionary *downloadTasksMeta;
    
    if(isPaused) {
        downloadTasksMeta = [downloadTasksOld objectForKey:downloadTaskIdentifierAsString];
    } else {
        downloadTasksMeta = [downloadTasks objectForKey:downloadTaskIdentifierAsString];
    }
    
    int pageId = [[downloadTasksMeta objectForKey:@"pageId"] intValue];
    NSString *queueIdAsString = [downloadTasksMeta objectForKey:@"queueIdAsString"];

    if(isPaused) {
        [downloadTasksOld removeObjectForKey:downloadTaskIdentifierAsString];
    } else {
        [downloadTasks removeObjectForKey:downloadTaskIdentifierAsString];
    }

    
    DownloadMangaModel *downloadMangaModel = [downloadQueue objectForKey:queueIdAsString];
    [downloadMangaModel markPageAsDownloaded:pageId];
    
    [FileSystemHelper moveDownloadedMangaPageOfDownloadMangaModel:downloadMangaModel ofPageId:pageId fromTempDirectoryAt:location];
    
    if(downloadMangaModel.allPagesCompleted == YES) { // Completion handling done over here so downloadQueue can be removed.
        [downloadMangaModel handleDownloadCompletion];
        [downloadQueue removeObjectForKey:queueIdAsString];
    }
}

- (void)pauseAllTransfers {
    isPaused = YES;
    downloadTasksOld = [[NSMutableDictionary alloc ]initWithDictionary:downloadTasks];
    
    for (NSString *downloadTaskIdentifierAsString in [downloadTasks copy]) {
        NSMutableDictionary *downloadTaskMeta = [downloadTasks objectForKey:downloadTaskIdentifierAsString];
        NSURLSessionDownloadTask *downloadTask = [downloadTaskMeta objectForKey:@"downloadTask"];
        [downloadTask cancelByProducingResumeData:^(NSData *resumeData) {
            if (resumeData != nil) {
                NSData *resumeDataToWrite = [[NSData alloc] initWithData:resumeData];
                [downloadTaskMeta setObject:resumeDataToWrite forKey:@"resumeData"];
            } else {
                [downloadTaskMeta setObject:[NSNull null] forKey:@"resumeData"];
            }
        }];
        [downloadTasksPaused addObject:downloadTaskMeta];
        [downloadTasks removeObjectForKey:downloadTaskIdentifierAsString];
    }
}

- (void)resumeAllTransfers {
    isPaused = NO;
    [downloadTasks removeAllObjects];
    for (NSMutableDictionary *downloadTaskMeta in downloadTasksPaused) {
        NSURLSessionDownloadTask *downloadTask;

        if([downloadTaskMeta objectForKey:@"resumeData"] == [NSNull null]) {
            downloadTask = [[self safeGetSession] downloadTaskWithURL:[downloadTaskMeta objectForKey:@"pageUrl"]];

        } else {
            NSData *resumeDataToWrite = [[NSData alloc] initWithData:[downloadTaskMeta objectForKey:@"resumeData"]];
            downloadTask = [[self safeGetSession] downloadTaskWithResumeData:resumeDataToWrite];

        }
        
        NSString *downloadTaskIdentifierAsString = [NSString stringWithFormat:@"task%lu", (unsigned long)downloadTask.taskIdentifier];

        [downloadTaskMeta setObject:downloadTask forKey:@"downloadTask"];
        [downloadTasks setObject:downloadTaskMeta forKey:downloadTaskIdentifierAsString];
        [downloadTask resume];
    }
    [downloadTasksOld removeAllObjects];
}

@end