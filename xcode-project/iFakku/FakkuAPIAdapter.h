//
//  FakkuAPIAdapter.h
//  iFakku
//
//  Created by Yuki Nagato on 2/23/15.
//  Copyright (c) 2015 SOS Brigade. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "DataHelper.h"

@interface FakkuAPIAdapter : NSObject

+(NSDictionary*)getJSONAsNSDictionaryFromUrlExtension:(NSString*)urlExtension;
+(NSDictionary*)SPECIALgetJSONAsNSDictionaryFromFullUrl:(NSString*)url; // !!!!!
+(NSString*)stripFakkuBaseUrlFromFullFakkuUrl:(NSString*)fullFakkuUrl;

@end
