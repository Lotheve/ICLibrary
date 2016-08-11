//  ICAlbumImagePicker.h
//  Created by Lotheve on 15/7/7.

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>

extern NSString *const UIImagePickerControllerMediaType;
extern NSString *const UIImagePickerControllerOriginalImage;
extern NSString *const UIImagePickerControllerReferenceURL;

@class ICAlbumImagePicker;

@protocol ICAlbumImagePickerDelegate <NSObject>

- (void)imagesPickingFinishedWithInfo:(NSMutableArray *)info;

@end

@interface ICAlbumImagePicker : UIViewController

@property (nonatomic, strong) id<ICAlbumImagePickerDelegate> delegate;

@property (nonatomic, strong) ALAssetsGroup *assetsGroup;
@property (nonatomic, assign) NSUInteger numberOfImageEachRow;  //每行显示的照片数

@end
