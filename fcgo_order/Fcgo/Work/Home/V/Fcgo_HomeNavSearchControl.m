//
//  Fcgo_HomeNavSearchControl.m
//  Fcgo
//
//  Created by huafanxiao on 2017/5/11.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_HomeNavSearchControl.h"


@interface Fcgo_HomeNavSearchControl()

@property (nonatomic,strong) UIImageView *searchImageView;
@property (nonatomic,strong) UILabel     *searchLabel;

@end

@implementation Fcgo_HomeNavSearchControl

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIRGBColor(245, 245, 245, 1);
        [self addTarget:self action:@selector(search) forControlEvents:UIControlEventTouchUpInside];
        
        self.layer.cornerRadius = 15;
        self.layer.masksToBounds = YES;
        
        
        [self addSubview:self.searchImageView];
        [self addSubview:self.searchLabel];
    }
    return self;
}

- (void)search
{
    if (self.searchBlock) {
        self.searchBlock();
    }
}

- (void)setupUI
{
    WEAKSELF(weakSelf)
    [self.searchImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(15);
        make.top.mas_offset(7);
        make.height.width.mas_offset(16);
    }];
    
    [self.searchLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_offset(0);
        make.left.mas_equalTo(weakSelf.searchImageView.mas_right).mas_offset(kAutoWidth6(10));
        make.right.mas_offset(-15);
    }];
}


- (void)setBgAlpha:(float)bgAlpha
{
    if (bgAlpha>0.7) {
        self.backgroundColor = UIRGBColor(235,235,235, 1);
        //self.searchLabel.textColor =  UIRGBColor(255, 255, 255, 1);
        _searchImageView.image = [UIImage imageWithName:@"w_search" ofType:@"png"];
    }else{
        self.backgroundColor = UIRGBColor(240, 240, 240, 1);
        //self.searchLabel.textColor =  UIStringColor(@"#8a8a8a");
        _searchImageView.image = [UIImage imageWithName:@"b_search" ofType:@"png"];
    }
}

- (UIImageView *)searchImageView
{
    if (!_searchImageView) {
        _searchImageView = [[UIImageView alloc]init];
         _searchImageView.image = [UIImage imageWithName:@"b_search" ofType:@"png"];
    }
    return _searchImageView;
}

- (UILabel *)searchLabel
{
    if (!_searchLabel) {
        _searchLabel = [[UILabel alloc]init];
        _searchLabel.font = [UIFont systemFontOfSize:13];
        _searchLabel.textColor = UIRGBColor(183,183,200, 1);
        _searchLabel.textAlignment = NSTextAlignmentLeft;
        _searchLabel.text = @"搜索商品 分类 功效 用户";
    }
    return _searchLabel;
}

@end
