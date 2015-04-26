//
//  MangaListingViewController.m
//  iFakku
//
//  Created by Yuki Nagato on 2/23/15.
//  Copyright (c) 2015 SOS Brigade. All rights reserved.
//

#import "MangaListingViewController.h"

@interface MangaListingViewController () {
    MangaListingTableViewController *mangaListingTableViewController;
    MangaModel *mangaInstanceToPush;
}

@end

@implementation MangaListingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    mangaListingTableViewController = [[MangaListingTableViewController alloc]initWithNibName:@"MangaListingTableViewController" bundle:[NSBundle mainBundle]];
    mangaListingTableViewController.delegate = self;

    mangaListingTableViewController.fakkuAPIMangaListingPageInitializationMethodID = 1; // Override if search.

    if(self.fromMangaSettingsTableViewControllerForFavorites) {
        self.title = @"Favorites";
        mangaListingTableViewController.fakkuAPIMangaListingPageInitializationMethodID = 4;
    } else if(self.fromMangaBrowseTableViewController) {
        if(self.mangaTag != nil) {
            self.title = self.mangaTag;
            mangaListingTableViewController.mangaTagDigitized = self.mangaTagDigitized;
            mangaListingTableViewController.fakkuAPIMangaListingPageInitializationMethodID = 3;
        } else if(self.mangaSeries != nil) {
            self.title = self.mangaSeries;
            mangaListingTableViewController.mangaSeriesDigitized = self.mangaSeriesDigitized;
            mangaListingTableViewController.fakkuAPIMangaListingPageInitializationMethodID = 5;
        } else if(self.mangaArtist != nil) {
            self.title = self.mangaArtist;
            mangaListingTableViewController.mangaArtistDigitized = self.mangaArtistDigitized;
            mangaListingTableViewController.fakkuAPIMangaListingPageInitializationMethodID = 6;
        } else if(self.mangaTranslator != nil) {
            self.title = self.mangaTranslator;
            mangaListingTableViewController.mangaTranslatorDigitized = self.mangaTranslatorDigitized;
            mangaListingTableViewController.fakkuAPIMangaListingPageInitializationMethodID = 7;
        } else if(self.mangaSearchQuery == nil) {
            if ([self.mangaSorting isEqualToString:@"newest"]) {
                self.title = @"Newest";
            } else if ([self.mangaSorting isEqualToString:@"popular"]) {
                self.title = @"Most Popular";
            } else if ([self.mangaSorting isEqualToString:@"favorites"]) {
                self.title = @"Most Favorited";
            } else if ([self.mangaSorting isEqualToString:@"controversial"]) {
                self.title = @"Most Controversial";
            }

            mangaListingTableViewController.mangaCategory = self.mangaCategory;
            mangaListingTableViewController.mangaSorting = self.mangaSorting;
        } else {
            self.title = self.mangaSearchQuery;
            
            mangaListingTableViewController.mangaSearchQuery = self.mangaSearchQuery;
            mangaListingTableViewController.fakkuAPIMangaListingPageInitializationMethodID = 2;
        }
    } else {
        self.title = @"Home";
        mangaListingTableViewController.mangaSorting = @"newest";
        mangaListingTableViewController.mangaCategory = @"doujinshi";
    }

    mangaListingTableViewController.view.frame =  self.mangaListingContainerView.bounds;
    [self.mangaListingContainerView addSubview:mangaListingTableViewController.view];
    [self addChildViewController:mangaListingTableViewController];
}

- (void)viewWillDisappear:(BOOL)animated {
    if(self.fromMangaBrowseTableViewController) {
        self.mangaListingContainerView = nil;
        mangaListingTableViewController = nil;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadMangaDisplay:(MangaModel*) manga {
    mangaInstanceToPush = manga;
    [self performSegueWithIdentifier:@"pushMangaDisplayViewController" sender:self];
}

#pragma mark - IBAction

 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
     if([segue.identifier isEqualToString:@"pushMangaDisplayViewController"]) {
         MangaDisplayViewController *vc_MangaDisplayViewController = [segue destinationViewController];
         vc_MangaDisplayViewController.manga = mangaInstanceToPush;
     }
 }

@end
