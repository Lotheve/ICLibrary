//
//  ICPageControlDemo.m
//  ICGeneral
//
//  Created by Lotheve on 15/7/21.
//  Copyright (c) 2015年 Lotheve. All rights reserved.
//

#import "ICPageControlDemo.h"
#import "ICPageControl.h"

@interface ICPageControlDemo ()

@property (nonatomic, strong)ICPageControl *pageControl;

@end

@implementation ICPageControlDemo

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"ICPageControl";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    [self loadBaseUI];
}

- (void)loadBaseUI{
    [self.view addSubview:self.pageControl];
    //校准线
    UIView *lineX = [[UIView alloc] initWithFrame:CGRectMake(149, 100, 2, 100)];
    UIView *liney = [[UIView alloc] initWithFrame:CGRectMake(0, 149, 300, 2)];
    liney.backgroundColor = [UIColor blackColor];
    lineX.backgroundColor = [UIColor blackColor];
    [self.view addSubview:lineX];
    [self.view addSubview:liney];
}

#pragma mark- Getter, Setter
- (ICPageControl *)pageControl{
    if (!_pageControl) {
        _pageControl = [[ICPageControl alloc] initWithFrame:CGRectMake(0, 100, 300, 100)];
        [_pageControl setBackgroundColor:[UIColor yellowColor]];
        [_pageControl setNumberOfPages:6];
        [_pageControl setCurrentPage:0];
        [_pageControl setPageControlDotsDiameter:15 dotsDistance:30];
        [_pageControl setPageControlWithPageIndicatorTintColor:[UIColor redColor] currentPageIndicatorTintColor:[UIColor blueColor]];
        [_pageControl addTarget:self action:@selector(turnPage:) forControlEvents:UIControlEventValueChanged];
    }
    return _pageControl;
}

#pragma mark- Private method
- (void)turnPage:(UIPageControl*)pageControl{
    NSLog(@"PageControl改变位置------%ld", (long)pageControl.currentPage);
    self.pageControl.currentPage = pageControl.currentPage;
}

@end
