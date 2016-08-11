//
//  ICDatePicker.m
//
//  Created by Lotheve on 15/7/21.
//  Copyright (c) 2015年 Lotheve. All rights reserved.
//

#import "ICDatePicker.h"

#define TOOLBAR_HEIGHT 44
#define DATEPICKER_HEIGHT 216

@interface ICDatePicker ()<UIPickerViewDelegate, UIPickerViewDataSource>

@property (strong, nonatomic) UIPickerView *datePicker;
@property (strong, nonatomic) UIToolbar    *toolBar;

@property (nonatomic        ) ICDatePickerMode         datePickerMode;
@property (strong, nonatomic) ICDatePickerCertainBlock certainBlock;
@property (strong, nonatomic) ICDatePickerCancelBlock  cancelBlock;
@property (strong, nonatomic) NSArray                  *years;//从1900到现在的所有年份
@property (strong, nonatomic) NSArray                  *month;//一年中的月份
@property (strong, nonatomic) NSString                 *selectString;

@end

@implementation ICDatePicker

- (instancetype)initDatePickerWithLeftUpPoint:(CGPoint)point DatePickerMode:(ICDatePickerMode)datePickerMode andCertainBlock:(ICDatePickerCertainBlock)certainBlock cancelBlock:(ICDatePickerCancelBlock)cancelBlock{
    self = [super initWithFrame:CGRectMake(point.x, point.y, [UIScreen mainScreen].bounds.size.width, DATEPICKER_HEIGHT+TOOLBAR_HEIGHT)];
    self.userInteractionEnabled = YES;
    self.datePickerMode = datePickerMode;
    self.cancelBlock = cancelBlock;
    self.certainBlock = certainBlock;
    if (self) {
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self addSubview:self.toolBar];
    [self addSubview:self.datePicker];
}

#pragma mark- Getter
- (UIPickerView*)datePicker{
    if (!_datePicker) {
        _datePicker = [[UIPickerView alloc]initWithFrame:CGRectMake(0, TOOLBAR_HEIGHT, self.frame.size.width, DATEPICKER_HEIGHT)];
        _datePicker.delegate = self;
        _datePicker.dataSource = self;
    }
    return _datePicker;
}

- (UIToolbar*)toolBar{
    if (!_toolBar) {
        _toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, TOOLBAR_HEIGHT)];
        //BarButtonItem
        UIBarButtonItem *certainButton = [[UIBarButtonItem alloc]initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(actionCertain:)];
        UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(actionCancel:)];
        UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        _toolBar.items = @[cancelButton, spaceItem, certainButton];
    }
    return _toolBar;
}

- (NSString*)selectString{
    if (!_selectString) {
        if (self.datePickerMode == ICDatePickerModeYear) {
            self.selectString = [self.years objectAtIndex:0];
        }else if(self.datePickerMode == ICDatePickerModeMonth){
            self.selectString = [self.month objectAtIndex:0];
        }else if (self.datePickerMode == ICDatePickerModeYearAndMonth){
            self.selectString = [NSString stringWithFormat:@"%@--%@", [self.years objectAtIndex:0], [self.month objectAtIndex:0]];
        }
    }
    return _selectString;
}

- (NSArray*)month{
    if (!_month) {
        _month = [[NSArray alloc]initWithObjects:@1, @2, @3, @4, @5, @6, @7, @8, @9, @10, @11, @12, nil];
    }
    return _month;
}

- (NSArray*)years{
    if (!_years) {
        NSDate *date = [NSDate date];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
        [dateFormatter setDateFormat:@"yyyy"];
        NSString *time = [dateFormatter stringFromDate:date];
        
        NSMutableArray *tempArray = [[NSMutableArray alloc]init];
        NSInteger nowYear = [time integerValue];
        for (int i=1900; i<=nowYear; i++) {
            [tempArray addObject:[NSNumber numberWithUnsignedInteger:i]];
        }
        _years = [[NSArray alloc]initWithArray:tempArray];
    }
    return _years;
}

#pragma mark- Private method
- (void)actionCertain:(UIBarButtonItem*)buttonItem{
    if (self.certainBlock) {
        self.certainBlock(self.datePicker, self.selectString);
    }
}

- (void)actionCancel:(UIBarButtonItem*)buttonItem{
    if (self.cancelBlock) {
        self.cancelBlock(self.datePicker, self.selectString);
    }
}

#pragma mark- UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    if (self.datePickerMode == ICDatePickerModeYearAndMonth) {
        return 2;
    }else{
        return 1;
    }
    
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (self.datePickerMode == ICDatePickerModeYear) {
        return [self.years count];
    }else if(self.datePickerMode == ICDatePickerModeMonth){
        return [self.month count];
    }else if(self.datePickerMode == ICDatePickerModeYearAndMonth){
        if (component == 0) {
            return [self.years count];
        }else{
            return [self.month count];
        }
    }else{
        return 0;
    }
}

#pragma mark- UIPickerViewDelegate
- (NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component{
    NSString *str;
    if (self.datePickerMode == ICDatePickerModeYear) {
        str = [NSString stringWithFormat:@"%@", [self.years objectAtIndex:row]];
    }else if(self.datePickerMode == ICDatePickerModeMonth){
        str = [NSString stringWithFormat:@"%@", [self.month objectAtIndex:row]];
    }else if (self.datePickerMode == ICDatePickerModeYearAndMonth){
        if (component == 0) {
            str = [NSString stringWithFormat:@"%@", [self.years objectAtIndex:row]];
        }else{
            str = [NSString stringWithFormat:@"%@", [self.month objectAtIndex:row]];
        }
    }else{
        str = @"";
    }
    
    NSAttributedString *attributeStr = [[NSAttributedString alloc]initWithString:str];
    return attributeStr;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if (self.datePickerMode == ICDatePickerModeYear) {
        self.selectString = [self.years objectAtIndex:row];
    }else if(self.datePickerMode == ICDatePickerModeMonth){
        self.selectString = [self.month objectAtIndex:row];
    }else if (self.datePickerMode == ICDatePickerModeYearAndMonth){
        self.selectString = [NSString stringWithFormat:@"%@--%@", [self.years objectAtIndex:[pickerView selectedRowInComponent:0]], [self.month objectAtIndex:[pickerView selectedRowInComponent:1]]];
    }
}

@end