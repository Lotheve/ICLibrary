//
//  UIButtonTest.m
//  ICGeneral
//
//  Created by Lotheve on 16/4/23.
//  Copyright © 2016年 Lotheve. All rights reserved.
//

#import "UIButtonCategoryDemo.h"
#import "UIButton+Additions.h"
#import "UIButton+HitRect.h"

@implementation UIButtonCategoryDemo

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadBaseUI];
}

- (void)loadBaseUI{
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame = CGRectMake(0, 0, 100, 40);
    button1.center = CGPointMake(self.view.center.x, 100);
    button1.backgroundColor = [UIColor purpleColor];
    [button1 setTitle:@"测试" forState:UIControlStateNormal];
    [button1 setImage:[UIImage imageNamed:@"warning_btn"] forState:UIControlStateNormal];
    [button1 alignImageAboveTitle];
    [self.view addSubview:button1];
    
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    button2.frame = CGRectMake(0, 0, 100, 40);
    button2.center = CGPointMake(self.view.center.x, 200);
    button2.backgroundColor = [UIColor purpleColor];
    [button2 setTitle:@"测试" forState:UIControlStateNormal];
    [button2 setImage:[UIImage imageNamed:@"warning_btn"] forState:UIControlStateNormal];
    [button2 alignImageRightTitle];
    [self.view addSubview:button2];
    
    
    UIView *indicateView = [[UIView alloc] init];
    indicateView.frame = CGRectMake(0, 0, 140, 80);
    indicateView.center = self.view.center;
    indicateView.backgroundColor = [UIColor colorWithRed:0.678 green:1.000 blue:0.040 alpha:0.500];
    [self.view addSubview:indicateView];
    UILabel *label = [[UILabel alloc]init];
    label.text = @"点击范围扩展至黄色区域";
    label.textColor = [UIColor redColor];
    label.font = [UIFont systemFontOfSize:16];
    label.frame = (CGRect){0, 0, label.intrinsicContentSize};
    label.center = CGPointMake(self.view.center.x, self.view.center.y+50);
    [self.view addSubview:label];
    
    UIButton *buttonTest = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonTest.bounds = CGRectMake(0, 0, 100, 40);
    buttonTest.center = self.view.center;
    buttonTest.backgroundColor = [UIColor purpleColor];
    [buttonTest setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [buttonTest setTitle:@"点击" forState:UIControlStateNormal];
    [buttonTest addTarget:self action:@selector(actionTest:) forControlEvents:UIControlEventTouchUpInside];
    [buttonTest setEnlargeEdgeWithTop:20 right:20 bottom:20 left:20];
    [self.view addSubview:buttonTest];
}


- (void)actionTest:(UIButton *)button{
    NSLog(@"%s",__FUNCTION__);
}


@end
