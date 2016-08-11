//
//  ICSimpleCamera.m
//  ICSimpleCamera
//
//  Created by Lotheve on 15/7/29.
//  Copyright (c) 2015年 Lotheve. All rights reserved.
//

#import "ICSimpleCamera.h"
#import <ImageIO/ImageIO.h>

@interface ICSimpleCamera ()

@property (nonatomic, strong) AVCaptureSession *session;
@property (nonatomic, strong) AVCaptureDevice *device;
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *captureVideoPreviewLayer;
@property (nonatomic, strong) AVCaptureStillImageOutput *stillImageOutput;
@property (nonatomic, strong) UIView *preview;

@end

@implementation ICSimpleCamera

- (instancetype)initWithQuality:(ICCameraQuality)quality{
    if (self = [super init]) {
        _cameraQuality = quality;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.cameraFlash = ICCameraFlashOff;  //闪光灯默认为关闭状态
    self.view.backgroundColor = [UIColor clearColor];
    self.preview = [[UIView alloc]initWithFrame:CGRectZero];
    [self.view addSubview:self.preview];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    self.preview.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
    CGRect bounds=self.preview.bounds;
    self.captureVideoPreviewLayer.bounds=bounds;
    self.captureVideoPreviewLayer.position=CGPointMake(CGRectGetMidX(bounds), CGRectGetMidY(bounds));
    self.captureVideoPreviewLayer.connection.videoOrientation = AVCaptureVideoOrientationPortrait;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)attachToViewController:(UIViewController *)vc withDelegate:(id<ICSimpleCameraDelegate>)delegate {
    self.delegate = delegate;
    [vc.view addSubview:self.view];
    [vc addChildViewController:self];
    [self didMoveToParentViewController:vc];
}

//开始工作
- (void)start{
    if(!_session) {
        
        self.session = [[AVCaptureSession alloc] init];
        
        NSString *sessionPreset = nil;
        
        switch (self.cameraQuality) {
            case ICCameraQualityHigh:
                sessionPreset = AVCaptureSessionPresetHigh;
                break;
            case ICCameraQualityMedium:
                sessionPreset = AVCaptureSessionPresetMedium;
                break;
            case ICCameraQualityLow:
                sessionPreset = AVCaptureSessionPresetLow;
                break;
            default:
                sessionPreset = AVCaptureSessionPresetPhoto;
                break;
        }
        
        self.session.sessionPreset = sessionPreset;
        
        CALayer *viewLayer = self.preview.layer;
        
        AVCaptureVideoPreviewLayer *captureVideoPreviewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:self.session];
        
        CGRect bounds=viewLayer.bounds;
        captureVideoPreviewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
        captureVideoPreviewLayer.bounds=bounds;
        captureVideoPreviewLayer.position=CGPointMake(CGRectGetMidX(bounds), CGRectGetMidY(bounds));
        [self.preview.layer addSublayer:captureVideoPreviewLayer];
        
        self.captureVideoPreviewLayer = captureVideoPreviewLayer;
        
        _device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        
        NSError *error = nil;
        AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:_device error:&error];
        
        if (!input) {
            // Handle the error appropriately.
            NSLog(@"ERROR: trying to open camera: %@", error);
            return;
        }
        [self.session addInput:input];
        
        self.stillImageOutput = [[AVCaptureStillImageOutput alloc] init];
        NSDictionary *outputSettings = [[NSDictionary alloc] initWithObjectsAndKeys: AVVideoCodecJPEG, AVVideoCodecKey, nil];
        [self.stillImageOutput setOutputSettings:outputSettings];
        [self.session addOutput:self.stillImageOutput];
    }
    
    [self.session startRunning];
}

