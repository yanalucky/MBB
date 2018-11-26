//
//  Fcgo_SiftMainView.h
//  Fcgo
//
//  Created by huafanxiao on 2017/6/9.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Fcgo_SiftMainView : UIView

@property (nonatomic,strong) NSMutableArray *siftArray;

@property (nonatomic,copy) void(^selectTradeItemBlock)(NSString *tradeId,NSString *type);
@property (nonatomic,copy) void(^selectCateItemBlock)(NSString *cateId,NSString *type);
@property (nonatomic,copy) void(^selectBrandItemBlock)(NSString *brandId,NSString *type);
@property (nonatomic,copy) void(^selectCatemItemBlock)(NSString *catemId,NSString *type);
@property (nonatomic,copy) void(^selectAttrItemBlock)(NSString *attr,NSString *type,BOOL isSelected);

@property (nonatomic,copy) void(^confirmBlock)(void);
@property (nonatomic,copy) void(^resetBlock)(void);

@end
