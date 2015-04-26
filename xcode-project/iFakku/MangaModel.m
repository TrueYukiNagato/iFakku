//
//  MangaModel.m
//  iFakku
//
//  Created by Yuki Nagato on 2/23/15.
//  Copyright (c) 2015 SOS Brigade. All rights reserved.
//

#import "MangaModel.h"

@implementation MangaModel
-(id)initWithRawMangaInfo:(NSDictionary*)mangaJSONData {
    self.mangaIsLoadedInternally = NO;
    
    [self renderMangaTitle:[mangaJSONData objectForKey:@"content_name"] andMangaTitleDigitized:[mangaJSONData objectForKey:@"content_url"]];
    self.mangaCategory = [[MangaCategory alloc] initWithCategoryDigitized:[mangaJSONData objectForKey:@"content_category"]];
    self.mangaLanguage = [[MangaLanguage alloc] initWithLanguageDigitized:[mangaJSONData objectForKey:@"content_language"]];
    [self renderSeries:[mangaJSONData objectForKey:@"content_series"]];
    [self renderTags:[mangaJSONData objectForKey:@"content_tags"]];
    [self renderArtists:[mangaJSONData objectForKey:@"content_artists"]];
    [self renderTranslators:[mangaJSONData objectForKey:@"content_translators"]];
    self.mangaDescription = [mangaJSONData objectForKey:@"content_description"];
    self.mangaUploadTime = [[mangaJSONData objectForKey:@"content_date"] integerValue];
    self.mangaPageNums = [[mangaJSONData objectForKey:@"content_pages"] integerValue];
    self.mangaPoster = [[MangaPoster alloc]initWithPoster:[mangaJSONData objectForKey:@"content_poster"] andPosterUrl:[mangaJSONData objectForKey:@"content_poster_url"]];
    [self renderPreviewThumbnails:[mangaJSONData objectForKey:@"content_images"]];
    
    self.mangaURLExtension = [NSString stringWithFormat:@"%@/%@", self.mangaCategory.mangaCategoryDigitized, self.mangaTitleDigitized];

    //    @property (strong, nonatomic) NSArray *mangaPages; // Fill with MangaPage
    return self;
}

-(void)renderMangaTitle:(NSString*)mangaTitle andMangaTitleDigitized:(NSString*)mangaUrl {
    self.mangaTitle = mangaTitle;
    self.mangaTitleDigitized = [DataHelper stripAllButLastOfFakkuUrlSegment:mangaUrl];

    // Replace Unicode characters
    NSArray *searchForUnicode = [[NSMutableArray alloc] initWithObjects:@"❤", nil];
    NSArray *replaceWithUnicode = [[NSMutableArray alloc] initWithObjects:@"❤\U0000FE0E", nil];
    
    self.mangaTitleSafe = self.mangaTitle;
    for (int i=0; i<[searchForUnicode count];i++) {
        self.mangaTitleSafe = [self.mangaTitleSafe stringByReplacingOccurrencesOfString:[searchForUnicode objectAtIndex:i] withString:[replaceWithUnicode objectAtIndex:i]];
    }
}

-(void)renderSeries:(NSDictionary*)seriesInfo {
    NSMutableArray *mangaSeriesMutableArray = [[NSMutableArray alloc]init];
    
    for (NSDictionary *rawSeriesInfo in seriesInfo) {
        MangaSeries *series = [[MangaSeries alloc] initWithRawSeriesInfo:rawSeriesInfo];
        [mangaSeriesMutableArray addObject:series];
    }
    self.mangaSeries = [mangaSeriesMutableArray copy];
    self.mangaSeriesConcatenated = [[self.mangaSeries valueForKey:@"mangaSeries"] componentsJoinedByString:@", "];
}

-(void)renderTags:(NSDictionary*)tagsInfo {
    NSMutableArray *mangaTagsMutableArray = [[NSMutableArray alloc]init];
    
    for (NSDictionary *rawTagsInfo in tagsInfo) {
        MangaTag *tag = [[MangaTag alloc] initWithRawTagInfo:rawTagsInfo];
        [mangaTagsMutableArray addObject:tag];
    }
    self.mangaTags = [mangaTagsMutableArray copy];
    self.mangaTagsConcatenated = [[self.mangaTags valueForKey:@"mangaTag"] componentsJoinedByString:@", "];
}

