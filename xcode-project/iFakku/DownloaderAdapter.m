//
//  DownloadAdapter.m
//  iFakku
//
//  Created by Yuki Nagato on 2/25/15.
//  Copyright (c) 2015 SOS Brigade. All rights reserved.
//

#import "DownloaderAdapter.h"

@implementation DownloaderAdapter

static Downloader *DownloaderInstance;
static dispatch_queue_t downloaderInstanceQueue;



+(void)downloadMangaFromMangaModel:(MangaModel*)manga {
    if(!DownloaderInstance) {
        DownloaderInstance = [Downloader getInstance];
    }
    if(!downloaderInstanceQueue) {
        downloaderInstanceQueue = dispatch_queue_create("downloaderInstanceQueue", NULL);
    }
    
    dispatch_async(downloaderInstanceQueue, ^{
        DownloadMangaModel *downloadMangaModel = [[DownloadMangaModel alloc] initWithMangaModel:manga];
        [DownloaderInstance addDownloadMangaModelToDownloadQueue:downloadMangaModel];
    });
}

+(void)saveLoadedMangaModel:(MangaModel*)manga {
    if(!DownloaderInstance) {
        DownloaderInstance = [Downloader getInstance];
    }
    
    DownloadMangaModel *downloadMangaModel = [[DownloadMangaModel alloc] initWithMangaModel:manga];
    [DownloaderInstance saveLoadedDownloadMangaModel:downloadMangaModel];
}

+(NSArray*)getDownloadQueueAsArray {
    if(!DownloaderInstance) {
        DownloaderInstance = [Downloader getInstance];
    }
    
    NSDictionary *downloadQueue = [DownloaderInstance getDownloadQueue];
    NSMutableArray *downloadQueueAsArray = [[NSMutableArray alloc]init];
    
    for(id queueId in downloadQueue) {
        [downloadQueueAsArray addObject:[downloadQueue objectForKey:queueId]];
    }
    
    return downloadQueueAsArray;
}

+(BOOL)getIsPaused {
    return [DownloaderInstance getIsPaused];
}

+(void)pauseAllTransfers {
    [DownloaderInstance pauseAllTransfers];
}

+(void)resumeAllTransfers {
    [DownloaderInstance resumeAllTransfers];
}

@end
