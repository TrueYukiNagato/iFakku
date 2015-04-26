//
//  MangaTag.m
//  iFakku
//
//  Created by Yuki Nagato on 2/24/15.
//  Copyright (c) 2015 SOS Brigade. All rights reserved.
//

#import "MangaTag.h"

@implementation MangaTag

-(id)initWithRawTagInfo:(NSDictionary*)rawTagsInfo {
    self.mangaTag = [rawTagsInfo objectForKey:@"attribute"];
    self.mangaTagDigitized = [DataHelper stripAllButLastOfFakkuUrlSegment:[rawTagsInfo objectForKey:@"attribute_link"]];
    
    return self;
}

-(id)initWithTagName:(NSString*)mangaTagName {
    self.mangaTag = mangaTagName;
    
    if ([self.mangaTag isEqualToString:@"Ahegao"]) {
        self.mangaTagDigitized = @"ahegao";
    } else if ([self.mangaTag isEqualToString:@"Anal"]) {
        self.mangaTagDigitized = @"anal";
    } else if ([self.mangaTag isEqualToString:@"Animated"]) {
        self.mangaTagDigitized = @"animated";
    } else if ([self.mangaTag isEqualToString:@"Ashikoki"]) {
        self.mangaTagDigitized = @"ashikoki";
    } else if ([self.mangaTag isEqualToString:@"Bakunyuu"]) {
        self.mangaTagDigitized = @"bakunyuu";
    } else if ([self.mangaTag isEqualToString:@"Bara"]) {
        self.mangaTagDigitized = @"bara";
    } else if ([self.mangaTag isEqualToString:@"Bondage"]) {
        self.mangaTagDigitized = @"bondage";
    } else if ([self.mangaTag isEqualToString:@"Cheating"]) {
        self.mangaTagDigitized = @"cheating";
    } else if ([self.mangaTag isEqualToString:@"Chikan"]) {
        self.mangaTagDigitized = @"chikan";
    } else if ([self.mangaTag isEqualToString:@"Chubby"]) {
        self.mangaTagDigitized = @"chubby";
    } else if ([self.mangaTag isEqualToString:@"Color"]) {
        self.mangaTagDigitized = @"color";
    } else if ([self.mangaTag isEqualToString:@"Dark Skin"]) {
        self.mangaTagDigitized = @"darkskin";
    } else if ([self.mangaTag isEqualToString:@"Decensored"]) {
        self.mangaTagDigitized = @"decensored";
    } else if ([self.mangaTag isEqualToString:@"Ecchi"]) {
        self.mangaTagDigitized = @"ecchi";
    } else if ([self.mangaTag isEqualToString:@"Femdom"]) {
        self.mangaTagDigitized = @"femdom";
    } else if ([self.mangaTag isEqualToString:@"Forced"]) {
        self.mangaTagDigitized = @"forced";
    } else if ([self.mangaTag isEqualToString:@"Futanari"]) {
        self.mangaTagDigitized = @"futanari";
    } else if ([self.mangaTag isEqualToString:@"Glasses"]) {
        self.mangaTagDigitized = @"glasses";
    } else if ([self.mangaTag isEqualToString:@"Group"]) {
        self.mangaTagDigitized = @"group";
    } else if ([self.mangaTag isEqualToString:@"Harem"]) {
        self.mangaTagDigitized = @"harem";
    } else if ([self.mangaTag isEqualToString:@"Hentai"]) {
        self.mangaTagDigitized = @"hentai";
    } else if ([self.mangaTag isEqualToString:@"Horror"]) {
        self.mangaTagDigitized = @"horror";
    } else if ([self.mangaTag isEqualToString:@"Housewife"]) {
        self.mangaTagDigitized = @"housewife";
    } else if ([self.mangaTag isEqualToString:@"Humiliation"]) {
        self.mangaTagDigitized = @"humiliation";
    } else if ([self.mangaTag isEqualToString:@"Idol"]) {
        self.mangaTagDigitized = @"idol";
    } else if ([self.mangaTag isEqualToString:@"Incest"]) {
        self.mangaTagDigitized = @"incest";
    } else if ([self.mangaTag isEqualToString:@"Irrumatio"]) {
        self.mangaTagDigitized = @"irrumatio";
    } else if ([self.mangaTag isEqualToString:@"Kemonomimi"]) {
        self.mangaTagDigitized = @"kemonomimi";
    } else if ([self.mangaTag isEqualToString:@"Maid"]) {
        self.mangaTagDigitized = @"maid";
    } else if ([self.mangaTag isEqualToString:@"Monster Girl"]) {
        self.mangaTagDigitized = @"monstergirl";
    } else if ([self.mangaTag isEqualToString:@"Nakadashi"]) {
        self.mangaTagDigitized = @"nakadashi";
    } else if ([self.mangaTag isEqualToString:@"Netorare"]) {
        self.mangaTagDigitized = @"netorare";
    } else if ([self.mangaTag isEqualToString:@"Netori"]) {
        self.mangaTagDigitized = @"netori";
    } else if ([self.mangaTag isEqualToString:@"Non-H"]) {
        self.mangaTagDigitized = @"non-h";
    } else if ([self.mangaTag isEqualToString:@"Nurse"]) {
        self.mangaTagDigitized = @"nurse";
    } else if ([self.mangaTag isEqualToString:@"Oppai"]) {
        self.mangaTagDigitized = @"oppai";
    } else if ([self.mangaTag isEqualToString:@"Oral"]) {
        self.mangaTagDigitized = @"oral";
    } else if ([self.mangaTag isEqualToString:@"Osananajimi"]) {
        self.mangaTagDigitized = @"osananajimi";
    } else if ([self.mangaTag isEqualToString:@"Oshiri"]) {
        self.mangaTagDigitized = @"oshiri";
    } else if ([self.mangaTag isEqualToString:@"Paizuri"]) {
        self.mangaTagDigitized = @"paizuri";
    } else if ([self.mangaTag isEqualToString:@"Pegging"]) {
        self.mangaTagDigitized = @"pegging";
    } else if ([self.mangaTag isEqualToString:@"Pettanko"]) {
        self.mangaTagDigitized = @"pettanko";
    } else if ([self.mangaTag isEqualToString:@"Pregnant"]) {
        self.mangaTagDigitized = @"pregnant";
    } else if ([self.mangaTag isEqualToString:@"Random"]) {
        self.mangaTagDigitized = @"random";
    } else if ([self.mangaTag isEqualToString:@"Schoolgirl"]) {
        self.mangaTagDigitized = @"schoolgirl";
    } else if ([self.mangaTag isEqualToString:@"Shimapan"]) {
        self.mangaTagDigitized = @"shimapan";
    } else if ([self.mangaTag isEqualToString:@"Socks"]) {
        self.mangaTagDigitized = @"socks";
    } else if ([self.mangaTag isEqualToString:@"Stockings"]) {
        self.mangaTagDigitized = @"stockings";
    } else if ([self.mangaTag isEqualToString:@"Swimsuit"]) {
        self.mangaTagDigitized = @"swimsuit";
    } else if ([self.mangaTag isEqualToString:@"Tanlines"]) {
        self.mangaTagDigitized = @"tanlines";
    } else if ([self.mangaTag isEqualToString:@"Teacher"]) {
        self.mangaTagDigitized = @"teacher";
    } else if ([self.mangaTag isEqualToString:@"Tentacles"]) {
        self.mangaTagDigitized = @"tentacles";
    } else if ([self.mangaTag isEqualToString:@"Tomboy"]) {
        self.mangaTagDigitized = @"tomboy";
    } else if ([self.mangaTag isEqualToString:@"Toys"]) {
        self.mangaTagDigitized = @"toys";
    } else if ([self.mangaTag isEqualToString:@"Trap"]) {
        self.mangaTagDigitized = @"trap";
    } else if ([self.mangaTag isEqualToString:@"Tsundere"]) {
        self.mangaTagDigitized = @"tsundere";
    } else if ([self.mangaTag isEqualToString:@"Vanilla"]) {
        self.mangaTagDigitized = @"vanilla";
    } else if ([self.mangaTag isEqualToString:@"Western"]) {
        self.mangaTagDigitized = @"western";
    } else if ([self.mangaTag isEqualToString:@"Yandere"]) {
        self.mangaTagDigitized = @"yandere";
    } else if ([self.mangaTag isEqualToString:@"Yaoi"]) {
        self.mangaTagDigitized = @"yaoi";
    } else if ([self.mangaTag isEqualToString:@"Yuri"]) {
        self.mangaTagDigitized = @"yuri";
    }
    
    NSString *imageName = [NSString stringWithFormat:@"mangaTag_%@", self.mangaTagDigitized];
    self.mangaTagImage = [UIImage imageNamed:imageName];
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder  {
    [encoder encodeObject:self.mangaTag forKey:@"mangaTag"];
    [encoder encodeObject:self.mangaTagDigitized forKey:@"mangaTagDigitized"];
}

- (id)initWithCoder:(NSCoder *)decoder  {
    if ((self = [super init])) {
        self.mangaTag  = [decoder decodeObjectForKey:@"mangaTag"];
        self.mangaTagDigitized  = [decoder decodeObjectForKey:@"mangaTagDigitized"];
    }
    
    return self;
}

@end
