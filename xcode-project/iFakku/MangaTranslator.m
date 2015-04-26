//
//  MangaTranslator.m
//  iFakku
//
//  Created by Yuki Nagato on 2/24/15.
//  Copyright (c) 2015 SOS Brigade. All rights reserved.
//

#import "MangaTranslator.h"

@implementation MangaTranslator

-(id)initWithRawTranslatorInfo:(NSDictionary*)rawTranslatorInfo {
    self.mangaTranslator = [rawTranslatorInfo objectForKey:@"attribute"];
    self.mangaTranslatorDigitized = [DataHelper stripAllButLastOfFakkuUrlSegment:[rawTranslatorInfo objectForKey:@"attribute_link"]];
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder  {
    [encoder encodeObject:self.mangaTranslator forKey:@"mangaTranslator"];
    [encoder encodeObject:self.mangaTranslatorDigitized forKey:@"mangaTranslatorDigitized"];
}

- (id)initWithCoder:(NSCoder *)decoder  {
    if ((self = [super init])) {
        self.mangaTranslator  = [decoder decodeObjectForKey:@"mangaTranslator"];
        self.mangaTranslatorDigitized  = [decoder decodeObjectForKey:@"mangaTranslatorDigitized"];
    }
    
    return self;
}

@end
