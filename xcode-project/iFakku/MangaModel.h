//
//  MangaModel.h
//  iFakku
//
//  Created by Yuki Nagato on 2/23/15.
//  Copyright (c) 2015 SOS Brigade. All rights reserved.
//

#import <Foundation/Foundation.h>

// It's set up this way because of the way the API is set up, helps organize readable vs. API values
// Only MangaTitle retains both versions in this Model

#import "MangaCategory.h"
#import "MangaLanguage.h"
#import "MangaSeries.h"
#import "MangaTag.h"
#import "MangaArtist.h"
#import "MangaTranslator.h"
#import "MangaPoster.h"
#import "MangaPreviewThumbnails.h"
#import "MangaPage.h"


@interface MangaModel : NSObject

@property (strong, nonatomic) NSString *mangaURLExtension;

@property (assign, nonatomic) BOOL mangaIsLoadedInternally;

@property (strong, nonatomic) NSString *mangaTitle;
@property (strong, nonatomic) NSString *mangaTitleSafe;
@property (strong, nonatomic) NSString *mangaTitleDigitized;
@property (strong, nonatomic) MangaCategory *mangaCategory;
@property (strong, nonatomic) MangaLanguage *mangaLanguage;

@property (strong, nonatomic) NSArray *mangaSeries; // Fill with MangaSeries
@property (strong, nonatomic) NSString *mangaSeriesConcatenated;

@property (strong, nonatomic) NSString *mangaDescription;
@property (nonatomic) NSInteger mangaUploadTime;
@property (nonatomic) NSInteger mangaPageNums;

@property (strong, nonatomic) NSArray *mangaTags;  // Fill with MangaTags
@property (strong, nonatomic) NSString *mangaTagsConcatenated;

@property (strong, nonatomic) NSArray *mangaArtists; // Fill with MangaArtist
@property (strong, nonatomic) NSString *mangaArtistsConcatenated;

@property (strong, nonatomic) NSArray *mangaTranslators;  // Fill with MangaTranslator
@property (strong, nonatomic) NSString *mangaTranslatorsConcatenated;

@property (strong, nonatomic) MangaPoster *mangaPoster;
@property (strong, nonatomic) MangaPreviewThumbnails *mangaInternalPreviewThumbnails; // Internal uses Internal urls
@property (strong, nonatomic) MangaPreviewThumbnails *mangaExternalPreviewThumbnails; // External uses API urls

@property (strong, nonatomic) NSArray *mangaInternalPageListing; // Custom array of URLs to internal images;
@property (strong, nonatomic) NSArray *mangaExternalPageListing; // Custom array of URLs to external images;
@property (strong, nonatomic) NSArray *mangaPages; // The FINAL page list to be used on MangaReadViewController

-(id)initWithRawMangaInfo:(NSDictionary*)mangaJSONData;
-(void)generateMangaInternallPreviewThumbnailsFromMangaPath:(NSString*)mangaPath;
-(void)setExternalPageListingArray:(NSArray*)externalPageListingArray;
-(void)setInternalPageListingArray:(NSArray*)internalPageListingArray;
-(void)generateMangaPagesArray;
-(void)completeInternalInitialization;

@end
