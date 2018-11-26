//
//  Fcgo_AddressSelectedCell.h
//  Fcgo
//
//  Created by by_r on 2017/10/16.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Fcgo_AddressModel.h"
@interface Fcgo_AddressSelectedCell : UITableViewCell
@property (nonatomic, strong) Fcgo_AddressModel *model;
@property (nonatomic, copy) void(^open)(Fcgo_AddressModel *model);
@end
