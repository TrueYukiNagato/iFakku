//
//  MangaLanguage.m
//  iFakku
//
//  Created by Yuki Nagato on 2/23/15.
//  Copyright (c) 2015 SOS Brigade. All rights reserved.
//

#import "MangaLanguage.h"

@implementation MangaLanguage

-(id)initWithLanguageDigitized:(NSString*)languageDigitized {
    self.mangaLanguageDigitized = languageDigitized;
    if([self.mangaLanguageDigitized isEqualToString:@"english"]) {
        self.mangaLanguage = @"English";
    } else if([self.mangaLanguageDigitized isEqualToString:@"japanese"]) {
        self.mangaLanguage = @"Japanese";
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder  {
    [encoder encodeObject:self.mangaLanguageDigitized forKey:@"mangaLanguageDigitized"];
    [encoder encodeObject:self.mangaLanguage forKey:@"mangaLanguage"];
}

- (id)initWithCoder:(NSCoder *)decoder  {
    if ((self = [super init])) {
        self.mangaLanguageDigitized  = [decoder decodeObjectForKey:@"mangaLanguageDigitized"];
        self.mangaLanguage  = [decoder decodeObjectForKey:@"mangaLanguage"];
    }

    return self;
}

@end
