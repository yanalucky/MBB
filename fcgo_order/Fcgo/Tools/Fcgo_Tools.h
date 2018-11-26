//
//  Fcgo_Tools.h
//  Fcgo
//
//  Created by huafanxiao on 2017/5/8.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import <Foundation/Foundation.h>
//首先导入头文件信息
#include <ifaddrs.h>
#include <arpa/inet.h>
#include <net/if.h>
#import "sys/utsname.h"

#define IOS_CELLULAR    @"pdp_ip0"
#define IOS_WIFI        @"en0"
//#define IOS_VPN       @"utun0"
#define IP_ADDR_IPv4    @"ipv4"
#define IP_ADDR_IPv6    @"ipv6"

/// 导航栏高度
#define kNavigationHeight   [Fcgo_Tools getNavigationHeight]
/// 导航栏子视图y坐标值在iPhone X上的增值
#define kNavigationSubY(margin)     ([Fcgo_Tools getNavigationSubviewFrameY] + margin)
/// 自定义tabBar高度
#define kTabBarHeight       [Fcgo_Tools getTabBarHeight]
/// 自定义tabBar子视图与底部间距
#define kTabBarBottomMargin  [Fcgo_Tools getTabBarBottomMargin]

@interface Fcgo_Tools : NSObject

//获取设备ID
+ (NSString *)getDeviceId;

+ (NSString *)uuidString;

/**字符串判空*/
+ (BOOL)isNullString:(NSString *)string;

+ (UIFont *)getFontWithFontSize:(float)size;
//适配字体
+ (UIFont *)getFontWithFontSize:(float)size bold:(BOOL)isBold;

+ (NSInteger)isActivityTimeByStartDate:(NSString *)start endDate:(NSString *)end;

+ (void)timeDownWithBtn:(UIButton *)sender;

+ (BOOL)valiMobile:(NSString *)mobile;

+ (UIImage *)imageDealHandleWithImage:(UIImage *)image;

+ (UIImage *)imageDealHandleWithImage:(UIImage *)image scaleToSize:(CGSize)size;

+ (NSDate *)getLocalDate:(NSDate *)date;

+ (BOOL)judgeTextcharacterstextLegal:(NSString *)pass;

+ (BOOL)isNetworkConnected;

+ (UIImage *)creatQRImageWithString:(NSString *)string;
/// 校验精确的身份证号码
+ (BOOL)accurateVerifyIDCardNumber:(NSString *)value;

+ (UIViewController *)topViewController;

/// 适配iPhone X导航栏高度
+ (CGFloat)getNavigationHeight;
/// 适配iPhone X导航栏子视图的y坐标值，默认为0，在iPhone X上增加24.0f
+ (CGFloat)getNavigationSubviewFrameY;
/// 适配iPhone X自定义tabBar高度
+ (CGFloat)getTabBarHeight;
/// 适配iPhone X自定义tabBar底部预留间距
+ (CGFloat)getTabBarBottomMargin;

+ (void)getPhoneMesg;
+ (NSString *)iphoneType;
+ (NSString *)getIPAddress:(BOOL)preferIPv4;
+ (NSDictionary *)getIPAddresses;

@end
