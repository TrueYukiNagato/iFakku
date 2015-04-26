//
//  MangaPreviewThumbnails.m
//  iFakku
//
//  Created by Yuki Nagato on 2/24/15.
//  Copyright (c) 2015 SOS Brigade. All rights reserved.
//

#import "MangaPreviewThumbnails.h"

@implementation MangaPreviewThumbnails

-(id)initWithCoverImageUrl:(NSString*)coverImageUrl andSampleImageUrl:(NSString*)sampleImageUrl {
    self.mangaCoverImageUrl = [NSString stringWithFormat:@"https:%@", coverImageUrl];
    self.mangaSampleImageUrl = [NSString stringWithFormat:@"https:%@", sampleImageUrl];
        
    return self;
}

-(id)initWithMangaPath:(NSString*)mangaPath {
    self.mangaCoverImageUrl = [NSString stringWithFormat:@"%@/c.png", mangaPath];
    //self.mangaSampleImageUrl = [NSString stringWithFormat:@"%@/s.png", mangaPath];
    
    return self;
}

- (void)loadImagesForMangaPreviewThumbnails {    
    self.mangaCoverImage = [DataHelper getImageFromUrl:self.mangaCoverImageUrl];
    // self.mangaSampleImage = [DataHelper getImageFromUrl:self.mangaSampleImageUrl]; // Unused as of now, so no point in getting.
}

- (void)loadInternalImagesForMangaPreviewThumbnails {
    self.mangaCoverImage = [FileSystemHelper getImageFromFile:self.mangaCoverImageUrl];
}

- (void)encodeWithCoder:(NSCoder *)encoder  {
    [encoder encodeObject:self.mangaCoverImageUrl forKey:@"mangaCoverImageUrl"];
    [encoder encodeObject:self.mangaSampleImageUrl forKey:@"mangaSampleImageUrl"];
}

- (id)initWithCoder:(NSCoder *)decoder  {
    if ((self = [super init])) {
        self.mangaCoverImageUrl  = [decoder decodeObjectForKey:@"mangaCoverImageUrl"];
        self.mangaSampleImageUrl  = [decoder decodeObjectForKey:@"mangaSampleImageUrl"];
    }
    
    return self;
}

@end
