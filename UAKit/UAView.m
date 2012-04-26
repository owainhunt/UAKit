//
//  UAView.m
//  TableView
//
//  Created by Owain Hunt on 10/04/2012.
//  Copyright (c) 2012 Owain R Hunt. All rights reserved.
//

#import "UAView.h"

@implementation UAView

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
        [self setTranslatesAutoresizingMaskIntoConstraints:NO];
    }
    
    return self;
}

- (BOOL)isFlipped
{
    return YES;
}

- (void)drawRect:(NSRect)dirtyRect
{
    // Drawing code here.
}

@end
