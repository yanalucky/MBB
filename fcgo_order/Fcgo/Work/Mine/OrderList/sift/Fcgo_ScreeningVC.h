//
//  Fcgo_ScreeningVC.h
//  Fcgo
//
//  Created by by_r on 2017/11/28.
//  Copyright © 2017年 Fcg. All rights reserved.
//

#import "Fcgo_BasicVC.h"

static NSString *kTitle = @"title";
static NSString *kValue = @"value";
static NSString *kList  = @"list";
static NSString *kType = @"type";
static NSString *kYear = @"year";
static NSString *kMonth = @"month";
static NSString *kDay = @"day";
static NSString *kTypeTexe = @"texe";
static NSString *kTypeStart = @"payTimeStart";

@protocol Fcgo_ScreeningVCDelegate <NSObject>
//确定代理
- (void)determineButtonTouchEvent:(NSDictionary *)dictionary;

@end

@interface Fcgo_ScreeningVC : UIViewController
@property (assign, nonatomic) CGFloat width;
@property (assign, nonatomic) id<Fcgo_ScreeningVCDelegate> delegate;
@property (nonatomic, strong) NSMutableArray    *listArray;
/// 加载数据
- (void)resetButtonAction;
@end
