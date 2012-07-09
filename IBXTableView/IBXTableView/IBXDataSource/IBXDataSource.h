//
//  IBXDataSource.h
//  IBXTableView
//
//  Created by 剑锋 屠 on 4/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "IBXTableViewSection.h"

@interface IBXDataSource : NSObject <UITableViewDataSource, UITableViewDelegate>

- (void)addSection:(IBXTableViewSection *)section;
- (void)removeSection:(IBXTableViewSection *)section;
- (IBXTableViewSection *)sectionAtIndex:(NSUInteger)index;

@end
