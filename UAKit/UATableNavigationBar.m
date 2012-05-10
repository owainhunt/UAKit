//
//  UATableNavigationBar.m
//  UAKit
//
//  Created by Owain Hunt on 10/05/2012.
//  Copyright (c) 2012 Owain R Hunt. All rights reserved.
//

#import "UATableNavigationBar.h"

@implementation UATableNavigationBar

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
    NSGradient* aGradient = [[NSGradient alloc]
                              initWithStartingColor:[NSColor colorWithCalibratedRed:0.91 green:0.91 blue:0.91 alpha:1.0]
                              endingColor:[NSColor colorWithCalibratedRed:0.73 green:0.73 blue:0.73 alpha:1.0]];
    [aGradient drawInRect:[self bounds] angle:270];
    NSBezierPath *path = [NSBezierPath bezierPathWithRect:CGRectMake(0, 0, NSMaxX([self bounds]), 1)];
    [[NSColor colorWithCalibratedRed:0.4 green:0.4 blue:0.4 alpha:1.0] set];
    [path fill];

}

@end
