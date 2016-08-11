//
//  ICTextView.m
//  test
//
//  Created by Lotheve on 15/7/21.
//  Copyright (c) 2015年 Lotheve. All rights reserved.
//

#import "ICTextView.h"

@interface ICTextView ()

@property (strong, nonatomic)NSAttributedString *placeholder;
@property (strong, nonatomic)UIColor *orignalTextColor;

@end

@implementation ICTextView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(actionTextViewDidBeginEditing) name:UITextViewTextDidBeginEditingNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(actionTextViewDidEndEditing) name:UITextViewTextDidEndEditingNotification object:nil];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(actionTextViewDidBeginEditing) name:UITextViewTextDidBeginEditingNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(actionTextViewDidEndEditing) name:UITextViewTextDidEndEditingNotification object:nil];
    }
    return self;
}

- (void)setPlaceHolder:(NSString *)placeholder{
    self.placeholder = [[NSAttributedString alloc]initWithString:placeholder attributes:@{NSForegroundColorAttributeName:[UIColor colorWithWhite:0.755 alpha:1.000]}];
    self.attributedText = self.placeholder;
}

#pragma mark- Private
- (void)actionTextViewDidBeginEditing{
    if ([self.text isEqualToString:self.placeholder.string]) {
        self.attributedText = nil;
        if (self.orignalTextColor) {
            super.textColor = self.orignalTextColor;
        }else{
            self.textColor = [UIColor blackColor];
        }
    }
}

- (void)actionTextViewDidEndEditing{
    if ([self.text isEqualToString:@""]) {
        self.attributedText = self.placeholder;
    }
}

- (void)setTextColor:(UIColor *)textColor{
    self.orignalTextColor = textColor;
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
