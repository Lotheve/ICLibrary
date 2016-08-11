//
//  ICCircleScrollBanner.h
//
//  Created by Lotheve on 15/7/22.
//  Copyright (c) 2015年 Lotheve. All rights reserved.
//

/*!
 1.可无限循环滚动的图片轮播视图，支持点击和滑动
 2.支持block形式回调
 3.支持本地图片和网络图片（基于SDWebImage）
 */

#import <UIKit/UIKit.h>

@class ICCircleScrollBanner;
typedef void(^ICTapScrollViewBlock)(ICCircleScrollBanner *ICScrollVIew ,NSUInteger index);
typedef void(^ICPanScrollViewBlock)(ICCircleScrollBanner *ICScrollVIew ,NSUInteger index);

/*!
 1.可无限循环滚动的图片轮播视图，支持点击和滑动
 2.支持block形式回调
 */

@interface ICCircleScrollBanner : UIView


/**
*  本地图片滚动视图
*
*  @param frame    视图大小
*  @param images   视图的图片
*  @param tapBlock 点击图片，触发事件（不需要惦记时间，设置为nil）
*  @param panBlock   滚动视图更换，触发方法
*
*  @return 返回滚动视图
*/
- (instancetype)initWithFrame:(CGRect)frame contentImages:(NSArray*)images tapBlock:(ICTapScrollViewBlock)tapBlock scrollBlock:(ICPanScrollViewBlock)panBlock;

/**
 *  网络图片滚动视图
 *
 *  @param frame      视图大小
 *  @param imagesURLs 视图的图片URL
 *  @param tapBlock   点击图片，触发事件（不需要的时候，设置为nil）
 *  @param panBlock   滚动视图更换，触发方法
 *
 *  @return 返回滚动视图
 */
- (instancetype)initWithFrame:(CGRect)frame contentImageURLs:(NSArray*)imagesURLs tapBlock:(ICTapScrollViewBlock)tapBlock scrollBlock:(ICPanScrollViewBlock)panBlock;

@end
