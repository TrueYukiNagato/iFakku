//
//  MangaTag.h
//  iFakku
//
//  Created by Yuki Nagato on 2/24/15.
//  Copyright (c) 2015 SOS Brigade. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "DataHelper.h"

@interface MangaTag : NSObject

@property (copy, nonatomic) NSString *mangaTag;
@property (copy, nonatomic) NSString *mangaTagDigitized;
@property (copy, nonatomic) UIImage *mangaTagImage;

-(id)initWithRawTagInfo:(NSDictionary*)rawTagsInfo;
-(id)initWithTagName:(NSString*)mangaTagName;

@end
