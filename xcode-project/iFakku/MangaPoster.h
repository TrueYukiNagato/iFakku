//
//  MangaPoster.h
//  iFakku
//
//  Created by Yuki Nagato on 2/24/15.
//  Copyright (c) 2015 SOS Brigade. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "DataHelper.h"

@interface MangaPoster : NSObject

@property (copy, nonatomic) NSString *mangaPoster;
@property (copy, nonatomic) NSString *mangaPosterDigitized;

-(id)initWithPoster:(NSString*)poster andPosterUrl:(NSString*)posterUrl;

@end
