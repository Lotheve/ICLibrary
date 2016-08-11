//
//  UIAlertView+Additions.m
//  ICGeneral
//
//  Created by Lotheve on 15/7/22.
//  Copyright (c) 2015年 Lotheve. All rights reserved.
//

#import "UIAlertView+Additions.h"
#import <objc/runtime.h>

static void* cancelBlockKey;
static void* otherButtonBlockKey;

@implementation UIAlertView (Additions)

- (CancelBlock)cancelBlock{
    return objc_getAssociatedObject(self, &cancelBlockKey);
}

- (void)setCancelBlock:(CancelBlock)cancelBlock{
    objc_setAssociatedObject(self, &cancelBlockKey, cancelBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (OtherButtonBlock)otherButtonBlock{
    return objc_getAssociatedObject(self, &otherButtonBlockKey);
}

- (void)setOtherButtonBlock:(OtherButtonBlock)otherButtonBlock{
    objc_setAssociatedObject(self, &otherButtonBlockKey, otherButtonBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

+ (UIAlertView *)alertViewWithTitle:(NSString *)title
                            message:(NSString *)message{
    return [UIAlertView alertViewWithTitle:title
                                   message:message
                         cancelButtonTitle:@"取消"];
}

+ (UIAlertView *)alertViewWithTitle:(NSString *)title
                            message:(NSString *)message
                  cancelButtonTitle:(NSString *)cancelButtonTitle{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:title
                                                   message:message
                                                  delegate:nil
                                         cancelButtonTitle:cancelButtonTitle
                                         otherButtonTitles: nil];
    [alert show];
    return alert;
}

+ (UIAlertView *)alertViewWithTitle:(NSString *)title
                            message:(NSString *)message
                  cancelButtonTitle:(NSString *)cancelButtonTitle
                   otherButtonTitle:(NSArray *)otherButtonTitles
                  cancelButtonBlock:(CancelBlock)cancelBlock
                   otherButtonBlock:(OtherButtonBlock)otherButtonBlck{
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:title
                                                   message:message
                                                  delegate:[self class]
                                                  //设置代理为UIAlertView类
                                         cancelButtonTitle:cancelButtonTitle
                                         otherButtonTitles:nil];
    
    [alert setCancelBlock:cancelBlock];
    [alert setOtherButtonBlock:otherButtonBlck];
    
    for (NSString *title in otherButtonTitles) {
        [alert addButtonWithTitle:title];
    }

    [alert show];
    return alert;
}

#pragma mark - UIAlertViewDelegate
//修改代理方法为类方法
+ (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{
    if (buttonIndex == alertView.cancelButtonIndex) {
        if (alertView.cancelBlock) {
            alertView.cancelBlock();
        }
    }else{
        if (alertView.otherButtonBlock) {
            alertView.otherButtonBlock(buttonIndex - 1);   
        }
    }
}

@end
