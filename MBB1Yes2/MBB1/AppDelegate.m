//
//  AppDelegate.m
//  MBB1
//
//  Created by 陈彦 on 15/9/1.
//  Copyright (c) 2015年 elsa. All rights reserved.
//

#import "AppDelegate.h"
#import "UIImageView+WebCache.h"
#import "CYAlertView.h"
#import "CYOverRunView.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
//    if (IOS7_OR_LATER) { // 判断是否是IOS7
//        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
//    }
    
    
    UIView *statusBarView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 20)];
    
    statusBarView.backgroundColor=[UIColor whiteColor];
    
    [self.window addSubview:statusBarView];
    
    
    
    
    
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
    _sex = ISBOY;
    
    
    CYAlertView *alertBgView = [[CYAlertView alloc] initWithFrame:self.window.bounds];
    alertBgView.tag = 8888;

    alertBgView.hidden = YES;
    [self.window addSubview:alertBgView];
    CYOverRunView *overRunView = [[CYOverRunView alloc] initWithFrame:self.window.bounds];
    overRunView.tag = 999;
    overRunView.hidden = YES;
    
    [self.window addSubview:overRunView];
    
    
    
    // Override point for customization after application launch.
    return YES;
}






- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationLandscapeRight||interfaceOrientation == UIInterfaceOrientationLandscapeLeft);
    
}
-(UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window{
    
    return UIInterfaceOrientationMaskAll;
}



-(BOOL)shouldAutorotate{
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
