//
//  Fcgo_LogisticsHeaderView.m
//  Fcgo
//
//  Created by huafanxiao on 2017/7/7.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_LogisticsHeaderView.h"

@implementation Fcgo_LogisticsHeaderView

+ (instancetype)headViewWithTableView:(UITableView *)tableView
{
    static NSString *headIdentifier = @"header";
    Fcgo_LogisticsHeaderView *headView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headIdentifier];
    if (headView == nil){
        headView = [[Fcgo_LogisticsHeaderView alloc] initWithReuseIdentifier:headIdentifier];
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
    [self.contentView addSubview:self.freightNumLabel];
    [self.contentView addSubview:self.freightNum];
    
    [self.contentView addSubview:self.freightState];
    
    [self.contentView addSubview:self.freightCompanyLabel];
    [self.contentView addSubview:self.freightCompany];
    
    [self.contentView addSubview:self.arrowImageView];
    
    [self.contentView addSubview:self.bottomView];
    
    [self.contentView addSubview:self.showBtn];
    
    [self.showBtn addTarget:self action:@selector(show) forControlEvents:UIControlEventTouchUpInside];
    
    
    WEAKSELF(weakSelf)
    [self.freightNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(10);
        make.left.mas_offset(15);
    }];
    
    [self.freightNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakSelf.freightNumLabel.mas_centerY);
        make.left.mas_equalTo(weakSelf.freightNumLabel.mas_right).mas_offset(5);
    }];
    
    [self.freightState mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakSelf.freightNumLabel.mas_centerY);
        make.height.mas_equalTo(weakSelf.freightNumLabel.mas_height);
        make.left.mas_equalTo(weakSelf.freightNum.mas_right).mas_offset(5);
         make.width.mas_offset(50);
    }];
    
    [self.freightCompanyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.freightNumLabel.mas_bottom).mas_offset(10);
        make.left.mas_offset(15);
    }];
    
    [self.freightCompany mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakSelf.freightCompanyLabel.mas_centerY);
        make.left.mas_equalTo(weakSelf.freightCompanyLabel.mas_right).mas_offset(5);
    }];
    
    [self.arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakSelf.contentView.mas_centerY).mas_offset(-2.5);
        make.right.mas_offset(-15);
        make.height.mas_offset(18*13/26);
        make.width.mas_offset(18);
    }];
    
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
       make.left.bottom.right.mas_offset(0);
        make.height.mas_offset(5);
    }];

    [self.showBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.mas_offset(0);
    }];
    
    UILongPressGestureRecognizer *longGr = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longAction)];
    
    [self addGestureRecognizer:longGr];
}

- (void)longAction
{
    if (self.copyBlock) {
        self.copyBlock();
    }
}

- (void)show
{
    if (self.showBlock) {
        self.showBlock(self.showBtn.select);
    }
}

- (UILabel *)freightNumLabel
{
    if (!_freightNumLabel) {
        UILabel *label = [[UILabel alloc]init];
        label.textColor = UIFontMiddleGrayColor;
        label.font = UIFontSize(14);
        _freightNumLabel = label;
    }
    return _freightNumLabel;
}

- (UILabel *)freightNum
{
    if (!_freightNum) {
        UILabel *label = [[UILabel alloc]init];
        label.textColor = UIFontMainGrayColor;
        label.font = UIFontSize(14);
        _freightNum = label;
    }
    return _freightNum;
}

- (UILabel *)freightState
{
    if (!_freightState) {
        UILabel *label = [[UILabel alloc]init];
        label.textColor = UIFontWhiteColor;
        label.backgroundColor = UIFontRedColor;
        label.font = UIFontSize(11);
        label.textAlignment = NSTextAlignmentCenter;
        label.layer.cornerRadius = 3;
        label.layer.masksToBounds = 1;
        _freightState = label;
    }
    return _freightState;
}

- (UILabel *)freightCompanyLabel
{
    if (!_freightCompanyLabel) {
        UILabel *label = [[UILabel alloc]init];
        label.textColor = UIFontMiddleGrayColor;
        label.font = UIFontSize(14);
        _freightCompanyLabel = label;
    }
    return _freightCompanyLabel;
}

- (UILabel *)freightCompany
{
    if (!_freightCompany) {
        UILabel *label = [[UILabel alloc]init];
        label.textColor = UIFontMainGrayColor;
        label.font = UIFontSize(14);
        
        _freightCompany = label;
    }
    return _freightCompany;
}

- (Fcgo_IndexButton *)showBtn
{
    if (!_showBtn) {
        _showBtn = [Fcgo_IndexButton buttonWithType:UIButtonTypeCustom];
        _showBtn.backgroundColor = UIFontClearColor;
    }
    return _showBtn;
}

- (UIImageView *)arrowImageView
{
    if (!_arrowImageView) {
        _arrowImageView = [[UIImageView alloc]init];
        _arrowImageView.image = [UIImage imageNamed:@"down_icon_arrow@2x"];
    }
    return _arrowImageView;
}

- (UIView *)bottomView
{
    if (!_bottomView) {
        _bottomView = [[UIView alloc]init];
        _bottomView.backgroundColor = UIBackGroundColor;
    }
    return _bottomView;
}

@end

