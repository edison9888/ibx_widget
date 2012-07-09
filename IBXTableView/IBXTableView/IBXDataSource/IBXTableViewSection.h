//
//  IBXTableViewSection.h
//  IBXTableView
//
//  Created by 剑锋 屠 on 7/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "IBXTableViewItem.h"

@interface IBXTableViewSection : NSObject

@property (nonatomic, copy) NSString * headString;
@property (nonatomic, copy) NSString * tailString;

- (void)addItem:(IBXTableViewItem *)item;
- (void)removeItem:(IBXTableViewItem *)item;

- (void)addItem:(IBXTableViewItem *)item atIndex:(NSUInteger)index;
- (void)removeItem:(IBXTableViewItem *)item atIndex:(NSUInteger)index;

- (IBXTableViewItem *)itemAtIndex:(NSUInteger)index;

- (NSUInteger)itemCount;

@end
