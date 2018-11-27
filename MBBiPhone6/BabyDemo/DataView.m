//
//  DataView.m
//  BabyDemo
//
//  Created by 陈彦 on 16/4/6.
//  Copyright © 2016年 elsa. All rights reserved.
//

#import "DataView.h"
#define TEXTCOLOR MBColor(101, 102, 103, 1)
@implementation DataView{
    UILabel *_titleLabel;
    UILabel *_unitLabel;
}

-(instancetype)init{
    
    if (self = [super init]) {
        [self createView];
    }
    return self;
}
-(void)createView{
    _titleLabel = [[UILabel alloc] init];
    [_titleLabel makeLabelWithText:nil andTextColor:TEXTCOLOR andFont:[UIFont yaHeiFontOfSize:12*Ratio]];
    [self addSubview:_titleLabel];
    
    _button = [UIButton buttonWithType:UIButtonTypeCustom];
    [_button setBackgroundImage:[UIImage imageNamed:@"jilu_kuang"] forState:UIControlStateNormal];
    [_button setBackgroundImage:[UIImage imageNamed:@"jilu_kuang_none"] forState:UIControlStateDisabled];
    
    [_button setBackgroundImage:[UIImage imageNamed:@"jilu_kuang_set"] forState:UIControlStateSelected];
    [_button setTitleColor:TEXTCOLOR forState:UIControlStateNormal];
    [_button setTitleColor:TEXTCOLOR forState:UIControlStateSelected];
    _button.titleLabel.font = [UIFont yaHeiFontOfSize:12*Ratio];
    [self addSubview:_button];
    
    
    _unitLabel = [[UILabel alloc] init];
    [_unitLabel makeLabelWithText:@"cm" andTextColor:MBColor(253, 167, 199, 1) andFont:[UIFont yaHeiFontOfSize:12*Ratio]];
    [self addSubview:_unitLabel];
    
    
}
-(void)makeViewWithTitle:(NSString *)title andUnit:(NSString *)unit andNumberData:(NSString *)number{
    
    _titleLabel.text = title;
    _unitLabel.text = unit;
    [_button setTitle:number forState:UIControlStateNormal];
    CGSize size = [_titleLabel sizeThatFits:CGSizeMake(90, 15)];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(size.width));
    }];
    
}


-(void)layoutSubviews{
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.centerY.equalTo(self);
        make.height.equalTo(self);
    }];
    
    [_unitLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self);
        make.centerY.equalTo(self);
        make.height.equalTo(self);
        make.width.equalTo(@(34*Ratio));
    }];
    
    [_button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_unitLabel.mas_left).offset(-5*Ratio);
        make.centerY.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(50*Ratio, 25*Ratio));
//        make.width.mas_equalTo(@(50*Ratio));
//        make.height.mas_equalTo(self);
    }];
    
    
}
@end
