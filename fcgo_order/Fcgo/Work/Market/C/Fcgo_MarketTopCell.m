//
//  Fcgo_MarketTopCell.m
//  Fcgo
//
//  Created by huafanxiao on 2017/8/2.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_MarketTopCell.h"

@interface Fcgo_MarketTopCell ()

@property (weak, nonatomic) IBOutlet UIImageView *bgImgView;
@property (weak, nonatomic) IBOutlet UIImageView *headerImg;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *numLabel;
@property (weak, nonatomic) IBOutlet UIButton *shareBtn;
@property (weak, nonatomic) IBOutlet Fcgo_MarketButton *orderBtn;
@property (weak, nonatomic) IBOutlet UIView *line1;
@property (weak, nonatomic) IBOutlet Fcgo_MarketButton *incomeBtn;
@property (weak, nonatomic) IBOutlet UIView *line2;
@property (weak, nonatomic) IBOutlet Fcgo_MarketButton *VisitorsBtn;

@end

@implementation Fcgo_MarketTopCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self setupUI];
}

- (void)setupUI
{
    WEAKSELF(weakSelf);
    self.backgroundColor = UIFontWhiteColor;
    [self.bgImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.right.mas_offset(0);
    }];
    
    [self.headerImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(kAutoWidth6(30));
        make.left.mas_offset(kAutoWidth6(15));
        make.width.height.mas_offset(kAutoWidth6(55));
    }];
    
    self.headerImg.layer.cornerRadius = 5;
    self.headerImg.layer.masksToBounds = YES;
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(weakSelf.headerImg.mas_centerY).mas_offset(-2);
        make.left.mas_equalTo(weakSelf.headerImg.mas_right).mas_offset(kAutoWidth6(15));
        make.right.mas_offset(kAutoWidth6(-100));
    }];
    self.nameLabel.font = UIFontSacleSize(15);
    
    [self.numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.headerImg.mas_centerY).mas_offset(kAutoWidth6(5));
        make.left.mas_equalTo(weakSelf.nameLabel.mas_left);
        make.right.mas_equalTo(weakSelf.nameLabel.mas_right);
    }];
    self.numLabel.font = UIFontSacleSize(12);
    
    [self.shareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakSelf.headerImg.mas_centerY);
        make.height.mas_offset(kAutoWidth6(25));
        make.width.mas_offset(kAutoWidth6(25*50/22));
        make.right.mas_offset(0);
    }];
    self.shareBtn.titleLabel.font = UIFontSacleSize(11);
    
    CGFloat width = (kScreenWidth - 2)/3;
    
    [self.orderBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_offset(0);
        make.height.mas_offset(kAutoWidth6(50));
        make.width.mas_offset(width);
        make.left.mas_offset(0);
    }];
    
    self.orderBtn.bottomLabel.text = @"今日订单";
    [self.orderBtn setupUI];
    
    [self.line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakSelf.orderBtn.mas_centerY);
        make.left.mas_equalTo(weakSelf.orderBtn.mas_right).mas_offset(0);
        make.width.mas_offset(1);
        make.height.mas_offset(kAutoWidth6(20));
    }];
    [self.incomeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakSelf.orderBtn.mas_centerY);
        make.left.mas_equalTo(weakSelf.line1.mas_right).mas_offset(0);
        make.width.mas_offset(width);
        make.height.mas_equalTo(weakSelf.orderBtn.mas_height);
    }];
    self.incomeBtn.bottomLabel.text = @"今日收益";
    [self.incomeBtn setupUI];
    
    [self.line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakSelf.orderBtn.mas_centerY);
        make.left.mas_equalTo(weakSelf.incomeBtn.mas_right).mas_offset(0);
        make.width.mas_offset(1);
        make.height.mas_offset(kAutoWidth6(20));
    }];
    
    [self.VisitorsBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakSelf.orderBtn.mas_centerY);
        make.right.mas_offset(0);
        make.width.mas_offset(width);
        make.height.mas_equalTo(weakSelf.orderBtn.mas_height);
    }];
    self.VisitorsBtn.bottomLabel.text = @"累计访问";
    [self.VisitorsBtn setupUI];
    
    self.VisitorsBtn.topLabel.text = @"3000";
    self.incomeBtn.topLabel.text = @"3000";
    self.orderBtn.topLabel.text = @"30";
}
- (IBAction)share:(UIButton *)sender {
    if (self.shareBlock) {
        self.shareBlock();
    }
}
    
@end
