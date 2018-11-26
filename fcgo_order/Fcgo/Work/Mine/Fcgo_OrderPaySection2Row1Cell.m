//
//  Fcgo_OrderPaySection2Row1Cell.m
//  Fcgo
//
//  Created by huafanxiao on 2017/6/12.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_OrderPaySection2Row1Cell.h"

@interface Fcgo_OrderPaySection2Row1Cell ()
@property (weak, nonatomic) IBOutlet UIView *bottomLineView;
@end

@implementation Fcgo_OrderPaySection2Row1Cell

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setupUI];
}

- (void)setupUI
{
    WEAKSELF(weakSelf)
    [self.titleImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(15);
        make.top.mas_offset(5);
        make.bottom.mas_offset(-5);
        make.width.mas_equalTo(weakSelf.titleImageView.mas_height);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(0);
        make.bottom.mas_offset(0);
        make.left.mas_equalTo(weakSelf.titleImageView.mas_right).mas_offset(10);
    }];
    self.titleLabel.textColor = UIFontMainGrayColor;
    self.titleLabel.font = UIFontSize(15);
    
    [self.titleDescLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(0);
        make.bottom.mas_offset(0);
        make.left.mas_equalTo(weakSelf.titleLabel.mas_right).mas_offset(7);
        make.width.mas_offset(kAutoWidth6(200));
    }];
    self.titleDescLabel.textColor = UIFontMiddleGrayColor;
    self.titleDescLabel.font = UIFontSize(12);
    
    [self.selectImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakSelf.contentView);
        make.right.mas_offset(-15);
        make.height.mas_offset(kAutoWidth6(18));
        make.width.mas_offset(kAutoWidth6(18));
    }];
    
    self.bottomLineView.backgroundColor = UISepratorLineColor;
    [self.bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.mas_offset(0);
        make.left.mas_offset(15);
        make.height.mas_offset(0.5);
    }];
}



@end

