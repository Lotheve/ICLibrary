//
//  ICTextField.h
//  ICGeneral
//
//  Created by Lotheve on 15/7/20.
//  Copyright (c) 2015年 Lotheve. All rights reserved.
//

/*!
 1）	使用自定义颜色大小的默认提示文字。
 2）	可方便改变文字离左右边界的间距。
 3）	可方便设置TextField左右自定义视图。
 */

#import <UIKit/UIKit.h>

@interface ICTextField : UITextField

/**
 *  自定义颜色大小的默认提示文字
 *
 *  @param placeholder 默认提示文字
 *  @param color       文字颜色
 *  @param font        文字字体
 */
- (void)setPlaceholder:(NSString *)placeholder withColor:(UIColor*)color Font:(UIFont*)font;

/**
 *  改变文字离左边界的间距
 *
 *  @param rightSpace 文字距右边界的间距
 */
- (void)setTextFieldRectWithLeftSpace:(CGFloat)leftSpace;

/**
 *  改变文字离左边界的间距
 *
 *  @param rightSpace 文字距左边界的间距（系统默认空出10个像素点，如果要设置向右的位置，请设置负数）
 */
- (void)setTextFieldRectWithRightSpace:(CGFloat)rightSpace;

/**
 *  自定义TextField的左视图
 *
 *  @param leftView          左视图
 *  @param frame             在textField中的位置
 */
- (void)setLeftView:(UIView *)leftView rectForBounds:(CGRect)frame;

/**
 *  自定义TextField的右视图
 *
 *  @param rightView         右视图
 *  @param frame             在textField中的位置
 */
- (void)setRightView:(UIView *)rightView rectForBounds:(CGRect)frame;

@end
