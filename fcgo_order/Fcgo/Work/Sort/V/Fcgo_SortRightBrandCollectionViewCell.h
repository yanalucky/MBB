//
//  Fcgo_SortRightBrandCollectionViewCell.h
//  Fcgo
//
//  Created by huafanxiao on 2017/5/23.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Fcgo_BrandModel.h"

@interface Fcgo_SortRightBrandCollectionViewCell :UICollectionViewCell

@property (nonatomic,strong) Fcgo_BrandModel *model;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end
