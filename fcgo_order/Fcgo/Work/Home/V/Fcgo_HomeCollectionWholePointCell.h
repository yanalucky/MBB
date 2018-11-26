//
//  Fcgo_HomeCollectionWholePointCell.h
//  Fcgo
//
//  Created by huafanxiao on 2017/6/1.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Fcgo_HomeWholePointModel.h"

@interface Fcgo_HomeCollectionWholePointCell : UICollectionViewCell

@property (nonatomic,strong) Fcgo_HomeWholePointModel *wholePointModel;
@property (nonatomic,copy) void(^pushWholePointDetailVC)(void);
@property (nonatomic,copy) void(^timeFinishBlock)(void);


@end
