//
//  ICDoubleColumnPicker.m
//
//  Created by Lotheve on 15/7/21.
//  Copyright (c) 2015年 Lotheve. All rights reserved.
//

#import "ICDoubleColumnPicker.h"

#define TOOLBAR_HEIGHT 44

@interface ICDoubleColumnPicker ()<UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic, strong) UIToolbar *toolBar;
@property (nonatomic, strong) UIPickerView *picker;
@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) UILabel *titleLabel;


@property (nonatomic, strong) NSArray *firstCompItems;    //第一列选项组
@property (nonatomic, strong) NSArray *secondCompItems;   //第二列选项组
@property (nonatomic, strong) NSDictionary *dataSource;        //有依赖关系的数据源

@property (nonatomic) CGRect viewFrame;
@property (nonatomic) ICDoubleColumnPickerType type;     //数据选择器类型
@property (nonatomic) NSInteger hostCurrentIndex;    //主列当前所在位置

@end

@implementation ICDoubleColumnPicker

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
        _firstCompItems = [NSArray array];
        _secondCompItems = [NSArray array];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame firstComponentItems:(NSArray *)firstItems secondComponentItems:(NSArray *)secondItems{
    if (self = [self initWithFrame:frame]) {
        _firstCompItems = [firstItems copy];
        _secondCompItems = [secondItems copy];
        _type = ICDoubleColumnPickerIndependence;
        _hostCurrentIndex = 0;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame withArrayItems:(NSDictionary *)items forRelyType:(ICDoubleColumnPickerType)pickerViewType{
    if (self = [self initWithFrame:frame]) {
        _dataSource = [items copy];
        _type = pickerViewType;
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [self addSubview:self.bottomView];
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
        UIBarButtonItem *titleItem = [[UIBarButtonItem alloc]initWithCustomView:self.titleLabel];
        UIBarButtonItem *selectItem = [[UIBarButtonItem alloc]initWithTitle:@"确定" style:UIBarButtonItemStyleDone target:self action:@selector(selectAction)];
        UIBarButtonItem *cancelItem = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancelAction)];
        [_toolBar setItems:@[cancelItem,spaceItem,titleItem,spaceItem,selectItem]];
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
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(50, 0, _viewFrame.size.width - 100, TOOLBAR_HEIGHT)];
        _titleLabel.font = [UIFont systemFontOfSize:18.0];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = [UIColor orangeColor];
    }
    return _titleLabel;
}

#pragma mark - public methods
- (void)setTitle:(NSString *)title{
    self.titleLabel.text = title;
}

#pragma mark - private methods
- (void)selectAction{
    if (self.delegate && [self.delegate respondsToSelector:@selector(pickerView:didSelectRowOnFirstComponent:secondComponent:)]) {
        [self.delegate pickerView:self
     didSelectRowOnFirstComponent:[self.picker selectedRowInComponent:0]
                  secondComponent:[self.picker selectedRowInComponent:1]];
    }
}

- (void)cancelAction{
    if (self.delegate && [self.delegate respondsToSelector:@selector(pickerViewDidCancelSelection:)]) {
        [self.delegate pickerViewDidCancelSelection:self];
    }
}

#pragma mark - UIPickerViewDataSource && UIPickerViewDelegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    NSInteger numberOfRow = 0;
    
    if (_type == ICDoubleColumnPickerIndependence) {
        //无依赖关系
        if (component == 0) {
            numberOfRow = _firstCompItems.count;
        }else{
            numberOfRow = _secondCompItems.count;
        }
        
    }else if (_type == ICDoubleColumnPickerRightRelyLeft){
        //右列依赖左列
        NSArray *leftItems = [NSArray arrayWithArray:[_dataSource allKeys]];

        NSArray *rightItems = [NSArray array];
        if (leftItems.count) {
            if ([[_dataSource objectForKey:leftItems[_hostCurrentIndex]] isKindOfClass:[NSArray class]]) {
                rightItems = [[_dataSource objectForKey:leftItems[_hostCurrentIndex]] copy];
            }else{
                return 0;
            }
        }
        if (component == 0) {
            numberOfRow = leftItems.count;
        }else{
            numberOfRow = rightItems.count;
        }
    }else if (_type == ICDoubleColumnPickerLeftRelyRight){
        //左列依赖右列
        NSArray *rightItems = [NSArray arrayWithArray:[_dataSource allKeys]];
        NSArray *leftItems = [NSArray array];
        if (rightItems.count) {
            if ([[_dataSource objectForKey:rightItems[_hostCurrentIndex]] isKindOfClass:[NSArray class]]) {
                leftItems = [[_dataSource objectForKey:rightItems[_hostCurrentIndex]] copy];
            }else{
                return 0;
            }
        }
        if (component == 0) {
            numberOfRow = leftItems.count;
        }else{
            numberOfRow = rightItems.count;
        }
    }

    return numberOfRow;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    NSString *title;

    if (_type == ICDoubleColumnPickerIndependence) {
        //无依赖关系
        if (component == 0) {
            title = _firstCompItems[row];
        }else{
            title = _secondCompItems[row];
        }
    }else if (_type == ICDoubleColumnPickerRightRelyLeft){
        //右列依赖左列
        
        NSArray *leftItems = [NSArray arrayWithArray:[_dataSource allKeys]];
        NSArray *rightItem;
        if (![[_dataSource objectForKey:leftItems[_hostCurrentIndex]] isKindOfClass:[NSArray class]]) {
            return 0;
        }else{
            rightItem = [NSArray arrayWithArray:[_dataSource objectForKey:leftItems[_hostCurrentIndex]]];
        }
        
        if (component == 0) {
            title = leftItems[row];
        }else{
            title = rightItem[row];
        }

    }else if (_type == ICDoubleColumnPickerLeftRelyRight){
        //左列依赖右列
        NSArray *rightItem = [NSArray arrayWithArray:[_dataSource allKeys]];
        NSArray *leftItems;
        if (![[_dataSource objectForKey:rightItem[_hostCurrentIndex]] isKindOfClass:[NSArray class]]) {
            return 0;
        }else{
            leftItems = [NSArray arrayWithArray:[_dataSource objectForKey:rightItem[_hostCurrentIndex]]];
        }
        
        if (component == 0) {
            title = leftItems[row];
        }else{
            title = rightItem[row];
        }
    }
    
    return title;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if (_type == ICDoubleColumnPickerLeftRelyRight && component == 1) {
        _hostCurrentIndex = row;
        [self.picker reloadComponent:0];
        [self.picker selectRow:0 inComponent:0 animated:YES];
        
    }else if (_type == ICDoubleColumnPickerRightRelyLeft && component == 0){
        _hostCurrentIndex = row;
        [self.picker reloadComponent:1];
        [self.picker selectRow:0 inComponent:1 animated:YES];
    }
}

@end
