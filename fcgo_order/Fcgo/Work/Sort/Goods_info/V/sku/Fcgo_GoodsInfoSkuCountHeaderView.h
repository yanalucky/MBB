//
//  Fcgo_GoodsInfoSkuCountHeaderView.h
//  Fcgo
//
//  Created by huafanxiao on 2017/12/27.
//  Copyright © 2017年 Fcg. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Fcgo_GoodsInfoSkuCountHeaderView : UICollectionReusableView

@property (nonatomic,strong) PPNumberButton *numberButton;
+ (instancetype)headViewWithCollectionView:(UICollectionView *)collectionView headIdentifier:(NSString *)headIdentifier forIndexPath:(NSIndexPath *)indexPath;
@end

