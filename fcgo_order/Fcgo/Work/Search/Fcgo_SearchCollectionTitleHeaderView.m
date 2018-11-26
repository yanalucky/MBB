//
//  Fcgo_SearchCollectionTitleHeaderView.m
//  Fcgo
//
//  Created by huafanxiao on 2017/6/14.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_SearchCollectionTitleHeaderView.h"

@implementation Fcgo_SearchCollectionTitleHeaderView
- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel =  [[UILabel alloc]init];
        _titleLabel.textColor = UIFontMainGrayColor;
        _titleLabel.font = [UIFont systemFontOfSize:15];
    }
    return _titleLabel;
}
@end
