//
//  YLZYTableViewCell.m
//  MBB1
//
//  Created by 陈彦 on 15/9/14.
//  Copyright (c) 2015年 elsa. All rights reserved.
//

#import "YLZYTableViewCell.h"
#import "UIImageView+WebCache.h"

@implementation YLZYTableViewCell{
    
    
    UIImageView *_leftView;
    UILabel *_title;
    UILabel *_detailTitle;
    UILabel *_colorTitle;
    
    
    UILabel *_goodAtLabe;
    //    UIButton *_rightBtn;
    
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
    self.backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320*Ratio, 72*Ratio)];
    self.backgroundView.backgroundColor = MBColor(255, 255, 255, 1);
    
    
    
    _leftView = [[UIImageView alloc] init];
    _leftView.layer.masksToBounds = YES;
    _leftView.layer.cornerRadius = 22.5*Ratio;
    _leftView.layer.borderWidth = 1;
    _leftView.layer.borderColor = MBColor(149, 243, 235, 1).CGColor;
    
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
    
    
}
-(void)makeCellByLeftImageName:(NSString *)leftImageName withTitle:(NSString *)title withDetailTitle:(NSString *)detailTitle withColorTitle:(NSString *)clrStr withGoodAtTitle:(NSString *)goodAtTitle{
    
    _leftView.image = [UIImage imageNamed:@"chouti_01"];
    if (leftImageName.length > 0) {
        [_leftView sd_setImageWithURL:[NSURL URLWithString:[NSString urlStringOfImage:leftImageName]] placeholderImage:[UIImage imageNamed:@"chouti_01"]];
        
    }
    _title.text = title;
    
    _detailTitle.text = detailTitle;
    
    _colorTitle.text = clrStr;
    
    _goodAtLabe.text = goodAtTitle;
    
    
}

-(void)layoutSubviews{
    [_leftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(11*Ratio);
        make.size.mas_equalTo(CGSizeMake(45*Ratio, 45*Ratio));
        make.left.equalTo(self).offset(13*Ratio);
    }];
    
    [_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(57*Ratio, 15*Ratio));
        make.top.equalTo(self).offset(11*Ratio);
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
        make.right.equalTo(self).offset(-10*Ratio);
        
        
    }];
    
    [_goodAtLabe mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_title);
        make.right.equalTo(self).offset(-20*Ratio);
        make.top.equalTo(_detailTitle.mas_bottom).offset(3*Ratio);
        make.bottom.equalTo(self).offset(-10*Ratio);
    }];
    
    
    [lineLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(0.5);
        make.left.equalTo(_title);
        make.right.equalTo(_colorTitle);
        make.top.equalTo(_title.mas_bottom).offset(4*Ratio);
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
