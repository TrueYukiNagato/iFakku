//
//  LoadMoreFooterTableViewCell.m
//  iFakku
//
//  Created by Yuki Nagato on 2/24/15.
//  Copyright (c) 2015 SOS Brigade. All rights reserved.
//

#import "LoadMoreFooterTableViewCell.h"

@implementation LoadMoreFooterTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)readyLoadFooterTableViewCell {
    self.loadMoreLabel.text = @"Drag to load more";
}

- (void)toggleLoadMoreIndicators {
    if(self.loadMoreLabel.hidden == YES) {
        self.loadMoreLabel.hidden = NO;
        [self.loadMoreActivityIndicator stopAnimating];
    } else {
        self.loadMoreLabel.hidden = YES;
        [self.loadMoreActivityIndicator startAnimating];
    }
}

@end
