//
//  ICDeviceInfoHelper.h
//
//  Created by Lotheve on 15/7/30.
//  Copyright (c) 2015年 Lotheve. All rights reserved.
//

#import <Foundation/Foundation.h>

/*!
 *  获取设备用户名,设备系统名,系统版本,是否IPhone等的工具类
 */
@interface ICDeviceInfoHelper : NSObject

+(instancetype)shareInstance;

/**
 *  设备名
 *
 *  @return 返回设备名
 */
- (NSString*)getDeviceName;

/**
 *  设备版本
 *
 *  @return 返回设备版本号
 */
- (NSString*)getDeviceSystemVersion;

/**
 *  设备系统名
 *
 *  @return 返回设备系统名
 */
- (NSString*)getDeviceSystemName;

/**
 *  设备型号
 *
 *  @return 返回手机型号
 */
- (NSString*)getDeviceModel;

/**
 *  判断是否为Iphone
 *
 *  @return bool
 */
- (BOOL)isIphone;

@end
