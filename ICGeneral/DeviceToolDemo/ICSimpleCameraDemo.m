//
//  ICSimpleCameraDemo.m
//  ICGeneral
//
//  Created by Lotheve on 15/8/3.
//  Copyright (c) 2015年 Lotheve. All rights reserved.
//

#import "ICSimpleCameraDemo.h"
#import "ICCameraViewController.h"

@interface ICSimpleCameraDemo ()

@end

@implementation ICSimpleCameraDemo

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(50, 50, 50, 50)];
    button.backgroundColor = [UIColor greenColor];
    [button setTitle:@"相机" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)buttonAction{
    ICCameraViewController *cameraVC = [[ICCameraViewController alloc]init];
    [self presentViewController:cameraVC animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
