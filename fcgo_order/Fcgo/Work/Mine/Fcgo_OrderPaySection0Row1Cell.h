//
//  Fcgo_OrderPaySection0Row1Cell.h
//  Fcgo
//
//  Created by huafanxiao on 2017/6/12.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Fcgo_OrderPayModel.h"

@interface Fcgo_OrderPaySection0Row1Cell : UITableViewCell

@property (nonatomic,strong) Fcgo_OrderPayModel *model;
@property (nonatomic,copy) void(^timeFinishBlock)(void);
@end
