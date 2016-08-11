//
//  ICQRCodeRecognizerDemo.m
//  ICGeneral
//
//  Created by Lotheve on 15/8/3.
//  Copyright (c) 2015年 Lotheve. All rights reserved.
//

#import "ICQRCodeRecognizerDemo.h"
#import "ICQRCodeRecognizer.h"

@interface ICQRCodeRecognizerDemo ()

@end

@implementation ICQRCodeRecognizerDemo

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(100, 100, 120, 40)];
    button.backgroundColor = [UIColor greenColor];
    [button setTitle:@"获取二维码" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(raiseQRCodePicker) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)raiseQRCodePicker{
    ICQRCodeRecognizer *recognizer = [[ICQRCodeRecognizer alloc]init];
    [self presentViewController:recognizer animated:YES completion:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
