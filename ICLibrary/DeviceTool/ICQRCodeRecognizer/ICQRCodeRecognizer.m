//
//  ICQRCodeRecognizer.m
//  ICQRCodeRecognizer
//
//  Created by Lotheve on 15/7/30.
//  Copyright (c) 2015年 Lotheve. All rights reserved.
//

#import "ICQRCodeRecognizer.h"
#import <AVFoundation/AVFoundation.h>

@interface ICQRCodeRecognizer ()<AVCaptureMetadataOutputObjectsDelegate>
{
    UIImageView *_slideStrip;
    NSTimer *_timer;
    NSInteger _slideDirection;  //0为向下滑动 1为向上滑动
    NSInteger _distance; //滑动距离
}

@property (nonatomic, strong) AVCaptureSession *session;
@property (nonatomic, strong) AVCaptureDevice *device;
@property (nonatomic, strong) AVCaptureDeviceInput *input;
@property (nonatomic, strong) AVCaptureMetadataOutput *outPut;
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *previewLayer;

@end

@implementation ICQRCodeRecognizer

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithWhite:0.965 alpha:1.000];
    
    CGPoint center = self.view.center;
    UIImageView *circum = [[UIImageView alloc]initWithFrame:CGRectMake(center.x - 150 , center.y - 180, 300, 300)];
    circum.contentMode = UIViewContentModeScaleToFill;
    circum.backgroundColor = [UIColor clearColor];
    circum.image = [UIImage imageNamed:@"pick_bg"];
    [self.view addSubview:circum];
    
    _slideStrip = [[UIImageView alloc]initWithFrame:CGRectMake(center.x - 140, center.y - 170, 280, 2)];
    _slideStrip.image = [UIImage imageNamed:@"line"];
    _slideStrip.contentMode = UIViewContentModeScaleToFill;
    _slideStrip.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_slideStrip];
    
    UIButton *cancelButton = [[UIButton alloc]initWithFrame:CGRectMake(center.x - 60, center.y + 140, 120, 40)];
    cancelButton.backgroundColor = [UIColor clearColor];
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [cancelButton setTitleColor:[UIColor purpleColor] forState:UIControlStateNormal];
    [cancelButton addTarget:self action:@selector(dismissAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cancelButton];
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(slideAction) userInfo:nil repeats:YES];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setupCamera];
}

- (void)slideAction{
    CGPoint center = self.view.center;
    
    if (_slideDirection == 0) {
        //向下
        _slideStrip.frame = CGRectMake(center.x - 140, center.y - 170 + _distance, 280, 2);
        _distance++;
        if (_distance == 280) {
            _slideDirection = 1;
        }
    }else{
        //向上
        _slideStrip.frame = CGRectMake(center.x - 140, center.y - 170 + _distance, 280, 2);
        _distance--;
        if (_distance == 0) {
            _slideDirection = 0;
        }
    }
}

- (void)dismissAction{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)setupCamera{
    
    //设备
    _device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    //输入绑定设备
    NSError *error;
    _input = [AVCaptureDeviceInput deviceInputWithDevice:_device error:&error];
    if (error) {
        return;
    }
    
    //输出
    _outPut = [[AVCaptureMetadataOutput alloc]init];
    // 说明：使用主线程队列，相应比较同步，使用其他队列，相应不同步，容易让用户产生不好的体验
    [_outPut setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    //session
    _session = [[AVCaptureSession alloc]init];
    [_session setSessionPreset:AVCaptureSessionPresetHigh];  //设置画面采集的质量
    if ([_session canAddInput:_input]) {
        [_session addInput:_input];
    }
    if ([_session canAddOutput:_outPut]) {
        [_session addOutput:_outPut];
    }
    
     //一定要先设置会话的输出为output之后，再指定输出的元数据类型为条码类型！
    [_outPut setMetadataObjectTypes:@[AVMetadataObjectTypeQRCode]];
    
    //预览图层
    _previewLayer = [[AVCaptureVideoPreviewLayer alloc]initWithSession:_session];
    _previewLayer.videoGravity = AVLayerVideoGravityResizeAspect;   //preview图层的属性
    _previewLayer.frame = self.view.frame;                    //preview图层的大小
    [self.view.layer insertSublayer:_previewLayer atIndex:0]; //将图层添加到视图的图层
    
    [_session startRunning];
}

#pragma mark - AVCaptureMetadataOutputObjectsDelegate
// 此方法是在识别到QRCode，并且完成转换
// 如果QRCode的内容越大，转换需要的时间就越长
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
    
    NSString *stringValue;
    if ([metadataObjects count] >0)
    {
        AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex:0];
        stringValue = metadataObject.stringValue;
    }
    
    NSLog(@"%@",stringValue);
    [_session stopRunning];
    [self dismissViewControllerAnimated:YES completion:nil];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
