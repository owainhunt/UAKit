//
//  UATableViewController.h
//  UAKit
//
//  Created by Owain Hunt on 10/04/2012.
//  Copyright (c) 2012 Owain R Hunt. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@protocol UATableViewControllerDelegate <NSObject>

- (void)didSelectRowWithObject:(id)obj;
- (void)popTableView;

@end

@interface UATableViewController : NSViewController <NSTableViewDelegate, NSTableViewDataSource>

@property id<UATableViewControllerDelegate> delegate;
@property (strong) IBOutlet NSTableView *tableView;
@property (strong) IBOutlet NSTextField *titleField;
@property (strong) IBOutlet NSButton *backButton;

- (IBAction)backButtonPressed:(id)sender;

@end
