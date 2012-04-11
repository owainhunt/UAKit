//
//  UAAppDelegate.h
//  TableView
//
//  Created by Owain Hunt on 09/04/2012.
//  Copyright (c) 2012 Owain R Hunt. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface UAAppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;
@property (strong) NSMutableArray *viewControllers;
@property (assign) int visibleViewControllerIndex;

- (IBAction)popTableView:(id)sender;
- (void)tableWithIndex:(NSInteger)tableIndex;
- (void)didSelectRowWithObject:(id)object;

@end
