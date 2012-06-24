//
//  UABadgedTableViewCell.m
//  UAKit
//
//  Created by Owain Hunt on 09/05/2012.
//  Copyright (c) 2012 Owain R Hunt. All rights reserved.
//

#import "UABadgedTableViewCell.h"

@implementation UABadgedTableViewCell

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
        self.translatesAutoresizingMaskIntoConstraints = NO;
    }
    
    return self;
}


- (void)drawRect:(NSRect)dirtyRect
{
    // Drawing code here.
    if (self.hasDisclosureIndicator)
    {
        [self.disclosureImageView setHidden:NO];
    }
        
    if (self.badgeString)
    {
        CGSize badgeSize = [self sizeOfBadgeWithString:self.badgeString font:nil];
        CGRect rect = [self frame];
        CGRect badgeRect = NSMakeRect(NSMaxX(rect) - badgeSize.width - 8, NSMidY(rect)-(badgeSize.height/2.0)-2, badgeSize.width, badgeSize.height);
        CGFloat rightInset = badgeSize.width + 12;
        if (self.hasDisclosureIndicator)
        {
            badgeRect.origin.x -= 12;
            rightInset += 12;
        }
        [self drawBadgeInRect:badgeRect withString:self.badgeString foregroundColor:self.badgeColor backgroundColor:self.badgeBackgroundColor font:nil];
        NSDictionary *viewsDictionary = @{ @"titleTextField" : self.titleTextField };
        NSDictionary *metricsDictionary = @{ @"rightInset" : [NSNumber numberWithFloat:abs(rightInset)] };
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-8-[titleTextField]-rightInset-|" options:0 metrics:metricsDictionary views:viewsDictionary]];
    }
    else
    {
        NSDictionary *viewsDictionary = @{ @"titleTextField" : self.titleTextField };
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-8-[titleTextField]-8-|" options:0 metrics:nil views:viewsDictionary]];
    }
}

@end
