//
//  NetworkHelper.h
//  iFakku
//
//  Created by Yuki Nagato on 2/25/15.
//  Copyright (c) 2015 SOS Brigade. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "DataHelper.h"

@interface NetworkHelper : NSObject

+(BOOL)isNetworkAvailable;
+(UIImage*)getImageFromUrl:(NSString *)imageUrl;
+ (NSString*)getDataFromUrl:(NSURL*)url;

@end
