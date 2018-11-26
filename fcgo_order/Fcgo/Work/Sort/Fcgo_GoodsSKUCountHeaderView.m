//
//  Fcgo_GoodsSKUCountHeaderView.m
//  Fcgo
//
//  Created by huafanxiao on 2017/6/21.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_GoodsSKUCountHeaderView.h"

@implementation Fcgo_GoodsSKUCountHeaderView

- (PPNumberButton *)numberButton
{
    if (!_numberButton) {
        PPNumberButton *numberButton = [PPNumberButton numberButtonWithFrame:CGRectMake(kScreenWidth - kAutoWidth6(110)- 15, 10, kAutoWidth6(110), 30)];
        // 开启抖动动画
        numberButton.shakeAnimation = YES;
        //设置边框颜色
        numberButton.borderColor = UIFontMainGrayColor;
        numberButton.increaseTitle = @"＋";
        numberButton.decreaseTitle = @"－";
        [self addSubview:_numberButton = numberButton];
    }
    return _numberButton;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        UILabel *label = [[UILabel alloc]init];
        label.textColor = UIFontMainGrayColor;
        label.font = [UIFont systemFontOfSize:15];
        label.textAlignment = NSTextAlignmentLeft;
        _titleLabel = label;
    }
    return _titleLabel;
}

@end
