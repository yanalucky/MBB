//
//  Fcgo_App_acrossTools.m
//  Fcgo
//
//  Created by huafanxiao on 2017/7/6.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_App_acrossTools.h"
#import "Fcgo_GoodsDetailVC.h"
#import "Fcgo_OrderConfirmVC.h"
#import "Fcgo_OrderDetailVC.h"
#import "Fcgo_GoodsListVC.h"
#import "Fcgo_OrderPayVC.h"
#import "Fcgo_ScanVC.h"
#import "Fcgo_MsgOrderVC.h"
#import "Fcgo_MsgSystemVC.h"
#import "Fcgo_MsgDetailHtmlVC.h"
#import "Fcgo_FromHomeWebVC.h"

#import "Fcgo_CouponMessageVC.h"

#import "Home_WholePointDetailVC.h"
#import "Fcgo_SearchVC.h"

@implementation Fcgo_App_acrossTools

+ (BOOL)app_acrossWithJsonString:(NSString *)jsonString webView:(UIWebView *)webView parentVC:(UIViewController *)parentVC
{
    
    if (!jsonString || [jsonString isEqualToString:@""]) {
        return YES;
    }
    NSString  *string;
    if ([jsonString containsString:@"app_across="]) {
        string=[[jsonString  componentsSeparatedByString:@"app_across="]lastObject];
        if ([Fcgo_Tools isNullString:string])
        {
            return YES;
        }
    }else{
        string = jsonString;
    }
    //string = [string stringByReplacingOccurrencesOfString:@"=" withString:@":"];
    //string = [string stringByReplacingOccurrencesOfString:@"\'" withString:@"\""];
    //NSLog(@">>chenyandict>>>%@",string);
    NSData  *data = [string  dataUsingEncoding:NSUTF8StringEncoding];
    if (!data) {
        return YES;
    }
    NSError *error;
    NSDictionary  *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
    
    if (error) {
        return YES;
    }
    if(dict.count<=0)
    {
        return YES;
    }
    if (![dict.allKeys containsObject:@"app_across"])
    {
        return YES;
    }
    //获取截取的参数进行一下操作
    NSString *app_across = dict[@"app_across"];
    
    if ([app_across isEqualToString:@"goods_detail"])
    {
        NSDictionary *app_across_value = dict[@"app_across_value"];
        NSString *goodsType = app_across_value[@"goodsType"];
        NSString *goodsValue = app_across_value[@"goodsValue"];
        Fcgo_GoodsDetailVC *vc = [[Fcgo_GoodsDetailVC alloc]init];
        vc.goodsType = goodsType;
        vc.goodsValue = goodsValue;
        vc.hidesBottomBarWhenPushed = 1;
        [parentVC.navigationController pushViewController:vc animated:YES];
    }
    else  if ([app_across isEqualToString:@"goods_list"])
    {
        NSDictionary *app_across_value = dict[@"app_across_value"];
        NSString *words = app_across_value[@"words"];
        NSString *goodsIds = app_across_value[@"goodsIds"];
        NSString *cateIds = app_across_value[@"cateIds"];
        NSString *catemIds = app_across_value[@"catemIds"];
        NSString *brandIds = app_across_value[@"brandIds"];
        
        Fcgo_GoodsListVC *vc = [[Fcgo_GoodsListVC alloc]init];
        vc.words = words;
        vc.goodsIds = goodsIds;
        vc.cateIds  = cateIds;
        vc.catemIds = catemIds;
        vc.brandIds = brandIds;
        
        vc.hidesBottomBarWhenPushed = 1;
        [parentVC.navigationController pushViewController:vc animated:YES];
    }
    else  if ([app_across isEqualToString:@"order_prepare"])
    {
        
        id object = dict[@"app_across_value"];
        
        //NSDictionary *dic = dict[@"app_across_value"];
        
        [self buyWithObject:object parentVC:parentVC];
    }
    else  if ([app_across isEqualToString:@"order_detail"])
    {
        Fcgo_OrderDetailVC *vc = [[Fcgo_OrderDetailVC alloc]init];
        vc.hidesBottomBarWhenPushed = 1;
        NSDictionary *app_across_value = dict[@"app_across_value"];
        NSString *orderId = app_across_value[@"orderId"];
        vc.orderId = orderId;
        [parentVC.navigationController pushViewController:vc animated:YES];
    }
    else  if ([app_across isEqualToString:@"message_detail"])
    {
        NSDictionary *app_across_value = dict[@"app_across_value"];
        NSString *message_type = app_across_value[@"message_type"];
        //系统消息
        if(message_type.intValue == 1)
        {
            Fcgo_MsgSystemVC *vc = [[Fcgo_MsgSystemVC alloc]init];
            vc.hidesBottomBarWhenPushed = 1;
            [parentVC.navigationController pushViewController:vc animated:YES];
        }
        //订单消息
        else if(message_type.intValue == 2)
        {
            Fcgo_MsgOrderVC *vc = [[Fcgo_MsgOrderVC alloc]init];
            vc.hidesBottomBarWhenPushed = 1;
            [parentVC.navigationController pushViewController:vc animated:YES];
        }
    }
    else  if ([app_across isEqualToString:@"camera_open"])
    {
        Fcgo_ScanVC *vc = [[Fcgo_ScanVC alloc]init];
        vc.hidesBottomBarWhenPushed = 1;
        [parentVC.navigationController pushViewController:vc animated:YES];
    }
    else  if ([app_across isEqualToString:@"app_aut_login"])
    {
        
    }
    else  if ([app_across isEqualToString:@"order_pay"])
    {
        Fcgo_OrderPayVC *vc = [[Fcgo_OrderPayVC alloc]init];
        vc.hidesBottomBarWhenPushed = 1;
        [parentVC.navigationController pushViewController:vc animated:YES];
    }
    else  if ([app_across isEqualToString:@"back_native_last"])
    {
        //{"app_across":"gotoUrl","app_across_value":{"gotoUrl":""}}
        if (webView) {
            if (webView.canGoBack) {
                [webView goBack];
            }
            else{
                [parentVC.navigationController popViewControllerAnimated:YES];
            }
        }
    }
    else  if ([app_across isEqualToString:@"back_native_root"])
    {
        [parentVC.navigationController popViewControllerAnimated:YES];
    }
    else  if ([app_across isEqualToString:@"coupon_list"])
    {
        Fcgo_CouponMessageVC *vc = [[Fcgo_CouponMessageVC alloc]init];
        vc.hidesBottomBarWhenPushed = 1;
        vc.index = 1;
        [parentVC.navigationController pushViewController:vc animated:YES];
    }
    
    else  if ([app_across isEqualToString:@"integral"])
    {
        Home_WholePointDetailVC *vc = [[Home_WholePointDetailVC alloc]init];
        vc.hidesBottomBarWhenPushed = 1;
        [parentVC.navigationController pushViewController:vc animated:YES];
    }
    else  if ([app_across isEqualToString:@"search"])
    {
        Fcgo_SearchVC *vc = [[Fcgo_SearchVC alloc]init];
        vc.hidesBottomBarWhenPushed = YES;
        [parentVC.navigationController pushViewController:vc animated:YES];
    }
    else  if ([app_across isEqualToString:@"login"])
    {
        [WSProgressHUD showImage:nil status:@"已过期,请重新登录"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [Fcgo_Delegate setLoginVCToRootVC];
        });
    }
    else  if ([app_across isEqualToString:@"gotoUrl"])
    {
        NSDictionary *app_across_value = dict[@"app_across_value"];
        NSString *gotoUrl = app_across_value[@"gotoUrl"];
        
        //测试
        //gotoUrl = @"";
        
        if ([gotoUrl containsString:@"http://interfaces"])
        {
            if ([gotoUrl containsString:@"?"]) {
                gotoUrl = [NSString stringWithFormat:@"%@&merId=%@&token=%@",gotoUrl,MerId,Token];
                
            }else{
                gotoUrl = [NSString stringWithFormat:@"%@?merId=%@&token=%@",gotoUrl,MerId,Token];
            }
        }
        else if ([gotoUrl containsString:@"http://"])
        {
            if ([gotoUrl containsString:@"?"]) {
                gotoUrl = [NSString stringWithFormat:@"%@&merId=%@&token=%@",gotoUrl,MerId,Token];
                
            }else{
                gotoUrl = [NSString stringWithFormat:@"%@?merId=%@&token=%@",gotoUrl,MerId,Token];
            }
        }
        else
        {
            if ([gotoUrl containsString:@"?"]) {
                gotoUrl = [NSString stringWithFormat:@"%@%@&merId=%@&token=%@",NSServiceShortUrl,gotoUrl,MerId,Token];
            }else{
                gotoUrl = [NSString stringWithFormat:@"%@%@?merId=%@&token=%@",NSServiceShortUrl,gotoUrl,MerId,Token];
            }
        }
//       Fcgo_FromHomeWebVC *fromHomeWebVC = [[Fcgo_FromHomeWebVC alloc]init];
//        fromHomeWebVC.hidesBottomBarWhenPushed = 1;
//        if ([gotoUrl containsString:@"bis/show/index/wheel.html"]) {
//            fromHomeWebVC.scroll = YES;
//        }
        Fcgo_BasicShowWebViewVC *fromHomeWebVC = [[Fcgo_BasicShowWebViewVC alloc]init];
        fromHomeWebVC.urlString = gotoUrl;
        fromHomeWebVC.isShowNavBar = YES;
        fromHomeWebVC.hidesBottomBarWhenPushed = 1;
        [parentVC.navigationController pushViewController:fromHomeWebVC animated:YES];
    }
    return NO;
}

