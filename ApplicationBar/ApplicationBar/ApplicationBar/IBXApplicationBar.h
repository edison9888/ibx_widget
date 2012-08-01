//
//  IBXApplicationBar.h
//  ApplicationBar
//
//  Created by InstBox.com on 4/7/12.
//  Copyright (c) 2012 VNT. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "IBXOptionButton.h"

#define IBX_APPLICATION_BAR_DEFAULT_HEIGHT 44
#define IBX_APPLICATION_BAR_DEFAULT_WIDTH  320

#define IBX_APPLICATION_BAR_BUTTON_HEIGHT    44
#define IBX_APPLICATION_DISPLAY_BUTTON_WIDTH 40

#define IBX_EMPTY_TAG -1

@class IBXApplicationBar;

@protocol IBXApplicationBarDelegate <NSObject>

@required
- (void)barButtonClicked:(NSInteger)buttonTag 
                 withBar:(IBXApplicationBar *)applicationBar;

@optional
- (void)barButtonLongPressed:(NSInteger)buttonTag 
                 withBar:(IBXApplicationBar *)applicationBar;

@end

@interface IBXApplicationBar : UIView

@property (nonatomic, assign) id<IBXApplicationBarDelegate> barDelegate;

- (void)addDisplayButton:(UIImage *)icon withTitle:(NSString *)title withTag:(NSInteger)tag;

- (void)addOptionButton:(IBXOptionButton *)optionButton;
- (void)insertOptionButton:(IBXOptionButton *)optionButton atIndex:(NSUInteger)index;
- (NSUInteger)indexOfOptionButton:(IBXOptionButton *)optionButton;
- (void)removeOptionButton:(IBXOptionButton *)optionButton;
- (NSUInteger)countOfOptionButtons;

- (void)showMessage:(NSString *)message withIcon:(UIImage *)icon withTag:(NSInteger)tag;

@end
