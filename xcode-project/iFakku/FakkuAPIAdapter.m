//
//  FakkuAPIAdapter.m
//  iFakku
//
//  Created by Yuki Nagato on 2/23/15.
//  Copyright (c) 2015 SOS Brigade. All rights reserved.
//

#import "FakkuAPIAdapter.h"

@implementation FakkuAPIAdapter

+(NSDictionary*)getJSONAsNSDictionaryFromUrlExtension:(NSString*)urlExtension {
    NSString *fakkuAPIBaseUrl = @"https://api.fakku.net/";
    
    NSString *fullFakkuUrlAsNSString = [fakkuAPIBaseUrl stringByAppendingString:urlExtension];
    NSURL *fullFakkuUrl = [NSURL URLWithString:fullFakkuUrlAsNSString];
    
    NSString *rawJSONAsNSStringFromFakkuAPI = [DataHelper getDataFromUrl:fullFakkuUrl];
    NSDictionary *JSONAsNSDictionary = [DataHelper createNSDictionaryFromNSString:rawJSONAsNSStringFromFakkuAPI];
    
    return JSONAsNSDictionary;
}

+(NSDictionary*)SPECIALgetJSONAsNSDictionaryFromFullUrl:(NSString*)url {
    NSURL *fullUrl = [NSURL URLWithString:url];
    NSString *rawJSONAsNSStringFromFakkuAPI = [DataHelper getDataFromUrl:fullUrl];
    NSDictionary *JSONAsNSDictionary = [DataHelper createNSDictionaryFromNSString:rawJSONAsNSStringFromFakkuAPI];
    
    return JSONAsNSDictionary;
}

+(NSString*)stripFakkuBaseUrlFromFullFakkuUrl:(NSString*)fullFakkuUrl {
    NSString *fakkuBaseUrl = @"https://www.fakku.net/";
    NSString *urlExtension = [fullFakkuUrl stringByReplacingOccurrencesOfString:fakkuBaseUrl withString:@""];
    
    return urlExtension;
}


@end
