//
//  MangaReadGridModalCollectionViewCell.h
//  iFakku
//
//  Created by Yuki Nagato on 2/27/15.
//  Copyright (c) 2015 SOS Brigade. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MangaReadGridModalCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *mangaPageThumbnail;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *mangaPageLoadingActivityIndicator;

@end
