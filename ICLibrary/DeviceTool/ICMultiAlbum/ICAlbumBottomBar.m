//  ICAlbumBottomBar.m
//  Created by Lotheve on 15/7/7.

#import "ICAlbumBottomBar.h"

@implementation ICAlbumBottomBar

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.selectedAssets = [NSMutableArray array];
        self.delegate = self;
        [self addSubview:self.selectNumLabel];
    }
    return self;
}

- (void)addAsset:(ICAssetView *)assetView{
    [self.selectedAssets addObject:assetView];
    [self reloadView];
}

- (void)removeAsset:(ICAssetView *)assetView{
    [self.selectedAssets removeObject:assetView];
    [self reloadView];
}

- (void)reloadView{
    [self.subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([obj isKindOfClass:[ICSelectedAsset class]]) {
            [obj removeFromSuperview];
        }
    }];
    
    CGRect frame = CGRectMake(10, 20, 55, 55);
    for (int i = 0; i<self.selectedAssets.count; i++) {
        ICSelectedAsset *photoView = [[ICSelectedAsset alloc]initWithAssetView:self.selectedAssets[i] withFrame:frame];
        [self addSubview:photoView];
        frame.origin.x += 55+5;
    }
    
    [self setContentSize:CGSizeMake(frame.origin.x+5, 80)];
    if (frame.origin.x+5 > SCREEN_WIDTH) {
        [self setContentOffset:CGPointMake(frame.origin.x+5-SCREEN_WIDTH, 0) animated:YES];
    }
}

- (UILabel *)selectNumLabel{
    if (!_selectNumLabel) {
        _selectNumLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 2, SCREEN_WIDTH - 20, 10)];
        _selectNumLabel.backgroundColor = [UIColor blackColor];  //设置成和selectPhotosView背景颜色一致
        _selectNumLabel.font = [UIFont systemFontOfSize:10.0f];
        _selectNumLabel.textColor = [UIColor whiteColor];
        _selectNumLabel.text = [NSString stringWithFormat:@"已选择 0 张 剩余 %zi 张可选",MAXCOUNT];
    }
    return _selectNumLabel;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGRect rect = self.selectNumLabel.frame;
    rect.origin.x = self.contentOffset.x + 10;
    self.selectNumLabel.frame = rect;
}

@end
