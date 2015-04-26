//
//  MangaDisplayViewController.m
//  iFakku
//
//  Created by Yuki Nagato on 2/25/15.
//  Copyright (c) 2015 SOS Brigade. All rights reserved.
//

#import "MangaDisplayViewController.h"

@interface MangaDisplayViewController () {
    dispatch_queue_t loadMangaExternalPageListingQueue;

}

@end

@implementation MangaDisplayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.downloadDeleteButton.enabled = NO;
    [self.readButton setEnabled:NO];
    [self.infoButton setEnabled:NO];
    
    if(!loadMangaExternalPageListingQueue) {
        loadMangaExternalPageListingQueue = dispatch_queue_create("loadMangaExternalPageListingQueue", NULL);
    }
        
    self.title = self.manga.mangaTitleSafe;
    self.mangaTitle.text = self.manga.mangaTitleSafe;
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) { // Load iPad only UI
        self.mangaSeries.text = self.manga.mangaSeriesConcatenated;
        self.mangaArtists.text = self.manga.mangaArtistsConcatenated;
        self.mangaTranslators.text = self.manga.mangaTranslatorsConcatenated;
        self.mangaLanguage.text = self.manga.mangaLanguage.mangaLanguage;
        self.mangaTags.text = self.manga.mangaTagsConcatenated;
    }
    
    dispatch_async(loadMangaExternalPageListingQueue, ^{
        if(self.manga.mangaIsLoadedInternally) {
            // mangaInternalPageListing already loaded through PLIST
            dispatch_sync(dispatch_get_main_queue(), ^{
                [self.downloadDeleteButton setEnabled:YES];
                [self.readButton setEnabled:YES];
                [self.infoButton setEnabled:YES];
            });
        } else {
            FakkuAPIMangaReadPage *page = [[FakkuAPIMangaReadPage alloc]initWithMangaModel:self.manga];
            [self.manga setExternalPageListingArray:[page getPagesListingArray]];
            dispatch_sync(dispatch_get_main_queue(), ^{
                if([FileSystemHelper isMangaDownloaded:self.manga]) {
                    self.downloadDeleteButton.image = nil;
                    self.downloadDeleteButton.title = @"Downloaded";
                } else if([FileSystemHelper isMangaBeingDownloaded:self.manga]) {
                    self.downloadDeleteButton.image = nil;
                    self.downloadDeleteButton.title = @"Downloading";
                } else {
                    [self.downloadDeleteButton setEnabled:YES];
                }
                [self.readButton setEnabled:YES];
                [self.infoButton setEnabled:YES];
            });
        }
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated {
    [self.navigationController setToolbarHidden:NO animated:YES];
    
    if(self.manga.mangaIsLoadedInternally) { // Reload here
        self.downloadDeleteButton.image = [UIImage imageNamed:@"trash"];
        [self.mangaCoverImage setImage:self.manga.mangaInternalPreviewThumbnails.mangaCoverImage];
    } else {
        [self.mangaCoverImage setImage:self.manga.mangaExternalPreviewThumbnails.mangaCoverImage];
    }
}

-(void)viewWillDisappear:(BOOL)animated {
    [self.navigationController setToolbarHidden:YES animated:YES];
}


#pragma mark - IBActions

- (IBAction)downloadDeleteButtonClick:(id)sender {
    if(self.manga.mangaIsLoadedInternally) {
        [FileSystemHelper deleteMangaFromMangaModel:self.manga];
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        self.downloadDeleteButton.enabled = NO;
        
        dispatch_async(dispatch_get_main_queue(), ^{ // I need this, the nested dispatch keeps running before the above UI change functions, causing problems.
            [DownloaderAdapter downloadMangaFromMangaModel:self.manga];
        });
    }
}

- (IBAction)readButtonClick:(id)sender {
}

- (IBAction)infoButtonClick:(id)sender {
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"pushMangaReadViewController"]) {
        MangaReadViewController *vc_MangaReadViewController = [segue destinationViewController];
        vc_MangaReadViewController.manga = self.manga;
    } else if([segue.identifier isEqualToString:@"pushToMangaInfoTableViewController"]) {
        MangaInfoTableViewController *vc_MangaInfoTableViewController = [segue destinationViewController];
        vc_MangaInfoTableViewController.manga = self.manga;
    }
}

@end
