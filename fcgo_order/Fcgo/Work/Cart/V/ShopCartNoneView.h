//
//  ShopCartNoneView.h
//  Fcg
//
//  Created by huafanxiao on 2017/4/13.
//  Copyright © 2017年 zgntech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Fcgo_HomeGoodsModel.h"

@interface ShopCartNoneView : UIView

@property (nonatomic,strong) NSMutableArray * goodsNewArray;
@property (nonatomic,strong) UICollectionView *collectionview;
@property (nonatomic,copy)void(^goToVisit)();
@property (nonatomic,copy)void(^selectItemBlock)(Fcgo_HomeGoodsModel *model);
@property (nonatomic,copy)void(^refreshBlock)(void);
- (instancetype)initWithFrame:(CGRect)frame;

@end
