//
//  UIButton+HitRect.h
//  ICGeneral
//
//  Created by 卢旭峰 on 16/8/29.
//  Copyright © 2016年 Lotheve. All rights reserved.
//

/*!
 *  支持调整点击范围的UIButton扩展类
 */

#import <UIKit/UIKit.h>

@interface UIButton (HitRect)

/**
 *  增加按钮的点击范围
 *
 *  @param top    顶部增加距离
 *  @param right  右部增加距离
 *  @param bottom 底部增加距离
 *  @param left   左部增加距离
 */
- (void)setEnlargeEdgeWithTop:(CGFloat) top right:(CGFloat) right bottom:(CGFloat) bottom left:(CGFloat) left;

@end
