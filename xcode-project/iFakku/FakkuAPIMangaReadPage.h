//
//  FakkuAPIMangaReadPage.h
//  iFakku
//
//  Created by Yuki Nagato on 2/25/15.
//  Copyright (c) 2015 SOS Brigade. All rights reserved.
//

#import "FakkuAPIPage.h"

#import "MangaModel.h"

@interface FakkuAPIMangaReadPage : FakkuAPIPage

@property (weak, nonatomic) MangaModel *manga;
@property (strong, nonatomic) NSArray *mangaPagesListingArray;

-(id)initWithMangaModel:(MangaModel*)manga;
-(NSArray*)getPagesListingArray;

@end
