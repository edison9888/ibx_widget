//
//  IBXActionSheetDataSource.h
//  IBXTableView
//
//  Created by 剑锋 屠 on 6/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IBXActionSheetDataSource : NSObject <UIActionSheetDelegate>

@property (nonatomic, retain) void (^buttonClicked)(NSUInteger, id, id);
@property (nonatomic, assign) id target;

- (void)setButtonValue:(id)value atIndex:(NSUInteger)index;

@end
