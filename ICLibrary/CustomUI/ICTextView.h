//
//  ICTextView.h
//  test
//
//  Created by Lotheve on 15/7/21.
//  Copyright (c) 2015年 Lotheve. All rights reserved.
//

/*!
 *  支持设置占位符的TextView
 */

#import <UIKit/UIKit.h>

@interface ICTextView : UITextView

/**
 *  设置占位符
 *
 *  @param placeholder 占位符文本
 */
- (void)setPlaceHolder:(NSString*)placeholder;

@end
