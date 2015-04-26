//
//  DownloadsQueueTableViewController.h
//  iFakku
//
//  Created by Yuki Nagato on 2/25/15.
//  Copyright (c) 2015 SOS Brigade. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DownloaderAdapter.h"

#import "MangaDownloadQueueTableViewCell.h"

@interface MangaDownloadsQueueTableViewController : UITableViewController

@property (weak, nonatomic) IBOutlet UIBarButtonItem *pauseResumeButton;
- (IBAction)pauseResumeButtonClick:(id)sender;

@end
