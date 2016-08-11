//
//  UIButton+Additions.m
//  ICGeneral
//
//  Created by Lotheve on 15/7/28.
//  Copyright (c) 2015年 Lotheve. All rights reserved.
//

#import "UIButton+Additions.h"

@implementation UIButton (Additions)

- (void)alignImageAboveTitle{
    //必须先将内容至于左上角 否则偏移不准
    self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    self.contentVerticalAlignment = UIControlContentVerticalAlignmentTop;
    CGRect buttonBounds = self.bounds;
    CGRect imageBounds = self.imageView.bounds;
    CGRect titleBounds = self.titleLabel.bounds;
    [self setImageEdgeInsets:UIEdgeInsetsMake((buttonBounds.size.height-imageBounds.size.height-titleBounds.size.height)/2.0, (buttonBounds.size.width-imageBounds.size.width)/2.0, 0, 0)];
    [self setTitleEdgeInsets:UIEdgeInsetsMake((buttonBounds.size.height-imageBounds.size.height-titleBounds.size.height)/2.0+imageBounds.size.height, (buttonBounds.size.width-titleBounds.size.width)/2.0-imageBounds.size.width, 0, 0)];
}

- (void)alignImageRightTitle{
    self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    self.contentVerticalAlignment = UIControlContentVerticalAlignmentTop;
    CGRect buttonBounds = self.bounds;
    CGRect imageBounds = self.imageView.bounds;
    CGRect titleBounds = self.titleLabel.bounds;
    [self setTitleEdgeInsets:UIEdgeInsetsMake((buttonBounds.size.height-titleBounds.size.height)/2.0, (buttonBounds.size.width-imageBounds.size.width-titleBounds.size.width)/2.0-imageBounds.size.width, 0, 0)];
    [self setImageEdgeInsets:UIEdgeInsetsMake((buttonBounds.size.height-imageBounds.size.height)/2.0, (buttonBounds.size.width-imageBounds.size.width-titleBounds.size.width)/2.0+titleBounds.size.width, 0, 0)];
}

@end
