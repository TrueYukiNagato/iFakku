//
//  MangaListingTableViewController.h
//  iFakku
//
//  Created by Yuki Nagato on 2/24/15.
//  Copyright (c) 2015 SOS Brigade. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FakkuAPIMangaListingPage.h"

#import "NSUserDefaultsHelper.h"

#import "MangaListingTableViewCell.h"
#import "LoadMoreFooterTableViewCell.h"

#import "MangaModel.h"

@interface MangaListingTableViewController : UITableViewController

@property (assign, nonatomic) id delegate;

// Pass properties
@property (nonatomic) NSInteger fakkuAPIMangaListingPageInitializationMethodID; // To reduce memory usages.
@property (weak, nonatomic) NSString *mangaSorting;
@property (weak, nonatomic) NSString *mangaSearchQuery;
@property (weak, nonatomic) NSString *mangaCategory;
@property (weak, nonatomic) NSString *mangaSeries;
@property (weak, nonatomic) NSString *mangaSeriesDigitized;
@property (weak, nonatomic) NSString *mangaArtistDigitized;
@property (weak, nonatomic) NSString *mangaTranslatorDigitized;
@property (weak, nonatomic) NSString *mangaTagDigitized;

@property (nonatomic) NSInteger pageNum;
@property (strong, nonatomic) NSMutableArray *mangaListing;

@end

@protocol MangaListingTableViewControllerDelegate

- (void)loadMangaDisplay:(MangaModel*) manga;

@end