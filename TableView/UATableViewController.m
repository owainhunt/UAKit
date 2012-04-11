//
//  UATableViewController.m
//  TableView
//
//  Created by Owain Hunt on 10/04/2012.
//  Copyright (c) 2012 Owain R Hunt. All rights reserved.
//

#import "UATableViewController.h"
#import "UATableViewCell.h"

@interface UATableViewController ()

@end

@implementation UATableViewController

@synthesize delegate = _delegate;
@synthesize tableView = _tableView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) 
    {
    }
    
    return self;
}


- (void)loadView
{
    [super loadView];
    [self.tableView setDataSource:self];
    [self.tableView setDelegate:self];
}


- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView
{
    return [self.representedObject count];
}


- (id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
    return [self.representedObject objectAtIndex:row];
}


- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row 
{
    UATableViewCell *cellView = [tableView makeViewWithIdentifier:@"MyView" owner:self];
    NSDictionary *cellDictionary = [self tableView:tableView objectValueForTableColumn:tableColumn row:row];
    cellView.titleTextField.stringValue = [cellDictionary objectForKey:@"titleString"];
    cellView.detailTextField.stringValue = [cellDictionary objectForKey:@"detailString"];
    cellView.representedObject = [cellDictionary objectForKey:@"representedObject"];

    return cellView;    
}


- (id)representedObjectForCellAtRow:(NSInteger)row
{
    return [[self.representedObject objectAtIndex:row] objectForKey:@"representedObject"];
}


- (void)tableViewSelectionDidChange:(NSNotification *)notification
{
    [self.delegate didSelectRowWithObject:[self representedObjectForCellAtRow:self.tableView.selectedRow]];
}


@end
