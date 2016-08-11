//
//  ICAudioRecorder.h
//  test11
//
//  Created by Lotheve on 15/7/29.
//  Copyright (c) 2015年 Lotheve. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface ICAudioRecorder : NSObject<AVAudioRecorderDelegate>

/**
 *  单例
 *
 *  @return 返回单例
 */
+ (ICAudioRecorder*)shareInstance;

/**
 *  录音设置
 *
 *  @param savePath 录音存放位置
 */
- (void)setRecorderWithSavePath:(NSString*)savePath;

/**
 *  开始录音
 */
- (void)recorderStart;

/**
 *  停止录音
 */
- (void)recorderStop;

/**
 *  暂停录音
 */
- (void)recorderPause;

@end
