//
//  BuyDoctorTableViewCell.m
//  BabyDemo
//
//  Created by 陈彦 on 16/7/12.
//  Copyright © 2016年 elsa. All rights reserved.
//

#import "BuyDoctorTableViewCell.h"
#import "UIImageView+WebCache.h"

@implementation BuyDoctorTableViewCell{
    
    
    UIImageView *_leftView;
    UILabel *_title;
    UILabel *_detailTitle;
    UILabel *_colorTitle;
    
    
    UILabel *_goodAtLabe;
    //    UIButton *_rightBtn;
    bool _isSelected;
    
    UILabel *lineLab;
    
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self remakeCell];
    }
    return self;
}
-(void)remakeCell{
    
    [self setBackgroundColor:MBColor(225, 253, 255, 1)];
    self.backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320*Ratio, 90*Ratio)];
    self.backgroundView.backgroundColor = MBColor(255, 255, 255, 1);
    
    
    
    _leftView = [[UIImageView alloc] init];
    _leftView.layer.masksToBounds = YES;
    _leftView.layer.cornerRadius = 22.5*Ratio;
    _leftView.layer.borderWidth = 1;
    _leftView.layer.borderColor = MBColor(245, 215, 216, 1).CGColor;
    
    [self addSubview:_leftView];
    
    
    _title = [[UILabel alloc] init];
    _title.font = [UIFont yaHeiFontOfSize:14*Ratio];
    _title.textColor = MBColor(51, 51, 51, 1);
    [self addSubview:_title];
    
    _detailTitle = [[UILabel alloc] init];
    _detailTitle.font = [UIFont yaHeiFontOfSize:11*Ratio];
    _detailTitle.textColor = MBColor(102, 102, 102, 1);
    [self addSubview:_detailTitle];
    
    _goodAtLabe = [[UILabel alloc] init];
    _goodAtLabe.font = [UIFont yaHeiFontOfSize:11*Ratio];
    _goodAtLabe.textColor = MBColor(102, 102, 102, 1);
    _goodAtLabe.numberOfLines = 0;
    [self addSubview:_goodAtLabe];
    
    
    lineLab = [[UILabel alloc] init];
    lineLab.backgroundColor = MBColor(252, 236, 246, 1);
    [self addSubview:lineLab];
    
    
    _colorTitle = [[UILabel alloc] init];
    _colorTitle.font = [UIFont yaHeiFontOfSize:11*Ratio];
    _colorTitle.textColor = MBColor(250, 109, 166, 1);
    _colorTitle.textAlignment = NSTextAlignmentLeft;
    [self addSubview:_colorTitle];
    
    _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _rightBtn.layer.masksToBounds = YES;
    _rightBtn.layer.cornerRadius = 11*Ratio;
    _rightBtn.layer.borderColor = MBColor(250, 109, 166, 1).CGColor;
    _rightBtn.layer.borderWidth = 1;
    [_rightBtn setBackgroundImage:[UIImage imageNamed:@"buy_selectdoctor_set"] forState:UIControlStateSelected];
    [_rightBtn setBackgroundImage:[UIImage imageNamed:@"buy_selectdoctor"] forState:UIControlStateNormal];
    
    [self addSubview:_rightBtn];
}
-(void)makeCellByLeftImageName:(NSString *)leftImageName withTitle:(NSString *)title withDetailTitle:(NSString *)detailTitle withColorTitle:(NSString *)clrStr withGoodAtTitle:(NSString *)goodAtTitle withIsSel:(BOOL)isSel{
    
    _leftView.image = [UIImage imageNamed:@"chouti_01"];
    if (leftImageName.length > 0) {
        [_leftView sd_setImageWithURL:[NSURL URLWithString:[NSString urlStringOfImage:leftImageName]] placeholderImage:[UIImage imageNamed:@"chouti_01"]];
        
    }
    _title.text = title;
    
    _detailTitle.text = detailTitle;
    
    _colorTitle.text = clrStr;
    
    _goodAtLabe.text = goodAtTitle;
    
    _rightBtn.selected = isSel;
    
}

-(void)layoutSubviews{
    [_leftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(15*Ratio);
        make.size.mas_equalTo(CGSizeMake(45*Ratio, 45*Ratio));
        make.left.equalTo(self).offset(13*Ratio);
    }];
    
    [_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(57*Ratio, 15*Ratio));
        make.top.equalTo(self).offset(15*Ratio);
        make.left.equalTo(_leftView.mas_right).offset(10*Ratio);
        
    }];
    [_detailTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(160*Ratio, 15*Ratio));
        make.top.equalTo(_title.mas_bottom).offset(8*Ratio);
        make.left.equalTo(_title);
    }];
    [_colorTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(70*Ratio, 15*Ratio));
        make.centerY.equalTo(_title);
        make.left.equalTo(_title.mas_right).offset(8*Ratio);
        
        
    }];
    
    [_goodAtLabe mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_title);
        make.right.equalTo(self).offset(-20*Ratio);
        make.top.equalTo(_detailTitle.mas_bottom).offset(3*Ratio);
        make.bottom.equalTo(self).offset(-10*Ratio);
    }];
    [_rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(55*Ratio, 22*Ratio));
        make.centerY.equalTo(_title);
        make.right.equalTo(_goodAtLabe);
    }];
    
    
    [lineLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(0.5);
        make.left.equalTo(_title);
        make.right.equalTo(_rightBtn).offset(10*Ratio);
        make.top.equalTo(_title.mas_bottom).offset(4*Ratio);
    }];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
