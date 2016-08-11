//
//  ICCalendarEventHelper.h
//  ICCalendarHelpe
//
//  Created by Lotheve on 15/7/31.
//  Copyright (c) 2015年 Lotheve. All rights reserved.
//

/**
 * 日历事件工具类
 */

#import <Foundation/Foundation.h>

typedef void(^GetEventsFn)(NSArray *events);


@interface ICCalendarEventHelper : NSObject

/**
 *  事件助手实例
 *
 *  @return 实例
 */
+ (instancetype)shareInstance;

/**
 *  获取日历事件
 *
 *  @param startDate 起始时间
 *  @param endDate   截止时间
 *  @param eventsFn  事件句柄
 */
- (void)getCalendarEventWithStartDate:(NSDate *)startDate
                              EndDate:(NSDate *)endDate
                             EventsFn:(GetEventsFn)eventsFn;

/**
 *  添加事件
 *
 *  @param title       事件标题
 *  @param location    事件定位
 *  @param startDate   事件起始date
 *  @param endDate     事件结束date
 *  @param isAllDay    是否全天事件
 *  @param firstAlarm  首次提醒
 *  @param secondAlarm 第二次提醒
 */
- (void)joinEventWithTitle:(NSString *)title
                  Location:(NSString *)location
                 StartDate:(NSDate *)startDate
                   EndDate:(NSDate *)endDate
                  IsAllDay:(BOOL)isAllDay
                FirstAlarm:(NSTimeInterval)firstAlarm
               SecondAlarm:(NSTimeInterval)secondAlarm;

@end
