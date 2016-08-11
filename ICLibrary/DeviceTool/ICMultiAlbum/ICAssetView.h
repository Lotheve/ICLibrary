//  ICAssetView.h
//  Created by Lotheve on 15/7/7.

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>

#define PHOTO_DEFAULT_MARGIN 6

@class ICAssetView;

@protocol ICAssetViewDelegate <NSObject>

@optional

- (void)ICAssetViewClicked:(ICAssetView *)assetView;

@end

@interface ICAssetView : UIView

@property (nonatomic, strong) id<ICAssetViewDelegate> delegate;

@property (nonatomic, strong) UIImageView *photoView;
@property (nonatomic, strong) UIImageView *maskView;

@property (nonatomic, strong) ALAsset *asset;

- (id)initWithAsset:(ALAsset *)asset WithFrame:(CGRect)frame;

- (void)clickAction;

@end
