//
//  Fcgo_OrderDetailBottomTableViewCell.h
//  Fcgo
//
//  Created by huafanxiao on 2017/5/25.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Fcgo_OrderDetailModel.h"


@interface Fcgo_OrderDetailBottomTableViewCell : UITableViewCell

- (void)setupWithModel:(Fcgo_OrderDetailModel *)model Index:(NSInteger)index;

@end
