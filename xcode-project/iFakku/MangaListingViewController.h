//
//  MangaListingViewController.h
//  iFakku
//
//  Created by Yuki Nagato on 2/23/15.
//  Copyright (c) 2015 SOS Brigade. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MangaListingTableViewController.h"

#import "MangaDisplayViewController.h"

#import "MangaModel.h"

@interface MangaListingViewController : UIViewController <MangaListingTableViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UIView *mangaListingContainerView;

@property (nonatomic) BOOL fromMangaBrowseTableViewController;
@property (nonatomic) BOOL fromMangaSettingsTableViewControllerForFavorites;

@property (weak, nonatomic) NSString *mangaSorting;
@property (weak, nonatomic) NSString *mangaSearchQuery;
@property (weak, nonatomic) NSString *mangaCategory;
@property (weak, nonatomic) NSString *mangaSeries;
@property (weak, nonatomic) NSString *mangaSeriesDigitized;
@property (weak, nonatomic) NSString *mangaArtist;
@property (weak, nonatomic) NSString *mangaArtistDigitized;
@property (weak, nonatomic) NSString *mangaTranslator;
@property (weak, nonatomic) NSString *mangaTranslatorDigitized;
@property (weak, nonatomic) NSString *mangaTag;
@property (weak, nonatomic) NSString *mangaTagDigitized;

@end
