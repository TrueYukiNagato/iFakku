//
//  MangaLanguage.h
//  iFakku
//
//  Created by Yuki Nagato on 2/23/15.
//  Copyright (c) 2015 SOS Brigade. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MangaLanguage : NSObject

@property (copy, nonatomic) NSString *mangaLanguage;
@property (copy, nonatomic) NSString *mangaLanguageDigitized;

-(id)initWithLanguageDigitized:(NSString*)languageDigitized;

@end
