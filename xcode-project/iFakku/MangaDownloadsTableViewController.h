//
//  MangaDownloadsTableViewController.h
//  iFakku
//
//  Created by Yuki Nagato on 2/25/15.
//  Copyright (c) 2015 SOS Brigade. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MangaDisplayViewController.h"

#import "MangaDownloadedTableViewCell.h"

#import "MangaModel.h"

#import "FileSystemHelper.h"

@interface MangaDownloadsTableViewController : UITableViewController

@property (strong, nonatomic) NSArray *mangaDownloadedListing;
@property (strong, nonatomic) NSArray *mangaSortedDownloadedListing;

@property (weak, nonatomic) IBOutlet UISegmentedControl *mangaDownloadedSortSegmented;
- (IBAction)mangaDownloadSortSegmentedClick:(id)sender;

@end
