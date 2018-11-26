//
//  Fcgo_SortRightBrandCollectionViewCell.m
//  Fcgo
//
//  Created by huafanxiao on 2017/5/23.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_SortRightBrandCollectionViewCell.h"

@interface Fcgo_SortRightBrandCollectionViewCell ()



@end


@implementation Fcgo_SortRightBrandCollectionViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setupUI];
}

- (void)setupUI
{
    self.contentView.layer.borderColor = UISepratorLineColor.CGColor;
    self.contentView.layer.borderWidth = 0.5;
    self.contentView.layer.masksToBounds = 1;
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(0);
        make.left.mas_offset(0);
        make.right.mas_offset(0);
        make.bottom.mas_offset(0);
        
    }];
}

- (void)setModel:(Fcgo_BrandModel *)model
{
    _model = model;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:model.brand_logo]placeholderImage:[UIImage imageNamed:@"456X228（品牌）"]];
}

@end
