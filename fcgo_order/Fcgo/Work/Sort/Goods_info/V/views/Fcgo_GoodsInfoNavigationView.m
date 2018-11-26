//
//  Fcgo_GoodsInfoNavigationView.m
//  Fcgo
//
//  Created by huafanxiao on 2017/12/25.
//  Copyright © 2017年 Fcg. All rights reserved.
//

#import "Fcgo_GoodsInfoNavigationView.h"

@interface Fcgo_GoodsInfoNavigationView ()

@property (nonatomic,strong) UIButton  *goodsBtn,*detailBtn;
@property (nonatomic,strong) UIView    *lineView;
@property (nonatomic,strong) UILabel   *titleLabel;
@property (nonatomic,strong) UIScrollView *scrollView;

@end

@implementation Fcgo_GoodsInfoNavigationView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setupUI];
    }
    return self;
}

- (void)setupUI
{
    self.backgroundColor = UIFontClearColor;
    CGFloat centerX = self.mj_w /2;
    self.goodsBtn.frame = CGRectMake(centerX - 10 - 40, 7, 40, 30);
    self.detailBtn.frame = CGRectMake(centerX + 10, 7, 40, 30);
    self.goodsBtn.transform = CGAffineTransformMakeScale(1.08, 1.08);
    self.lineView.frame = CGRectMake(self.goodsBtn.center.x - 14, 41, 28, 2);
    
    self.titleLabel.frame = CGRectMake(0, self.scrollView.mj_h, self.scrollView.mj_w, self.scrollView.mj_h);
    
    [self.goodsBtn addTarget:self action:@selector(selectedGoodsMsg:) forControlEvents:UIControlEventTouchUpInside];
    [self.detailBtn addTarget:self action:@selector(selectedGoodsDetail:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:self.scrollView];
    
    [self.scrollView addSubview:self.goodsBtn];
    [self.scrollView addSubview:self.detailBtn];
    [self.scrollView addSubview:self.lineView];
    [self.scrollView addSubview:self.titleLabel];
}

- (void)selectedGoodsMsg:(UIButton *)btn
{
    if (self.selectedGoodsTypeBlock) {
        self.selectedGoodsTypeBlock(SelectedGoodsMsgType);
    }
   
}

- (void)selectedGoodsDetail:(UIButton *)btn
{
    if (self.selectedGoodsTypeBlock) {
        self.selectedGoodsTypeBlock(SelectedGoodsDetailType);
    }
}

#pragma mark set meth 

- (void)setScroll_x:(CGFloat)scroll_x
{
    _scroll_x  = scroll_x;
    CGFloat x =  self.detailBtn.center.x - self.goodsBtn.center.x;
    self.lineView.frame = CGRectMake(self.goodsBtn.center.x - 14 + x*_scroll_x/kScreenWidth, 41, 28, 2);
    if (scroll_x == 0) {
        [UIView animateWithDuration:0.2 animations:^{
            self.goodsBtn.transform = CGAffineTransformMakeScale(1.08, 1.08);
            self.detailBtn.transform = CGAffineTransformMakeScale(1.0, 1.0);
        }];
    }
    else if (scroll_x == kScreenWidth){
        [UIView animateWithDuration:0.2 animations:^{
            self.goodsBtn.transform = CGAffineTransformMakeScale(1.0, 1.0);
            self.detailBtn.transform = CGAffineTransformMakeScale(1.08, 1.08);
        }];
    }
}

- (void)setScrollPage:(BOOL)scrollPage
{
    _scrollPage = scrollPage;
    _scrollPage?[self.scrollView setContentOffset:CGPointMake(0, self.mj_h) animated:YES]:[self.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
}

- (void)setSubviewsColor:(UIColor *)subviewsColor
{
    [self.goodsBtn setTitleColor:subviewsColor forState:UIControlStateNormal];
    [self.detailBtn setTitleColor:subviewsColor forState:UIControlStateNormal];
    self.titleLabel.textColor = subviewsColor;
    self.lineView.backgroundColor = subviewsColor;
}

#pragma mark lazy load
- (UIButton *)goodsBtn
{
    if (!_goodsBtn) {
        UIButton *goodsBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [goodsBtn setTitle:@"商品" forState:UIControlStateNormal];
        [goodsBtn setTitleColor:UIFontMainGrayColor forState:UIControlStateNormal];
        goodsBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        _goodsBtn = goodsBtn;
    }
    return _goodsBtn;
}

- (UIButton *)detailBtn
{
    if (!_detailBtn) {
        UIButton *detailBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [detailBtn setTitle:@"详情" forState:UIControlStateNormal];
        [detailBtn setTitleColor:UIFontMainGrayColor forState:UIControlStateNormal];
        detailBtn.titleLabel.font = [UIFont systemFontOfSize:17];
        _detailBtn = detailBtn;
    }
    return _detailBtn;
}

- (UIView *)lineView
{
    if (!_lineView) {
        UIView *lineView = [[UIView alloc]init];
        lineView.backgroundColor = UIFontMainGrayColor;
        _lineView = lineView;
    }
    return _lineView;
}

- (UIScrollView  *)scrollView
{
    if (!_scrollView) {
        UIScrollView  *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.mj_w, self.mj_h)];
        scrollView.contentSize = CGSizeMake(self.mj_w, self.mj_h*2);
        scrollView.pagingEnabled = YES;
        _scrollView = scrollView;
    }
    return _scrollView;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        UILabel *titleLabel = [[UILabel alloc]init];
        titleLabel.font = [UIFont systemFontOfSize:17];
        titleLabel.textColor = UIFontMainGrayColor;
        titleLabel.text = @"商品详情";
        titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel = titleLabel;
    }
    return _titleLabel;
}

@end

