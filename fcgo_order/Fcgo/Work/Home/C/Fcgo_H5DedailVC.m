//
//  Fcgo_H5DedailVC.m
//  Fcgo
//
//  Created by fcg on 2017/9/26.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_H5DedailVC.h"

#import "Fcgo_HomeWebView.h"

@interface Fcgo_H5DedailVC ()<UIScrollViewDelegate,UIWebViewDelegate>

@property (nonatomic,strong) Fcgo_HomeWebView *webView;

@end

@implementation Fcgo_H5DedailVC


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setMainH5View];
    
    [self.navigationView setupBackBtnBlock:^{
        [self.navigationController popViewControllerAnimated:YES];
    }];

    [self.navigationView setupBackTitle:@"返回"];

    [self.navigationView setupTitleLabelWithTitle:@"详情"];
    // Do any additional setup after loading the view.
}
-(void)setMainH5View{
    WEAKSELF(weakSelf)
    _webView = [[Fcgo_HomeWebView alloc] init];
    
    [_webView setUrlString:_urlStr];
    _webView.webView.scrollView.delegate = self;

    self.webView.webView.parentVC = self;
    self.webView.parentVC = self;
    self.webView.detailBlock = ^(NSString *urlStr) {
        if (![urlStr containsString:_urlStr]) {
            Fcgo_H5DedailVC *dvc = [[Fcgo_H5DedailVC alloc] init];
            dvc.urlStr = urlStr;
            dvc.hidesBottomBarWhenPushed = YES;
            [weakSelf.navigationController pushViewController:dvc animated:YES];
            
        }
        
    };
    [self.view addSubview:_webView];
    [self.view sendSubviewToBack:_webView];
    [_webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.view);
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).offset(64);
        make.bottom.equalTo(self.view);
    }];
    
    _webView.webView.scrollView.mj_header = [Fcgo_RefreshNormalHeader headerRefreshBlock:^{
        [_webView.webView reload];
        [_webView.webView.scrollView.header endRefreshing];
    }];
    _webView.webView.scrollView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [_webView.webView reload];
        [_webView.webView.scrollView.footer endRefreshing];
    }];
}


/*
-(void)setMainH5View{



    WEAKSELF(weakSelf)
    UIWebView *webView = [[UIWebView alloc] init];

    webView.scrollView.delegate = self;
    [self.view addSubview:webView];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:_urlStr]];
    [webView loadRequest:request];
    [self.view sendSubviewToBack:webView];
    [webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.view);
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).offset(64);
        make.bottom.equalTo(self.view);
    }];
    MJRefreshNormalHeader * header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        //        [_webView.webView.scrollView.mj_header  endRefreshing];
        //        [_webView.webView.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    }];
    header.arrowView.alpha = 0;
    header.lastUpdatedTimeLabel.hidden = YES;

    //    [header setTitle:@"" forState:3];
    webView.scrollView.mj_header = header;


    webView.scrollView.mj_header = [Fcgo_RefreshNormalHeader headerRefreshBlock:^{
        [webView reload];
        [webView.scrollView.header endRefreshing];
    }];
    webView.scrollView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [webView reload];
        [webView.scrollView.footer endRefreshing];
    }];


}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
