//
//  ICCommunicationHelper.h
//
//  Created by Lotheve on 15/7/30.
//  Copyright (c) 2015年 Lotheve. All rights reserved.
//

/**
 *  通信工具类（拨号/短信/邮件）
 */
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

typedef void(^SuccessFn)(void);
typedef void(^FailFn)(void);
typedef void(^CancelFn)(void);

@interface ICCommunicationHelper : NSObject

/**
 *  通信工具单例
 *
 *  @return 通信工具
 */
+ (ICCommunicationHelper *)shareInstance;

/**
 *  拨号
 *
 *  @param tel 号码
 */
- (void)dialWithTel:(NSString *)tel;

/**
 *  发送短信
 *
 *  @param controller  视图控制器
 *  @param recipients  收件人（数组类型，支持群发）
 *  @param mesBody     消息内容
 *  @param successFn   发送成功
 *  @param failFn      发送失败
 *  @param cancelFn    取消发送
 */
- (void)sendMessageWithViewController:(UIViewController *)sender
                           Recipients:(NSArray *)recipients
                              MesBody:(NSString *)mesBody
                            SuccessFn:(SuccessFn)successFn
                               FailFn:(FailFn)failFn
                             CancelFn:(CancelFn)cancelFn;

/**
 *  发送邮件
 *
 *  @param sender     视图控制器
 *  @param recipients 接收人（数组类型，支持群发）
 *  @param subject    主题
 *  @param mailBody   邮件内容
 *  @param isHTML     内容是否为HTML格式
 *  @param successFn  发送成功
 *  @param failFn     发送失败
 *  @param cancelFn   取消发送
 */
- (void)sendMailWithViewController:(UIViewController *)sender
                        Recipients:(NSArray *)recipients
                           Subject:(NSString *)subject
                          MailBody:(NSString *)mailBody
                            IsHTML:(BOOL)isHTML
                         SuccessFn:(SuccessFn)successFn
                            FailFn:(FailFn)failFn
                          CancelFn:(CancelFn)cancelFn;

@end
