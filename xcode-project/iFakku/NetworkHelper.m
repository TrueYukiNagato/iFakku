//
//  NetworkHelper.m
//  iFakku
//
//  Created by Yuki Nagato on 2/25/15.
//  Copyright (c) 2015 SOS Brigade. All rights reserved.
//

#import "NetworkHelper.h"

@implementation NetworkHelper

+(BOOL)isNetworkAvailable {
    NSError* error;
    NSString *URLString = [NSString stringWithContentsOfURL:[NSURL URLWithString:@"https://api.fakku.net"]  encoding:NSUTF8StringEncoding error:&error];
    // Shit has to be repeated here or else infinite loop
    return (URLString != NULL) ? YES : NO;
}

+(UIImage*)getImageFromUrl:(NSString *)imageUrl {
    NSURL *url = [[NSURL alloc]initWithString:[imageUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *img = [[UIImage alloc] initWithData:data];
    
    return img;
}

+ (NSString*)getDataFromUrl:(NSURL*)url {
    //Shit moved here so Network can be checked if it is avaiable. Access method in DataHelper since that's like the adapter or wtv.
    
    
    NSError* error;
    NSString *contents;
    
    // If no network, connect auto nil
    contents = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:&error];
    if(contents == nil) {
        contents = @"{\"error\":\"This information is currently unavailable.\"}";
        // I have no fucking clue why this happens, but sometimes the shit will return nill
    }
    
    return contents;
}

@end
