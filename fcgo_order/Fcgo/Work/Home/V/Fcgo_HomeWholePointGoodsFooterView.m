//
//  Fcgo_HomeWholePointGoodsFooterView.m
//  Fcgo
//
//  Created by huafanxiao on 2017/6/12.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_HomeWholePointGoodsFooterView.h"

@implementation Fcgo_HomeWholePointGoodsFooterView

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        UILabel *label = [[UILabel alloc]init];
        label.text = @"查\n看\n更\n多";
        label.font = UIFontSacleSize(12);
        label.textColor = UIFontWhiteColor;
        label.numberOfLines = 0;
        _titleLabel = label;
    }
    return _titleLabel;
}

- (UIImageView *)arrowImageView

{
    if (!_arrowImageView) {
        _arrowImageView = [[UIImageView alloc]init];
        _arrowImageView.image = [UIImage imageNamed:@"icon_arrow_home"];
    }
    return _arrowImageView;
}

@end
