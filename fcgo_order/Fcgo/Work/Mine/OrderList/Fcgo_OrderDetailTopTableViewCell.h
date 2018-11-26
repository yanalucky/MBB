//
//  Fcgo_OrderDetailTopTableViewCell.h
//  Fcgo
//
//  Created by huafanxiao on 2017/5/25.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Fcgo_OrderDetailModel.h"


@interface Fcgo_OrderDetailTopTableViewCell : UITableViewCell

@property (nonatomic,strong) Fcgo_OrderDetailModel *model;
@property (nonatomic,copy) void(^timeFinishBlock)(void);

@end
