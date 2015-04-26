//
//  MangaDisplayViewController.h
//  iFakku
//
//  Created by Yuki Nagato on 2/25/15.
//  Copyright (c) 2015 SOS Brigade. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MangaReadViewController.h"
#import "MangaInfoTableViewController.h"

#import "DownloaderAdapter.h"

#import "FakkuAPIMangaReadPage.h"

#import "MangaModel.h"

@interface MangaDisplayViewController : UIViewController

@property (weak, nonatomic) MangaModel *manga;

@property (nonatomic) BOOL fromMangaSettingsTableViewControllerForRandom;

@property (weak, nonatomic) IBOutlet UITextView *mangaTitle;
@property (weak, nonatomic) IBOutlet UIImageView *mangaCoverImage;
@property (weak, nonatomic) IBOutlet UILabel *mangaSeries;
@property (weak, nonatomic) IBOutlet UILabel *mangaArtists;
@property (weak, nonatomic) IBOutlet UILabel *mangaTranslators;
@property (weak, nonatomic) IBOutlet UILabel *mangaLanguage;
@property (weak, nonatomic) IBOutlet UITextView *mangaTags;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *downloadDeleteButton;
- (IBAction)downloadDeleteButtonClick:(id)sender;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *readButton;
- (IBAction)readButtonClick:(id)sender;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *infoButton;
- (IBAction)infoButtonClick:(id)sender;

@end