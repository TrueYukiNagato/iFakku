//
//  MangaSeries.m
//  iFakku
//
//  Created by Yuki Nagato on 2/24/15.
//  Copyright (c) 2015 SOS Brigade. All rights reserved.
//

#import "MangaSeries.h"

@implementation MangaSeries

-(id)initWithRawSeriesInfo:(NSDictionary*)rawSeriesInfo {
    self.mangaSeries = [rawSeriesInfo objectForKey:@"attribute"];
    self.mangaSeriesDigitized = [DataHelper stripAllButLastOfFakkuUrlSegment:[rawSeriesInfo objectForKey:@"attribute_link"]];
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder  {
    [encoder encodeObject:self.mangaSeries forKey:@"mangaSeries"];
    [encoder encodeObject:self.mangaSeriesDigitized forKey:@"mangaSeriesDigitized"];
}

- (id)initWithCoder:(NSCoder *)decoder  {
    if ((self = [super init])) {
        self.mangaSeries  = [decoder decodeObjectForKey:@"mangaSeries"];
        self.mangaSeriesDigitized  = [decoder decodeObjectForKey:@"mangaSeriesDigitized"];
    }
    
    return self;
}

@end
