//
//  MangaReadGridViewController.h
//  iFakku
//
//  Created by Yuki Nagato on 2/27/15.
//  Copyright (c) 2015 SOS Brigade. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MangaReadGridModalCollectionViewCell.h"

#import "MangaModel.h"

@interface MangaReadGridModalViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDataSource>


@property (weak, nonatomic) IBOutlet UICollectionView *mangaPagesGridLayoutCollectionView;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *downloadRepairButton;
- (IBAction)downloadRepairButtonClick:(id)sender;
- (IBAction)closeButtonClick:(id)sender;

@property (assign, nonatomic) id delegate;
@property (weak, nonatomic) MangaModel *manga;

@end

@protocol MangaReadGridModalViewControllerDelegate


-(void)callRepairCompletionHandler;
-(BOOL)getIsDoneLoadingImages;
-(void)jumpToPage:(NSInteger)mangaPageNum;
-(void)closeMangaReadGridModalViewController;
-(void)saveLoadedMangaModel;

@end