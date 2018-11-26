//
//  Fcgo_OrderConfirmBottomView.m
//  Fcgo
//
//  Created by huafanxiao on 2017/6/12.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_OrderConfirmBottomView.h"
@interface Fcgo_OrderConfirmBottomView ()


@property (nonatomic,strong) UIButton *submitBtn;

@end

@implementation Fcgo_OrderConfirmBottomView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI
{
    WEAKSELF(weakSelf);
    [self addSubview:self.submitBtn];
    [self addSubview:self.totalLabel];
    [self addSubview:self.total];
    [self addSubview:self.freightLabel];
    
    [self.submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.top.bottom.mas_offset(0);
        make.width.mas_offset(kAutoWidth6(110));
    }];
    
    [self.total mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakSelf.mas_centerY);
        make.right.mas_equalTo(weakSelf.submitBtn.mas_left).mas_offset(-5);
    }];
    [self.totalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakSelf.total);
        make.right.mas_equalTo(weakSelf.total.mas_left).mas_offset(-3);
    }];
    
    [self.freightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.mas_centerY).mas_offset(3);
        make.right.mas_equalTo(weakSelf.submitBtn.mas_left).mas_offset(-5);
    }];
    self.freightLabel.hidden = 1;
    self.totalLabel.text = @"总计: ";
}

- (void)setTotalString:(NSString *)totalString
{
    _totalString = totalString;
    self.total.text = totalString;
}

- (void)showWithAnimation
{
    [UIView animateWithDuration:0.20 animations:^{
        self.frame = CGRectMake(0, KScreenHeight - self.mj_h, kScreenWidth, self.mj_h);
    } completion:^(BOOL finished) {}];
}

- (void)submit
{
    if (self.submitBlock) {
       self.submitBlock();
    }
    
}

- (UILabel *)freightLabel
{
    if (!_freightLabel) {
        UILabel *label = [[UILabel alloc]init];
        label.textColor = UIFontMainGrayColor;
        label.numberOfLines = 0;
        label.font = [UIFont systemFontOfSize:12];
        label.textAlignment = NSTextAlignmentCenter;
        _freightLabel = label;
    }
    return _freightLabel;
}


- (UILabel *)totalLabel
{
    if (!_totalLabel) {
        UILabel *label = [[UILabel alloc]init];
        label.textColor = UIFontMainGrayColor;
        label.numberOfLines = 0;
        label.font = [UIFont systemFontOfSize:14];
        label.textAlignment = NSTextAlignmentCenter;
        _totalLabel = label;
    }
    return _totalLabel;
}

- (UILabel *)total
{
    if (!_total) {
        UILabel *label = [[UILabel alloc]init];
        label.textColor = UIFontRedColor;
        label.numberOfLines = 0;
        label.font = [UIFont systemFontOfSize:17];
        label.textAlignment = NSTextAlignmentCenter;
        _total = label;
    }
    return _total;
}

- (UIButton *)submitBtn
{
    if (!_submitBtn) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        
        btn.backgroundColor = UIFontRedColor;
        [btn setTitleColor:UIFontWhiteColor forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:16];
        [btn addTarget:self action:@selector(submit) forControlEvents:UIControlEventTouchUpInside];
        
        [btn setTitle:@"提交订单" forState:UIControlStateNormal];
        
        _submitBtn = btn;
    }
    return _submitBtn;
}

@end
