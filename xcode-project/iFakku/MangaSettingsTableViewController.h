//
//  MangaUserTableViewController.h
//  iFakku
//
//  Created by Yuki Nagato on 3/6/15.
//  Copyright (c) 2015 SOS Brigade. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MangaListingViewController.h"
#import "MangaSettingsWebViewController.h"

#import "NSUserDefaultsHelper.h"
#import "FileSystemHelper.h"
#import "DownloaderAdapter.h"

@interface MangaSettingsTableViewController : UITableViewController
@property (weak, nonatomic) IBOutlet UIBarButtonItem *repairDownloadListingButton;
- (IBAction)repairDownloadListingClick:(id)sender;

@end
