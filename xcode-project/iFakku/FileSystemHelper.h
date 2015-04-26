//
//  FileSystemHelper.h
//  iFakku
//
//  Created by Yuki Nagato on 2/26/15.
//  Copyright (c) 2015 SOS Brigade. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>

@class MangaModel;
@class DownloadMangaModel;

@interface FileSystemHelper : NSObject

+ (UIImage*)getImageFromFile:(NSString *)file;
+ (void)prepareFileSystemForDownloadMangaModel:(DownloadMangaModel*)downloadMangaModel;
+ (void)moveDownloadedMangaPageOfDownloadMangaModel:(DownloadMangaModel*)downloadMangaModel ofPageId:(int)pageId fromTempDirectoryAt:(NSURL*)tempDirectory;
+ (void)saveDownloadMangaModel:(DownloadMangaModel*)downloadMangaModel UIImage:(UIImage*)image OfPage:(int)pageId;
+ (NSArray*)generateInternalPageListingForDownloadMangaModel:(DownloadMangaModel*)downloadMangaModel;
+ (void)createMangaPlist:(DownloadMangaModel*)downloadMangaModel;
+(void)repairMangaFromMangaModel:(MangaModel*)manga;
+(void)deleteMangaFromMangaModel:(MangaModel*)manga;

+(void)repairDownloadListing;
+(NSArray*)getDownloadsFileAndFormatAsArray;

+(MangaModel*)loadMangaModelFromUrl:(NSString*)mangaUrlExtension;

+(BOOL)isMangaBeingDownloaded:(MangaModel*)manga;
+(BOOL)isMangaDownloaded:(MangaModel*)manga;

@end
