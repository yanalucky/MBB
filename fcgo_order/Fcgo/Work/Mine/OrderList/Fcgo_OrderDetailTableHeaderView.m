//
//  Fcgo_OrderDetailTableHeaderView.m
//  Fcgo
//
//  Created by huafanxiao on 2017/5/25.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_OrderDetailTableHeaderView.h"

@implementation Fcgo_OrderDetailTableHeaderView

+ (instancetype)headViewWithTableView:(UITableView *)tableView {
    static NSString *headIdentifier = @"header";
    Fcgo_OrderDetailTableHeaderView *headView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headIdentifier];
    if (headView == nil){
        headView = [[Fcgo_OrderDetailTableHeaderView alloc] initWithReuseIdentifier:headIdentifier];
        headView.contentView.backgroundColor = UIFontWhiteColor;
    }
    return headView;
}

- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithReuseIdentifier:reuseIdentifier]){
        [self setupUI];
    }
    return self;
}

- (void)setupUI
{
     [self.logisticsControl addTarget:self action:@selector(logistics) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.logisticsControl];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.arrowImageView];
    [self.contentView addSubview:self.orderStatusLabel];
    
    WEAKSELF(weakSelf)
    [self.logisticsControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.mas_offset(0);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(0);
        make.centerY.mas_equalTo(weakSelf.contentView.mas_centerY);
        make.bottom.mas_offset(0);
        make.left.mas_offset(15);
    }];
    
    self.titleLabel.textColor = UIFontRedColor;
    self.titleLabel.font = UIFontSize(15);
    
    [self.arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakSelf.contentView.mas_centerY);
        make.right.mas_offset(-15);
        make.width.mas_offset(16*19/36);
        make.height.mas_offset(16);
    }];
    self.arrowImageView.hidden = 1;
    [self.orderStatusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(weakSelf.arrowImageView.mas_left).mas_offset(-10);
        make.centerY.mas_equalTo(weakSelf.titleLabel);
        
    }];
    self.orderStatusLabel.textColor = UIFontMainGrayColor;
    self.orderStatusLabel.font = UIFontSize(15);
}

- (void)logistics
{
    if (self.logisticsBlock) {
        self.logisticsBlock();
    }
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        //_titleLabel.text = @"包裹1";
    }
    return _titleLabel;
}

- (UILabel *)orderStatusLabel
{
    if (!_orderStatusLabel) {
        _orderStatusLabel = [[UILabel alloc]init];
        _orderStatusLabel.textAlignment = NSTextAlignmentRight;
        //_orderStatusLabel.text = @"已发货";
    }
    return _orderStatusLabel;
}

- (UIControl *)logisticsControl
{
    if (!_logisticsControl) {
        _logisticsControl = [[UIControl alloc]initWithFrame:CGRectZero];
        _logisticsControl.backgroundColor = UIFontClearColor;
    }
    return _logisticsControl;
}

- (UIImageView *)arrowImageView
{
    if (!_arrowImageView) {
        _arrowImageView = [[UIImageView alloc]initWithFrame:CGRectZero];
        _arrowImageView.image = [UIImage imageNamed:@"right_arrow"];
    }
    return _arrowImageView;
}

@end
