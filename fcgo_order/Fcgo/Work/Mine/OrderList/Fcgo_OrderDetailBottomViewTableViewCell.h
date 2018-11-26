//
//  Fcgo_OrderDetailBottomViewTableViewCell.h
//  Fcgo
//
//  Created by huafanxiao on 2017/5/25.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Fcgo_OrderDetailBottomViewTableViewCell : UITableViewCell

@property (nonatomic,assign) OrderStatusType      statusType;
@property (nonatomic,assign) NSInteger       orderType;

@property(nonatomic,copy) void (^payBlock)(void);
@property(nonatomic,copy) void (^cancelBlock)(void);
@property(nonatomic,copy) void (^serviceBlock)(void);
@property(nonatomic,copy) void (^remindBlock)(void);
@property(nonatomic,copy) void (^againBlock)(void);

@property (nonatomic,copy) void(^signBlock)(void);
@end
