//
//  IBXApplicationBar.m
//  ApplicationBar
//
//  Created by InstBox.com on 4/7/12.
//  Copyright (c) 2012 VNT. All rights reserved.
//

#import "IBXApplicationBar.h"

#define DEFAULT_PADDING    10
#define HIDE_BUTTON_HEIGHT 480
#define DEFAULT_DURATION   0.2
#define HIDE_BUTTON_ALPHA  0.3

@interface IBXApplicationBar ()
{
    id<IBXApplicationBarDelegate> _barDelegate;
    
    NSMutableArray * _displayButtons;
    NSMutableArray * _optionButtons;
    
    UIButton * _optionButton;
    UIButton * _hideButton;
    UIButton * _messageButton;
    
    UIView * _contentView;
}

@end

@implementation IBXApplicationBar

@synthesize barDelegate = _barDelegate;

- (void)dealloc
{
    _barDelegate = nil;
    
    [_contentView release];
    [_displayButtons release];
    [_optionButtons release];
    [_optionButton release];
    [_hideButton release];
    [_messageButton release];
    
    [super dealloc];
}

- (id)init
{
    self = [super init];
    if (self) {
        
        _contentView = [[UIView alloc] init];
        _contentView.backgroundColor = [UIColor blackColor];
        [self addSubview:_contentView];

        _displayButtons = [[NSMutableArray alloc] init];
        _optionButtons = [[NSMutableArray alloc] init];
        
        _optionButton = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
        _optionButton.titleLabel.textColor = [UIColor whiteColor];
        _optionButton.hidden = YES;
        _optionButton.showsTouchWhenHighlighted = YES;
        [_optionButton addTarget:self 
                          action:@selector(toggleView)
                forControlEvents:UIControlEventTouchUpInside];
        [_optionButton setTitle:@"..." forState:UIControlStateNormal];
        [_contentView addSubview:_optionButton];
        
        _hideButton = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
        _hideButton.frame = CGRectZero;
        [_hideButton addTarget:self 
                        action:@selector(toggleView) 
              forControlEvents:UIControlEventTouchUpInside];
        _hideButton.backgroundColor = [UIColor blackColor];
        _hideButton.alpha = 0;
        [self addSubview:_hideButton];
        [self sendSubviewToBack:_hideButton];
        
        UISwipeGestureRecognizer * gestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self 
                                                                                                 action:@selector(swipeDetected:)];
        gestureRecognizer.direction = UISwipeGestureRecognizerDirectionDown;
        [self addGestureRecognizer:gestureRecognizer];
        [gestureRecognizer release];
        
        gestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeDetected:)];
        gestureRecognizer.direction = UISwipeGestureRecognizerDirectionUp;
        [self addGestureRecognizer:gestureRecognizer];
        [gestureRecognizer release];
        
        self.userInteractionEnabled = YES;
    }
    
    return self;
}

#pragma mark - gestureRecognizer

- (void)swipeDetected:(UISwipeGestureRecognizer *)recoginzer
{
    if (recoginzer.direction == UISwipeGestureRecognizerDirectionDown && ![self minState]) {
        [self toggleView];
    }
    else if (recoginzer.direction == UISwipeGestureRecognizerDirectionUp && [self minState]) {
        [self toggleView];
    }
}

#pragma mark - other

- (CGFloat)heightForOptionButtons
{
    CGFloat height = 0;
    for (UIButton * button in _optionButtons) {
        height += button.frame.size.height;
    }
    
    return height;
}

- (BOOL)minState
{
    return (self.frame.size.height == IBX_APPLICATION_BAR_DEFAULT_HEIGHT);
}

- (void)showView
{
    for (IBXOptionButton * optionButton in _optionButtons) {
        [optionButton updateTitle];
    }
    
    
    [UIView animateWithDuration:DEFAULT_DURATION animations:^(void) {
        CGRect frame = self.frame;
        frame.size.height = IBX_APPLICATION_BAR_DEFAULT_HEIGHT + [self heightForOptionButtons] + HIDE_BUTTON_HEIGHT;
        frame.origin.y -= [self heightForOptionButtons] + HIDE_BUTTON_HEIGHT;
        self.frame = frame;
            
        frame = _contentView.frame;
        frame.size.height = IBX_APPLICATION_BAR_DEFAULT_HEIGHT + [self heightForOptionButtons];
        frame.origin.y += HIDE_BUTTON_HEIGHT;
        _contentView.frame = frame;
        _contentView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:[_optionButtons count] > 2 ? 0.9 : 1];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:DEFAULT_DURATION animations:^{
            _hideButton.alpha = HIDE_BUTTON_ALPHA;
        }];
    }];
}
     

