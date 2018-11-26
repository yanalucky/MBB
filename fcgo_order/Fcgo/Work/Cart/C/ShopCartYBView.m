//
//  ShopCartYBView.m
//  Fcg
//
//  Created by huafanxiao on 2017/4/14.
//  Copyright © 2017年 zgntech. All rights reserved.
//

#import "ShopCartYBView.h"
#import "ShopCartYBCell.h"
#import "ShopCartYB_IntetalCell.h"
#import "Fcgo_CartIndexButton.h"

@interface ShopCartYBView ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation ShopCartYBView

- (void)setCartArray:(NSMutableArray *)cartArray
{
    _cartArray = cartArray;
    [self.selectAllBtn setBackgroundImage:[UIImage imageNamed:@"select_on"] forState:UIControlStateNormal];
    self.selectAllBtn.select = YES;
    [self selectedCellSetBuyBtnTitle];
    [self dealSelectedGoodsPrice];
    [self.tableview reloadData];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = UIFontWhiteColor;
        [self addSubview:self.tableview];
        
        self.selectAllBtn.frame = CGRectMake(12, self.mj_h-40, 30, 30);
        self.selectAllLabel.frame = CGRectMake(47, self.mj_h-50, 30, 50);
        
        self.buyBtn.frame = CGRectMake(self.mj_w-kAutoWidth6(140), self.mj_h-50, kAutoWidth6(140), 50);
        self.goodsAmountLabel.frame = CGRectMake(self.mj_w-kAutoWidth6(140)-50-10, self.mj_h-50, 50, 50);
        self.goodsSumLabel.frame = CGRectMake(self.mj_w-kAutoWidth6(140)-35-50-10, self.mj_h-50, 35, 50);
        [self addSubview:self.selectAllBtn];
        [self addSubview:self.selectAllLabel];
        [self addSubview:self.goodsSumLabel];
        [self addSubview:self.goodsAmountLabel];
        [self addSubview:self.buyBtn];
    }
    return self;
}

- (UILabel *)selectAllLabel
{
    if (!_selectAllLabel) {
        _selectAllLabel = [[UILabel alloc]init];
        _selectAllLabel.font = [UIFont systemFontOfSize:14];
        _selectAllLabel.text = @"全选";
        _selectAllLabel.textColor = UIFontMainGrayColor;
    }
    return _selectAllLabel;
}

- (UILabel *)goodsSumLabel
{
    if (!_goodsSumLabel) {
        _goodsSumLabel = [[UILabel alloc]init];
        _goodsSumLabel.font = [UIFont systemFontOfSize:14];
        _goodsSumLabel.text = @"总计:";
        _goodsSumLabel.textColor = UIFontMainGrayColor;
    }
    return _goodsSumLabel;
}

- (UILabel *)goodsAmountLabel
{
    if (!_goodsAmountLabel) {
        _goodsAmountLabel = [[UILabel alloc]init];
        _goodsAmountLabel.font = [UIFont systemFontOfSize:17];
        _goodsAmountLabel.textColor = UIFontRedColor;
        _goodsAmountLabel.text = @"¥ 0.00";
    }
    return _goodsAmountLabel;
}

