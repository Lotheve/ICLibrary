//
//  ICCameraViewController.m
//  ICSimpleCamera
//
//  Created by Lotheve on 15/7/30.
//  Copyright (c) 2015年 Lotheve. All rights reserved.
//

#import "ICCameraViewController.h"
#import "ICSimpleCamera.h"

@interface ICCameraViewController ()<ICSimpleCameraDelegate>

@property (nonatomic, strong) ICSimpleCamera *camera;

@property (nonatomic, strong) UIButton *captureButton;
@property (nonatomic, strong) UIButton *positionButton;
@property (nonatomic, strong) UIButton *flashButton;

@end

@implementation ICCameraViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden = YES;
    self.view.backgroundColor = [UIColor yellowColor];
    //创建相机
    self.camera = [[ICSimpleCamera alloc]initWithQuality:ICCameraQualityHigh];
    //将相机绑定在当前视图控制器并设置代理
    [self.camera attachToViewController:self withDelegate:self];
    self.camera.view.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    
    CGRect bounds = [UIScreen mainScreen].bounds;
    _captureButton = [[UIButton alloc]initWithFrame:CGRectMake(bounds.size.width/2.0 - 25, bounds.size.height - 50 - 20, 50, 50)];
    _captureButton.layer.cornerRadius = 25.0;
    _captureButton.layer.borderWidth = 2.0;
    _captureButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _captureButton.backgroundColor = [UIColor whiteColor];
    _captureButton.layer.masksToBounds = YES;
    [_captureButton addTarget:self action:@selector(captureAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_captureButton];
    
    _flashButton = [[UIButton alloc]initWithFrame:CGRectMake(bounds.size.width/2.0 - 20, 20, 40, 40)];
    _flashButton.backgroundColor = [UIColor clearColor];
    [_flashButton setImage:[UIImage imageNamed:@"camera-flash-off"] forState:UIControlStateNormal];
    [_flashButton setImage:[UIImage imageNamed:@"camera-flash-on"] forState:UIControlStateSelected];
    [_flashButton addTarget:self action:@selector(flashAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_flashButton];
    
    _positionButton = [[UIButton alloc]initWithFrame:CGRectMake(bounds.size.width - 60, 20, 40, 40)];
    _positionButton.backgroundColor = [UIColor clearColor];
    [_positionButton setImage:[UIImage imageNamed:@"camera-switch"] forState:UIControlStateNormal];
    [_positionButton addTarget:self action:@selector(positionAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_positionButton];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.camera start];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)captureAction{
    [self.camera capture];
}

- (void)flashAction{
    [self.camera toggleCameraFlash];
    if (self.camera.cameraFlash == ICCameraFlashOn) {
        self.flashButton.selected = YES;
    }else{
        self.flashButton.selected = NO;
    }
}

- (void)positionAction{
    [self.camera togglCameraPosition];
}

#pragma mark - private methods
- (void)saveImageToAlbum:(UIImage *)image{
    UIImageWriteToSavedPhotosAlbum(image, self, @selector(imageSavedToPhotosAlbum:didFinishSavingWithError:contextInfo:), nil);
}

- (void)imageSavedToPhotosAlbum:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    NSString *result;
    if (!error) {
        result = @"已存至相册";
    }else{
        result = @"相片保存失败";
    }
    CGPoint center = self.view.center;
    UILabel *resultLabel = [[UILabel alloc]initWithFrame:CGRectMake(center.x - 50, center.y - 30, 100, 60)];
    resultLabel.backgroundColor = [UIColor colorWithWhite:0.906 alpha:0.4];
    resultLabel.layer.cornerRadius = 4.0;
    resultLabel.text = result;
    resultLabel.textColor = [UIColor blackColor];
    [self.view addSubview:resultLabel];
    
    [self performSelector:@selector(dismissResultLabel:) withObject:resultLabel afterDelay:1.0];
}

- (void)dismissResultLabel:(UILabel *)label{
    [label removeFromSuperview];
    [self.camera stop];
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - ICSimpleCameraDelegate
- (void)cameraViewController:(ICSimpleCamera *)camera didCapturePhoto:(UIImage *)image{

    [self saveImageToAlbum:image];
}




@end
