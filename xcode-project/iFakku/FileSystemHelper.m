//
//  FileSystemHelper.m
//  iFakku
//
//  Created by Yuki Nagato on 2/26/15.
//  Copyright (c) 2015 SOS Brigade. All rights reserved.
//

#import "FileSystemHelper.h"

#import "FakkuAPIMangaReadPage.h"

#import "MangaModel.h"
#import "DownloadMangaModel.h"

@implementation FileSystemHelper

static NSString *documentsDirectory;

+ (NSString*)getDocumentsDirectoryPath {
    
    if(!documentsDirectory) {
        NSArray *searchPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        documentsDirectory = [searchPaths lastObject];
        NSLog(@"<%@> Documents static directory created.", documentsDirectory);
    }
    
    return documentsDirectory;
}

+(UIImage*)getImageFromFile:(NSString *)file {
    NSString *imageUrl = [NSString stringWithFormat:@"%@/%@", [self getDocumentsDirectoryPath], file];
    NSLog(@"<%@> Image loaded.", imageUrl);
    NSData *data = [NSData dataWithContentsOfFile:imageUrl];
    UIImage *img = [[UIImage alloc] initWithData:data];
    
    return img;
}

+ (void)prepareFileSystemForDownloadMangaModel:(DownloadMangaModel*)downloadMangaModel {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *documentsDirectory = [self getDocumentsDirectoryPath];
    NSError *error;
    
    NSString *mangaCategoryFolderPath = [documentsDirectory stringByAppendingPathComponent:downloadMangaModel.manga.mangaCategory.mangaCategoryDigitized];
    
    if (![fileManager fileExistsAtPath:mangaCategoryFolderPath]) {
        [fileManager createDirectoryAtPath:mangaCategoryFolderPath withIntermediateDirectories:NO attributes:nil error:&error];
    }
    
    NSString *mangaTitleDigitized = downloadMangaModel.manga.mangaTitleDigitized;
    NSString *mangaTitleFolderPath = [mangaCategoryFolderPath stringByAppendingPathComponent:mangaTitleDigitized];
    
    if (![fileManager fileExistsAtPath:mangaTitleFolderPath]) {
        [fileManager createDirectoryAtPath:mangaTitleFolderPath withIntermediateDirectories:NO attributes:nil error:&error];
        [self saveMangaPreviewThumbnails:downloadMangaModel];
    }
}

+ (void)updateGlobalDownloadPlist:(DownloadMangaModel*)downloadMangaModel {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *documentsDirectory = [self getDocumentsDirectoryPath];
    
    //Update Downloads
    NSString *downloadsFilePath = [documentsDirectory stringByAppendingPathComponent:@"MangaDownloaded.plist"];
    NSMutableArray *existingDownloads = [[NSMutableArray alloc]init];
    
    if(![fileManager fileExistsAtPath:downloadsFilePath]) {
        NSLog(@"<%@> To be created.", downloadsFilePath);
    } else {
        existingDownloads = [NSKeyedUnarchiver unarchiveObjectWithFile:downloadsFilePath];
    }
    
    [existingDownloads addObject:downloadMangaModel.manga.mangaURLExtension];
    [NSKeyedArchiver archiveRootObject:existingDownloads toFile:downloadsFilePath];
    NSLog(@"<%@> Added to GlobalMangaDownloadedPlist.", downloadMangaModel.manga.mangaTitleDigitized);
}

+ (void)updateAndDeleteGlobalDownloadPlist:(MangaModel*)manga {
    NSString *documentsDirectory = [FileSystemHelper getDocumentsDirectoryPath];
    
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:@"MangaDownloaded.plist"];
    
    NSMutableArray *existingDownloads = [[NSMutableArray alloc]init];
    existingDownloads = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    
    [existingDownloads removeObject:manga.mangaURLExtension];
    [NSKeyedArchiver archiveRootObject:existingDownloads toFile:filePath];
    NSLog(@"<%@> Deleted from GlobalMangaDownloadedPlist.", manga.mangaTitleDigitized);
}


+ (void)saveMangaPreviewThumbnails:(DownloadMangaModel*)downloadMangaModel {
    NSString *documentsDirectory = [self getDocumentsDirectoryPath];
    
    NSString *coverFilename = @"c.png";
    NSString *mangaTitleFullFolderPath = [[NSString alloc] initWithFormat:@"%@/%@/", documentsDirectory, downloadMangaModel.manga.mangaURLExtension];
    NSString *fileDestinationUrl = [mangaTitleFullFolderPath stringByAppendingString:coverFilename];
    
    [downloadMangaModel.manga generateMangaInternallPreviewThumbnailsFromMangaPath:downloadMangaModel.manga.mangaURLExtension];
    [UIImagePNGRepresentation(downloadMangaModel.manga.mangaExternalPreviewThumbnails.mangaCoverImage) writeToFile:fileDestinationUrl atomically:YES];
}

