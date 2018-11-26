//
//  Fcgo_OrderConfirmNoneImageRealNameTableCell.m
//  Fcgo
//
//  Created by huafanxiao on 2017/7/17.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_OrderConfirmNoneImageRealNameTableCell.h"

@interface Fcgo_OrderConfirmNoneImageRealNameTableCell ()

@property (weak, nonatomic) IBOutlet UIImageView *customerImageView;
@property (weak, nonatomic) IBOutlet UILabel     *customerNameLabel;

@property (weak, nonatomic) IBOutlet UIImageView *cardImageView;
@property (weak, nonatomic) IBOutlet UILabel     *cardLabel;

@property (strong, nonatomic) IBOutlet UIView *bottomLineView;

@end

@implementation Fcgo_OrderConfirmNoneImageRealNameTableCell

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
    self.cardLabel.text = [NSString stringWithFormat:@"%@***********%@",[string substringWithRange:NSMakeRange(0, 3)],[string substringWithRange:NSMakeRange(string.length-4, 4)]];
    
}

@end



