//
//  Fcgo_QYIM_JumpTools.m
//  Fcgo
//
//  Created by shihaifeng on 2017/9/22.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_QYIM_JumpTools.h"

@interface Fcgo_QYIM_JumpTools()
@property (nonatomic, strong) QYSessionViewController *sessionViewController;
@end

@implementation Fcgo_QYIM_JumpTools
+ (instancetype)sharedInstance {
    static Fcgo_QYIM_JumpTools *instance;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        instance = [[Fcgo_QYIM_JumpTools alloc] init];
    });
    return instance;
}
- (void)qy_jumpWithTitle:(NSString *)title
               urlString:(NSString *)urlString
              customInfo:(NSString *)customInfo
            sessionTitle:(NSString *)sessionTitle
 commodityInfoDictionary:(NSDictionary *)dictionary {
    
    /**
     *  会话窗口上方提示条中的文本字体颜色
     */
    [[QYSDK sharedSDK] customUIConfig].sessionTipTextColor = UIFontWhiteColor;
    /**
     *  会话窗口上方提示条中的文本字体大小
     */
    [[QYSDK sharedSDK] customUIConfig].sessionTipTextFontSize = 12;
    //    /**
    //     *  会话窗口上方提示条中的背景颜色
    //     */
    [[QYSDK sharedSDK] customUIConfig].sessionTipBackgroundColor = UIStringColor(@"#d2d2d2");
    //    /**
    //     *  访客文本消息字体颜色
    //     */
    [[QYSDK sharedSDK] customUIConfig].customMessageTextColor = UIFontWhiteColor;
    
    //    /**
    //     *  访客文本消息字体大小
    //     */
    [[QYSDK sharedSDK] customUIConfig].customMessageTextFontSize = 15;
    //    /**
    //     *  客服文本消息字体颜色
    //     */
    [[QYSDK sharedSDK] customUIConfig].serviceMessageTextColor = [UIColor blackColor];
    
    //    /**
    //     *  客服文本消息字体大小
    //     */
    [[QYSDK sharedSDK] customUIConfig].serviceMessageTextFontSize = 15;
    //    /**
    //     *  提示文本消息字体颜色；提示文本消息有很多种，比如“***为你服务”就是一种
    //     */
    //  [[QYSDK sharedSDK] customUIConfig].tipMessageTextColor = UIFontWhiteColor;
    //    /**
    //     *  提示文本消息字体大小；提示文本消息有很多种，比如“***为你服务”就是一种
    //     */
    [[QYSDK sharedSDK] customUIConfig].tipMessageTextFontSize = 12;
    //    /**
    //     *  消息tableview的背景图片
    //     */
    //    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"session_bg"]];
    //    imageView.contentMode = UIViewContentModeScaleToFill;
    [[QYSDK sharedSDK] customUIConfig].sessionBackground.backgroundColor = UIBackGroundColor;
    //    /**
    //     *  访客头像
    //     */
    [[QYSDK sharedSDK] customUIConfig].customerHeadImage = [UIImage imageNamed:@"portrait"];
    //    /**
    //     *  访客头像url
    //     */
    //    //[[QYSDK sharedSDK] customUIConfig].customerHeadImageUrl = @"http_url";
    //
    //    /**
    //     *  访客消息气泡normal图片
    //     */
    [[QYSDK sharedSDK] customUIConfig].customerMessageBubbleNormalImage =
    [[UIImage imageNamed:@"bubble2"]
     resizableImageWithCapInsets:UIEdgeInsetsMake(30,15,15,30)
     resizingMode:UIImageResizingModeStretch];
    //    /**
    //     *  访客消息气泡pressed图片
    //     */
        [[QYSDK sharedSDK] customUIConfig].customerMessageBubblePressedImage =
        [[UIImage imageNamed:@"bubble2"]
         resizableImageWithCapInsets:UIEdgeInsetsMake(30,15,15,30)
         resizingMode:UIImageResizingModeStretch];
    
    [QYCustomUIConfig sharedInstance].autoShowKeyboard = NO;
    
    
    if ([Fcgo_UserTools shared].userDict) {
        QYUserInfo *userInfo = [[QYUserInfo alloc] init];
        userInfo.userId = [Fcgo_UserTools shared].userDict[@"storeMobile"];
        NSMutableArray *array = [NSMutableArray new];
        NSMutableDictionary *dictRealName = [NSMutableDictionary new];
        [dictRealName setObject:@"real_name" forKey:@"key"];
        [dictRealName setObject:[Fcgo_UserTools shared].userDict[@"storeName"] forKey:@"value"];
        [array addObject:dictRealName];
        NSMutableDictionary *dictMobilePhone = [NSMutableDictionary new];
        [dictMobilePhone setObject:@"mobile_phone" forKey:@"key"];
        [dictMobilePhone setObject:[Fcgo_UserTools shared].userDict[@"opPhone"] forKey:@"value"];
        [dictMobilePhone setObject:@(NO) forKey:@"hidden"];
        [array addObject:dictMobilePhone];
        //    NSMutableDictionary *dictEmail = [NSMutableDictionary new];
        //    [dictEmail setObject:@"email" forKey:@"key"];
        //    [dictEmail setObject:@"bianchen@163.com" forKey:@"value"];
        //    [array addObject:dictEmail];
        //    NSMutableDictionary *dictAuthentication = [NSMutableDictionary new];
        //    [dictAuthentication setObject:@"0" forKey:@"index"];
        //    [dictAuthentication setObject:@"authentication" forKey:@"key"];
        //    [dictAuthentication setObject:@"实名认证" forKey:@"label"];
        //    [dictAuthentication setObject:@"已认证" forKey:@"value"];
        //    [array addObject:dictAuthentication];
        //    NSMutableDictionary *dictBankcard = [NSMutableDictionary new];
        //    [dictBankcard setObject:@"1" forKey:@"index"];
        //    [dictBankcard setObject:@"bankcard" forKey:@"key"];
        //    [dictBankcard setObject:@"绑定银行卡" forKey:@"label"];
        //    [dictBankcard setObject:@"622202******01116068" forKey:@"value"];
        //    [array addObject:dictBankcard];
        
        NSData *data = [NSJSONSerialization dataWithJSONObject:array
                                                       options:0
                                                         error:nil];
        if (data)
        {
            userInfo.data = [[NSString alloc] initWithData:data
                                                  encoding:NSUTF8StringEncoding];
        }
        
        [[QYSDK sharedSDK] setUserInfo:userInfo];
    }
    
    QYSource *source = [[QYSource alloc] init];
    source.title = title;//[title length] > 0 ? title : @"备货通客服";
    source.urlString = urlString;//[urlString length] > 0 ? urlString : @"https://8.163.com/";
    
    if (!self.sessionViewController) {
        self.sessionViewController = [[QYSDK sharedSDK] sessionViewController];
    }
    //vc.sessionTitle = [sessionTitle length] > 0 ? sessionTitle : @"备货通客服";
    self.sessionViewController.source = source;
    
    // 发送商品信息
    if (dictionary) {
        QYCommodityInfo *info = [[QYCommodityInfo alloc] init];
        info.title = dictionary[commodityInfoTitle];
        info.desc = dictionary[commodityInfoDes];
        info.pictureUrlString = dictionary[commodityInfoPic];
        info.note = dictionary[commodityInfoNote];
        self.sessionViewController.commodityInfo = info;
    }
    Fcgo_BasicNavVC *nav = [[Fcgo_BasicNavVC alloc] initWithRootViewController:self.sessionViewController];
    nav.navigationItem.hidesBackButton = 1;
    // 自定义返回按钮
    UIButton *navBackBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [navBackBtn setImage:[UIImage imageNamed:@"ico_back"]forState:UIControlStateNormal];
    [navBackBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    navBackBtn.frame = CGRectMake(0, 0, 34, 34);
    navBackBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -35, 0, 0);
    
    self.sessionViewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:navBackBtn];
    
    UILabel *navTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth/2-60, 7, 120, 30)];
    navTitleLabel.font = UIFontSize(17);//[UIFont boldSystemFontOfSize:17];
    navTitleLabel.textColor = UIFontMainGrayColor;
    navTitleLabel.textAlignment = NSTextAlignmentCenter;
    navTitleLabel.text = [sessionTitle length] > 0 ? sessionTitle : @"备货通客服";
    self.sessionViewController.navigationItem.titleView = navTitleLabel;
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:nav animated:YES completion:nil];
    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
}

- (void)backAction {
    if (self.sessionViewController) {
        [self.sessionViewController dismissViewControllerAnimated:YES completion:NULL];
        [IQKeyboardManager sharedManager].enableAutoToolbar = YES;
        //self.sessionViewController = nil;
    }
}

@end