-(void)renderArtists:(NSDictionary*)tagsInfo {
    NSMutableArray *mangaArtistsMutableArray = [[NSMutableArray alloc]init];
    
    for (NSDictionary *rawArtistInfo in tagsInfo) {
        MangaArtist *artist = [[MangaArtist alloc] initWithRawArtistInfo:rawArtistInfo];
        [mangaArtistsMutableArray addObject:artist];
    }
    self.mangaArtists = [mangaArtistsMutableArray copy];
    
    if([self.mangaArtists count] == 0) {
        self.mangaArtistsConcatenated = @"_";
    } else {
        self.mangaArtistsConcatenated = [[self.mangaArtists valueForKey:@"mangaArtist"] componentsJoinedByString:@", "];
    }
}

-(void)renderTranslators:(NSDictionary*)translatorsInfo {
    NSMutableArray *mangaTranslatorsMutableArray = [[NSMutableArray alloc]init];
    
    for (NSDictionary *rawTranslatorInfo in translatorsInfo) {
        MangaTranslator *translator = [[MangaTranslator alloc] initWithRawTranslatorInfo:rawTranslatorInfo];
        [mangaTranslatorsMutableArray addObject:translator];
    }
    self.mangaTranslators = [mangaTranslatorsMutableArray copy];
    
    if([self.mangaTranslators count] == 0) {
        self.mangaTranslatorsConcatenated = @"_";
    } else {
        self.mangaTranslatorsConcatenated = [[self.mangaTranslators valueForKey:@"mangaTranslator"] componentsJoinedByString:@", "];
    }
}

-(void)renderPreviewThumbnails:(NSDictionary*)previewThumbnailsInfo {
    self.mangaExternalPreviewThumbnails = [[MangaPreviewThumbnails alloc]initWithCoverImageUrl:[previewThumbnailsInfo objectForKey:@"cover"] andSampleImageUrl:[previewThumbnailsInfo objectForKey:@"sample"]];
}

-(void)generateMangaInternallPreviewThumbnailsFromMangaPath:(NSString*)mangaPath {
    self.mangaInternalPreviewThumbnails = [[MangaPreviewThumbnails alloc] initWithMangaPath:mangaPath];
}

-(void)setInternalPageListingArray:(NSArray*)internalPageListingArray {
    self.mangaInternalPageListing = internalPageListingArray;
}

-(void)setExternalPageListingArray:(NSArray*)externalPageListingArray {
    self.mangaExternalPageListing = externalPageListingArray;
    // Temp variable not created in Manga Listing
}

-(void)generateMangaPagesArray {
    NSMutableArray *mangaPagesMutableArray = [[NSMutableArray alloc]init];
    if(self.mangaIsLoadedInternally == YES) {
        int pageId = 0;
        for(NSString *pageUrl in self.mangaInternalPageListing) {
            [mangaPagesMutableArray addObject:[[MangaPage alloc] initPage:pageId WithUrl:pageUrl]];
            pageId++;
        }
        
        self.mangaPages = [mangaPagesMutableArray copy];
    } else {
        self.mangaPages = [[NSMutableArray alloc]init];
        int pageId = 0;
        for(NSString *pageUrl in self.mangaExternalPageListing) {
            [mangaPagesMutableArray addObject:[[MangaPage alloc] initPage:pageId WithUrl:pageUrl]];
            pageId++;
        }
        
        self.mangaPages = [mangaPagesMutableArray copy];
    }
}

#pragma mark - NSCoding

