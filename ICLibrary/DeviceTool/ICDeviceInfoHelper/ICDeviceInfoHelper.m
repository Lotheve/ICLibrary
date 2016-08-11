//
//  ICDeviceInfoHelper.m
//
//  Created by Lotheve on 15/7/30.
//  Copyright (c) 2015年 Lotheve. All rights reserved.
//

#import "ICDeviceInfoHelper.h"
#import <UIKit/UIKit.h>

@implementation ICDeviceInfoHelper{
    UIDevice *currentDevice;
}

+ (instancetype)shareInstance{
    static ICDeviceInfoHelper *deviceInfoHelper;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        deviceInfoHelper = [[ICDeviceInfoHelper alloc]init];
    });
    return deviceInfoHelper;
}

- (instancetype)init{
    self = [super init];
    currentDevice = [UIDevice currentDevice];
    return self;
}

- (NSString*)getDeviceName{
    NSString *strName = [currentDevice name];
#ifdef DEBUG
    NSLog(@"设备名称：%@", strName);//e.g. "My iPhone"
#endif
    return strName;
}

- (NSString*)getDeviceSystemVersion{
    NSString *strSystemVersion = [currentDevice systemVersion];
#ifdef DEBUG
    NSLog(@"设备版本：%@", strSystemVersion);/// e.g. @"4.0"
#endif
    return strSystemVersion;
}

- (NSString*)getDeviceSystemName{
    NSString *strSystemName = [currentDevice systemName];
#ifdef DEBUG
    NSLog(@"设备系统名：%@", strSystemName);// e.g. @"iOS"
#endif
    return strSystemName;
}

- (NSString*)getDeviceModel{
    NSString *strModel = [currentDevice model];
#ifdef DEBUG
    NSLog(@"设备型号：%@", strModel);//手机型号
#endif
    return strModel;
}

- (BOOL)isIphone{
    NSString *strSystemName = [currentDevice systemName];

    if ([strSystemName isEqual:@"iPhone OS"]) {
        return YES;
    }else{
        return NO;
    }
}

@end
