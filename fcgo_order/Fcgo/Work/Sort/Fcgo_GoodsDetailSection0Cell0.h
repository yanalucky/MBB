//
//  Fcgo_GoodsDetailSection0Cell0.h
//  Fcgo
//
//  Created by huafanxiao on 2017/6/3.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Fcgo_GoodsInfoModel.h"
#import "Fcgo_BestSKUModel.h"
@interface Fcgo_GoodsDetailSection0Cell0 : UITableViewCell
@property (nonatomic,copy)   NSString *goodsType;
@property (nonatomic,strong) Fcgo_GoodsInfoModel *infoModel;
@property (nonatomic,strong) Fcgo_BestSKUModel *bestSKUModel;

@property (nonatomic,assign) CGFloat height;

@end
