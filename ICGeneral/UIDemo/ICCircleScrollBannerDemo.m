//
//  ICCircleScrollBannerDemo.m
//  ICGeneral
//
//  Created by Lotheve on 15/7/22.
//  Copyright (c) 2015年 Lotheve. All rights reserved.
//

#import "ICCircleScrollBannerDemo.h"
#import "ICCircleScrollBanner.h"

@interface ICCircleScrollBannerDemo ()

@property (strong, nonatomic)ICCircleScrollBanner *scrollView1;
@property (strong, nonatomic)ICCircleScrollBanner *scrollView2;

@end

@implementation ICCircleScrollBannerDemo

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.scrollView1];
    [self.view addSubview:self.scrollView2];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark- Getter, Setter
- (ICCircleScrollBanner*)scrollView1{
    if (!_scrollView1) {
        NSArray *imgs = [[NSArray alloc]initWithObjects:[UIImage imageNamed:@"warning_btn"],[UIImage imageNamed:@"warning_btn"], [UIImage imageNamed:@"warning_btn"], nil];
        _scrollView1 = [[ICCircleScrollBanner alloc]initWithFrame:CGRectMake(0, 0, 300, 200) contentImages:imgs tapBlock:^(ICCircleScrollBanner *ICScrollVIew, NSUInteger index) {
            NSLog(@"点击");
        } scrollBlock:^(ICCircleScrollBanner *ICScrollVIew, NSUInteger index) {
            NSLog(@"滚动");
        }];
        _scrollView1.layer.borderWidth = 1;
    }
    return _scrollView1;
}

- (ICCircleScrollBanner*)scrollView2{
    if (!_scrollView2) {
        _scrollView2 = [[ICCircleScrollBanner alloc]initWithFrame:CGRectMake(0, 300, 300, 200) contentImageURLs:@[@"http://cc.cocimg.com/api/uploads/20150724/1437708966850587.jpg", @"http://tp3.sinaimg.cn/2174934262/180/5718887970/1", @"http://tp4.sinaimg.cn/2873422327/180/5671083668/0", @"http://tp4.sinaimg.cn/3821006471/180/5718103005/1", @"http://tp4.sinaimg.cn/3584345627/180/5711016962/1"] tapBlock:^(ICCircleScrollBanner *ICScrollVIew, NSUInteger index) {
            NSLog(@"点击");
        } scrollBlock:^(ICCircleScrollBanner *ICScrollVIew, NSUInteger index) {
            NSLog(@"拖动");
        }];
        _scrollView2.layer.borderWidth = 1;
    }
    return _scrollView2;
}

@end
