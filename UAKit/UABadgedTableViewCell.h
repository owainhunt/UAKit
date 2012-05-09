//
//  UABadgedTableViewCell.h
//  UAKit
//
//  Created by Owain Hunt on 09/05/2012.
//  Copyright (c) 2012 Owain R Hunt. All rights reserved.
//

#import "UATableViewCell.h"

@interface UABadgedTableViewCell : UATableViewCell

@property (strong, nonatomic) NSString *badgeString;
@property (strong) NSColor *badgeBackgroundColor;
@property (strong) NSColor *badgeColor;

@end
