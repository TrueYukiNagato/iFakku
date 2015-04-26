//
//  MangaArtist.m
//  iFakku
//
//  Created by Yuki Nagato on 2/24/15.
//  Copyright (c) 2015 SOS Brigade. All rights reserved.
//

#import "MangaArtist.h"

@implementation MangaArtist

-(id)initWithRawArtistInfo:(NSDictionary*)rawArtistInfo {
    self.mangaArtist = [rawArtistInfo objectForKey:@"attribute"];
    self.mangaArtistDigitized = [DataHelper stripAllButLastOfFakkuUrlSegment:[rawArtistInfo objectForKey:@"attribute_link"]];
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder  {
    [encoder encodeObject:self.mangaArtist forKey:@"mangaArtist"];
    [encoder encodeObject:self.mangaArtistDigitized forKey:@"mangaArtistDigitized"];
}

- (id)initWithCoder:(NSCoder *)decoder  {
    if ((self = [super init])) {
        self.mangaArtist  = [decoder decodeObjectForKey:@"mangaArtist"];
        self.mangaArtistDigitized  = [decoder decodeObjectForKey:@"mangaArtistDigitized"];
    }
    
    return self;
}

@end
