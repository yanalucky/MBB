//
//  Fcgo_GoodsInfoNavigationView.h
//  Fcgo
//
//  Created by huafanxiao on 2017/12/25.
//  Copyright © 2017年 Fcg. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Fcgo_GoodsInfoNavigationView : UIView

typedef enum : NSUInteger{
    SelectedGoodsMsgType,     //点击商品信息
    SelectedGoodsDetailType, //点击商品详情描述
} GoodsInfoSelectedNavigationButtonType;

@property (nonatomic,copy) void(^selectedGoodsTypeBlock)(GoodsInfoSelectedNavigationButtonType selectedType);


@property (nonatomic,assign) CGFloat scroll_x;//从外部传来的scrollview的x的偏移量，来控制line的横线移动动画
@property (nonatomic,assign) BOOL scrollPage;//从外部传来的scrollview的y的偏移量页数，来控制和商品按钮详情按钮与商品详情上下移动动画

@property (nonatomic,strong) UIColor *subviewsColor;//设置背景颜色

@end
