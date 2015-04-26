//
//  iFakkuOfficialThreadViewController.h
//  iFakku
//
//  Created by Yuki Nagato on 3/6/15.
//  Copyright (c) 2015 SOS Brigade. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MangaSettingsWebViewController.h"

@interface MangaSettingsWebViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIWebView *mainWebView;
@property (weak, nonatomic) NSString *pageToLoadByWebView;

@end
