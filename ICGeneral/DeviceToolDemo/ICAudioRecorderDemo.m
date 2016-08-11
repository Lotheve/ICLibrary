//
//  ICAudioRecorderDemo.m
//  ICGeneral
//
//  Created by Lotheve on 15/8/3.
//  Copyright (c) 2015年 Lotheve. All rights reserved.
//

#import "ICAudioRecorderDemo.h"
#import "ICAudioRecorder.h"

@interface ICAudioRecorderDemo ()

@property (nonatomic, strong) ICAudioRecorder *avRecorder;

@end

@implementation ICAudioRecorderDemo

- (void)viewDidLoad {
    [super viewDidLoad];

    UIButton *speakBut = [UIButton buttonWithType:UIButtonTypeCustom];
    speakBut.frame = CGRectMake(60, 340, 200, 40);
    [speakBut setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [speakBut addTarget:self action:@selector(actionBeginRecorder:) forControlEvents:UIControlEventTouchDown];
    [speakBut addTarget:self action:@selector(actionStopRecorder:) forControlEvents:UIControlEventTouchUpInside];
    [speakBut setTitle:@"按住说话" forState:UIControlStateNormal];
    [speakBut setTitle:@"正在录音" forState:UIControlStateHighlighted];
    speakBut.titleLabel.font = [UIFont boldSystemFontOfSize:25];
    [self.view addSubview:speakBut];
    
    //录音文件保存路径
    NSString *recordUrl = NSTemporaryDirectory();
    recordUrl = [recordUrl stringByAppendingPathComponent:@"sound.mp3"];
    self.avRecorder = [ICAudioRecorder shareInstance];
    [self.avRecorder setRecorderWithSavePath:recordUrl];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (void)actionBeginRecorder:(id)sender
{
    [self.avRecorder recorderStart];
}

- (void)actionStopRecorder:(id)sender{
    [self.avRecorder recorderStop];
}

@end
