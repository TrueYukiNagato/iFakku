//
//  FakkuAPIPage.m
//  iFakku
//
//  Created by Yuki Nagato on 2/23/15.
//  Copyright (c) 2015 SOS Brigade. All rights reserved.
//

#import "FakkuAPIPage.h"

@implementation FakkuAPIPage

-(void)developUrlExtensionAndRetrieveData {
    self.urlExtension = [[NSMutableString alloc]initWithString:self.urlBaseExtension];
    
    if(self.pageNum != 1) {
        NSString *urlPageExtension = [NSString stringWithFormat:@"/page/%d", self.pageNum];
        [self.urlExtension appendString:urlPageExtension];

    }

    self.APIData = [FakkuAPIAdapter getJSONAsNSDictionaryFromUrlExtension:self.urlExtension];
    
    if([self.APIData objectForKey:@"error"]) {
        self.APIData = nil;
    }
}

-(void)SPECIALdevelopUrlExtensionAndRetrieveDataFromFullURL:(NSString*)url {
    self.APIData = [FakkuAPIAdapter SPECIALgetJSONAsNSDictionaryFromFullUrl:url];
}

@end
