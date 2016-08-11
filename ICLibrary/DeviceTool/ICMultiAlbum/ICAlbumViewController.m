//  ICAlbumViewController.m
//  Created by Lotheve on 15/7/7.

#import "ICAlbumViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "ICAlbumImagePicker.h"

@interface ICAlbumViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) ALAssetsLibrary *assetsLibrary;
@property (nonatomic, strong) ALAssetsGroup *assetsGroup;
@property (nonatomic, strong) ALAsset *asset;

@property (nonatomic, strong) NSMutableArray *assetsArray;

@end

@implementation ICAlbumViewController

- (void)loadView{
    [super loadView];
    [self initialization];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadBaseUI];
}

- (void)initialization{
    //数据初始化
    _assetsArray = [NSMutableArray array];
    _assetsLibrary = [[ALAssetsLibrary alloc]init];
    _assetsGroup = [[ALAssetsGroup alloc]init];
}

- (void)loadBaseUI{
    self.title = @"照片";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *cancelButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    cancelButton.titleLabel.font = [UIFont systemFontOfSize:15.0];
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [cancelButton setTitleColor:[UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1] forState:UIControlStateHighlighted];
    [cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [cancelButton addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:cancelButton];
    
    [self.view addSubview:self.tableView];
    
    [self getImagesArray]; //获取相册列表
    [self.tableView reloadData];
}

#pragma mark - getter/setter
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:(CGRect){0,0,SCREEN_WIDTH,SCREEN_HEIGHT-64} style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    }
    return _tableView;
}

#pragma mark - private methods
- (void)cancelAction{
    if (self.delegate && [self.delegate respondsToSelector:@selector(photoPickingCanceled:)]) {
        [self.delegate photoPickingCanceled:self];
    }
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (void)getImagesArray{
    [_assetsArray removeAllObjects];

    [_assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
        if (group) {
            [_assetsArray addObject:group];
            [self.tableView reloadData];
        }
    } failureBlock:^(NSError *error) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"相册获取失败" delegate:self cancelButtonTitle:@"取消" otherButtonTitles: nil];
        [alert show];
    }];
}

#pragma mark - UITableViewDelegate && UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.assetsArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    [cell.subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([NSStringFromClass([obj class]) isEqualToString:@"UIView"]) {
            [obj removeFromSuperview];
        }
    }];
    
    cell.backgroundColor = [UIColor whiteColor];
    _assetsGroup = (ALAssetsGroup *)self.assetsArray[indexPath.row];
    //资源组名
    NSString *albumName = [NSString stringWithFormat:@"%@",[_assetsGroup valueForProperty:ALAssetsGroupPropertyName]];
    if ([albumName isEqualToString:@"Camera Roll"]) {
        albumName = @"相册胶卷";
    }else if([albumName isEqualToString:@"My Photo Stream"]){
        albumName = @"我的照片流";
    }
    //过滤出照片资源
    [_assetsGroup setAssetsFilter:[ALAssetsFilter allPhotos]];
    cell.textLabel.text = [NSString stringWithFormat:@"%@(%zi)",albumName,_assetsGroup.numberOfAssets];
    cell.imageView.image = [UIImage imageWithCGImage:_assetsGroup.posterImage]; //相册的海报缩略图
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    UIView *line = [[UIView alloc]initWithFrame:(CGRect){80,59,SCREEN_HEIGHT-80,0.5}];
    line.backgroundColor = [UIColor lightGrayColor];
    [cell addSubview:line];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ICAlbumImagePicker *imagesVC = [[ICAlbumImagePicker alloc]init];
    imagesVC.delegate = self;
    imagesVC.assetsGroup = self.assetsArray[indexPath.row];
    imagesVC.numberOfImageEachRow = 4;
    [self.navigationController pushViewController:imagesVC animated:YES];
}

#pragma mark - ICAlbumImagePickerDelegate
- (void)imagesPickingFinishedWithInfo:(NSMutableArray *)info{
    if (self.delegate && [self.delegate respondsToSelector:@selector(photoPickingSubmited:withInfo:
)]) {
        [self.delegate photoPickingSubmited:self withInfo:info];
    }
}
@end
