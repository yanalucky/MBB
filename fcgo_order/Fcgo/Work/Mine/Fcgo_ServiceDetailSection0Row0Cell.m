//
//  Fcgo_ServiceDetailSection0Row0Cell.m
//  Fcgo
//
//  Created by huafanxiao on 2017/6/14.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_ServiceDetailSection0Row0Cell.h"


@interface Fcgo_ServiceDetailSection0Row0Cell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImg;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UIView *bottomLineView;

@end

@implementation Fcgo_ServiceDetailSection0Row0Cell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupUI];
}

- (void)setupUI
{
    WEAKSELF(weakSelf)
    self.selectionStyle = 0;
    [self.iconImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakSelf.contentView.mas_centerY);
        make.left.mas_offset(15);
        make.height.width.mas_offset(30);
    }];
    [self.statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakSelf.iconImg.mas_centerY);
        make.left.mas_equalTo(weakSelf.iconImg.mas_right).mas_offset(8);
    }];
    self.statusLabel.textColor = UIFontMainGrayColor;
    self.statusLabel.font = UIFontSize(17);
    
    self.bottomLineView.backgroundColor = UISepratorLineColor;
    [self.bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.mas_offset(0);
        make.left.mas_offset(15);
        make.height.mas_offset(0.5);
    }];
}

- (void)setDetailModel:(Fcgo_AfterSalesService_DetailModel *)detailModel
{
    _detailModel = detailModel;
    if (detailModel.f_status.intValue == 0) {
        self.statusLabel.text = @"待审核";
    }
    else if (detailModel.f_status.intValue == 1) {
        self.statusLabel.text = @"处理中";
    }
    else if (detailModel.f_status.intValue == 100) {
        self.statusLabel.text = @"处理完成";
    }
    else if (detailModel.f_status.intValue == 50) {
        self.statusLabel.text = @"已驳回";
    }
}


@end
