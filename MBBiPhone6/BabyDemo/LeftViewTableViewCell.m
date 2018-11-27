//
//  LeftViewTableViewCell.m
//  BabyDemo
//
//  Created by 陈彦 on 16/3/16.
//  Copyright © 2016年 elsa. All rights reserved.
//

#import "LeftViewTableViewCell.h"

@implementation LeftViewTableViewCell{
    UIImageView *leftView;
    UIImageView *rightView;
    UILabel *_title;
}

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
    
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self makeCell];
        
    }
    return self;
}
-(void)makeCell{
    [self setBackgroundColor:[UIColor clearColor]];
    self.backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320*Ratio, 43*Ratio)];
    
    self.backgroundView.backgroundColor = MBColor(255, 255, 255, 1);
    self.selectedBackgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320*Ratio, 43*Ratio)];
    self.selectedBackgroundView.backgroundColor = MBColor(245, 245, 245, 1);
    
    
    leftView = [[UIImageView alloc] init];
    
    [self addSubview:leftView];
    
    
    _title = [[UILabel alloc] init];
    _title.font = [UIFont yaHeiFontOfSize:13*Ratio];
    _title.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1];
    [self addSubview:_title];
    
    
    
    
    rightView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"chouti_ARROW_RIGHT2"]];
    
    [self addSubview:rightView];
    
    
    
    

}
-(void)makeCellByLeftImageName:(NSString *)leftImageName withTitle:(NSString *)title{
    leftView.image = [UIImage imageNamed:leftImageName];
    
    
    _title.text = title;
    
}


-(void)layoutSubviews{
    [leftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(21*Ratio, 21*Ratio));
        make.left.equalTo(self).offset(13*Ratio);
    }];
    
    [_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100*Ratio, 20*Ratio));
        make.centerY.equalTo(self);
        make.left.equalTo(leftView.mas_right).offset(17*Ratio);
        
    }];
    
    [rightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(9*Ratio, 15*Ratio));
        make.centerY.equalTo(self);
        make.right.equalTo(self).offset(-15*Ratio);
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
