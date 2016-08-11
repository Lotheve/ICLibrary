//
//  ICButtonDemo.m
//  ICGeneral
//
//  Created by Lotheve on 15/7/22.
//  Copyright (c) 2015年 Lotheve. All rights reserved.
//

#import "ICButtonDemo.h"
#import "ICButton.h"

@interface ICButtonDemo ()

@property (nonatomic, strong) ICButton *button;

@end

@implementation ICButtonDemo

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadBaseUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)loadBaseUI{
    [self.view addSubview:self.button];
}

- (ICButton *)button{
    if (!_button) {
        _button = [[ICButton alloc]initWithFrame:CGRectMake(60, 200, 100, 40)];
        [_button setImage:[UIImage imageNamed:@"warning_btn"] withImageRect:CGRectMake(10,10, 20, 20)];
        [_button setTitle:@"测试" withTitleRect:CGRectMake(40, 0, 60, 40)];
        [_button setNormalTitleColor:[UIColor redColor] withHighlightColor:[UIColor lightGrayColor]];
        [_button setButtonType:ICButtonTypeRoundedRect];
        [_button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button;
}

- (void)buttonClick{
    NSLog(@"buttonClicked");
}


@end
