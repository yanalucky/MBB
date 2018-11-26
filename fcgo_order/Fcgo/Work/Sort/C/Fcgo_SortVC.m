//
//  Fcgo_SortVC.m
//  Fcgo
//
//  Created by huafanxiao on 2017/5/10.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_SortVC.h"
#import "Fcgo_SortLeftTableView.h"
#import "Fcgo_SortRightCollectionView.h"
#import "Fcgo_SortModel.h"
#import "Fcgo_TotalBrandVC.h"
#import "Fcgo_SortModel.h"
#import "Fcgo_GoodsListVC.h"

@interface Fcgo_SortVC ()

@property (nonatomic,strong) Fcgo_SortLeftTableView       *leftTableView;
@property (nonatomic,strong) Fcgo_SortRightCollectionView *rightCollectionView;
@property (nonatomic,strong) NSMutableArray               *sortMutableArray;

@end

@implementation Fcgo_SortVC

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleDefault];
}

- (void)reloadRequest
{
    if (![Fcgo_Tools isNetworkConnected]) {
        [WSProgressHUD showImage:nil status:@"亲,没联网啊"];
        [self showUIData:NO];
        return;
    }
    [WSProgressHUD showWithStatus:@"加载中..." maskType:WSProgressHUDMaskTypeClear];
    WEAKSELF(weakSelf);
    [Fcgo_NetworkManager postRequest:NSFormatHeardMeThodUrl(ServiceLocalTypeOne,GOODMETHOD, @"cate/communication") parametersContentCommon:nil successBlock:^(BOOL success, id responseObject, NSString *msg) {
       if (success) {
           [weakSelf showUIData:1];
           NSArray *sortArray = responseObject[@"data"];;
           for (int i = 0; i < sortArray.count; i ++) {
               NSDictionary *sortDic = sortArray[i];
               Fcgo_SortModel *model = [Fcgo_SortModel shareWithNSDictionary:sortDic];
               [weakSelf.sortMutableArray addObject:model];
           }
           weakSelf.leftTableView.sortArray = weakSelf.sortMutableArray;
           Fcgo_SortModel *model =  weakSelf.sortMutableArray[0];
           weakSelf.rightCollectionView.sortModel = model;
           [WSProgressHUD dismiss];
       }else{
           [weakSelf showUIData:0];
       }
    } failureBlock:^(NSString *description) {
    [weakSelf showUIData:0];
    }];
}

- (void)showUIData:(BOOL)isShow
{
    [self showNoControl:!isShow titleString:@"网络错误,点击重新加载" imageString:@"ico_no-wifi"];
    self.leftTableView.hidden = !isShow;
    self.rightCollectionView.hidden = !isShow;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupUI];
    [self reloadRequest];
}

- (void)setupUI
{
    WEAKSELF(weakSelf)
    [self.navigationView setupTitleLabelWithTitle:@"分类"];
    
    self.leftTableView.didSelectedBlock = ^(Fcgo_SortModel *model){
        weakSelf.rightCollectionView.sortModel = model;
    };
    [self.view addSubview:self.leftTableView];

    self.rightCollectionView.didSelectHeaderBlock = ^(Fcgo_SortModel *sortModel) {
        [Fcgo_App_acrossTools app_acrossWithJsonString:sortModel.href webView:nil parentVC:weakSelf];
    };
    
    self.rightCollectionView.didSelectCateBlock = ^(Fcgo_CateModel *model){
        //选中二级分类，跳转列表页
        Fcgo_GoodsListVC *vc = [[Fcgo_GoodsListVC alloc]init];
        vc.hidesBottomBarWhenPushed = 1;
        vc.catemIds = [NSString stringWithFormat:@"%@",model.cate_id];
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
    self.rightCollectionView.didSelectBrandBlock = ^(Fcgo_SortModel *sortModel,Fcgo_BrandModel *model){
        //选中品牌，跳转列表页
        Fcgo_GoodsListVC *vc = [[Fcgo_GoodsListVC alloc]init];
        vc.hidesBottomBarWhenPushed = 1;
        vc.brandIds = [NSString stringWithFormat:@"%@",model.brand_id];
        vc.cateIds = [NSString stringWithFormat:@"%@",sortModel.sort_id];
        
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
    self.rightCollectionView.gotTotalBrandBlock = ^{
        //所有品牌
        Fcgo_TotalBrandVC *vc = [[Fcgo_TotalBrandVC alloc]init];
        vc.hidesBottomBarWhenPushed = 1;
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
    [self.view addSubview:self.rightCollectionView];
}

- (Fcgo_SortLeftTableView *)leftTableView
{
    if (!_leftTableView) {
        _leftTableView = [[Fcgo_SortLeftTableView alloc]initWithFrame:CGRectMake(0, kNavigationHeight, kAutoWidth6(90), KScreenHeight - kNavigationHeight - kTabBarHeight)];
        _leftTableView.hidden = 1;
    }
    return _leftTableView;
}

- (Fcgo_SortRightCollectionView *)rightCollectionView
{
    if (!_rightCollectionView) {
        _rightCollectionView = [[Fcgo_SortRightCollectionView alloc]initWithFrame:CGRectMake(self.leftTableView.mj_w, kNavigationHeight, kScreenWidth - self.leftTableView.mj_w, KScreenHeight - kNavigationHeight - kTabBarHeight)];
        _rightCollectionView.hidden = 1;
    }
    return _rightCollectionView;
}

- (NSMutableArray *)sortMutableArray
{
    if (!_sortMutableArray) {
        _sortMutableArray = [[NSMutableArray alloc]init];
    }
    return _sortMutableArray;
}
@end
