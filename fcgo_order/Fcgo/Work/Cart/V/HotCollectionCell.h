//
//  HotCollectionCell.h
//  Fcg
//
//  Created by huafanxiao on 2017/3/29.
//  Copyright © 2017年 zgntech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Fcgo_HomeGoodsModel.h"


@interface HotCollectionCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *goodsImg;
@property (weak, nonatomic) IBOutlet UIImageView *leftTopImg;
@property (weak, nonatomic) IBOutlet UILabel *leftTopLabel;
@property (weak, nonatomic) IBOutlet UIView *line;


@property (weak, nonatomic) IBOutlet UILabel *goodsName;
@property (weak, nonatomic) IBOutlet UILabel *goodsDesLabel;
@property (weak, nonatomic) IBOutlet UILabel *goodsPrice;
@property (weak, nonatomic) IBOutlet UILabel *goodsSalePrice;

@property (nonatomic,strong) NSDictionary *dict;
@property (nonatomic,strong) Fcgo_HomeGoodsModel *goodsModel;
- (void)setGoodsDesLableHieghtIndex:(NSInteger )item;



@end
