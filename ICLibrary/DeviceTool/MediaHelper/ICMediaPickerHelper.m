//
//  ICMediaPickerHelper.m
//
//  Created by Lotheve on 15/7/29.
//  Copyright (c) 2015年 Lotheve. All rights reserved.
//

#import "ICMediaPickerHelper.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <AVFoundation/AVFoundation.h>
#import "UIAlertView+Additions.h"


@implementation ICMediaPickerHelper{
    UIImagePickerController *imgPickView;
}

+ (ICMediaPickerHelper*)shareInstance{
    static ICMediaPickerHelper *imgPickerController = nil;
    static dispatch_once_t onceTokenPickerController;
    dispatch_once(&onceTokenPickerController, ^{
        imgPickerController = [[ICMediaPickerHelper alloc] init];
    });
    return imgPickerController;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        imgPickView = [[UIImagePickerController alloc]init];
    }
    return self;
}

- (void)imagePickerWithMode:(ICMeidaPickerType)model presentViewController:(UIViewController*)viewController didFinishPickBlock:(ICImagePickerDidFinishPickingImageBlock)block{
    if (model==ICMediaPickerTypePhotoAlbum) {
        if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
            [UIAlertView alertViewWithTitle:@"错误" message:@"对不起，您的设备不支持此功能" cancelButtonTitle:@"好的"];
        }else{
            imgPickView.delegate = self;
            imgPickView.allowsEditing = YES;
            imgPickView.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            imgPickView.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
            NSArray *availabelMedia = [UIImagePickerController availableMediaTypesForSourceType:imgPickView.sourceType];
            imgPickView.mediaTypes = [NSArray arrayWithObject:availabelMedia[0]];//只支持照片
            self.imagePickerDidFinishPickingBlock = block;
            self.pikcerModel = model;
            ALAuthorizationStatus author = [ALAssetsLibrary authorizationStatus];
            if (author == ALAuthorizationStatusAuthorized || author == ALAuthorizationStatusNotDetermined) {
                [viewController presentViewController:imgPickView animated:YES completion:nil];
            }
        }
    }else if(model==ICMediaPickerTypePhotoCamera){
        if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            [UIAlertView alertViewWithTitle:@"错误" message:@"对不起，您的设备不支持此功能" cancelButtonTitle:@"好的"];
        }else{
            imgPickView.delegate = self;
            imgPickView.sourceType = UIImagePickerControllerSourceTypeCamera;
            imgPickView.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
            //是否允许编辑图片
            imgPickView.allowsEditing = YES;
            NSArray *availabelMedia = [UIImagePickerController availableMediaTypesForSourceType:imgPickView.sourceType];
            imgPickView.mediaTypes = [NSArray arrayWithObject:availabelMedia[0]];//只支持照片
            self.imagePickerDidFinishPickingBlock = block;
            self.pikcerModel = model;
            AVAuthorizationStatus author = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
            if (author == ALAuthorizationStatusAuthorized || author == ALAuthorizationStatusNotDetermined) {
                [viewController presentViewController:imgPickView animated:YES completion:nil];
            }
        }
    }
}

