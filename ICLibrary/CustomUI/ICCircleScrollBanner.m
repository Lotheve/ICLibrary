//
//  ICCircleScrollBanner.m
//
//  Created by Lotheve on 15/7/22.
//  Copyright (c) 2015年 Lotheve. All rights reserved.
//

#import "ICCircleScrollBanner.h"
#import "UIImageView+WebCache.h"

#define BOUNDS_WIDTH self.bounds.size.width
#define BOUNDS_HEIGHT self.bounds.size.height

@interface ICCircleScrollBanner ()<UIScrollViewDelegate>

@property (strong, nonatomic)UIScrollView *scrollView;
@property (strong, nonatomic)ICTapScrollViewBlock tapBlock;
@property (strong, nonatomic)ICPanScrollViewBlock panBlock;

@property (strong, nonatomic)NSMutableArray *pageImgs;          //滚动视图中所有图片数组（使用图片数组创建时，使用）
@property (strong, nonatomic)NSMutableArray *pageImgUrls;       //滚动图片URL
@property (strong, nonatomic)NSMutableDictionary *pageImgDic;   //（使用Url数组创建时，使用）
@property (strong, nonatomic)NSMutableArray *pageViews;         //滚动视图中的图片
@property (nonatomic)NSUInteger curPage;                        //现在所处的图片位置

@end

@implementation ICCircleScrollBanner
- (instancetype)initWithFrame:(CGRect)frame contentImages:(NSMutableArray*)images tapBlock:(ICTapScrollViewBlock)tapBlock scrollBlock:(ICPanScrollViewBlock)panBlock{
    self = [super initWithFrame:frame];
    [self initlization];
    if (self) {
        self.tapBlock = tapBlock;
        self.panBlock = panBlock;
        self.pageImgs = images;
        [self addSubview:self.scrollView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame contentImageURLs:(NSMutableArray*)imagesURLs tapBlock:(ICTapScrollViewBlock)tapBlock scrollBlock:(ICPanScrollViewBlock)panBlock{
    self = [super initWithFrame:frame];
    [self initlization];
    if (self) {
        self.tapBlock = tapBlock;
        self.panBlock = panBlock;
        self.pageImgUrls = imagesURLs;
        [self addSubview:self.scrollView];
    }
    return self;
}

- (void)initlization{
    self.pageImgDic = [[NSMutableDictionary alloc]init];
    self.pageImgs = [[NSMutableArray alloc]init];
    self.pageImgUrls = [[NSMutableArray alloc]init];
    self.pageViews = [[NSMutableArray alloc]init];
    self.tapBlock = nil;
    self.panBlock = nil;
    self.curPage = 0;
}

#pragma mark- Getter, Setter
- (UIScrollView*)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0,  BOUNDS_WIDTH, BOUNDS_HEIGHT)];
        _scrollView.bounces = YES;
        _scrollView.delegate = self;
        _scrollView.pagingEnabled = YES;
        _scrollView.userInteractionEnabled = YES;
        _scrollView.showsHorizontalScrollIndicator = NO;
        //添加imageView和手势
        if ([self.pageImgs count]==1 || [self.pageImgUrls count]==1) {
            _scrollView.contentSize = CGSizeMake(BOUNDS_WIDTH, BOUNDS_HEIGHT);
            UIImageView *view = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, BOUNDS_WIDTH, BOUNDS_HEIGHT)];
            [_scrollView addSubview:view];
            [self.pageViews addObject:view];
        }else{
            _scrollView.contentSize = CGSizeMake(BOUNDS_WIDTH*3, BOUNDS_HEIGHT);
            for (int i=0; i<3; i++) {
                UIImageView *view = [[UIImageView alloc]initWithFrame:CGRectMake(BOUNDS_WIDTH*i, 0, BOUNDS_WIDTH, BOUNDS_HEIGHT)];
                [_scrollView addSubview:view];
                [self.pageViews addObject:view];
            }
        }
        //添加手势
        if (self.tapBlock) {
            for (UIImageView *imageView in [self.scrollView subviews]) {
                UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(actionTapImageView:)];
                [imageView addGestureRecognizer:tap];
                imageView.userInteractionEnabled = YES;
            }
        }
        
        [self setpageViewsRoundIndex:self.curPage];
    }
    return _scrollView;
}

