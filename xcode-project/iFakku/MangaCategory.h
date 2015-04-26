//
//  MangaCategory.h
//  iFakku
//
//  Created by Yuki Nagato on 2/23/15.
//  Copyright (c) 2015 SOS Brigade. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MangaCategory : NSObject

@property (copy, nonatomic) NSString *mangaCategory;
@property (copy, nonatomic) NSString *mangaCategoryDigitized;

-(id)initWithCategoryDigitized:(NSString*)categoryDigitized;

@end
