//
//  Fcgo_GoodsInfoBottomView.h
//  Fcgo
//
//  Created by huafanxiao on 2017/12/25.
//  Copyright © 2017年 Fcg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Fcgo_GoodsInfoBottomButton.h"
#import "Fcgo_GoodsSkuModel.h"
#import "Fcgo_GoodsInfoMsgModel.h"



typedef enum : NSUInteger {
    GoodsInfoBottomViewSelectedCollectType, //点击收藏
    GoodsInfoBottomViewSelectedPushCartType,//点击购物车
    GoodsInfoBottomViewSelectedAddCartType, //加入购物车
    GoodsInfoBottomViewSelectedBuyType,     //点击购买
    GoodsInfoBottomViewSelectedAddressType,//活动按钮
} GoodsInfoBottomViewSelectedType;

@interface Fcgo_GoodsInfoBottomView : UIView

//判断是否是活动商品，活动商品没有加入购物车按钮

@property (nonatomic,strong) Fcgo_GoodsSkuModel     *skuModel;
@property (nonatomic,strong) Fcgo_GoodsInfoMsgModel *infoModel;

//以下都是数据返回传的
@property (nonatomic,assign) NSInteger cartCount;//购物车数量
@property (nonatomic,assign) BOOL collect;//是否收藏

@property (nonatomic,copy) void(^selectedTypeBlock)(GoodsInfoBottomViewSelectedType selectedType,BOOL isSelect);

- (void)collectAnimation;
- (void)addCartAnimation;

@end
