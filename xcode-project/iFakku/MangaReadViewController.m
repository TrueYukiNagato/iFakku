//
//  MangaReadViewController.m
//  iFakku
//
//  Created by Yuki Nagato on 2/27/15.
//  Copyright (c) 2015 SOS Brigade. All rights reserved.
//

#import "MangaReadViewController.h"

@interface MangaReadViewController () {
    NSOperationQueue *mangaPageLoadingQueue;
    BOOL isStatusBarHidden ;
    UIScrollView *Scroller;
    NSString *readingDirection;
}

@end

@implementation MangaReadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.isDoneLoadingImages = NO;
    self.numOfLoadedImages = 0;
    readingDirection = @"LR";

    self.mangaPageImageViews = [[NSMutableArray alloc] init];
    self.mangaPageLoadingActivityIndicatorViews = [[NSMutableArray alloc] init];

    mangaPageLoadingQueue = [[NSOperationQueue alloc] init];
    
    [self.manga generateMangaPagesArray];
    [self createUI];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated {
    [self.navigationController setToolbarHidden:NO animated:YES];
}

-(void)viewWillDisappear:(BOOL)animated {
    [self.navigationController setToolbarHidden:YES animated:YES];

    if (self.isMovingFromParentViewController) {
        Scroller = nil;
        self.manga.mangaPages = nil;
        self.manga = nil;
    }

}

-(void)saveLoadedMangaModel {
        [DownloaderAdapter saveLoadedMangaModel: self.manga];
}

-(void)createUI {
    //Scroller = [[UIScrollView alloc] initWithFrame:[self.mangaReadMainView frame]]; //Main Gallery View
    Scroller = [[UIScrollView alloc] initWithFrame:[self.view frame]];

    Scroller.delegate = self;
    Scroller.pagingEnabled = YES;
    Scroller.userInteractionEnabled = YES;
    Scroller.contentSize = CGSizeMake(self.manga.mangaPageNums * Scroller.bounds.size.width, Scroller.bounds.size.height);
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(toggleUIElements:)];
    [Scroller addGestureRecognizer:tap];
    
    CGRect ScrollerViewSize;
    
    // Now aren't you glad you're good at math.
    if([readingDirection isEqualToString:@"LR"]) {
        ScrollerViewSize = Scroller.bounds;
    } else if([readingDirection isEqualToString:@"RL"]) {
        ScrollerViewSize = CGRectMake((self.manga.mangaPageNums - 1) * Scroller.frame.size.width, 0, Scroller.frame.size.width, Scroller.frame.size.height);
    }

    for(MangaPage *mangaPage in self.manga.mangaPages) {
        UIScrollView *SubScroller = [[UIScrollView alloc] initWithFrame:ScrollerViewSize];
        SubScroller.delegate = self;
        SubScroller.tag = mangaPage.mangaPageId;
        
        
        SubScroller.maximumZoomScale = 4.0;
        SubScroller.minimumZoomScale = 1.0;
        
        CGRect SubViewSize = SubScroller.bounds;
        
        UIImageView *ImgView = [[UIImageView alloc] initWithFrame:SubViewSize];
        [ImgView setContentMode: UIViewContentModeScaleAspectFit];
        [SubScroller addSubview:ImgView];
        
        UIActivityIndicatorView *mangaPageLoadingActivityIndicatorView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        mangaPageLoadingActivityIndicatorView.center = CGPointMake(SubViewSize.size.width / 2, SubViewSize.size.height / 2);
        [mangaPageLoadingActivityIndicatorView startAnimating];
        [SubScroller addSubview:mangaPageLoadingActivityIndicatorView];
        
        [self.mangaPageImageViews addObject:ImgView];
        [self.mangaPageLoadingActivityIndicatorViews addObject:mangaPageLoadingActivityIndicatorView];
        
        [mangaPageLoadingQueue addOperationWithBlock:^{ // Have faith that this will work.
            if(self.manga.mangaIsLoadedInternally) {
                [mangaPage loadInternalImageForMangaPage];
            } else {
                if(mangaPage.mangaPageImage == nil) {
                    [mangaPage loadImageForMangaPage];
                }
            }
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                if(mangaPage.mangaPageImage == nil) {
                    
                } else {
                    [ImgView setImage:mangaPage.mangaPageImage];
                    [mangaPageLoadingActivityIndicatorView stopAnimating];
                }

                self.numOfLoadedImages++;
                if(self.numOfLoadedImages == self.manga.mangaPageNums) {
                    self.isDoneLoadingImages = YES;
                }
            }];
        }];
        
        [Scroller addSubview:SubScroller];

        if([readingDirection isEqualToString:@"LR"]) {
            ScrollerViewSize = CGRectOffset(ScrollerViewSize, Scroller.frame.size.width, 0);
        } else if([readingDirection isEqualToString:@"RL"]) {
            ScrollerViewSize = CGRectOffset(ScrollerViewSize, -1 * Scroller.frame.size.width, 0);
        }
    }
    
    [self.mangaReadMainView addSubview:Scroller];
    [self.loadingActivityIndicator stopAnimating];
    
    self.title = [NSString stringWithFormat:@"1 of %d", self.manga.mangaPageNums];
    if([readingDirection isEqualToString:@"LR"]) {
    } else if([readingDirection isEqualToString:@"RL"]) {
        [Scroller setContentOffset:CGPointMake(Scroller.frame.size.width * (self.manga.mangaPageNums - 1), 0.0f) animated:NO];
    }

}

