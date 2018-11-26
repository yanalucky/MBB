//
//  Fcgo_ShowAndTouchInteractionWebViewVC.h
//  Fcgo
//
//  Created by huafanxiao on 2017/5/15.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_BasicVC.h"
#import "Fcgo_BasicWebView.h"

@interface Fcgo_ShowAndTouchInteractionWebViewVC : Fcgo_BasicVC

@property (nonatomic,strong) NSString *urlString;  //url地址
@property (nonatomic,strong) Fcgo_BasicWebView  *webView;
//是不是一级VC,一级VC没有默认的导航返回按钮。一级VC为微店首页
@property (nonatomic,assign) BOOL isFirstVC;

@end
