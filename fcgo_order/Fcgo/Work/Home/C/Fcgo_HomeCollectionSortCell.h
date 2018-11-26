//
//  Fcgo_HomeCollectionSortCell.h
//  Fcgo
//
//  Created by huafanxiao on 2017/5/31.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Fcgo_HomeSortIconModel;

typedef void(^SortIconBlock)(Fcgo_HomeSortIconModel *sortIconModel);
@interface Fcgo_HomeCollectionSortCell : UICollectionViewCell

@property (nonatomic,strong) NSMutableArray *sortIconArray;
@property (nonatomic,copy)   SortIconBlock   sortIconBlock;

@end

