//
//  UIAlertView+Additions.h
//  ICGeneral
//
//  Created by Lotheve on 15/7/22.
//  Copyright (c) 2015年 Lotheve. All rights reserved.
//

/*!
 *  支持Block模式的UIAlertView扩展类
 */

#import <UIKit/UIKit.h>

typedef void(^CancelBlock)();
typedef void(^OtherButtonBlock)(NSInteger index);

@interface UIAlertView (Additions)<UIAlertViewDelegate>

/**
 *  快速创建alert
 *
 *  @param title   标题
 *  @param message 内容
 *
 *  @return alert实例
 */
+ (UIAlertView *)alertViewWithTitle:(NSString *)title message:(NSString *)message;

/**
 *  快速创建alert
 *
 *  @param title             标题
 *  @param message           内容
 *  @param cancelButtonTitle 取消按钮句柄
 *
 *  @return alert实例
 */
+ (UIAlertView *)alertViewWithTitle:(NSString *)title
                   message:(NSString *)message
           cancelButtonTitle:(NSString *)cancelButtonTitle;

/**
 *  快速创建alert
 *
 *  @param title             标题
 *  @param message           内同
 *  @param cancelButtonTitle 取消按钮标题
 *  @param otherButtonTitles 其他按钮标题组
 *  @param cancelBlock       取消按钮句柄
 *  @param otherButtonBlck   其他按钮句柄
 *
 *  @return alert实例
 */
+ (UIAlertView *)alertViewWithTitle:(NSString *)title
                   message:(NSString *)message
         cancelButtonTitle:(NSString *)cancelButtonTitle
          otherButtonTitle:(NSArray *)otherButtonTitles
         cancelButtonBlock:(CancelBlock)cancelBlock
          otherButtonBlock:(OtherButtonBlock)otherButtonBlck;

@property (nonatomic) CancelBlock cancelBlock;
@property (nonatomic) OtherButtonBlock otherButtonBlock;

@end
