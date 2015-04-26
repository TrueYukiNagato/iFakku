//
//  MangaPage.h
//  iFakku
//
//  Created by Yuki Nagato on 2/24/15.
//  Copyright (c) 2015 SOS Brigade. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>

#import "DataHelper.h"

@interface MangaPage : NSObject

@property (nonatomic) int mangaPageId;
@property (copy, nonatomic) NSString *mangaImageUrl;
@property (copy, nonatomic) UIImage *mangaPageImage;

-(id)initPage:(int)pageId WithUrl:(NSString*)imageUrl;
-(void)loadImageForMangaPage;
- (void)loadInternalImageForMangaPage;

@end