- (void)vedioPickerWithMode:(ICMeidaPickerType)model savePath:(NSString*)path presentViewController:(UIViewController*)viewController didSuccessPickBlock:(ICImagePickerDidFinishPickingVedioBlock)successBlock failedBlock:(ICImagePickerDidFinishPickingVedioBlock)failBlock{
    if (model == ICMediaPickerTypeVideoAlbum) {
        if (![UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypePhotoLibrary]) {
            [UIAlertView alertViewWithTitle:@"错误" message:@"对不起，您的设备不支持此功能" cancelButtonTitle:@"好的"];
        }else{
            imgPickView = [[UIImagePickerController alloc] init];
            imgPickView.delegate = self;
            imgPickView.allowsEditing = YES;
            imgPickView.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            imgPickView.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
            NSArray *availabelMedia = [UIImagePickerController availableMediaTypesForSourceType:imgPickView.sourceType];
            imgPickView.mediaTypes = [NSArray arrayWithObject:availabelMedia[1]];//只支持视频
            self.vedioPickerDidFinishSuccessBlock = successBlock;
            self.vedioPickerDidFinishFFailBlock = failBlock;
            self.savePath = path;
            self.pikcerModel = model;
            ALAuthorizationStatus author = [ALAssetsLibrary authorizationStatus];
            if (author == ALAuthorizationStatusAuthorized || author == ALAuthorizationStatusNotDetermined) {
                [viewController presentViewController:imgPickView animated:YES completion:nil];
            }
        }
    }else if(model == ICMediaPickerTypeVideoCamera) {
        if (![UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
            [UIAlertView alertViewWithTitle:@"错误" message:@"对不起，您的设备不支持此功能" cancelButtonTitle:@"好的"];
        }else{
            imgPickView = [[UIImagePickerController alloc] init];//创建一个获取视频的类
            imgPickView.sourceType = UIImagePickerControllerSourceTypeCamera;//通过设置SourceType可以确定调用出来的UIImagePickerController所显示出来的界面
            imgPickView.modalTransitionStyle = UIModalTransitionStyleCoverVertical;//界面跳转出来的方式
            imgPickView.videoQuality = UIImagePickerControllerQualityTypeHigh;//录取视频的质量
            imgPickView.delegate = self;//设置代理
            imgPickView.allowsEditing = YES;
            NSArray *availabelMedia = [UIImagePickerController availableMediaTypesForSourceType:imgPickView.sourceType];
            imgPickView.mediaTypes = [NSArray arrayWithObject:availabelMedia[1]];
            self.vedioPickerDidFinishSuccessBlock = successBlock;
            self.vedioPickerDidFinishFFailBlock = failBlock;
            self.savePath = path;
            self.pikcerModel = model;
            AVAuthorizationStatus author = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
            if (author == ALAuthorizationStatusAuthorized || author == ALAuthorizationStatusNotDetermined) {
                [viewController presentViewController:imgPickView animated:YES completion:nil];
            }
        }
    }
}

#pragma mark- Private method
- (void)URLToMp4:(NSURL*)mediaUrl SavePath:(NSString*)savePath{
    //假如存在，则先删除
    if ([[NSFileManager defaultManager] fileExistsAtPath:savePath]) {
        [[NSFileManager defaultManager] removeItemAtPath:savePath error:nil];
    }
    
    NSURL *pathUrl = [NSURL fileURLWithPath:savePath];//获取fileUrl，注意为file
    AVURLAsset * urlAsset = [[AVURLAsset alloc] initWithURL:mediaUrl options:nil];//获取视频资源
    AVAssetExportSession *audioSession = [AVAssetExportSession exportSessionWithAsset:urlAsset presetName:AVAssetExportPreset640x480];//输出资源类创建
    /*
     AVAssetExportPresetLowQuality
     AVAssetExportPresetMediumQuality
     AVAssetExportPresetHighestQuality
     和
     AVAssetExportPreset640x480
     AVAssetExportPreset960x540
     AVAssetExportPreset1280x720
     AVAssetExportPreset1920x1080
     */
    
    audioSession.outputURL = pathUrl;// 资源输出路径
    audioSession.outputFileType = AVFileTypeQuickTimeMovie;//资源输出格式
    /*
     AVFileTypeQuickTimeMovie
     AVFileTypeMPEG4
     AVFileTypeAppleM4V
     AVFileTypeAppleM4A
     AVFileType3GPP
     AVFileType3GPP2
     AVFileTypeCoreAudioFormat
     AVFileTypeWAVE
     AVFileTypeAIFF
     AVFileTypeAIFC
     AVFileTypeAMR
     AVFileTypeMPEGLayer3
     AVFileTypeSunAU
     AVFileTypeAC3
     */
    
    [audioSession exportAsynchronouslyWithCompletionHandler:^{//资源输出情况获取
        switch (audioSession.status) {
            case AVAssetExportSessionStatusUnknown:
                // [self.ICMediaVideoDg ICMediaVideoSaveError:@"AVAssetExportSessionStatusUnknown"];
                break;
            case AVAssetExportSessionStatusWaiting:
                //  [self.ICMediaVideoDg ICMediaVideoSaveError:@"AVAssetExportSessionStatusWaiting"];
                break;
            case AVAssetExportSessionStatusExporting:
                //                 [self.ICMediaVideoDg ICMediaVideoSaveError:@"AVAssetExportSessionStatusExporting"];
                break;
            case AVAssetExportSessionStatusCompleted: {
                [imgPickView dismissViewControllerAnimated:YES completion:nil];
                if (self.vedioPickerDidFinishSuccessBlock) {
                    self.vedioPickerDidFinishSuccessBlock(imgPickView, mediaUrl, savePath);
                }
            }
                break;
            case AVAssetExportSessionStatusFailed:{
                [imgPickView dismissViewControllerAnimated:YES completion:nil];
                if (self.vedioPickerDidFinishFFailBlock) {
                    self.vedioPickerDidFinishFFailBlock(imgPickView, mediaUrl, savePath);
                }
            }
                break;
            case AVAssetExportSessionStatusCancelled: {
                [imgPickView dismissViewControllerAnimated:YES completion:nil];
                [imgPickView dismissViewControllerAnimated:YES completion:nil];
                if (self.vedioPickerDidFinishFFailBlock) {
                    self.vedioPickerDidFinishFFailBlock(imgPickView, mediaUrl, savePath);
                }
            }
                break;
            default:
                break;
        }
    }];
}

#pragma mark- UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    if (self.pikcerModel==ICMediaPickerTypePhotoAlbum) {
        UIImage *image= [info objectForKey:UIImagePickerControllerOriginalImage];
        UIImage *thumbnail= [info objectForKey:UIImagePickerControllerEditedImage];
        [picker dismissViewControllerAnimated:YES completion:nil];
        //block操作
        if (self.imagePickerDidFinishPickingBlock) {
            self.imagePickerDidFinishPickingBlock(picker, image, thumbnail);
        }
    }else if(self.pikcerModel==ICMediaPickerTypePhotoCamera){
        UIImage *image= [info objectForKey:UIImagePickerControllerOriginalImage];
        UIImage *thumbnail= [info objectForKey:UIImagePickerControllerEditedImage];
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
        [picker dismissViewControllerAnimated:YES completion:nil];
        //block操作
        if (self.imagePickerDidFinishPickingBlock) {
            self.imagePickerDidFinishPickingBlock(picker, image, thumbnail);
        }
    }else if(self.pikcerModel==ICMediaPickerTypeVideoAlbum){
        NSURL *pathUrl = [info objectForKey:UIImagePickerControllerMediaURL];//获取URL
        [self URLToMp4:pathUrl SavePath:self.savePath];
    }else if(self.pikcerModel==ICMediaPickerTypeVideoCamera){
        NSURL *pathUrl = [info objectForKey:UIImagePickerControllerMediaURL];//获取URL
        ALAssetsLibrary *assetsLibrary = [[ALAssetsLibrary alloc] init];
        [assetsLibrary writeVideoAtPathToSavedPhotosAlbum:pathUrl completionBlock:^(NSURL *assetURL, NSError *error) {
            NSLog(@"已经将视频存放到相册中");
        }];
        [self URLToMp4:pathUrl SavePath:self.savePath];
    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    //按取消键，进行的操作
    [picker dismissViewControllerAnimated:YES completion:nil];
}


@end
