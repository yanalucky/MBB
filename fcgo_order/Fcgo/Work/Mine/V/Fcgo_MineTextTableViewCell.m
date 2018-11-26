//
//  Fcgo_MineTextTableViewCell.m
//  Fcgo
//
//  Created by huafanxiao on 2017/5/17.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_MineTextTableViewCell.h"

@interface Fcgo_MineTextTableViewCell()

@property (weak, nonatomic) IBOutlet UILabel     *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *arrowImageView;
@property (weak, nonatomic) IBOutlet UILabel     *descriptionLabel;

@end

@implementation Fcgo_MineTextTableViewCell

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
    
    self.descriptionLabel.alpha = 0;
    [self.descriptionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(0);
        make.bottom.mas_offset(0);
        make.right.mas_equalTo(weakSelf.arrowImageView.mas_left).mas_offset(-8);
    }];
    self.descriptionLabel.textColor = UIFontMiddleGrayColor;
    self.descriptionLabel.font = UIFontSize(14);
    

    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(0);
        make.bottom.mas_offset(0);
        make.left.mas_offset(15);
        make.right.mas_equalTo(weakSelf.descriptionLabel.mas_left).mas_offset(-10);
    }];
    self.titleLabel.textColor = UIFontMainGrayColor;
    self.titleLabel.font = UIFontSize(15);
}

- (void)setTitleString:(NSString *)titleString
{
    _titleString = titleString;
    self.titleLabel.text = titleString;
    
    if ([titleString isEqualToString:@"我的订单"]) {
        self.descriptionLabel.alpha = 1;
        self.descriptionLabel.text = @"全部订单";
    }else{
        self.descriptionLabel.alpha = 0;
    }
}

@end
