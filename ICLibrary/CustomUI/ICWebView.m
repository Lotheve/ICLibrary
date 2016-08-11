//
//  ICWebView.m
//  测试
//
//  Created by Lotheve on 15/7/22.
//  Copyright (c) 2015年 Lotheve. All rights reserved.
//

#import "ICWebView.h"

@interface ICWebView ()

@property (nonatomic) BOOL enable;

@property (nonatomic, copy) startLoadBlock startBlock;
@property (nonatomic, copy) finishLoadBlock finishBlock;
@property (nonatomic, copy) failLoadBlock failBlock;

@property (nonatomic) CGFloat boundHeight;

@end

@implementation ICWebView

#pragma mark - init
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.delegate = self;
        self.boundHeight = frame.size.height;   //默认最大高度为初始化高度
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)initialFrame
            startLoad:(startLoadBlock)start
           finishLoad:(finishLoadBlock)finish
             failLoad:(failLoadBlock)fail{
    
    if (self = [self initWithFrame:initialFrame]) {
        self.enable = YES;
        self.startBlock = start;
        self.finishBlock = finish;
        self.failBlock = fail;
    }
    return self;
}

#pragma mark - public methods
- (void)setLoadEnable:(BOOL)isEnable{
    _enable = isEnable;
}

- (void)setBoundHeight:(CGFloat)height{
    _boundHeight = height;
    if (_boundHeight < self.frame.size.height) {
        [self reloadFrameWithHeight:_boundHeight];
    }
    
}

#pragma mark - private methods
- (void)reloadFrameWithHeight:(CGFloat)height{
    
    if (height <= self.boundHeight) {
        CGRect newFrame = self.frame;
        newFrame.size.height = height;
        self.frame = newFrame;
    }else{
        CGRect newFrame = self.frame;
        newFrame.size.height = _boundHeight;
        self.frame = newFrame;
    }
}

#pragma maek - UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    return _enable;
}

- (void)webViewDidStartLoad:(UIWebView *)webView{
    if (self.startBlock) {
        self.startBlock(webView);
    }
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    if (self.finishBlock) {
        self.finishBlock(webView);
    }
    CGFloat height = [[webView stringByEvaluatingJavaScriptFromString:@"document.body.offsetHeight"] floatValue];
    [self reloadFrameWithHeight:height];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    if (self.failBlock) {
        self.failBlock(webView, error);
    }
}

@end