- (Fcgo_IndexButton *)selectAllBtn
{
    if (!_selectAllBtn) {
        _selectAllBtn = [Fcgo_IndexButton buttonWithType:UIButtonTypeSystem];
        [_selectAllBtn setBackgroundImage:[UIImage imageNamed:@"select_off"] forState:UIControlStateNormal];
        [_selectAllBtn addTarget:self action:@selector(selectAllClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _selectAllBtn;
}

- (UIButton *)buyBtn
{
    if (!_buyBtn) {
        _buyBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        _buyBtn.backgroundColor = UIStringColor(@"f63378");
        [_buyBtn setTitle:@"结算" forState:UIControlStateNormal];
        [_buyBtn setTitleColor:UIStringColor(@"#ffffff") forState:UIControlStateNormal];
        _buyBtn.titleLabel.font = [UIFont boldSystemFontOfSize:15];
        [_buyBtn addTarget:self action:@selector(buy) forControlEvents:UIControlEventTouchUpInside];
    }
    return _buyBtn;
}

- (void)selectAllClick
{
    //未全部选中，点击全部选中
    if(!self.selectAllBtn.select)
    {
        [self.selectAllBtn setBackgroundImage:[UIImage imageNamed:@"select_on"] forState:UIControlStateNormal];
    }
    else
    {
        [self.selectAllBtn setBackgroundImage:[UIImage imageNamed:@"select_off"] forState:UIControlStateNormal];
    }
    self.selectAllBtn.select =  !self.selectAllBtn.select;
    for (int i  = 0 ; i < self.cartArray.count; i ++) {
        NSMutableArray *array = self.cartArray[i];
        for (int t = 0; t < array.count; t ++) {
            Fcgo_CartModel *model = array[t];
            model.select = self.selectAllBtn.select;
            [array replaceObjectAtIndex:t withObject:model];
            [self.cartArray replaceObjectAtIndex:i withObject:array];
        }
    }
    
    [self.tableview reloadData];
    [self dealSelectedGoodsPrice];
    [self selectedCellSetBuyBtnTitle];
}

- (void)buy
{
    BOOL selected = NO;
    for (int i  = 0 ; i < self.cartArray.count; i ++) {
        NSMutableArray *array = self.cartArray[i];
        for (int t = 0; t < array.count; t ++) {
            Fcgo_CartModel *model = array[t];
            if (model.select  && model.f_status.intValue == 1 ) //&& model.remain.intValue/model.f_number.intValue > 0)
            {
                selected = YES;
            }
        }
    }
    
    if (!selected) {
        [WSProgressHUD showImage:nil status:@"请选中商品"];
        return;
    }
    NSMutableArray  *selectedArray = [NSMutableArray array];
    for (int i  = 0 ; i < self.cartArray.count; i ++) {
        NSMutableArray *array = self.cartArray[i];
        for (int t = 0; t < array.count; t ++) {
            Fcgo_CartModel *model = array[t];
            if (model.select && model.f_status.intValue == 1 ) //&& model.remain.intValue/model.f_number.intValue > 0 )
            {
                [selectedArray addObject:model];
                
            }
        }
    }
    self.buyBlock(selectedArray);
}

- (UITableView *)tableview
{
    WEAKSELF(weakSelf);
    if ((!_tableview)) {
        _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.mj_w, self.mj_h-50) style:UITableViewStylePlain];
        _tableview.delegate = self;
        _tableview.dataSource  = self;
        _tableview.separatorStyle = 0;
        _tableview.backgroundColor = UIBackGroundColor;
        [_tableview registerNib:[UINib nibWithNibName:NSStringFromClass([ShopCartYBCell class]) bundle:nil] forCellReuseIdentifier:@"shopCartYBCell"];
        [_tableview registerNib:[UINib nibWithNibName:NSStringFromClass([ShopCartYB_IntetalCell class]) bundle:nil] forCellReuseIdentifier:@"shopCartYB_IntetalCell"];
        if (@available(iOS 11.0, *)) {
            _tableview.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        
        UIView *footerview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.mj_w, 5)];
        footerview.backgroundColor = UIBackGroundColor;
        _tableview.tableFooterView = footerview;
        _tableview.mj_header = [Fcgo_RefreshNormalHeader headerRefreshBlock:^{
            weakSelf.refreshBlock();
        }];
    }
    return _tableview;
}


#pragma mark-----UITableViewDelegate   UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.cartArray.count>0) {
        NSMutableArray *array = self.cartArray[section];
        return array.count;
    }
    return 0;
}
    
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.cartArray.count>0) {
        return [self.cartArray count];
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if (indexPath.section == 0)
//    {
//        return 168;
//    }
    return 150;
}