//快门
- (void)capture{
    
    AVCaptureConnection *videoConnection = nil;
    for (AVCaptureConnection *connection in self.stillImageOutput.connections)
    {
        for (AVCaptureInputPort *port in [connection inputPorts])
        {
            if ([[port mediaType] isEqual:AVMediaTypeVideo]) {
                videoConnection = connection;
                break;
            }
        }
        if (videoConnection) {
            break;
        }
    }
    
    if (!videoConnection) {
        return;
    }
    
    [self.stillImageOutput captureStillImageAsynchronouslyFromConnection:videoConnection completionHandler: ^(CMSampleBufferRef imageSampleBuffer, NSError *error)
     {
         CFDictionaryRef exifAttachments = CMGetAttachment(imageSampleBuffer, kCGImagePropertyExifDictionary, NULL);
         if (exifAttachments) {
             // Do something with the attachments.
             NSLog(@"attachements: %@", exifAttachments);
         } else {
             NSLog(@"no attachments");
         }
         
         NSData *imageData = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageSampleBuffer];
         UIImage *image = [[UIImage alloc] initWithData:imageData];

         if(self.delegate) {
             if ([self.delegate respondsToSelector:@selector(cameraViewController:didCapturePhoto:)]) {
                 [self.delegate cameraViewController:self didCapturePhoto:image];
             }
         }
     }];
}

//停止工作
- (void)stop{
    [_session stopRunning];
}

- (void)setCameraFlash:(ICCameraFlash)cameraFlash{
    
    if (_cameraFlash == cameraFlash) {
        return;
    }
    
    AVCaptureInput* currentCameraInput = [self.session.inputs objectAtIndex:0];
    AVCaptureDeviceInput *deviceInput = (AVCaptureDeviceInput *)currentCameraInput;
    
    //判断当前设备闪光灯是否可用
    if(!deviceInput.device.isTorchAvailable) {
        return;
    }
    
    _cameraFlash = cameraFlash;
    
    //开始配置
    [self.session beginConfiguration];
    [deviceInput.device lockForConfiguration:nil];
    
    if(_cameraFlash == ICCameraFlashOn) {
        deviceInput.device.torchMode = AVCaptureTorchModeOn;
    }
    else {
        deviceInput.device.torchMode = AVCaptureTorchModeOff;
    }
    
    [deviceInput.device unlockForConfiguration];
    
    //提交配置
    [self.session commitConfiguration];
}

- (void)toggleCameraFlash{
    if (self.cameraFlash == ICCameraFlashOff) {
        self.cameraFlash = ICCameraFlashOn;
    }else{
        self.cameraFlash = ICCameraFlashOff;
    }
}

- (void)togglCameraPosition{
    if (self.cameraPosition == ICCameraPositionFront) {
        self.cameraPosition = ICCameraPositionBack;
    }else{
        self.cameraPosition = ICCameraPositionFront;
    }
}

- (void)setCameraPosition:(ICCameraPosition)cameraPosition{
    if (_cameraPosition == cameraPosition) {
        return;
    }
    
    //告诉session要重新做一些配置
    [self.session beginConfiguration];
    
    //移除原有输入设备
    AVCaptureInput* currentCameraInput = [self.session.inputs objectAtIndex:0];
    [self.session removeInput:currentCameraInput];
    
    //设置新的输入设备
    AVCaptureDevice *newCamera = nil;
    if(((AVCaptureDeviceInput*)currentCameraInput).device.position == AVCaptureDevicePositionBack) {
        newCamera = [self cameraWithPosition:AVCaptureDevicePositionFront];
    }
    else {
        newCamera = [self cameraWithPosition:AVCaptureDevicePositionBack];
    }
    
    if(!newCamera) {
        return;
    }
    
    _cameraPosition = cameraPosition;
    
    //添加新的输入设备
    AVCaptureDeviceInput *newVideoInput = [[AVCaptureDeviceInput alloc] initWithDevice:newCamera error:nil];
    [self.session addInput:newVideoInput];
    
    //提交配置
    [self.session commitConfiguration];
    
    _device = newCamera;
}

//查找符合条件的相机设备
- (AVCaptureDevice *)cameraWithPosition:(AVCaptureDevicePosition) position
{
    NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    for (AVCaptureDevice *device in devices) {
        if ([device position] == position) return device;
    }
    return nil;
}

@end
