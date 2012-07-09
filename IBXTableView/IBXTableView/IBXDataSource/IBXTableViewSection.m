//
//  IBXTableViewSection.m
//  IBXTableView
//
//  Created by 剑锋 屠 on 7/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "IBXTableViewSection.h"

@interface IBXTableViewSection ()
{
    NSMutableArray * _items;
    NSString * _headString;
    NSString * _tailString;
}

@end

@implementation IBXTableViewSection

@synthesize headString = _headString;
@synthesize tailString = _tailString;

- (void)dealloc
{
    [_items release];
    [_headString release];
    [_tailString release];
    
    [super dealloc];
}

- (id)init
{
    self = [super init];
    if (self) {
        _items = [[NSMutableArray alloc] init];
    }
    
    return self;
}

- (void)addItem:(IBXTableViewItem *)item
{
    [_items addObject:item];
}

- (void)removeItem:(IBXTableViewItem *)item
{
    [_items removeObject:item];
}

- (void)addItem:(IBXTableViewItem *)item atIndex:(NSUInteger)index
{
    if (index < [_items count]){
        [_items insertObject:item atIndex:index]; 
    }
    else {
        [_items addObject:item];
    }
}

- (void)removeItem:(IBXTableViewItem *)item atIndex:(NSUInteger)index
{
    if (index < [_items count]) {
        [_items removeObjectAtIndex:index];
    }
}

- (IBXTableViewItem *)itemAtIndex:(NSUInteger)index
{
    if (index < [_items count]) {
        return [_items objectAtIndex:index];
    }
    
    return nil;
}

- (NSUInteger)itemCount
{
    return [_items count];
}

@end
