//
//  DoctorTableViewCell.m
//  BabyDemo
//
//  Created by 陈彦 on 16/5/6.
//  Copyright © 2016年 elsa. All rights reserved.
//

#import "DoctorTableViewCell.h"
#import "UIImageView+WebCache.h"

@implementation DoctorTableViewCell{
    UIImageView *_leftView;
    UILabel *_title;
    UILabel *_detailTitle;
    UILabel *_colorTitle;
//    UIButton *_rightBtn;
    bool _isSelected;
   
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
    [self setBackgroundColor:[UIColor clearColor]];
    self.backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320*Ratio, 74*Ratio)];
    
    self.backgroundView.backgroundColor = MBColor(255, 255, 255, 1);
    self.selectedBackgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320*Ratio, 74*Ratio)];
    self.selectedBackgroundView.backgroundColor = MBColor(245, 245, 245, 1);
    
    
    _leftView = [[UIImageView alloc] init];
    _leftView.layer.masksToBounds = YES;
    _leftView.layer.cornerRadius = 22*Ratio;
    _leftView.layer.borderWidth = 1;
    _leftView.layer.borderColor = MBColor(245, 215, 216, 1).CGColor;
    
    [self addSubview:_leftView];
    
    
    _title = [[UILabel alloc] init];
    _title.font = [UIFont yaHeiFontOfSize:12*Ratio];
    _title.textColor = MBColor(51, 51, 51, 1);
    [self addSubview:_title];
    
    _detailTitle = [[UILabel alloc] init];
    _detailTitle.font = [UIFont yaHeiFontOfSize:11*Ratio];
    _detailTitle.textColor = MBColor(102, 102, 102, 1);
    [self addSubview:_detailTitle];
    
    _colorTitle = [[UILabel alloc] init];
    _colorTitle.font = [UIFont yaHeiFontOfSize:11*Ratio];
    _colorTitle.textColor = MBColor(250, 109, 166, 1);
    [self addSubview:_colorTitle];
    
    _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _rightBtn.layer.masksToBounds = YES;
    _rightBtn.layer.cornerRadius = 12.5*Ratio;
    _rightBtn.layer.borderColor = MBColor(250, 109, 166, 1).CGColor;
    _rightBtn.layer.borderWidth = 1;
//    [_rightBtn setTitle:@"选我" forState:UIControlStateNormal];
    [_rightBtn setBackgroundImage:[UIImage imageNamed:@"buy_selectdoctor_set"] forState:UIControlStateSelected];
    [_rightBtn setBackgroundImage:[UIImage imageNamed:@"buy_selectdoctor"] forState:UIControlStateNormal];
//    [_rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
//    [_rightBtn setTitleColor:MBColor(250, 109, 166, 1) forState:UIControlStateNormal];
    [self addSubview:_rightBtn];
}
-(void)makeCellByLeftImageName:(NSString *)leftImageName withTitle:(NSString *)title withDetailTitle:(NSString *)detailTitle withColorTitle:(NSString *)clrStr withIsSel:(BOOL)isSel{
    
    _leftView.image = [UIImage imageNamed:@"chouti_01"];
    if (leftImageName.length > 0) {
        [_leftView sd_setImageWithURL:[NSURL URLWithString:[NSString urlStringOfImage:leftImageName]] placeholderImage:[UIImage imageNamed:@"chouti_01"]];

    }
    _title.text = title;
    
    _detailTitle.text = detailTitle;
    
    _colorTitle.text = clrStr;
    
    _rightBtn.selected = isSel;
    
}

-(void)layoutSubviews{
    [_leftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(45*Ratio, 45*Ratio));
        make.left.equalTo(self).offset(11*Ratio);
    }];
    
    [_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(160*Ratio, 18*Ratio));
        make.top.equalTo(self).offset(9*Ratio);
        make.left.equalTo(_leftView.mas_right).offset(10*Ratio);
        
    }];
    [_detailTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(160*Ratio, 17*Ratio));
        make.top.equalTo(_title.mas_bottom).offset(7*Ratio);
        make.left.equalTo(_leftView.mas_right).offset(10*Ratio);
    }];
    [_colorTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(160*Ratio, 17*Ratio));
        make.top.equalTo(_detailTitle.mas_bottom).offset(7*Ratio);
        make.left.equalTo(_leftView.mas_right).offset(10*Ratio);
    }];
    [_rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(60*Ratio, 27*Ratio));
        make.centerY.equalTo(self);
        make.right.equalTo(self).offset(-12.5*Ratio);
    }];
}

- (void)drawRect:(CGRect)rect {
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor);
    CGContextFillRect(context, rect);
    //上分割线，
    //    CGContextSetStrokeColorWithColor(context, [UIColor magentaColor].CGColor); CGContextStrokeRect(context, CGRectMake(5, -1, rect.size.width - 10, 1));
    //下分割线
    CGContextSetStrokeColorWithColor(context, [UIColor colorWithRed:253/255.0 green:236/255.0 blue:246/255.0 alpha:1].CGColor);
    CGContextStrokeRect(context, CGRectMake(10*Ratio, rect.size.height, rect.size.width - (20*Ratio), 1*Ratio));
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
