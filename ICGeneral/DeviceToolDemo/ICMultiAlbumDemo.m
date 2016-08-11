//
//  ICMultiAlbumDemo.m
//  ICGeneral
//
//  Created by Lotheve on 15/8/3.
//  Copyright (c) 2015年 Lotheve. All rights reserved.
//

#import "ICMultiAlbumDemo.h"
#import "ICMutiAlbum.h"

@interface ICMultiAlbumDemo ()<ICMutiAlbumDelegate>

@property (nonatomic, strong) UIButton *selectBtn;
@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation ICMultiAlbumDemo

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadBaseUI];
}

- (void)loadBaseUI{
    [self.view addSubview:self.selectBtn];
    [self.view addSubview:self.imageView];
}

- (UIButton *)selectBtn{
    if (!_selectBtn) {
        _selectBtn = [[UIButton alloc]initWithFrame:(CGRect){SCREEN_WIDTH/2.0-50,100,100,40}];
        [_selectBtn setTitle:@"选择照片" forState:UIControlStateNormal];
        [_selectBtn setTitleColor:[UIColor purpleColor] forState:UIControlStateNormal];
        [_selectBtn addTarget:self action:@selector(selectAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _selectBtn;
}

- (UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc]initWithFrame:(CGRect){20,200,SCREEN_WIDTH-40,SCREEN_WIDTH-40}];
        _imageView.backgroundColor = [UIColor lightGrayColor];
        _imageView.contentMode = UIViewContentModeScaleToFill;
    }
    return _imageView;
}

- (void)selectAction:(UIButton *)sender{
    ICMutiAlbum *album = [[ICMutiAlbum alloc]init];
    album.albumDelegate = self;
    [self presentViewController:album animated:YES completion:nil];
}

#pragma mark - MutiPhotoPickerControllerDelegate
- (void)mutiImagePickerController:(ICAlbumImagePicker *)picker didFinishPickingMediaWithInfo:(NSArray *)info{
    
    NSMutableArray *images = [NSMutableArray arrayWithCapacity:info.count];
    for (NSDictionary *dic in info) {
        UIImage *image = [dic objectForKey:UIImagePickerControllerOriginalImage];
        [images addObject:image];
    }
    
    //通过imageView轮播查看结果
    _imageView.animationImages = images;
    _imageView.animationDuration = info.count;
    _imageView.animationRepeatCount = 0;
    [_imageView startAnimating];
}

- (void)mutiImagePickerControllerDidCancel:(ICAlbumImagePicker *)picker{
    NSLog(@"取消选择");
}
@end
