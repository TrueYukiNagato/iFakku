//
//  MangaTranslator.h
//  iFakku
//
//  Created by Yuki Nagato on 2/24/15.
//  Copyright (c) 2015 SOS Brigade. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "DataHelper.h"

@interface MangaTranslator : NSObject

@property (copy, nonatomic) NSString *mangaTranslator;
@property (copy, nonatomic) NSString *mangaTranslatorDigitized;

-(id)initWithRawTranslatorInfo:(NSDictionary*)rawTranslatorInfo;

@end

