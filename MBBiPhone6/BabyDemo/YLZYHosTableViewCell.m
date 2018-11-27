//
//  YLZYHosTableViewCell.m
//  BabyDemo
//
//  Created by 曹露 on 16/9/9.
//  Copyright © 2016年 elsa. All rights reserved.
//

#import "YLZYHosTableViewCell.h"
#import "UIImageView+WebCache.h"

@implementation YLZYHosTableViewCell{
    
    
    UIImageView *_leftView;
    UILabel *_title;
    UILabel *_detailTitle;
    
    
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
    self.backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320*Ratio, 65*Ratio)];
    self.backgroundView.backgroundColor = MBColor(255, 255, 255, 1);
    
    
    
    _leftView = [[UIImageView alloc] init];
    _leftView.layer.masksToBounds = YES;
    _leftView.layer.cornerRadius = 22.5*Ratio;
    _leftView.layer.borderWidth = 1;
    _leftView.layer.borderColor = MBColor(149, 243, 235, 1).CGColor;
    _leftView.image = [UIImage imageNamed:@"chouti_01"];
    [self addSubview:_leftView];
    
    
    _title = [[UILabel alloc] init];
    _title.font = [UIFont yaHeiFontOfSize:14*Ratio];
    _title.textColor = MBColor(51, 51, 51, 1);
    [self addSubview:_title];
    
    _detailTitle = [[UILabel alloc] init];
    _detailTitle.font = [UIFont yaHeiFontOfSize:11*Ratio];
    _detailTitle.textColor = MBColor(102, 102, 102, 1);
    [self addSubview:_detailTitle];
    
    
}
-(void)makeCellByLeftImageName:(NSString *)leftImageName withTitle:(NSString *)title withDetailTitle:(NSString *)detailTitle{
    
    [_leftView sd_setImageWithURL:[NSURL URLWithString:[NSString urlStringOfImage:leftImageName]] placeholderImage:[UIImage imageNamed:@"tubiao.jpg"]];
    
    
    _title.text = title;
    
    _detailTitle.text = detailTitle;
    
    
}

-(void)layoutSubviews{
    
    [_leftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(11*Ratio);
        make.size.mas_equalTo(CGSizeMake(45*Ratio, 45*Ratio));
        make.left.equalTo(self).offset(13*Ratio);
    }];
    
    [_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(180*Ratio, 15*Ratio));
        make.top.equalTo(self).offset(15*Ratio);
        make.left.equalTo(_leftView.mas_right).offset(10*Ratio);
        
    }];
    
    [_detailTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(230*Ratio, 15*Ratio));
        make.top.equalTo(_title.mas_bottom).offset(10*Ratio);
        make.left.equalTo(_title);
    }];
    
    
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
