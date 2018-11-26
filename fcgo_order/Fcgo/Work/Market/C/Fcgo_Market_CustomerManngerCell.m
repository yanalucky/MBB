//
//  Fcgo_Market_CustomerManngerCell.m
//  Fcgo
//
//  Created by huafanxiao on 2017/8/2.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_Market_CustomerManngerCell.h"

@interface Fcgo_Market_CustomerManngerCell ()
@property (weak, nonatomic) IBOutlet UIImageView *headerImg;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIView *bottomLine;
@property (weak, nonatomic) IBOutlet UIImageView *arrowImageView;


@end

@implementation Fcgo_Market_CustomerManngerCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setupUI];
}

- (void)setupUI
{
    WEAKSELF(weakSelf);
    [self.headerImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(15);
        make.centerY.mas_equalTo(weakSelf.contentView.mas_centerY);
        make.height.width.mas_offset(kAutoWidth6(40));
    }];
    self.headerImg.layer.cornerRadius = kAutoWidth6(18);
    self.headerImg.layer.masksToBounds = YES;
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.headerImg.mas_right).mas_offset(kAutoWidth6(15));
        make.centerY.mas_equalTo(weakSelf.headerImg.mas_centerY);
    }];
    self.nameLabel.textColor = UIFontMainGrayColor;
    [self.arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakSelf.contentView);
        make.right.mas_offset(-10);
        make.width.mas_offset(16*19/36);
        make.height.mas_offset(16);
    }];
    
    self.bottomLine.backgroundColor = UISepratorLineColor;
    [self.bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.mas_offset(0);
        make.height.mas_offset(0.5);
    }];
}

@end
