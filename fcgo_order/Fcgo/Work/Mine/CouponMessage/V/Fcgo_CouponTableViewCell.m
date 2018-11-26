//
//  Fcgo_CouponTableViewCell.m
//  Fcgo
//
//  Created by huafanxiao on 2017/5/26.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_CouponTableViewCell.h"

@interface Fcgo_CouponTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *leftImageView;
@property (weak, nonatomic) IBOutlet UIImageView *getImageView;
@property (weak, nonatomic) IBOutlet UILabel *getCountLabel;
@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;
@property (weak, nonatomic) IBOutlet UILabel     *AmountLabel;
@property (weak, nonatomic) IBOutlet UILabel     *AmountTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel     *useLabel;
@property (weak, nonatomic) IBOutlet UILabel     *userDescriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel     *passedTimeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *couponStatusImageView;
@property (weak, nonatomic) IBOutlet UIButton *geBtn;

@end

@implementation Fcgo_CouponTableViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setupUI];
}

- (void)setupUI
{
    WEAKSELF(weakSelf)
    self.selectionStyle = 0;
    self.contentView.backgroundColor = UIBackGroundColor;
    [self.leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.top.mas_offset(5);
        make.width.mas_equalTo(weakSelf.leftImageView.mas_height);
        make.bottom.mas_offset(0);
    }];
    [self.getImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(8);
        make.top.mas_offset(9);
        make.right.mas_equalTo(weakSelf.leftImageView.mas_right);
        make.height.mas_offset(20);
    }];
    
    self.getImageView.hidden = 1;
    
    [self.getCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.mas_equalTo(weakSelf.getImageView);
        make.left.mas_equalTo(weakSelf.getImageView.mas_left).mas_offset(5);
        make.height.mas_offset(15);
    }];
    
    self.getCountLabel.textColor = UIFontWhiteColor;
    self.getCountLabel.hidden = 1;
    
    
    [self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_offset(0);
        make.top.mas_offset(5);
        make.left.mas_equalTo(weakSelf.leftImageView.mas_right).mas_offset(0);
        make.right.mas_offset(-10);
    }];
    
    //self.bgImageView.image = [UIImage imageNamed:@"bg_coupon"];
    self.bgImageView.backgroundColor = UIFontWhiteColor;
    
    [self.AmountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(weakSelf.leftImageView.mas_centerY);
        make.left.mas_equalTo(weakSelf.leftImageView.mas_left);
        make.right.mas_equalTo(weakSelf.leftImageView.mas_right);
    }];
    
    self.AmountLabel.textColor = UIFontWhiteColor;
    self.AmountLabel.adjustsFontSizeToFitWidth = YES;
    
    NSMutableAttributedString *content = [[NSMutableAttributedString alloc]initWithString:self.AmountLabel.text];
   [content addAttribute:NSFontAttributeName value:UIBoldFontSize(15) range:NSMakeRange(0, 1)];
    [content addAttribute:NSFontAttributeName value:UIBoldFontSize(30) range:NSMakeRange(1, self.AmountLabel.text.length - 1)];
    self.AmountLabel.attributedText = content;
    //self.AmountLabel.text = @"";
    
    [self.AmountTypeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.leftImageView.mas_centerY).mas_offset(kAutoWidth6(10));
        make.left.mas_equalTo(weakSelf.leftImageView.mas_left);
        make.right.mas_equalTo(weakSelf.leftImageView.mas_right);
    }];
    
    self.AmountTypeLabel.textColor = UIFontWhiteColor;
    self.AmountTypeLabel.font = UIFontSize(13);
    
    [self.useLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.bgImageView.mas_top).mas_offset(kAutoWidth6(10));
        make.left.mas_equalTo(weakSelf.leftImageView.mas_right).mas_offset(kAutoWidth6(10));
    }];
    
    self.useLabel.textColor = UIFontMainGrayColor;
    self.useLabel.font = UIFontSize(12);
    
    self.useLabel.hidden = 1;
    
