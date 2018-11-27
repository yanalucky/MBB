//
//  RickyNavViewController.m
//  BabyDemo
//
//  Created by 王保霖 on 16/3/9.
//  Copyright © 2016年 elsa. All rights reserved.
//

#import "RickyNavViewController.h"

@interface RickyNavViewController ()<UIGestureRecognizerDelegate>

@end

@implementation RickyNavViewController

//这个方法只会调用一次
+ (void)initialize
{
    //UINavigationBar的appearance 可以修改全部的UINavigationBar
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont yaHeiFontOfSize:17*Ratio];
    attrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
    
    
    UINavigationBar *bar =[UINavigationBar appearance];
//    [bar setBarTintColor:[UIColor colorWithRed:239/255.0 green:67/255.0 blue:153/255.0 alpha:1]];
//    [bar setBarTintColor:MBColor(239, 67, 153, 1)];
    [bar setBackgroundImage:[[UIImage imageNamed:@"nav_bar"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forBarMetrics:UIBarMetricsDefault];
    bar.titleTextAttributes = attrs;
    
//    [bar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    bar.shadowImage = [[UIImage alloc] init];
  
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.interactivePopGestureRecognizer.enabled = YES;
    __weak typeof (self) weakSelf = self;
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.delegate = weakSelf;
    }
}


-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{

    
    //重些Push方法,这样只要不是第一层,push的下一个界面都隐藏了Tabbar
    if(self.childViewControllers.count>0){
    
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [button setTitle:@"返回" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        
        [button setImage:[[UIImage imageNamed:@"back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
        [button setImage:[[UIImage imageNamed:@"back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateHighlighted];
        button.frame = CGRectMake(0, 0, 11.5, 20);
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        
        
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button];
//        viewController.navigationItem.leftBarButtonItem.image = [UIImage imageNamed:@"back"];
        //隐藏tabbar
        viewController.hidesBottomBarWhenPushed = YES;
    }
  
    [super pushViewController:viewController animated:animated];
}
-(void)back{
    [super popViewControllerAnimated:YES];

}


- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    return YES;

}


-(UIStatusBarStyle)preferredStatusBarStyle{
    
    return  UIStatusBarStyleLightContent;
}



@end
