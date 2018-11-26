//
//  Fcgo_AlertAnimationView.h
//  Fcgo
//
//  Created by huafanxiao on 2017/6/9.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Fcgo_AlertAnimationView : UIView

@property (nonatomic,copy) void(^confirmBlick)(void);
@property (nonatomic,copy) void(^cancelBlick)(void);
+ (instancetype)showWithTitle:(NSString *)title text:(NSString *)text cancelTitle:(NSString *)cancel confirmTitle:(NSString *)confirm block:(void(^)(void))confirmBlick;

+ (instancetype)showWithTitle:(NSString *)title text:(NSString *)text cancelTitle:(NSString *)cancel confirmTitle:(NSString *)confirm cancelBlock:(void(^)(void))cancelBlick block:(void(^)(void))confirmBlick;

@end
