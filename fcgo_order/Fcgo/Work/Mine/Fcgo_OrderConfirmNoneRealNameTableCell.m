//
//  Fcgo_OrderConfirmNoneRealNameTableCell.m
//  Fcgo
//
//  Created by huafanxiao on 2017/6/12.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_OrderConfirmNoneRealNameTableCell.h"


@interface Fcgo_OrderConfirmNoneRealNameTableCell()

@property (weak, nonatomic) IBOutlet UILabel     *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *arrowImageView;
@property (weak, nonatomic) IBOutlet UILabel     *descriptionLabel;
@property (strong, nonatomic) IBOutlet UIView *bottomLineView;

@end

@implementation Fcgo_OrderConfirmNoneRealNameTableCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setupUI];
}

- (void)setupUI
{
    WEAKSELF(weakSelf)
    self.selectionStyle = 0;
    [self.arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakSelf.contentView);
        make.right.mas_offset(-15);
        make.width.mas_offset(16*19/36);
        make.height.mas_offset(16);
    }];
    
    
    [self.descriptionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(0);
        make.bottom.mas_offset(0);
        make.right.mas_equalTo(weakSelf.arrowImageView.mas_left).mas_offset(-8);
    }];
    self.descriptionLabel.textColor = UIFontRedColor;
    self.descriptionLabel.font = UIFontSize(15);
    
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(0);
        make.bottom.mas_offset(0);
        make.left.mas_offset(15);
        make.right.mas_equalTo(weakSelf.descriptionLabel.mas_left).mas_offset(-10);
    }];
    self.titleLabel.textColor = UIFontMiddleGrayColor;//UIFontMainGrayColor;
    self.titleLabel.font = UIFontSize(15);
    
    self.bottomLineView.backgroundColor = UIBackGroundColor;
    [self.bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_offset(0);
        make.height.mas_offset(5);
    }];
}


@end

