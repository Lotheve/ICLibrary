//
//  ICAddressBookHelperDemo.m
//  ICGeneral
//
//  Created by Lotheve on 15/8/3.
//  Copyright (c) 2015年 Lotheve. All rights reserved.
//

#import "ICAddressBookHelperDemo.h"
#import "ICAddressBookHelper.h"

@implementation ICAddressBookHelperDemo
- (void)viewDidLoad {
    [super viewDidLoad];
    [self LoadBaseUI];
}

- (void)LoadBaseUI{
    UIButton *button1 = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 200, 100)];
    [button1 setTitle:@"获取通讯录(未分组)" forState:UIControlStateNormal];
    [button1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(actionGetAddressNomal) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button1];
    
    UIButton *button2 = [[UIButton alloc]initWithFrame:CGRectMake(0, 100, 200, 100)];
    [button2 setTitle:@"获取分组通讯录" forState:UIControlStateNormal];
    [button2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(actionGetAddressByGroup) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button2];
}

- (void)actionGetAddressNomal{
    ICAddressBookHelper *addressBookHelper = [ICAddressBookHelper shareInstance];
    [addressBookHelper getContactsWithSuccessFn:^(NSMutableArray *contacts) {
        for (User *aUser in contacts) {
            NSLog(@"%@", aUser.name);
        }
    } FailedFn:^(NSError *error, NSString *desc) {
        NSLog(@"失败消息为------%@", desc);
    }];
}

- (void)actionGetAddressByGroup{
    ICAddressBookHelper *addressBookHelper = [ICAddressBookHelper shareInstance];
    [addressBookHelper getContactsByGroupWithSuccessFn:^(NSMutableArray *indexsOfGroup, NSMutableArray *groups, NSUInteger count) {
        NSLog(@"indexsOfGroup - %@",indexsOfGroup);
        NSLog(@"groups - %@",groups);
        NSLog(@"count - %zi",count);
    } FailedFn:^(NSError *error, NSString *desc) {
        NSLog(@"%@",desc);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
