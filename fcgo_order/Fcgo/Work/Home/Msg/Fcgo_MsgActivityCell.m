//
//  Fcgo_MsgActivityCell.m
//  Fcgo
//
//  Created by huafanxiao on 2017/6/22.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_MsgActivityCell.h"

@interface Fcgo_MsgActivityCell ()

@property (weak, nonatomic) IBOutlet UIImageView *iconImgView;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIView *whiteView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIImageView *actImgView;

@end

@implementation Fcgo_MsgActivityCell

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
    
    [self.actImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.titleLabel.mas_bottom).mas_offset(10);
        make.right.mas_equalTo(weakSelf.whiteView.mas_right).mas_offset(-10);
         make.left.mas_equalTo(weakSelf.whiteView.mas_left).mas_offset(10);
         make.height.mas_offset((kScreenWidth-20-30)*276/614);
    }];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.actImgView.mas_bottom).mas_offset(15);
        make.left.mas_equalTo(weakSelf.whiteView.mas_left).mas_offset(12);
        make.right.mas_equalTo(weakSelf.whiteView.mas_right).mas_offset(-12);
    }];
    self.contentLabel.textColor = UIFontMainGrayColor;
    self.contentLabel.font = UIFontSize(13);
    self.contentLabel.numberOfLines = 2;
}

@end

