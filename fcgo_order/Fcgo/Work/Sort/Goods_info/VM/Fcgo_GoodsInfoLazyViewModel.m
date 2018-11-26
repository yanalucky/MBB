//
//  Fcgo_GoodsInfoLazyViewModel.m
//  Fcgo
//
//  Created by huafanxiao on 2017/12/25.
//  Copyright © 2017年 Fcg. All rights reserved.
//

#import "Fcgo_GoodsInfoLazyViewModel.h"
#import "Fcgo_MsgVC.h"
#import "Fcgo_CollectVC.h"
#import "Fcgo_GoodsListVC.h"
#import "Fcgo_ContactServiceVC.h"

@interface Fcgo_GoodsInfoLazyViewModel ()<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>

//@property (nonatomic,strong) Fcgo_BasicVC *parentVC;

@end


@implementation Fcgo_GoodsInfoLazyViewModel

//导航条
+ (Fcgo_GoodsInfoNavigationView *)navigation_view
{
   Fcgo_GoodsInfoNavigationView *navigation_view = [[Fcgo_GoodsInfoNavigationView alloc]initWithFrame:CGRectMake(50, kNavigationSubY(20), kScreenWidth - 100, 44)];
    return navigation_view;
}

+ (UITableView *)tableWithDeledateVC:(Fcgo_BasicVC *)delegateVC
{
    UITableView *table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, KScreenHeight-50) style:UITableViewStylePlain];
    table.delegate   = delegateVC;
    table.dataSource = delegateVC;
    table.separatorStyle = 0;
    table.backgroundColor = UIFontClearColor;
    table.showsVerticalScrollIndicator = NO;
    table.contentInset = UIEdgeInsetsMake(kNavigationHeight, 0, 0, 0);
    //table.tableHeaderView = self.tableCycleView;
    if (@available(iOS 11.0, *)) {
        table.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    table.tableFooterView = [self table_footerView];
    if (@available(iOS 11.0, *)) {
        table.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    return table;
}

+ (UIView *)table_footerView
{
    UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 50)];
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.text = @"上拉查看图文详情";
    titleLabel.textColor = UIFontMiddleGrayColor;
    titleLabel.font = [UIFont systemFontOfSize:14];
    [footerView addSubview:titleLabel];
    
    UIImageView *iconImageView = [[UIImageView alloc]init];
    iconImageView.image = [UIImage imageWithName:@"up_arrow_detail" ofType:@"png"];
    [footerView addSubview:iconImageView];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(footerView.mas_centerX).mas_offset(15);
        make.left.mas_equalTo(iconImageView.mas_right).mas_offset(5);
        make.centerY.mas_equalTo(footerView.mas_centerY);
    }];
    
    [iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(titleLabel.mas_left).mas_offset(0);
        make.centerY.mas_equalTo(footerView.mas_centerY);
        make.width.mas_offset(30);
        make.height.mas_offset(20);
        
    }];
    return footerView;
}

+ (FDDemoScrollView *)h_scrollViewWithDeledateVC:(Fcgo_BasicVC *)delegateVC;
{
    FDDemoScrollView *h_scrollView = [self scrollView];
    h_scrollView.contentSize = CGSizeMake(kScreenWidth*2, 0);
    h_scrollView.delegate = delegateVC;
    h_scrollView.scrollEnabled = 1;
    return h_scrollView;
}

+ (FDDemoScrollView *)v_scrollViewWithDeledateVC:(Fcgo_BasicVC *)delegateVC;
{
    FDDemoScrollView *v_scrollView = [self scrollView];
    v_scrollView.contentSize = CGSizeMake(0, KScreenHeight*2);
    v_scrollView.delegate = delegateVC;
    return v_scrollView;
}

+ (FDDemoScrollView *)scrollView
{
    FDDemoScrollView *scrollView = [[FDDemoScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, KScreenHeight)];
    scrollView.bounces = 0;
    scrollView.scrollEnabled = 0;
    scrollView.pagingEnabled = 1;
    scrollView.showsVerticalScrollIndicator = 0;
    //scrollView.hidden = 1;
    if (@available(iOS 11.0, *)) {
        scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    return scrollView;
}

+ (UIWebView *)v_webView
{
    UIWebView *v_webView = [self webView];
    v_webView.frame = CGRectMake(0, KScreenHeight, kScreenWidth, KScreenHeight-50);
    return v_webView;
}

+ (UIWebView *)h_webView
{
    UIWebView *h_webView = [self webView];
    h_webView.frame = CGRectMake(kScreenWidth, 0, kScreenWidth, KScreenHeight-50);
    return h_webView;
}

+ (UIWebView *)webView
{
    UIWebView *webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, KScreenHeight, kScreenWidth, KScreenHeight-50)];
    webView.scalesPageToFit = 1;
    webView.backgroundColor = UIFontWhiteColor;
    webView.hidden = 0;
    webView.scrollView.contentInset = UIEdgeInsetsMake(kNavigationHeight, 0, 0, 0);
    if (@available(iOS 11.0, *)) {
        webView.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    return webView;
}

+ (SDCycleScrollView *)cycleViewWithDeledateVC:(Fcgo_BasicVC *)delegateVC
{
    SDCycleScrollView *cycleView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, kScreenWidth,kScreenWidth) delegate:delegateVC placeholderImage:nil];
    cycleView.autoScroll = 0;
    cycleView.backgroundColor = UIFontClearColor;
    cycleView.mainView.backgroundColor = UIFontClearColor;
    cycleView.currentPageDotColor = UIFontRedColor;
    cycleView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
    //cycleView.mainView.tag = 503;
    //        cycleView.observeBlock = ^(CGFloat offsetX){
    //            [self.bgCycleView.mainView setContentOffset:CGPointMake(offsetX, 0)];
    //        };
    return cycleView;
}

@end
