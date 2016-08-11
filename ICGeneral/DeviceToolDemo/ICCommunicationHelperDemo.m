//
//  ICCommunicationHelperDemo.m
//  ICGeneral
//
//  Created by Lotheve on 15/8/3.
//  Copyright (c) 2015年 Lotheve. All rights reserved.
//

#import "ICCommunicationHelperDemo.h"
#import "ICCommunicationHelper.h"

@interface ICCommunicationHelperDemo ()

@end

@implementation ICCommunicationHelperDemo

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *dialButton = [[UIButton alloc]initWithFrame:CGRectMake(100, 100, 120, 40)];
    dialButton.backgroundColor = [UIColor greenColor];
    [dialButton setTitle:@"拨号" forState:UIControlStateNormal];
    [dialButton addTarget:self action:@selector(dialAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:dialButton];
    
    UIButton *mesButton = [[UIButton alloc]initWithFrame:CGRectMake(100, 200, 120, 40)];
    mesButton.backgroundColor = [UIColor yellowColor];
    [mesButton setTitle:@"短信" forState:UIControlStateNormal];
    [mesButton addTarget:self action:@selector(mesAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:mesButton];
    
    UIButton *mailButton = [[UIButton alloc]initWithFrame:CGRectMake(100, 300, 120, 40)];
    mailButton.backgroundColor = [UIColor cyanColor];
    [mailButton setTitle:@"邮件" forState:UIControlStateNormal];
    [mailButton addTarget:self action:@selector(mailAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:mailButton];
}

- (void)dialAction{
    //拨号
    [[ICCommunicationHelper shareInstance] dialWithTel:@"10010"];
    
}

- (void)mesAction{
    //短信
    [[ICCommunicationHelper shareInstance] sendMessageWithViewController:self Recipients:@[@"10010"] MesBody:@"测试" SuccessFn:^{
        NSLog(@"发送成功");
    } FailFn:^{
        NSLog(@"发送失败");
    }CancelFn:^{
        NSLog(@"取消发送");
    }];
}

- (void)mailAction{
    //邮件
    [[ICCommunicationHelper shareInstance] sendMailWithViewController:self Recipients:@[@"453775721@qq.com"] Subject:@"我的工作报告" MailBody:@"测试测试测试" IsHTML:NO SuccessFn:^{
        NSLog(@"发送成功");
    } FailFn:^{
        NSLog(@"发送失败");
    } CancelFn:^{
        NSLog(@"取消发送");
    }];
}

@end
