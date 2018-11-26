//
//  Fcgo_HomeVC_H5_V4.m
//  Fcgo
//
//  Created by huafanxiao on 2017/11/30.
//  Copyright © 2017年 Fcg. All rights reserved.
//

#import "Fcgo_HomeVCH5.h"

#import "Fcgo_HomeWebView.h"
#import "Fcgo_HomeNavView.h"

#import "Fcgo_ScanVC.h"
#import "Fcgo_SearchVC.h"
#import "Fcgo_MsgVC.h"
#import "Home_WholePointDetailVC.h"
#import "Fcgo_GoodsInfoVC.h"
#import "FLAnimatedImage.h"
#import "FLAnimatedImageView.h"
#import "UMMobClick/MobClick.h"

@interface Fcgo_HomeVCH5 ()<UIScrollViewDelegate,UIWebViewDelegate>
{
    NSTimer *_timer;
    NSTimer *_timer1;
}



@property (nonatomic,strong) Fcgo_HomeNavView *navView;
@property (nonatomic,strong) Fcgo_HomeWebView *webView;
@property (nonatomic,strong) FLAnimatedImageView *adImgView;

@end

@implementation Fcgo_HomeVCH5

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    CGFloat y = self.webView.webView.scrollView.contentOffset.y;
    CGFloat alpha = y/170;
    if (alpha>0.7) {
        [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleDefault];
    }
    else{
        [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleDefault];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent];
    //先发送版本跟新
    [Fcgo_publicNetworkTools postRequestViesion];
    [self startTimer];
    [self setNavView];
    [self setMainH5View];
    if (@available(iOS 11.0,*)) {
        self.webView.webView.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    
    [Fcgo_publicNetworkTools postRequestAreaLocalListSuccessBlock:nil failureBlock:nil];//地区数据
}

- (NSString *)homeUrl
{
    //NSLog(@"=======home===%@",[NSString stringWithFormat:@"%@?storeId=%@&token=%@",NSFormatHeardMeThodUrl(ServiceLocalTypeOne, @"", @"bis/show/index/first-page"),MerId,Token]);
    return [NSString stringWithFormat:@"%@?storeId=%@&token=%@",NSFormatHeardMeThodUrl(ServiceLocalTypeOne, @"", @"bis/show/index/first-page"),MerId,Token];
}

- (void)reloadRequest{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        self.webView.urlString = self.homeUrl;
//        [self.webView setUrlString:self.homeUrl];
//        [_webView.webView reload];
    });
}

- (void)showUIData:(BOOL)isShow
{
    [self showNoControl:!isShow titleString:@"网络错误,点击重新加载" imageString:@"ico_no-wifi"];
}

-(void)setMainH5View
{
    self.automaticallyAdjustsScrollViewInsets = 0;
    WEAKSELF(weakSelf)
    Fcgo_HomeWebView *webView = [[Fcgo_HomeWebView alloc] init];
    webView.frame = CGRectMake(0, 0, kScreenWidth, KScreenHeight-49);
    [webView.webView.scrollView setContentSize:CGSizeMake(0, 0)];
    [webView setUrlString:self.homeUrl];
    webView.webView.scrollView.delegate = self;
    webView.detailBlock = ^(NSString *urlStr) {
        [weakSelf.webView.webView.scrollView.mj_header endRefreshing];
        if (![urlStr containsString:weakSelf.homeUrl]) {
            Fcgo_BasicShowWebViewVC *dvc = [[Fcgo_BasicShowWebViewVC alloc] init];
            dvc.urlString = urlStr;
            //BOOL isContent = [urlStr containsString:@"ddhshop.com/"];
            dvc.isShowNavBar = YES;
            dvc.hidesBottomBarWhenPushed = YES;
            [weakSelf.navigationController pushViewController:dvc animated:YES];
        }
    };
    webView.failBlock = ^{
        [weakSelf.webView.webView.scrollView.mj_header endRefreshing];
    };
    webView.successBlock = ^{
        [weakSelf.webView.webView.scrollView.mj_header endRefreshing];
    };
    self.webView = webView;
    [self.view insertSubview:self.webView belowSubview:self.navigationView];
    _webView.webView.scrollView.mj_header = [Fcgo_RefreshNormalHeader headerRefreshBlock:^{
            //[weakSelf.webView setUrlString:self.homeUrl];
            [weakSelf.webView.webView reload];
    }];
    //断网防崩溃
    if (![Fcgo_Tools isNetworkConnected])
    {
        [WSProgressHUD showImage:nil status:@"亲,没联网啊"];
        [self showUIData:NO];
        return;
    }
}

-(void)setNavView
{
    WEAKSELF(weakSelf)
    Fcgo_HomeNavView *navView = [[Fcgo_HomeNavView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kNavigationHeight) ofScan:^{
        
//        Fcgo_GoodsInfoVC *vc = [[Fcgo_GoodsInfoVC alloc]init];
//        vc.hidesBottomBarWhenPushed = YES;
//        vc.goodsType = @"integral";
//        vc.goodsValue = @"2203";
//        [weakSelf.navigationController pushViewController:vc animated:YES];
        
        Fcgo_ScanVC *vc = [[Fcgo_ScanVC alloc]init];
        vc.hidesBottomBarWhenPushed = YES;
        [weakSelf.navigationController pushViewController:vc animated:YES];

    } ofSearch:^{
        Fcgo_SearchVC *vc = [[Fcgo_SearchVC alloc]init];
        vc.hidesBottomBarWhenPushed = YES;
        [weakSelf.navigationController pushViewController:vc animated:YES];
    } ofMsg:^{
        Fcgo_MsgVC *msgVC = [[Fcgo_MsgVC alloc]init];
        msgVC.hidesBottomBarWhenPushed =  YES;
        [weakSelf.navigationController pushViewController:msgVC animated:YES];
        
    }];
    self.navView = navView;
    [self.navigationView addSubview:navView];
    [self.navigationView bringSubviewToFront:navView];
    self.navigationView.alphaImageView.backgroundColor = UIFontWhiteColor;
    self.navigationView.bgAlpha = 0;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat y = scrollView.contentOffset.y;
    CGFloat alpha = y/170;
    if (y<0) {
        self.navView.alpha = 0;
        self.navigationView.isShowLine = 0;
    }else{
        self.navView.alpha = 1;
        self.navigationView.isShowLine = 1;
    }
    if (alpha>0.7) {
        [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleDefault];
    }
    else{
        [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent];
    }
    self.navView.bgAlpha = alpha;
    self.navigationView.bgAlpha = alpha;
}
#pragma mark - 用于处理抢购相关倒计时功能的刷新
- (void)startTimer
{
    //全局的秒倒计时
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.f target:self selector:@selector(refreshLessTime) userInfo:@"" repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:UITrackingRunLoopMode];
    
    /*/全局的毫秒秒倒计时
    _timer1 = [NSTimer scheduledTimerWithTimeInterval:0.1f target:self selector:@selector(refreshLessTime1) userInfo:@"" repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_timer1 forMode:UITrackingRunLoopMode];*/
}

- (void)refreshLessTime
{
    //倒计时发送通知
    [[NSNotificationCenter defaultCenter]postNotificationName:@"countdown" object:nil];
}

- (void)refreshLessTime1
{
    //倒计时发送通知
    [[NSNotificationCenter defaultCenter]postNotificationName:@"countdown1" object:nil];
}


- (void)dealloc
{
    [_timer invalidate];
    _timer = nil;
    
    [_timer1 invalidate];
    _timer1 = nil;
}

@end

