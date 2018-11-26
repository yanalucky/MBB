//
//  ImageScrollView.m
//  Ios_HYCom_Demo
//
//  Created by 姚碧波 on 15/8/15.
//  Copyright (c) 2015年 BourneYao. All rights reserved.
//

#import "HYImageScrollView.h"
#import "UIImageView+WebCache.h"

#import "ScrollImageView.h"

@implementation HYImageScrollView
{
    int _iCount;
    NSTimer *_timer;
    UIScrollView   *_scrollView;
    NSInteger       _currentPage;
    // 所有的图片view
    NSMutableSet *_visiblePhotoViews;
    NSMutableSet *_reusablePhotoViews;
}

- (UIView *)initWithFrame:(CGRect)frame marrImages:(NSMutableArray *)marrImages
{
    _iCount = (int)marrImages.count;
    
    _marrImageList = [[NSMutableArray alloc]init];
    _visiblePhotoViews = [NSMutableSet set];
    _reusablePhotoViews = [NSMutableSet set];
    _marrImageList = marrImages;
    
    self.frame = frame;
    if(self = [super initWithFrame:frame])
    {
        _scrollView               = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        _scrollView.delegate      = self;
        _scrollView.pagingEnabled = YES;
        _scrollView.bounces       = YES;
        _scrollView.showsHorizontalScrollIndicator = NO;
        if (@available(iOS 11.0, *)) {
            _scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        [self addSubview:_scrollView];
        
        [self setMarrImageList:marrImages];
    }
    
    return self;
}

- (void)setBNeedStopScrollWithOnePic:(BOOL)bNeedStopScrollWithOnePic
{
    _bNeedStopScrollWithOnePic = bNeedStopScrollWithOnePic;
    if (_bNeedStopScrollWithOnePic && _marrImageList.count == 1)
    {
        [self stopScroll];
        [_scrollView scrollRectToVisible:CGRectMake(self.frame.size.width, 0, self.frame.size.width, self.frame.size.height) animated:NO];
        _scrollView.scrollEnabled = NO;
        [_pageControl removeFromSuperview];
    }
    else
    {
        [self startScroll];
        _scrollView.scrollEnabled = YES;
        [self addSubview:_pageControl];
    }
}

- (void)setMarrImageList:(NSMutableArray *)marrImageList
{
    _marrImageList = marrImageList;
    _iCount = (int)_marrImageList.count;
    _scrollView.contentSize   = CGSizeMake([UIScreen mainScreen].bounds.size.width*(_marrImageList.count+2), self.frame.size.height);
    [_scrollView scrollRectToVisible:CGRectMake(self.frame.size.width, 0, self.frame.size.width, self.frame.size.height) animated:NO];
    _scrollView.scrollEnabled = !(_bNeedStopScrollWithOnePic && _marrImageList.count == 1);
    
    [_pageControl removeFromSuperview];
    _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, self.frame.size.height-20, self.frame.size.width, 20)];
    _pageControl.numberOfPages = marrImageList.count;
    _pageControl.pageIndicatorTintColor = UINavSepratorLineColor;
    _pageControl.currentPageIndicatorTintColor = UIFontRedColor;
    _pageControl.hidesForSinglePage = YES;
    [_pageControl addTarget:self action:@selector(turnPage) forControlEvents:UIControlEventValueChanged];
    if (_scrollView.scrollEnabled)
    {
        [self addSubview:_pageControl];
    }

    [self showImageScrollView];
    (_scrollView.scrollEnabled)?[self startScroll]:[self stopScroll];
}

- (void)showImageScrollView
{
    if (_marrImageList.count == 0)
    {
        return;
    }
    
    CGRect visibleBounds = _scrollView.bounds;
    int firstIndex = (int)floorf(CGRectGetMinX(visibleBounds) / CGRectGetWidth(visibleBounds)) - 1;
    int lastIndex  = (int)floorf((CGRectGetMaxX(visibleBounds) - 1)/ CGRectGetWidth(visibleBounds)) - 1;
    if (firstIndex < -1)
        firstIndex = -1;
    if (firstIndex >= (int)_marrImageList.count + 1)
        firstIndex = (int)_marrImageList.count;
    if (lastIndex < -1) lastIndex = -1;
    if (lastIndex >= (int)_marrImageList.count + 1) lastIndex = (int)_marrImageList.count;
    
    _pageControl.currentPage = firstIndex;
    
    // 回收不再显示的ImageView
    NSInteger photoViewIndex;
    for (ScrollImageView *photoView in _visiblePhotoViews)
    {
        photoViewIndex = photoView.index;
        if (photoViewIndex < firstIndex || photoViewIndex > lastIndex)
        {
            [_reusablePhotoViews addObject:photoView];
            [photoView removeFromSuperview];
        }
    }
    
    [_visiblePhotoViews minusSet:_reusablePhotoViews];
    while (_reusablePhotoViews.count > 2)
    {
        [_reusablePhotoViews removeObject:[_reusablePhotoViews anyObject]];
    }
    
    for (int index = firstIndex; index <= lastIndex; index++)
    {
        if (![self isShowingPhotoViewAtIndex:index])
        {
            [self showPhotoViewAtIndex:index];
        }
    }
}

