//
//  Fcgo_HomeSortIconCollectionViewCell.m
//  Fcgo
//
//  Created by huafanxiao on 2017/5/15.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_HomeSortIconCollectionViewCell.h"

@interface Fcgo_HomeSortIconCollectionViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *sortIconImageView;
@property (weak, nonatomic) IBOutlet UILabel     *sortIconLabel;

@end

@implementation Fcgo_HomeSortIconCollectionViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];
     [self setupUI];
}

- (void)setupUI
{
    WEAKSELF(weakSelf);
    [self.sortIconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(kAutoWidth6(5));
        make.left.mas_offset(kAutoWidth6(20));
        make.right.mas_offset(kAutoWidth6(-20));
        make.height.mas_equalTo(weakSelf.sortIconImageView.mas_width);
    }];
    [self.sortIconLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.mas_offset(0);
        make.top.mas_equalTo(weakSelf.sortIconImageView.mas_bottom).mas_offset(8);
    }];
    self.sortIconLabel.font =  [UIFont systemFontOfSize:13];
    self.sortIconLabel.textColor = UIFontSortGrayColor;
}

- (void)setSortIconModel:(Fcgo_HomeSortIconModel *)sortIconModel
{
    _sortIconModel = sortIconModel;
    [self.sortIconImageView sd_setImageWithURL:[NSURL URLWithString:sortIconModel.f_icon]placeholderImage:[UIImage imageNamed:@"580X580(圆角）"]];
    self.sortIconLabel.text = sortIconModel.f_status;
}

@end
