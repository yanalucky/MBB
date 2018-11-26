//
//  AppDelegate.m
//  Fcgo
//
//  Created by huafanxiao on 2017/5/8.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_AppDelegate.h"
#import "Fcgo_LoginVC.h"
#import "Fcgo_LeadVC.h"
#import "Fcgo_GoodsDetailVC.h"
#import "Fcgo_LaunchAdTools.h"

#import <CloudPushSDK/CloudPushSDK.h>
// iOS 10 notification
#import <UserNotifications/UserNotifications.h>

#import <VasSonic/Sonic.h>

#import <Bugly/Bugly.h>

#import "UMMobClick/MobClick.h"

static NSString *const testAppKey = @"23721732";
static NSString *const testAppSecret = @"bfd2b578a3b01cf478df09662991cccf";

//static NSString *const testAppKey = @"24717010";
//static NSString *const testAppSecret = @"cc8afd49a6adcaac291310e165109006";

@interface Fcgo_AppDelegate ()<WXApiDelegate,UNUserNotificationCenterDelegate>
{
    // iOS 10通知中心
    UNUserNotificationCenter *_notificationCenter;
}
@end

@implementation Fcgo_AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    application.applicationIconBadgeNumber = 0;
    [self clearURLCacheAndHTTPCookie];
    [self registVendorsApplication:application options:launchOptions];
    [self setupWindow];
    [self setupRootVC];
    return YES;
}

- (void)clearURLCacheAndHTTPCookie
{
    // 清除缓存
    NSURLCache *cache = [NSURLCache sharedURLCache];
    [cache removeAllCachedResponses];
    [cache setDiskCapacity:0];
    [cache setMemoryCapacity:0];
    // 清除cookies
    NSHTTPCookie *cookie;
    NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (cookie in [storage cookies]) {
        [storage deleteCookie:cookie];
    }
}

- (void)registVendorsApplication:(UIApplication *)application options:(NSDictionary *)launchOptions
{
    //阿里推送
    {
        // APNs注册，获取deviceToken并上报
        [self registerAPNS:application];
        // 初始化SDK
        [self initCloudPush];
        // 监听推送消息到达
        [self registerMessageReceive];
        
        [CloudPushSDK sendNotificationAck:launchOptions];
    }
    //微信支付
    {
        [WXApi  registerApp:@"wx4771dbbe833f781e"];
    }
    // 七鱼云
    {
        [[QYSDK sharedSDK] registerAppId:@"99d239f9b0b7e856cba20f618a111a9b" appName:@"备货通"];
         // 客服聊天页面不使用IQKeyboard
        [[IQKeyboardManager sharedManager].disabledDistanceHandlingClasses addObject:[QYSessionViewController class]];
    }
    /*
    //友盟
    {
        UMConfigInstance.appKey = @"59253e3ac895761e730016a8";
        UMConfigInstance.channelId = @"App Store";
        [MobClick startWithConfigure:UMConfigInstance];//配置以上参数后调用此方法初始化SDK！
        NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
        [MobClick setAppVersion:version];
    }
    //版本崩溃监测工具 bugly
    {
         [Bugly startWithAppId:@"b8b1c4ef93"];
    }*/
}

- (void)setupWindow
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    // 获取设备基本信息
    [Fcgo_Tools getPhoneMesg];
}

#pragma mark 设置rootVC

- (void)setupRootVC
{
    if ([Fcgo_UserTools shared].isFirstLaunch == 0) {
        [self setLeadVCToRootVC];
    }
    else
    {
        if ([Fcgo_UserTools shared].isLogin == 0)
        {
            [self  setLoginVCToRootVC];
        }
        else
        {
            [Fcgo_publicNetworkTools postCheckToken];
            [self  setTabarVCToRootVC];
            // 启动广告
            {
                [[Fcgo_LaunchAdTools sharedInstance] show];
            }
        }
    }
}

- (void)setLeadVCToRootVC
{
    self.window.rootViewController = nil;
    Fcgo_LeadVC *tabVC = [[Fcgo_LeadVC alloc]init];
    self.window.rootViewController = tabVC;
}

- (void)setTabarVCToRootVC
{
    self.window.rootViewController = nil;
    Fcgo_BasicTabVC *tabVC = [[Fcgo_BasicTabVC alloc]init];
    Fcgo_BasicNavVC *tabNav = [[Fcgo_BasicNavVC alloc] initWithRootViewController:tabVC];
    tabNav.navigationBar.hidden = 1;
    self.window.rootViewController = tabNav;
    self.tabVC = tabVC;
}

