//
//  NSUserDefaultsHelper.h
//  iFakku
//
//  Created by Yuki Nagato on 3/8/15.
//  Copyright (c) 2015 SOS Brigade. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSUserDefaultsHelper : NSObject

+(NSString*)getValueForKey:(NSString*)key;
+(void)setValue:(NSString*)value ForKey:(NSString*)key;

@end
