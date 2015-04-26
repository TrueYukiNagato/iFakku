//
//  MangaPage.m
//  iFakku
//
//  Created by Yuki Nagato on 2/24/15.
//  Copyright (c) 2015 SOS Brigade. All rights reserved.
//

#import "MangaPage.h"

@implementation MangaPage

-(id)initPage:(int)pageId WithUrl:(NSString*)imageUrl {
    self.mangaPageId = pageId;
    self.mangaImageUrl = imageUrl;
    self.mangaPageImage = nil;

    return self;
}

- (void)loadImageForMangaPage {
    self.mangaPageImage = [DataHelper getImageFromUrl:self.mangaImageUrl];
}

- (void)loadInternalImageForMangaPage {
    self.mangaPageImage = [FileSystemHelper getImageFromFile:self.mangaImageUrl];
}


@end
