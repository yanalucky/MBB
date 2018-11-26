//
//  Fcgo_RealNameTableCell.m
//  Fcgo
//
//  Created by huafanxiao on 2017/6/8.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_RealNameTableCell.h"
#import "Fcgo_AdressButton.h"

@interface Fcgo_RealNameTableCell ()

@property (weak, nonatomic) IBOutlet UIImageView *customerImageView;
@property (weak, nonatomic) IBOutlet UILabel     *customerNameLabel;

@property (weak, nonatomic) IBOutlet UIImageView *cardImageView;
@property (weak, nonatomic) IBOutlet UILabel     *cardLabel;

@property (weak, nonatomic) IBOutlet UIImageView *mainCardImageView;
@property (weak, nonatomic) IBOutlet UIImageView *backCardImageView;

@property (weak, nonatomic) IBOutlet UIView      *middleLineView;

@property (weak, nonatomic) IBOutlet UILabel     *defultLabel;
@property (weak, nonatomic) IBOutlet Fcgo_AdressButton *editBtn;
@property (weak, nonatomic) IBOutlet Fcgo_AdressButton *deleteBtn;
@property (strong, nonatomic) IBOutlet UIView *bottomLineView;

@end

@implementation Fcgo_RealNameTableCell

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
        make.top.mas_offset(12);
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

    [self.mainCardImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(15);
        make.top.mas_equalTo(weakSelf.cardImageView.mas_bottom).mas_offset(10);
        make.height.mas_offset(100/1.6);
        make.width.mas_offset(100);
    }];
    
    [self.backCardImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.mainCardImageView.mas_right).mas_offset(10);
        make.top.mas_equalTo(weakSelf.cardLabel.mas_bottom).mas_offset(10);
        make.height.mas_offset(100/1.6);
        make.width.mas_offset(100);
    }];
    
    [self.middleLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_offset(0);
        make.top.mas_equalTo(weakSelf.mainCardImageView.mas_bottom).mas_offset(10);
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

- (IBAction)setDefultAddress:(Fcgo_IndexButton *)sender {
    if (sender.select == YES) {
        return;
    }
    if (self.defaultBlock) {
        self.defaultBlock(self.model);
    }
    
}
- (IBAction)edit:(Fcgo_AdressButton *)sender {
    if (self.editBlock) {
        self.editBlock(self.model);
    }
}
- (IBAction)delete:(Fcgo_AdressButton *)sender {
    if (self.deleteBlock) {
        self.deleteBlock(self.model);
    }
}

- (void)setModel:(Fcgo_RealNameModel *)model
{
    _model = model;
    
    self.customerNameLabel.text = model.mchRealName;
    NSString *string = model.mchIdcard;
    if(string.length>10)
    {
       self.cardLabel.text = [NSString stringWithFormat:@"%@***********%@",[string substringWithRange:NSMakeRange(0, 3)],[string substringWithRange:NSMakeRange(string.length-4, 4)]];
    }
    [self.mainCardImageView sd_setImageWithURL:[NSURL URLWithString:model.mchPicurlW]placeholderImage:[UIImage imageNamed:@"756X300(分类）"]];
    [self.backCardImageView sd_setImageWithURL:[NSURL URLWithString:model.mchPicurlB]placeholderImage:[UIImage imageNamed:@"756X300(分类）"]];

    if (model.f_default.intValue == 0) {
        self.defultBtn.select = NO;
        [self.defultBtn setBackgroundImage:[UIImage imageNamed:@"select_off"] forState:UIControlStateNormal];
    }
    else
    {
        self.defultBtn.select = YES;
        [self.defultBtn setBackgroundImage:[UIImage imageNamed:@"select_on"] forState:UIControlStateNormal];
    }
}

@end

