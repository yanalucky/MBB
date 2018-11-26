//
//  Fcgo_GoodsSKUVC.h
//  Fcgo
//
//  Created by huafanxiao on 2017/6/20.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Fcgo_GoodsInfoModel.h"
#import "Fcgo_BestSKUModel.h"

@interface Fcgo_GoodsSKUVC : UIViewController
//@property (nonatomic,assign) BOOL isAddCart;
@property (nonatomic,copy)   NSString *goodsType;
@property (nonatomic,strong) Fcgo_BestSKUModel *bestSKUModel;
@property (nonatomic,strong) Fcgo_GoodsInfoModel *infoModel;
@property (nonatomic,strong) NSMutableArray *attrArray;
@property (nonatomic,strong) NSMutableArray *saveAttrArray;
@property (nonatomic,copy) void(^selectAttrItemBlock)(NSString *properties_name,NSString *attr,BOOL isSelected,NSInteger count);//,BOOL addCart);

@property (nonatomic,copy) void(^selectCountBlock)(NSInteger count);

@property (nonatomic,copy) void(^lowerPriceBlock)(void);

@end
