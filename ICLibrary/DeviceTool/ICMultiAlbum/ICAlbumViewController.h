//  ICAlbumViewController.h
//  Created by Lotheve on 15/7/7.

#import <UIKit/UIKit.h>
#import "ICAlbumImagePicker.h"

@class ICAlbumViewController;

@protocol  ICAlbumViewControllerDelegate<NSObject>

- (void)photoPickingCanceled:(ICAlbumViewController *)picker;

- (void)photoPickingSubmited:(ICAlbumViewController *)picker withInfo:(NSMutableArray *)info;

@end

@interface ICAlbumViewController : UIViewController<ICAlbumImagePickerDelegate>

@property (nonatomic, strong) id<ICAlbumViewControllerDelegate> delegate;

@end
