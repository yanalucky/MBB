//
//  Fcgo_Header.h
//  Fcgo
//
//  Created by huafanxiao on 2017/5/8.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#ifndef Fcgo_Header_h
#define Fcgo_Header_h

//服务器地址
//#define NSServiceHeaderUrl   @"http://172.16.103.77:8080/interfaces/v2/app/"
//#define NSServiceShortUrl    @"http://172.16.103.77:8080/interfaces/"

#define NSServiceHeaderUrl   @"http://api.ddhshop.com/v2/app/"
#define NSServiceShortUrl    @"http://api.ddhshop.com/"
#define NSTestServiceUrl     @"http://106.14.59.144:8080/interfaces/v2/app/"
#define NSShortUrl           @"http://api.ddhshop.com/"
#define XMURL                @"http://106.14.59.144:8080/v2/app/"
//#define NSTestServiceUrl     @"http://172.16.103.85:8080/interfaces/v2/app/"
//#define NSShortUrl           @"http://172.16.103.85:8080/interfaces/"
//#define XMURL                @"http://172.16.103.85:8080/v2/app/"
//#define NSTestServiceUrl     @"http://172.16.103.56:8060/interfaces/v2/app/"
//#define NSShortUrl           @"http://192.168.1.138:8080/interfaces/"
//#define XMURL                @"http://192.168.1.171/v2/app/"

//#define NSHeaderUrl   @"http://192.168.1.187:8080/fcgo2.0/v2/app/"//测试服务器地址
//#define NSShortUrl    @"http://192.168.1.187:8080/fcgo2.0/"

//#define NSHeaderUrl   @"http://192.168.1.156:80/fcgo3.0/v2/app/"//测试服务器地址
//#define NSShortUrl    @"http://192.168.1.156:80/fcgo3.0/"

#define NSFormatLogiciticsUrl(urlString) [NSString stringWithFormat:@"%@%@.html",@"http://192.168.1.156:80/fcgo3.0/v3/app/",urlString]   //测试物流地址 


//    @"http://test.ddhshop.com:8080/fcgo3.0/v2/app/bis/show/index/first-page.html?merId=2703"

//#define NSHeaderUrl   @"http://www.ddhshop.com/v1/app/"//服务器地址
//#define NSShortUrl    @"http://www.ddhshop.com/"

#define NSFormatHeardUrl(urlString) [NSString stringWithFormat:@"%@%@.html",NSServiceHeaderUrl,urlString]
//num  1 服务器   2  本地138    3  本地171
//(ServiceType == 1)?NSServiceHeaderUrl:((ServiceType == 2)?NSTestServiceUrl:XMURL)
#define  NSFormatHeardMeThodUrl(ServiceType,methodName,urlString) [NSString stringWithFormat:@"%@%@%@.html",NSServiceHeaderUrl,methodName,urlString]

#define NSFormatShortUrl(urlString) [NSString stringWithFormat:@"%@%@.html",NSServiceShortUrl,urlString]

typedef enum : NSUInteger {
    ServiceOnlineType = 1,
    ServiceLocalTypeOne,
    ServiceLocalTypeTwo,
    
}ServiceType;


#define REALNAMEMETHOD   @"mch/realname/"
#define INFOMETHOD       @"mch/info/"
#define USERMETHOD       @"mch/user/"
#define ADDRESSMETHOD    @"mer/address/"
#define COMMONMETHOD     @"common/"
#define GOODMETHOD       @"goods/"
#define NOTICEMETHOD     @"notice/"
#define SHOPCARMETHOD    @"mch/shopcar/"
#define ORDERMETHOD      @"order/"
#define STOREMETHOD      @"mch/store/"
#define FOOTPRINTMETHOD  @"mch/footprint/"
#define ACTIVITY         @"bis/activity/"
#define COUPON           @"mer/coupon/"
#define HOTSEARCHMETHOD  @"bis/show/hotsearch/"
#define IntegralMethod   @"bis/promote/"
#define ADVERTMethod    @"bis/ad/"

#define Fcgo_Delegate   ((Fcgo_AppDelegate *)[[UIApplication  sharedApplication] delegate])

#define Token         [Fcgo_UserTools shared].userDict[@"token"]
#define MerId         [Fcgo_UserTools shared].userDict[@"storeId"]
#define MchId         [Fcgo_UserTools shared].userDict[@"mchId"]
#define OperatorId    [Fcgo_UserTools shared].userDict[@"operatorId"]

#define Dev_no            [Fcgo_UserTools shared].deviceDict[@"f_dev_no"]
#define Dev_system_no     [Fcgo_UserTools shared].deviceDict[@"f_dev_system_no"]
#define Dev_brand         [Fcgo_UserTools shared].deviceDict[@"f_dev_brand"]
#define Dev_IPAdd         [Fcgo_UserTools shared].deviceDict[@"ipStr"]
#define Dev_logSource     [Fcgo_UserTools shared].deviceDict[@"loginSource"]
#define Dev_Channel       [Fcgo_UserTools shared].deviceDict[@"f_channel"]
#define Dev_App_Version   [Fcgo_UserTools shared].deviceDict[@"f_app_version"]
//防止循环引用weak
#define WEAKSELF(weakSelf)      __weak __typeof(&*self)weakSelf = self;
//防止提前释放strong
#define STRONGSELF(strongSelf)  __strong __typeof(&*self)strongSelf = weakSelf;

//单例类
#define  OBJC_Defaults   [NSUserDefaults  standardUserDefaults]

