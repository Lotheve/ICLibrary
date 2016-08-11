//  ICAlbumImagePicker.m
//  Created by Lotheve on 15/7/7.

#import "ICAlbumImagePicker.h"
#import "ICAssetView.h"
#import "ICAssetsCell.h"
#import "ICAlbumBottomBar.h"

@interface ICAlbumImagePicker ()<UITableViewDataSource,UITableViewDelegate,ICAssetViewDelegate>
{
    CGFloat _thumbnailMeasure;  //缩略图大小
    BOOL _isSelected;
}

@property (nonatomic, strong) UITableView *imagesTableView;
@property (nonatomic, strong) ICAlbumBottomBar *selectPhotosView;
@property (nonatomic, strong) UIView *footView;   //用来显示照片总数

@property (nonatomic, strong) NSMutableArray *assetsArray;
@property (nonatomic, assign) NSInteger selectNum;      //已选照片数量
@property (nonatomic, strong) NSMutableArray *result;   //选择结果

@end

@implementation ICAlbumImagePicker

- (void)loadView{
    [super loadView];
    _assetsArray = [NSMutableArray array];
    _result = [NSMutableArray array];
    _selectNum = 0;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"加载中";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *selectButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    selectButton.titleLabel.font = [UIFont systemFontOfSize:15.0];
    [selectButton setTitle:@"选择" forState:UIControlStateNormal];
    [selectButton setTitleColor:[UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1] forState:UIControlStateHighlighted];
    [selectButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [selectButton addTarget:self action:@selector(submitSelection) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:selectButton];
    
    UIButton *backButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    backButton.titleLabel.font = [UIFont systemFontOfSize:15.0];
    [backButton setTitle:@"返回" forState:UIControlStateNormal];
    [backButton setTitleColor:[UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1] forState:UIControlStateHighlighted];
    [backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backButton];
    
    NSString *albumName = [NSString stringWithFormat:@"%@",[self.assetsGroup valueForProperty:ALAssetsGroupPropertyName]];
    if ([albumName isEqualToString:@"Camera Roll"]) {
        albumName = @"相册胶卷";
    }else if([albumName isEqualToString:@"My Photo Stream"]){
        albumName = @"我的照片流";
    }
    self.title = albumName;
    
    [self.view addSubview:self.imagesTableView];
    [self.view addSubview:self.selectPhotosView];
    
    //获取照片
    [self getImages];
    [self.imagesTableView reloadData];
}

#pragma mark - setter/getter
- (UITableView *)imagesTableView{
    if (!_imagesTableView) {
        _imagesTableView = [[UITableView alloc]initWithFrame:(CGRect){0,6,SCREEN_WIDTH,SCREEN_HEIGHT - 64 - 6 - 80}];
        _imagesTableView.backgroundColor = [UIColor clearColor];
        _imagesTableView.delegate = self;
        _imagesTableView.dataSource = self;
        _imagesTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_imagesTableView registerClass:[ICAssetsCell class] forCellReuseIdentifier:@"cell"];
        
        _imagesTableView.tableFooterView = self.footView;
    }
    return _imagesTableView;
}

- (ICAlbumBottomBar *)selectPhotosView{
    if (!_selectPhotosView) {
        _selectPhotosView = [[ICAlbumBottomBar alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 64 - 80, SCREEN_WIDTH, 80)];
        _selectPhotosView.backgroundColor = [UIColor blackColor];
        _selectPhotosView.showsHorizontalScrollIndicator = NO;
    }
    return _selectPhotosView;
}

- (UIView *)footView{
    if (!_footView) {
        _footView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
        _footView.backgroundColor = [UIColor clearColor];
        UILabel *statisticsLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
        statisticsLabel.backgroundColor = [UIColor clearColor];
        statisticsLabel.font = [UIFont systemFontOfSize:17.0f];
        statisticsLabel.textColor = [UIColor blackColor];
        statisticsLabel.textAlignment = NSTextAlignmentCenter;
        statisticsLabel.text = [NSString stringWithFormat:@"%zi 张照片",[self.assetsGroup numberOfAssets]];
        [_footView addSubview:statisticsLabel];
    }
    return _footView;
}

