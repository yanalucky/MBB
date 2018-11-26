//
//  Fcgo_BasicTabVC.m
//  Fcgo
//
//  Created by huafanxiao on 2017/5/6.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_BasicTabVC.h"

#import "Fcgo_SortVC.h"
#import "Fcgo_MarketVC.h"
#import "Fcgo_CartVC.h"
#import "Fcgo_MineVCNew.h"
#import "Fcgo_HomeVCH5.h"

#import "Fcgo_AppDelegate.h"
#import "Fcgo_CartOfAddVC.h"
#import "Fcgo_AddressView.h"

@interface Fcgo_BasicTabVC ()

@end

@implementation Fcgo_BasicTabVC

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1];
    [self  initialize];

//    NSArray *tabBarItems = self.tabBar.items;
//    UITabBarItem *personCenterTabBarItem = [tabBarItems objectAtIndex:3];
//    personCenterTabBarItem.badgeValue = @"";
//    personCenterTabBarItem.badgeColor = UIFontRedColor;
    
}


- (void)initialize
{
    
    //修改tabbar颜色
    UIImageView *bgView = [[UIImageView alloc]initWithFrame:CGRectMake( 0, 0, kScreenWidth, kTabBarHeight)];
    bgView.backgroundColor = UIFontWhiteColor;
    [self.tabBar insertSubview:bgView atIndex:0];
    
    self.extendedLayoutIncludesOpaqueBars =YES;
    //改变字体颜色
    [[UITabBarItem appearance] setTitleTextAttributes:
     @{NSForegroundColorAttributeName:UIFontMainGrayColor}
                                             forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:
     @{NSForegroundColorAttributeName:UIFontRedColor}
                                             forState:UIControlStateSelected];
    [self setupViewControllers];
    
//    Fcgo_AddressView *addressView = [[Fcgo_AddressView alloc] init];
//    addressView.tag = 111111;
//    [self.view addSubview:addressView];
//    addressView.hidden = YES;
//    [addressView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.size.equalTo(self.view);
//        make.center.equalTo(self.view);
//    }];
}

- (void)setupViewControllers
{
//    Fcgo_HomeVC *homeVC = [[Fcgo_HomeVC alloc]init];
    Fcgo_HomeVCH5 *homeVC = [[Fcgo_HomeVCH5 alloc] init];

    homeVC.title = @"首页";
    homeVC.tabBarItem.image = [[UIImage  imageNamed:@"icon_home_tab_off"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    homeVC.tabBarItem.selectedImage = [[UIImage  imageNamed:@"icon_home_tab_on"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    Fcgo_SortVC  *sortVC = [[Fcgo_SortVC alloc]init];
    sortVC.title = @"分类";
    sortVC.tabBarItem.image = [[UIImage  imageNamed:@"icon_classify_tab_off"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    sortVC.tabBarItem.selectedImage = [[UIImage  imageNamed:@"icon_classify_tab_on"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    Fcgo_MarketVC *marketVC = [[Fcgo_MarketVC  alloc] init];
    marketVC.title = @"微商城";
    marketVC.tabBarItem.image = [[UIImage  imageNamed:@"icon_micro-mall_tab_off-"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    marketVC.tabBarItem.selectedImage = [[UIImage  imageNamed:@"icon_micro-mall_tab_on"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    Fcgo_CartOfAddVC *cartVC = [[Fcgo_CartOfAddVC alloc] init];
//    Fcgo_CartVC *cartVC = [[Fcgo_CartVC alloc]init];
//    cartVC.haveNavBar = NO;
    
    cartVC.title = @"购物车";
    cartVC.tabBarItem.image = [[UIImage imageNamed:@"icon_shopping-cart_tab_off"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    cartVC.tabBarItem.selectedImage = [[UIImage imageNamed:@"icon_shopping-cart_tab_on"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
//    Fcgo_MineVC *mineVC = [[Fcgo_MineVC alloc]init];
    Fcgo_MineVCNew *mineVC = [[Fcgo_MineVCNew alloc] init];
    mineVC.title = @"我的";
    mineVC.tabBarItem.image = [[UIImage  imageNamed:@"icon_my_tab_off"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    mineVC.tabBarItem.selectedImage = [[UIImage imageNamed:@"icon_my_tab_on"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    Fcgo_BasicNavVC *homeNav   = [[Fcgo_BasicNavVC  alloc]initWithRootViewController:homeVC];
   
    Fcgo_BasicNavVC *sortNav   = [[Fcgo_BasicNavVC  alloc]initWithRootViewController:sortVC];
    Fcgo_BasicNavVC *marketNav = [[Fcgo_BasicNavVC  alloc]initWithRootViewController:marketVC];
    Fcgo_BasicNavVC *cartNav   = [[Fcgo_BasicNavVC  alloc]initWithRootViewController:cartVC];
    Fcgo_BasicNavVC *mineNav   = [[Fcgo_BasicNavVC  alloc]initWithRootViewController:mineVC];
    
    homeNav.navigationBar.hidden   = 1;
    sortNav.navigationBar.hidden   = 1;
    marketNav.navigationBar.hidden = 1;
    cartNav.navigationBar.hidden   = 1;
    mineNav.navigationBar.hidden   = 1;

//    NSNumber *type = [Fcgo_UserTools shared].userDict[@"weixin"];
    NSArray    *viewControllersArray;
//    if (type.intValue == 1)
//    {
//             viewControllersArray = @[homeNav,sortNav,marketNav,cartNav,mineNav];
//    }else
//    {
       viewControllersArray = @[homeNav,sortNav,cartNav,mineNav];
//    }
    self.viewControllers = viewControllersArray;
    for (UIViewController *vc in self.viewControllers) {
        vc.tabBarItem.imageInsets = UIEdgeInsetsMake(-2, 0, 2, 0);
        vc.tabBarItem.titlePositionAdjustment = UIOffsetMake(0, -2);
    }
}


@end
