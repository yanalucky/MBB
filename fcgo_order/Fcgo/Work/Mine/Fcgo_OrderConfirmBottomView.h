//
//  Fcgo_OrderConfirmBottomView.h
//  Fcgo
//
//  Created by huafanxiao on 2017/6/12.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Fcgo_OrderConfirmBottomView : UIView

@property (nonatomic,strong) UILabel  *freightLabel;
@property (nonatomic,strong) UILabel  *totalLabel;
@property (nonatomic,strong) UILabel  *total;

@property (nonatomic,copy) NSString   *totalString;
@property (nonatomic,copy) void(^submitBlock)();
- (void)showWithAnimation;

@end
