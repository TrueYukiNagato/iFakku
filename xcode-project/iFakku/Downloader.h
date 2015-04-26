//
//  Downloader.h
//  iFakku
//
//  Created by Yuki Nagato on 2/25/15.
//  Copyright (c) 2015 SOS Brigade. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "NetworkHelper.h"

#import "DownloadMangaModel.h"


@interface Downloader : NSObject

+ (Downloader*)getInstance;

-(void)saveLoadedDownloadMangaModel:(DownloadMangaModel*)downloadMangaModel;
-(void)addDownloadMangaModelToDownloadQueue:(DownloadMangaModel*)downloadMangaModel;
- (BOOL)getIsPaused;
- (NSDictionary*)getDownloadQueue;
- (void)pauseAllTransfers;
- (void)resumeAllTransfers;

@end