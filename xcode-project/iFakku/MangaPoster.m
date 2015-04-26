//
//  MangaPoster.m
//  iFakku
//
//  Created by Yuki Nagato on 2/24/15.
//  Copyright (c) 2015 SOS Brigade. All rights reserved.
//

#import "MangaPoster.h"

@implementation MangaPoster

-(id)initWithPoster:(NSString*)poster andPosterUrl:(NSString*)posterUrl {
    self.mangaPoster = poster;
    self.mangaPosterDigitized = [DataHelper stripAllButLastOfFakkuUrlSegment:posterUrl];
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder  {
    [encoder encodeObject:self.mangaPoster forKey:@"mangaPoster"];
    [encoder encodeObject:self.mangaPosterDigitized forKey:@"mangaPosterDigitized"];
}

- (id)initWithCoder:(NSCoder *)decoder  {
    if ((self = [super init])) {
        self.mangaPoster  = [decoder decodeObjectForKey:@"mangaPoster"];
        self.mangaPosterDigitized  = [decoder decodeObjectForKey:@"mangaPosterDigitized"];
    }
    
    return self;
}

@end
