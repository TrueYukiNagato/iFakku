//
//  DataHelper.h
//  iFakku
//
//  Created by Yuki Nagato on 2/23/15.
//  Copyright (c) 2015 SOS Brigade. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "NetworkHelper.h"

#import "FileSystemHelper.h"

@interface DataHelper : NSObject

+(UIImage*)getImageFromUrl:(NSString*)imageUrl;
+(NSString*)getDataFromUrl:(NSURL*)url;
+(NSDictionary*)createNSDictionaryFromNSString:(NSString*)rawString;
+(NSString*)stripAllButLastOfFakkuUrlSegment:(NSString*)fullFakkuUrl;
+(NSArray*)getAllMangaTagNamesAsArray;

@end
