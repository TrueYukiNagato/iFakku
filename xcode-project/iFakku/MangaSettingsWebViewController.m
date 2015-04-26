//
//  iFakkuOfficialThreadViewController.m
//  iFakku
//
//  Created by Yuki Nagato on 3/6/15.
//  Copyright (c) 2015 SOS Brigade. All rights reserved.
//

#import "MangaSettingsWebViewController.h"

@interface MangaSettingsWebViewController () {
    BOOL isLocal;
}

@end

@implementation MangaSettingsWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    isLocal = NO;

    NSString *url;
    NSString* htmlString;
    
    self.mainWebView.delegate = self;
    
    if([self.pageToLoadByWebView isEqualToString:@"iFakkuFAQ"]) {
        self.title = @"iFakku FAQ";
        isLocal = YES;

        NSString *htmlFile = [[NSBundle mainBundle] pathForResource:@"iFakkuFAQ" ofType:@"html"];
        htmlString = [NSString stringWithContentsOfFile:htmlFile encoding:NSUTF8StringEncoding error:nil];
    } else if([self.pageToLoadByWebView isEqualToString:@"iFakkuThread"]) {
        self.title = @"iFakku Official Thread";
        url = @"https://www.fakku.net/forums/fakku-developers/ifakku-a-fakku-app-for-iphone";
    } else if([self.pageToLoadByWebView isEqualToString:@"FakkuForums"]) {
        self.title = @"Fakku Forums";
        url = @"https://www.fakku.net/forums/";
    } else if([self.pageToLoadByWebView isEqualToString:@"SpecialThanks"]) {
        self.title = @"Special Thanks";
        isLocal = YES;
        
        NSString *htmlFile = [[NSBundle mainBundle] pathForResource:@"iFakkuSpecialThanks" ofType:@"html"];
        htmlString = [NSString stringWithContentsOfFile:htmlFile encoding:NSUTF8StringEncoding error:nil];
    }
    
    if(isLocal) {
        [self.mainWebView loadHTMLString:htmlString baseURL:nil];
    } else {
        
    }
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    [self.mainWebView loadRequest:request];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL) webView:(UIWebView *)inWeb shouldStartLoadWithRequest:(NSURLRequest *)inRequest navigationType:(UIWebViewNavigationType)inType {
    if([self.pageToLoadByWebView isEqualToString:@"iFakkuFAQ"]) {
        if ( inType == UIWebViewNavigationTypeLinkClicked ) {
            [[UIApplication sharedApplication] openURL:[inRequest URL]];
            return NO;
        }
        
        return YES;
    } else {
        return YES;
    }
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

}

@end