- (void)scrollViewDidScroll:(UIScrollView *)sender {
    CGFloat pageWidth = Scroller.frame.size.width;
    int currentPage = floor((Scroller.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    int currentPageForGallery = currentPage + 1;
    
    if([readingDirection isEqualToString:@"LR"]) {
        self.title = [NSString stringWithFormat:@"%d of %d", currentPageForGallery, self.manga.mangaPageNums];
    } else if([readingDirection isEqualToString:@"RL"]) {
        self.title = [NSString stringWithFormat:@"%d of %d", self.manga.mangaPageNums - currentPage, self.manga.mangaPageNums];
    }
}

- (void)toggleUIElements:(UIGestureRecognizer*)tap {
    if(isStatusBarHidden == NO) {
        [self.navigationController setNavigationBarHidden:YES animated:YES];
        [self.navigationController setToolbarHidden:YES animated:YES];
        [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
        isStatusBarHidden = YES;
    } else {
        [self.navigationController setNavigationBarHidden:NO animated:YES];
        [self.navigationController setToolbarHidden:NO animated:YES];
        [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationSlide];
        isStatusBarHidden = NO;
    }
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    int tag = [scrollView tag];
    UIImageView *ImgView = [self.mangaPageImageViews objectAtIndex:tag];
    
    return ImgView;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    int tag = [scrollView tag];
    UIImageView *ImgView = [self.mangaPageImageViews objectAtIndex:tag];
    
    // center the image as it becomes smaller than the size of the screen
    CGSize boundsSize = scrollView.bounds.size;
    CGRect frameToCenter = ImgView.frame;
    
    // center horizontally
    if (frameToCenter.size.width < boundsSize.width) {
        frameToCenter.origin.x = (boundsSize.width - frameToCenter.size.width) / 2;
    } else {
        frameToCenter.origin.x = 0;
    }
    
    // center vertically
    if (frameToCenter.size.height < boundsSize.height) {
        frameToCenter.origin.y = (boundsSize.height - frameToCenter.size.height) / 2;
    } else {
        frameToCenter.origin.y = 0;
    }
    
    ImgView.frame = frameToCenter;
    
}

-(void)jumpToPage:(NSInteger)mangaPageNum {
    if([readingDirection isEqualToString:@"LR"]) {
        [Scroller setContentOffset:CGPointMake(Scroller.frame.size.width * mangaPageNum, 0) animated:NO];
    } else if([readingDirection isEqualToString:@"RL"]) {
        [Scroller setContentOffset:CGPointMake(Scroller.frame.size.width * (self.manga.mangaPageNums - mangaPageNum - 1), 0) animated:NO];
    }
    
//    MangaPage *mangaPage = [self.manga.mangaPages objectAtIndex:mangaPageNum];
//    
//    if(mangaPage.mangaPageImage == nil) {
//        if(self.manga.mangaIsLoadedInternally) {
//            [mangaPage loadInternalImageForMangaPage];
//        } else {
//            [mangaPage loadImageForMangaPage];
//        }
//    }
}

-(BOOL)getIsDoneLoadingImages {
    return self.isDoneLoadingImages;
}

-(void)closeMangaReadGridModalViewController {
    [self dismissViewControllerAnimated:YES completion:	nil];
}

-(void)callRepairCompletionHandler {
    [self dismissViewControllerAnimated:YES completion:	nil];
    [self.navigationController popViewControllerAnimated:YES];
}

 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
     if([segue.identifier isEqualToString:@"pushMangaReadGridModalViewController"]) {
         MangaReadGridModalViewController *vc_MangaReadGridModalViewController = [segue destinationViewController];
         vc_MangaReadGridModalViewController.delegate = self;
     }
 }


- (IBAction)toggleReadingDirectionButtonClick:(id)sender {
    [mangaPageLoadingQueue cancelAllOperations];
    self.title = @"";
    [self.mangaPageImageViews removeAllObjects];
    [self.mangaPageLoadingActivityIndicatorViews removeAllObjects];
    
    if([readingDirection isEqualToString:@"LR"]) {
        readingDirection = @"RL";
        self.readingDirectionButton.image = [UIImage imageNamed:@"readingDirectionRL"];
    } else if([readingDirection isEqualToString:@"RL"]) {
        readingDirection = @"LR";
        self.readingDirectionButton.image = [UIImage imageNamed:@"readingDirectionLR"];
    }

    [Scroller removeFromSuperview];
    //[self.loadingActivityIndicator startAnimating];
    [self createUI];
}
@end
