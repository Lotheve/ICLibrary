//
//  UIButton+Additions.h
//  ICGeneral
//
//  Created by Lotheve on 15/7/28.
//  Copyright (c) 2015年 Lotheve. All rights reserved.
//

/**
 *  调整按钮文本与图片对其方式的UIButton扩展类
 */

#import <UIKit/UIKit.h>

@interface UIButton (Additions)

/**
 *  图片在上 标题在下
 */
- (void)alignImageAboveTitle;

/*!
 *  图片在右 标题在左
 */
- (void)alignImageRightTitle;

@end