+ (BOOL)app_across:(NSString *)app_across app_across_value:(id)app_across_value webView:(UIWebView *)webView parentVC:(UINavigationController *)parentVC
{
    if ([app_across isEqualToString:@"goods_detail"])
    {
        NSDictionary *app_across_value1 = app_across_value;
        NSString *goodsType = app_across_value1[@"goodsType"];
        NSString *goodsValue = app_across_value1[@"goodsValue"];
        Fcgo_GoodsDetailVC *vc = [[Fcgo_GoodsDetailVC alloc]init];
        vc.goodsType = goodsType;
        vc.goodsValue = goodsValue;
        vc.hidesBottomBarWhenPushed = 1;
        [parentVC pushViewController:vc animated:YES];
    }
    else  if ([app_across isEqualToString:@"goods_list"])
    {
        NSDictionary *app_across_value1 = app_across_value;
        NSString *words = app_across_value1[@"words"];
        NSString *goodsIds = app_across_value1[@"goodsIds"];
        NSString *cateIds = app_across_value1[@"cateIds"];
        NSString *catemIds = app_across_value1[@"catemIds"];
        NSString *brandIds = app_across_value1[@"brandIds"];
        
        Fcgo_GoodsListVC *vc = [[Fcgo_GoodsListVC alloc]init];
        vc.words = words;
        vc.goodsIds = goodsIds;
        vc.cateIds  = cateIds;
        vc.catemIds = catemIds;
        vc.brandIds = brandIds;
        
        vc.hidesBottomBarWhenPushed = 1;
        [parentVC pushViewController:vc animated:YES];
    }
    else  if ([app_across isEqualToString:@"order_prepare"])
    {
        id object = app_across_value;
        [self buyWithObject:object parentVC:parentVC];
        
//        NSDictionary *dic = (NSDictionary *)app_across_value;
//        [self buyWithDic:dic parentVC:parentVC];
    }
    else  if ([app_across isEqualToString:@"order_detail"])
    {
        Fcgo_OrderDetailVC *vc = [[Fcgo_OrderDetailVC alloc]init];
        vc.hidesBottomBarWhenPushed = 1;
        NSDictionary *app_across_value1 = app_across_value;
        NSString *orderId = app_across_value1[@"orderId"];
        vc.orderId = orderId;
        [parentVC pushViewController:vc animated:YES];
    }
    else  if ([app_across isEqualToString:@"message_detail"])
    {
        NSDictionary *app_across_value1 = app_across_value;
        NSString *message_type = app_across_value1[@"message_type"];
        //系统消息
        if(message_type.intValue == 1)
        {
            Fcgo_MsgSystemVC *vc = [[Fcgo_MsgSystemVC alloc]init];
            vc.hidesBottomBarWhenPushed = 1;
            [parentVC pushViewController:vc animated:YES];
        }
        //订单消息
        else if(message_type.intValue == 2)
        {
            Fcgo_MsgOrderVC *vc = [[Fcgo_MsgOrderVC alloc]init];
            vc.hidesBottomBarWhenPushed = 1;
            [parentVC pushViewController:vc animated:YES];
        }
    }
    else  if ([app_across isEqualToString:@"camera_open"])
    {
        Fcgo_ScanVC *vc = [[Fcgo_ScanVC alloc]init];
        vc.hidesBottomBarWhenPushed = 1;
        [parentVC pushViewController:vc animated:YES];
    }
    else  if ([app_across isEqualToString:@"app_aut_login"])
    {
        
    }
    else  if ([app_across isEqualToString:@"order_pay"])
    {
        Fcgo_OrderPayVC *vc = [[Fcgo_OrderPayVC alloc]init];
        vc.hidesBottomBarWhenPushed = 1;
        [parentVC pushViewController:vc animated:YES];
    }
    else  if ([app_across isEqualToString:@"back_native_last"])
    {
        if (webView) {
            if (webView.canGoBack) {
                [webView goBack];
            }
            else{
                [parentVC.navigationController popViewControllerAnimated:YES];
            }
        }
        
        
    }
    else  if ([app_across isEqualToString:@"back_native_root"])
    {
        [parentVC popViewControllerAnimated:YES];
    }
    
    else  if ([app_across isEqualToString:@"coupon_list"])
    {
        Fcgo_CouponMessageVC *vc = [[Fcgo_CouponMessageVC alloc]init];
        vc.hidesBottomBarWhenPushed = 1;
        vc.index = 2;
        [parentVC.navigationController pushViewController:vc animated:YES];
    }
    
    else  if ([app_across isEqualToString:@"integral"])
    {
        Home_WholePointDetailVC *vc = [[Home_WholePointDetailVC alloc]init];
        vc.hidesBottomBarWhenPushed = 1;
        
        [parentVC.navigationController pushViewController:vc animated:YES];
    }
    else  if ([app_across isEqualToString:@"search"])
    {
        Fcgo_SearchVC *vc = [[Fcgo_SearchVC alloc]init];
        vc.hidesBottomBarWhenPushed = YES;
        [parentVC.navigationController pushViewController:vc animated:YES];
    }
    else  if ([app_across isEqualToString:@"login"])
    {
        [WSProgressHUD showImage:nil status:@"已过期,请重新登录"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [Fcgo_Delegate setLoginVCToRootVC];
        });
    }
    else  if ([app_across isEqualToString:@"gotoUrl"])
    {
        NSDictionary *app_across_value1 = app_across_value;
        NSString *gotoUrl = app_across_value1[@"gotoUrl"];
        if ([gotoUrl containsString:@"http://interfaces"])
        {
            if ([gotoUrl containsString:@"?"]) {
                gotoUrl = [NSString stringWithFormat:@"%@&merId=%@&token=%@",gotoUrl,MerId,Token];
                
            }else{
                gotoUrl = [NSString stringWithFormat:@"%@?merId=%@&token=%@",gotoUrl,MerId,Token];
            }
        }
        else if ([gotoUrl containsString:@"http://"])
        {
            if ([gotoUrl containsString:@"?"]) {
                gotoUrl = [NSString stringWithFormat:@"%@&merId=%@&token=%@",gotoUrl,MerId,Token];
                
            }else{
                gotoUrl = [NSString stringWithFormat:@"%@?merId=%@&token=%@",gotoUrl,MerId,Token];
            }
        }
        else
        {
            if ([gotoUrl containsString:@"?"]) {
                gotoUrl = [NSString stringWithFormat:@"%@%@&merId=%@&token=%@",NSServiceShortUrl,gotoUrl,MerId,Token];
            }else{
                gotoUrl = [NSString stringWithFormat:@"%@%@?merId=%@&token=%@",NSServiceShortUrl,gotoUrl,MerId,Token];
            }
        }
        
//        Fcgo_FromHomeWebVC *fromHomeWebVC = [[Fcgo_FromHomeWebVC alloc]init];
//        fromHomeWebVC.hidesBottomBarWhenPushed = 1;
//        if ([gotoUrl containsString:@"bis/show/index/wheel.html"]) {
//            fromHomeWebVC.scroll = YES;
//        }
        
        Fcgo_BasicShowWebViewVC *fromHomeWebVC = [[Fcgo_BasicShowWebViewVC alloc]init];
        fromHomeWebVC.urlString = gotoUrl;
        fromHomeWebVC.isShowNavBar = YES;
        fromHomeWebVC.hidesBottomBarWhenPushed = 1;
        [parentVC pushViewController:fromHomeWebVC animated:YES];
    }
    return NO;
}

