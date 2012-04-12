//
//  UATableViewCell.m
//  UAKit
//
//  Created by Owain Hunt on 09/04/2012.
//  Copyright (c) 2012 Owain R Hunt. All rights reserved.
//

#import "UATableViewCell.h"

@implementation UATableViewCell

@synthesize titleTextField = _titleTextField;
@synthesize detailTextField = _detailTextField;
@synthesize representedObject = _representedObject;

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
}

@end
