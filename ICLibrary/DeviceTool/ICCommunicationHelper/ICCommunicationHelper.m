//
//  ICCommunicationHelper.m
//
//  Created by Lotheve on 15/7/30.
//  Copyright (c) 2015年 Lotheve. All rights reserved.
//

#import "ICCommunicationHelper.h"
#import <MessageUI/MessageUI.h>

@interface ICCommunicationHelper () <MFMessageComposeViewControllerDelegate, UIWebViewDelegate, MFMailComposeViewControllerDelegate>

@property (nonatomic, strong) UIViewController *sender;  //通信发起者
@property (nonatomic, copy) SuccessFn success;
@property (nonatomic, copy) FailFn fail;
@property (nonatomic, copy) CancelFn cancelFn;

@property (nonatomic, strong) UIWebView *webView;

@end

@implementation ICCommunicationHelper

+ (ICCommunicationHelper *)shareInstance{
    static ICCommunicationHelper *helper;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
    helper = [[ICCommunicationHelper alloc]init];
    });
    return helper;
}

- (instancetype)init{
    if (self = [super init]) {
        //initialization
    }
    return self;
}

#pragma mark - 拨号
- (void)dialWithTel:(NSString *)tel{
    //webView必须为全局变量
    if (!_webView) {
        _webView = [[UIWebView alloc]init];
    }
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",tel]];
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url];
    [_webView loadRequest:request];
}

#pragma mark - 短信
- (void)sendMessageWithViewController:(UIViewController *)sender
                           Recipients:(NSArray *)recipients
                              MesBody:(NSString *)mesBody
                            SuccessFn:(SuccessFn)successFn
                               FailFn:(FailFn)failFn
                             CancelFn:(CancelFn)cancelFn{
    // 判断用户设备能否发送短信
    if (![MFMessageComposeViewController canSendText]) {
        //提示设备无法发送短信
        return;
    }
    
    MFMessageComposeViewController *controller = [[MFMessageComposeViewController alloc]init];
    controller.recipients = recipients;
    controller.body = mesBody;
    controller.messageComposeDelegate = self;
    _success = successFn;
    _fail = failFn;
    _cancelFn = cancelFn;
    _sender = sender;
    [sender presentViewController:controller animated:YES completion:nil];
}

// MFMessageComposeViewControllerDelegate代理
- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result{
    if (result == MessageComposeResultSent) {
        if (_success) {
            _success();
        }
    }else if (result == MessageComposeResultFailed){
        if (_fail) {
            _fail();
        }
    }else{
        if (_cancelFn) {
            _cancelFn();
        }
    }
    [_sender dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - 邮件
- (void)sendMailWithViewController:(UIViewController *)sender
                        Recipients:(NSArray *)recipients
                           Subject:(NSString *)subject
                          MailBody:(NSString *)mailBody
                            IsHTML:(BOOL)isHTML
                         SuccessFn:(SuccessFn)successFn
                            FailFn:(FailFn)failFn
                          CancelFn:(CancelFn)cancelFn{
    //先判断能否发送邮件
    if (![MFMailComposeViewController canSendMail]) {
        //提示设备无法发送邮件
        return;
    }
    MFMailComposeViewController *controller = [[MFMailComposeViewController alloc]init];
    [controller setToRecipients:recipients];
    [controller setSubject:subject];
    [controller setMessageBody:mailBody isHTML:isHTML];
    controller.mailComposeDelegate = self;
    _success = successFn;
    _fail = failFn;
    _cancelFn = cancelFn;
    _sender = sender;
    [_sender presentViewController:controller animated:YES completion:nil];
}

//MFMailComposeViewControllerDelegate回调
- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error{
    if (result== MFMailComposeResultSent) {
        if (_success) {
            _success();
        }
    }else if (result == MFMailComposeResultFailed){
        if (_fail) {
            _fail();
        }
    }else if (result == MFMailComposeResultCancelled){
        if (_cancelFn) {
            _cancelFn();
        }
    }else{
        //保存邮件
    }
    [_sender dismissViewControllerAnimated:YES completion:nil];
}

@end
