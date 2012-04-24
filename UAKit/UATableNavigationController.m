//
//  UANavigationController.m
//  UAKit
//
//  Created by Owain Hunt on 11/04/2012.
//  Copyright (c) 2012 Owain R Hunt. All rights reserved.
//

#import "UATableNavigationController.h"
#import "UATableViewController.h"

@implementation UATableNavigationController

@synthesize viewControllers = _viewControllers;
@synthesize visibleViewControllerIndex = _visibleViewControllerIndex;
@synthesize containerView = _containerView;
@synthesize view = _view;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if ((self = [super init]))
    {
        self.nibName = nibNameOrNil;
        self.viewControllers = [NSMutableArray array];
        self.visibleViewControllerIndex = -1;
    }
    
    return self;
}


- (void)awakeFromNib
{
    self.viewControllers = [NSMutableArray array];
    self.visibleViewControllerIndex = -1;
}


- (void)presentInitialTable
{
    UATableViewController *tvc = [self prepareTableWithObject:nil];
    [self presentTable:tvc];
}


- (UATableViewController *)prepareTableWithObject:(id)obj
{
    UATableViewController *tvc;
    
    if (self.nibName)
    {
        tvc = [[UATableViewController alloc] initWithNibName:self.nibName bundle:[NSBundle mainBundle]];
    }
    else
    {
        tvc = [[UATableViewController alloc] initWithNibName:@"UATableView" bundle:[NSBundle bundleForClass:[UATableNavigationController class]]];
    }
    
    [tvc loadView]; // Do this here so outlets are available for below
    tvc.titleField.stringValue = [obj objectForKey:@"titleString"] ?: @"orhunt";
    NSArray *array = [NSArray arrayWithObjects:
                      [NSDictionary dictionaryWithObjectsAndKeys:@"My Issues", @"titleString", @"96", @"detailString", [NSString class], @"representedObject", nil],
                      [NSDictionary dictionaryWithObjectsAndKeys:@"Repositories", @"titleString", @"12", @"detailString", nil],
                      [NSDictionary dictionaryWithObjectsAndKeys:@"Milestones", @"titleString", @"1", @"detailString", nil],
                      [NSDictionary dictionaryWithObjectsAndKeys:@"Pull Requests", @"titleString", @"", @"detailString", nil],
                      [NSDictionary dictionaryWithObjectsAndKeys:@"Log", @"titleString", @"371", @"detailString", nil],
                      nil];
    tvc.representedObject = array;
    //    tvc.representedObject = obj;
    tvc.delegate = self;
    return tvc;
}


- (void)presentTable:(UATableViewController *)tvc
{
    [self.viewControllers addObject:tvc];
    self.visibleViewControllerIndex += 1;
    CGRect newFrame = CGRectMake(255, 10, 245, 300);
    [[tvc view] setFrame:newFrame];
    if ([[self.view subviews] count] < 1)
    {
        [self.view addSubview:[tvc view]];
    }
    else
    {
        [self.view addSubview:[tvc view] positioned:NSWindowAbove relativeTo:[[self.viewControllers objectAtIndex:self.visibleViewControllerIndex] view]];
    }
    newFrame.origin.x -= 245;
    [[[tvc view] animator] setFrame:newFrame];
}


- (void)tableWithIndex:(NSInteger)tableIndex
{
    UATableViewController *tvc = [self prepareTableWithObject:nil];
    [self presentTable:tvc];
}


- (void)didSelectRowWithObject:(id)object
{
    UATableViewController *tvc = [self prepareTableWithObject:nil];
    [self presentTable:tvc];
}


- (void)popTableView
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
