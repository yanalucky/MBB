//
//  Fcgo_BasicVC.m
//  Fcgo
//
//  Created by huafanxiao on 2017/5/6.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_BasicVC.h"
#import "Fcgo_BrokenNetworkOrNoDataControl.h"
#import "UMMobClick/MobClick.h"
@interface Fcgo_BasicVC ()

@property (nonatomic,strong) Fcgo_BrokenNetworkOrNoDataControl *noControl;

@end

@implementation Fcgo_BasicVC

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:NSStringFromClass([self class])];
    [WSProgressHUD dismiss];

}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:NSStringFromClass([self class])];//("PageOne"为页面名称，可自定义)
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self setupBasicUI];

}

- (void)setupBasicUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    WEAKSELF(weakSelf)
    //断网时的背景
    [self.view addSubview:self.noControl];
    self.noControl.reloadBlock = ^{
        [weakSelf reloadRequest];
    };
   //添加导航条
    [self.view addSubview:self.navigationView];
}

- (void)reloadRequest
{
    
}

- (void)showNoControl:(BOOL)showNoControl titleString:(NSString *)title imageString:(NSString *)image
{
    if (showNoControl) {
        self.noControl.hidden = 0;
        self.noControl.imageString = image;
        self.noControl.titleString = title;
    }
    else{
        self.noControl.hidden = 1;
    }
}

- (void)updateNoControlFrame
{
    self.noControl.frame = CGRectMake(0, 0, kScreenWidth, KScreenHeight);
}

#pragma mark Lazy method

- (Fcgo_NavigationView *)navigationView
{
    if (!_navigationView) {
        _navigationView = [[Fcgo_NavigationView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kNavigationHeight)];
    }
    return _navigationView;
}

- (Fcgo_BrokenNetworkOrNoDataControl *)noControl
{
    if (!_noControl) {
        _noControl = [[Fcgo_BrokenNetworkOrNoDataControl alloc]initWithFrame:CGRectMake(0, kNavigationHeight, kScreenWidth, KScreenHeight - kNavigationHeight)];
        _noControl.hidden = 1;
    }
    return _noControl;
}

@end
