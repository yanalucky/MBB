//
//  Fcgo_MarketTopCell.h
//  Fcgo
//
//  Created by huafanxiao on 2017/8/2.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Fcgo_MarketButton.h"

@interface Fcgo_MarketTopCell : UICollectionViewCell
@property (nonatomic,copy) void(^shareBlock)(void);
@end
