//
//  ICProgressViewDemo.m
//  ICGeneral
//
//  Created by Lotheve on 15/7/22.
//  Copyright (c) 2015年 Lotheve. All rights reserved.
//

#import "ICProgressViewDemo.h"
#import "ICProgressView.h"

@interface ICProgressViewDemo ()

@property (nonatomic, strong) ICProgressView *progressView;

@end

@implementation ICProgressViewDemo

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadBaseUI];
}

- (void)loadBaseUI{
    [self.view addSubview:self.progress];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (ICProgressView *)progress{
    if (!_progressView) {
        _progressView = [[ICProgressView alloc]initWithFrame:CGRectMake(50, 200, 200, 20)];
        _progressView.progress = 0.4;
        _progressView.progressTintColor = [UIColor redColor];
        _progressView.trackTintColor = [UIColor greenColor];
        _progressView.style = ICProgressViewStyleRoundRect;
    }
    return _progressView;
}



@end
