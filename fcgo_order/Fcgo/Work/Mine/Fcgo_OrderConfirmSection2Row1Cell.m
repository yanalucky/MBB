//
//  Fcgo_OrderConfirmSection2Row1Cell.m
//  Fcgo
//
//  Created by huafanxiao on 2017/6/12.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_OrderConfirmSection2Row1Cell.h"

@interface Fcgo_OrderConfirmSection2Row1Cell()




@property (strong, nonatomic) IBOutlet UIView    *bottomLineView;

@end

@implementation Fcgo_OrderConfirmSection2Row1Cell

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
        make.right.mas_offset(-10);
        make.width.mas_offset(16*19/36);
        make.height.mas_offset(16);
    }];
    
    
    [self.descriptionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(0);
        make.bottom.mas_offset(0);
        make.right.mas_equalTo(weakSelf.arrowImageView.mas_left).mas_offset(-8);
        make.left.mas_offset(120);
    }];
    self.descriptionLabel.textColor = UIFontRedColor;
    self.descriptionLabel.font = UIFontSize(15);
    
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(0);
        make.bottom.mas_offset(0);
        make.left.mas_offset(15);
    }];
    self.titleLabel.textColor = UIFontMainGrayColor;
    self.titleLabel.font = UIFontSize(15);
    
    self.bottomLineView.backgroundColor = UIBackGroundColor;
    [self.bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_offset(0);
        make.height.mas_offset(0.5);
    }];
}

- (void)setIsShowArrowImage:(BOOL)isShowArrowImage
{
    _isShowArrowImage = isShowArrowImage;
    self.arrowImageView.hidden = !isShowArrowImage;
    WEAKSELF(weakSelf)
    if (isShowArrowImage) {
        [self.arrowImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(weakSelf.contentView);
            make.right.mas_offset(-15);
            make.width.mas_offset(16*19/36);
            make.height.mas_offset(16);
        }];
        [self.descriptionLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_offset(0);
            make.bottom.mas_offset(0);
            make.right.mas_equalTo(weakSelf.arrowImageView.mas_left).mas_offset(-8);
            make.left.mas_offset(120);
        }];
    }
    else{
        [self.descriptionLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_offset(0);
            make.bottom.mas_offset(0);
            make.right.mas_offset(-15);
            make.left.mas_offset(120);
        }];
    }
}
@end

