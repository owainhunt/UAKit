//
//  UANavigationController.m
//  UAKit
//
//  Created by Owain Hunt on 11/04/2012.
//  Copyright (c) 2012 Owain R Hunt. All rights reserved.
//

#import "UATableNavigationController.h"
#import "UATableViewController.h"

#define ANIMATION_FACTOR 3
#define DEFAULT_NAVIGATION_TITLE @"orhunt"

@interface UATableNavigationController (Private)


@end

@implementation UATableNavigationController

@synthesize viewControllers = _viewControllers;
@synthesize visibleViewControllerIndex = _visibleViewControllerIndex;
//@synthesize containerView = _containerView;
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
    UATableViewController *tvc = [self prepareTableWithObject:nil title:nil];
    [self presentTable:tvc animated:NO];
}


- (id)prepareTableWithObject:(id)obj title:(NSString *)title
{
    UATableViewController *tvc = [[UATableViewController alloc] initWithNavigationController:self];
    tvc.titleField.stringValue = title ?: DEFAULT_NAVIGATION_TITLE;
    [tvc setRepresentedObject:[obj copy]];
    return tvc;
}


- (void)presentTable:(UATableViewController *)tvc animated:(BOOL)animated
{        
    [self.viewControllers addObject:tvc];
    self.visibleViewControllerIndex += 1;
    UATableViewController *currentTVC = nil;
    
    if (self.visibleViewControllerIndex > 0)
    {
        currentTVC = [self.viewControllers objectAtIndex:self.visibleViewControllerIndex - 1];
    }
    
    CGRect currentFrame = self.view.frame;
    [[tvc view] setFrame:currentFrame];
 
    if (animated)
    {        
        [[tvc view] setAlphaValue:0];
    }
       
    if ([[self.view subviews] count] < 1)
    {
        [self.view addSubview:[tvc view]];
    }
    else
    {
        [self.view addSubview:[tvc view] positioned:NSWindowAbove relativeTo:[[self.viewControllers objectAtIndex:self.visibleViewControllerIndex] view]];
    }

    if (animated)
    {
        CGRect currentTVCEndPositionFrame = currentFrame;
        currentTVCEndPositionFrame.origin.x -= currentFrame.size.width/ANIMATION_FACTOR;

        CGRect animationStartingPositionFrame = currentFrame;
        animationStartingPositionFrame.origin.x += currentFrame.size.width/ANIMATION_FACTOR;
        [[tvc view] setFrame:animationStartingPositionFrame];

        [NSAnimationContext beginGrouping];
        [[NSAnimationContext currentContext] setDuration:0.4];
        [[currentTVC.view animator] setFrame:currentTVCEndPositionFrame];
        [currentTVC.view animateToVisible:NO];
        [NSAnimationContext beginGrouping];
        [[NSAnimationContext currentContext] setDuration:0.2];
        [[[tvc view] animator] setFrame:currentFrame];
        [[tvc view] animateToVisible:YES];
        [NSAnimationContext endGrouping];
        [NSAnimationContext endGrouping];
    }

    [tvc.view setTranslatesAutoresizingMaskIntoConstraints:NO];
    NSDictionary *viewsDictionary = @{ @"tvcView" : tvc.view };
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-0-[tvcView]-0-|" options:0 metrics:nil views:viewsDictionary]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[tvcView]-0-|" options:0 metrics:nil views:viewsDictionary]];
    self.displayedObject = tvc.representedObject;

}


- (void)tableWithIndex:(NSInteger)tableIndex
{
    UATableViewController *tvc = [self prepareTableWithObject:nil title:nil];
    [self presentTable:tvc animated:YES];
}


- (void)didSelectRowWithObject:(id)object
{
    UATableViewController *tvc = [self prepareTableWithObject:object title:nil];
    [self presentTable:tvc animated:YES];
}


- (void)popTableView
{
    if (self.visibleViewControllerIndex == 0)
    {
        return;
    }
    
    UATableViewController *currentTVC = [self.viewControllers objectAtIndex:self.visibleViewControllerIndex];
    UATableViewController *nextTVC = [self.viewControllers objectAtIndex:self.visibleViewControllerIndex - 1];

    CGRect currentTVCStartPositionFrame = currentTVC.view.frame;
    CGRect currentTVCEndPositionFrame = currentTVC.view.frame;
    currentTVCEndPositionFrame.origin.x += currentTVC.view.frame.size.width/ANIMATION_FACTOR;

    for (UATableViewController *controller in self.viewControllers)
    {
        controller.view.frame = currentTVCStartPositionFrame;
    }
    
    CGRect nextTVCFrame = nextTVC.view.frame;
    nextTVCFrame.origin.x -= currentTVC.view.frame.size.width/ANIMATION_FACTOR;
    [nextTVC.view setFrame:nextTVCFrame];
    
    [NSAnimationContext beginGrouping];
    [[NSAnimationContext currentContext] setDuration:0.2];
    [[nextTVC.view animator] setFrame:currentTVCStartPositionFrame];
    [nextTVC.view animateToVisible:YES];
    
    [NSAnimationContext beginGrouping];
    [[NSAnimationContext currentContext] setDuration:0.2];
    [currentTVC.view animateToVisible:NO];
    [[currentTVC.view animator] setFrame:currentTVCEndPositionFrame];
    [NSAnimationContext endGrouping];
    [NSAnimationContext endGrouping];

    [self.viewControllers removeObjectAtIndex:self.visibleViewControllerIndex];
    [currentTVC.view performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:0.5];
    self.visibleViewControllerIndex -= 1;
}


@end
