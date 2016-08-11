//
//  ICWebViewController.m
//  ICGeneral
//
//  Created by Lotheve on 15/7/23.
//  Copyright (c) 2015年 Lotheve. All rights reserved.
//

#import "ICWebViewDemo.h"
#import "ICWebView.h"

@interface ICWebViewDemo ()

@property (nonatomic, strong) ICWebView *webView;

@end

@implementation ICWebViewDemo

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadBaseUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)loadBaseUI{
    _webView = [[ICWebView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 64) startLoad:^(UIWebView *webView) {
        NSLog(@"start");
    } finishLoad:^(UIWebView *webView) {
        NSLog(@"finish");
    } failLoad:^(UIWebView *webView, NSError *error) {
        NSLog(@"fail");
    }];
    _webView.scalesPageToFit = YES;
    [self.view addSubview:_webView];
//    [_webView setBoundHeight:400];
    
    NSURL *URL = [NSURL URLWithString:@"http://baidu.com"];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    [_webView loadRequest:request];
}

@end
