//
//  UIAlertViewTest.m
//  ICGeneral
//
//  Created by Lotheve on 15/7/22.
//  Copyright (c) 2015年 Lotheve. All rights reserved.
//

#import "UIAlertViewCategoryDemo.h"
#import "UIAlertView+Additions.h"

@implementation UIAlertViewCategoryDemo

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadBaseUI];
}

- (void)loadBaseUI{
//    [UIAlertView alertViewWithTitle:@"标题" message:@"内容" cancelButtonTitle:@"取消" otherButtonTitle:@[@"确定"] cancelButtonBlock:^{
//        NSLog(@"取消");
//    } otherButtonBlock:^(NSInteger index) {
//        NSLog(@"其他");
//    }];
    
    [UIAlertView alertViewWithTitle:@"dfas" message:@"dfasdf"];
}

@end