#pragma mark 显示一个图片view
- (void)showPhotoViewAtIndex:(int)index
{
    ScrollImageView *photoView = [self dequeueReusablePhotoView];
    photoView.backgroundColor = [UIColor whiteColor];
    if (!photoView)
    { // 添加新的图片view
        photoView = [[ScrollImageView alloc] init];
        photoView.backgroundColor = [UIColor whiteColor];
        [photoView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ImageScrollUserClicked:)]];
        photoView.userInteractionEnabled = YES;
    }
    photoView.index = index;
    // 调整当期页的frame
    CGRect bounds = _scrollView.bounds;
    CGRect photoViewFrame = bounds;
    photoViewFrame.origin.x = (bounds.size.width * (index+1));
    
    photoView.frame = photoViewFrame;
    
    int indexPic = (index == -1)?(int)_marrImageList.count-1:index;
    indexPic = (index == (int)_marrImageList.count)?0:indexPic;
//    [_marrImageList removeAllObjects];
//    NSString *str = @"hdjjdhjdhf";
//    [_marrImageList addObject:str];
//    [_marrImageList addObject:str];
    NSString *strPicture = [_marrImageList objectAtIndex:indexPic];
    [photoView sd_setImageWithURL:[NSURL URLWithString:strPicture] placeholderImage:[UIImage imageNamed:@"1242X580（banner)"]];
    [_visiblePhotoViews addObject:photoView];
    [_scrollView addSubview:photoView];
}


#pragma mark index这页是否正在显示
- (BOOL)isShowingPhotoViewAtIndex:(NSUInteger)index
{
    for (ScrollImageView *photoView in _visiblePhotoViews)
    {
        if (photoView.index == index)
        {
            return YES;
        }
    }
    return  NO;
}

#pragma mark 循环利用某个view
- (ScrollImageView *)dequeueReusablePhotoView
{
    ScrollImageView *photoView = [_reusablePhotoViews anyObject];
    if (photoView)
    {
        [_reusablePhotoViews removeObject:photoView];
    }
    return photoView;
}

#pragma mark - UIScrollView Delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    for (UIImageView *photo in _scrollView.subviews) {
        for (UIGestureRecognizer *ges in photo.gestureRecognizers) {
            NSInteger x = _scrollView.contentOffset.x;
            NSInteger w = kScreenWidth;
            if (x%w == 0) {
                ges.enabled = YES;
            }else{
                ges.enabled = NO;
            }
        }
    }
    [self showImageScrollView];

    _currentPage = floor((_scrollView.contentOffset.x-self.frame.size.width)/self.frame.size.width);
    if (_currentPage == -1)
    {
         _currentPage = floor((_scrollView.contentOffset.x-self.frame.size.width/10)/self.frame.size.width);
    }
    _pageControl.currentPage = _currentPage;
    
    if (_currentPage == -1)
    {
        [_scrollView scrollRectToVisible:CGRectMake(self.frame.size.width*_iCount, 0, self.frame.size.width, self.frame.size.height) animated:NO];
        _pageControl.currentPage = _iCount-1;
    }
    else if (_currentPage == _iCount)
    {
        [_scrollView scrollRectToVisible:CGRectMake(self.frame.size.width, 0, self.frame.size.width, self.frame.size.height) animated:NO];
        _pageControl.currentPage = 0;
    }
}

//开始滚动
- (void)startScroll
{
    if (_timer == nil)
    {
        _timer = [NSTimer scheduledTimerWithTimeInterval:4.f target:self selector:@selector(imageRun) userInfo:nil repeats:YES];
    }
}

- (void)stopScroll
{
    [_timer invalidate];
    _timer = nil;
}

//选择器的方法
- (void)turnPage
{
    [_scrollView scrollRectToVisible:CGRectMake(self.frame.size.width*(_currentPage+1),0,self.frame.size.width,self.frame.size.height) animated:YES];
}

//图片自动轮播功能
- (void)imageRun
{
    _currentPage = floor((_scrollView.contentOffset.x-self.frame.size.width)/self.frame.size.width);
    _currentPage++;
    [self turnPage];
}

//拖拽时停止滚动，3秒后继续滚动
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView;
{
    [_timer invalidate];
    _timer = nil;
    [self performSelector:@selector(startScroll) withObject:nil afterDelay:3.0];
}
//单击
-(void)ImageScrollUserClicked:(UITapGestureRecognizer  *)sender
{
    //int indexPic = ((int)_currentPage == -1)?(int)_marrImageList.count-1:(int)_currentPage;
    //indexPic = (_currentPage == (int)_marrImageList.count)?0:indexPic;

    if ([_delegate respondsToSelector:@selector(ImageScroll:UserClickedAtPage:)])
    {
         [_delegate ImageScroll:self UserClickedAtPage:_marrImageList.count-1];
    }
    if ([_delegate respondsToSelector:@selector(ImageScrollUserClickedAtPage:)])
    {
        ScrollImageView *photoView = (ScrollImageView *)sender.view;
        [_delegate ImageScrollUserClickedAtPage:photoView.index];
    }
}

@end
