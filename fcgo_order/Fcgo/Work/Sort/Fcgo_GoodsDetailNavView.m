//
//  Fcgo_GoodsDetailNavView.m
//  Fcgo
//
//  Created by huafanxiao on 2017/6/1.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_GoodsDetailNavView.h"

@interface Fcgo_GoodsDetailNavView ()

@property (nonatomic,strong)  UIButton  *goodsBtn,*detailBtn;
@property (nonatomic,strong)  UIView    *lineView;
@property (nonatomic,strong)  UILabel   *titleLabel;

@end


@implementation Fcgo_GoodsDetailNavView

- (instancetype)initWithFrame:(CGRect)frame

{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIFontClearColor;
        [self setupUI];
    }
    return self;
}

- (void)setupUI
{
    CGFloat centerX = self.mj_w /2;
    self.goodsBtn.frame = CGRectMake(centerX - 10 - 40, 7, 40, 30);
    self.detailBtn.frame = CGRectMake(centerX + 10, 7, 40, 30);
    self.goodsBtn.transform = CGAffineTransformMakeScale(1.08, 1.08);
    self.lineView.frame = CGRectMake(self.goodsBtn.center.x - 14, 41, 28, 2);
    
    self.titleLabel.frame = CGRectMake(0, self.scrollView.mj_h, self.scrollView.mj_w, self.scrollView.mj_h);
    
    [self.goodsBtn addTarget:self action:@selector(touchGoods:) forControlEvents:UIControlEventTouchUpInside];
    [self.detailBtn addTarget:self action:@selector(touchDetail:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:self.scrollView];
    
    
    
    [self.scrollView addSubview:self.goodsBtn];
    [self.scrollView addSubview:self.detailBtn];
    [self.scrollView addSubview:self.lineView];
    [self.scrollView addSubview:self.titleLabel];
}

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

- (void)touchGoods:(UIButton *)btn
{
//    [UIView animateWithDuration:0.2 animations:^{
//         self.lineView.frame = CGRectMake(self.goodsBtn.center.x - 14, 41, 28, 2);
//         self.goodsBtn.transform = CGAffineTransformMakeScale(1.08, 1.08);
//         self.detailBtn.transform = CGAffineTransformMakeScale(1.0, 1.0);
//    }completion:^(BOOL finished) {
        if (self.didTouchBlock) {
            self.didTouchBlock(GoodsDetailTouchGoodsType);
        }
    //}];
}

- (void)touchDetail:(UIButton *)btn
{
//    [UIView animateWithDuration:0.2 animations:^{
//        self.lineView.frame = CGRectMake(self.detailBtn.center.x - 14, 41, 28, 2);
//        self.goodsBtn.transform = CGAffineTransformMakeScale(1.0, 1.0);
//        self.detailBtn.transform = CGAffineTransformMakeScale(1.08, 1.08);
//    }completion:^(BOOL finished) {
        if (self.didTouchBlock) {
            self.didTouchBlock(GoodsDetailTouchDetailType);
        }
    //}];
}

- (UIButton *)goodsBtn
{
    if (!_goodsBtn) {
        _goodsBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [_goodsBtn setTitle:@"商品" forState:UIControlStateNormal];
        [_goodsBtn setTitleColor:UIFontMainGrayColor forState:UIControlStateNormal];
        _goodsBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    }
    return _goodsBtn;
}

- (UIButton *)detailBtn
{
    if (!_detailBtn) {
        _detailBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [_detailBtn setTitle:@"详情" forState:UIControlStateNormal];
        [_detailBtn setTitleColor:UIFontMainGrayColor forState:UIControlStateNormal];
        _detailBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    }
    return _detailBtn;
}

- (UIView *)lineView
{
    if (!_lineView) {
        _lineView = [[UIView alloc]init];
        _lineView.backgroundColor = UIFontMainGrayColor;
    }
    return _lineView;
}

- (UIScrollView  *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.mj_w, self.mj_h)];
        _scrollView.contentSize = CGSizeMake(self.mj_w, self.mj_h*2);
        _scrollView.pagingEnabled=YES;
    }
    return _scrollView;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font = [UIFont systemFontOfSize:17];
        _titleLabel.textColor = UIFontMainGrayColor;
        _titleLabel.text = @"商品详情";
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

- (void)setMainColor:(UIColor *)mainColor
{
    [self.goodsBtn setTitleColor:mainColor forState:UIControlStateNormal];
    [self.detailBtn setTitleColor:mainColor forState:UIControlStateNormal];
    self.titleLabel.textColor = mainColor;
    self.lineView.backgroundColor = mainColor;
}

@end
