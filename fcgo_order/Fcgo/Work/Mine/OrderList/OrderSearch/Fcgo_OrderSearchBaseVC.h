//
//  Fcgo_OrderSearchBaseVC.h
//  Fcgo
//
//  Created by by_r on 2017/11/28.
//  Copyright © 2017年 Fcg. All rights reserved.
//

#import "Fcgo_BasicVC.h"
#import "Fcgo_AllOrderView.h"
@interface Fcgo_OrderSearchBaseVC : Fcgo_BasicVC
@property (nonatomic, strong) Fcgo_AllOrderView     *allOrderView;
@property (nonatomic, assign) NSInteger         page;
- (void)setupUI;
/// 刷新数据 isTop扩展字段，暂未用到
- (void)refresh:(BOOL)isTop;
- (void)showUIData:(BOOL)isShow;
- (void)showMoreUIData:(BOOL)isShow;
@end
