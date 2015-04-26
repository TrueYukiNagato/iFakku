//
//  DownloadMangaModel.m
//  iFakku
//
//  Created by Yuki Nagato on 2/25/15.
//  Copyright (c) 2015 SOS Brigade. All rights reserved.
//

#import "DownloadMangaModel.h"

@implementation DownloadMangaModel

- (id)initWithLoadedMangaModel:(MangaModel*)manga {
    self.manga = manga;
    
    [FileSystemHelper prepareFileSystemForDownloadMangaModel:self];

    return self;
}

- (id)initWithMangaModel:(MangaModel*)manga {
    self.manga = manga;
    self.pagesDownloaded = [[NSMutableArray alloc] init];
    self.numOfPagesCompleted = 0;
    self.allPagesCompleted = NO;
    
    for (NSInteger pageId = 0; pageId < self.manga.mangaPageNums; ++pageId) {
        [self.pagesDownloaded addObject:@"i"];
    }

    [FileSystemHelper prepareFileSystemForDownloadMangaModel:self];

    return self;
}

- (void)markPageAsDownloaded:(int)pageId {
    // c = complete
    // i = incomplete

    //[self.pagesDownloaded replaceObjectAtIndex:pageId withObject:@"c"];
    NSLog(@"<%@> Page %d downloaded.", self.manga.mangaTitleDigitized, pageId);
    self.numOfPagesCompleted++;
    [self updateAllPagesCompleted];
}

- (void)updateAllPagesCompleted {
    if(self.numOfPagesCompleted == self.manga.mangaPageNums) {
        self.allPagesCompleted = YES;
    }
}

- (void)handleDownloadCompletion {
    NSLog(@"<%@> Completion handler called.", self.manga.mangaTitleDigitized);
    [self.manga setInternalPageListingArray:[FileSystemHelper generateInternalPageListingForDownloadMangaModel:self]];
    [FileSystemHelper createMangaPlist:self];
}

@end