- (void)encodeWithCoder:(NSCoder *)encoder  {
    // I'm lazy AF, so just encode everything (including concatenated things)
    [encoder encodeObject:self.mangaURLExtension forKey:@"mangaURLExtension"];
    [encoder encodeObject:self.mangaTitle forKey:@"mangaTitle"];
    [encoder encodeObject:self.mangaTitleSafe forKey:@"mangaTitleSafe"];
    [encoder encodeObject:self.mangaTitleDigitized forKey:@"mangaTitleDigitized"];
    [encoder encodeObject:self.mangaCategory forKey:@"mangaCategory"];
    [encoder encodeObject:self.mangaLanguage forKey:@"mangaLanguage"];
    [encoder encodeObject:self.mangaSeries forKey:@"mangaSeries"];
    [encoder encodeObject:self.mangaSeriesConcatenated forKey:@"mangaSeriesConcatenated"];
    [encoder encodeObject:self.mangaDescription forKey:@"mangaDescription"];
    [encoder encodeInteger:self.mangaUploadTime forKey:@"mangaUploadTime"];
    [encoder encodeInteger:self.mangaPageNums forKey:@"mangaPageNums"];
    [encoder encodeObject:self.mangaTags forKey:@"mangaTags"];
    [encoder encodeObject:self.mangaTagsConcatenated forKey:@"mangaTagsConcatenated"];
    [encoder encodeObject:self.mangaArtists forKey:@"mangaArtists"];
    [encoder encodeObject:self.mangaArtistsConcatenated forKey:@"mangaArtistsConcatenated"];
    [encoder encodeObject:self.mangaTranslators forKey:@"mangaTranslators"];
    [encoder encodeObject:self.mangaTranslatorsConcatenated forKey:@"mangaTranslatorsConcatenated"];
    [encoder encodeObject:self.mangaPoster forKey:@"mangaPoster"];
    [encoder encodeObject:self.mangaExternalPreviewThumbnails forKey:@"mangaExternalPreviewThumbnails"]; // Keep this to make the repairing easier...
    [encoder encodeObject:self.mangaInternalPreviewThumbnails forKey:@"mangaInternalPreviewThumbnails"];
    [encoder encodeObject:self.mangaInternalPageListing forKey:@"mangaInternalPageListing"];
}

- (id)initWithCoder:(NSCoder *)decoder  {
    if ((self = [super init])) {
        self.mangaIsLoadedInternally = YES;

        self.mangaURLExtension  = [decoder decodeObjectForKey:@"mangaURLExtension"];
        self.mangaTitle  = [decoder decodeObjectForKey:@"mangaTitle"];
        self.mangaTitleSafe  = [decoder decodeObjectForKey:@"mangaTitleSafe"];
        self.mangaTitleDigitized  = [decoder decodeObjectForKey:@"mangaTitleDigitized"];
        self.mangaCategory  = [decoder decodeObjectForKey:@"mangaCategory"];
        self.mangaLanguage  = [decoder decodeObjectForKey:@"mangaLanguage"];
        self.mangaSeries  = [decoder decodeObjectForKey:@"mangaSeries"];
        self.mangaSeriesConcatenated  = [decoder decodeObjectForKey:@"mangaSeriesConcatenated"];
        self.mangaDescription  = [decoder decodeObjectForKey:@"mangaDescription"];
        self.mangaUploadTime  = [decoder decodeIntegerForKey:@"mangaUploadTime"];
        self.mangaPageNums  = [decoder decodeIntegerForKey:@"mangaPageNums"];
        self.mangaTags  = [decoder decodeObjectForKey:@"mangaTags"];
        self.mangaTagsConcatenated = [decoder decodeObjectForKey:@"mangaTagsConcatenated"];
        self.mangaArtists = [decoder decodeObjectForKey:@"mangaArtists"];
        self.mangaArtistsConcatenated = [decoder decodeObjectForKey:@"mangaArtistsConcatenated"];
        self.mangaTranslators = [decoder decodeObjectForKey:@"mangaTranslators"];
        self.mangaTranslatorsConcatenated = [decoder decodeObjectForKey:@"mangaTranslatorsConcatenated"];
        self.mangaPoster  = [decoder decodeObjectForKey:@"mangaPoster"];
        self.mangaExternalPreviewThumbnails  = [decoder decodeObjectForKey:@"mangaExternalPreviewThumbnails"];
        self.mangaInternalPreviewThumbnails  = [decoder decodeObjectForKey:@"mangaInternalPreviewThumbnails"];
        self.mangaInternalPageListing = [decoder decodeObjectForKey:@"mangaInternalPageListing"];
    }
    
    return self;
}

-(void)completeInternalInitialization {
    [self.mangaInternalPreviewThumbnails loadInternalImagesForMangaPreviewThumbnails];
}

@end
