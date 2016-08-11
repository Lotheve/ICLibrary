//
//  ICSingleColumnPicker.h
//  ICControlerTest
//
//  Created by Lotheve on 15/7/21.
//  Copyright (c) 2015年 Lotheve. All rights reserved.
//

/**
 *  单列数据选择器，支持自定义标题
 */

#import <UIKit/UIKit.h>

@class ICSingleColumnPicker;

@protocol ICSingleRowPickerViewDelegate <NSObject>

@required

- (void)pickerViewDidCancelSelection:(ICSingleColumnPicker *)pickerView;

- (void)pickerView:(ICSingleColumnPicker *)pickerView didSelectRow:(NSInteger)row;

@end

@interface ICSingleColumnPicker : UIView

@property (nonatomic, strong) id<ICSingleRowPickerViewDelegate> delegate;

/**
 *  设置pickerView标题
 *
 *  @param title 标题
 */
- (void)setTitle:(NSString *)title;

/**
 *  初始化
 *
 *  @param frame 框架
 *  @param items 选择项
 *
 *  @return 实例
 */
- (instancetype)initWithFrame:(CGRect)frame withSelectItems:(NSArray *)items;

@end
