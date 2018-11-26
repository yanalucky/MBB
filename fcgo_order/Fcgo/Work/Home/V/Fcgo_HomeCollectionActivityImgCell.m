//
//  Fcgo_HomeCollectionActivityImgCell.m
//  Fcgo
//
//  Created by huafanxiao on 2017/6/23.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_HomeCollectionActivityImgCell.h"

@implementation Fcgo_HomeCollectionActivityImgCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupUI];
}

- (void)setupUI
{
   [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.top.left.right.mas_offset(0);
    }];
}

@end
