//
//  ICTextFieldDemo.m
//  ICGeneral
//
//  Created by Lotheve on 15/7/21.
//  Copyright (c) 2015年 Lotheve. All rights reserved.
//

#import "ICTextFieldDemo.h"
#import "ICTextField.h"

@interface ICTextFieldDemo ()

@property (strong, nonatomic)ICTextField *textField1;
@property (strong, nonatomic)ICTextField *textField2;
@property (strong, nonatomic)ICTextField *textField3;

@end

@implementation ICTextFieldDemo

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"ICTextField";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    [self loadBaseUI];
}

- (void)loadBaseUI{
    [self.view addSubview:self.textField1];
    [self.view addSubview:self.textField2];
    [self.view addSubview:self.textField3];
}

#pragma mark- Getter, Setter
- (ICTextField*)textField1{
    if (!_textField1) {
        UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
        [view1 setBackgroundColor:[UIColor yellowColor]];
        _textField1 = [[ICTextField alloc] initWithFrame:CGRectMake(20, 100, 200, 40)];
        [_textField1 setPlaceholder:@"你十分了解阿斯达克解放啦水电费拉沙德"
                         withColor:[UIColor colorWithRed:0.712 green:0.814 blue:0.921 alpha:1.000]
                              Font:[UIFont systemFontOfSize:12]];
        [_textField1 setTextFieldRectWithLeftSpace:10];
        [_textField1 setTextFieldRectWithRightSpace:20];
        [_textField1 setLeftView:view1
                  rectForBounds:CGRectMake(0, 0, 30, 30)];
    }
    return _textField1;
}

- (ICTextField*)textField2{
    if (!_textField2) {
        UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
        [view2 setBackgroundColor:[UIColor greenColor]];
        _textField2 = [[ICTextField alloc] initWithFrame:CGRectMake(20, 200, 200, 40)];
        [_textField2 setPlaceholder:@"你十分了解阿斯达克解放啦水电费拉沙德"
                          withColor:[UIColor colorWithRed:0.712 green:0.814 blue:0.921 alpha:1.000]
                               Font:[UIFont systemFontOfSize:12]];
        [_textField2 setTextFieldRectWithLeftSpace:10];
        [_textField2 setTextFieldRectWithRightSpace:0];
        [_textField2 setRightView:view2
                    rectForBounds:CGRectMake(_textField2.bounds.size.width-55, 0, 55, 40)];
    }
    return _textField2;
}

- (ICTextField*)textField3{
    if (!_textField3) {
        _textField3 = [[ICTextField alloc] initWithFrame:CGRectMake(20, 300, 200, 40)];
        [_textField3 setPlaceholder:@"你十分了解阿斯达克解放啦水电费sdfasdfasdfasd沙德"
                          withColor:[UIColor colorWithRed:0.712 green:0.814 blue:0.921 alpha:1.000]
                               Font:[UIFont systemFontOfSize:12]];
        [_textField3 setTextFieldRectWithLeftSpace:10];
        [_textField3 setTextFieldRectWithRightSpace:-10];
    }
    return _textField3;
}

@end
