//
//  ICLabelDemo.m
//  ICGeneral
//
//  Created by Lotheve on 15/7/21.
//  Copyright (c) 2015年 Lotheve. All rights reserved.
//

#import "ICLabelDemo.h"
#import "ICLabel.h"

@interface ICLabelDemo ()

@property (strong, nonatomic)ICLabel *label;
@property (strong, nonatomic)ICLabel *label1;
@property (strong, nonatomic)ICLabel *label2;
@property (strong, nonatomic)ICLabel *label3;

@end

@implementation ICLabelDemo

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"ICLabel";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    [self loadBaseUI];
}

- (void)loadBaseUI{
    [self.view addSubview:self.label1];
    [self.view addSubview:self.label2];
    [self.view addSubview:self.label3];
    [self.view addSubview:self.label];
}

#pragma makr- Getter, Setter
- (ICLabel*)label1{
    if (!_label1) {
        _label1 = [[ICLabel alloc]initWithFrame:CGRectMake(0, 100, SCREEN_WIDTH, 100)];
        NSMutableArray *rangeArray = [NSMutableArray rangeArrayWithLocationAndLength:@1, @12, @2, @20, nil];
        [_label1 setText:@"dfjalsdkfjasldkf sljfskdljfsdf"];;
        [_label1 setDeleteLineInRanges:rangeArray];
    }
    return _label1;
}

- (ICLabel*)label2{
    if (!_label2) {
        _label2 = [[ICLabel alloc]initWithFrame:CGRectMake(0, 200, SCREEN_WIDTH, 100)];
        NSMutableArray *rangeArray = [NSMutableArray rangeArrayWithLocationAndLength:@3, @11, nil];
        [_label2 setText:@"dfjalsdkfjasldkf sljfskdljfsdf"];;
        [_label2 setColor:[UIColor redColor] inRanges:rangeArray];
    }
    return _label2;
}

- (ICLabel*)label3{
    if (!_label3) {
        _label3 = [[ICLabel alloc]initWithFrame:CGRectMake(0, 300, SCREEN_WIDTH, 100)];
        NSMutableArray *rangeArray = [NSMutableArray rangeArrayWithLocationAndLength:@3, @11, nil];
        [_label3 setText:@"dfjalsdkfjasldkf sljfskdljfsdf"];;
        [_label3 setFont:[UIFont systemFontOfSize:30] inRanges:rangeArray];
    }
    return _label3;
}

- (ICLabel*)label{
    if (!_label) {
        NSMutableArray *rangeArray = [NSMutableArray rangeArrayWithLocationAndLength:@1, @12, @2, @20, nil];
        _label = [[ICLabel alloc]initWithFrame:CGRectMake(0, 400, [UIScreen mainScreen].bounds.size.width, 100)];
        _label.lineBreakMode = NSLineBreakByWordWrapping;
        _label.numberOfLines = 0;
        [_label setText:@"混合之后，出现的效果dfjalsdkfjasldkf sljfskdljdsafsdfas"];;
        [_label setDeleteLineInRanges:rangeArray];
        [_label setColor:[UIColor redColor] inRanges:rangeArray];
        [_label setFont:[UIFont systemFontOfSize:30] inRanges:rangeArray];
    }
    return _label;
}
@end
