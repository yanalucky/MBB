//
//  ShopCartNoneFooterView.m
//  Fcg
//
//  Created by huafanxiao on 2017/4/13.
//  Copyright © 2017年 zgntech. All rights reserved.
//

#import "ShopCartNoneFooterView.h"

@implementation ShopCartNoneFooterView

- (UILabel *)noMoreLabel {
    if (!_noMoreLabel) {
        _noMoreLabel = [[UILabel alloc]init];
        _noMoreLabel.font = UIFontSize(14);
        _noMoreLabel.text = @"我是有底线的";
        _noMoreLabel.textColor = UIStringColor(@"#f63378");
        _noMoreLabel.font = [UIFont systemFontOfSize:13];
        _noMoreLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _noMoreLabel;
}

@end
