//
//  MangaSettingsPageTableViewController.m
//  iFakku
//
//  Created by Yuki Nagato on 3/8/15.
//  Copyright (c) 2015 SOS Brigade. All rights reserved.
//

#import "MangaSettingsPageTableViewController.h"

@interface MangaSettingsPageTableViewController ()

@end

@implementation MangaSettingsPageTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 1;
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if(alertView.tag == 1) { //Set User
        if (buttonIndex == 1) {
            [NSUserDefaultsHelper setValue:[alertView textFieldAtIndex:0].text ForKey:@"setUsername"];
        }
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.row == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Username" message:@"Please enter your full username (with your id). Please check the FAQ if you don't know where to find your full username." delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Confirm", nil];
        alert.alertViewStyle = UIAlertViewStylePlainTextInput;
        UITextField *textField = [alert textFieldAtIndex:0];
        textField.text = [NSUserDefaultsHelper getValueForKey:@"setUsername"];
        alert.tag = 1;
        [alert show];
    }

    [tableView deselectRowAtIndexPath:indexPath animated:YES];

}

@end
