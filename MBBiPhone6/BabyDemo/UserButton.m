//
//  UserButton.m
//  BabyDemo
//
//  Created by 陈彦 on 16/5/16.
//  Copyright © 2016年 elsa. All rights reserved.
//

#import "UserButton.h"
#define TEXTCOLOR MBColor(100, 100, 100, 1)

@implementation UserButton{
    UILabel *_titleLabel;
    UIImageView *_leftView;
    UIImageView *_rightView;
}
-(instancetype)init{
    
    if (self = [super init]) {
        [self createView];
    }
    return self;
}
+(instancetype)buttonWithType:(UIButtonType)buttonType{
    
    UserButton *button = [super buttonWithType:buttonType];
    if (button) {
        button.backgroundColor = [UIColor whiteColor];
        [button createView];
    }
    return button;
}
-(void)createView{
    
    _titleLabel = [[UILabel alloc] init];
    [_titleLabel makeLabelWithText:nil andTextColor:TEXTCOLOR andFont:[UIFont yaHeiFontOfSize:13*Ratio]];
    [self addSubview:_titleLabel];
    
    _leftView = [[UIImageView alloc] init];
    [self addSubview:_leftView];
    
    _rightView = [[UIImageView alloc] init];
    _rightView.image = [UIImage imageNamed:@"chouti_ARROW_RIGHT2"];
    [self addSubview:_rightView];
   
    
    
    
    
}
-(void)makeViewWithTitle:(NSString *)title andLeftImageName:(NSString *)leftImage{
    
    _titleLabel.text = title;
    
    _leftView.image = [UIImage imageNamed:leftImage];
}


-(void)layoutSubviews{
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(41*Ratio);
        make.centerY.equalTo(self);
        make.height.equalTo(self);
        make.width.mas_equalTo(140*Ratio);
    }];
    [_leftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self).offset(15*Ratio);
        make.size.mas_equalTo(CGSizeMake(16*Ratio, 16*Ratio));
    }];
    [_rightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.equalTo(self).offset(-10*Ratio);
        make.size.mas_equalTo(CGSizeMake(10*Ratio, 16*Ratio));
    }];
    
   
    
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
