//
//  ICDoubleColumnPickerDemo.m
//  ICGeneral
//
//  Created by Lotheve on 15/7/23.
//  Copyright (c) 2015年 Lotheve. All rights reserved.
//

#import "ICDoubleColumnPickerDemo.h"
#import "ICDoubleColumnPicker.h"

@interface ICDoubleColumnPickerDemo ()<ICDoubleColumnPickerDelegate>

@property (nonatomic, strong) ICDoubleColumnPicker *indepickerView;
@property (nonatomic, strong) ICDoubleColumnPicker *relyPickerView;

@end

@implementation ICDoubleColumnPickerDemo

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadBaseUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)loadBaseUI{
    _indepickerView = [[ICDoubleColumnPicker alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 250) firstComponentItems:@[@"测试11",@"测试12",@"测试13",@"测试14",@"测试15",@"测试16"] secondComponentItems:@[@"测试21",@"测试22",@"测试23",@"测试24",@"测试25",@"测试26"]];
    [_indepickerView setTitle:@"无依赖关系"];
    _indepickerView.delegate = self;
    [self.view addSubview:_indepickerView];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"pickerData" ofType:@"plist"];
    NSDictionary *dic = [[NSDictionary alloc]initWithContentsOfFile:path];
    _relyPickerView = [[ICDoubleColumnPicker alloc]initWithFrame:CGRectMake(0, 270, [UIScreen mainScreen].bounds.size.width, 250) withArrayItems:dic forRelyType:ICDoubleColumnPickerRightRelyLeft];
    _relyPickerView.delegate = self;
    [_relyPickerView setTitle:@"双列依赖"];
    [self.view addSubview:_relyPickerView];
}

#pragma mark - ICDoubleColumnPickerDelegate
- (void)pickerViewDidCancelSelection:(ICDoubleColumnPicker *)pickerView{
    NSLog(@"取消");
}

- (void)pickerView:(ICDoubleColumnPicker *)pickerView didSelectRowOnFirstComponent:(NSInteger)firstItemIndex secondComponent:(NSInteger)secondItemIndex{
    NSLog(@"firstItemIndex = %d",(int)firstItemIndex);
    NSLog(@"secondItemIndex = %d",(int)secondItemIndex);
}

@end
