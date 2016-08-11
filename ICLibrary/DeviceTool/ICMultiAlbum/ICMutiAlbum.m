//  AlbumListNavigationController.m
//  Created by Lotheve on 15/7/7.

#import "ICMutiAlbum.h"

@implementation ICMutiAlbum

- (instancetype)init
{
    ICAlbumViewController *albumVC = [[ICAlbumViewController alloc]init];
    self = [super initWithRootViewController:albumVC];
    if (self) {
        albumVC.delegate = self;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationBar.translucent = NO;
    
    UINavigationBar *navigationBar = [UINavigationBar appearance];
    [navigationBar setBarTintColor:[UIColor colorWithRed:0.153 green:0.162 blue:0.087 alpha:0.810]];
    NSDictionary *dic = @{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:17.0f]};
    [navigationBar setTitleTextAttributes:dic];
}

#pragma mark - ICAlbumViewControllerDelegate
- (void)photoPickingSubmited:(ICAlbumViewController *)picker withInfo:(NSMutableArray *)info{
    if (self.albumDelegate && [self.albumDelegate respondsToSelector:@selector(mutiImagePickerController:didFinishPickingMediaWithInfo:)]) {
        [self.albumDelegate mutiImagePickerController:picker didFinishPickingMediaWithInfo:info];
    }
}

- (void)photoPickingCanceled:(ICAlbumViewController *)picker{
    if (self.albumDelegate && [self.albumDelegate respondsToSelector:@selector(mutiImagePickerControllerDidCancel:)]) {
        [self.albumDelegate mutiImagePickerControllerDidCancel:picker];
    }
}

@end
