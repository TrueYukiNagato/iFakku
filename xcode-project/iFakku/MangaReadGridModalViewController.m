//
//  MangaReadGridViewController.m
//  iFakku
//
//  Created by Yuki Nagato on 2/27/15.
//  Copyright (c) 2015 SOS Brigade. All rights reserved.
//

#import "MangaReadGridModalViewController.h"

@interface MangaReadGridModalViewController () {
    NSTimer *customReloadDataNSTimer;
}

@end

@implementation MangaReadGridModalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.mangaPagesGridLayoutCollectionView.dataSource = self;
    self.mangaPagesGridLayoutCollectionView.delegate = self;
    
    if([self.delegate manga].mangaIsLoadedInternally) {
        self.downloadRepairButton.image = [UIImage imageNamed:@"repair"];
    }
    self.downloadRepairButton.enabled = NO;
    
    [self customReloadData];
    customReloadDataNSTimer = [NSTimer scheduledTimerWithTimeInterval:2 target: self selector: @selector(customReloadData) userInfo: nil repeats: YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)customReloadData {
    if([self.delegate getIsDoneLoadingImages]) {
        [customReloadDataNSTimer invalidate];
        
        [self.mangaPagesGridLayoutCollectionView reloadData];
        
        if([self.delegate manga].mangaIsLoadedInternally) {
            self.downloadRepairButton.enabled = YES;
        } else if([FileSystemHelper isMangaDownloaded:[self.delegate manga]]) {
            self.downloadRepairButton.image = nil;
            self.downloadRepairButton.title = @"Downloaded";
        } else if([FileSystemHelper isMangaBeingDownloaded:[self.delegate manga]]) {
            self.downloadRepairButton.image = nil;
            self.downloadRepairButton.title = @"Downloading";
        } else if([self.delegate manga].mangaIsLoadedInternally == NO && ![FileSystemHelper isMangaDownloaded:[self.delegate manga]] && ![FileSystemHelper isMangaBeingDownloaded:[self.delegate manga]]) {
            self.downloadRepairButton.enabled = YES;
        }
        
        // Just reload it one more time for safe measure.
        [self.mangaPagesGridLayoutCollectionView reloadData];
    } else {
        [self.mangaPagesGridLayoutCollectionView reloadData];
    }
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.delegate manga].mangaPageNums;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MangaReadGridModalCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"mangaReadGridModalCollectionViewCell" forIndexPath:indexPath];
    
    if([[[self.delegate manga].mangaPages objectAtIndex:indexPath.row] mangaPageImage] == nil) {
        [cell.mangaPageLoadingActivityIndicator startAnimating];
        cell.mangaPageThumbnail.hidden = YES;
    } else {
        [cell.mangaPageLoadingActivityIndicator stopAnimating];
        [cell.mangaPageThumbnail setImage:[[[self.delegate manga].mangaPages objectAtIndex:indexPath.row] mangaPageImage]];
        cell.mangaPageThumbnail.hidden = NO;
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self.delegate jumpToPage:indexPath.row];
    [self.delegate closeMangaReadGridModalViewController];
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        NSLog(@"Cancel Tapped.");
    } else if (buttonIndex == 1) {
        NSLog(@"Confirming Repair");
        self.downloadRepairButton.enabled = NO;
        self.downloadRepairButton.image = nil;
        self.downloadRepairButton.title = @"Repairing";

        dispatch_async(dispatch_get_main_queue(), ^{ // I need this, the nested dispatch keeps running before the above UI change functions, causing problems.
            [FileSystemHelper repairMangaFromMangaModel:[self.delegate manga]];
            [self.delegate callRepairCompletionHandler];
        });
    }
}

#pragma mark - IBActions

- (IBAction)downloadRepairButtonClick:(id)sender {
    if([self.delegate manga].mangaIsLoadedInternally) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"%@", [self.delegate manga].mangaTitleSafe] message:@"Repairing may take a long time." delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Repair",nil];
        [alert show];
    } else {
        self.downloadRepairButton.enabled = NO;
        self.downloadRepairButton.image = nil;
        self.downloadRepairButton.title = @"Saving";

        dispatch_async(dispatch_get_main_queue(), ^{ // I need this, the nested dispatch keeps running before the above UI change functions, causing problems.
            [self.delegate saveLoadedMangaModel];
            self.downloadRepairButton.title = @"Completed";
        });
    }
}

- (IBAction)closeButtonClick:(id)sender {
    [self.delegate closeMangaReadGridModalViewController];
}

@end
