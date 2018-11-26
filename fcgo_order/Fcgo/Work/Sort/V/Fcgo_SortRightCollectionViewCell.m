//
//  Fcgo_SortRightCollectionViewCell.m
//  Fcgo
//
//  Created by huafanxiao on 2017/5/23.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_SortRightCollectionViewCell.h"

@interface Fcgo_SortRightCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation Fcgo_SortRightCollectionViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setupUI];
}

- (void)setupUI
{
    
    WEAKSELF(weakSelf);
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(8);
        make.left.mas_offset(8);
        make.right.mas_offset(-8);
        make.height.mas_equalTo(weakSelf.imageView.mas_width);
        
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_offset(0);
        make.top.mas_equalTo(weakSelf.imageView.mas_bottom).mas_offset(13);
    }];
    self.titleLabel.font      =  UIFontSize(13);
    self.titleLabel.textColor = UIFontSortGrayColor;
}

- (void)setModel:(Fcgo_CateModel *)model
{
    _model = model;
    self.titleLabel.text = model.cate_name;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:model.cate_logo]placeholderImage:[UIImage imageNamed:@"756X300(分类）"]];
}

@end