+ (void)moveDownloadedMangaPageOfDownloadMangaModel:(DownloadMangaModel*)downloadMangaModel ofPageId:(int)pageId fromTempDirectoryAt:(NSURL*)tempDirectory {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *documentsDirectory = [self getDocumentsDirectoryPath];
    NSError *error;
    
    NSString *destinationFilename = [NSString stringWithFormat:@"%d.png", pageId];
    NSString *mangaTitleFolderPath = [[NSString alloc] initWithFormat:@"%@/%@/", documentsDirectory, downloadMangaModel.manga.mangaURLExtension];
    
    NSString *fileDestinationUrl = [mangaTitleFolderPath stringByAppendingString:destinationFilename];
    
    if ([fileManager fileExistsAtPath:fileDestinationUrl]) {
    } else {
        BOOL success = [fileManager copyItemAtPath:[tempDirectory path] toPath:fileDestinationUrl error:&error];
        
        if(success == YES) {
            NSLog(@"<%@> Page %d moved.", downloadMangaModel.manga.mangaTitleDigitized, pageId);
        } else {
            NSLog(@"<%@> Page %d Error => ", downloadMangaModel.manga.mangaTitleDigitized, pageId);
            NSLog(@"\n\n\n%@\n\n\n", error );
        }
    }
}

+ (NSArray*)generateInternalPageListingForDownloadMangaModel:(DownloadMangaModel*)downloadMangaModel {
    NSMutableArray *mutablePageListing = [[NSMutableArray alloc]init];
    
    for(int pageId = 0; pageId < downloadMangaModel.manga.mangaPageNums; pageId++) {
        NSString *pageLocation = [NSString stringWithFormat:@"%@/%d.png", downloadMangaModel.manga.mangaURLExtension, pageId];
        [mutablePageListing addObject:pageLocation];
    }
    
    return [[NSArray alloc]initWithArray:mutablePageListing];
}

+ (void)createMangaPlist:(DownloadMangaModel*)downloadMangaModel {
    NSString *documentsDirectory = [self getDocumentsDirectoryPath];
    NSString *mangaPath = [documentsDirectory stringByAppendingPathComponent:downloadMangaModel.manga.mangaURLExtension];
    NSString *mangaPlistPath = [mangaPath stringByAppendingPathComponent:@"info.plist"];
    [NSKeyedArchiver archiveRootObject:downloadMangaModel.manga toFile:mangaPlistPath];
    
    [self updateGlobalDownloadPlist:downloadMangaModel];
}

+(void)repairDownloadListing {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *documentsDirectory = [self getDocumentsDirectoryPath];
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:@"MangaDownloaded.plist"];
   
    NSError *error;

    NSArray *existingDownloads = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];

    NSString *doujinshiPath = [documentsDirectory stringByAppendingString:@"/doujinshi/"];
    NSString *mangaPath = [documentsDirectory stringByAppendingString:@"/manga/"];
    
    NSLog(@"sadas %@", existingDownloads);
    NSArray *fileList = [fileManager contentsOfDirectoryAtPath:doujinshiPath error:nil];
    for (NSString *s in fileList){
        NSString *relativeMangaPath = [NSString stringWithFormat:@"doujinshi/%@", s];
        NSString *mangaPath = [NSString stringWithFormat:@"%@/doujinshi/%@", documentsDirectory, s];
        if([existingDownloads containsObject:relativeMangaPath]) {
            
        } else {
            BOOL success = [fileManager removeItemAtPath:mangaPath error:&error];
            NSLog(@"Deleting...");
        }
    }
}

+ (void)saveDownloadMangaModel:(DownloadMangaModel*)downloadMangaModel UIImage:(UIImage*)image OfPage:(int)pageId {
    NSString *documentsDirectory = [self getDocumentsDirectoryPath];
    
    NSString *destinationFilename = [NSString stringWithFormat:@"%d.png", pageId];
    NSString *mangaTitleFolderPath = [[NSString alloc] initWithFormat:@"%@/%@/", documentsDirectory, downloadMangaModel.manga.mangaURLExtension];
    
    NSString *fileDestinationUrl = [mangaTitleFolderPath stringByAppendingString:destinationFilename];
    
    [UIImagePNGRepresentation(image) writeToFile:fileDestinationUrl atomically:YES];
}

