//
//  MangaDownloadsTableViewController.m
//  iFakku
//
//  Created by Yuki Nagato on 2/25/15.
//  Copyright (c) 2015 SOS Brigade. All rights reserved.
//

#import "MangaDownloadsTableViewController.h"

@interface MangaDownloadsTableViewController () {
    NSTimer *autoUpdaterTimer;
    MangaModel *mangaInstanceToPush;
    int sortIndex;
}

@end

static NSString* const MangaDownloadedCellReuseIdentifier = @"MangaDownloadedCellReuseIdentifier";

@implementation MangaDownloadsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated {
    [self updateDownloadQueueAsArrayAndTableView];
    autoUpdaterTimer = [NSTimer scheduledTimerWithTimeInterval:5.0
                                                        target:self
                                                      selector:@selector(updateDownloadQueueAsArrayAndTableView)
                                                      userInfo:nil
                                                       repeats:YES];
}

-(void)viewWillDisappear:(BOOL)animated {
    [autoUpdaterTimer invalidate];
}

-(void)updateDownloadQueueAsArrayAndTableView {
    self.mangaDownloadedListing = [FileSystemHelper getDownloadsFileAndFormatAsArray];
    [self sortMangaSortedDownloadedArrayAndReload];
}

-(void)sortMangaSortedDownloadedArrayAndReload {
    if(sortIndex == 0) {
        NSSortDescriptor *sortMangaTitle = [[NSSortDescriptor alloc] initWithKey:@"mangaTitle" ascending:YES selector:@selector(localizedCaseInsensitiveCompare:)];
        self.mangaSortedDownloadedListing = [self.mangaDownloadedListing sortedArrayUsingDescriptors:[NSArray arrayWithObjects:sortMangaTitle, nil]];
    } else if(sortIndex == 1) {
        NSSortDescriptor *sortMangaSeriesConcatenated = [[NSSortDescriptor alloc] initWithKey:@"mangaSeriesConcatenated" ascending:YES selector:@selector(localizedCaseInsensitiveCompare:)];
        self.mangaSortedDownloadedListing = [self.mangaDownloadedListing sortedArrayUsingDescriptors:[NSArray arrayWithObjects:sortMangaSeriesConcatenated, nil]];
    } else if(sortIndex == 2) {
        NSSortDescriptor *sortMangaArtistsConcatenated = [[NSSortDescriptor alloc] initWithKey:@"mangaArtistsConcatenated" ascending:YES selector:@selector(localizedCaseInsensitiveCompare:)];
        self.mangaSortedDownloadedListing = [self.mangaDownloadedListing sortedArrayUsingDescriptors:[NSArray arrayWithObjects:sortMangaArtistsConcatenated, nil]];
    } else if(sortIndex == 3) {
        self.mangaSortedDownloadedListing = self.mangaDownloadedListing; // Already sorted by date
    }
    
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return self.mangaDownloadedListing.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MangaDownloadedTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MangaDownloadedCellReuseIdentifier forIndexPath:indexPath];
    
    MangaModel *manga = [self.mangaSortedDownloadedListing objectAtIndex:indexPath.row];
            
    [cell.mangaCoverImage setImage:manga.mangaInternalPreviewThumbnails.mangaCoverImage];
    cell.mangaTitle.text = manga.mangaTitleSafe;
    cell.mangaSeries.text = manga.mangaSeriesConcatenated;
    cell.mangaArtists.text = manga.mangaArtistsConcatenated;
    cell.mangaTranslators.text = manga.mangaTranslatorsConcatenated;
    cell.mangaLanguage.text = manga.mangaLanguage.mangaLanguage;
    cell.mangaTags.text = manga.mangaTagsConcatenated;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        return 300;
    } else if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        return 510;
    }
    
    return 0;
}

- (void) tableView: (UITableView *) tableView didSelectRowAtIndexPath: (NSIndexPath *) indexPath {
    mangaInstanceToPush = [self.mangaSortedDownloadedListing objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"pushMangaDisplayViewController" sender:self];
}

#pragma mark - IBActions

- (IBAction)mangaDownloadSortSegmentedClick:(id)sender {
    sortIndex = self.mangaDownloadedSortSegmented.selectedSegmentIndex;
    [self sortMangaSortedDownloadedArrayAndReload];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"pushMangaDisplayViewController"]) {
        MangaDisplayViewController *vc_MangaDisplayViewController = [segue destinationViewController];
        vc_MangaDisplayViewController.manga = mangaInstanceToPush;
    }
}

@end
