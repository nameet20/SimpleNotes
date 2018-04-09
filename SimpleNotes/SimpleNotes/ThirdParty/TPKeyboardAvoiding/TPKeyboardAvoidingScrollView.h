//
//  TPKeyboardAvoidingScrollView.h
//  TPKeyboardAvoiding
//
//  Created by Michael Tyson on 30/09/2013.
//  Copyright 2015 A Tasty Pixel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIScrollView+TPKeyboardAvoidingAdditions.h"
/*
 While adding this class to scroll view, check for the following things:
 1. Module textfield should be none.
 2. Inherit Module from target should be unchecked.
 */
@interface TPKeyboardAvoidingScrollView : UIScrollView <UITextFieldDelegate, UITextViewDelegate>
- (void)contentSizeToFit;
- (BOOL)focusNextTextField;
- (void)scrollToActiveTextField;
@end