+(void)repairMangaFromMangaModel:(MangaModel*)manga {
    FakkuAPIMangaReadPage *page = [[FakkuAPIMangaReadPage alloc]initWithMangaModel:manga];
    NSArray *externalPageListingArray = [page getPagesListingArray];
    
    int pageId = 0;
    
    NSString *mangaTitleFolderPath = [[NSString alloc] initWithFormat:@"%@/%@/", documentsDirectory, manga.mangaURLExtension];
    NSString *coverDestinationFilename = [mangaTitleFolderPath stringByAppendingString:@"c.png"];
    //[UIImagePNGRepresentation([DataHelper getImageFromUrl:manga.mangaExternalPreviewThumbnails.mangaCoverImageUrl]) writeToFile:coverDestinationFilename atomically:YES];
    [manga completeInternalInitialization]; // Reload cover
    
    for(NSString *imageUrl in externalPageListingArray) {
        NSString *destinationFilename = [NSString stringWithFormat:@"%d.png", pageId];
        NSString *fileDestinationUrl = [mangaTitleFolderPath stringByAppendingString:destinationFilename];
        
        [UIImagePNGRepresentation([DataHelper getImageFromUrl:imageUrl]) writeToFile:fileDestinationUrl atomically:YES];
        pageId++;
    }
}

+(void)deleteMangaFromMangaModel:(MangaModel*)manga {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *documentsDirectory = [FileSystemHelper getDocumentsDirectoryPath];
    NSError *error;
    
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:@"MangaDownloaded.plist"];
    
    NSMutableArray *existingDownloads = [[NSMutableArray alloc]init];
    existingDownloads = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    
    NSString *mangaPath = [documentsDirectory stringByAppendingPathComponent:manga.mangaURLExtension];
    
    BOOL success = [fileManager removeItemAtPath:mangaPath error:&error];
    if(success == YES) {
        NSLog(@"<%@> Deleted.", manga.mangaTitleDigitized);
    } else {
        NSLog(@"<%@> Error => ", manga.mangaTitleDigitized);
        NSLog(@"\n\n\n%@\n\n\n", error );
    }
    
    [self updateAndDeleteGlobalDownloadPlist:manga];
}

+(NSArray*)getDownloadsFileAndFormatAsArray {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *documentsDirectory = [self getDocumentsDirectoryPath];
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:@"MangaDownloaded.plist"];
    
    NSMutableArray *mangaMutableArray = [[NSMutableArray alloc]init];
    
    if (![fileManager fileExistsAtPath:filePath]) {
    } else {
        NSArray *existingDownloads = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
        for(id mangaUrlExtension in existingDownloads) {
            NSString *mangaFilePath = [documentsDirectory stringByAppendingPathComponent:mangaUrlExtension];
            NSString *mangaFileInfoPath = [mangaFilePath stringByAppendingPathComponent:@"info.plist"];
            
            if([fileManager fileExistsAtPath:mangaFileInfoPath]) {
                MangaModel *manga = [NSKeyedUnarchiver unarchiveObjectWithFile:mangaFileInfoPath];
                [manga completeInternalInitialization];
                [mangaMutableArray addObject:manga];
            }
        }
    }
    
    NSArray *mangaArray = [[NSArray alloc]initWithArray:mangaMutableArray];
    
    return mangaArray;
}

+(BOOL)isMangaBeingDownloaded:(MangaModel*)manga {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDir;
    BOOL isBeingDownloaded = NO;
    
    NSString *documentsDirectory = [FileSystemHelper getDocumentsDirectoryPath];
    
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:manga.mangaURLExtension];
    
    
    if([fileManager fileExistsAtPath:filePath isDirectory:&isDir]) {
        if(isDir) {
            isBeingDownloaded = YES;
        }
    }
    
    return isBeingDownloaded;
}

+(BOOL)isMangaDownloaded:(MangaModel*)manga {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    BOOL isDownloaded = NO;
    
    NSString *documentsDirectory = [self getDocumentsDirectoryPath];
    
    NSString *mangaFilePath = [documentsDirectory stringByAppendingPathComponent:manga.mangaURLExtension];
    NSString *mangaFileInfoPath = [mangaFilePath stringByAppendingPathComponent:@"info.plist"];
    
    if([fileManager fileExistsAtPath:mangaFileInfoPath]) {
        isDownloaded = YES;
    } else {
        isDownloaded = NO;
    }
    
    return isDownloaded;
}

@end
