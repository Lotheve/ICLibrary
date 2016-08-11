//  ICAssetsCell.h
//  Created by Lotheve on 15/7/7.

#import <UIKit/UIKit.h>

@interface ICAssetsCell : UITableViewCell

@property (nonatomic, strong) NSMutableArray *assets;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withAssets:(NSMutableArray *)assets;

@end