#pragma mark - private methods
- (void)submitSelection{
    [self getResult]; //获取选择的图片
    if(self.delegate && [self.delegate respondsToSelector:@selector(imagesPickingFinishedWithInfo:)]) {
        [self.delegate imagesPickingFinishedWithInfo:_result];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)getImages{
    _thumbnailMeasure = (SCREEN_WIDTH-(self.numberOfImageEachRow+1)*PHOTO_DEFAULT_MARGIN)/self.numberOfImageEachRow;
    CGRect frame = CGRectMake(0, 0, _thumbnailMeasure, _thumbnailMeasure);
    [self.assetsGroup enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
        if (result) {
            ICAssetView *assetView = [[ICAssetView alloc]initWithAsset:result WithFrame:frame];
            assetView.delegate = self;
            [_assetsArray addObject:assetView];
        }
    }];
}

- (void)getResult{
    if (self.selectPhotosView.selectedAssets.count <= 0) {
        return;
    }
    
    [_result removeAllObjects];
    for (ICAssetView *assetView in self.selectPhotosView.selectedAssets) {
        ALAsset *asset = assetView.asset;
        NSMutableDictionary *workingDictionary = [[NSMutableDictionary alloc] init];
        
        //资源类型
        id propertyType = [asset valueForProperty:ALAssetPropertyType];
        if (propertyType) {
            [workingDictionary setObject:propertyType forKey:UIImagePickerControllerMediaType];
        } else {
            continue;
        }
        
        UIImage *originalImage = [UIImage imageWithCGImage:[[asset defaultRepresentation] fullResolutionImage]];
        //defaultRepresentation 用来封装asset的陈述
        //fullResolutionImage 用来获取完全分辨率的图像
        if (originalImage) {
            [workingDictionary setObject:originalImage forKey:UIImagePickerControllerOriginalImage];
        } else {
            continue;
        }
        
        //资源URL
        id referenceURL = [[asset valueForProperty:ALAssetPropertyURLs] valueForKey:[[[asset valueForProperty:ALAssetPropertyURLs] allKeys] objectAtIndex:0]];
        if (referenceURL) {
            [workingDictionary setObject:referenceURL forKey:UIImagePickerControllerReferenceURL];
        } else {
            continue;
        }
        
        [_result addObject:workingDictionary];
    }
}

#pragma mark - UITableViewDataSource && UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  ceil(self.assetsGroup.numberOfAssets/(double)_numberOfImageEachRow);
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;{
    return _thumbnailMeasure+PHOTO_DEFAULT_MARGIN;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSMutableArray *assets = [[NSMutableArray alloc]initWithCapacity:_numberOfImageEachRow];
    
    for (NSInteger i = indexPath.row*_numberOfImageEachRow; i<self.assetsArray.count && i<(indexPath.row+1)*_numberOfImageEachRow; i++) {
        [assets addObject:_assetsArray[i]];
    }
    
    ICAssetsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell = [[ICAssetsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell" withAssets:assets];
    
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark - ICAssetViewDelegate
- (void)ICAssetViewClicked:(ICAssetView *)assetView{
    
    _isSelected = assetView.maskView.hidden;
    if (_isSelected) {
        if (_selectNum >= MAXCOUNT) {
            return;
        }
        assetView.maskView.hidden = NO;
        [_selectPhotosView addAsset:assetView];
        _selectNum++;
    }else{
        assetView.maskView.hidden = YES;
        [_selectPhotosView removeAsset:assetView];
        _selectNum--;
    }
    self.selectPhotosView.selectNumLabel.text = [NSString stringWithFormat:@"已选择 %zi 张 剩余 %zi 张可选",_selectNum,MAXCOUNT - _selectNum];
}

@end
