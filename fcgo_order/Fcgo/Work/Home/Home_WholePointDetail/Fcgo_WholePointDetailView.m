//
//  Fcgo_WholePointDetailView.m
//  Fcgo
//
//  Created by huafanxiao on 2017/6/13.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_WholePointDetailView.h"
#import "Home_WholePointDetailCell.h"
#import "Fcgo_TimeCountDownView.h"
#import "Fcgo_BrokenNetworkOrNoDataControl.h"

@interface Fcgo_WholePointDetailView()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView  *table;
@property (nonatomic,strong) NSArray      *titleArray;
@property (nonatomic,strong) Fcgo_BrokenNetworkOrNoDataControl *noControl;

@end

@implementation Fcgo_WholePointDetailView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews
{
    [self addSubview:self.noControl];
    [self.table registerNib:[UINib nibWithNibName:NSStringFromClass([Home_WholePointDetailCell class]) bundle:nil] forCellReuseIdentifier:@"home_WholePointDetailCell"];
    [self addSubview:self.table];
}

- (void)reloadTableDataWithModel:(Fcgo_WholePointModel *)model type:(WholePointType)type1
{
    self.model = model;
    if (self.model.datas.count<=0) {
        self.noControl.hidden = 0;
        self.table.hidden = 1;
    }
    else
    {
        self.noControl.hidden = 1;
        self.table.hidden = 0;
    }
    self.type = type1;
    [self.table reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.model) {
        return self.model.datas.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WEAKSELF(weakSelf)
    Home_WholePointDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"home_WholePointDetailCell"];
    if (self.model) {
        Fcgo_WholePointGoodsModel *model = self.model.datas[indexPath.row];
        cell.pointModel = self.model;
        cell.model = model;
        cell.type = self.type;
    }
    cell.selectedBlock = ^(Fcgo_WholePointGoodsModel *goodsModel){
        if (weakSelf.selectedBlock) {
            weakSelf.selectedBlock(goodsModel);
        }
    };
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   if (self.model) {
        Fcgo_WholePointGoodsModel *model = self.model.datas[indexPath.row];
        if(self.selectedBlock)
        {
            self.selectedBlock(model);
        }
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 105;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    WEAKSELF(weakSelf)
    Fcgo_TimeCountDownView *headView = [[Fcgo_TimeCountDownView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
    if (self.model) {
        headView.type = self.type;
        headView.model = self.model;
    }
    headView.timeFinishBlock = ^{
        weakSelf.timeFinishBlock();
    };
    return headView;
}

#pragma mark Lazy method

- (UITableView *)table
{
    if (!_table) {
        UITableView *table    = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.mj_w, self.mj_h) style:UITableViewStylePlain];
        table.backgroundColor = UIFontClearColor;
        table.separatorStyle  = 0;
        table.delegate        = self;
        table.dataSource      = self;
        _table                = table;
        if (@available(iOS 11.0, *)) {
            table.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return _table;
}

- (Fcgo_BrokenNetworkOrNoDataControl *)noControl
{
    if (!_noControl) {
        _noControl = [[Fcgo_BrokenNetworkOrNoDataControl alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, KScreenHeight - kNavigationHeight)];
        _noControl.hidden = 1;
        _noControl.imageString = @"ico_no-collect";
        _noControl.titleString = @"暂无整点抢商品哦";
    }
    return _noControl;
}

@end

