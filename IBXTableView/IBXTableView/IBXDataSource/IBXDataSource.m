//
//  IBXDataSource.m
//  IBXTableView
//
//  Created by 剑锋 屠 on 4/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "IBXDataSource.h"

@interface IBXDataSource () 
{
    NSMutableArray * _sections;
}

@end

@implementation IBXDataSource

- (void)dealloc
{
    [_sections release];
    
    [super dealloc];
}

- (id)init
{
    self = [super init];
    if (self) {
        _sections = [[NSMutableArray alloc] init];
    }
    
    return self;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [_sections count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    IBXTableViewSection * ibxSection = [_sections objectAtIndex:section];
    return [ibxSection headString];
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    IBXTableViewSection * ibxSection = [_sections objectAtIndex:section];
    return [ibxSection tailString];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    IBXTableViewSection * ibxSection = [_sections objectAtIndex:section];
    return [ibxSection itemCount];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * identifer = @"ibx_cell";
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 
                                       reuseIdentifier:identifer] autorelease];
    }
    
    IBXTableViewSection * ibxSection = [_sections objectAtIndex:indexPath.section];
    IBXTableViewItem * ibxItem = [ibxSection itemAtIndex:indexPath.row];
    [ibxItem layout:cell];
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    IBXTableViewSection * ibxSection = [_sections objectAtIndex:indexPath.section];
    IBXTableViewItem * ibxItem = [ibxSection itemAtIndex:indexPath.row];
    if (ibxItem.itemClicked != nil) {
        ibxItem.itemClicked();
    }
}

#pragma mark - self

- (void)addSection:(IBXTableViewSection *)section
{
    [_sections addObject:section];
}


- (void)removeSection:(IBXTableViewSection *)section
{
    [_sections removeObject:section];
}

- (IBXTableViewSection *)sectionAtIndex:(NSUInteger)index
{
    if (index < [_sections count]) {
        return [_sections objectAtIndex:index];
    }
    
    return nil;
}

@end
