//
//  Fcgo_AddressPickerView.h
//  Fcgo
//
//  Created by huafanxiao on 2017/6/5.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Fcgo_AddressPickerView : UIControl

@property (nonatomic,copy) void(^addressBlock)(NSMutableDictionary *addressDict);

+ (void)showPickerWithSelectAddressBlock:(void(^)(NSMutableDictionary *addressDict))addressBlock;


@end
