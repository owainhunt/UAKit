//
//  UATableViewCell.h
//  TableView
//
//  Created by Owain Hunt on 09/04/2012.
//  Copyright (c) 2012 Owain R Hunt. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface UATableViewCell : NSTableCellView

@property IBOutlet NSTextField *titleTextField;
@property IBOutlet NSTextField *detailTextField;
@property id representedObject;

@end
