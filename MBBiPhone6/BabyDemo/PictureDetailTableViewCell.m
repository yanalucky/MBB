//
//  PictureDetailTableViewCell.m
//  BabyDemo
//
//  Created by 陈彦 on 16/5/20.
//  Copyright © 2016年 elsa. All rights reserved.
//

#import "PictureDetailTableViewCell.h"

@implementation PictureDetailTableViewCell{
    UILabel *_date;
    UILabel *_data;
    UILabel *_babyAge;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self makeCell];
        
    }
    return self;
}
-(void)makeCell{
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    _date = [[UILabel alloc] init];
    [_date makeLabelWithText:nil andTextColor:MBColor(102, 102, 102, 1) andFont:[UIFont yaHeiFontOfSize:13*Ratio]];
    _date.textAlignment = NSTextAlignmentCenter;

    [self addSubview:_date];
    
   
    _babyAge = [[UILabel alloc] init];
    [_babyAge makeLabelWithText:nil andTextColor:MBColor(102, 102, 102, 1) andFont:[UIFont yaHeiFontOfSize:13*Ratio]];
    _babyAge.textAlignment = NSTextAlignmentCenter;
    
    _babyAge.numberOfLines = 0;
    [self addSubview:_babyAge];
    _data = [[UILabel alloc] init];
    [_data makeLabelWithText:nil andTextColor:MBColor(102, 102, 102, 1) andFont:[UIFont yaHeiFontOfSize:13*Ratio]];
    _data.textAlignment = NSTextAlignmentCenter;
    
    [self addSubview:_data];
    
    
    
}
-(void)makeCellWithDate:(NSString *)date andBabyAge:(NSString *)age andData:(NSString *)data{
    _date.text = date;
    _babyAge.text = age;
    _data.text = data;
}


-(void)layoutSubviews{
    [_date mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.width.mas_equalTo((_isForth == NO)?(75*Ratio):(75*Ratio));
        make.height.equalTo(self);
        make.left.equalTo(self).offset((_isForth == NO)?(12.5*Ratio):(5*Ratio));
    }];
    
    [_babyAge mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(self);
        make.centerY.equalTo(self);
        make.left.equalTo(_date.mas_right);
        make.right.equalTo(self).offset((_isForth == NO)?(-74*Ratio):(-10*Ratio));
    }];
    
    [_data mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(70*Ratio);
        make.height.equalTo(self);
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
