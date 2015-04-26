//
//  NSUserDefaultsHelper.m
//  iFakku
//
//  Created by Yuki Nagato on 3/8/15.
//  Copyright (c) 2015 SOS Brigade. All rights reserved.
//

#import "NSUserDefaultsHelper.h"

@implementation NSUserDefaultsHelper

+(NSString*)getValueForKey:(NSString*)key {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults objectForKey:key];
}

+(void)setValue:(NSString*)value ForKey:(NSString*)key {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:value forKey:key];
    [defaults synchronize];
    
}
@end
