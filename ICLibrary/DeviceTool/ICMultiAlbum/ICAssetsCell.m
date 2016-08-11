//  ICAssetsCell.m
//  Created by Lotheve on 15/7/7.

#import "ICAssetsCell.h"
#import "ICAssetView.h"

@implementation ICAssetsCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withAssets:(NSMutableArray *)assets{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.assets = assets;
        [self setBaseUI];
    }
    return self;
}

- (void)setBaseUI{
    if (self.assets.count == 0) {
        return;
    }
    ICAssetView *assetView = self.assets[0];
    CGRect frame = CGRectMake(PHOTO_DEFAULT_MARGIN, PHOTO_DEFAULT_MARGIN/2, assetView.frame.size.width, assetView.frame.size.height);
    for (int i = 0; i<self.assets.count; i++) {
        assetView = self.assets[i];
        assetView.frame = frame;
        [self addSubview:assetView];
        frame.origin.x += assetView.frame.size.width+PHOTO_DEFAULT_MARGIN;
    }
}

@end
