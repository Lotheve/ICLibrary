//
//  ICPageControl.m
//
//  Created by Lotheve on 15/7/21.
//  Copyright (c) 2015年 Lotheve. All rights reserved.
//

#import "ICPageControl.h"

@interface ICPageControl ()

@property (nonatomic)CGFloat dotsDiameter;
@property (nonatomic)CGFloat dotsDistance;
@end

@implementation ICPageControl
- (void)setPageControlWithPageIndicatorTintColor:(UIColor*)pageIndicatorTintColor
                   currentPageIndicatorTintColor:(UIColor*)currentPageIndicatorTintColor{
    //直接使用系统方法
    self.pageIndicatorTintColor = pageIndicatorTintColor;
    self.currentPageIndicatorTintColor = currentPageIndicatorTintColor;
}

- (void)setPageControlDotsDiameter:(CGFloat)diameter dotsDistance:(CGFloat)distance{
    self.dotsDiameter = diameter;
    self.dotsDistance = distance;
}


#pragma mark- Private method
-(void)updateDots{
    if (self.dotsDiameter==0 || self.dotsDistance==0){
        return;
    }
    
    CGFloat middleNum = ((CGFloat)[self.subviews count]-1.0)/2.0;
    for (int i=0; i<[self.subviews count]; i++) {
        UIView* dot = [self.subviews objectAtIndex:i];
        //设置大小
        CGSize size;
        size.height = self.dotsDiameter;     //自定义圆点的大小
        size.width = self.dotsDiameter;      //自定义圆点的大小
        dot.layer.cornerRadius = self.dotsDiameter/2;
        
        //设置位置
        CGFloat number = i-middleNum;
        CGFloat dotX = number*(self.dotsDistance+self.dotsDiameter) + self.frame.size.width/2.0 - self.dotsDiameter/2.0;
        CGFloat dotY = dot.frame.origin.y-self.dotsDiameter/2.0+3.5;
        
        [dot setFrame:CGRectMake(dotX, dotY, size.width, size.width)];
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [self updateDots];
}


-(void)setCurrentPage:(NSInteger)page
{
    [super setCurrentPage:page];
    [self updateDots];
}
@end
