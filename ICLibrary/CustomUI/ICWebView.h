//
//  ICWebView.h
//  测试
//
//  Created by Lotheve on 15/7/22.
//  Copyright (c) 2015年 Lotheve. All rights reserved.
//

/**
 *  可根据内容调节高度的webView工具类
 */

#import <UIKit/UIKit.h>

typedef void(^startLoadBlock)(UIWebView *webView);

typedef void(^finishLoadBlock)(UIWebView *webView);

typedef void(^failLoadBlock)(UIWebView *webView, NSError *error);

@interface ICWebView : UIWebView<UIWebViewDelegate>

/**
 *  是否可加载网页
 *
 *  @param isEnable BOOL值
 */
- (void)setLoadEnable:(BOOL)isEnable;

/**
 *  设置最大高度
 *
 *  @param height 高度
 */
- (void)setBoundHeight:(CGFloat)height;

/**
 *  初始化
 *
 *  @param initialFrame 初始框架
 *  @param start        开始加载
 *  @param finish       结束加载
 *  @param fail         加载失败
 */
- (instancetype)initWithFrame:(CGRect)initialFrame
                    startLoad:(startLoadBlock)start
                   finishLoad:(finishLoadBlock)finish
                     failLoad:(failLoadBlock)fail;

@end
