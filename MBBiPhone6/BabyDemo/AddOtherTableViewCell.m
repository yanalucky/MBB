//
//  AddOtherTableViewCell.m
//  BabyDemo
//
//  Created by 陈彦 on 16/4/26.
//  Copyright © 2016年 elsa. All rights reserved.
//

#import "AddOtherTableViewCell.h"



@implementation AddOtherTableViewCell{
    UILabel *_monthLab;
    


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
    
    _monthLab = [[UILabel alloc] init];
    [_monthLab makeLabelWithText:nil andTextColor:[UIColor grayColor] andFont:[UIFont yaHeiFontOfSize:15*Ratio]];
    
    [self addSubview:_monthLab];
    
    _field0 = [[UITextField alloc] init];
    _field0.layer.masksToBounds = YES;
    _field0.layer.cornerRadius = 12.25*Ratio;
    _field0.layer.borderWidth = 1;
    _field0.layer.borderColor = MBColor(203, 204, 205, 1).CGColor;
    [_field0 setTextColor:[UIColor grayColor]];
    _field0.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    _field0.text = nil;
    [_field0 setLeftViewOfBlankforWidth:15*Ratio];
    [self addSubview:_field0];
    
    _field1 = [[UITextField alloc] init];
    _field1.layer.masksToBounds = YES;
    _field1.layer.cornerRadius = 12.25*Ratio;
    _field1.layer.borderWidth = 1;
    _field1.layer.borderColor = MBColor(203, 204, 205, 1).CGColor;
    [_field1 setTextColor:[UIColor grayColor]];
    _field1.text = nil;
    _field1.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    [_field1 setLeftViewOfBlankforWidth:15*Ratio];
    [self addSubview:_field1];
    
}
-(void)makeCellByMonth:(NSString *)monthStr{
    
    _monthLab.text = monthStr;
}


-(void)layoutSubviews{
    [_monthLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(21*Ratio, 21*Ratio));
        make.left.equalTo(self).offset(50*Ratio);
    }];
    
    [_field0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(59*Ratio, 24.5*Ratio));
        make.centerY.equalTo(self);
        make.left.equalTo(_monthLab.mas_right).offset(65*Ratio);
        
    }];
    
    [_field1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(59*Ratio, 24.5*Ratio));
        make.centerY.equalTo(self);
        make.right.equalTo(self).offset(-21*Ratio);
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
