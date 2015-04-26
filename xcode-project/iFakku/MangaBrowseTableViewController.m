//
//  MangaBrowseTableViewController.m
//  iFakku
//
//  Created by Yuki Nagato on 3/4/15.
//  Copyright (c) 2015 SOS Brigade. All rights reserved.
//

#import "MangaBrowseTableViewController.h"

@interface MangaBrowseTableViewController () {
    NSString *mangaSearchQuery;
    MangaModel *mangaInstanceToPush;
}

@end

@implementation MangaBrowseTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mangaSearchBar.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 2;
    //return 3; Hide since no API usages
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    if(section == 0) {
        return 4;
    } else if (section == 1) {
        return 2;
    } else if (section == 2) {
        //return 3; Hide since no API usages
    }
    return 0;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    mangaSearchQuery = self.mangaSearchBar.text;
    [self performSegueWithIdentifier:@"showMangaListingViewController" sender:self];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Find the selected cell in the usual way
    
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    
    if(section == 0) {
        if(row == 0) {
            self.mangaSorting = @"newest";
        } else if(row == 1) {
            self.mangaSorting = @"popular";
        } else if(row == 2) {
            self.mangaSorting = @"favorites";
        } else if(row == 3) {
            self.mangaSorting = @"controversial";
        }
        if(self.mangaSorting != nil) {
            NSInteger mangaCategorySegmentedControlSelectedSegmentIndex = self.mangaCategorySegmentedControl.selectedSegmentIndex;
            if(mangaCategorySegmentedControlSelectedSegmentIndex == 0) {
                self.mangaCategory = @"doujinshi";
            } else if(mangaCategorySegmentedControlSelectedSegmentIndex == 1) {
                self.mangaCategory = @"manga";
            }
            
            [self performSegueWithIdentifier:@"showMangaListingViewController" sender:self];
        }
        
    } else if(section == 1) {
        if(indexPath.row == 0) {
            [self performSegueWithIdentifier:@"pushToMangaTagsTableViewController" sender:self];
        } else if(indexPath.row == 1) {
            NSInteger mangaCategorySegmentedControlSelectedSegmentIndex = self.mangaCategorySegmentedControl.selectedSegmentIndex;
            if(mangaCategorySegmentedControlSelectedSegmentIndex == 0) {
                self.mangaCategory = @"doujinshi";
            } else if(mangaCategorySegmentedControlSelectedSegmentIndex == 1) {
                self.mangaCategory = @"manga";
            }
            [self performSegueWithIdentifier:@"pushToMangaDisplayViewControllerForRandom" sender:self];
        }
    }
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showMangaListingViewController"]) {
        MangaListingViewController *vc_MangaListingViewController = [segue destinationViewController];
        
        vc_MangaListingViewController.fromMangaBrowseTableViewController = YES;
        
        vc_MangaListingViewController.mangaSorting = self.mangaSorting; // Will be nil if unused
        vc_MangaListingViewController.mangaSearchQuery = mangaSearchQuery; // Will be nil if unused
        vc_MangaListingViewController.mangaCategory = self.mangaCategory;
    } else if([[segue identifier] isEqualToString:@"pushToMangaDisplayViewControllerForRandom"]) {
        MangaDisplayViewController *vc_MangaDisplayViewController = [segue destinationViewController];

        NSString *urlFull = [NSString stringWithFormat:@"http://german-anime.com/fakku/?type=%@&page=random", self.mangaCategory];
        NSURL *url = [NSURL URLWithString:urlFull];
        NSData *data = [[NetworkHelper getDataFromUrl:url] dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                
        mangaInstanceToPush = [[MangaModel alloc] initWithRawMangaInfo:[dict objectForKey:@"content"]];
        [[mangaInstanceToPush mangaExternalPreviewThumbnails] loadImagesForMangaPreviewThumbnails];
        
        vc_MangaDisplayViewController.fromMangaSettingsTableViewControllerForRandom = YES;
        vc_MangaDisplayViewController.manga = mangaInstanceToPush;
    }
}

@end
