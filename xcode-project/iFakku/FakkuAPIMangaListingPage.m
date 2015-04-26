//
//  FakkuAPIMangaListingPage.m
//  iFakku
//
//  Created by Yuki Nagato on 2/23/15.
//  Copyright (c) 2015 SOS Brigade. All rights reserved.
//

#import "FakkuAPIMangaListingPage.h"

@implementation FakkuAPIMangaListingPage

-(id)initWithMangaCategory:(NSString*)mangaCategoryDigitized sortedBy:(NSString*)sortedByDigitized onPage:(NSInteger)pageNum {
    self.mangaCategoryDigitized = mangaCategoryDigitized;
    self.sortedByDigitized = sortedByDigitized;
    self.pageNum = pageNum;
    
    self.urlBaseExtension = [NSString stringWithFormat:@"%@/%@", self.mangaCategoryDigitized, self.sortedByDigitized];
    
    [super developUrlExtensionAndRetrieveData];
    [self populateMangaListingArray];

    return self;
}

-(id)initWithSearchQuery:(NSString*)SearchQuery onPage:(NSInteger)pageNum {
    self.mangaSearchQueryDigitized = [SearchQuery stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    self.pageNum = pageNum;
    
    self.urlBaseExtension = [NSString stringWithFormat:@"search/%@", self.mangaSearchQueryDigitized];
    
    [self developUrlExtensionAndRetrieveData];
    [self populateMangaListingArray];
    
    return self;
}

-(id)initWithMangaTagDigitized:(NSString*)mangaTagDigitized onPage:(NSInteger)pageNum {
    self.mangaTagDigitized = mangaTagDigitized;
    self.pageNum = pageNum;

    self.urlBaseExtension = [NSString stringWithFormat:@"tags/%@", self.mangaTagDigitized];
    
    [self developUrlExtensionAndRetrieveData];
    [self populateMangaListingArray];
    
    return self;
}

-(id)initForFavoritesWithFullUsername:(NSString*)username onPage:(NSInteger)pageNum {
    self.setUsername = username;
    self.pageNum = pageNum;
    
    NSString *url = [NSString stringWithFormat:@"http://german-anime.com/fakku/?type=user&page=favorites&uname=%@&pagenr=%d", self.setUsername, self.pageNum];
    
    [self SPECIALdevelopUrlExtensionAndRetrieveDataFromFullURL:url];
    [self populateMangaListingArray];

    return self;
}

-(id)initWithMangaSeriesDigitized:(NSString*)mangaSeriesDigitized onPage:(NSInteger)pageNum {
    self.mangaSeriesDigitized = mangaSeriesDigitized;
    self.pageNum = pageNum;
    
    self.urlBaseExtension = [NSString stringWithFormat:@"series/%@", self.mangaSeriesDigitized];
    
    [self developUrlExtensionAndRetrieveData];
    [self populateMangaListingArray];
    
    return self;
}

-(id)initWithMangaArtistDigitized:(NSString*)mangaArtistDigitized onPage:(NSInteger)pageNum {
    self.mangaArtistDigitized = mangaArtistDigitized;
    self.pageNum = pageNum;
    
    self.urlBaseExtension = [NSString stringWithFormat:@"artists/%@", self.mangaArtistDigitized];
    
    [self developUrlExtensionAndRetrieveData];
    [self populateMangaListingArray];
    
    return self;
}

-(id)initWithMangaTranslatorDigitized:(NSString*)mangaTranslatorDigitized onPage:(NSInteger)pageNum {
    self.mangaTranslatorDigitized = mangaTranslatorDigitized;
    self.pageNum = pageNum;
    
    self.urlBaseExtension = [NSString stringWithFormat:@"translators/%@", self.mangaTranslatorDigitized];
    
    [self developUrlExtensionAndRetrieveData];
    [self populateMangaListingArray];
    
    return self;
}

-(void)populateMangaListingArray {
    if(![self.APIData isEqual:nil]) {
        NSDictionary *rawMangaListing = [self.APIData objectForKey:@"content"];
        NSMutableArray *mangaListingMutableArray = [[NSMutableArray alloc]init];
        
        int counter = 0;
        for (NSDictionary *rawMangaInfo in rawMangaListing) {
            MangaModel *manga = [[MangaModel alloc]initWithRawMangaInfo:rawMangaInfo];
            [mangaListingMutableArray addObject:manga];
            counter++;
        }
        
        if(counter == 0) {
            self.mangaListingArray = [[NSArray alloc]initWithObjects:nil];
        }
        self.mangaListingArray = [mangaListingMutableArray copy];
    } else {
        self.mangaListingArray = [[NSArray alloc]initWithObjects:nil];
    }
}

-(NSArray*)getMangaListingArray {
    return self.mangaListingArray;
}

@end
