//
//  IBXOptionButton.h
//  MemoBox
//
//  Created by 剑锋 屠 on 7/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IBXOptionButton : UIButton

@property (nonatomic, retain) NSString * (^getCurrentTitle)();

- (void)setIcon:(UIImage *)icon;
- (void)updateTitle;

@end
