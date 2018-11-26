//
//  Fcgo_HelpCenterVC.m
//  Fcgo
//
//  Created by huafanxiao on 2017/5/23.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_HelpCenterVC.h"

@interface Fcgo_HelpCenterVC ()

@end

@implementation Fcgo_HelpCenterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    WEAKSELF(weakSelf)
    [self.navigationView setupBackBtnBlock:^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    }];
    [self.navigationView setupTitleLabelWithTitle:@"帮助中心"];
}

@end
