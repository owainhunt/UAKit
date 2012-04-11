//
//  UATableViewController.h
//  TableView
//
//  Created by Owain Hunt on 10/04/2012.
//  Copyright (c) 2012 Owain R Hunt. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "UAAppDelegate.h"

@interface UATableViewController : NSViewController <NSTableViewDelegate, NSTableViewDataSource>

@property UAAppDelegate *delegate;
@property (strong) IBOutlet NSTableView *tableView;

@end
