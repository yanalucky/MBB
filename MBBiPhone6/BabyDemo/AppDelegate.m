//
//  AppDelegate.m
//  BabyDemo
//
//  Created by 陈彦 on 16/2/26.
//  Copyright © 2016年 elsa. All rights reserved.
//

#import "AppDelegate.h"
#import "FirstViewController.h"
#import "LeftViewController.h"
#import "RickyNavViewController.h"
#import "CYAlertView.h"
#import "CYRecordAlertView.h"


#import "FirPageViewController.h"



#import <AlipaySDK/AlipaySDK.h>

//测试
#import "FillInfoViewController.h"

#import "UserDefaultsManager.h"
#import "NewAppViewController.h"


//友盟
#import "UMMobClick/MobClick.h"
//崩溃监测
#import <CrashMaster/CrashMaster.h>

@interface AppDelegate (){
    void(^_myBlock)(BOOL isSuccess);
}

@end

@implementation AppDelegate




+(AppDelegate *)sharedInstance{
    return (AppDelegate *)[UIApplication sharedApplication].delegate;
}
#pragma mark - 检测WiFi
/*
 - (void)checkNetworkState
{
    // 1.检测wifi状态
    Reachability *wifi = [Reachability reachabilityForLocalWiFi];
    
    // 2.检测手机是否能上网络
    Reachability *conn = [Reachability reachabilityForInternetConnection];
    
    
    // 3.判断网络状态
    if ([wifi currentReachabilityStatus] != NotReachable) {
        // 有wifi
        NSLog(@"有wifi");
        
        } else if ([conn currentReachabilityStatus] != NotReachable) {
            // 没有使用wifi, 使用手机自带网络进行上网
            NSLog(@"使用手机自带网络进行上网");
            
            CYRecordAlertView *alert = [self.window viewWithTag:9999];
            [alert alertViewWith:@"提示" andDetailTitle:@"当前非WiFi状态，可能会产生流量费用，确认下载？"  andButtonTitle:@"0"];
            [alert layoutSubviews];
            
            
            
        } else {
            // 没有网络
            NSLog(@"没有网络");

            
            CYRecordAlertView *alert = [self.window viewWithTag:9999];
            [alert alertViewWith:@"提示" andDetailTitle:@"当前无网络，无法打开！"  andButtonTitle:@"0"];
            [alert layoutSubviews];
        }
    
    
    
    
}

*/
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    UMConfigInstance.appKey = @"57c641d0e0f55a97b0004439";
    UMConfigInstance.channelId = nil;

    [MobClick startWithConfigure:UMConfigInstance];//配置以上参数后调用此方法初始化SDK！
    
    
    [CrashMaster  init:@"9550922801d131db81874475d5a84cf4" channel:nil config:[CrashMasterConfig defaultConfig]];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [UserDefaultsManager clearUserInfomation];
    
    // Override point for customization after application launch.
    /*
    FirstViewController *first = [[FirstViewController alloc] init];
    
    LeftViewController *left = [LeftViewController shareLeftViewController];
    RickyNavViewController *nav = [[RickyNavViewController alloc] initWithRootViewController:left];
    self.window.rootViewController = nav;
    */
    
    
    
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:CURRENTVERSION]) {
        
        FirPageViewController *rvc = [[FirPageViewController alloc] init];
        rvc.isAutoLogin = YES;
        rvc.isOverTime = YES;
        self.window.rootViewController = rvc;
        
        
       
    }else{
        
        [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"manyOfMainView"];
        [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"manyOfRecordStar"];
        [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"manyOfPG"];
        [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"manyOfRecordLength"];
        [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"manyOfFeed"];
        
        [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"commentted"];
        [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"numOfseeNurture"];
        [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"needFillInRecord"];
        [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"needFillInFeature"];
        [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"arcrandom"];

        [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"city"];
        
        NewAppViewController *nvc = [[NewAppViewController alloc] init];
        self.window.rootViewController = nvc;
    }
   
    
  
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    
    
    /*
    for(NSString *fontfamilyname in [UIFont familyNames])
    {
        NSLog(@"family:'%@'",fontfamilyname);
        for(NSString *fontName in [UIFont fontNamesForFamilyName:fontfamilyname])
        {
            NSLog(@"\tfont:'%@'",fontName);
        }
        NSLog(@"-------------");
    }
    */
    
    
    
    
    

#pragma mark - 登录纯文字
    
    CYAlertView *alertBgView = [[CYAlertView alloc] init];
    alertBgView.tag = 8888;
    
    alertBgView.hidden = YES;
    
    [self.window addSubview:alertBgView];
    

    [alertBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.window);
        make.width.and.height.equalTo(self.window);
    }];
    
    
#pragma mark - 记录的弹出框
    CYRecordAlertView *recordAlertView = [[CYRecordAlertView alloc] init];
    recordAlertView.tag = 9999;
    recordAlertView.hidden = YES;
    
    [self.window addSubview:recordAlertView];
    
    
    [recordAlertView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.window);
        make.width.and.height.equalTo(self.window);
    }];
    
    
#pragma mark - 自定义弹出框
    UIView *CYView = [[UIView alloc] init];
    CYView.tag = 6666;
    CYView.backgroundColor = [UIColor colorWithRed:120/255.0 green:120/255.0 blue:120/255.0 alpha:0.3];
    CYView.hidden = YES;
    [self.window addSubview:CYView];
    [CYView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.window);
        make.width.and.height.equalTo(self.window);
    }];
    
    
    
//    [self checkNetworkState];
    

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


- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    
    if ([url.host isEqualToString:@"safepay"]) {
        //跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
            NSString *result = [resultDic objectForKey:@"result"];
            id  resultStatus = [resultDic objectForKey:@"resultStatus"];
            if (([resultStatus intValue] == 9000)&&[result containsString:@"&success=\"true\""]) {
                NSLog(@"支付成功！");
                
                _myBlock(YES);
                
//                self.window.rootViewController presentViewController:<#(nonnull UIViewController *)#> animated:<#(BOOL)#> completion:<#^(void)completion#>

            }else{
                _myBlock(NO);
            }
        }];
    }
    return YES;
}

// NOTE: 9.0以后使用新API接口
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options
{
    if ([url.host isEqualToString:@"safepay"]) {
        //跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
            NSString *result = [resultDic objectForKey:@"result"];
            id  resultStatus = [resultDic objectForKey:@"resultStatus"];
            if (([resultStatus intValue] == 9000)&&[result containsString:@"&success=\"true\""]) {
                NSLog(@"支付成功！");
                
               _myBlock(YES);
                
                
            }else{
                _myBlock(NO);
            }
        }];
    }
    return YES;
}

-(void)zhifubaoBackBlock:(void (^)(BOOL))backBlock{
    
    _myBlock = [backBlock copy];
    
    
}


@end
