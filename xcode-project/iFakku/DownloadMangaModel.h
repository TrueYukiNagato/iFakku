//
//  DownloadMangaModel.h
//  iFakku
//
//  Created by Yuki Nagato on 2/25/15.
//  Copyright (c) 2015 SOS Brigade. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FileSystemHelper.h"

#import "MangaModel.h"

@interface DownloadMangaModel : NSObject

@property (strong, nonatomic) MangaModel *manga;
@property (strong, nonatomic) NSMutableArray *pagesDownloaded; // Not actually used right now, so disabled.
@property (nonatomic) NSInteger numOfPagesCompleted;
@property (nonatomic) BOOL allPagesCompleted;

- (id)initWithLoadedMangaModel:(MangaModel*)manga;
- (id)initWithMangaModel:(MangaModel*)manga;
- (void)markPageAsDownloaded:(int)pageNum;
- (void)handleDownloadCompletion;

@end