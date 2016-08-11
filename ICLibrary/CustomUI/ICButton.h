//
//  ICButton.h
//
//  Created by Lotheve on 15/7/20.
//  Copyright (c) 2015年 Lotheve. All rights reserved.
//

/*!
 1）	图片和文字同时存在的Button,可随意改变图片和文字的位置。
 2）	常用的自定义圆角边界按钮等。
 */

#import <UIKit/UIKit.h>

//按钮类型
typedef enum {
    ICButtonTypeDefault = 0,
    ICButtonTypeRect,
    ICButtonTypeRoundedRect,
}ICButtonType;

@interface ICButton : UIButton

/**
 *  设置title并指定区域
 *
 *  @param title     标题
 *  @param titleRect 区域
 */
- (void)setTitle:(NSString *)title withTitleRect:(CGRect)titleRect;

/**
 *  设置图片并指定区域
 *
 *  @param image     图片
 *  @param imageRect 区域
 */
- (void)setImage:(UIImage *)image withImageRect:(CGRect)imageRect;

/**
 *  设置常规和高亮时的图片
 *
 *  @param normalImage    常规图片
 *  @param highlightImage 高亮图片
 */
- (void)setNormalImage:(UIImage *)normalImage withHighlightImage:(UIImage *)highlightImage;

/**
 *  设置常规标题颜色和高亮标题颜色
 *
 *  @param normalColor    常规颜色
 *  @param highlightColor 高亮颜色
 */
- (void)setNormalTitleColor:(UIColor *)normalColor withHighlightColor:(UIColor *)highlightColor;

/**
 *  设置常规标题和选中标题
 *
 *  @param normalTitle   常规标题
 *  @param selectecTitle 选中标题
 */
- (void)setNormalTitle:(NSString *)normalTitle withSelectedTitle:(NSString *)selectecTitle;

/**
 *  设置button类型
 *
 *  @param type 类型
 */
- (void)setButtonType:(ICButtonType)type;

@end
