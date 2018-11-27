//
//  BannerViewController.m
//  BabyDemo
//
//  Created by 曹露 on 16/9/12.
//  Copyright © 2016年 elsa. All rights reserved.
//

#import "BannerViewController.h"
#import "SVProgressHUD.h"

@interface BannerViewController ()<UIWebViewDelegate>


@end

@implementation BannerViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    //    if (_isFirstUnit == YES) {
    //        self.title = @"育儿小课堂";
    //    }else{
    //        self.title = @"育儿知识";
    //
    //    }
    self.title = _titleStr;
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self createWebView];
    // Do any additional setup after loading the view.
}

#pragma mark - UIWebView
-(void)createWebView{
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    [SVProgressHUD setBackgroundLayerColor:[UIColor colorWithWhite:0 alpha:0.]];
    [SVProgressHUD show];
    UIWebView *webView = [[UIWebView alloc] init];
    webView.backgroundColor = [UIColor whiteColor];
    webView.scrollView.backgroundColor = [UIColor whiteColor];
    if (_bannerUrl&&_bannerUrl.length > 0) {
        NSURL *url = [NSURL URLWithString:_bannerUrl];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [webView loadRequest:request];
    }else{
        [webView loadHTMLString:_contentHtmlStr baseURL:nil];

    }
    /*加载网页
     1.网址的字符串：@""
     NSString *str = @"http://www.baidu.com";
     2.str --> 网址url
     NSURL *url = [NSURL URLWithString:str];
     3.url --> NSURLRequest
     NSURLRequest *request = [NSURLRequest requestWithURL:url];
     4.webView加载请求
     [webView loadRequest:request];
     
     */
    
    
    //5.调整页面
    webView.scalesPageToFit = NO;
    
    //6.代理
    webView.delegate = self;
    webView.scrollView.scrollIndicatorInsets = UIEdgeInsetsMake(0, 3*Ratio, 0, -3*Ratio);
    [self.view addSubview:webView];
    
    [webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(10);
        make.right.equalTo(self.view).offset(-10);
        make.top.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
    
    //    float fontSize = 24;
    //    UIFont *fontFamily = [UIFont fontWithName:@"MicrosoftYaHei" size:fontSize];
    //    NSString *jsString = [NSString stringWithFormat:@"<html> \n""<head> \n""<style type=\"text/css\"> \n""body {font-size: %f; font-family: \"%@\"; color: %@;}\n""</style> \n""</head> \n""<body>%@</body> \n""</html>", fontSize, fontFamily, fontColor, htmlText];
    //    [webView loadHTMLString:jsString baseURL:nil];
    
}
#pragma mark - UIWebViewDelegate相关
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    [SVProgressHUD dismiss];
    NSLog(@"加载完成");
}
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    NSLog(@"加载失败:%@",error);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end