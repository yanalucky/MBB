//
//  Fcgo_GoodsInfoSkuView.h
//  Fcgo
//
//  Created by huafanxiao on 2017/12/26.
//  Copyright © 2017年 Fcg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Fcgo_GoodsSkuModel.h"
#import "Fcgo_GoodsInfoMsgModel.h"
#import "Fcgo_GoodsPropertyModel.h"

typedef enum : NSUInteger {
    SkuViewAddCartType,  //普通商品
    SkuViewBuyType,
    SkuViewAddCartAndBuyType//活动商品
    
} SkuViewType;

@interface Fcgo_GoodsInfoSkuView : UIControl

@property (nonatomic,strong) Fcgo_GoodsSkuModel     *skuModel;
@property (nonatomic,strong) Fcgo_GoodsInfoMsgModel *infoModel;

@property (nonatomic,copy) void(^buyBlock)(void);
@property (nonatomic,copy) void(^addCartBlock)(void);
@property (nonatomic,copy) void(^lowerBlock)(void);
@property (nonatomic,copy) void(^selectedPropertyBlock)(NSString *attr,NSString *property,BOOL isSelected,NSInteger count);
@property (nonatomic,copy) void(^selectedCountBlock)(NSInteger count);

@property (nonatomic,copy) void(^reloadBlock)(void);

- (void)showWithType:(SkuViewType)type;
- (void)dismiss;
@end
