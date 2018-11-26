//
//  Fcgo_BrokenNetworkOrNoDataControl.m
//  Fcgo
//
//  Created by huafanxiao on 2017/7/5.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_BrokenNetworkOrNoDataControl.h"

@interface Fcgo_BrokenNetworkOrNoDataControl()

@property (nonatomic,strong) UIImageView *notConnectImageView;
@property (nonatomic,strong) UILabel     *notConnectLabel;

@end

@implementation Fcgo_BrokenNetworkOrNoDataControl

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addTarget:self action:@selector(reload) forControlEvents:UIControlEventTouchUpInside];
        
        
        [self setupUI];
    }
    return self;
}

- (void)reload
{
    if (self.reloadBlock) {
        self.reloadBlock();
    }
}

- (void)setupUI
{
    WEAKSELF(weakSelf)
    [self addSubview:self.notConnectImageView];
    [self addSubview:self.notConnectLabel];
    [self.notConnectImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(weakSelf.mas_centerX);
        make.top.mas_offset(kAutoWidth6(100));
        make.height.width.mas_offset(kAutoWidth6(120));
    }];
    [self.notConnectLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.notConnectImageView.mas_bottom).mas_offset(kAutoWidth6(40));
        make.centerX.mas_equalTo(weakSelf.mas_centerX);
    }];
}

- (UIImageView *)notConnectImageView
{
    if (!_notConnectImageView) {
        _notConnectImageView = [[UIImageView alloc]init];
        
    }
    return _notConnectImageView;
}

- (UILabel *)notConnectLabel
{
    if (!_notConnectLabel) {
        _notConnectLabel = [[UILabel alloc]init];
        _notConnectLabel.font = [UIFont systemFontOfSize:14];
        _notConnectLabel.textColor = UIFontSortGrayColor;
        _notConnectLabel.textAlignment = NSTextAlignmentCenter;
        _notConnectLabel.numberOfLines = 2;
    }
    return _notConnectLabel;
}

- (void)setImageString:(NSString *)imageString
{
    _imageString = imageString;
    self.notConnectImageView.image = [UIImage imageNamed:imageString];
}

- (void)setTitleString:(NSString *)titleString
{
    _titleString = titleString;
    self.notConnectLabel.text = titleString;
}

@end

