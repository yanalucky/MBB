//
//  Fcgo_GoodsDetailNavView.h
//  Fcgo
//
//  Created by huafanxiao on 2017/6/1.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    GoodsDetailTouchGoodsType,  //点击商品
    GoodsDetailTouchDetailType, //点击详情
} GoodsDetailTouchType;


@interface Fcgo_GoodsDetailNavView : UIView

@property (nonatomic,copy) void(^didTouchBlock)(GoodsDetailTouchType touchType);


@property (nonatomic,strong) UIColor *mainColor;
@property (nonatomic,assign) CGFloat scroll_x;
@property(nonatomic,strong)  UIScrollView   *scrollView;

@end
