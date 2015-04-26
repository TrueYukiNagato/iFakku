//
//  LoadMoreFooterTableViewCell.h
//  iFakku
//
//  Created by Yuki Nagato on 2/24/15.
//  Copyright (c) 2015 SOS Brigade. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoadMoreFooterTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *loadMoreLabel;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loadMoreActivityIndicator;
- (void)toggleLoadMoreIndicators;
- (void)readyLoadFooterTableViewCell;

@end
