//
//  ICSingColumnPickerDemo.m
//  ICGeneral
//
//  Created by Lotheve on 15/7/22.
//  Copyright (c) 2015年 Lotheve. All rights reserved.
//

#import "ICSingColumnPickerDemo.h"
#import "ICSingleColumnPicker.h"

@interface ICSingColumnPickerDemo ()<ICSingleRowPickerViewDelegate>
{
    NSArray *_dataSource;
}

@property (nonatomic, strong) ICSingleColumnPicker *pickerView;

@end

@implementation ICSingColumnPickerDemo

- (void)loadView{
    [super loadView];
    [self initalization];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadBaseUI];
}

- (void)initalization{
    _dataSource = @[@"111",@"222",@"333",@"444",@"555",@"666",@"777",@"888",@"999"];
}

- (void)loadBaseUI{
    [self.view addSubview:self.pickerView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (ICSingleColumnPicker *)pickerView{
    if (!_pickerView) {
        _pickerView = [[ICSingleColumnPicker alloc]initWithFrame:CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, 250) withSelectItems:_dataSource];
        _pickerView.delegate = self;
        [_pickerView setTitle:@"测试PickerView"];
    }
    return _pickerView;
}

#pragma mark - ICSingleRowPickerViewDelegate
- (void)pickerViewDidCancelSelection:(ICSingleColumnPicker *)pickerView{
    NSLog(@"取消");
}

- (void)pickerView:(ICSingleColumnPicker *)pickerView didSelectRow:(NSInteger)row{
    NSLog(@"index %zi selected!",row);
}


@end
