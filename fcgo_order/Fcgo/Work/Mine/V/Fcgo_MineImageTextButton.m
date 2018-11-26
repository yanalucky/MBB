//
//  Fcgo_MineImageTextButton.m
//  Fcgo
//
//  Created by by_r on 2017/10/19.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_MineImageTextButton.h"

@implementation Fcgo_MineImageTextButton

- (void)setupUI {
    [self addSubview:self.btnImageView];
    [self addSubview:self.iconCountLabel];
    [self addSubview:self.btnLabel];
    
    [self.btnImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(5);
        make.centerX.equalTo(self);
        make.size.mas_equalTo(self.btnImageView.image.size);
    }];
    [self.iconCountLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.btnImageView.mas_right).offset(-4);
        make.top.mas_equalTo(1);
        make.height.width.mas_offset(16);
    }];
    self.iconCountLabel.layer.cornerRadius = 8;
    [self.btnLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.top.mas_equalTo(self.btnImageView.mas_bottom).offset(6);
        
    }];
}

@end
