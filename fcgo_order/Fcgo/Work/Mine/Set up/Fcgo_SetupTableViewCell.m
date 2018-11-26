
//
//  Fcgo_SetupTableViewCell.m
//  Fcgo
//
//  Created by huafanxiao on 2017/5/16.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_SetupTableViewCell.h"

@interface Fcgo_SetupTableViewCell()



@end

@implementation Fcgo_SetupTableViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setupUI];
}

- (void)setupUI
{
    WEAKSELF(weakSelf)
    [self.arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakSelf.contentView);
        make.right.mas_offset(-10);
        make.width.mas_offset(16*19/36);
        make.height.mas_offset(16);
    }];
    
    self.cacheLabel.alpha = 0;
    [self.cacheLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(0);
        make.bottom.mas_offset(0);
        make.right.mas_equalTo(weakSelf.arrowImageView.mas_left).mas_offset(-8);
    }];
    self.cacheLabel.textColor = UIFontMiddleGrayColor;
    self.cacheLabel.font = UIFontSize(14);
    
    self.activityIndicatorView.alpha = 0;
    [self.activityIndicatorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakSelf.contentView);
        make.right.mas_offset(-10);
        make.height.mas_offset(36);
    }];

    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(0);
        make.bottom.mas_offset(0);
        make.left.mas_offset(15);
        make.right.mas_equalTo(weakSelf.cacheLabel.mas_left).mas_offset(-10);
    }];
    self.titleLabel.textColor = UIFontMainGrayColor;
    self.titleLabel.font = UIFontSize(15);
}

- (void)setTitleString:(NSString *)titleString
{
    _titleString = titleString;
    if ([titleString isEqualToString:@"清除缓存"]) {
        self.cacheLabel.alpha = 1;
        NSString *cacheString = [NSString stringWithFormat:@"%.2fM",(float)[[SDImageCache sharedImageCache] getSize]/1024/1024];
        self.cacheLabel.text = cacheString;
    }else{
        self.cacheLabel.alpha = 0;
    }
    self.titleLabel.text = titleString;
}

- (void)startActivityIndicatorView
{
    self.cacheLabel.alpha = 0;
    self.activityIndicatorView.alpha = 1;
    self.arrowImageView.alpha        = 0;
    [self.activityIndicatorView startAnimating];
}

- (void)stopActivityIndicatorView
{
    self.cacheLabel.alpha = 1;
    self.cacheLabel.text = @"0.00M";
    self.activityIndicatorView.alpha = 0;
    self.arrowImageView.alpha        = 1;
    [self.activityIndicatorView stopAnimating];
}

@end