//    [self.userDescriptionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(weakSelf.useLabel.mas_bottom).mas_offset(kAutoWidth6(8));
//        make.left.mas_equalTo(weakSelf.leftImageView.mas_right).mas_offset(kAutoWidth6(10));
//        make.right.mas_offset(-12);
//    }];
    
    [self.userDescriptionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.bgImageView.mas_top).mas_offset(kAutoWidth6(10));
        make.left.mas_equalTo(weakSelf.leftImageView.mas_right).mas_offset(kAutoWidth6(10));
        make.right.mas_offset(-15);
    }];

    
    self.userDescriptionLabel.textColor = UIFontSortGrayColor;
    self.userDescriptionLabel.font = UIFontSize(14);
    
    
    [self.passedTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_offset(-5);
        make.right.mas_equalTo(weakSelf.bgImageView.mas_right).mas_offset(kAutoWidth6(-10));
    }];
    
    self.passedTimeLabel.textColor = UIFontMiddleGrayColor;
    self.passedTimeLabel.font = UIFontSize(12);
    
    self.geBtn.layer.borderColor   = UIFontRedColor.CGColor;
    self.geBtn.layer.borderWidth   = 0.5;
    self.geBtn.layer.cornerRadius  = 3;
    self.geBtn.layer.masksToBounds = 1;
    self.geBtn.userInteractionEnabled = 0;
    [self.geBtn setTitleColor:UIFontRedColor forState:UIControlStateNormal];
    [self.geBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(weakSelf.bgImageView.mas_right).mas_offset(kAutoWidth6(-10));
        make.height.mas_offset(25);
        make.width.mas_offset(70);
        make.bottom.mas_equalTo(weakSelf.passedTimeLabel.mas_top).mas_offset(-5);
    }];
    
    [self.couponStatusImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        CGFloat height = kAutoWidth6(55) *105/116 ;
        make.centerY.mas_equalTo(weakSelf.bgImageView.mas_centerY).mas_offset(kAutoWidth6(-10));
        make.width.mas_offset(kAutoWidth6(55));
        make.height.mas_offset(kAutoWidth6(height));
        make.right.mas_offset(-16);
    }];
    self.geBtn.hidden = 1;
    
    
    
    [self.AmountLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(weakSelf.leftImageView.mas_centerY).mas_offset(kAutoWidth6(15));
        make.left.mas_equalTo(weakSelf.leftImageView.mas_left);
        make.right.mas_equalTo(weakSelf.leftImageView.mas_right);
    }];
    [self.AmountTypeLabel mas_updateConstraints:  ^(MASConstraintMaker *make) {make.top.mas_equalTo(weakSelf.leftImageView.mas_centerY).mas_offset(kAutoWidth6(20));
        make.left.mas_equalTo(weakSelf.leftImageView.mas_left);
        make.right.mas_equalTo(weakSelf.leftImageView.mas_right);
    }];
}


- (void)showGetBtn
{
    self.couponStatusImageView.hidden = 1;
    self.geBtn.hidden = 0;
    
    
    self.getCountLabel.hidden = 0;
    self.getImageView.hidden = 0;
    WEAKSELF(weakSelf)
    
//    [self.AmountLabel mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.bottom.mas_equalTo(weakSelf.leftImageView.mas_centerY).mas_offset(kAutoWidth6(10));
//        make.left.mas_equalTo(weakSelf.leftImageView.mas_left);
//        make.right.mas_equalTo(weakSelf.leftImageView.mas_right);
//    }];
//    [self.AmountTypeLabel mas_updateConstraints:  ^(MASConstraintMaker *make) {make.top.mas_equalTo(weakSelf.leftImageView.mas_centerY).mas_offset(kAutoWidth6(20));
//        make.left.mas_equalTo(weakSelf.leftImageView.mas_left);
//        make.right.mas_equalTo(weakSelf.leftImageView.mas_right);
//    }];
}

