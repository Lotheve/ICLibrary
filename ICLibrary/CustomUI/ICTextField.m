//
//  ICTextField.m
//  ICGeneral
//
//  Created by Lotheve on 15/7/20.
//  Copyright (c) 2015年 Lotheve. All rights reserved.
//

#import "ICTextField.h"

#define ImageEdgeSpace 5

@interface ICTextField ()

@property (assign, nonatomic) CGFloat textRightSpace;
@property (assign, nonatomic) CGFloat textLeftSpace;
@property (assign, nonatomic) CGRect  leftViewFrame;
@property (assign, nonatomic) CGRect  rightViewFrame;

@end

@implementation ICTextField
- (void)setPlaceholder:(NSString *)placeholder withColor:(UIColor*)color Font:(UIFont*)font{
    [self setPlaceholder:placeholder];
    
    NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc]initWithAttributedString:self.attributedPlaceholder];
    NSRange range = NSMakeRange(0, attributeStr.length);
    if (color) {
        [attributeStr addAttribute:NSForegroundColorAttributeName value:color range:range];
    }
    if (font) {
        [attributeStr addAttribute:NSFontAttributeName value:font range:range];
    }
    
    [self setAttributedPlaceholder:attributeStr];
}

- (void)setTextFieldRectWithLeftSpace:(CGFloat)leftSpace{
    self.textLeftSpace = leftSpace;
}

- (void)setTextFieldRectWithRightSpace:(CGFloat)rightSpace{
    self.textRightSpace = rightSpace;
}

- (void)setLeftView:(UIView *)leftView rectForBounds:(CGRect)frame{
    [self setLeftView:leftView];
    [self setLeftViewMode:UITextFieldViewModeAlways];
    [self setLeftViewFrame:frame];
}

- (void)setRightView:(UIView *)rightView rectForBounds:(CGRect)frame{
    [self setRightView:rightView];
    [self setRightViewMode:UITextFieldViewModeAlways];
    [self setRightViewFrame:frame];
}

#pragma mark- Private method
- (void)setPlaceholder:(NSString *)placeholder{
    [super setPlaceholder:placeholder];
    
    NSAttributedString *attributeStr = [[NSAttributedString alloc]initWithString:placeholder];
    [self setAttributedPlaceholder:attributeStr];
}

- (CGRect)textRectForBounds:(CGRect)bounds{
    bounds.size.width = bounds.size.width-self.textRightSpace-self.textLeftSpace;//默认就是空出10个像素点
    bounds.origin.x = bounds.origin.x+self.textLeftSpace;
    //左视图
    if (self.leftView) {
        CGFloat lenght = self.leftViewFrame.origin.x+self.leftViewFrame.size.width;
        bounds.size.width -= lenght;
        bounds.origin.x += lenght;
    }
    //右视图
    if (self.rightView) {
        CGFloat lenght = self.bounds.size.width-self.rightViewFrame.origin.x;
        bounds.size.width -= lenght;
    }
    return bounds;
}

- (CGRect)editingRectForBounds:(CGRect)bounds{
    bounds.size.width = bounds.size.width-self.textRightSpace-self.textLeftSpace;//默认就是空出10个像素点
    bounds.origin.x = bounds.origin.x+self.textLeftSpace;
    //左视图
    if (self.leftView) {
        CGFloat lenght = self.leftViewFrame.origin.x+self.leftViewFrame.size.width;
        bounds.size.width -= lenght;
        bounds.origin.x += lenght;
    }
    //右视图
    if (self.rightView) {
        CGFloat lenght = self.bounds.size.width-self.rightViewFrame.origin.x;
        bounds.size.width -= lenght;
    }
    return bounds;
}

- (CGRect)leftViewRectForBounds:(CGRect)bounds{
    if ([NSStringFromCGRect(self.leftViewFrame) isEqualToString:NSStringFromCGRect(CGRectZero)]) {
        return bounds;
    }
    return self.leftViewFrame;
}

- (CGRect)rightViewRectForBounds:(CGRect)bounds{
    if ([NSStringFromCGRect(self.rightViewFrame) isEqualToString:NSStringFromCGRect(CGRectZero)]) {
        return bounds;
    }
    return self.rightViewFrame;
}
@end
