//
//  FakkuAPIMangaReadPage.m
//  iFakku
//
//  Created by Yuki Nagato on 2/25/15.
//  Copyright (c) 2015 SOS Brigade. All rights reserved.
//

#import "FakkuAPIMangaReadPage.h"

@implementation FakkuAPIMangaReadPage

-(id)initWithMangaModel:(MangaModel*)manga {
    self.manga = manga;
    self.pageNum = 1;
    
    self.urlBaseExtension = [NSString stringWithFormat:@"%@/%@/read", self.manga.mangaCategory.mangaCategoryDigitized, self.manga.mangaTitleDigitized];
    [super developUrlExtensionAndRetrieveData];
    [self populatePageListing];
    
    return self;
}

-(void)populatePageListing {
    if(![self.APIData isEqual:nil]) {
        NSDictionary *rawPagesListing = [self.APIData objectForKey:@"pages"];
        NSMutableArray *mangaPagesListingMutableArray = [[NSMutableArray alloc]init];
        
        for(int pageId = 0; pageId < self.manga.mangaPageNums; pageId++) {
            NSString *pageNumAsString = [NSString stringWithFormat:@"%d", pageId + 1];
            NSString *imageUrl = [[rawPagesListing objectForKey:pageNumAsString] objectForKey:@"image"];
            [mangaPagesListingMutableArray insertObject:imageUrl atIndex:pageId];
        }

        self.mangaPagesListingArray = [mangaPagesListingMutableArray copy];
    } else {
        self.mangaPagesListingArray = [[NSArray alloc]initWithObjects:nil];
    }

}

-(NSArray*)getPagesListingArray {
    return self.mangaPagesListingArray;
}

@end
