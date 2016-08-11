//  ICSelectedAsset.m
//  Created by Lotheve on 15/7/7.

#import "ICSelectedAsset.h"

@implementation ICSelectedAsset

- (id)initWithAssetView:(ICAssetView *)assetView withFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.assetView = assetView;
        [self setBaseUI];
    }
    return self;
}

- (void)setBaseUI{
    _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    _imageView.contentMode = UIViewContentModeScaleToFill;
    _imageView.image = [UIImage imageWithCGImage:[self.assetView.asset thumbnail]];
    [self addSubview:_imageView];
    
    _maskView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    _maskView.contentMode = UIViewContentModeScaleToFill;
    _maskView.image = [UIImage imageNamed:@"TTImagePickerBar_RoundCornerMask"];
    [self addSubview:_maskView];

    UIImage *deleteImage = [UIImage imageNamed:@"TTImagePickerBar_DeleteBtnBg"];
    _deleteButton = [[UIButton alloc]initWithFrame:CGRectMake(-5, -5, deleteImage.size.width, deleteImage.size.height)];
    [_deleteButton setImage:deleteImage forState:UIControlStateNormal];
    [_deleteButton addTarget:self action:@selector(deleteAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_deleteButton];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(deleteAction)];
    [self addGestureRecognizer:tap];
}

- (void)deleteAction{
    [self.assetView performSelector:@selector(clickAction)];
}

@end
