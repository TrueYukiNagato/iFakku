//
//  FakkuAPIPage.h
//  iFakku
//
//  Created by Yuki Nagato on 2/23/15.
//  Copyright (c) 2015 SOS Brigade. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "NetworkHelper.h"

#import "FakkuAPIAdapter.h"

@interface FakkuAPIPage : NSObject

@property (weak, nonatomic) NSString *urlBaseExtension;
@property (strong, nonatomic) NSMutableString *urlExtension;
@property (nonatomic) NSInteger pageNum;

@property (weak, nonatomic) NSDictionary *APIData;

-(void)developUrlExtensionAndRetrieveData;
-(void)SPECIALdevelopUrlExtensionAndRetrieveDataFromFullURL:(NSString*)url;

@end
