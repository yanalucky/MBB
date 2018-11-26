//
//  AppDelegate.h
//  Fcgo
//
//  Created by huafanxiao on 2017/5/8.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Fcgo_BasicTabVC.h"

@interface Fcgo_AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) Fcgo_BasicTabVC *tabVC;
- (void)setupRootVC;
- (void)setTabarVCToRootVC;
- (void)setLoginVCToRootVC;

@end

