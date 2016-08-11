//
//  ICTextViewDemo.m
//  ICGeneral
//
//  Created by Lotheve on 15/7/22.
//  Copyright (c) 2015年 Lotheve. All rights reserved.
//

#import "ICTextViewDemo.h"
#import "ICTextView.h"

@interface ICTextViewDemo ()

@property (nonatomic, strong) ICTextView *textView;

@end

@implementation ICTextViewDemo

- (void)viewDidLoad {
    [super viewDidLoad];
    ICTextView *textView = [[ICTextView alloc]initWithFrame:CGRectMake(0, 20, [UIScreen mainScreen].bounds.size.width, 200)];
    [textView setPlaceHolder:@"请输入内容"];
    textView.textColor = [UIColor redColor];
    textView.layer.borderWidth = 1;
    [self.view addSubview:textView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hiddenKeyBoard)];
    [self.view addGestureRecognizer:tap];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark- Private method
- (void)hiddenKeyBoard{
    [self.view endEditing:YES];
}



@end
