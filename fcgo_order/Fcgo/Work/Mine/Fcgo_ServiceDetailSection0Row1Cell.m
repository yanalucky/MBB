//
//  Fcgo_ServiceDetailSection0Row1Cell.m
//  Fcgo
//
//  Created by huafanxiao on 2017/6/14.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_ServiceDetailSection0Row1Cell.h"

@interface Fcgo_ServiceDetailSection0Row1Cell ()

@property (weak, nonatomic) IBOutlet UIView *bottomLineView;

@end

@implementation Fcgo_ServiceDetailSection0Row1Cell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupUI];
}

- (void)setupUI
{
    WEAKSELF(weakSelf)
    self.selectionStyle = 0;
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakSelf.contentView.mas_centerY);
        make.left.mas_offset(15);
        
    }];
    self.titleLabel.textColor = UIFontMainGrayColor;
    self.titleLabel.font = UIFontSize(14);
    [self.descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakSelf.contentView.mas_centerY);
        make.left.mas_equalTo(weakSelf.titleLabel.mas_right).mas_offset(8);
    }];
    self.descLabel.textColor = UIFontMiddleGrayColor;
    self.descLabel.font = UIFontSize(14);
    
    self.bottomLineView.backgroundColor = UISepratorLineColor;
    [self.bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.mas_offset(0);
        make.left.mas_offset(15);
        make.height.mas_offset(0.5);
    }];
}
@end
