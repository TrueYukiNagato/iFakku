//
//  DataHelper.m
//  iFakku
//
//  Created by Yuki Nagato on 2/23/15.
//  Copyright (c) 2015 SOS Brigade. All rights reserved.
//

#import "DataHelper.h"

@implementation DataHelper

+(UIImage*)getImageFromUrl:(NSString *)imageUrl {
    return [NetworkHelper getImageFromUrl:imageUrl]; // Moved to NetworkHelper. Check there
}

+(NSString*)getDataFromUrl:(NSURL*)url {
    return [NetworkHelper getDataFromUrl:url]; // Moved to NetworkHelper. Check there
}

+(NSDictionary*)createNSDictionaryFromNSString:(NSString*)rawString {
    NSData *NSDictionaryAsNSData =  [rawString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *FinalNSDictionary = [NSJSONSerialization JSONObjectWithData:NSDictionaryAsNSData options:NSJSONReadingMutableContainers error:nil];
    
    return FinalNSDictionary;
}

+(NSString*)stripAllButLastOfFakkuUrlSegment:(NSString*)fullFakkuUrl {
    NSArray *explodedUrl = [fullFakkuUrl componentsSeparatedByString: @"/"];
    NSString *lastSegment = [explodedUrl lastObject];
    
    return lastSegment;
}

+(NSArray*)getAllMangaTagNamesAsArray {
    return [NSArray arrayWithObjects:@"Ahegao", @"Anal", @"Animated", @"Ashikoki", @"Bakunyuu", @"Bara", @"Bondage", @"Cheating", @"Chikan", @"Chubby", @"Color", @"Dark Skin", @"Decensored", @"Ecchi", @"Femdom", @"Forced", @"Futanari", @"Glasses", @"Group", @"Harem", @"Hentai", @"Horror", @"Housewife", @"Humiliation", @"Idol", @"Incest", @"Irrumatio", @"Kemonomimi", @"Maid", @"Monster Girl", @"Nakadashi", @"Netorare", @"Netori", @"Non-H", @"Nurse", @"Oppai", @"Oral", @"Osananajimi", @"Oshiri", @"Paizuri", @"Pegging", @"Pettanko", @"Pregnant", @"Random", @"Schoolgirl", @"Shimapan", @"Socks", @"Stockings", @"Swimsuit", @"Tanlines", @"Teacher", @"Tentacles", @"Tomboy", @"Toys", @"Trap", @"Tsundere", @"Vanilla", @"Western", @"Yandere", @"Yaoi", @"Yuri", nil];
}

@end
