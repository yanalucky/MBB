//
//  Fcgo_OrderDetailLeftMessageTableViewCell.m
//  Fcgo
//
//  Created by huafanxiao on 2017/8/9.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_OrderDetailLeftMessageTableViewCell.h"

@interface Fcgo_OrderDetailLeftMessageTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@end

@implementation Fcgo_OrderDetailLeftMessageTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupUI];
}

- (void)setupUI
{
    self.selectionStyle = 0;
    WEAKSELF(weakSelf)
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.centerY.mas_equalTo(weakSelf.mas_centerY).mas_offset(-2.5);
        make.left.mas_offset(15);
        make.width.mas_offset(65);
        
    }];
    self.titleLabel.textColor = UIFontMiddleGrayColor;
    self.titleLabel.font = UIFontSize(13);
    
    [self.descriptionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakSelf.titleLabel.mas_centerY);
        make.left.mas_equalTo(weakSelf.titleLabel.mas_right).mas_offset(0);
        make.right.mas_offset(-15);
    }];
    self.descriptionLabel.textColor = UIFontMiddleGrayColor;
    self.descriptionLabel.font = UIFontSize(13);
    
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.height.mas_offset(5);
         make.left.right.bottom.mas_offset(0);
         
     }];
    
    self.bottomView.backgroundColor = UIBackGroundColor;
}

- (void)setModel:(Fcgo_OrderDetailModel *)model
{
    _model = model;
    self.descriptionLabel.text = model.remark;
}

@end
