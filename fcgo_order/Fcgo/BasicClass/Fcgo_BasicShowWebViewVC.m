//
//  Fcgo_BasicShowWebViewVC.m
//  Fcgo
//
//  Created by huafanxiao on 2017/5/12.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_BasicShowWebViewVC.h"
#import "Fcgo_BasicWebViewProgressView.h"
#import "Fcgo_HomeWebView.h"

@interface Fcgo_BasicShowWebViewVC ()

@property (nonatomic,strong) Fcgo_BasicWebViewProgressView  *progressLine;

@end

@implementation Fcgo_BasicShowWebViewVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    WEAKSELF(weakSelf)
    [self.navigationView setupBackBtnBlock:^{
        if([weakSelf.webView.webView canGoBack])
        {
            [weakSelf.webView.webView goBack];
        }else{
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }
    }];
    [self.view insertSubview:self.webView belowSubview:self.navigationView];
    [_webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.view);
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).offset((_isShowNavBar == YES)?kNavigationHeight:0);
        make.bottom.equalTo(self.view);
    }];
    [self.navigationView addSubview:self.progressLine];
    
    [self reloadRequest];
    
}

- (void)reloadRequest
{
    if (self.urlString) {
        [self.webView setUrlString:self.urlString];
    }
    if (self.htmlString) {
        if ([self.htmlString containsString:@"18px"]) {
            self.htmlString = [self.htmlString stringByReplacingOccurrencesOfString:@"18px" withString:@"16px"];
        }
        [self.webView.webView loadHTMLString:self.htmlString baseURL:nil];
    }
}



- (void)showUIData:(BOOL)isShow
{
    [self showNoControl:!isShow titleString:@"网络错误,点击重新加载" imageString:@"ico_no-wifi"];
    self.webView.hidden = !isShow;
}

#pragma mark Lazy method

- (Fcgo_HomeWebView *)webView
{
    if (!_webView) {
        
        WEAKSELF(weakSelf)
        _webView = [[Fcgo_HomeWebView alloc] init];
        _webView.detailBlock = ^(NSString *urlStr) {
            [weakSelf.webView.webView.scrollView.mj_header endRefreshing];
            [weakSelf.webView.webView.scrollView.mj_footer endRefreshing];
            if (![urlStr containsString:weakSelf.urlString]) {
                //            Fcgo_H5DedailVC *dvc = [[Fcgo_H5DedailVC alloc] init];
                //            dvc.urlStr = urlStr;
                Fcgo_BasicShowWebViewVC *dvc = [[Fcgo_BasicShowWebViewVC alloc] init];
                dvc.urlString = urlStr;
                //BOOL isContent = [urlStr containsString:@"ddhshop.com/"];
                //dvc.isShowNavBar = !isContent;
                dvc.isShowNavBar = YES;
                dvc.hidesBottomBarWhenPushed = YES;
                [weakSelf.navigationController pushViewController:dvc animated:YES];
            }
        };
        _webView.LoadStartBlock = ^{
            [weakSelf.progressLine startLoadingAnimation];
        };
        _webView.successBlock = ^{
            [weakSelf showUIData:1];
            [weakSelf.progressLine endLoadingAnimation];
            //weakSelf.navigationView.hidden = !weakSelf.isShowNavBar;
            if (!weakSelf.titleString) {
                [weakSelf.navigationView setupTitleLabelWithTitle:[weakSelf.webView.webView stringByEvaluatingJavaScriptFromString:@"document.title"]];
                return;
            }
            [weakSelf.navigationView setupTitleLabelWithTitle:weakSelf.titleString];
            
            ////修改字体大小
            NSString *str = @"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '250%'";
            [weakSelf.webView.webView stringByEvaluatingJavaScriptFromString:str];
            
            
            NSString *js=@"var script = document.createElement('script');"
            "script.type = 'text/javascript';"
            "script.text = \"function ResizeImages() { "
            "var myimg,oldwidth;"
            "var maxwidth = %f;"
            "for(i=0;i <document.images.length;i++){"
            "myimg = document.images[i];"
            "if(myimg.width > maxwidth){"
            "oldwidth = myimg.width;"
            "myimg.width = %f;"
            "}"
            "}"
            "}\";"
            "document.getElementsByTagName('head')[0].appendChild(script);";
            js=[NSString stringWithFormat:js,[UIScreen mainScreen].bounds.size.width,[UIScreen mainScreen].bounds.size.width-15];
            [weakSelf.webView.webView stringByEvaluatingJavaScriptFromString:js];
            [weakSelf.webView.webView stringByEvaluatingJavaScriptFromString:@"ResizeImages();"];
            
        };
        _webView.failBlock = ^{
            [weakSelf.webView.webView.scrollView.mj_header endRefreshing];
            [weakSelf.webView.webView.scrollView.mj_footer endRefreshing];
            [weakSelf showUIData:0];
            
        };
    }
    return _webView;
}

- (Fcgo_BasicWebViewProgressView *)progressLine
{
    if (!_progressLine) {
        _progressLine = [[Fcgo_BasicWebViewProgressView alloc] initWithFrame:CGRectMake(0, kNavigationHeight, 0, 2)];
    }
    return _progressLine;
}
@end
