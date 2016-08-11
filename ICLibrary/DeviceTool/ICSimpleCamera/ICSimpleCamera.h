//
//  ICSimpleCamera.h
//  ICSimpleCamera
//
//  Created by Lotheve on 15/7/29.
//  Copyright (c) 2015年 Lotheve. All rights reserved.
//

/**
 自定义相机拍照
 */

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

typedef enum : NSInteger{
    ICCameraPositionFront,
    ICCameraPositionBack,
}ICCameraPosition;

typedef enum :NSInteger{
    ICCameraFlashOff,
    ICCameraFlashOn
}ICCameraFlash;

typedef enum : NSInteger{
    ICCameraQualityHigh,
    ICCameraQualityMedium,
    ICCameraQualityLow,
    ICCameraQualityPhoto
}ICCameraQuality;

@protocol ICSimpleCameraDelegate;

@interface ICSimpleCamera : UIViewController

/**
 *  照片质量
 */
@property (nonatomic) ICCameraQuality cameraQuality;

/**
 *  闪光灯状态
 */
@property (nonatomic) ICCameraFlash cameraFlash;

/**
 *  摄像头（前后）
 */
@property (nonatomic) ICCameraPosition cameraPosition;

@property (nonatomic) id<ICSimpleCameraDelegate> delegate;

/**
 *  相机开始工作
 */
- (void)start;

/**
 *  按下快门拍照
 */
- (void)capture;

/**
 *  相机停止工作
 */
- (void)stop;

/**
 *  通过画质初始化
 */
- (instancetype)initWithQuality:(ICCameraQuality)quality;

/**
 *  固定在某个视图控制器上，并设置代理
 */
- (void)attachToViewController:(UIViewController *)vc withDelegate:(id<ICSimpleCameraDelegate>)delegate;

/**
 *  闪光灯开关
 */
- (void)toggleCameraFlash;

/**
 *  选择摄像头
 */
- (void)togglCameraPosition;

@end

@protocol ICSimpleCameraDelegate <NSObject>

- (void)cameraViewController:(ICSimpleCamera *)camera didCapturePhoto:(UIImage *)image;

@end
