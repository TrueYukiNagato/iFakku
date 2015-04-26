//
//  FakkuAPIMangaListingPage.h
//  iFakku
//
//  Created by Yuki Nagato on 2/23/15.
//  Copyright (c) 2015 SOS Brigade. All rights reserved.
//

#import "FakkuAPIPage.h"

#import "FileSystemHelper.h"

#import "MangaModel.h"

@interface FakkuAPIMangaListingPage : FakkuAPIPage

@property (weak, nonatomic) NSString *mangaCategoryDigitized;
@property (weak, nonatomic) NSString *sortedByDigitized;
@property (weak, nonatomic) NSString *mangaSearchQueryDigitized;
@property (weak, nonatomic) NSString *mangaSeriesDigitized;
@property (weak, nonatomic) NSString *mangaArtistDigitized;
@property (weak, nonatomic) NSString *mangaTranslatorDigitized;
@property (weak, nonatomic) NSString *mangaTagDigitized;
@property (weak, nonatomic) NSString *setUsername;

@property (strong, nonatomic) NSArray *mangaListingArray;

-(id)initWithMangaCategory:(NSString*)mangaCategoryDigitized sortedBy:(NSString*)sortedByDigitized onPage:(NSInteger)pageNum; // ID = 1
-(id)initWithSearchQuery:(NSString*)SearchQuery onPage:(NSInteger)pageNum; // ID = 2
-(id)initWithMangaTagDigitized:(NSString*)mangaTagDigitized onPage:(NSInteger)pageNum; // ID = 3
-(id)initForFavoritesWithFullUsername:(NSString*)username onPage:(NSInteger)pageNum; // ID = 4
-(id)initWithMangaSeriesDigitized:(NSString*)mangaSeriesDigitized onPage:(NSInteger)pageNum; // ID = 5
-(id)initWithMangaArtistDigitized:(NSString*)mangaArtistDigitized onPage:(NSInteger)pageNum; // ID = 6
-(id)initWithMangaTranslatorDigitized:(NSString*)mangaTranslatorDigitized onPage:(NSInteger)pageNum; // ID = 7

-(NSArray*)getMangaListingArray;

@end