#pragma mark- Private method
//获取index图片以及index左右两边的图片的imageView
- (void)setpageViewsRoundIndex:(NSUInteger)index{
    //panBlock
    if (self.panBlock) {
        self.panBlock(self, self.curPage);
    }
    
    //设置图片
    if (![self.pageImgUrls count]) {
        //通过图片数组设置图片
        NSMutableArray *tempImgs = [self getPageViewRoundTempArray:self.pageImgs WithIndex:index];
        [tempImgs enumerateObjectsUsingBlock:^(UIImage *img, NSUInteger idx, BOOL *stop) {
            UIImageView *imgView = [self.pageViews objectAtIndex:idx];
            imgView.image = img;
        }];
    }else{
        //通过URL数组设置图片
        if (!((index+1)<[self.pageImgDic count]) && index!=([self.pageImgUrls count])) {
            //本地没有图片，需要网络加载，再设置
            NSMutableArray *tempImgUrls = [self getPageViewRoundTempArray:self.pageImgUrls WithIndex:index];
            [tempImgUrls enumerateObjectsUsingBlock:^(NSURL *imgUrl, NSUInteger idx, BOOL *stop) {
                UIImageView *imgView = [self.pageViews objectAtIndex:idx];
                [imgView sd_setImageWithURL:imgUrl placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                    if ([self.pageImgUrls count]==1 && image) {
                        [self.pageImgDic setObject:image forKey:@"0"];
                    }else if ((index-1+idx)!=-1 && (index-1+idx)!=[self.pageImgUrls count] && image) {
                        [self.pageImgDic setObject:image forKey:[NSString stringWithFormat:@"%zi", index-1+idx]];
                    }
                }];
            }];
        }else{
            //本地有图片，直接设置
            NSMutableArray *tempImgs = [[NSMutableArray alloc]init];
            if ([self.pageImgDic count]==1) {
                [tempImgs addObject:[self.pageImgDic objectForKey:@"0"]];
            }else{
                if (index==0) {
                    [tempImgs addObject:[self.pageImgDic objectForKey:[NSString stringWithFormat:@"%zi", [self.pageImgUrls count]-1]]];
                }else{
                    [tempImgs addObject:[self.pageImgDic objectForKey:[NSString stringWithFormat:@"%zi", index-1]]];
                }
                [tempImgs addObject:[self.pageImgDic objectForKey:[NSString stringWithFormat:@"%zi", index]]];
                if (index==([self.pageImgDic count]-1)) {
                    [tempImgs addObject:[self.pageImgDic objectForKey:[NSString stringWithFormat:@"%i", 0]]];
                }else{
                    [tempImgs addObject:[self.pageImgDic objectForKey:[NSString stringWithFormat:@"%zi", index+1]]];
                }
            }
            [tempImgs enumerateObjectsUsingBlock:^(UIImage *img, NSUInteger idx, BOOL *stop) {
                UIImageView *imgView = [self.pageViews objectAtIndex:idx];
                imgView.image = img;
            }];
        }
    }

    if ([self.pageImgs count]==1 || [self.pageImgUrls count]==1) {
        self.scrollView.contentOffset = CGPointZero;
    }else{
        self.scrollView.contentOffset = CGPointMake(BOUNDS_WIDTH, 0);
    }
}

/**
 *  获取CurrentPage及其前后的图片信息的数组
 *
 *  @param array 存放pageView图片信息的数组
 *  @param index currentPage的位置
 *
 *  @return 存放CurrentPage及其前后的图片信息的数组
 */
- (NSMutableArray*)getPageViewRoundTempArray:(NSMutableArray*)array WithIndex:(NSUInteger)index{
    NSMutableArray *tempImgs = [[NSMutableArray alloc]init];
    if ([array count]==1) {
        [tempImgs addObject:[array objectAtIndex:0]];
    }else{
        if (index==0) {
            [tempImgs addObject:[array lastObject]];
        }else{
            [tempImgs addObject:[array objectAtIndex:index-1]];
        }
        [tempImgs addObject:[array objectAtIndex:index]];
        if (index==([array count]-1)) {
            [tempImgs addObject:[array objectAtIndex:0]];
        }else{
            [tempImgs addObject:[array objectAtIndex:index+1]];
        }
    }
    return tempImgs;
}

- (void)actionTapImageView:(UITapGestureRecognizer*)tap{
    if (self.tapBlock) {
        self.tapBlock(self, self.curPage);
    }
}

#pragma mark- UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.x<=0) {
        if ([self.pageImgUrls count]) {
            self.curPage = !self.curPage? self.pageImgUrls.count-1 :self.curPage-1;
        }else{
            self.curPage = !self.curPage? self.pageImgs.count-1 :self.curPage-1;
        }
        [self setpageViewsRoundIndex:self.curPage];
    }else if (scrollView.contentOffset.x>=2*BOUNDS_WIDTH){
        if ([self.pageImgUrls count]) {
            self.curPage = (self.curPage==self.pageImgUrls.count-1)? 0 :self.curPage+1;
        }else{
            self.curPage = (self.curPage==self.pageImgs.count-1)? 0 :self.curPage+1;
        }
        [self setpageViewsRoundIndex:self.curPage];
    }
}
@end
