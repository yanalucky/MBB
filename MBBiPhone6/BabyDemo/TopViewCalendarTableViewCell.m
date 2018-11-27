//
//  TopViewCalendarTableViewCell.m
//  BabyDemo
//
//  Created by 陈彦 on 16/3/22.
//  Copyright © 2016年 elsa. All rights reserved.
//

#import "TopViewCalendarTableViewCell.h"

@implementation TopViewCalendarTableViewCell{
    UIImageView *_leftView;
    UIImageView *_rightView;
    UILabel *_title;
    UILabel *_detailTitle;
}


- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
    
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
    self.backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320*Ratio, 44*Ratio)];
    
    self.backgroundView.backgroundColor = MBColor(255, 255, 255, 1);
    self.selectedBackgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320*Ratio, 44*Ratio)];
    self.selectedBackgroundView.backgroundColor = MBColor(245, 245, 245, 1);
    
    
    _leftView = [[UIImageView alloc] init];
    
    [self addSubview:_leftView];
    
    
    _title = [[UILabel alloc] init];
    _title.font = [UIFont yaHeiFontOfSize:12*Ratio];
    _title.textColor = MBColor(51, 51, 51, 1);
    [self addSubview:_title];
    
    _detailTitle = [[UILabel alloc] init];
    _detailTitle.font = [UIFont yaHeiFontOfSize:11*Ratio];
    _detailTitle.textColor = MBColor(102, 102, 102, 1);
    [self addSubview:_detailTitle];
    
    
    _rightView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"chouti_ARROW_RIGHT2"]];
    
    [self addSubview:_rightView];
}
-(void)makeCellByLeftImageName:(NSString *)leftImageName withTitle:(NSString *)title withDetailTitle:(NSString *)detailTitle withIsRight:(BOOL)isRight{
    _leftView.image = [UIImage imageNamed:leftImageName];
    
    
    _title.text = title;
    
   
    _detailTitle.text = detailTitle;
    
    
    _rightView.hidden = !isRight;
}

-(void)layoutSubviews{
    [_leftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(35*Ratio, 35*Ratio));
        make.left.equalTo(self).offset(13*Ratio);
    }];
    
    [_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(250*Ratio, 15*Ratio));
        make.centerY.equalTo(self);
        make.left.equalTo(_leftView.mas_right).offset(10*Ratio);
        
    }];
    [_detailTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_title);
        make.top.equalTo(_title.mas_bottom);
        make.height.equalTo(_title);
        make.width.mas_equalTo(@100);
    }];
    
    [_rightView mas_makeConstraints:^(MASConstraintMaker *make) {
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
    CGContextSetStrokeColorWithColor(context, [UIColor colorWithRed:253/255.0 green:236/255.0 blue:246/255.0 alpha:1].CGColor); CGContextStrokeRect(context, CGRectMake(10*Ratio, rect.size.height, rect.size.width - (20*Ratio), 1*Ratio));
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
