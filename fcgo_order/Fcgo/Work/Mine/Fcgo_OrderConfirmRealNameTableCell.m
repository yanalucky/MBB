//
//  Fcgo_OrderConfirmRealNameTableCell.m
//  Fcgo
//
//  Created by huafanxiao on 2017/6/12.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_OrderConfirmRealNameTableCell.h"

@interface Fcgo_OrderConfirmRealNameTableCell ()

@property (weak, nonatomic) IBOutlet UIImageView *customerImageView;
@property (weak, nonatomic) IBOutlet UILabel     *customerNameLabel;

@property (weak, nonatomic) IBOutlet UIImageView *cardImageView;
@property (weak, nonatomic) IBOutlet UILabel     *cardLabel;

@property (weak, nonatomic) IBOutlet UIImageView *mainCardImageView;
@property (weak, nonatomic) IBOutlet UIImageView *backCardImageView;


@property (strong, nonatomic) IBOutlet UIView *bottomLineView;

@end

@implementation Fcgo_OrderConfirmRealNameTableCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setupUI];
}

- (void)setupUI
{
    WEAKSELF(weakSelf)
    self.selectionStyle = 0;
    
    [self.customerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(16);
        make.left.mas_offset(15);
        make.height.width.mas_offset(18);
    }];
    
    [self.customerNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.customerImageView.mas_right).mas_offset(10);
        make.bottom.mas_equalTo(weakSelf.customerImageView.mas_bottom);
        make.width.mas_offset(70);
    }];
    self.customerNameLabel.textColor = UIFontMainGrayColor;
    
    [self.cardImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.customerImageView.mas_bottom).mas_offset(10);
        make.left.mas_offset(15);
        make.height.width.mas_offset(18);
    }];
    
    [self.cardLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.cardImageView.mas_right).mas_offset(10);
        make.bottom.mas_equalTo(weakSelf.cardImageView.mas_bottom);
    }];
    self.cardLabel.textColor = UIFontMainGrayColor;
    
    [self.mainCardImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(15);
        make.top.mas_equalTo(weakSelf.cardImageView.mas_bottom).mas_offset(10);
        make.height.mas_offset(kAutoWidth6(60));
        make.width.mas_offset(kAutoWidth6(100));
    }];
    
    [self.backCardImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.mainCardImageView.mas_right).mas_offset(10);
        make.top.mas_equalTo(weakSelf.cardLabel.mas_bottom).mas_offset(10);
        make.height.mas_offset(kAutoWidth6(60));
        make.width.mas_offset(kAutoWidth6(100));
    }];
    
    [self.arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakSelf.contentView.mas_centerY).mas_offset(-2.5);
        make.right.mas_offset(-10);
        make.width.mas_offset(16*19/36);
        make.height.mas_offset(16);
    }];
    
    self.bottomLineView.backgroundColor = UIBackGroundColor;
    [self.bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_offset(0);
        make.height.mas_offset(5);
    }];
}


- (void)setModel:(Fcgo_RealNameModel *)model
{
    _model = model;
    
    self.customerNameLabel.text = model.mchRealName;
    NSString *string = model.mchIdcard;
    if (string.length>10) {
        self.cardLabel.text = [NSString stringWithFormat:@"%@***********%@",[string substringWithRange:NSMakeRange(0, 3)],[string substringWithRange:NSMakeRange(string.length-4, 4)]];
    }
    [self.mainCardImageView sd_setImageWithURL:[NSURL URLWithString:model.mchPicurlW] placeholderImage:[UIImage imageNamed:@"756X300(分类）"]];
    [self.backCardImageView sd_setImageWithURL:[NSURL URLWithString:model.mchPicurlB] placeholderImage:[UIImage imageNamed:@"756X300(分类）"]];
}

@end


