//
//  ICMediaPickerHelperDemo.m
//  ICGeneral
//
//  Created by Lotheve on 15/8/3.
//  Copyright (c) 2015年 Lotheve. All rights reserved.
//

#import "ICMediaPickerHelperDemo.h"
#import "ICMediaPickerHelper.h"


@implementation ICMediaPickerHelperDemo

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
    button.backgroundColor = [UIColor redColor];
    [button setTitle:@"照片相册" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(actionImagePicker) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    UIButton *button1 = [[UIButton alloc]initWithFrame:CGRectMake(0, 100, 100, 100)];
    button1.backgroundColor = [UIColor blueColor];
    [button1 setTitle:@"拍照" forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(actionImageCamera) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button1];
    
    UIButton *button2 = [[UIButton alloc]initWithFrame:CGRectMake(0, 200, 100, 100)];
    button2.backgroundColor = [UIColor blueColor];
    [button2 setTitle:@"视频相册" forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(actionVedioAlbram) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button2];
    
    UIButton *button3 = [[UIButton alloc]initWithFrame:CGRectMake(0, 300, 100, 100)];
    button3.backgroundColor = [UIColor blueColor];
    [button3 setTitle:@"录像" forState:UIControlStateNormal];
    [button3 addTarget:self action:@selector(actionVedioCamra) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button3];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)actionImagePicker{
    ICMediaPickerHelper *imgPicker = [ICMediaPickerHelper shareInstance];
    [imgPicker imagePickerWithMode:ICMediaPickerTypePhotoAlbum presentViewController:self didFinishPickBlock:^(UIImagePickerController *pickerController, UIImage *image, UIImage *thumbnail) {
        UIImageView *imgView = [[UIImageView alloc]initWithImage:image];
        imgView.frame = CGRectMake(100, 100, 100, 100);
        [self.view addSubview:imgView];
        UIImageView *imgView1 = [[UIImageView alloc]initWithImage:thumbnail];
        imgView1.frame = CGRectMake(100, 200, 100, 100);
        [self.view addSubview:imgView1];
    }];
}

- (void)actionImageCamera{
    ICMediaPickerHelper *imgPicker = [ICMediaPickerHelper shareInstance];
    [imgPicker imagePickerWithMode:ICMediaPickerTypePhotoCamera presentViewController:self didFinishPickBlock:^(UIImagePickerController *pickerController, UIImage *image, UIImage *thumbnail) {
        UIImageView *imgView = [[UIImageView alloc]initWithImage:image];
        imgView.contentMode = UIViewContentModeScaleToFill;
        imgView.frame = CGRectMake(100, 100, 100, 100);
        [self.view addSubview:imgView];
        UIImageView *imgView1 = [[UIImageView alloc]initWithImage:thumbnail];
        imgView1.frame = CGRectMake(100, 200, 100, 100);
        [self.view addSubview:imgView1];
    }];
}

- (void)actionVedioAlbram{
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    NSString *desPath = [path stringByAppendingPathComponent:@"video.mp4"];
    ICMediaPickerHelper *imgPicker = [ICMediaPickerHelper shareInstance];
    [imgPicker vedioPickerWithMode:ICMediaPickerTypeVideoAlbum savePath:desPath presentViewController:self didSuccessPickBlock:^(UIImagePickerController *pickerController, NSURL *mediaUrl, NSString *savePath) {
        NSLog(@"chenggong");
    } failedBlock:^(UIImagePickerController *pickerController, NSURL *mediaUrl, NSString *savePath) {
        NSLog(@"shibai");
    }];
}

- (void)actionVedioCamra{
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    NSString *desPath = [path stringByAppendingPathComponent:@"video.mp4"];
    ICMediaPickerHelper *imgPicker = [ICMediaPickerHelper shareInstance];
    [imgPicker vedioPickerWithMode:ICMediaPickerTypeVideoCamera savePath:desPath presentViewController:self didSuccessPickBlock:^(UIImagePickerController *pickerController, NSURL *mediaUrl, NSString *savePath) {
        NSLog(@"chenggong");
    } failedBlock:^(UIImagePickerController *pickerController, NSURL *mediaUrl, NSString *savePath) {
        NSLog(@"shibai");
    }];
}


@end
