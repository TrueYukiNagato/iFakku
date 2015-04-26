//
//  MangaUserTableViewController.m
//  iFakku
//
//  Created by Yuki Nagato on 3/6/15.
//  Copyright (c) 2015 SOS Brigade. All rights reserved.
//

#import "MangaSettingsTableViewController.h"

@interface MangaSettingsTableViewController ()

@end

@implementation MangaSettingsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewWillAppear:(BOOL)animated {
    if([DownloaderAdapter getIsPaused] || [[DownloaderAdapter getDownloadQueueAsArray] count] == 0) {
        self.repairDownloadListingButton.enabled = YES;
    } else {
        self.repairDownloadListingButton.enabled = NO;
    }
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    if(section == 0) {
        return 2;
    } else if(section == 1) {
        return 4;
    }

    return 0;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if(section == 0) {
        return [NSUserDefaultsHelper getValueForKey:@"setUsername"];
    } else if(section == 1) {
        return [NSString stringWithFormat:@"iFakku Version %@", [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]];
    }
    
    return @"";
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    if(section == 0) {
    } else if(section == 1) {
        return @"Developed by TrueYukiNagato";
    }
    
    return @"";
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == 0) {
        if(indexPath.row == 0) {
            [self performSegueWithIdentifier:@"pushToMangaListingViewController" sender:self];
        }
    }
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"pushToMangaListingViewController"]) {
        MangaListingViewController *vc_MangaListingViewController = [segue destinationViewController];
        vc_MangaListingViewController.fromMangaSettingsTableViewControllerForFavorites = YES;
    } else if([segue.identifier isEqualToString:@"pushSettingsWebViewControllerToiFakkuFAQ"]) {
        MangaSettingsWebViewController *vc_SettingsWebViewController = [segue destinationViewController];
        vc_SettingsWebViewController.pageToLoadByWebView = @"iFakkuFAQ";
    } else if([segue.identifier isEqualToString:@"pushSettingsWebViewControllerToFakkuForums"]) {
        MangaSettingsWebViewController *vc_SettingsWebViewController = [segue destinationViewController];
        vc_SettingsWebViewController.pageToLoadByWebView = @"FakkuForums";
    } else if([segue.identifier isEqualToString:@"pushSettingsWebViewControllerToiFakkuThread"]) {
        MangaSettingsWebViewController *vc_SettingsWebViewController = [segue destinationViewController];
        vc_SettingsWebViewController.pageToLoadByWebView = @"iFakkuThread";
    } else if([segue.identifier isEqualToString:@"pushSettingsWebViewControllerToSpecialThanks"]) {
        MangaSettingsWebViewController *vc_SettingsWebViewController = [segue destinationViewController];
        vc_SettingsWebViewController.pageToLoadByWebView = @"SpecialThanks";
    }
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        NSLog(@"Cancel Tapped.");
    } else if (buttonIndex == 1) {
        self.repairDownloadListingButton.enabled = NO;
        
        dispatch_async(dispatch_get_main_queue(), ^{ // I need this, the nested dispatch keeps running before the above UI change functions, causing problems.
            [FileSystemHelper repairDownloadListing];
            self.repairDownloadListingButton.enabled = YES;
        });
    }
}

- (IBAction)repairDownloadListingClick:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Repair Download Listing" message:@"In some cases, an app crash will cause the Downloaded Manga Listing to act strangely. Use this tool to repair that." delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Repair",nil];
    [alert show];
}
@end
