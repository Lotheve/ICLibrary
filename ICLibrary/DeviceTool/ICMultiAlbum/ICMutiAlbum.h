//  AlbumListNavigationController.h
//  Created by Lotheve on 15/7/7.

/**
 *  自定义多选相册
 */

#import <UIKit/UIKit.h>
#import "ICAlbumViewController.h"

@protocol ICMutiAlbumDelegate <NSObject>

@required

- (void)mutiImagePickerController:(ICAlbumViewController *)picker didFinishPickingMediaWithInfo:(NSArray *)info;

- (void)mutiImagePickerControllerDidCancel:(ICAlbumViewController *)picker;

@end

@interface ICMutiAlbum : UINavigationController<ICAlbumViewControllerDelegate>

@property (nonatomic, strong) id<ICMutiAlbumDelegate> albumDelegate;


@end
