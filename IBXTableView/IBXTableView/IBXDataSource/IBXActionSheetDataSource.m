//
//  IBXActionSheetDataSource.m
//  IBXTableView
//
//  Created by 剑锋 屠 on 6/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "IBXActionSheetDataSource.h"

@interface IBXActionSheetDataSource () 
{
    NSMutableDictionary * _buttonValues;
    
    void (^_buttonClicked)(NSUInteger, id);
}

@end

@implementation IBXActionSheetDataSource

@synthesize buttonClicked = _buttonClicked;

- (void)dealloc
{
    [_buttonValues release];
    [_buttonClicked release];
    
    [super dealloc];
}


- (void)setButtonValue:(id)value atIndex:(NSUInteger)index
{
    if (_buttonValues == nil) _buttonValues = [[NSMutableDictionary alloc] init];
    [_buttonValues setObject:value forKey:[NSString stringWithFormat:@"%d", index]];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex != actionSheet.cancelButtonIndex) {
        id value = [_buttonValues objectForKey:[NSString stringWithFormat:@"%d", buttonIndex]];
        _buttonClicked(buttonIndex, value);
    }
}

@end
