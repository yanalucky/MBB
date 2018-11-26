//
//  Fcgo_ContainImageViewLabelButton.m
//  Fcgo
//
//  Created by huafanxiao on 2017/5/11.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_ContainImageViewLabelButton.h"

@implementation Fcgo_ContainImageViewLabelButton

- (void)setupUI
{
    WEAKSELF(weakSelf)
    [self addSubview:self.btnImageView];
    [self addSubview:self.btnLabel];
    
    [self.btnImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(5);
        make.right.mas_offset(-5);
        make.top.mas_offset(0);
        make.height.mas_equalTo(weakSelf.btnImageView.mas_width);
    }];
    
    [self.btnLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_offset(0);
    }];
}

- (UIImageView *)btnImageView
{
    if (!_btnImageView) {
        _btnImageView = [[UIImageView alloc]init];
        
    }
    return _btnImageView;
}

- (UILabel *)btnLabel
{
    if (!_btnLabel) {
        _btnLabel = [[UILabel alloc]init];
        _btnLabel.font = [UIFont boldSystemFontOfSize:9];
        _btnLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _btnLabel;
}
@end
