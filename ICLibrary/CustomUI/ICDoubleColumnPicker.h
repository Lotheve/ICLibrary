//
//  ICDoubleColumnPicker.h
//
//  Created by Lotheve on 15/7/21.
//  Copyright (c) 2015年 Lotheve. All rights reserved.
//

/**
 1）	自定义标题的双列数据选择器。
 2）	自定义标题的双列有依赖关系或没有依赖关系的选择器。
 */

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ICDoubleColumnPickerType) {
    ICDoubleColumnPickerIndependence = 0,
    ICDoubleColumnPickerRightRelyLeft,     //右列依赖左列
    ICDoubleColumnPickerLeftRelyRight,         //左列依赖右列
};

@class ICDoubleColumnPicker;

@protocol ICDoubleColumnPickerDelegate <NSObject>

@required

- (void)pickerViewDidCancelSelection:(ICDoubleColumnPicker *)pickerView;

- (void)pickerView:(ICDoubleColumnPicker *)pickerView didSelectRowOnFirstComponent:(NSInteger)firstItemIndex secondComponent:(NSInteger)secondItemIndex;

@end

@interface ICDoubleColumnPicker : UIView

@property (nonatomic, strong) id<ICDoubleColumnPickerDelegate> delegate;

/**
 *  设置pickerView标题
 *
 *  @param title 标题
 */
- (void)setTitle:(NSString *)title;

/**
 *  初始化无依赖关系的双列数据选择器
 *
 *  @param frame       框架
 *  @param firstItems  第一列选择项
 *  @param secondItems 第二列选择项
 *
 *  @return pickerView实例
 */
- (instancetype)initWithFrame:(CGRect)frame firstComponentItems:(NSArray *)firstItems secondComponentItems:(NSArray *)secondItems;

/**
 *  初始化有依赖关系的双列数据选择器
 *
 *  @param frame            框架
 *  @param items            数据源（字典类型，字典所有key作为第一列选择项，每一个key的值都为数组，数组内容作为第二列选择项）
 *  @param pickerViewType   选择器类型
 *
 *  @return pickerView实例
 */
- (instancetype)initWithFrame:(CGRect)frame withArrayItems:(NSDictionary *)items forRelyType:(ICDoubleColumnPickerType)pickerViewType;

@end
