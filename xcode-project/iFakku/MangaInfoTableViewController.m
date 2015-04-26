//
//  MangaInfoTableViewController.m
//  iFakku
//
//  Created by Yuki Nagato on 3/18/15.
//  Copyright (c) 2015 SOS Brigade. All rights reserved.
//

#import "MangaInfoTableViewController.h"

@interface MangaInfoTableViewController () {
    NSInteger sectionSelected;
    NSInteger rowSelected;
}

@end

@implementation MangaInfoTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 8;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if(section == 0) {
        return @"Title";
    } else if(section == 1) {
        return @"Category";
    } else if(section == 2) {
        return @"Language";
    } else if(section == 3) {
        return @"Series";
    } else if(section == 4) {
        return @"Description";
    } else if(section == 5) {
        return @"Artists";
    } else if(section == 6) {
        return @"Translators";
    } else if(section == 7) {
        return @"Tags";
    }
    
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    if(section == 0) {
        return 1;
    } else if(section == 1) {
        return 1;
    } else if(section == 2) {
        return 1;
    } else if(section == 3) {
        return [self.manga.mangaSeries count];
    } else if(section == 4) {
        return 1;
    } else if(section == 5) {
        return [self.manga.mangaArtists count];
    } else if(section == 6) {
        return [self.manga.mangaTranslators count];
    } else if(section == 7) {
        return [self.manga.mangaTags count];
    }
    
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == 4) {
        return 200;
    } else {
        return 44;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == 4) { //Description
        MangaInfoDescriptionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"mangaInfoDescriptionReuseTableViewCell" forIndexPath:indexPath];
        cell.mangaDescription.text = self.manga.mangaDescription;
        return cell;
    } else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"mangaInfoBasicReuseTableViewCell" forIndexPath:indexPath];
        if(indexPath.section == 0) {
            cell.textLabel.text = self.manga.mangaTitleSafe;
            cell.userInteractionEnabled = NO;
            cell.accessoryType = UITableViewCellAccessoryNone;
        } else if(indexPath.section == 1) {
            cell.textLabel.text = self.manga.mangaCategory.mangaCategory;
            cell.userInteractionEnabled = NO;
            cell.accessoryType = UITableViewCellAccessoryNone;
        } else if(indexPath.section == 2) {
            cell.textLabel.text = self.manga.mangaLanguage.mangaLanguage;
            cell.userInteractionEnabled = NO;
        } else if(indexPath.section == 3) { // Series
            MangaSeries *mangaSeries = [self.manga.mangaSeries objectAtIndex:indexPath.row];
            cell.textLabel.text = mangaSeries.mangaSeries;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.userInteractionEnabled = YES;
        } else if(indexPath.section == 5) { // Artist
            MangaArtist *mangaArtist = [self.manga.mangaArtists objectAtIndex:indexPath.row];
            cell.textLabel.text = mangaArtist.mangaArtist;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.userInteractionEnabled = YES;
        } else if(indexPath.section == 6) { // Translators
            MangaTranslator *mangaTranslator = [self.manga.mangaTranslators objectAtIndex:indexPath.row];
            cell.textLabel.text = mangaTranslator.mangaTranslator;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.userInteractionEnabled = YES;
        } else if(indexPath.section == 7) {// Tags
            MangaTag *mangaTag = [self.manga.mangaTags objectAtIndex:indexPath.row];
            cell.textLabel.text = mangaTag.mangaTag;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.userInteractionEnabled = YES;
        }
        
        return cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    sectionSelected = indexPath.section;
    rowSelected = indexPath.row;
    if(sectionSelected == 4) {
    } else {
        [self performSegueWithIdentifier:@"pushToMangaListingViewController" sender:self];
    }
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"pushToMangaListingViewController"]) {
        MangaListingViewController *vc_MangaListingViewController = [segue destinationViewController];
        vc_MangaListingViewController.fromMangaBrowseTableViewController = YES;
        if(sectionSelected == 3) {
            MangaSeries *mangaSeries = [self.manga.mangaSeries objectAtIndex:rowSelected];
            vc_MangaListingViewController.mangaSeries = mangaSeries.mangaSeries;
            vc_MangaListingViewController.mangaSeriesDigitized = mangaSeries.mangaSeriesDigitized;
        } else if(sectionSelected == 5) {
            MangaArtist *mangaArtist = [self.manga.mangaArtists objectAtIndex:rowSelected];
            vc_MangaListingViewController.mangaArtist = mangaArtist.mangaArtist;
            vc_MangaListingViewController.mangaArtistDigitized = mangaArtist.mangaArtistDigitized;
        } else if(sectionSelected == 6) {
            MangaTranslator *mangaTranslator = [self.manga.mangaTranslators objectAtIndex:rowSelected];
            vc_MangaListingViewController.mangaTranslator = mangaTranslator.mangaTranslator;
            vc_MangaListingViewController.mangaTranslatorDigitized = mangaTranslator.mangaTranslatorDigitized;
        } else if(sectionSelected == 7) {
            MangaTag *mangaTag = [self.manga.mangaTags objectAtIndex:rowSelected];
            vc_MangaListingViewController.mangaTag = mangaTag.mangaTag;
            vc_MangaListingViewController.mangaTagDigitized = mangaTag.mangaTagDigitized;
        }
    }
}

@end
