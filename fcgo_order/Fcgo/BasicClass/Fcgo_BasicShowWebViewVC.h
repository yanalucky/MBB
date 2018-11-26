//
//  Fcgo_BasicShowWebViewVC.h
//  Fcgo
//
//  Created by huafanxiao on 2017/5/12.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Fcgo_HomeWebView.h"
//@class Fcgo_HomeWebView;
@interface Fcgo_BasicShowWebViewVC : Fcgo_BasicVC

@property (nonatomic,strong) NSString  *urlString;  //url地址
@property (nonatomic,strong) NSString  *htmlString; //html标签
@property (nonatomic,strong) NSString  *titleString;//title

@property (nonatomic,strong) Fcgo_HomeWebView *webView;


@property (nonatomic,assign) BOOL isShowNavBar;
@end
