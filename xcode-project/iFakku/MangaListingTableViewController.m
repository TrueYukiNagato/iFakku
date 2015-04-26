//
//  MangaListingTableViewController.m
//  iFakku
//
//  Created by Yuki Nagato on 2/24/15.
//  Copyright (c) 2015 SOS Brigade. All rights reserved.
//

#import "MangaListingTableViewController.h"

@interface MangaListingTableViewController () {
    //    NSMutableArray *mangaPreviewThumbnailsArray;
    NSInteger numberOfRows;
    
    LoadMoreFooterTableViewCell *loadMoreFooter;
    dispatch_queue_t loadNextPageOfMangaListingQueue;
    dispatch_queue_t mangaPreviewThumbnailsLoaderQueue;
}

@end

@implementation MangaListingTableViewController

static NSString* const MangaListingCellReuseIdentifier = @"MangaListingTableViewCell";
static NSString* const footerReuseIdentifier = @"LoadMoreFooterTableViewCell";
static NSString* const mangaListingCellNibNameiPhone = @"MangaListingTableViewCell_iPhone";
static NSString* const mangaListingCellNibNameiPad = @"MangaListingTableViewCell_iPad";
static NSString* const loadMoreFooterNibName = @"LoadMoreFooterTableViewCell";

BOOL isNibForCellLoaded;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.pageNum = 1;
    
    UINib *nib;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        nib = [UINib nibWithNibName:mangaListingCellNibNameiPad bundle: nil];
    } else if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        nib = [UINib nibWithNibName:mangaListingCellNibNameiPhone bundle: nil];
    }
    
    [self.tableView registerNib:nib forCellReuseIdentifier:MangaListingCellReuseIdentifier];
    UINib *loadMoreFooterNib = [UINib nibWithNibName:loadMoreFooterNibName bundle: nil];
    [self.tableView registerNib:loadMoreFooterNib forCellReuseIdentifier:footerReuseIdentifier];
    
    if(!loadNextPageOfMangaListingQueue) {
        loadNextPageOfMangaListingQueue = dispatch_queue_create("loadNextPageOfMangaListingQueue", NULL);
    }
    
    if(!mangaPreviewThumbnailsLoaderQueue) {
        mangaPreviewThumbnailsLoaderQueue = dispatch_queue_create("mangaPreviewThumbnailsLoaderQueue", NULL);
    }
    
    self.mangaListing = [[NSMutableArray alloc] init];
    
    dispatch_async(loadNextPageOfMangaListingQueue, ^{
        [self prepareNextPage];
        dispatch_sync(dispatch_get_main_queue(), ^{
            [self readyLoadFooterTableViewCell];
            [self reloadTableView];
        });
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)readyLoadFooterTableViewCell {
    [loadMoreFooter readyLoadFooterTableViewCell];
}

- (void)prepareNextPage {
    FakkuAPIMangaListingPage *page;
    if(self.fakkuAPIMangaListingPageInitializationMethodID == 1) {
        page = [[FakkuAPIMangaListingPage alloc] initWithMangaCategory:self.mangaCategory sortedBy:self.mangaSorting onPage:self.pageNum];
    } else if(self.fakkuAPIMangaListingPageInitializationMethodID == 2){
        page = [[FakkuAPIMangaListingPage alloc] initWithSearchQuery:self.mangaSearchQuery onPage:self.pageNum];
    } else if(self.fakkuAPIMangaListingPageInitializationMethodID == 3){
        page = [[FakkuAPIMangaListingPage alloc] initWithMangaTagDigitized:self.mangaTagDigitized onPage:self.pageNum];
    } else if(self.fakkuAPIMangaListingPageInitializationMethodID == 4){
        page = [[FakkuAPIMangaListingPage alloc] initForFavoritesWithFullUsername:[NSUserDefaultsHelper getValueForKey:@"setUsername"] onPage:self.pageNum];
    } else if(self.fakkuAPIMangaListingPageInitializationMethodID == 5){
        page = [[FakkuAPIMangaListingPage alloc] initWithMangaSeriesDigitized:self.mangaSeriesDigitized onPage:self.pageNum];
    } else if(self.fakkuAPIMangaListingPageInitializationMethodID == 6){
        page = [[FakkuAPIMangaListingPage alloc] initWithMangaArtistDigitized:self.mangaArtistDigitized onPage:self.pageNum];
    } else if(self.fakkuAPIMangaListingPageInitializationMethodID == 7){
        page = [[FakkuAPIMangaListingPage alloc] initWithMangaTranslatorDigitized:self.mangaTranslatorDigitized onPage:self.pageNum];
    }
    if([[page getMangaListingArray] count] != 0) {
        self.pageNum++;
        [self.mangaListing addObjectsFromArray:[page getMangaListingArray]];
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return numberOfRows + 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        if(indexPath.row == numberOfRows) {
            return 50;
        } else {
            return 300;
        }
    } else if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        if(indexPath.row == numberOfRows) {
            return 50;
        } else {
            return 510;
        }
    }
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger rowNumber = indexPath.row;
    if(rowNumber == numberOfRows) {
        LoadMoreFooterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:footerReuseIdentifier forIndexPath:indexPath];
        loadMoreFooter = cell;
        return cell;
    } else {
        MangaModel *manga = [self.mangaListing objectAtIndex:rowNumber];
        MangaListingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MangaListingCellReuseIdentifier forIndexPath:indexPath];
        
        cell.mangaTitle.text = manga.mangaTitleSafe;
        cell.mangaSeries.text = manga.mangaSeriesConcatenated;
        cell.mangaArtists.text = manga.mangaArtistsConcatenated;
        cell.mangaTranslators.text = manga.mangaTranslatorsConcatenated;
        cell.mangaLanguage.text = manga.mangaLanguage.mangaLanguage;
        cell.mangaTags.text = manga.mangaTagsConcatenated;
        if(manga.mangaIsLoadedInternally) {
            [cell.mangaCoverImage setImage:manga.mangaInternalPreviewThumbnails.mangaCoverImage];
        } else {
            if(manga.mangaExternalPreviewThumbnails.mangaCoverImage) {
                [cell.mangaCoverImage setImage:[manga.mangaExternalPreviewThumbnails mangaCoverImage]];
            } else {
                [cell.mangaCoverImage setImage:[UIImage imageNamed:@"coverPlaceholder"]]; // Just to be sure since rows are reused.
                
                dispatch_async(mangaPreviewThumbnailsLoaderQueue, ^{
                    [manga.mangaExternalPreviewThumbnails loadImagesForMangaPreviewThumbnails];
                    
                    dispatch_sync(dispatch_get_main_queue(), ^{
                        [cell.mangaCoverImage setImage:[manga.mangaExternalPreviewThumbnails mangaCoverImage]];
                    });
                });
            }
        }
        
        return cell;
    }
}

- (void)reloadTableView {
    numberOfRows = [self.mangaListing count];
    [self.tableView reloadData];
}

#pragma mark - Dynamic Loading

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    CGPoint offset = scrollView.contentOffset;
    CGRect bounds = scrollView.bounds;
    CGSize size = scrollView.contentSize;
    UIEdgeInsets inset = scrollView.contentInset;
    float y = offset.y + bounds.size.height - inset.bottom;
    float h = size.height;
    float reload_distance = 50;
    
    if(y > h + reload_distance) {
        dispatch_async(loadNextPageOfMangaListingQueue, ^{
            dispatch_async(dispatch_get_main_queue(), ^{
                [loadMoreFooter toggleLoadMoreIndicators];
            });
            [self prepareNextPage];
            dispatch_async(dispatch_get_main_queue(), ^{
                [loadMoreFooter toggleLoadMoreIndicators];
                [self reloadTableView];
            });
        });
    }
}

- (void) tableView: (UITableView *) tableView didSelectRowAtIndexPath: (NSIndexPath *) indexPath {
    if(indexPath.row == numberOfRows) {
        
    } else {
        MangaModel *manga = [self.mangaListing objectAtIndex:indexPath.row];
        [self.delegate loadMangaDisplay:manga];
    }
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
