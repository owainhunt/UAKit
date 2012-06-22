//
//  UATableViewController.m
//  UAKit
//
//  Created by Owain Hunt on 10/04/2012.
//  Copyright (c) 2012 Owain R Hunt. All rights reserved.
//

#import "UATableViewController.h"
#import "UATableViewCell.h"
#import "UATableNavigationController.h"

@interface UATableViewController ()

@end

@implementation UATableViewController

@synthesize delegate = _delegate;
@synthesize tableView = _tableView;
@synthesize titleField = _titleField;
@synthesize backButton = _backButton;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) 
    {
    }
    
    return self;
}


- (id)initWithNavigationController:(UATableNavigationController *)tnc
{
    if (tnc.nibName)
    {
        self = [self initWithNibName:tnc.nibName bundle:[NSBundle mainBundle]];
    }
    else
    {
        self = [self initWithNibName:@"UATableView" bundle:[NSBundle bundleForClass:[UATableNavigationController class]]];
    }
    
    if (self)
    {
        [self loadView];
        self.delegate = tnc;
    }
    return self;
}


- (void)loadView
{
    /*
    NSNib *nib = [[NSNib alloc] initWithNibNamed:[self nibName] bundle:[self nibBundle]];
    [nib instantiateNibWithOwner:self topLevelObjects:nil];
     */
    [super loadView];
    [self.titleField.cell setBackgroundStyle:NSBackgroundStyleRaised];
    [self.tableView setDataSource:self];
    [self.tableView setDelegate:self];
    [self.tableView setTarget:self];
    [self.tableView setDoubleAction:@selector(doubleClicked)];
}


- (void)doubleClicked
{
    [self.delegate didSelectRowWithObject:[self representedObjectForCellAtRow:[self.tableView clickedRow]]];
}


- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView
{
    return [[self representedObject] count];
}

- (id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
    return [[self representedObject] objectAtIndex:row];
}


- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row 
{
    UATableViewCell *cellView = [tableView makeViewWithIdentifier:@"MyView" owner:self];
    NSDictionary *cellDictionary = [self tableView:tableView objectValueForTableColumn:tableColumn row:row];
    cellView.titleTextField.stringValue = [cellDictionary objectForKey:@"titleString"];
    cellView.representedObject = [cellDictionary objectForKey:@"representedObject"] ?: cellDictionary;

    return cellView;    
}


- (id)representedObjectForCellAtRow:(NSInteger)row
{
    return [[self.representedObject objectAtIndex:row] objectForKey:@"representedObject"] ?: [self.representedObject objectAtIndex:row];
}


- (void)backButtonPressed:(id)sender
{
    [self.delegate popTableView];
}


@end
