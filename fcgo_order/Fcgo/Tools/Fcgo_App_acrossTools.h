//
//  Fcgo_App_acrossTools.h
//  Fcgo
//
//  Created by huafanxiao on 2017/7/6.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Fcgo_App_acrossTools : NSObject


+ (BOOL)app_acrossWithJsonString:(NSString *)jsonString webView:(UIWebView *)webView parentVC:(UIViewController *)parentVC;
+ (BOOL)app_across:(NSString *)app_across app_across_value:(id)app_across_value webView:(UIWebView *)webView parentVC:(UINavigationController *)parentVC;

@end
