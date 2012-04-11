//
//  UANavigationController.h
//  TableView
//
//  Created by Owain Hunt on 11/04/2012.
//  Copyright (c) 2012 Owain R Hunt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UATableViewController.h"

@interface UANavigationController : NSObject <UATableViewControllerDelegate>

@property (strong) NSMutableArray *viewControllers;
@property (assign) int visibleViewControllerIndex;
@property (strong) IBOutlet NSView *containerView;
@property (strong) IBOutlet NSView *view;

- (void)tableWithIndex:(NSInteger)tableIndex;

@end
