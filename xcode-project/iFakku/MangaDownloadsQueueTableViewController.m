//
//  DownloadsQueueTableViewController.m
//  iFakku
//
//  Created by Yuki Nagato on 2/25/15.
//  Copyright (c) 2015 SOS Brigade. All rights reserved.
//

#import "MangaDownloadsQueueTableViewController.h"

@interface MangaDownloadsQueueTableViewController () {
    NSArray *downloadQueueAsArray;
    NSTimer *autoUpdaterTimer;
}

@end

@implementation MangaDownloadsQueueTableViewController

static NSString* const MangaDownloadQueueCellReuseIdentifier = @"MangaDownloadQueueTableViewCell";

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated {
    if([DownloaderAdapter getIsPaused]) {
        self.pauseResumeButton.image = [UIImage imageNamed:@"resume"];
    } else {
        self.pauseResumeButton.image = [UIImage imageNamed:@"pause"];
    }
    
    [self.navigationController setToolbarHidden:NO animated:YES];
    [self updateDownloadQueueAsArrayAndTableView];
    autoUpdaterTimer = [NSTimer scheduledTimerWithTimeInterval:2.0
                                     target:self
                                   selector:@selector(updateDownloadQueueAsArrayAndTableView)
                                   userInfo:nil
                                    repeats:YES];
}

-(void)viewWillDisappear:(BOOL)animated {
    [self.navigationController setToolbarHidden:YES animated:YES];
    
    [autoUpdaterTimer invalidate];
}

#pragma mark - Auto-Updater

-(void)updateDownloadQueueAsArrayAndTableView {
    downloadQueueAsArray = [DownloaderAdapter getDownloadQueueAsArray];
    [self.tableView reloadData];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return downloadQueueAsArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        return 320;
    } else if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        return 520;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MangaDownloadQueueTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MangaDownloadQueueCellReuseIdentifier forIndexPath:indexPath];
    
    DownloadMangaModel *downloadMangaModel = [downloadQueueAsArray objectAtIndex:indexPath.row];

    [cell.mangaCoverImage setImage:downloadMangaModel.manga.mangaExternalPreviewThumbnails.mangaCoverImage];
    cell.mangaTitle.text = downloadMangaModel.manga.mangaTitleSafe;
    cell.mangaSeries.text = downloadMangaModel.manga.mangaSeriesConcatenated;
    cell.mangaArtists.text = downloadMangaModel.manga.mangaArtistsConcatenated;
    cell.mangaTranslators.text = downloadMangaModel.manga.mangaTranslatorsConcatenated;
    cell.mangaLanguage.text = downloadMangaModel.manga.mangaLanguage.mangaLanguage;
    cell.mangaTags.text = downloadMangaModel.manga.mangaTagsConcatenated;

    cell.mangaDownloadProgressIndicator.text = [[NSString alloc]initWithFormat:@"%ld/%ld", (long)downloadMangaModel.numOfPagesCompleted, (long)downloadMangaModel.manga.mangaPageNums];

    float numOfPagesCompletedAsFloat = (float) downloadMangaModel.numOfPagesCompleted;
    float mangaPageNumsAsFloat = (float) downloadMangaModel.manga.mangaPageNums;
    
    float progressAsFloat = numOfPagesCompletedAsFloat/mangaPageNumsAsFloat;
    [cell.mangaDownloadProgressBar setProgress:progressAsFloat animated:YES];

    return cell;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)pauseResumeButtonClick:(id)sender {
    if([DownloaderAdapter getIsPaused]) {
        self.pauseResumeButton.image = [UIImage imageNamed:@"pause"];
        [DownloaderAdapter resumeAllTransfers];
    } else {
        self.pauseResumeButton.image = [UIImage imageNamed:@"resume"];
        [DownloaderAdapter pauseAllTransfers];
    }
}
@end
