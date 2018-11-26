//
//  Fcgo_HomeCollectionTitleHeaderView.m
//  Fcgo
//
//  Created by huafanxiao on 2017/5/31.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_HomeCollectionTitleHeaderView.h"

@implementation Fcgo_HomeCollectionTitleHeaderView

- (UIImageView *)titleImageView
{
    if (!_titleImageView) {
        _titleImageView = [[UIImageView alloc]init];
    }
    return _titleImageView;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel =  [[UILabel alloc]init];
        _titleLabel.textColor = UIFontMainGrayColor;
        _titleLabel.font = [UIFont systemFontOfSize:14];
    }
    return _titleLabel;
}

- (UIView *)topLineView
{
    if (!_topLineView) {
        _topLineView = [[UIView alloc]init];
        _topLineView.backgroundColor = UIBackGroundColor;
    }
    return _topLineView;
}

@end