- (void)setLoginVCToRootVC
{
    //每次登录前，都应清除已存的登录信息
    [[Fcgo_UserTools shared] clearUserInfomation];
    
    self.window.rootViewController = nil;
    Fcgo_LoginVC *loginVC = [[Fcgo_LoginVC alloc]init];
    Fcgo_BasicNavVC *loginNav = [[Fcgo_BasicNavVC alloc] initWithRootViewController:loginVC];
    loginNav.navigationBar.hidden = 1;
    self.window.rootViewController = loginNav;
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    //是在应用在前台时发送token是否失效，以便及时弹出登录页
    if ([Fcgo_UserTools shared].isFirstLaunch == 1 && [Fcgo_UserTools shared].isLogin == 1) {
        [Fcgo_publicNetworkTools postCheckToken];
    }
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return [WXApi  handleOpenURL:url delegate:self];
}

-(void)onResp:(BaseResp *)resp
{
    if (resp.errCode==0) {
        [[NSNotificationCenter  defaultCenter] postNotificationName:@"pay" object:nil];
    }
    else if (resp.errCode==-1)
    {
        [WSProgressHUD showImage:nil status:resp.errStr];
        
    }
    else
    {
        [WSProgressHUD showImage:nil status:@"取消支付"];
    }
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    
    //   **************  日历通知  ************
    if([url.absoluteString containsString:@"openfcgo://detail"])
    {
        [self setCalendarWithUrl:url];
        
    }
    //   ************      支付     ************
    if ([url.host isEqualToString:@"safepay"]) {
        //跳转支付宝钱包进行支付，处理支付结果
        [self setAlipayWithUrl:url];
        return YES;
    }
    
    if ([url.host isEqualToString:@"platformapi"]) {
        [[AlipaySDK  defaultService] processAuthResult:url standbyCallback:^(NSDictionary *resultDic) {
        }];
        return YES;
    }
    return [WXApi  handleOpenURL:url delegate:self];
}

// NOTE: 9.0以后使用新API接口
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options
{
    if([url.absoluteString containsString:@"openfcgo://detail"])
    {
        [self setCalendarWithUrl:url];
    }
    if ([url.host isEqualToString:@"safepay"]) {
        
        [self setAlipayWithUrl:url];
        return YES;
    }
    if ([url.host isEqualToString:@"platformapi"]) {
        [[AlipaySDK  defaultService] processAuthResult:url standbyCallback:^(NSDictionary *resultDic) {
        }];
        return YES;
    }
    return [WXApi  handleOpenURL:url delegate:self];
}

- (void)setAlipayWithUrl:(NSURL *)url
{
    //跳转支付宝钱包进行支付，处理支付结果
    [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
        if (![resultDic isKindOfClass:[NSNull  class]]) {
            NSInteger  resultStatus = [[resultDic  objectForKey:@"resultStatus"] integerValue];
            if (![Fcgo_Tools isNullString:[resultDic  objectForKey:@"memo"]]) {
                [WSProgressHUD  showImage:nil status:[resultDic  objectForKey:@"memo"]];
            }
            if (resultStatus==9000) {
                [[NSNotificationCenter  defaultCenter] postNotificationName:@"pay" object:nil];
            }
        }
    }];
}

- (void)setCalendarWithUrl:(NSURL *)url
{
    //     日历通知
    NSString *params = [url query];
    if ([params containsString:@"&"])
    {
        NSArray  *paremetes=[params  componentsSeparatedByString:@"&"];
        NSMutableDictionary  *paremeterDict = [NSMutableDictionary dictionary];
        for (NSString  *str in paremetes)
        {
            NSArray  *ssss=[str  componentsSeparatedByString:@"="];
            [paremeterDict  setObjectWithNullValidate:[ssss objectAtIndex:1] forKey:[ssss  objectAtIndex:0]];
        }
        
        NSString *goodsValue = paremeterDict[@"params"];
        NSString *type = paremeterDict[@"type"];
        Fcgo_GoodsDetailVC *vc = [[Fcgo_GoodsDetailVC alloc]init];
        vc.goodsValue = goodsValue;
        vc.goodsType = type;
        [(UINavigationController *)self.tabVC.selectedViewController pushViewController:vc animated:YES];
    }
}

#pragma mark 阿里推送
// 向APNs注册，获取deviceToken用于推送
- (void)registerAPNS:(UIApplication *)application {
    float systemVersionNum = [[[UIDevice currentDevice] systemVersion] floatValue];
    if (systemVersionNum >= 10.0) {
        // iOS 10 notifications
        _notificationCenter = [UNUserNotificationCenter currentNotificationCenter];
        // 创建category，并注册到通知中心
        [self createCustomNotificationCategory];
        _notificationCenter.delegate = self;
        // 请求推送权限
        [_notificationCenter requestAuthorizationWithOptions:UNAuthorizationOptionAlert | UNAuthorizationOptionBadge | UNAuthorizationOptionSound completionHandler:^(BOOL granted, NSError * _Nullable error) {
            if (granted) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [application registerForRemoteNotifications];
                });
            } else {
                
            }
        }];
    } else if (systemVersionNum >= 8.0) {
        // iOS 8 Notifications
#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wdeprecated-declarations"
        [application registerUserNotificationSettings:
         [UIUserNotificationSettings settingsForTypes:
          (UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge)
                                           categories:nil]];
        [application registerForRemoteNotifications];
#pragma clang diagnostic pop
    } else {
        // iOS < 8 Notifications
#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wdeprecated-declarations"
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:
         (UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound)];
