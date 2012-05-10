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
    }
    
    return self;
}


- (void)drawRect:(NSRect)dirtyRect
{
    // Drawing code here.
    if (self.badgeString)
    {
        CGSize badgeSize = [self sizeOfBadgeWithString:self.badgeString];
        CGRect rect = [self frame];
        CGRect badgeRect = NSMakeRect(NSMaxX(rect) - badgeSize.width - 10, NSMidY(rect)-(badgeSize.height/2.0), badgeSize.width, badgeSize.height);
        [self drawBadgeInRect:badgeRect];
    }
}


- (NSSize)sizeOfBadgeWithString:(NSString *)badgeString
{
    NSMutableParagraphStyle *paragStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    [paragStyle setAlignment:NSCenterTextAlignment];
    NSAttributedString *badgeAttrString = [[NSAttributedString alloc] initWithString:badgeString attributes:
                                           @{ NSParagraphStyleAttributeName : paragStyle,
                                                                NSFontAttributeName : [NSFont boldSystemFontOfSize:11],
                                                     NSForegroundColorAttributeName : [NSColor whiteColor]
                                           }
                                           ];
    CGSize badgeSize = [badgeAttrString size];
    CGFloat margin = 6;
    badgeSize.width += (margin * 2);
    return badgeSize;
}


- (void)drawBadgeInRect:(CGRect)badgeRect
{
    NSMutableParagraphStyle *paragStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    [paragStyle setAlignment:NSCenterTextAlignment];
    NSAttributedString *badgeAttrString = [[NSAttributedString alloc] initWithString:self.badgeString attributes:
                                           @{ NSParagraphStyleAttributeName : paragStyle,
                                                                NSFontAttributeName : [NSFont boldSystemFontOfSize:11],
                                                     NSForegroundColorAttributeName : (self.badgeColor) ?: [NSColor whiteColor]
                                           }
                                           ];
    
    NSGraphicsContext *context = [NSGraphicsContext currentContext];
    [context saveGraphicsState];
    NSBezierPath *path = [NSBezierPath bezierPathWithRoundedRect:badgeRect
                                                         xRadius:badgeRect.size.height/2
                                                         yRadius:badgeRect.size.height/2];
    if (self.badgeBackgroundColor)
    {
        [self.badgeBackgroundColor set];
    }
    else
    {
        [[NSColor colorWithCalibratedRed:0.6 green:0.65 blue:0.7 alpha:1.0] set];
    }
    [path fill];
    
	NSSize stringSize = [badgeAttrString size];
	NSPoint badgeTextPoint = NSMakePoint(NSMidX(badgeRect)-(stringSize.width/2.0),		//Center in the badge frame
										 NSMidY(badgeRect)-(stringSize.height/2.0));	//Center in the badge frame
	[badgeAttrString drawAtPoint:badgeTextPoint];
    
    [context restoreGraphicsState];
    
}


@end
