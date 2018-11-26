//
//  Fcgo_GoodsDetailBottomView.h
//  Fcgo
//
//  Created by huafanxiao on 2017/6/3.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Fcgo_GoodsDetailBottomButton.h"

typedef enum : NSUInteger {
    GoodsDetailTouchBuyType,  //点击商品
    GoodsDetailTouchAddCartType, //点击购物车
    GoodsDetailTouchCartType, //点击详情
    GoodsDetailTouchShowAddressType, //无货点击选择地区
    GoodsDetailTouchShowSoldOutType, //无货点击选择地区
    GoodsDetailTouchCollectType,
} GoodsDetailBottomType;

@interface Fcgo_GoodsDetailBottomView : UIView


@property (nonatomic,assign) NSInteger cartCount;
@property (nonatomic,assign) BOOL isFavourite;
@property (nonatomic,strong)  Fcgo_GoodsDetailBottomButton *collectBtn;
@property (nonatomic,copy) void(^didTouchBlock)(GoodsDetailBottomType touchType,BOOL isSelect);

@property (nonatomic,assign) BOOL   isSKU;//判断sku是否有数据
@property (nonatomic,assign) BOOL   isDefaultAddress;//判断是否是默认地址
@property (nonatomic,assign) BOOL   isSoldOut; //是否无货
@property (nonatomic,assign) BOOL   isIntegral;//抢购是否开始


@property (nonatomic,copy) NSString *imageString;

- (void)collectAnimation;
- (void)addCartAnimation;


@end
