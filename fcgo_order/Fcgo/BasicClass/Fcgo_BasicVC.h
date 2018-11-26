//
//  Fcgo_BasicVC.h
//  Fcgo
//
//  Created by huafanxiao on 2017/5/6.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Fcgo_NavigationView.h"

@interface Fcgo_BasicVC : UIViewController

@property (nonatomic,strong) Fcgo_NavigationView  *navigationView;

- (void)showNoControl:(BOOL)showNoControl titleString:(NSString *)title imageString:(NSString *)image;

- (void)updateNoControlFrame;

- (void)reloadRequest;

@end
