//
//  Fcgo_OrderDetailBottomView.m
//  Fcgo
//
//  Created by huafanxiao on 2017/5/25.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_OrderDetailBottomView.h"
#import "Fcgo_OrderDetailBottomViewTableViewCell.h"

@interface Fcgo_OrderDetailBottomView()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView  *table;

@end

@implementation Fcgo_OrderDetailBottomView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.orderType = -1;
        self.backgroundColor = UIBackGroundColor;
        [self setupSubviews];
    }
    return self;
}

- (void)setOrderType:(NSInteger)orderType
{
    _orderType = orderType;
    [self.table reloadData];
    
}

- (void)setupSubviews
{
    UIView *topLineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.mj_w, 0.5)];
    topLineView.backgroundColor = UINavSepratorLineColor;
    [self addSubview:topLineView];
    
    [self.table registerNib:[UINib nibWithNibName:NSStringFromClass([Fcgo_OrderDetailBottomViewTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"orderDetailBottomViewTableViewCell"];
    [self addSubview:self.table];
    [self.table mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_offset(0);
        make.top.mas_offset(kAutoWidth6(5));
        make.bottom.mas_offset(kAutoWidth6(-5));
    }];
}

- (void)showWithAnimation
{
    [UIView animateWithDuration:0.20 animations:^{
        self.frame = CGRectMake(0, KScreenHeight - self.mj_h, kScreenWidth, self.mj_h);
    } completion:^(BOOL finished) {}];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WEAKSELF(weakSelf)
    Fcgo_OrderDetailBottomViewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"orderDetailBottomViewTableViewCell"];
    if (self.orderType > -1) {
        cell.orderType = self.orderType;
    }
    cell.payBlock = ^{
        if(weakSelf.payBlock)
        {
            weakSelf.payBlock();
        }
    };
    cell.cancelBlock = ^{
        if(weakSelf.cancelBlock)
        {
            weakSelf.cancelBlock();
        }
    };
    cell.serviceBlock = ^{
        if(weakSelf.serviceBlock)
        {
            weakSelf.serviceBlock();
        }
    };
    cell.remindBlock = ^{
        if(weakSelf.remindBlock)
        {
            weakSelf.remindBlock();
        }
    };
    
    cell.againBlock = ^{
        if(weakSelf.againBlock)
        {
            weakSelf.againBlock();
        }
    };
    cell.signBlock = ^{
        if(weakSelf.signBlock)
        {
            weakSelf.signBlock();
        }
    };
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kAutoWidth6(50);
}

#pragma mark Lazy method

- (UITableView *)table
{
    if (!_table) {
        UITableView *table    = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        table.backgroundColor = UIFontClearColor;
        table.scrollEnabled   = 0;
        table.separatorStyle  = 0;
        table.delegate        = self;
        table.dataSource      = self;
        table.alpha           = 1;
        table.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
        _table                = table;
        if (@available(iOS 11.0, *)) {
            table.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return _table;
}


@end
