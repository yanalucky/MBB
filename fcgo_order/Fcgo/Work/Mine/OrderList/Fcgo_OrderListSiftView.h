//
//  Fcgo_OrderListSiftView.h
//  Fcgo
//
//  Created by by_r on 2017/10/24.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, OrderListShowType) {
    OrderStatusType_none = 0,
    OrderStatusType_search,
    OrderStatusType_sift,
};


@interface Fcgo_OrderListSiftView : UIView
@property (nonatomic,strong) NSMutableArray *siftArray;

@property (nonatomic,copy) void(^selectTradeItemBlock)(NSString *tradeId,NSString *type);
@property (nonatomic,copy) void(^selectCateItemBlock)(NSString *cateId,NSString *type);
@property (nonatomic,copy) void(^selectBrandItemBlock)(NSString *brandId,NSString *type);
@property (nonatomic,copy) void(^selectCatemItemBlock)(NSString *catemId,NSString *type);
@property (nonatomic,copy) void(^selectAttrItemBlock)(NSString *attr,NSString *type,BOOL isSelected);
@property (nonatomic,copy) void(^resetBlock)(void);

@property (nonatomic, copy) void(^searchBlock)(void);

- (void)show:(OrderListShowType)type;
@end
