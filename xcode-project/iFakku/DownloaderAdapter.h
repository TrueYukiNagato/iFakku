//
//  DownloadAdapter.h
//  iFakku
//
//  Created by Yuki Nagato on 2/25/15.
//  Copyright (c) 2015 SOS Brigade. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Downloader.h"

#import "MangaModel.h"
#import "DownloadMangaModel.h"

@interface DownloaderAdapter : NSObject

+(void)downloadMangaFromMangaModel:(MangaModel*)manga;
+(void)saveLoadedMangaModel:(MangaModel*)manga;
+(BOOL)getIsPaused;
+(NSArray*)getDownloadQueueAsArray;
+(void)pauseAllTransfers;
+(void)resumeAllTransfers;

@end
