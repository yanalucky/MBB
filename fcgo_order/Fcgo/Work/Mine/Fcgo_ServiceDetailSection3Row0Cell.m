//
//  Fcgo_ServiceDetailSection3Row0Cell.m
//  Fcgo
//
//  Created by huafanxiao on 2017/6/14.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_ServiceDetailSection3Row0Cell.h"

@interface Fcgo_ServiceDetailSection3Row0Cell ()

@property (weak, nonatomic) IBOutlet UIView *whiteView;
@property (weak, nonatomic) IBOutlet UIView *bottomLineView;

@end

@implementation Fcgo_ServiceDetailSection3Row0Cell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupUI];
}

- (void)setupUI
{
    WEAKSELF(weakSelf)
    self.selectionStyle = 0;
    self.backgroundColor = UIBackGroundColor;
    [self.whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(15);
        make.right.mas_offset(-15);
        make.top.bottom.mas_offset(0);
        
    }];
    self.whiteView.backgroundColor = UIFontWhiteColor;
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakSelf.contentView.mas_centerY);
        make.left.mas_equalTo(weakSelf.whiteView.mas_left).mas_offset(12);
    }];
    self.titleLabel.textColor = UIFontMiddleGrayColor;
    self.titleLabel.font = UIFontSize(14);
    self.titleLabel.numberOfLines = 0;
    
    self.bottomLineView.backgroundColor = UISepratorLineColor;
    [self.bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_offset(0);
        make.right.mas_equalTo(weakSelf.whiteView.mas_right);
        make.left.mas_equalTo(weakSelf.whiteView.mas_left);
        make.height.mas_offset(0.5);
    }];

}

@end
