//
//  Fcgo_Market_OrderManngerVC.m
//  Fcgo
//
//  Created by huafanxiao on 2017/8/2.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_Market_OrderManngerVC.h"

@interface Fcgo_Market_OrderManngerVC ()

@end

@implementation Fcgo_Market_OrderManngerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    WEAKSELF(weakSelf)
    [self.navigationView setupBackBtnBlock:^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    }];
    [self.navigationView setupTitleLabelWithTitle:@"订单管理"];
}

@end