- (void)hideView
{
    [UIView animateWithDuration:DEFAULT_DURATION animations:^{
        _hideButton.alpha = 0;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:DEFAULT_DURATION animations:^(void) {
            CGRect frame = self.frame;
            frame.size.height = IBX_APPLICATION_BAR_DEFAULT_HEIGHT;
            frame.origin.y += [self heightForOptionButtons] + HIDE_BUTTON_HEIGHT;
            self.frame = frame;
            
            frame = _contentView.frame;
            frame.size.height = IBX_APPLICATION_BAR_DEFAULT_HEIGHT + [self heightForOptionButtons];
            frame.origin.y -= HIDE_BUTTON_HEIGHT;
            _contentView.backgroundColor = [UIColor blackColor];
            _contentView.frame = frame;
        }];
    }];
}

- (void)toggleView
{    
    for (UIButton * displayButton in _displayButtons) {
        displayButton.enabled = ![self minState];
    } 
    
    if ([self minState]) {
        [self showView];
    }
    else {
        [self hideView];
    }
}

- (void)responseButtonTag:(id)sender
{
    if (![sender isKindOfClass:[UIButton class]]) return;
    
    if (_barDelegate 
        && [_barDelegate respondsToSelector:@selector(barButtonClicked:withBar:)]) {
        UIButton * button = sender;
        [_barDelegate barButtonClicked:button.tag withBar:self];
    }
}

- (void)displayButtonClicked:(id)sender
{
    [self responseButtonTag:sender];
}

- (void)displayButtonLongPressed:(UILongPressGestureRecognizer *)recoginzer
{
    if (recoginzer.state == UIGestureRecognizerStateBegan) {
        if ([recoginzer.view isKindOfClass:[UIButton class]]
            && [_barDelegate respondsToSelector:@selector(barButtonLongPressed:withBar:)]) {
            UIButton * sender = (UIButton *)recoginzer.view;
            [_barDelegate barButtonLongPressed:sender.tag withBar:self];
        }
    }
}

- (void)optionButtonClicked:(id)sender
{
    [self responseButtonTag:sender];
    
    [self toggleView];
}

#pragma mark - message button

- (void)hideMessageButton
{
    [UIView animateWithDuration:DEFAULT_DURATION animations:^{
        _messageButton.frame = CGRectMake(DEFAULT_DURATION, IBX_APPLICATION_BAR_DEFAULT_HEIGHT, _messageButton.frame.size.width, _messageButton.frame.size.height) ;
        _messageButton.alpha = 0;
    }];
}

- (void)messageButtonClicked
{
    [self responseButtonTag:_messageButton];
}

#pragma mark - public

