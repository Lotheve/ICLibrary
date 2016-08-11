//  ICAlbumBottomBar.h
//  Created by Lotheve on 15/7/7.

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "ICSelectedAsset.h"
#import "ICAssetView.h"

#define MAXCOUNT 10   //最多可选数量

@interface ICAlbumBottomBar : UIScrollView<UIScrollViewDelegate>

@property (nonatomic, strong) NSMutableArray *selectedAssets;

@property (nonatomic, strong) UILabel *selectNumLabel;


- (void)addAsset:(ICAssetView *)assetView;

- (void)removeAsset:(ICAssetView *)assetView;

- (void)reloadView;

@end