//输出宏
#ifdef DEBUG
#define NSLog(FORMAT, ...) fprintf(stderr,"%s:%d\t%s\n",[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else
#define NSLog(...)
#endif

//获取屏幕大小
#define kScreenWidth  [UIScreen mainScreen].bounds.size.width
#define KScreenHeight [UIScreen mainScreen].bounds.size.height

//屏幕适配比例
#define kAutoWidth6(width)      (width) *(kScreenWidth/375)
#define kAutoHeight6(height)    (height)*(KScreenHeight/667)

#define kAutoWidth6px(width)     (width)*(kScreenWidth/1242)
#define kAutoWidth6px_h(height)  (height)*(KScreenHeight/2208)


//判断设备
#define IPHONE4  ((int)KScreenHeight%480==0)
#define IPHONE5  ((int)KScreenHeight%568==0)
#define IPHONE6  ((int)KScreenHeight%667==0)
#define IPHONE6P ((int)KScreenHeight%736==0)
#define IPHONEX  ((int)KScreenHeight%812==0)


#define IOS10_Early    ([[[UIDevice currentDevice] systemVersion] floatValue] < 10.0)

//颜色
#define UIStringColorAlpha(kcolor,kalpha) [UIColor colorWithString:kcolor alpha:kalpha]
#define UIStringColor(kcolor) [UIColor colorWithString:kcolor]

#define UIRGBColor(r,g,b,a)   [UIColor colorWithRed:(r) / 255. green:(g) / 255. blue:(b) / 255. alpha:(a)]

                           /*常使用颜色*/
#define UIBackGroundColor       UIStringColor(@"#f7f4f2")  //背景色

#define UISepratorLineColor     UIRGBColor(234,234,234,1) //分割线 灰
#define UINavSepratorLineColor  UIStringColor(@"eaeaea") //分割线 灰

#define UIFontBlack1Color       UIStringColor(@"#090909") //字体黑
#define UIFontRedColor          UIStringColor(@"#f63378")  //字体红
#define UIFontRed_newColor          UIStringColor(@"#e5486a")  //字体红

#define UIFontBlack282828       UIStringColor(@"#282828") // 字体黑 新加

#define UIFontMainGrayColor     UIRGBColor(40, 40, 40, 1) //常规深灰
#define UIFontSortGrayColor     UIRGBColor(90, 90, 90, 1) //首页分类深灰
#define UIFontMiddleGrayColor   UIRGBColor(123, 123, 123, 1) //中灰
#define UIFontPlaceholderColor  UIRGBColor(190, 190, 190, 1) //输入框占位符

#define UIFontBlackColor        [UIColor blackColor]
#define UIFontWhiteColor        [UIColor whiteColor]
#define UIFontClearColor        [UIColor clearColor]
#define UIFontPhotoColor        [UIColor colorWithRed:253/255.0 green:142/255.0 blue:36/255.0 alpha:1]


//尺寸
#define UIFontSacleSize(size)  [Fcgo_Tools getFontWithFontSize:size]
#define UIFontSize(size)       [Fcgo_Tools getFontWithFontSize:size bold:NO]
#define UIBoldFontSize(size)   [Fcgo_Tools getFontWithFontSize:size bold:YES]



//提示框
#define alert(msg) UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:msg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];\
    [alert show];

typedef enum : NSUInteger {
    WholePointEndType,
    WholePointStartType,
    WholePointNotStartType,
} WholePointType;

typedef enum : NSUInteger {
    OrderStatusWaitPayType,    //待付款
    OrderStatusTestPayType,    //付款验证
    OrderStatusDealType,       //处理中
    OrderStatusWaitSendType,   //待发货
    OrderStatusWaitReceiveType,//待收货
    OrderStatusSiginedType,     //已签收
    OrderStatusFinishType,     //完成
    OrderStatusCancelType,     //取消
} OrderStatusType;

typedef NS_ENUM(NSInteger, kHeadTouchType) {
    /*个人中心头部视图按钮的tag*/
    kHeadTouchType_myOrder = 1, ///< 我的订单
    kHeadTouchType_waitPay = 2, ///< 待付款
    kHeadTouchType_deal = 3, ///< 处理中
    kHeadTouchType_recive = 4, ///< 待收货
    kHeadTouchType_afterSale = 5, ///< 售后服务
    kHeadTouchType_headImage = 6, ///< 用户头像
    /*个人中心导航栏按钮的tag*/
    kHeadTouchType_setting = 7, ///< 设置
    kHeadTouchType_message = 8, ///< 消息
    /*个人中心cell上按钮的tag*/
    kHeadTouchType_coupon = 9, ///< 优惠券
    kHeadTouchType_address = 10, ///< 地址管理
    kHeadTouchType_common = 11, ///< 实名认证
    kHeadTouchType_account = 12, ///< 账户信息
    kHeadTouchType_security = 13, ///< 安全中心
    kHeadTouchType_favorite = 14, ///< 我的收藏
    kHeadTouchType_shop = 15, ///< 门店管理
    kHeadTouchType_staff = 16, ///< 员工管理
    kHeadTouchType_history = 17, ///< 我的足迹
    kHeadTouchType_pay = 18, ///< 菲支付
    kHeadTouchType_intergral = 19, ///< 积分
    kHeadTouchType_service = 20, ///< 联系客服
    kHeadTouchType_subscribe = 21, ///< 公众号
    kHeadTouchType_feedback = 22, ///< 意见反馈
};

typedef void(^TouchType)(kHeadTouchType type);

typedef void(^VoidBlock)(void);

#endif /* Fcgo_Header_h */
