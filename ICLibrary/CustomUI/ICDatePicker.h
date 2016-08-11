//
//  ICDatePicker.h
//
//  Created by Lotheve on 15/7/21.
//  Copyright (c) 2015年 Lotheve. All rights reserved.
//

/*!
 1）	只有年份或只有月份的日期选择器,有确定取消按钮。
 2）	只有年份和月份的日期选择器,有确定取消按钮。

 */

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ICDatePickerMode) {
    ICDatePickerModeYear,
    ICDatePickerModeMonth,
    ICDatePickerModeYearAndMonth,
};

typedef void(^ICDatePickerCertainBlock)(UIPickerView *dataPicker, NSString *selected);
typedef void(^ICDatePickerCancelBlock)(UIPickerView *dataPicker, NSString *selected);


@interface ICDatePicker : UIView

/**
 *  设置picker的类型和按钮触发事件
 *
 *  @param point          左上角的位置
 *  @param datePickerMode picker的类型
 *  @param certainBlock   点击确定触发
 *  @param cancelBlock    点击取消触发
 *
 *  @return 返回dataPicker
 */
- (instancetype)initDatePickerWithLeftUpPoint:(CGPoint)point DatePickerMode:(ICDatePickerMode)datePickerMode andCertainBlock:(ICDatePickerCertainBlock)certainBlock cancelBlock:(ICDatePickerCancelBlock)cancelBlock;

@end
