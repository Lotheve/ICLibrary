//  ICAssetView.m
//  Created by Lotheve on 15/7/7.

#import "ICAssetView.h"

@implementation ICAssetView

- (id)initWithAsset:(ALAsset *)asset WithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.asset = asset;
        [self setBaseUI];
    }
    return self;
}

- (void)setBaseUI{
    _photoView = [[UIImageView alloc]initWithFrame:(CGRect){0,0,self.frame.size.width,self.frame.size.height}];
    _photoView.backgroundColor = [UIColor clearColor];
    _photoView.contentMode = UIViewContentModeScaleToFill;
    _photoView.image = [UIImage imageWithCGImage:_asset.thumbnail];  //正方形缩略图
    [self addSubview:_photoView];
    
    _maskView = [[UIImageView alloc]initWithFrame:_photoView.frame];
    _maskView.contentMode = UIViewContentModeScaleToFill;
    _maskView.image = [UIImage imageNamed:@"TTThumbnailCheckMask"];
    [self addSubview:_maskView];
    _maskView.hidden = YES;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickAction)];
    [self addGestureRecognizer:tap];
}

- (void)clickAction{
    if (self.delegate && [self.delegate respondsToSelector:@selector(ICAssetViewClicked:)]) {
        [self.delegate ICAssetViewClicked:self];
    }
}

@end
