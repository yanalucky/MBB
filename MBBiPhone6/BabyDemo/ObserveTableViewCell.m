//
//  ObserveTableViewCell.m
//  BabyDemo
//
//  Created by 陈彦 on 16/6/24.
//  Copyright © 2016年 elsa. All rights reserved.
//

#import "ObserveTableViewCell.h"

@implementation ObserveTableViewCell{
    UIImageView *_leftView;
    UILabel *_title;
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
    
    
    _leftView = [[UIImageView alloc] init];
    
    _leftView.image = [UIImage imageNamed:@"jilu_point"];
    [self addSubview:_leftView];
    
    
    _title = [[UILabel alloc] init];
    _title.font = [UIFont yaHeiFontOfSize:13*Ratio];
    _title.textColor = MBColor(101, 102, 103, 1);
    _title.numberOfLines = 0;
    [self addSubview:_title];
    
    
}
-(void)makeCellByTitle:(NSString *)title{
    
    
    _title.text = title;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:title];;
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    [paragraphStyle setLineSpacing:6];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, title.length)];
    
    _title.attributedText = attributedString;
    
    
    
    
    
}

-(void)layoutSubviews{
    
    [_leftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(10*Ratio);
        make.size.mas_equalTo(CGSizeMake(5*Ratio, 5*Ratio));
        make.left.equalTo(self).offset(10*Ratio);
    }];
    
    [_title mas_remakeConstraints:^(MASConstraintMaker *make) {
//        make.size.mas_equalTo(CGSizeMake(285*Ratio, 15*Ratio));
        make.width.mas_equalTo(285*Ratio);
        make.bottom.equalTo(self);
        make.top.equalTo(self);
        make.left.equalTo(_leftView.mas_right).offset(7.5*Ratio);
    }];
  
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
