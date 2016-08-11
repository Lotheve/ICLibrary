//
//  ICLabel.h
//  ICGeneral
//
//  Created by Lotheve on 15/7/20.
//  Copyright (c) 2015年 Lotheve. All rights reserved.
//

/*!
 1. 可指定range设置文本删除线的Label
 2. 可指定range设置文本颜色的Label
 3. 可指定range设置文本字体的Label
 */

#import <UIKit/UIKit.h>

@interface NSArray (ICLabel)
/**
 *  获取NSRange类数组
 *
 *  @param firstObject NSRange中的location和length
 *
 *  @return 返回NSRange类数组（如果参数不完整，为单数，则返回null）
 */
+ (instancetype)rangeArrayWithLocationAndLength:(id)firstObject, ... NS_REQUIRES_NIL_TERMINATION;
@end


@interface ICLabel : UILabel

/**
 *  将label中指定位置的String，转化为带删除线的String
 *
 *  @param ranges 带删除线的String的range（通过rangeArrayWithLocationAndLength：类方法获取）
 */
- (void)setDeleteLineInRanges:(NSArray*)ranges;

/**
 *  将label中指定位置的String，转化为font字体
 *
 *  @param font   字体
 *  @param ranges font字体的位置（通过rangeArrayWithLocationAndLength：类方法获取）
 */
- (void)setFont:(UIFont*)font inRanges:(NSArray*)ranges;

/**
 *  将label中指定位置的String，转化为color颜色
 *
 *  @param color  颜色
 *  @param ranges color颜色的位置（通过rangeArrayWithLocationAndLength：类方法获取）
 */
- (void)setColor:(UIColor*)color inRanges:(NSArray*)ranges;

@end
