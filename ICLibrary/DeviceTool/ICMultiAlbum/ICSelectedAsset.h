//  ICSelectedAsset.h
//  Created by Lotheve on 15/7/7.

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "ICAssetView.h"

@interface ICSelectedAsset : UIView

@property (nonatomic, strong) ICAssetView *assetView;

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIImageView *maskView;

@property (nonatomic, strong) UIButton *deleteButton;

- (id)initWithAssetView:(ICAssetView *)assetView withFrame:(CGRect)frame;

@end
