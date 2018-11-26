//
//  Fcgo_ExterAddressPickerView.h
//  Fcgo
//
//  Created by huafanxiao on 2017/6/7.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Fcgo_ExterAddressPickerView : UIControl

@property (nonatomic,copy) void(^addressBlock)(NSMutableDictionary *addressDict);

- (instancetype)initWithFrame:(CGRect)frame selectAddressBlock:(void(^)(NSMutableDictionary *addressDict))addressBlock;

- (void)hide;
- (void)show;

@end
