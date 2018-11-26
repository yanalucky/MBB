//
//  Fcgo_MsgSystemCell.m
//  Fcgo
//
//  Created by huafanxiao on 2017/6/22.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_MsgSystemCell.h"

@interface Fcgo_MsgSystemCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImgView;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIView *whiteView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIView *middleView;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;
@property (weak, nonatomic) IBOutlet UIImageView *arrowImgView;

@end

@implementation Fcgo_MsgSystemCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setupUI];
}

- (void)setupUI
    {
        self.contentView.backgroundColor = UIBackGroundColor;
        self.selectionStyle = 0;
        WEAKSELF(weakSelf)
        [self.iconImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_offset(10);
            make.left.mas_offset(15);
            make.height.mas_offset(20);
            make.width.mas_offset(20);
        }];
        
        [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(weakSelf.iconImgView.mas_centerY);
            make.left.mas_equalTo(weakSelf.iconImgView.mas_right).mas_offset(10);
        }];
        self.timeLabel.textColor = UIFontMainGrayColor;
        self.timeLabel.font = UIFontSize(12);
        
        [self.whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_offset(40);
            make.right.mas_offset(-15);
            make.left.mas_offset(15);
            make.bottom.mas_offset(0);
        }];
        self.whiteView.backgroundColor = UIFontWhiteColor;
        
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.whiteView.mas_top).mas_offset(10);
            make.left.mas_equalTo(weakSelf.whiteView.mas_left).mas_offset(12);
            make.right.mas_equalTo(weakSelf.whiteView.mas_right).mas_offset(-12);
        }];
        self.titleLabel.textColor = UIFontMainGrayColor;
        self.titleLabel.font = UIFontSize(15);
        
        [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.titleLabel.mas_bottom).mas_offset(15);
            make.left.mas_equalTo(weakSelf.whiteView.mas_left).mas_offset(12);
            make.right.mas_equalTo(weakSelf.whiteView.mas_right).mas_offset(-12);
        }];
        self.contentLabel.textColor = UIFontMainGrayColor;
        self.contentLabel.font = UIFontSize(13);
        self.contentLabel.numberOfLines = 2;
        
        [self.middleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.contentLabel.mas_bottom).mas_offset(12);
            make.right.mas_equalTo(weakSelf.whiteView.mas_right).mas_offset(-12);
            make.left.mas_equalTo(weakSelf.whiteView.mas_left).mas_offset(12);
            make.height.mas_offset(0.5);
        }];
        self.middleView.backgroundColor = UISepratorLineColor;
        
        [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.middleView.mas_bottom).mas_offset(12);
            make.left.mas_equalTo(weakSelf.whiteView.mas_left).mas_offset(12);
        }];
        self.detailLabel.textColor = UIFontMainGrayColor;
        self.detailLabel.font = UIFontSize(15);
        
        [self.arrowImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(weakSelf.detailLabel.mas_centerY);
            make.right.mas_equalTo(weakSelf.whiteView.mas_right).mas_offset(-10);
            make.width.mas_offset(16*19/36);
            make.height.mas_offset(16);
        }];
}


@end
