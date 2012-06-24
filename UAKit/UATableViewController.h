//
//  UATableViewController.h
//  UAKit
//
//  Created by Owain Hunt on 10/04/2012.
//  Copyright (c) 2012 Owain R Hunt. All rights reserved.
//

#import <Cocoa/Cocoa.h>
@class UATableNavigationController;
@class UATableViewCell;
@class UATableNavigationBar;
@class UATableView;

@protocol UATableViewControllerDelegate <NSObject>

@optional
- (void)didSelectRowWithObject:(id)obj;
- (void)didSelectCell:(UATableViewCell *)cell;
- (void)didDoubleClickCell:(UATableViewCell *)cell;
- (void)popTableView;

@end

@interface UATableViewController : NSViewController <NSTableViewDelegate, NSTableViewDataSource>

@property id<UATableViewControllerDelegate> delegate;
@property (strong) IBOutlet UATableView *tableView;
@property (strong) IBOutlet UATableNavigationBar *headerContainerView;
@property (strong) IBOutlet NSTextField *titleField;
@property (strong) IBOutlet NSButton *backButton;

- (id)initWithNavigationController:(UATableNavigationController *)tnc;
- (IBAction)backButtonPressed:(id)sender;


@end