//下单
+ (void)buyWithObject:(id)object parentVC:(UIViewController *)parentVC
{
    NSMutableDictionary   *paremtes = [NSMutableDictionary dictionary];
    NSString *jsonString = nil;
    if ([object isKindOfClass:[NSArray class]]) {
       jsonString=[Fcgo_publicNetworkTools arrayToJson:object];
    }
    else if ([object isKindOfClass:[NSDictionary class]]) {
        NSDictionary *dic = (NSDictionary *)object;
        NSArray *goodsArray =  dic[@"goods"];
        if (goodsArray.count<=0) {
            return;
        }
        jsonString=[Fcgo_publicNetworkTools arrayToJson:goodsArray];
        if ([dic.allKeys containsObject:@"areaID"]) {
            NSString *areaID = dic[@"areaID"];
            [paremtes setObjectWithNullValidate:areaID forKey:@"area"];
        }
    }
    else{
        return;
    }
    [paremtes  setObjectWithNullValidate:jsonString forKey:@"goods"];
    [WSProgressHUD showWithStatus:@"订单确认中..." maskType:WSProgressHUDMaskTypeClear];
    [Fcgo_NetworkManager postRequest:NSFormatHeardMeThodUrl(ServiceLocalTypeOne, ORDERMETHOD, @"prepare") parametersContentCommon:paremtes successBlock:^(BOOL success, id responseObject, NSString *msg) {
        [WSProgressHUD dismiss];
        if (success) {
            NSDictionary *data = responseObject[@"data"];
                Fcgo_OrderBuyModel *model = [Fcgo_OrderBuyModel yy_modelWithDictionary:data];//[Fcgo_OrderBuyModel shareWithNSDictionary:data];
                Fcgo_OrderConfirmVC *vc = [[Fcgo_OrderConfirmVC alloc]init];
                vc.model = model;
            vc.paremtes = paremtes;
                vc.hidesBottomBarWhenPushed = 1;
            if([parentVC isKindOfClass:[UINavigationController class]]){
                [(UINavigationController *)parentVC pushViewController:vc animated:1];
            }else{
                [parentVC.navigationController pushViewController:vc animated:1];
            }
        }
    } failureBlock:^(NSString *description) {
    }];
}

@end
