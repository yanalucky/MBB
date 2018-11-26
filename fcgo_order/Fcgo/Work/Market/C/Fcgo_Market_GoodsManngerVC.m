//
//  Fcgo_Market_GoodsManngerVC.m
//  Fcgo
//
//  Created by huafanxiao on 2017/8/2.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_Market_GoodsManngerVC.h"

@interface Fcgo_Market_GoodsManngerVC ()

@end

@implementation Fcgo_Market_GoodsManngerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    WEAKSELF(weakSelf)
    [self.navigationView setupBackBtnBlock:^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    }];
    [self.navigationView setupTitleLabelWithTitle:@"商品管理"];
}

@end
