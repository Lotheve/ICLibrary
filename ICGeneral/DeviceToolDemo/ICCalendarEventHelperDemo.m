//
//  ICCalendarEventHelperDemo.m
//  ICGeneral
//
//  Created by Lotheve on 15/8/3.
//  Copyright (c) 2015年 Lotheve. All rights reserved.
//

#import "ICCalendarEventHelperDemo.h"
#import "ICCalendarEventHelper.h"
#import <EventKit/EventKit.h>

@interface ICCalendarEventHelperDemo ()

@end

@implementation ICCalendarEventHelperDemo

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *getButton = [[UIButton alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
    getButton.backgroundColor = [UIColor greenColor];
    [getButton setTitle:@"获取日历" forState:UIControlStateNormal];
    [getButton addTarget:self action:@selector(getEvent) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:getButton];
    
    
    UIButton *setButton = [[UIButton alloc]initWithFrame:CGRectMake(100, 250, 100, 100)];
    setButton.backgroundColor = [UIColor greenColor];
    [setButton setTitle:@"添加事件" forState:UIControlStateNormal];
    [setButton addTarget:self action:@selector(joinEvent) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:setButton];
}

- (void)getEvent{
    
    //获取当前日历
    
    NSString *startDateString = @"2015-08-1 00:00";
    NSString *endDateString = @"2015-09-1 00:00";
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSDate *startDate = [dateFormatter dateFromString:startDateString];
    NSDate *endDate = [dateFormatter dateFromString:endDateString];
    
    [[ICCalendarEventHelper shareInstance] getCalendarEventWithStartDate:startDate EndDate:endDate EventsFn:^(NSArray *events) {
        for (EKEvent *event in events) {
            NSLog(@"%@",event.title);
            NSLog(@"%@",event.startDate);
            NSLog(@"%@",event.endDate);
            NSLog(@"================================================");
        }
    }];
}

- (void)joinEvent{
    
    NSString *startDateString = @"2015-08-06 05:00";
    NSString *endDateString = @"2015-08-07 20:00";
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSDate *startDate = [dateFormatter dateFromString:startDateString];
    NSDate *endDate = [dateFormatter dateFromString:endDateString];
    
    [[ICCalendarEventHelper shareInstance] joinEventWithTitle:@"测试测试" Location:@"TTTTTT" StartDate:startDate EndDate:endDate IsAllDay:NO FirstAlarm:-60*60 SecondAlarm:-60*30];
}
@end
