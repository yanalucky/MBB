//
//  Fcgo_CalendarTools.h
//  Fcgo
//
//  Created by huafanxiao on 2017/6/22.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <EventKit/EventKit.h>
#import "Fcgo_WholePointGoodsModel.h"
#import "Fcgo_WholePointModel.h"
//整点抢提醒tools
@interface Fcgo_CalendarTools : NSObject

@property (nonatomic,strong) EKEventStore *eventStore;

+ (Fcgo_CalendarTools *)shared;

- (void)saveEventwithWholePointModel:(Fcgo_WholePointModel *)model goodsModel:(Fcgo_WholePointGoodsModel *)goodsModel  block:(void(^)(void))block;
- (void)deleteEventwithWholePointModel:(Fcgo_WholePointModel *)model goodsModel:(Fcgo_WholePointGoodsModel *)goodsModel  block:(void(^)(void))block;
@end
