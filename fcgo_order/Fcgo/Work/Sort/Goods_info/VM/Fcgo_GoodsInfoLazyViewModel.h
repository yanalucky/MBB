//
//  Fcgo_GoodsInfoLazyViewModel.h
//  Fcgo
//
//  Created by huafanxiao on 2017/12/25.
//  Copyright © 2017年 Fcg. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Fcgo_GoodsInfoNavigationView.h"

@interface Fcgo_GoodsInfoLazyViewModel : NSObject

+ (Fcgo_GoodsInfoNavigationView *)navigation_view;
+ (UITableView *)tableWithDeledateVC:(Fcgo_BasicVC *)delegateVC;
+ (FDDemoScrollView *)h_scrollViewWithDeledateVC:(Fcgo_BasicVC *)delegateVC;
+ (FDDemoScrollView *)v_scrollViewWithDeledateVC:(Fcgo_BasicVC *)delegateVC;
+ (UIWebView *)v_webView;
+ (UIWebView *)h_webView;
+ (SDCycleScrollView *)cycleViewWithDeledateVC:(Fcgo_BasicVC *)delegateVC;
@end