#pragma clang diagnostic pop
    }
}

//*  主动获取设备通知是否授权(iOS 10+)
- (void)getNotificationSettingStatus {
    [_notificationCenter getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
        if (settings.authorizationStatus == UNAuthorizationStatusAuthorized) {
            
        } else {
            
        }
    }];
}

// *  APNs注册成功回调，将返回的deviceToken上传到CloudPush服务器
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    [CloudPushSDK registerDevice:deviceToken withCallback:^(CloudPushCallbackResult *res) {
        if (res.success) {
            
        } else {
            
        }
    }];
    
    [[QYSDK sharedSDK] updateApnsToken:deviceToken];
}

//*  APNs注册失败回调
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    
}

// *  创建并注册通知category(iOS 10+)
- (void)createCustomNotificationCategory {
    // 自定义`action1`和`action2`
    UNNotificationAction *action1 = [UNNotificationAction actionWithIdentifier:@"action1" title:@"test1" options: UNNotificationActionOptionNone];
    UNNotificationAction *action2 = [UNNotificationAction actionWithIdentifier:@"action2" title:@"test2" options: UNNotificationActionOptionNone];
    // 创建id为`test_category`的category，并注册两个action到category
    // UNNotificationCategoryOptionCustomDismissAction表明可以触发通知的dismiss回调
    UNNotificationCategory *category = [UNNotificationCategory categoryWithIdentifier:@"test_category" actions:@[action1, action2] intentIdentifiers:@[] options:
                                        UNNotificationCategoryOptionCustomDismissAction];
    // 注册category到通知中心
    [_notificationCenter setNotificationCategories:[NSSet setWithObjects:category, nil]];
}

// *  处理iOS 10通知(iOS 10+)

- (void)handleiOS10Notification:(UNNotification *)notification
{
    UNNotificationRequest *request = notification.request;
    UNNotificationContent *content = request.content;
    NSDictionary *userInfo = content.userInfo;
    // 通知打开回执上报
    [CloudPushSDK sendNotificationAck:userInfo];
}

// *  App处于前台时收到通知(iOS 10+)
- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler {
    
    // 处理iOS 10通知，并上报通知打开回执
    [self handleiOS10Notification:notification];
    // 通知不弹出
    //completionHandler(UNNotificationPresentationOptionNone);
    // 通知弹出，且带有声音、内容和角标
    completionHandler(UNNotificationPresentationOptionSound | UNNotificationPresentationOptionAlert | UNNotificationPresentationOptionBadge);
}

//*  触发通知动作时回调，比如点击、删除通知和点击自定义action(iOS 10+)
- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler {
    NSString *userAction = response.actionIdentifier;
    // 点击通知打开
    if ([userAction isEqualToString:UNNotificationDefaultActionIdentifier]) {
        // 处理iOS 10通知，并上报通知打开回执
        [self handleiOS10Notification:response.notification];
    }
    // 通知dismiss，category创建时传入UNNotificationCategoryOptionCustomDismissAction才可以触发
    if ([userAction isEqualToString:UNNotificationDismissActionIdentifier]) {
        
    }
    UNNotificationRequest *request = response.notification.request;
    UNNotificationContent *content = request.content;
    NSDictionary *userInfo = content.userInfo;
    NSString *type = userInfo[@"app_across"];
    id app_across_value = userInfo[@"app_across_value"];
    [Fcgo_App_acrossTools app_across:type app_across_value:app_across_value webView:nil parentVC:(UINavigationController *)self.tabVC.selectedViewController];
    completionHandler();
}

#pragma mark SDK Init
- (void)initCloudPush {
    // 正式上线建议关闭
    //[CloudPushSDK turnOnDebug];
    // SDK初始化
    [CloudPushSDK asyncInit:testAppKey appSecret:testAppSecret callback:^(CloudPushCallbackResult *res) {
        if (res.success) {} else {}
    }];
}

#pragma mark Notification Open
// *  App处于启动状态时，通知打开回调
- (void)application:(UIApplication*)application didReceiveRemoteNotification:(NSDictionary*)userInfo {
    application.applicationIconBadgeNumber = 0;
    // 通知打开回执上报
    // [CloudPushSDK handleReceiveRemoteNotification:userInfo];(Deprecated from v1.8.1)
    [CloudPushSDK sendNotificationAck:userInfo];
}

#pragma mark Receive Message
// *    @brief    注册推送消息到来监听
- (void)registerMessageReceive {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(onMessageReceived:)
                                                 name:@"CCPDidReceiveMessageNotification"
                                               object:nil];
}

- (void)onMessageReceived:(NSNotification *)notification
{
    
}

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application
{
    [[SDWebImageManager sharedManager] cancelAll];
    [[SDImageCache sharedImageCache] setValue:nil forKey:@"memCache"];
}

@end

