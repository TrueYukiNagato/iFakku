//
//  MangaBrowseTableViewController.h
//  iFakku
//
//  Created by Yuki Nagato on 3/4/15.
//  Copyright (c) 2015 SOS Brigade. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MangaListingViewController.h"
#import "MangaDisplayViewController.h"

#import "MangaModel.h"

@interface MangaBrowseTableViewController : UITableViewController

@property (weak, nonatomic) IBOutlet UISearchBar *mangaSearchBar;
@property (weak, nonatomic) IBOutlet UISegmentedControl *mangaCategorySegmentedControl;

@property (weak, nonatomic) NSString *browseRowSelection;
@property (weak, nonatomic) NSString *mangaCategory;
@property (weak, nonatomic) NSString *mangaSorting;

@end
