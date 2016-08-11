//
//  ICSingleColumnPicker.m
//  ICControlerTest
//
//  Created by Lotheve on 15/7/21.
//  Copyright (c) 2015年 Lotheve. All rights reserved.
//

#import "ICSingleColumnPicker.h"

#define TOOLBAR_HEIGHT 44

@interface ICSingleColumnPicker ()<UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic, strong) UIToolbar *toolBar;
@property (nonatomic, strong) UIPickerView *picker;
@property (nonatomic, strong) UIView *bottomView;

@property (nonatomic, strong) NSString *pickerTitle;
@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) NSArray *items;

@property (nonatomic) CGRect viewFrame;

@end

@implementation ICSingleColumnPicker

- (instancetype)initWithFrame:(CGRect)frame
{
    _viewFrame = frame;
    CGFloat height = frame.size.height - TOOLBAR_HEIGHT;
    if (height < 180 && height > TOOLBAR_HEIGHT) {
        _viewFrame.size.height = 162 + TOOLBAR_HEIGHT;
    }else if (height >= 180 && height < 216){
        _viewFrame.size.height = 180 + TOOLBAR_HEIGHT;
    }else if (height >= 216){
        _viewFrame.size.height = 216 + TOOLBAR_HEIGHT;
    }
    self = [super initWithFrame:_viewFrame];
    if (self) {
        _items = [NSMutableArray array];
        [self addSubview:self.bottomView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame withSelectItems:(NSArray *)items{
    if (self = [self initWithFrame:frame]) {
        _items = [NSArray arrayWithArray:items];
    }
    return self;
}

- (UIView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, _viewFrame.size.width, _viewFrame.size.height)];
        _bottomView.backgroundColor = [UIColor whiteColor];
        [_bottomView addSubview:self.toolBar];
        [_bottomView addSubview:self.picker];
    }
    return _bottomView;
}

- (UIToolbar *)toolBar{
    if (!_toolBar) {
        _toolBar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, _viewFrame.size.width, TOOLBAR_HEIGHT)];
        _toolBar.barStyle = UIBarStyleBlack;
        UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        UIBarButtonItem *selectItem = [[UIBarButtonItem alloc]initWithTitle:@"确定" style:UIBarButtonItemStyleDone target:self action:@selector(selectAction)];
        UIBarButtonItem *cancelItem = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancelAction)];
        [_toolBar setItems:@[cancelItem,spaceItem,selectItem]];
        [_toolBar addSubview:self.titleLabel];
    }
    return _toolBar;
}

- (UIPickerView *)picker{
    if (!_picker) {
        _picker = [[UIPickerView alloc]initWithFrame:CGRectMake(0, TOOLBAR_HEIGHT, _viewFrame.size.width, _viewFrame.size.height - TOOLBAR_HEIGHT)];
        _picker.backgroundColor = [UIColor lightGrayColor];
        _picker.delegate = self;
        _picker.dataSource = self;
        _picker.userInteractionEnabled = YES;
        _picker.showsSelectionIndicator = YES;
    }
    return _picker;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(50, 0, _viewFrame.size.width - 100, 50)];
        _titleLabel.font = [UIFont systemFontOfSize:18.0];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = [UIColor orangeColor];
    }
    return _titleLabel;
}

#pragma mark - public methods
- (void)setTitle:(NSString *)title{
    _titleLabel.text = title;
}

#pragma mark - private methods
- (void)selectAction{
    if (self.delegate && [self.delegate respondsToSelector:@selector(pickerView:didSelectRow:)]) {
        [self.delegate pickerView:self didSelectRow:[self.picker selectedRowInComponent:0]];
    }
}

- (void)cancelAction{
    if (self.delegate && [self.delegate respondsToSelector:@selector(pickerViewDidCancelSelection:)]) {
        [self.delegate pickerViewDidCancelSelection:self];
    }
}

#pragma mark - UIPickerViewDataSource && UIPickerViewDelegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return _items.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return _items[row];
}

@end
