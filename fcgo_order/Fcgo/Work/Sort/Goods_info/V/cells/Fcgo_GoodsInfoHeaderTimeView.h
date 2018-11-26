//
//  Fcgo_GoodsInfoHeaderTimeView.h
//  Fcgo
//
//  Created by huafanxiao on 2017/12/28.
//  Copyright © 2017年 Fcg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Fcgo_GoodsInfoMsgModel.h"
@interface Fcgo_GoodsInfoHeaderTimeView : UITableViewHeaderFooterView
@property (nonatomic,strong) Fcgo_GoodsInfoMsgModel *infoModel;
@property (nonatomic,copy) void(^reloadBlock)(void);
+ (instancetype)headViewWithTableView:(UITableView *)tableView headIdentifier:(NSString *)headIdentifier;
@end
