//
//  MangaCategory.m
//  iFakku
//
//  Created by Yuki Nagato on 2/23/15.
//  Copyright (c) 2015 SOS Brigade. All rights reserved.
//

#import "MangaCategory.h"

@implementation MangaCategory

-(id)initWithCategoryDigitized:(NSString*)categoryDigitized {
    self.mangaCategoryDigitized = categoryDigitized;
    
    if([self.mangaCategoryDigitized isEqualToString:@"doujinshi"]) {
        self.mangaCategory = @"Doujinshi";
    } else if([self.mangaCategory isEqualToString:@"manga"]) {
        self.mangaCategory = @"Manga";
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder  {
    [encoder encodeObject:self.mangaCategoryDigitized forKey:@"mangaCategoryDigitized"];
    [encoder encodeObject:self.mangaCategory forKey:@"mangaCategory"];
}

- (id)initWithCoder:(NSCoder *)decoder  {
    if ((self = [super init])) {
        self.mangaCategoryDigitized  = [decoder decodeObjectForKey:@"mangaCategoryDigitized"];
        self.mangaCategory  = [decoder decodeObjectForKey:@"mangaCategory"];
    }
    
    return self;
}

@end
