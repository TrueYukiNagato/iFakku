//
//  MangaTagsTableViewController.m
//  iFakku
//
//  Created by Yuki Nagato on 3/7/15.
//  Copyright (c) 2015 SOS Brigade. All rights reserved.
//

#import "MangaTagsTableViewController.h"

@interface MangaTagsTableViewController () {
    NSString *selectedMangaTag;
    NSString *selectedMangaTagDigitized;
}

@end

@implementation MangaTagsTableViewController

static NSString* const MangaTagCellReuseIdentifier = @"mangaTagReuseTableViewCell";

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [self createMangaTagsArray];
}

- (void)viewWillDisappear:(BOOL)animated {
    self.mangaTags = nil;
}


- (void)createMangaTagsArray {
    NSMutableArray *mangaTagsMutableArray = [[NSMutableArray alloc] init];

    for(NSString *mangaTagName in [DataHelper getAllMangaTagNamesAsArray]) {
        [mangaTagsMutableArray addObject:[[MangaTag alloc]initWithTagName:mangaTagName]] ;
    }
    
    self.mangaTags = [mangaTagsMutableArray copy];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [self.mangaTags count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MangaTagCellReuseIdentifier forIndexPath:indexPath];
    
    // No need for custom cell since it can use default styling.
    
    MangaTag *mangaTag = [self.mangaTags objectAtIndex:indexPath.row];
    
    cell.imageView.image = mangaTag.mangaTagImage;
    cell.textLabel.text = mangaTag.mangaTag;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MangaTag *mangaTag = [self.mangaTags objectAtIndex:indexPath.row];
    selectedMangaTag = mangaTag.mangaTag;
    selectedMangaTagDigitized = mangaTag.mangaTagDigitized;
    [self performSegueWithIdentifier:@"pushToMangaListingViewController" sender:self];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
        
    if([segue.identifier isEqualToString:@"pushToMangaListingViewController"]) {
        MangaListingViewController *vc_MangaListingViewController = [segue destinationViewController];
        vc_MangaListingViewController.fromMangaBrowseTableViewController = YES;
        vc_MangaListingViewController.mangaTag = selectedMangaTag;
        vc_MangaListingViewController.mangaTagDigitized = selectedMangaTagDigitized;
    }
}

@end
