//
//  Fcgo_ShowAndTouchInteractionWebViewVC.m
//  Fcgo
//
//  Created by huafanxiao on 2017/5/15.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_ShowAndTouchInteractionWebViewVC.h"
#import "Fcgo_BasicWebViewProgressView.h"


@interface Fcgo_ShowAndTouchInteractionWebViewVC ()


@property (nonatomic,strong) Fcgo_BasicWebViewProgressView  *progressLine;

@end

@implementation Fcgo_ShowAndTouchInteractionWebViewVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    WEAKSELF(weakSelf)
    //如果不是一级VC，带导航返回按钮
    if(!self.isFirstVC)
    {
        [self.navigationView setupBackBtnBlock:^{
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }];
    }
    [self reloadRequest];
    [self.view insertSubview:self.webView belowSubview:self.navigationView];
    [self.navigationView addSubview:self.progressLine];
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.top.mas_equalTo(0);
    }];
}

- (void)reloadRequest {
    if (self.urlString) {
        self.webView.urlString = self.urlString;
    }
}

#pragma mark Lazy method

- (Fcgo_BasicWebView *)webView
{
    WEAKSELF(weakSelf)
    if (!_webView) {
        _webView = [[Fcgo_BasicWebView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, KScreenHeight) ofStart:^{
            [weakSelf.progressLine startLoadingAnimation];
        } ofSuccess:^{
            [weakSelf finishLoadStatus:1];
            [weakSelf showUIData:1];
        } ofFail:^{
            [weakSelf finishLoadStatus:0];
            [weakSelf showUIData:0];
        }];
        _webView.backgroundColor = [UIColor whiteColor];
    }
    return _webView;
}

- (void)showUIData:(BOOL)isShow
{
    [self showNoControl:!isShow titleString:@"网络错误,点击重新加载" imageString:@"ico_no-wifi"];
    self.webView.hidden = !isShow;
}

- (void)finishLoadStatus:(BOOL)success
{
    if (self.webView) {
       self.webView.alpha = success;
    }
    [UIView animateWithDuration:0.1 animations:^{
        self.navigationView.alpha = !success;
    }];
    //self.notConnectControl.alpha = !success;
    [self.progressLine endLoadingAnimation];
}

- (Fcgo_BasicWebViewProgressView *)progressLine
{
    if (!_progressLine) {
        _progressLine = [[Fcgo_BasicWebViewProgressView alloc] initWithFrame:CGRectMake(0, kNavigationHeight, 0, 2)];
    }
    return _progressLine;
}

@end
