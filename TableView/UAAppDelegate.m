//
//  UAAppDelegate.m
//  TableView
//
//  Created by Owain Hunt on 09/04/2012.
//  Copyright (c) 2012 Owain R Hunt. All rights reserved.
//

#import "UAAppDelegate.h"
#import "UATableViewCell.h"
#import "UATableViewController.h"
#import <QuartzCore/QuartzCore.h>

@implementation UAAppDelegate

@synthesize window = _window;
@synthesize viewControllers = _viewControllers;
@synthesize visibleViewControllerIndex = _visibleViewControllerIndex;


- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    self.viewControllers = [NSMutableArray array];
    self.visibleViewControllerIndex = -1;
    UATableViewController *tvc = [self prepareTableWithObject:nil];
    [self presentTable:tvc];
}


- (UATableViewController *)prepareTableWithObject:(id)obj
{
    UATableViewController *tvc = [[UATableViewController alloc] initWithNibName:@"UATableViewController" bundle:nil];
    NSArray *array = [NSArray arrayWithObjects:
                      [NSDictionary dictionaryWithObjectsAndKeys:@"My Issues", @"titleString", @"96", @"detailString", [NSString class], @"representedObject", nil],
                      [NSDictionary dictionaryWithObjectsAndKeys:@"Repositories", @"titleString", @"12", @"detailString", nil],
                      [NSDictionary dictionaryWithObjectsAndKeys:@"Milestones", @"titleString", @"1", @"detailString", nil],
                      [NSDictionary dictionaryWithObjectsAndKeys:@"Pull Requests", @"titleString", @"", @"detailString", nil],
                      [NSDictionary dictionaryWithObjectsAndKeys:@"Log", @"titleString", @"371", @"detailString", nil],
                      nil];
    tvc.representedObject = array;
    tvc.delegate = self;
    return tvc;
}


- (void)presentTable:(UATableViewController *)tvc
{
    [self.viewControllers addObject:tvc];
    self.visibleViewControllerIndex += 1;
    CGRect newFrame = CGRectMake(255, 10, 245, 300);
    tvc.view.frame = newFrame;
    [[self.window contentView] addSubview:tvc.view];
    newFrame.origin.x -= 245;
    [[tvc.view animator] setFrame:newFrame];
}


- (void)tableWithIndex:(NSInteger)tableIndex
{
    UATableViewController *tvc = [self prepareTableWithObject:nil];
    [self presentTable:tvc];
}


- (void)didSelectRowWithObject:(id)object
{
    NSLog(@"%@", object);
    UATableViewController *tvc = [self prepareTableWithObject:nil];
    [self presentTable:tvc];
}


- (IBAction)popTableView:(id)sender
{
    if (self.visibleViewControllerIndex == 0)
    {
        return;
    }
    UATableViewController *tvc = [self.viewControllers objectAtIndex:self.visibleViewControllerIndex];
    CGRect newFrame = tvc.view.frame;
    newFrame.origin.x += 245;
    [[tvc.view animator] setFrame:newFrame];
    [self.viewControllers removeObjectAtIndex:self.visibleViewControllerIndex];
    [tvc.view performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:0.5];
    self.visibleViewControllerIndex -= 1;
}

@end