- (UITableViewCell  *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WEAKSELF(weakSelf);
    if (indexPath.section == 0) {
        ShopCartYB_IntetalCell *cell = [tableView dequeueReusableCellWithIdentifier:@"shopCartYB_IntetalCell"];
        if (self.cartArray.count>0) {
             NSMutableArray *array = self.cartArray[indexPath.section];
             Fcgo_CartModel *model = array[indexPath.row];
             cell.model = model;
        }
        cell.jumpBlock = ^(Fcgo_CartModel *model)
        {
            weakSelf.selectItemBlock(model);
        };
        
        cell.selectBlock = ^(Fcgo_CartModel *model)
        {
            if (model) {
                for (int i  = 0 ; i < weakSelf.cartArray.count; i ++) {
                    NSMutableArray *array = weakSelf.cartArray[i];
                    for (int t = 0; t < array.count; t ++) {
                        Fcgo_CartModel *model1 = array[t];
                        if ([model.cat_id integerValue] == [model1.cat_id integerValue]) {
                            [array replaceObjectAtIndex:t withObject:model];
                            [weakSelf.cartArray replaceObjectAtIndex:i withObject:array];
                        }
                    }
                }
                [weakSelf judgeAllSelected];
                [weakSelf dealSelectedGoodsPrice];
                [weakSelf selectedCellSetBuyBtnTitle];
            }
        };
        cell.countBlock = ^(Fcgo_CartModel *model){
            if (model) {
               
                for (int i  = 0 ; i < weakSelf.cartArray.count; i ++) {
                    NSMutableArray *array = weakSelf.cartArray[i];
                    for (int t = 0; t < array.count; t ++) {
                        Fcgo_CartModel *model1 = array[t];
                        if ([model.cat_id integerValue] == [model1.cat_id integerValue]) {
                            [array replaceObjectAtIndex:t withObject:model];
                            [weakSelf.cartArray replaceObjectAtIndex:i withObject:array];
                        }
                    }
                }
                [self addGoodsCount:model];

                [weakSelf dealSelectedGoodsPrice];
            }
        };
        cell.deleteBlock = ^(Fcgo_CartModel *model)
        {
            [weakSelf deleteGoodsCartWithModel:model];
        };
        return cell;
    }
    
    ShopCartYBCell *cell = [tableView dequeueReusableCellWithIdentifier:@"shopCartYBCell"];
    if (self.cartArray.count>0) {
        NSMutableArray *array = self.cartArray[indexPath.section];
        Fcgo_CartModel *model = array[indexPath.row];
        cell.model = model;
    }
    cell.jumpBlock = ^(Fcgo_CartModel *model)
    {
        weakSelf.selectItemBlock(model);
    };
    
    cell.selectBlock = ^(Fcgo_CartModel *model)
    {
        if (model) {
            for (int i  = 0 ; i < weakSelf.cartArray.count; i ++) {
                NSMutableArray *array = weakSelf.cartArray[i];
                for (int t = 0; t < array.count; t ++) {
                    Fcgo_CartModel *model1 = array[t];
                    if ([model.cat_id integerValue] == [model1.cat_id integerValue]) {
                        [array replaceObjectAtIndex:t withObject:model];
                        [weakSelf.cartArray replaceObjectAtIndex:i withObject:array];
                    }
                }
            }
            [weakSelf judgeAllSelected];
            [weakSelf dealSelectedGoodsPrice];
            [self selectedCellSetBuyBtnTitle];
        }
    };
    cell.countBlock = ^(Fcgo_CartModel *model){
        if (model) {
            
            for (int i  = 0 ; i < weakSelf.cartArray.count; i ++) {
                NSMutableArray *array = weakSelf.cartArray[i];
                for (int t = 0; t < array.count; t ++) {
                    Fcgo_CartModel *model1 = array[t];
                    if ([model.cat_id integerValue] == [model1.cat_id integerValue]) {
                        [array replaceObjectAtIndex:t withObject:model];
                        [weakSelf.cartArray replaceObjectAtIndex:i withObject:array];
                    }
                }
            }
            [weakSelf addGoodsCount:model];
            [weakSelf dealSelectedGoodsPrice];
        }
    };
    cell.deleteBlock = ^(Fcgo_CartModel *model){
        [weakSelf deleteGoodsCartWithModel:model];
    };
    return cell;
}