- (void)setStatusType:(CouponStatusType)statusType
{
    self.couponStatusImageView.hidden = 0;
    _statusType = statusType;
    switch (statusType) {
        case CouponStatusUnusedType:
        {
            self.leftImageView.image = [UIImage imageNamed:@"gray_coupon_mine"];
            self.couponStatusImageView.image = [UIImage imageNamed:@"use_mine"];
            
        }
            break;
        case CouponStatusUsedType:
        {
            self.leftImageView.image = [UIImage imageNamed:@"red_coupon_mine"];
            self.couponStatusImageView.hidden = 1;

        }
            break;
        case CouponStatusPassedUsedType:
        {
            self.leftImageView.image = [UIImage imageNamed:@"gray_coupon_mine"];
            self.couponStatusImageView.image = [UIImage imageNamed:@"overdue_mine"];
        }
            break;
        default:
            break;
    }
}

- (void)setModel:(Fcgo_CouponModel *)model
{
    _model = model;
    
    if (!model.status) {
        self.statusType = CouponStatusUsedType;
    }
    else{
        self.statusType = model.status.intValue;
    }
    
    NSMutableAttributedString *content = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"¥ %@",model.couponLoanYuan.stringValue]];
    [content addAttribute:NSFontAttributeName value:UIBoldFontSize(15) range:NSMakeRange(0, 1)];
    [content addAttribute:NSFontAttributeName value:UIBoldFontSize(30) range:NSMakeRange(1, content.length - 1)];
    self.AmountLabel.attributedText = content;
    
    self.AmountTypeLabel.text = model.couponName;
    self.userDescriptionLabel.text = [NSString stringWithFormat:@"使用说明:   %@",model.useIntroduce];
    self.passedTimeLabel.text = model.useEnd;
    

}

- (void)setRunModel:(Fcgo_CouponRunModel *)runModel
{
    _runModel = runModel;
    self.leftImageView.image = [UIImage imageNamed:@"red_coupon_mine"];
    self.couponStatusImageView.hidden = 1;
    NSMutableAttributedString *content = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"¥ %@",runModel.couponLoanYuan]];
    [content addAttribute:NSFontAttributeName value:UIBoldFontSize(15) range:NSMakeRange(0, 1)];
    [content addAttribute:NSFontAttributeName value:UIBoldFontSize(30) range:NSMakeRange(1, content.length - 1)];
    self.AmountLabel.attributedText = content;
    if (runModel.couponName && ![runModel.couponName isEqualToString:@""]) {
         self.AmountTypeLabel.text = runModel.couponName;
    }else{
         self.AmountTypeLabel.text = runModel.couponName;
    }
    self.userDescriptionLabel.text = [NSString stringWithFormat:@"使用说明:  %@",runModel.useIntroduce];
    self.passedTimeLabel.text = runModel.useEnd;
    
    NSString *getString = [NSString stringWithFormat:@"%@",runModel.drawTotal];
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@""];
    NSMutableAttributedString *string1 = [[NSMutableAttributedString alloc] initWithString:@"还可领取"];
    NSRange range1 = NSMakeRange(0, string1.length);
    [string1 addAttribute:NSFontAttributeName value:UIFontSize(10) range:range1];
    [string1 addAttribute:NSForegroundColorAttributeName value:UIFontWhiteColor range:range1];
    
    NSMutableAttributedString *string2 = [[NSMutableAttributedString alloc] initWithString:getString];
    NSRange range2 = NSMakeRange(0, string2.length);
    [string2 addAttribute:NSFontAttributeName value:UIFontSize(13) range:range2];
    [string2 addAttribute:NSForegroundColorAttributeName value:UIFontWhiteColor range:range2];
    
    NSMutableAttributedString *string3 = [[NSMutableAttributedString alloc] initWithString:@"次"];
    NSRange range3 = NSMakeRange(0, string3.length);
    [string3 addAttribute:NSFontAttributeName value:UIFontSize(10) range:range3];
    [string3 addAttribute:NSForegroundColorAttributeName value:UIFontWhiteColor range:range3];
    [string appendAttributedString:string1];
    [string appendAttributedString:string2];
    [string appendAttributedString:string3];
    
    self.getCountLabel.attributedText = string;
}

@end
