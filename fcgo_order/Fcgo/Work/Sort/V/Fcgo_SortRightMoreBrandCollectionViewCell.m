//
//  Fcgo_SortRightMoreBrandCollectionViewCell.m
//  Fcgo
//
//  Created by huafanxiao on 2017/5/23.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_SortRightMoreBrandCollectionViewCell.h"

@interface Fcgo_SortRightMoreBrandCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation Fcgo_SortRightMoreBrandCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupUI];
}

- (void)setupUI
{
    self.contentView.layer.borderColor = UISepratorLineColor.CGColor;
    self.contentView.layer.borderWidth = 0.5;
    self.contentView.layer.masksToBounds = 1;
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(0.5);
        make.left.mas_offset(0.5);
        make.right.mas_offset(-0.5);
        make.bottom.mas_offset(-0.5);
        
    }];
    
    self.titleLabel.font =  UIFontSize(11);
    self.titleLabel.textColor  = UIFontRedColor;
    self.titleLabel.text = @"点击查看\n更多品牌";
    
}


@end