- (void)showMessage:(NSString *)message withIcon:(UIImage *)icon withTag:(NSInteger)tag
{
    if (_messageButton == nil) {
        _messageButton = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
        [_contentView addSubview:_messageButton];
    }
    
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(hideMessageButton) object:nil];
    
    _messageButton.alpha = 0;
    [_messageButton setTitle:message forState:UIControlStateNormal];
    [_messageButton setImage:icon forState:UIControlStateNormal];
    [_messageButton sizeToFit];
    [_messageButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_messageButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];

    if (icon != nil) { 
        [_messageButton setTitleEdgeInsets:UIEdgeInsetsMake(0, DEFAULT_PADDING, 0, 0)];
        _messageButton.frame = CGRectMake(_messageButton.frame.origin.x, _messageButton.frame.origin.y, _messageButton.frame.size.width + DEFAULT_PADDING, _messageButton.frame.size.height);
    }
    _messageButton.tag = tag;
    _messageButton.frame = CGRectMake(DEFAULT_PADDING, IBX_APPLICATION_BAR_DEFAULT_HEIGHT, _messageButton.frame.size.width, IBX_APPLICATION_BAR_DEFAULT_HEIGHT);
    [_messageButton addTarget:self action:@selector(messageButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [UIView animateWithDuration:DEFAULT_DURATION animations:^{
        _messageButton.alpha = 1;
        _messageButton.frame = CGRectMake(DEFAULT_PADDING, 0, _messageButton.frame.size.width, _messageButton.frame.size.height);
    }];
    
    [self performSelector:@selector(hideMessageButton) withObject:nil afterDelay:3];
    
}

- (void)addDisplayButton:(UIImage *)icon 
               withTitle:(NSString *)title
                 withTag:(NSInteger)tag
{
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.tag = tag;
    button.frame = CGRectMake(0, 0, IBX_APPLICATION_BAR_DEFAULT_HEIGHT, 
                              IBX_APPLICATION_DISPLAY_BUTTON_WIDTH);
    button.titleLabel.textColor = [UIColor whiteColor];
    button.showsTouchWhenHighlighted = YES;
    [button setImage:icon forState:UIControlStateNormal];
    [button addTarget:self 
               action:@selector(displayButtonClicked:)
     forControlEvents:UIControlEventTouchUpInside];
    UILongPressGestureRecognizer * longRecognzier = [[UILongPressGestureRecognizer alloc] initWithTarget:self 
                                                                                                  action:@selector(displayButtonLongPressed:)];
    [button addGestureRecognizer:longRecognzier];
    [longRecognzier release];
    [_displayButtons addObject:button];
    [_contentView addSubview:button];
}

#pragma mark - option button

- (void)addOptionButton:(NSString *)title 
                withTag:(NSInteger)tag
{
    [self addOptionButton:title withIcon:nil withTag:tag];
}

- (void)addOptionButton:(NSString *)title withIcon:(UIImage *)image withTag:(NSInteger)tag
{
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.tag = tag;
    [button setTitle:title forState:UIControlStateNormal];
   
   [self addOptionButtonToUI:button];
}   

- (void)addOptionButtonToUI:(UIButton *)button
{
    CGFloat height = [self heightForOptionButtons] + IBX_APPLICATION_BAR_DEFAULT_HEIGHT;
    
    button.frame = CGRectMake(DEFAULT_PADDING, height,
                              self.frame.size.width - 5 * DEFAULT_PADDING, 
                              IBX_APPLICATION_BAR_BUTTON_HEIGHT);
    [button addTarget:self 
               action:@selector(optionButtonClicked:) 
     forControlEvents:UIControlEventTouchUpInside];
    
    
    [_optionButtons addObject:button];
    [_contentView addSubview:button];
    
    _optionButton.hidden = ([_optionButtons count] == 0);    
}

- (void)addOptionButton:(IBXOptionButton *)optionButton
{
    [self addOptionButtonToUI:optionButton];
}

- (void)insertOptionButton:(IBXOptionButton *)optionButton atIndex:(NSUInteger)index
{
    [_optionButtons insertObject:optionButton atIndex:index];
}

- (NSUInteger)indexOfOptionButton:(IBXOptionButton *)optionButton
{
    return [_optionButtons indexOfObject:optionButton];
}

- (void)removeOptionButton:(IBXOptionButton *)optionButton
{
    [_optionButtons removeObject:optionButton];
}

- (NSUInteger)countOfOptionButtons
{
    return [_optionButtons count];
}

#pragma - UIView

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    _optionButton.frame = CGRectMake(self.frame.size.width - IBX_APPLICATION_BAR_DEFAULT_HEIGHT, 
                                     0, 
                                     IBX_APPLICATION_BAR_DEFAULT_HEIGHT, 
                                     IBX_APPLICATION_BAR_DEFAULT_HEIGHT);
        
    CGFloat totalWidth = [_displayButtons count] * IBX_APPLICATION_DISPLAY_BUTTON_WIDTH;
    CGFloat startX = (self.frame.size.width - totalWidth) / 2.0;
    for (UIButton * button in _displayButtons) {
        button.frame = CGRectMake(startX, button.frame.origin.y,
                                  IBX_APPLICATION_DISPLAY_BUTTON_WIDTH,
                                  IBX_APPLICATION_BAR_DEFAULT_HEIGHT);
        startX += IBX_APPLICATION_DISPLAY_BUTTON_WIDTH;
    }
    
    _hideButton.frame = CGRectMake(0, 0, self.frame.size.width, HIDE_BUTTON_HEIGHT);
}

- (void)sizeToFit
{
    [super sizeToFit];
    
    CGRect frame = _contentView.frame;
    frame.size.width = IBX_APPLICATION_BAR_DEFAULT_WIDTH;
    frame.size.height = IBX_APPLICATION_BAR_DEFAULT_HEIGHT;
    _contentView.frame = frame;
    self.frame = _contentView.frame;
}

@end
