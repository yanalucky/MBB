//
//  Fcgo_StoreManagerCell.m
//  Fcgo
//
//  Created by huafanxiao on 2017/11/24.
//  Copyright © 2017年 Fcg. All rights reserved.
//

#import "Fcgo_StoreManagerCell.h"

@interface Fcgo_StoreManagerCell ()

@property (weak, nonatomic) IBOutlet UIImageView *storeImageView;

@property (weak, nonatomic) IBOutlet UILabel     *storeNameLabel;

@property (weak, nonatomic) IBOutlet UIImageView *storeTelImageView;
@property (weak, nonatomic) IBOutlet UILabel     *storeTelLabel;

@property (weak, nonatomic) IBOutlet UIImageView *storeAdressImageView;
@property (weak, nonatomic) IBOutlet UILabel    *storeAdressLabel;


@property (weak, nonatomic) IBOutlet UIImageView *arrowImageView;
@property (weak, nonatomic) IBOutlet UIView      *bottomLineView;

@end

@implementation Fcgo_StoreManagerCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self setupUI];
}

- (void)setupUI
{
    WEAKSELF(weakSelf)
    self.selectionStyle = 0;
    
    [self.storeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakSelf.contentView);
        make.left.mas_offset(12);
        make.height.mas_offset(60);
        make.width.mas_offset(60*203/162);
    }];
    
    [self.storeNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.storeImageView.mas_top).mas_offset(0);
        make.left.mas_equalTo(weakSelf.storeImageView.mas_right).mas_offset(8);
        make.right.mas_offset(-20);
    }];
    self.storeNameLabel.textColor = UIFontMainGrayColor;
    self.storeNameLabel.font = UIFontSize(15);
    
    [self.storeTelImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakSelf.storeImageView.mas_centerY).mas_offset(2);
        make.left.mas_equalTo(weakSelf.storeImageView.mas_right).mas_offset(8);
        make.width.mas_offset(10);
        make.height.mas_offset(10);
    }];
    [self.storeTelLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakSelf.storeTelImageView.mas_centerY);
        make.left.mas_equalTo(weakSelf.storeTelImageView.mas_right).mas_offset(5);
        make.right.mas_offset(-20);
    }];
    self.storeTelLabel.textColor = UIFontBlack282828;
    self.storeTelLabel.font = UIFontSize(12);
    
    [self.storeAdressImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(weakSelf.storeImageView.mas_bottom).mas_offset(-2);
        make.left.mas_equalTo(weakSelf.storeImageView.mas_right).mas_offset(8);
        make.width.mas_offset(10);
        make.height.mas_offset(10);
    }];
    [self.storeAdressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakSelf.storeAdressImageView.mas_centerY);
        make.left.mas_equalTo(weakSelf.storeAdressImageView.mas_right).mas_offset(5);
        make.right.mas_offset(-20);
    }];
    self.storeAdressLabel.textColor = UIFontBlack282828;
    self.storeAdressLabel.font = UIFontSize(12);
    
    [self.arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakSelf.contentView);
        make.right.mas_offset(-10);
        make.width.mas_offset(16*19/36);
        make.height.mas_offset(16);
    }];
    
    [self.bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.mas_offset(0);
        make.height.mas_offset(0.5);
    }];
    self.bottomLineView.backgroundColor = UINavSepratorLineColor;
    
}

@end

