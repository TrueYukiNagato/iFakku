//
//  MangaInfoTableViewController.h
//  iFakku
//
//  Created by Yuki Nagato on 3/18/15.
//  Copyright (c) 2015 SOS Brigade. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MangaModel.h"

#import "MangaListingViewController.h"

#import "MangaInfoDescriptionTableViewCell.h"

@interface MangaInfoTableViewController : UITableViewController

@property (weak, nonatomic) MangaModel *manga;

@end
