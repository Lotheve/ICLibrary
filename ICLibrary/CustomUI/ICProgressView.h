//
//  ICProgressView.h
//
//  Created by Lotheve on 15/7/21.
//  Copyright (c) 2015年 Lotheve. All rights reserved.
//

/**
 *  ICProgressView工具类
 */

#import <UIKit/UIKit.h>

typedef enum{
    ICProgressViewStyleRect = 0,
    ICProgressViewStyleRoundRect,
}ICProgressViewStyle;

@interface ICProgressView : UIView

@property (nonatomic) ICProgressViewStyle style;

@property (nonatomic) float progress;

@property (nonatomic, strong) UIColor *progressTintColor;

@property (nonatomic, strong) UIColor *trackTintColor;


- (instancetype)initWithFrame:(CGRect)frame withStyle:(ICProgressViewStyle)style;

- (void)setProgress:(float)progress animated:(BOOL)animated;

@end
