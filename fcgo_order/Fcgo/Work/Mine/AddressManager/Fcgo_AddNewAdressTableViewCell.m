//
//  Fcgo_AddNewAdressTableViewCell.m
//  Fcgo
//
//  Created by huafanxiao on 2017/5/27.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_AddNewAdressTableViewCell.h"


@interface Fcgo_AddNewAdressTableViewCell ()

@property (weak, nonatomic) IBOutlet UIView      *bottomLineView;
@property (weak, nonatomic) IBOutlet UIImageView *noneAdressImageView;
@property (weak, nonatomic) IBOutlet UILabel *noneAdressLabel;

@end

@implementation Fcgo_AddNewAdressTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupUI];
}

- (void)setupUI
{
    WEAKSELF(weakSelf)
    self.selectionStyle = 0;
    [self.bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_offset(0);
        make.height.mas_offset(5);
    }];
    self.bottomLineView.backgroundColor = UIBackGroundColor;
    
    [self.noneAdressImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(weakSelf.contentView);
        make.bottom.mas_equalTo(weakSelf.contentView.mas_centerY).mas_offset(-5);
        make.width.height.mas_offset(40);
    }];
    
    [self.noneAdressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(15);
        make.top.mas_equalTo(weakSelf.contentView.mas_centerY).mas_offset(15);
        make.right.mas_offset(-15);
    }];
    
    NSMutableAttributedString *content = [[NSMutableAttributedString alloc]initWithString:self.noneAdressLabel.text];
    [content addAttribute:NSForegroundColorAttributeName value:UIFontMiddleGrayColor range:NSMakeRange(0, 9)];
    [content addAttribute:NSForegroundColorAttributeName value:UIFontRedColor range:NSMakeRange(9, self.noneAdressLabel.text.length - 9)];
    self.noneAdressLabel.attributedText = content;
}

- (void)setIsNoneSelected:(BOOL)isNoneSelected
{
    _isNoneSelected = isNoneSelected;
    if (isNoneSelected) {
        WEAKSELF(weakSelf)
        [self.noneAdressLabel mas_updateConstraints: ^(MASConstraintMaker *make) {
            make.left.mas_offset(15);
            make.top.mas_equalTo(weakSelf.contentView.mas_centerY).mas_offset(15);
            make.right.mas_offset(-15);
        }];
        self.noneAdressLabel.text = @"点击选择收货地址 >>";
        self.noneAdressLabel.textColor = UIFontMiddleGrayColor;
    }
}

@end