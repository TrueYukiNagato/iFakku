//
//  MangaPreviewThumbnails.h
//  iFakku
//
//  Created by Yuki Nagato on 2/24/15.
//  Copyright (c) 2015 SOS Brigade. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "DataHelper.h"

@interface MangaPreviewThumbnails : NSObject

@property (copy, nonatomic) NSString *mangaCoverImageUrl;
@property (copy, nonatomic) NSString *mangaSampleImageUrl;

@property (copy, nonatomic) UIImage *mangaCoverImage;
@property (copy, nonatomic) UIImage *mangaSampleImage;

-(id)initWithCoverImageUrl:(NSString*)coverImageUrl andSampleImageUrl:(NSString*)sampleImageUrl;
-(id)initWithMangaPath:(NSString*)mangaPath;
-(void)loadImagesForMangaPreviewThumbnails;
-(void)loadInternalImagesForMangaPreviewThumbnails;

@end
