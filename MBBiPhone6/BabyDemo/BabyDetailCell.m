//
//  BabyDetailCell.m
//  BabyDemo
//
//  Created by 陈彦 on 16/5/30.
//  Copyright © 2016年 elsa. All rights reserved.
//

#import "BabyDetailCell.h"

@implementation BabyDetailCell


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(instancetype)init{
    self = [super init];
    if (self) {
        [self makeCell];
        
    }
    return self;
}
-(void)makeCell{
    [self setBackgroundColor:[UIColor whiteColor]];
    
    
    _title = [[UILabel alloc] init];
    _title.font = [UIFont yaHeiFontOfSize:13*Ratio];
    _title.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1];
    [self addSubview:_title];
    
    
    
    
    
    
    
    
}
-(void)makeCellWithTitle:(NSString *)title{
    
    _title.text = title;
    
}


-(void)layoutSubviews{
    
    
    [_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100*Ratio, 17*Ratio));
        make.centerY.equalTo(self);
        make.left.equalTo(self).offset(9*Ratio);
        
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


@end
