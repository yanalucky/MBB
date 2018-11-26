//
//  Fcgo_ApplyTypeDetailCell.m
//  Fcgo
//
//  Created by fcg on 2017/11/30.
//  Copyright © 2017年 Fcg. All rights reserved.
//

#import "Fcgo_ApplyTypeDetailCell.h"

@implementation Fcgo_ApplyTypeDetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setUI];
    // Initialization code
}
-(void)setUI{
    self.backgroundColor = UIFontWhiteColor;
    _leftImg.image = [UIImage imageNamed:@"gray_flow"];
    _leftImg.contentMode = UIViewContentModeCenter;
    _timeLab.text = @"2017-10-20 16:39:09";
    _timeLab.font = UIFontSize(14);
    _timeLab.textColor = UIStringColor(@"#7b7b7b");
    _titleDetail.textColor = UIStringColor(@"#7b7b7b");
    _titleDetail.text = @"退款失败，请重新提交";
    _titleDetail.font = UIFontSize(14);
    _line.backgroundColor = UISepratorLineColor;
    
}
-(void)makeCell:(NSDictionary *)dic isLast:(BOOL)islast isRed:(BOOL)isRed{
    
    _timeLab.text = dic[@"createTime"];
    _titleDetail.text = dic[@"detail"];
    if (islast) {
        _line.hidden = YES;
    }
    if (isRed) {
        _leftImg.image = [UIImage imageNamed:@"red_flow"];
        _timeLab.textColor = UIFontRedColor;
    _titleDetail.textColor = UIFontRedColor;
    }
}

-(void)layoutSubviews{
    [_leftImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.and.height.mas_equalTo(kAutoWidth6(16));
        make.left.equalTo(self).offset(kAutoWidth6(12));
        make.top.equalTo(self).offset(kAutoWidth6(12));
    }];

    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(0.5);
        make.top.equalTo(_leftImg.mas_bottom).offset(kAutoWidth6(12));
        make.bottom.equalTo(self);
        make.centerX.equalTo(_leftImg);
    }];
    [_timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_leftImg.mas_right).offset(kAutoWidth6(5));
        make.top.equalTo(_leftImg);
        make.height.equalTo(@(kAutoHeight6(15)));
        make.right.equalTo(self);
    }];
    [_titleDetail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_leftImg.mas_right).offset(kAutoWidth6(5));
        make.top.equalTo(_timeLab.mas_bottom);
        make.height.equalTo(@(kAutoHeight6(20)));
        make.right.equalTo(self);
    }];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
