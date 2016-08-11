//
//  ICCalendarEventHelper.m
//  ICCalendarHelpe
//
//  Created by Lotheve on 15/7/31.
//  Copyright (c) 2015年 Lotheve. All rights reserved.
//

#import "ICCalendarEventHelper.h"
#import <EventKit/EventKit.h>
#import <UIKit/UIKit.h>

@implementation ICCalendarEventHelper

+ (instancetype)shareInstance{
    static ICCalendarEventHelper *helper = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        helper = [[ICCalendarEventHelper alloc]init];
    });
    return helper;
}

- (void)getCalendarEventWithStartDate:(NSDate *)startDate
                              EndDate:(NSDate *)endDate
                             EventsFn:(GetEventsFn)eventsFn{
    //创建事件市场
    EKEventStore *eventStore = [[EKEventStore alloc]init];
    
    [eventStore requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error) {
        if (error) {
            // 获取失败
            NSString *str = [NSString stringWithFormat:@"获取事件失败,失败原因:%@",error.description];
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle:@"提示！"
                                  message:str
                                  delegate:nil
                                  cancelButtonTitle:@"OKay!"
                                  otherButtonTitles:nil];
            [alert show];
        }
        else if (!granted){
            //被用户拒绝，不允许访问日历
            NSString *str = @"拒绝访问";
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle:@"提示！"
                                  message:str
                                  delegate:nil
                                  cancelButtonTitle:@"Okay!"
                                  otherButtonTitles:nil];
            [alert show];
        }
        else{
            NSPredicate *predicate = [eventStore predicateForEventsWithStartDate:startDate endDate:endDate calendars:nil];
            NSArray *events = [eventStore eventsMatchingPredicate:predicate];
            eventsFn(events);
        }
    }];
}

- (void)joinEventWithTitle:(NSString *)title
                  Location:(NSString *)location
                 StartDate:(NSDate *)startDate
                   EndDate:(NSDate *)endDate
                  IsAllDay:(BOOL)isAllDay
                FirstAlarm:(NSTimeInterval)firstAlarm
               SecondAlarm:(NSTimeInterval)secondAlarm{
    //创建事件市场
    EKEventStore *eventStore = [[EKEventStore alloc]init];
    [eventStore requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (error)
            {
                // 获取失败
                NSString *str = [NSString stringWithFormat:@"获取事件失败,失败原因:%@",error.description];
                UIAlertView *alert = [[UIAlertView alloc]
                                      initWithTitle:@"提示！"
                                      message:str
                                      delegate:nil
                                      cancelButtonTitle:@"OKay!"
                                      otherButtonTitles:nil];
                [alert show];
            }
            else if (!granted)
            {
                //被用户拒绝，不允许访问日历
                NSString *str = @"拒绝访问";
                UIAlertView *alert = [[UIAlertView alloc]
                                      initWithTitle:@"提示！"
                                      message:str
                                      delegate:nil
                                      cancelButtonTitle:@"Okay!"
                                      otherButtonTitles:nil];
                [alert show];
            }
            else
            {
                //事件保存到日历
                
                //创建事件
                EKEvent *event  = [EKEvent eventWithEventStore:eventStore];
                event.title     = title;
                event.location = location;
                event.allDay = isAllDay;
                event.startDate = startDate;
                event.endDate   = endDate;
                
                //添加提醒
                //                [event addAlarm:[EKAlarm alarmWithRelativeOffset:60.0f * -60.0f * 24]];
                //                [event addAlarm:[EKAlarm alarmWithRelativeOffset:60.0f * -15.0f]];
                [event addAlarm:[EKAlarm alarmWithRelativeOffset:firstAlarm]];
                [event addAlarm:[EKAlarm alarmWithRelativeOffset:secondAlarm]];
                
                [event setCalendar:[eventStore defaultCalendarForNewEvents]];
                NSError *err;
                [eventStore saveEvent:event span:EKSpanThisEvent error:&err];
                
                UIAlertView *alert = [[UIAlertView alloc]
                                      initWithTitle:@"日历"
                                      message:@"事件添加成功"
                                      delegate:nil
                                      cancelButtonTitle:@"Okay!"
                                      otherButtonTitles:nil];
                [alert show];
            }
        });
    }];
}

@end
