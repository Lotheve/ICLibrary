//
//  ICDatePickerDemo.m
//  ICGeneral
//
//  Created by Lotheve on 15/7/21.
//  Copyright (c) 2015年 Lotheve. All rights reserved.
//

#import "ICDatePickerDemo.h"
#import "ICDatePicker.h"

@interface ICDatePickerDemo ()

@property (strong, nonatomic)ICDatePicker *dataPicker1;
@property (strong, nonatomic)ICDatePicker *dataPicker2;

@end

@implementation ICDatePickerDemo

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"ICDatePicker";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    [self loadBaseUI];
}

- (void)loadBaseUI{
    [self.view addSubview:self.dataPicker1];
    [self.view addSubview:self.dataPicker2];
}

#pragma mark- Getter, Setter
- (ICDatePicker*)dataPicker1{
    if (!_dataPicker1) {
        _dataPicker1 = [[ICDatePicker alloc]initDatePickerWithLeftUpPoint:CGPointMake(0, 0) DatePickerMode:ICDatePickerModeMonth andCertainBlock:^(UIPickerView *dataPicker, NSString *selected) {
            NSLog(@"%@", selected);
        } cancelBlock:^(UIPickerView *dataPicker, NSString *selected) {
            NSLog(@"%@", selected);
        }];
        
    }
    return _dataPicker1;
}

- (ICDatePicker*)dataPicker2{
    if (!_dataPicker2) {
        _dataPicker2 = [[ICDatePicker alloc]initDatePickerWithLeftUpPoint:CGPointMake(0, 260) DatePickerMode:ICDatePickerModeYearAndMonth andCertainBlock:^(UIPickerView *dataPicker, NSString *selected) {
            NSLog(@"%@", selected);
        } cancelBlock:^(UIPickerView *dataPicker, NSString *selected) {
            NSLog(@"%@", selected);
        }];
        
    }
    return _dataPicker2;
}

@end
