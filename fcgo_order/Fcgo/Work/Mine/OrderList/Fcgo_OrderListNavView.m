//
//  Fcgo_OrderListNavView.m
//  Fcgo
//
//  Created by by_r on 2017/10/24.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_OrderListNavView.h"

@interface Fcgo_OrderListNavView()
@property (nonatomic, strong) UILabel   *titleLabel;
@property (nonatomic, strong) UIButton  *searchButton;
@property (nonatomic, strong) UIButton  *siftButton;
@end

@implementation Fcgo_OrderListNavView
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = UIFontClearColor;
        [self setupUI];
    }
    return self;
}

- (void)setTitleString:(NSString *)title {
    self.titleLabel.text = title;
}

- (void)searchButtonAction:(UIButton *)sender {
    !self.searchBlock?:self.searchBlock();
}
- (void)siftButtonAction:(UIButton *)sender {
    !self.siftBlock?:self.siftBlock();
}

- (void)setupUI {
    UILabel *titleLabel = [UILabel new];
    titleLabel.font = UIFontSize(17);
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = @"全部订单";
    [self addSubview:self.titleLabel = titleLabel];
    
    UIButton *searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [searchButton setImage:[UIImage imageNamed:@"icon_order_select"] forState:UIControlStateNormal];
    [searchButton addTarget:self action:@selector(searchButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.searchButton = searchButton];
    
    UIButton *siftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [siftButton setImage:[UIImage imageNamed:@"icon_order_screening"] forState:UIControlStateNormal];
    [siftButton addTarget:self action:@selector(siftButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.siftButton = siftButton];
    
    {
        [siftButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.mas_centerY).mas_offset(10);
            make.right.mas_equalTo(-12);
            make.size.mas_equalTo(siftButton.imageView.image.size);
        }];
        [searchButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(siftButton);
            make.right.mas_equalTo(siftButton.mas_left).offset(-10);
            make.size.mas_equalTo(searchButton.imageView.image.size);
        }];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self);
            make.centerY.mas_equalTo(self.mas_centerY).mas_offset(10);
            make.height.mas_equalTo(30);
            make.left.mas_offset(35).priorityLow();
            make.right.mas_equalTo(searchButton.mas_left).offset(-5).priorityLow();
        }];
    }
}

@end
