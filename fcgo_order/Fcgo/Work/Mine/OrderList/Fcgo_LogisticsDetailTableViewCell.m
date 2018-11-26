//
//  Fcgo_LogisticsDetailTableViewCell.m
//  Fcgo
//
//  Created by huafanxiao on 2017/5/26.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_LogisticsDetailTableViewCell.h"

@interface Fcgo_LogisticsDetailTableViewCell ()


@property (weak, nonatomic) IBOutlet UIView      *bottomLineView;

@end

@implementation Fcgo_LogisticsDetailTableViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setupUI];
}

- (void)setupUI
{
    WEAKSELF(weakSelf)
    self.selectionStyle = 0;
    [self.logisticsDeatilLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(10);
        make.left.mas_offset(50);
        make.right.mas_offset(-15);
    }];
    self.logisticsDeatilLabel.textColor = UIFontMainGrayColor;
    self.logisticsDeatilLabel.font = UIFontSize(14);
    
    [self.logisticsImagView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.logisticsDeatilLabel.mas_top);
        make.left.mas_offset(20);
        make.width.height.mas_offset(10);
    }];
    
    [self.logisticsTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_offset(-10);
        make.left.mas_equalTo(weakSelf.logisticsDeatilLabel.mas_left);
        make.right.mas_offset(-15);
    }];
    self.logisticsTimeLabel.textColor = UIFontMiddleGrayColor;
    self.logisticsTimeLabel.font = UIFontSize(12);
    
    [self.bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(0);
        make.bottom.mas_offset(0);
        make.left.mas_equalTo(weakSelf.logisticsDeatilLabel.mas_left);
        make.height.mas_offset(0.5);
    }];
    self.bottomLineView.backgroundColor = UISepratorLineColor;
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(0);
        make.centerX.mas_equalTo(weakSelf.logisticsImagView.mas_centerX);
        make.bottom.mas_offset(0);
        make.width.mas_offset(0.5);
    }];
    
    self.lineView.backgroundColor = UISepratorLineColor;
}

- (void)updateFrameWithIndex:(NSInteger)index
{
    WEAKSELF(weakSelf)
    if(index == 0)
    {
        self.logisticsImagView.image = [UIImage imageNamed:@"icon_red@2x"];
        [self.logisticsImagView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.logisticsDeatilLabel.mas_top).mas_offset(3);
            make.left.mas_offset(17);
            make.width.height.mas_offset(16);
        }];
        [self.lineView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.logisticsImagView.mas_bottom);
            make.centerX.mas_equalTo(weakSelf.logisticsImagView.mas_centerX);
            make.bottom.mas_offset(0);
            make.width.mas_offset(0.5);
        }];
        self.logisticsDeatilLabel.textColor = UIFontRedColor;
    }
    else
    {
        self.logisticsImagView.image = [UIImage imageNamed:@"icon_gray@2x"];
        [self.logisticsImagView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.logisticsDeatilLabel.mas_top).mas_offset(3);
            make.left.mas_offset(21);
            make.width.height.mas_offset(8);
        }];
        [self.lineView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_offset(0);
            make.centerX.mas_equalTo(weakSelf.logisticsImagView.mas_centerX);
            make.bottom.mas_offset(0);
            make.width.mas_offset(0.5);
        }];
        self.logisticsDeatilLabel.textColor = UIFontMainGrayColor;
    }
}

@end
