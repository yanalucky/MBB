//
//  Fcgo_WholePointDetailView.h
//  Fcgo
//
//  Created by huafanxiao on 2017/6/13.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Fcgo_WholePointGoodsModel.h"
#import "Fcgo_WholePointModel.h"
@interface Fcgo_WholePointDetailView : UIView

@property (nonatomic,assign) WholePointType type;
@property (nonatomic,strong) Fcgo_WholePointModel *model;
@property (nonatomic,copy)   void(^selectedBlock)(Fcgo_WholePointGoodsModel *goodsModel);
@property (nonatomic,copy)   void(^timeFinishBlock)(void);

- (void)reloadTableDataWithModel:(Fcgo_WholePointModel *)model type:(WholePointType)type1;

@end