//删除商品
- (void)deleteGoodsCartWithModel:(Fcgo_CartModel *)model
{
    WEAKSELF(weakSelf);
    NSMutableDictionary *mutaDict=[[NSMutableDictionary alloc]init];
//    [mutaDict setObjectWithNullValidate:@"32" forKey:@"merId"];
    [mutaDict setObjectWithNullValidate:model.cat_id forKey:@"id"];
    [Fcgo_NetworkManager postRequest:NSFormatHeardMeThodUrl(ServiceLocalTypeOne, SHOPCARMETHOD, @"delShopCar") parametersContentCommon:mutaDict successBlock:^(BOOL success, id responseObject, NSString *msg) {
        if (success) {
            BOOL isAllDelete = YES;
            for (int i  = 0 ; i < weakSelf.cartArray.count; i ++) {
                NSMutableArray *array = weakSelf.cartArray[i];
                for (int t = 0; t < array.count; t ++) {
                    Fcgo_CartModel *model1 = array[t];
                    if ([model.cat_id integerValue] == [model1.cat_id integerValue]) {
                        [array removeObject:model];
                        [weakSelf.cartArray replaceObjectAtIndex:i withObject:array];
                        [weakSelf.tableview deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:t inSection:i]] withRowAnimation:UITableViewRowAnimationFade];
                    }
                }
                if(array.count > 0)
                {
                    isAllDelete = NO;
                }
            }
            if (isAllDelete == YES)
            {
                [weakSelf.tableview.mj_header beginRefreshing];
            }
            [weakSelf judgeAllSelected];
            [weakSelf dealSelectedGoodsPrice];
            [weakSelf selectedCellSetBuyBtnTitle];
            
        }else{
            [WSProgressHUD showImage:nil status:@"删除失败"];
            
        }
    } failureBlock:^(NSString *description) {}];
}
- (void)addGoodsCount:(Fcgo_CartModel *)model{
    NSMutableDictionary *paremeters = [NSMutableDictionary  dictionary];
    [paremeters setObjectWithNullValidate:model.cat_id forKey:@"id"];
    [paremeters setObjectWithNullValidate:@(model.number) forKey:@"num"];
    [Fcgo_NetworkManager postRequest:NSFormatHeardMeThodUrl(ServiceLocalTypeOne, SHOPCARMETHOD, @"updateShopcarNum") parametersContentCommon:paremeters successBlock:^(BOOL success, id responseObject, NSString *msg) {
        if (success) {
            
        }
    } failureBlock:^(NSString *description) {
        
    }];
}

//计算选中的价格总计，cell上面的按钮每一次点击都得调取
- (void)dealSelectedGoodsPrice
{
    float amount = 0.00;
    for (int i  = 0 ; i < self.cartArray.count; i ++) {
        NSMutableArray *array = self.cartArray[i];
        for (int t = 0; t < array.count; t ++) {
            Fcgo_CartModel *model = array[t];
            if (model.select && model.f_status.intValue == 1) //&& model.remain.intValue/model.f_number.intValue > 0)
            {
                float price = [model.totalPriceYUAN doubleValue];
                amount += price *model.number;
            }
        }
    }
    
    NSString *amountString = [NSString stringWithFormat:@"¥ %.2f",round(amount*100)/100];
    self.goodsAmountLabel.text = amountString;
    CGFloat width = [amountString getWidthWithFont:16 isBold:1];
    self.goodsAmountLabel.frame = CGRectMake(self.mj_w-kAutoWidth6(140)-width-10, self.mj_h-50, width+5, 50);
    self.goodsSumLabel.frame = CGRectMake(self.mj_w-kAutoWidth6(140)-35-width-10, self.mj_h-50, 35, 50);
}

//判断是否全部选中，cell上面的按钮每一次点击都得调取
- (void)judgeAllSelected
{
    BOOL allSelected = YES;
    
    for (int i  = 0 ; i < self.cartArray.count; i ++) {
        NSMutableArray *array = self.cartArray[i];
        for (int t = 0; t < array.count; t ++) {
            Fcgo_CartModel *model = array[t];
            if (model.f_status.intValue == 1 && model.select == NO ) //&& model.remain.intValue/model.f_number.intValue > 0)
            {
                allSelected = NO;
            }
        }
    }
    
    if (allSelected)
    {
        [self.selectAllBtn setBackgroundImage:[UIImage imageNamed:@"select_on"] forState:UIControlStateNormal];
        self.selectAllBtn.select = YES;
    }
    else
    {
        [self.selectAllBtn setBackgroundImage:[UIImage imageNamed:@"select_off"] forState:UIControlStateNormal];
        self.selectAllBtn.select = NO;
    }
}

- (void)selectedCellSetBuyBtnTitle
{
    NSInteger count = 0;
    for (int i  = 0 ; i < self.cartArray.count; i ++) {
        NSMutableArray *array = self.cartArray[i];
        for (int t = 0; t < array.count; t ++) {
            Fcgo_CartModel *model = array[t];
            if (model.select && model.f_status.intValue == 1 ) //&& model.remain.intValue/model.f_number.intValue > 0)
            {
                count += 1;
            }
        }
    }
    NSString *title;
    if (count == 0) {
        title = @"结算";
    }else
    {
        title = [NSString stringWithFormat:@"结算(%ld)",(long)count];
    }
    [self.buyBtn setTitle:title forState:UIControlStateNormal];
}
@end
