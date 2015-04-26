//
//  MangaArtist.h
//  iFakku
//
//  Created by Yuki Nagato on 2/24/15.
//  Copyright (c) 2015 SOS Brigade. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "DataHelper.h"

@interface MangaArtist : NSObject

@property (copy, nonatomic) NSString *mangaArtist;
@property (copy, nonatomic) NSString *mangaArtistDigitized;

-(id)initWithRawArtistInfo:(NSDictionary*)rawArtistInfo;

@end
