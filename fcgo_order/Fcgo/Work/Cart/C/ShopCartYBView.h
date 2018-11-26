//
//  ShopCartYBView.h
//  Fcg
//
//  Created by huafanxiao on 2017/4/14.
//  Copyright © 2017年 zgntech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Fcgo_CartModel.h"

@interface ShopCartYBView : UIView

@property (nonatomic,strong) NSMutableArray *cartArray;
@property (nonatomic,copy)void(^selectItemBlock)(Fcgo_CartModel *model);
@property (nonatomic,copy)void(^refreshBlock)(void);
@property (nonatomic,copy)void(^buyBlock)(NSMutableArray  *selectedArray);

@property (nonatomic,strong) UITableView *tableview;
@property (nonatomic,strong) UIButton *buyBtn;
@property (nonatomic,strong) Fcgo_IndexButton *selectAllBtn;

@property (nonatomic,strong) UILabel *selectAllLabel,*goodsSumLabel,*goodsAmountLabel;

- (instancetype)initWithFrame:(CGRect)frame;

@end
