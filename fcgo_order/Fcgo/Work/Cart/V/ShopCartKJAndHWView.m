//
//  ShopCartKJAndHWView.m
//  Fcg
//
//  Created by huafanxiao on 2017/4/14.
//  Copyright © 2017年 zgntech. All rights reserved.
//

#import "ShopCartKJAndHWView.h"
#import "ShopCartKJAndHWGoodsMsgCell.h"
#import "ShopCartKJAndHWGoodsMsg_IntetalCell.h"
#import "Fcgo_CartIndexButton.h"

@interface ShopCartKJAndHWView ()<UITableViewDelegate,UITableViewDataSource>



@end

@implementation ShopCartKJAndHWView


- (void)setCartArray:(NSMutableArray *)cartArray
{
    _cartArray = cartArray;
    [self.tableview reloadData];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = UIFontWhiteColor;
        [self addSubview:self.tableview];
    }
    return self;
}

- (UITableView *)tableview
{
    WEAKSELF(weakSelf);
    if ((!_tableview)) {
        _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.mj_w, self.mj_h) style:UITableViewStylePlain];
        _tableview.delegate = self;
        _tableview.dataSource  = self;
        _tableview.separatorStyle = 0;
        _tableview.backgroundColor = UIBackGroundColor;
        [_tableview registerNib:[UINib nibWithNibName:NSStringFromClass([ShopCartKJAndHWGoodsMsgCell class]) bundle:nil] forCellReuseIdentifier:@"shopCartKJAndHWGoodsMsgCell"];
        [_tableview registerNib:[UINib nibWithNibName:NSStringFromClass([ShopCartKJAndHWGoodsMsg_IntetalCell class]) bundle:nil] forCellReuseIdentifier:@"shopCartKJAndHWGoodsMsg_IntetalCell"];
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
//    if(indexPath.section == 0)
//    {
//        return 205;
//    }
    return 185;
}

- (UITableViewCell  *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WEAKSELF(weakSelf);
    if (indexPath.section == 0)
    {
        ShopCartKJAndHWGoodsMsg_IntetalCell *cell = [tableView dequeueReusableCellWithIdentifier:@"shopCartKJAndHWGoodsMsg_IntetalCell"];
        if (self.cartArray.count>0) {
            NSMutableArray *array = self.cartArray[indexPath.section];
            Fcgo_CartModel *model = array[indexPath.row];
            cell.model = model;
            cell.model = model;
        }
        
        cell.jumpBlock = ^(Fcgo_CartModel *model)
        {
            weakSelf.selectItemBlock(model);
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
                
            }
        };
        cell.deleteBlock = ^(Fcgo_CartModel *model)
        {
            [weakSelf deleteGoodsCartWithModel:model];
        };
        cell.buyBlock = ^(Fcgo_CartModel *model){
            self.buyBlock(model);
        };
        return cell;
    }
        ShopCartKJAndHWGoodsMsgCell *cell = [tableView dequeueReusableCellWithIdentifier:@"shopCartKJAndHWGoodsMsgCell"];
        if (self.cartArray.count>0) {
            NSMutableArray *array = self.cartArray[indexPath.section];
            Fcgo_CartModel *model = array[indexPath.row];
            cell.model = model;
            cell.model = model;
        }
        
        cell.jumpBlock = ^(Fcgo_CartModel *model)
        {
            weakSelf.selectItemBlock(model);
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
            }
        };
        cell.deleteBlock = ^(Fcgo_CartModel *model)
        {
            [weakSelf deleteGoodsCartWithModel:model];
        };
        cell.buyBlock = ^(Fcgo_CartModel *model){
            self.buyBlock(model);
        };
        return cell;
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
        }else{
            [WSProgressHUD showImage:nil status:@"删除失败"];
        }
    } failureBlock:^(NSString *description) {
    }];
}
@end
