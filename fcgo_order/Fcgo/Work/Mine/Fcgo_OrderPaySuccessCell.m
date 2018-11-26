//
//  Fcgo_OrderPaySuccessCell.m
//  Fcgo
//
//  Created by huafanxiao on 2017/6/12.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_OrderPaySuccessCell.h"

@implementation Fcgo_OrderPaySuccessCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setupUI];
}

- (void)setupUI
{
    [self.successImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(kAutoWidth6px(72));
        make.width.height.mas_offset(kAutoWidth6px(516));
        make.centerX.mas_equalTo(self.contentView.mas_centerX);
        
    }];
    
    self.successLabel.textColor = UIRGBColor(119, 119, 119, 1);
    self.successLabel.font = [UIFont systemFontOfSize:13];
    [self.successLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.successImg.mas_bottom).mas_offset(kAutoWidth6px(54));
        make.left.right.mas_offset(0);
    }];
    
    NSMutableAttributedString *content1 = [[NSMutableAttributedString alloc]initWithString:self.successLabel.text];
    [content1 addAttribute:NSForegroundColorAttributeName value:UIFontRedColor range:NSMakeRange(0, 4)];
    [content1 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13] range:NSMakeRange(0, 4)];
    
    [content1 addAttribute:NSForegroundColorAttributeName value:UIFontMainGrayColor range:NSMakeRange(4, self.successLabel.text.length-4)];
    [content1 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13] range:NSMakeRange(4, self.successLabel.text.length-4)];
    self.successLabel.attributedText = content1;
    
    self.success_goBtn.backgroundColor = UIFontRedColor;
    [self.success_goBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_offset(30);
        make.width.mas_offset(120);
        make.top.mas_equalTo(self.successLabel.mas_bottom).mas_offset(kAutoWidth6px(66));
        make.centerX.mas_equalTo(self.contentView.mas_centerX);
    }];
    [self.success_goBtn addTarget:self action:@selector(goToVisit1) forControlEvents:UIControlEventTouchUpInside];
    
    self.bottomview.backgroundColor = UIBackGroundColor;
    [self.bottomview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_offset(0);
        make.height.mas_offset(5);
    }];
}

- (void)goToVisit1
{
    self.goToVisit();
}

@end

