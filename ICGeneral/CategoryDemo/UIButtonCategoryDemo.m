//
//  UIButtonTest.m
//  ICGeneral
//
//  Created by Lotheve on 16/4/23.
//  Copyright © 2016年 Lotheve. All rights reserved.
//

#import "UIButtonCategoryDemo.h"
#import "UIButton+Additions.h"

@implementation UIButtonCategoryDemo

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadBaseUI];
}

- (void)loadBaseUI{
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame = CGRectMake(0, 0, 100, 40);
    button1.center = CGPointMake(self.view.center.x, self.view.center.y-100);
    button1.backgroundColor = [UIColor purpleColor];
    [button1 setTitle:@"测试" forState:UIControlStateNormal];
    [button1 setImage:[UIImage imageNamed:@"warning_btn"] forState:UIControlStateNormal];
    [button1 alignImageAboveTitle];
    [self.view addSubview:button1];
    
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    button2.frame = CGRectMake(0, 0, 100, 40);
    button2.center = CGPointMake(self.view.center.x, self.view.center.y+100);
    button2.backgroundColor = [UIColor purpleColor];
    [button2 setTitle:@"测试" forState:UIControlStateNormal];
    [button2 setImage:[UIImage imageNamed:@"warning_btn"] forState:UIControlStateNormal];
    [button2 alignImageRightTitle];
    [self.view addSubview:button2];
}

@end
