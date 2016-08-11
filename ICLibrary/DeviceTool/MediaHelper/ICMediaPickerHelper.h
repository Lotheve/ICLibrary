//
//  ICMediaPickerHelper.h
//
//  Created by Lotheve on 15/7/29.
//  Copyright (c) 2015年 Lotheve. All rights reserved.
//

/*!
 *  媒体获取工具类，支持从相册获取和从摄像头获取照片/视频（要通过摄像头获取请在真机调试）
 */

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ICMeidaPickerType) {
    ICMediaPickerTypePhotoAlbum,    //照片从相册中获取
    ICMediaPickerTypePhotoCamera,   //照片从摄像头中获取
    ICMediaPickerTypeVideoAlbum,    //视频从相册中获取
    ICMediaPickerTypeVideoCamera    //视频从摄像头中获取
};

typedef void(^ICImagePickerDidFinishPickingImageBlock)(UIImagePickerController *pickerController, UIImage *image, UIImage *thumbnail);
typedef void(^ICImagePickerDidFinishPickingVedioBlock)(UIImagePickerController *pickerController, NSURL *mediaUrl, NSString *savePath);

@interface ICMediaPickerHelper : NSObject<UINavigationControllerDelegate, UIImagePickerControllerDelegate>
/**
 *  选择图片完成，触发句柄
 */
@property (strong, nonatomic) ICImagePickerDidFinishPickingImageBlock imagePickerDidFinishPickingBlock;

/**
 *  选择视频成功，触发句柄
 */
@property (strong, nonatomic) ICImagePickerDidFinishPickingVedioBlock vedioPickerDidFinishSuccessBlock;

/**
 *  选择视频失败，触发句柄
 */
@property (strong, nonatomic) ICImagePickerDidFinishPickingVedioBlock vedioPickerDidFinishFFailBlock;

/**
 *  视频存放路径
 */
@property (nonatomic) NSString *savePath;

/**
 *  获取类型
 */
@property (nonatomic) ICMeidaPickerType pikcerModel;

/**
 *  照相单例
 *
 *  @return 返回单例
 */
+ (ICMediaPickerHelper*)shareInstance;

/**
 *  照片获取
 *
 *  @param model          单例类型
 *  @param viewController 显示页面
 *  @param block          选择图片触发句柄
 */
- (void)imagePickerWithMode:(ICMeidaPickerType)model presentViewController:(UIViewController*)viewController didFinishPickBlock:(ICImagePickerDidFinishPickingImageBlock)block;

/**
 *  视频获取
 *
 *  @param model          单例类型
 *  @param path           获取视频存放路径
 *  @param viewController 显示页面
 *  @param successBlock   存放视频成功触发句柄
 *  @param failBlock      存放视频失败触发句柄
 */
- (void)vedioPickerWithMode:(ICMeidaPickerType)model savePath:(NSString*)path presentViewController:(UIViewController*)viewController didSuccessPickBlock:(ICImagePickerDidFinishPickingVedioBlock)successBlock failedBlock:(ICImagePickerDidFinishPickingVedioBlock)failBlock;
@end
