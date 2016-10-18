//
//  ICMacros.h
//  haha
//
//  Created by Lotheve on 15/9/18.
//  Copyright (c) 2015年 Lotheve. All rights reserved.
//

/*!
 *  宏定义头文件
 */

#import "AppDelegate.h"

#ifndef MacroDefinition_h
#define MacroDefinition_h

/** 设备信息 **/
#define DEVICE_NAME [UIDevice currentDevice].name
#define DEVICE_SYSTEM_NAME [UIDevice currentDevice].systemName
#define DEVICE_SYSTEM_VERSION [UIDevice currentDevice].systemVersion.floatValue
#define DEVICE_ISIPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

/** 应用信息 **/
#define APP_DELEGATE (AppDelegate *)([UIApplication sharedApplication].delegate)
#define APP_NAME [[NSBundle mainBundle].infoDictionary objectForKey:@"CFBundleDisplayName"]
#define APP_BUILD_VERSION [[NSBundle mainBundle].infoDictionary objectForKey:@"CFBundleVersion"]
#define APP_VERSION [[NSBundle mainBundle].infoDictionary objectForKey:@"CFBundleShortVersionString"]

/** 系统调试 **/
#ifdef DEBUG
//#define DebugLog(...) NSLog(__VA_ARGS__)
#define DebugLog(format,...)    NSLog(@"{%s,%d}" format, __FUNCTION__,__LINE__,##__VA_ARGS__)
#else
//#define DebugLog(...)
#define DebugLog(format,...)
#endif

//Log对象引用计数值
#if __has_feature(objc_arc)
#define Log_Obj_RetainCount(obj) \
NSLog(@"%@_ref : retainCount = %lu",@#obj,CFGetRetainCount((__bridge CFTypeRef)(obj)))
#else
#define Log_Obj_RetainCount(obj) \
NSLog(@"%@_ref : retainCount = %lu",@#obj,[obj retainCount]);
#endif

/** 尺寸 **/
#define VIEW_FRAME self.view.frame
#define VIEW_WIDTH self.view.frame.size.width
#define VIEW_HEIGHT self.view.frame.size.height

#define SCREEN_BOUNDS [UIScreen mainScreen].bounds
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

/** 颜色 **/
#define ColorHex(rgbValue) \
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define ColorRGB(R,G,B) [UIColor colorWithRed:R/255.0f green:G/255.0f blue:B/255.0f alpha:1.0]
#define ColorRGBA(R,G,B,A) [UIColor colorWithRed:R/255.0f green:G/255.0f blue:B/255.0f alpha:A]


#endif
