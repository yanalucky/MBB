//
//  Fcgo_Market_SetShopBGCell.m
//  Fcgo
//
//  Created by huafanxiao on 2017/8/2.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_Market_SetShopBGCell.h"

@implementation Fcgo_Market_SetShopBGCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupUI];
}

- (void)setupUI
{
    self.backgroundColor = UIFontWhiteColor;
    self.layer.cornerRadius = 5;
    self.layer.masksToBounds = YES;
    
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.mas_offset(0);
    }];
    
    [self.selectedImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.mas_offset(0);
    }];
    
    self.selectedImgView.hidden = YES;
}

- (void)setSelected:(BOOL)selected
{
    if (selected) {
        self.selectedImgView.hidden = NO;
    }
    else{
        self.selectedImgView.hidden = YES;
    }
}

@end

