//
//  Fcgo_SortFristCollectionHeaderView.m
//  Fcgo
//
//  Created by huafanxiao on 2017/5/23.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_SortFristCollectionHeaderView.h"

@implementation Fcgo_SortFristCollectionHeaderView

- (UIButton *)headerBtn
{
    if (!_headerBtn) {
        _headerBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    }
    return _headerBtn;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.text = @"";
        _titleLabel.font = UIFontSize(14);
        _titleLabel.textColor = UIFontSortGrayColor;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

@end
