//
//  Fcgo_OrderDetailBottomView.h
//  Fcgo
//
//  Created by huafanxiao on 2017/5/25.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Fcgo_OrderDetailBottomView : UIView

@property (nonatomic,assign) NSInteger orderType;

@property(nonatomic,copy) void (^payBlock)(void);
@property(nonatomic,copy) void (^cancelBlock)(void);
@property(nonatomic,copy) void (^serviceBlock)(void);
@property(nonatomic,copy) void (^remindBlock)(void);
@property(nonatomic,copy) void (^againBlock)(void);
@property (nonatomic,copy) void(^signBlock)(void);

- (instancetype)initWithFrame:(CGRect)frame;

- (void)showWithAnimation;

@end
