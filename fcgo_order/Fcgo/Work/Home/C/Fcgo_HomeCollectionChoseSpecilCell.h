//
//  Fcgo_HomeCollectionChoseSpecilCell.h
//  Fcgo
//
//  Created by huafanxiao on 2017/5/31.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Fcgo_HomeTopicModel.h"
#import "Fcgo_HomeGoodsModel.h"
@interface Fcgo_HomeCollectionChoseSpecilCell : UICollectionViewCell

@property (nonatomic,strong) Fcgo_HomeTopicModel *model;
@property (nonatomic,copy)   void(^specialBlock)(Fcgo_HomeTopicModel *model);
@property (nonatomic,copy)   void(^selectItemBlock)(Fcgo_HomeGoodsModel *model);

@end
