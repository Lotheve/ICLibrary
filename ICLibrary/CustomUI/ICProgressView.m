//
//  ICProgressView.m
//
//  Created by Lotheve on 15/7/21.
//  Copyright (c) 2015年 Lotheve. All rights reserved.
//

#import "ICProgressView.h"

@interface ICProgressView ()

@property (nonatomic, strong) UIView *progressMask;

@end

@implementation ICProgressView

#pragma mark - init

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _progressTintColor = [UIColor colorWithRed:0.000 green:0.349 blue:1.000 alpha:1.000];
        _trackTintColor = [UIColor lightGrayColor];
        
        if (!_progressMask) {
            _progressMask = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, frame.size.height)];
            _progressMask.backgroundColor = _progressTintColor;
        }
        [self addSubview:_progressMask];
        
        self.layer.masksToBounds = YES;
        self.backgroundColor = _trackTintColor;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame withStyle:(ICProgressViewStyle)style{
    self = [self initWithFrame:frame];
    if (self) {
        self.style = style;
    }
    return self;
}

#pragma mark - public method
- (void)setTrackTintColor:(UIColor *)trackTintColor{
    if (trackTintColor) {
        self.backgroundColor = trackTintColor;
    }else{
        self.backgroundColor = [UIColor lightGrayColor];
    }
}

- (void)setProgressTintColor:(UIColor *)progressTintColor{
    if (progressTintColor) {
        _progressMask.backgroundColor = progressTintColor;
    }else{
        _progressMask.backgroundColor = [UIColor lightGrayColor];
    }
}

- (void)setStyle:(ICProgressViewStyle)style{
    switch (style) {
        case ICProgressViewStyleRect:{
            self.layer.cornerRadius = CGFLOAT_MIN;
        }
            break;
        case ICProgressViewStyleRoundRect:{
            CGFloat radius = floorf(self.frame.size.height/2);
            self.layer.cornerRadius = radius;
        }
            break;
        default:
            break;
    }
}

- (void)setProgress:(float)progress{
    [self setProgress:progress animated:NO];
}

- (void)setProgress:(float)progress animated:(BOOL)animated{
    if (progress < 0) {
        _progress = 0;
    }
    if (_progress > 1) {
        _progress = 1;
    }
    CGFloat animationTime;
    if (animated) {
        animationTime = fabsf(progress - _progress);
    }else{
        animationTime = 0;
    }
    [UIView animateWithDuration:animationTime animations:^{
        _progressMask.frame = CGRectMake(0, 0, progress*self.frame.size.width, self.frame.size.height);
    } completion:^(BOOL finished) {
        _progress = progress;
    }];
}

@end
