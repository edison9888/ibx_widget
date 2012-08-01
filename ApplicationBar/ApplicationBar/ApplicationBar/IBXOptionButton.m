//
//  IBXOptionButton.m
//  MemoBox
//
//  Created by 剑锋 屠 on 7/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "IBXOptionButton.h"

#define DEFAULT_PADDING 10

@interface IBXOptionButton () 
{
    NSString * (^_getCurrentTitle)();
}

@end

@implementation IBXOptionButton

@synthesize getCurrentTitle = _getCurrentTitle;

- (void)dealloc
{
    [_getCurrentTitle release];
    
    [super dealloc];
}

- (id)init
{
    self = [super init];
    if (self) {
        self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    }
    
    return self;
}

- (void)setIcon:(UIImage *)icon
{
    if (icon != nil) { 
        [self setImage:icon forState:UIControlStateNormal];
        [self setTitleEdgeInsets:UIEdgeInsetsMake(0, DEFAULT_PADDING, 0, 0)];
    }
}

- (void)updateTitle
{
    if (_getCurrentTitle != nil) {
        [self setTitle:_getCurrentTitle() forState:UIControlStateNormal];
    }
}

@end
