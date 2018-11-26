//
//  ShopCartKJAndHWView.h
//  Fcg
//
//  Created by huafanxiao on 2017/4/14.
//  Copyright © 2017年 zgntech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Fcgo_CartModel.h"

@interface ShopCartKJAndHWView : UIView

@property (nonatomic,strong) NSMutableArray *cartArray;

@property (nonatomic,copy)void(^buyBlock)(Fcgo_CartModel *model);
@property (nonatomic,copy)void(^selectItemBlock)(Fcgo_CartModel *model);
@property (nonatomic,copy)void(^refreshBlock)();

@property (nonatomic,strong) UITableView *tableview;
- (instancetype)initWithFrame:(CGRect)frame;

@end
