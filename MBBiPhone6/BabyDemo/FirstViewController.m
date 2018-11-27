//
//  FirstViewController.m
//  BabyDemo
//
//  Created by 陈彦 on 16/2/26.
//  Copyright © 2016年 elsa. All rights reserved.
//

#import "FirstViewController.h"
#import "MainViewController.h"
#import "RecordViewController.h"
#import "CommentViewController.h"
#import "BringViewController.h"
#import "Masonry.h"
#import "RickyNavViewController.h"
#import "RickyTabBar.h"


@interface FirstViewController (){
    UIView *_tabBarView;
    UIView *_slideView;
}

@end

@implementation FirstViewController


//这个函数只会调用一次
+ (void)initialize
{
    // 通过appearance统一设置所有UITabBarItem的文字属性
    //设置字体
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont yaHeiFontOfSize:9*Ratio];
    attrs[NSForegroundColorAttributeName] = [UIColor colorWithRed:151/255.0 green:151/255.0 blue:151/255.0 alpha:1];
    
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSFontAttributeName] = attrs[NSFontAttributeName];
    selectedAttrs[NSForegroundColorAttributeName] = [UIColor colorWithRed:239/255.0 green:67/255.0 blue:153/255.0 alpha:1];
    
    NSMutableDictionary *highlightAttrs = [NSMutableDictionary dictionary];
    highlightAttrs[NSFontAttributeName] = attrs[NSFontAttributeName];
    highlightAttrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
    
    //UITabBarItem的appearance
    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:attrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
    [item setTitleTextAttributes:highlightAttrs forState:UIControlStateHighlighted];
    
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self createViewControllers];

}


-(void)createViewControllers{
    
    MainViewController *mvc = [[MainViewController alloc] init];
    RecordViewController *rvc = [[RecordViewController alloc] init];
    CommentViewController *cvc = [[CommentViewController alloc] init];
    BringViewController *bvc = [[BringViewController alloc] init];
    NSArray *arr = @[@"首页",@"记录",@"评估",@"养育指导"];
    NSArray *vcArr = @[mvc,rvc,cvc,bvc];
    for (int i=0; i<[arr count]; i++) {
        [self setupChildVc:vcArr[i] title:arr[i] image:[NSString stringWithFormat:@"tabbar_%.2d",i+1] selectedImage:[NSString stringWithFormat:@"tabbar_sel%.2d",i+1]];

    }
    
    
    
    //替换Tabbar
    [self setValue:[[RickyTabBar alloc] init] forKeyPath:@"tabBar"];
}


/**
 * 初始化子控制器
 */
- (void)setupChildVc:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    // 设置文字和图片
     vc.tabBarItem = [[UITabBarItem alloc]initWithTitle:title image:[[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
//    vc.navigationItem.title = title;
//    vc.tabBarItem.title = title;
//    vc.tabBarItem.image = [UIImage imageNamed:image];
//    vc.tabBarItem.selectedImage = [UIImage imageNamed:selectedImage];
    
    RickyNavViewController *nav = [[RickyNavViewController alloc] initWithRootViewController:vc];
    vc.title = title;
    [self addChildViewController:nav];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
