//
//  ICDeviceInfoHelperDemo.m
//  ICGeneral
//
//  Created by Lotheve on 15/8/3.
//  Copyright (c) 2015年 Lotheve. All rights reserved.
//

#import "ICDeviceInfoHelperDemo.h"
#import "ICDeviceInfoHelper.h"

@interface ICDeviceInfoHelperDemo ()
@property (strong, nonatomic)ICDeviceInfoHelper *deviceHelper;
@end

@implementation ICDeviceInfoHelperDemo

- (void)viewDidLoad {
    [super viewDidLoad];
    self.deviceHelper = [ICDeviceInfoHelper shareInstance];
    
    UIButton *buttonText = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonText.frame = CGRectMake(0, 0, 100, 100);
    buttonText.backgroundColor = [UIColor redColor];
    buttonText.titleLabel.font = [UIFont systemFontOfSize:12.0];
    [buttonText setTitle:@"设备型号" forState:UIControlStateNormal];
    [buttonText addTarget:self action:@selector(actionDeviceModel:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttonText];
    
    UIButton *buttonText1 = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonText1.frame = CGRectMake(0, 100, 100, 100);
    buttonText1.backgroundColor = [UIColor redColor];
    buttonText1.titleLabel.font = [UIFont systemFontOfSize:12.0];
    [buttonText1 setTitle:@"设备版本" forState:UIControlStateNormal];
    [buttonText1 addTarget:self action:@selector(actionDeviceVersion:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttonText1];
    
    UIButton *buttonText2 = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonText2.frame = CGRectMake(0, 200, 100, 100);
    buttonText2.backgroundColor = [UIColor redColor];
    buttonText2.titleLabel.font = [UIFont systemFontOfSize:12.0];
    [buttonText2 setTitle:@"设备名字" forState:UIControlStateNormal];
    [buttonText2 addTarget:self action:@selector(actionDeviceName:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttonText2];
    
    UIButton *buttonText3 = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonText3.frame = CGRectMake(0, 300, 100, 100);
    buttonText3.backgroundColor = [UIColor redColor];
    buttonText3.titleLabel.font = [UIFont systemFontOfSize:12.0];
    [buttonText3 setTitle:@"是否是Iphone" forState:UIControlStateNormal];
    [buttonText3 addTarget:self action:@selector(actionDeviceIsIphone:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttonText3];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)actionDeviceModel:(UIButton *)sender {
    NSLog(@"设备型号---%@",[self.deviceHelper getDeviceModel]);
}

- (void)actionDeviceVersion:(id)sender {
    NSLog(@"设备版本---%@",[self.deviceHelper getDeviceSystemVersion]);
}

- (void)actionDeviceName:(id)sender {
    NSLog(@"设备名字---%@",[self.deviceHelper getDeviceName]);
}

- (void)actionDeviceIsIphone:(id)sender {
    NSLog(@"设备是否是Iphone---%d",[self.deviceHelper isIphone]);
}

@end
