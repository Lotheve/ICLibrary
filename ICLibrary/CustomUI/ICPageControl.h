//
//  ICPageControl.h
//
//  Created by Lotheve on 15/7/21.
//  Copyright (c) 2015年 Lotheve. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ICPageControl : UIPageControl

/**
 *  设置选中和非选中时点颜色
 *
 *  @param pageIndicatorTintColor        非选中颜色
 *  @param currentPageIndicatorTintColor 选中颜色
 */
- (void)setPageControlWithPageIndicatorTintColor:(UIColor*)pageIndicatorTintColor
                   currentPageIndicatorTintColor:(UIColor*)currentPageIndicatorTintColor;

/**
 *  设置PageControl中点的大小，点之间的间距。
 *
 *  @param diameter 点的直径
 *  @param distance 点之间距离
 */
- (void)setPageControlDotsDiameter:(CGFloat)diameter dotsDistance:(CGFloat)distance;
@end