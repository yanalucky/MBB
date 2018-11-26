//
//  Fcgo_HomeWebView.h
//  Fcgo
//
//  Created by fcg on 2017/9/22.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Fcgo_HomeWebView : UIView

@property (nonatomic,copy) void(^detailBlock)(NSString *urlStr);
@property (nonatomic, copy) void(^failBlock)(void);
@property (nonatomic,copy)   NSString *urlString;
@property (nonatomic,strong) UIViewController *parentVC;
@property (nonatomic,strong) Fcgo_BasicWebView *webView;

@property (nonatomic,copy) void(^returnHeightBlock)(CGFloat height);
@property (nonatomic,assign) CGFloat height;

@end
