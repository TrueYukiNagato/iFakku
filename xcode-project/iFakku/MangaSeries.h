//
//  MangaSeries.h
//  iFakku
//
//  Created by Yuki Nagato on 2/24/15.
//  Copyright (c) 2015 SOS Brigade. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "DataHelper.h"

@interface MangaSeries : NSObject

@property (copy, nonatomic) NSString *mangaSeries;
@property (copy, nonatomic) NSString *mangaSeriesDigitized;

-(id)initWithRawSeriesInfo:(NSDictionary*)rawSeriesInfo;

@end
