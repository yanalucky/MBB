//
//  Fcgo_HomeChoseSpecilCollectionCell.h
//  Fcgo
//
//  Created by huafanxiao on 2017/5/31.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Fcgo_HomeGoodsModel.h"
@interface Fcgo_HomeChoseSpecilCollectionCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *goodsImg;
@property (weak, nonatomic) IBOutlet UILabel *goodsName;
@property (weak, nonatomic) IBOutlet UILabel *goodsPrice;

@property (nonatomic,strong) Fcgo_HomeGoodsModel *model;

@end
