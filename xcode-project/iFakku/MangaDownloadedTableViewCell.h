//
//  MangaDownloadedTableViewCell.h
//  iFakku
//
//  Created by Yuki Nagato on 2/27/15.
//  Copyright (c) 2015 SOS Brigade. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MangaDownloadedTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *mangaCoverImage;
@property (weak, nonatomic) IBOutlet UITextView *mangaTitle;
@property (weak, nonatomic) IBOutlet UILabel *mangaSeries;
@property (weak, nonatomic) IBOutlet UILabel *mangaArtists;
@property (weak, nonatomic) IBOutlet UILabel *mangaTranslators;
@property (weak, nonatomic) IBOutlet UILabel *mangaLanguage;
@property (weak, nonatomic) IBOutlet UITextView *mangaTags;

@end
