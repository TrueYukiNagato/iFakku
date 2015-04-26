//
//  MangaReadViewController.h
//  iFakku
//
//  Created by Yuki Nagato on 2/27/15.
//  Copyright (c) 2015 SOS Brigade. All rights reserved.
//
#import <UIKit/UIKit.h>

#import "DownloaderAdapter.h"

#import "MangaReadGridModalViewController.h"

#import "MangaModel.h"

@interface MangaReadViewController : UIViewController <MangaReadGridModalViewControllerDelegate, UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loadingActivityIndicator;
@property (weak, nonatomic) IBOutlet UIView *mangaReadMainView;

@property (weak, nonatomic) MangaModel *manga;

@property (nonatomic) int numOfLoadedImages;
@property (nonatomic) BOOL isDoneLoadingImages;

@property (strong, nonatomic) NSArray *mangaPagesForMangaReadViewController;
@property (strong, nonatomic) NSMutableArray *mangaPageImageViews;
@property (strong , nonatomic) NSMutableArray *mangaPageLoadingActivityIndicatorViews;


@property (weak, nonatomic) IBOutlet UIBarButtonItem *readingDirectionButton;
- (IBAction)toggleReadingDirectionButtonClick:(id)sender;

@end
