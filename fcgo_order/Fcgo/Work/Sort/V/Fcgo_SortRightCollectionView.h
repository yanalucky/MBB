//
//  Fcgo_SortRightCollectionView.h
//  Fcgo
//
//  Created by huafanxiao on 2017/5/23.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Fcgo_SortModel.h"

@interface Fcgo_SortRightCollectionView : UIView

@property (nonatomic,strong) Fcgo_SortModel *sortModel;

@property (nonatomic,copy)   void(^didSelectHeaderBlock)(Fcgo_SortModel *sortModel);
@property (nonatomic,copy)   void(^didSelectCateBlock)(Fcgo_CateModel *model);
@property (nonatomic,copy)   void(^didSelectBrandBlock)(Fcgo_SortModel *sortModel,Fcgo_BrandModel *model);
@property (nonatomic,copy)   void(^gotTotalBrandBlock)();

@end
