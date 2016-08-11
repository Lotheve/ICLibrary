//
//  ICButton.m
//
//  Created by Lotheve on 15/7/20.
//  Copyright (c) 2015年 Lotheve. All rights reserved.
//

#import "ICButton.h"

@interface ICButton ()

@property (nonatomic, assign) CGRect imageRect;
@property (nonatomic, assign) CGRect titleRect;

@end

@implementation ICButton

#pragma mark - init
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //initialization
    }
    return self;
}

#pragma mark - public methods
- (void)setTitle:(NSString *)title withTitleRect:(CGRect)titleRect{
    _titleRect = titleRect;
    [self setTitle:title forState:UIControlStateNormal];
}

- (void)setImage:(UIImage *)image withImageRect:(CGRect)imageRect{
    _imageRect = imageRect;
    [self setImage:image forState:UIControlStateNormal];
}

- (void)setNormalImage:(UIImage *)normalImage withHighlightImage:(UIImage *)highlightImage{
        [self setImage:normalImage forState:UIControlStateNormal];
        [self setImage:highlightImage forState:UIControlStateHighlighted];
}

- (void)setNormalTitleColor:(UIColor *)normalColor withHighlightColor:(UIColor *)highlightColor{
        [self setTitleColor:normalColor forState:UIControlStateNormal];
        [self setTitleColor:highlightColor forState:UIControlStateHighlighted];
}

- (void)setNormalTitle:(NSString *)normalTitle withSelectedTitle:(NSString *)selectecTitle{
        [self setTitle:normalTitle forState:UIControlStateNormal];
        [self setTitle:selectecTitle forState:UIControlStateSelected];
}

- (void)setButtonType:(ICButtonType)type{
    switch (type) {
        case ICButtonTypeDefault:
            break;
        case ICButtonTypeRect:{
            self.layer.borderColor = [UIColor lightGrayColor].CGColor;
            self.layer.borderWidth = 1.0;
        }
            break;
        case ICButtonTypeRoundedRect:{
            self.layer.cornerRadius = 4.0;
            self.layer.borderColor = [UIColor lightGrayColor].CGColor;
            self.layer.borderWidth = 1.0;
        }
            break;
        default:
            break;
    }
}

#pragma mark - overwrite
- (CGRect)imageRectForContentRect:(CGRect)contentRect{
    return _imageRect ;
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect{
    return _titleRect;
}

@end
