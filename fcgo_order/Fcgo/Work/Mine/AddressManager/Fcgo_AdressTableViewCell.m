//
//  Fcgo_AdressTableViewCell.m
//  Fcgo
//
//  Created by huafanxiao on 2017/6/8.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_AdressTableViewCell.h"
#import "Fcgo_AdressButton.h"

@interface Fcgo_AdressTableViewCell ()


@property (weak, nonatomic) IBOutlet UIImageView *customerImageView;
@property (weak, nonatomic) IBOutlet UILabel     *customerNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *customerTelImageView;
@property (weak, nonatomic) IBOutlet UILabel     *customerTelLabel;
@property (weak, nonatomic) IBOutlet UILabel *busAdressLabel;



@property (weak, nonatomic) IBOutlet UIImageView *adressImageView;

@property (weak, nonatomic) IBOutlet UILabel    *adressLabel;

@property (weak, nonatomic) IBOutlet UIView      *middleLineView;

@property (weak, nonatomic) IBOutlet UILabel     *defultLabel;
@property (weak, nonatomic) IBOutlet Fcgo_AdressButton    *editBtn;
@property (weak, nonatomic) IBOutlet Fcgo_AdressButton    *deleteBtn;
@property (strong, nonatomic) IBOutlet UIView *bottomLineView;

@end

@implementation Fcgo_AdressTableViewCell

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
    
    [self.customerTelImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(16);
        make.left.mas_equalTo(weakSelf.customerNameLabel.mas_right).mas_offset(10);
        make.height.width.mas_offset(18);
    }];
    
    [self.customerTelLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.customerTelImageView.mas_right).mas_offset(10);
        make.bottom.mas_equalTo(weakSelf.customerTelImageView.mas_bottom);
    }];
    
    self.customerTelLabel.textColor = UIFontMainGrayColor;
    
    [self.busAdressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-15);
        make.centerY.mas_equalTo(weakSelf.customerTelImageView.mas_centerY);
        make.width.mas_offset(50);
        make.height.mas_offset(18);
    }];
    self.busAdressLabel.textColor = UIFontWhiteColor;
    self.busAdressLabel.backgroundColor = UIFontRedColor;
    self.busAdressLabel.font = UIFontSize(11);
    self.busAdressLabel.layer.cornerRadius = 3;
    self.busAdressLabel.layer.masksToBounds = 1;
    self.busAdressLabel.hidden = 1;
    
    [self.adressImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(15);
        make.top.mas_equalTo(weakSelf.customerImageView.mas_bottom).mas_offset(18);
        make.height.width.mas_offset(18);
    }];
    [self.adressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.customerNameLabel.mas_left);
        make.centerY.mas_equalTo(weakSelf.adressImageView);
        make.right.mas_offset(-15);
    }];
    
    self.adressLabel.textColor = UIFontMainGrayColor;
    self.customerTelLabel.textColor = UIFontMainGrayColor;
    self.adressLabel.textColor = UIFontMainGrayColor;
    
    [self.middleLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_offset(0);
        make.top.mas_equalTo(weakSelf.adressImageView.mas_bottom).mas_offset(20);
        make.height.mas_offset(0.5);
    }];
    self.middleLineView.backgroundColor = UISepratorLineColor;
    
    
    [self.defultBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_offset(30);
        make.top.mas_equalTo(weakSelf.middleLineView.mas_bottom).mas_offset(5);
        make.left.mas_offset(8);
    }];
    
    [self.defultLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.defultBtn.mas_right).mas_offset(5);
        make.centerY.mas_equalTo(weakSelf.defultBtn.mas_centerY);
    }];
    self.defultLabel.textColor = UIFontRedColor;
    
    
    [self.deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_offset(28);
        make.width.mas_offset(55);
        make.centerY.mas_equalTo(weakSelf.defultBtn.mas_centerY);
        make.right.mas_offset(-15);
    }];
    
    [self.deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
    [self.deleteBtn setImage:[UIImage imageNamed:@"delete_adress"] forState:UIControlStateNormal];
    //self.editBtn.imageEdgeInsets = UIEdgeInsetsMake(5, 8, 5, 8);
    [self.deleteBtn setTitleColor:UIFontMainGrayColor forState:UIControlStateNormal];
    self.deleteBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    
    
    [self.editBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_offset(28);
        make.width.mas_offset(55);
        make.centerY.mas_equalTo(weakSelf.defultBtn.mas_centerY);
        make.right.mas_equalTo(weakSelf.deleteBtn.mas_left).mas_offset(-12);
    }];
    
    [self.editBtn setTitle:@"编辑" forState:UIControlStateNormal];
    [self.editBtn setImage:[UIImage imageNamed:@"edit_adress"] forState:UIControlStateNormal];
    //self.editBtn.imageEdgeInsets = UIEdgeInsetsMake(5, 8, 5, 8);
    [self.editBtn setTitleColor:UIFontMainGrayColor forState:UIControlStateNormal];
    self.editBtn.titleLabel.font = [UIFont systemFontOfSize:14];

    self.bottomLineView.backgroundColor = UIBackGroundColor;
    [self.bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_offset(0);
        make.height.mas_offset(5);
    }];
}

- (void)setModel:(Fcgo_AddressModel *)model
{
    _model = model;
    self.customerNameLabel.text = model.consigee;
    self.customerTelLabel.text = model.consigeePhone;
    self.adressLabel.text = [NSString stringWithFormat:@"%@%@",model.addressFormal,model.addressDetail];
    if (model.deFault.intValue == 0) {
        self.defultBtn.select = NO;
       [self.defultBtn setBackgroundImage:[UIImage imageNamed:@"select_off"] forState:UIControlStateNormal];
    }
    else
    {
        self.defultBtn.select = YES;
         [self.defultBtn setBackgroundImage:[UIImage imageNamed:@"select_on"] forState:UIControlStateNormal];
    }
    
    if (model.merchantDefault.intValue == 1) {
        self.editBtn.hidden = 1;
        self.deleteBtn.hidden = 1;
        self.busAdressLabel.hidden = 0;
    }else{
        self.editBtn.hidden = 0;
        self.deleteBtn.hidden = 0;
        self.busAdressLabel.hidden = 1;
    }
    
    
}

- (IBAction)setDefultAddress:(Fcgo_IndexButton *)sender
{
    if (sender.select == YES) {
        return;
    }
    if (self.defaultBlock) {
        self.defaultBlock(self.model);
    }
    
}

- (IBAction)edit:(Fcgo_AdressButton *)sender
{
    if (self.editBlock) {
        self.editBlock(self.model);
    }
}
- (IBAction)delete:(Fcgo_AdressButton *)sender
{
    if (self.deleteBlock) {
        self.deleteBlock(self.model);
    }
}

@end


