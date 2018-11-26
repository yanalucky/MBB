//
//  Fcgo_Coupon_UIBaisc_VC.m
//  Fcgo
//
//  Created by huafanxiao on 2017/5/26.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_Coupon_UIBaisc_VC.h"
#import "Fcgo_CouponTableViewCell.h"
#import "Fcgo_CouponModel.h"
#import "Fcgo_CouponRunModel.h"

@interface Fcgo_Coupon_UIBaisc_VC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) NSMutableArray *couponArray;
@property (nonatomic,strong) UITableView    *table;
@property (nonatomic,assign) BOOL isCangetCoupon;
@property (nonatomic,assign) int type;
@end

@implementation Fcgo_Coupon_UIBaisc_VC

- (void)requestCouponListWithType:(int)type
{
    self.type = type;
    [self reloadRequest];
}

- (void)reloadRequest
{
    if (![Fcgo_Tools isNetworkConnected]) {
        [WSProgressHUD showImage:nil status:@"亲,没联网啊"];
        [self showUIData:NO];
        return;
    }
    [WSProgressHUD showWithStatus:@"数据加载..." maskType:WSProgressHUDMaskTypeClear];
    //0是运营的
    if (self.type == 0) {
        [self requestRunningCouponList];
    }
    //1 2 3是商户的
    else{
        [self requestBusCouponListWithType:self.type];
    }
}
//获取商户类的优惠券
- (void)requestBusCouponListWithType:(int)type
{
    WEAKSELF(weakSelf);
    NSMutableDictionary  *muatble = [NSMutableDictionary dictionary];
    [muatble  setObjectWithNullValidate:[NSString stringWithFormat:@"%d",type+1] forKey:@"status"];
    [Fcgo_NetworkManager postRequest:NSFormatHeardMeThodUrl(ServiceLocalTypeOne,COUPON,@"getStoreCoupons") parametersContentCommon:muatble successBlock:^(BOOL success, id responseObject, NSString *msg) {
        ///NSLog(@">>>>%@",responseObject);
        [WSProgressHUD dismiss];
        [weakSelf.table.mj_header endRefreshing];
        [weakSelf.couponArray removeAllObjects];
        if (success) {
            NSArray   *listArray = responseObject[@"data"][@"data"];
            for (int i = 0; i < listArray.count; i ++) {
                NSDictionary *couponDict = listArray[i];
                Fcgo_CouponModel *model = [Fcgo_CouponModel yy_modelWithDictionary:couponDict];
                [weakSelf.couponArray addObject:model];
            }
            if (weakSelf.couponArray.count<=0) {
                [weakSelf showMoreUIData:0];
            }
            else{
                [weakSelf showMoreUIData:1];
            }
            [weakSelf.table reloadData];
        }
        else
        {
            [weakSelf showUIData:0];
        }
    } failureBlock:^(NSString *description) {
        [weakSelf showUIData:0];
        [weakSelf.table.mj_header endRefreshing];
    }];
}

- (void)showUIData:(BOOL)isShow
{
    [self showNoControl:!isShow titleString:@"网络错误,点击重新加载" imageString:@"ico_no-wifi"];
    [self updateNoControlFrame];

    self.table.hidden = !isShow;
}

- (void)showMoreUIData:(BOOL)isShow
{
    [self showNoControl:!isShow titleString:@"暂无优惠券" imageString:@"ico_no-discount"];
    [self updateNoControlFrame];
    self.table.hidden = !isShow;
}

//获取运营类的可领取优惠券
- (void)requestRunningCouponList
{
    self.isCangetCoupon = YES;
    WEAKSELF(weakSelf);
    [Fcgo_NetworkManager postRequest:NSFormatHeardMeThodUrl(ServiceLocalTypeOne,COUPON,@"getCanDrawCoupons") parametersContentCommon:nil successBlock:^(BOOL success, id responseObject, NSString *msg) {
        //NSLog(@">>>>>>>>>%@",responseObject);
        [WSProgressHUD dismiss];
        [weakSelf.table.mj_header endRefreshing];
        [weakSelf.couponArray removeAllObjects];
        if (success) {
            NSArray   *listArray = responseObject[@"data"];
            for (int i = 0; i < listArray.count; i ++) {
                NSDictionary *couponDict = listArray[i];
                Fcgo_CouponRunModel *model = [Fcgo_CouponRunModel yy_modelWithDictionary:couponDict];
                [weakSelf.couponArray addObject:model];
            }
            if (weakSelf.couponArray.count<=0) {
                [weakSelf showMoreUIData:0];
            }
            else{
                [weakSelf showMoreUIData:1];
            }
            [weakSelf.table reloadData];
        }
        else
        {
            [weakSelf showUIData:0];
        }
        
    } failureBlock:^(NSString *description) {
        [weakSelf showUIData:0];
        [weakSelf.table.mj_header endRefreshing];
    }];
}

- (void)requestGetCouponWithModel:(Fcgo_CouponRunModel *)model
{
    WEAKSELF(weakSelf);
    NSMutableDictionary  *muatble = [NSMutableDictionary dictionary];
    [muatble  setObjectWithNullValidate:model.coupon_id forKey:@"couponId"];
    [WSProgressHUD showWithStatus:@"领取中..." maskType:WSProgressHUDMaskTypeClear];
    [Fcgo_NetworkManager postRequest:NSFormatHeardMeThodUrl(ServiceLocalTypeOne,COUPON,@"drawCoupon") parametersContentCommon:muatble successBlock:^(BOOL success, id responseObject, NSString *msg) {
        [WSProgressHUD dismiss];
        if (success) {
           [WSProgressHUD showSuccessWithStatus:@"领取成功"];
                //重新调取列表，刷新数据
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [weakSelf requestRunningCouponList];
                });
            }
        else
        {
            
        }
    } failureBlock:^(NSString *description) {
        
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    self.navigationView.isShowLine = 0;
}

- (void)setupUI
{
    WEAKSELF(weakSelf);
    self.table.mj_header = [Fcgo_RefreshNormalHeader headerRefreshBlock:^{
        if (weakSelf.isCangetCoupon) {
            [weakSelf requestRunningCouponList];
        }else{
            [weakSelf requestCouponListWithType:weakSelf.type];
        }
    }];
    [self.table registerNib:[UINib nibWithNibName:NSStringFromClass([Fcgo_CouponTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"couponTableViewCell"];
    [self.view addSubview:self.table];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.couponArray.count > 0) {
        return [self.couponArray count];
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Fcgo_CouponTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"couponTableViewCell"];
    if (self.couponArray.count > 0) {
        if (self.isCangetCoupon) {
            [cell showGetBtn];
            Fcgo_CouponRunModel *model = self.couponArray[indexPath.row];
            cell.runModel = model;
        }else{
            Fcgo_CouponModel *model = self.couponArray[indexPath.row];
            cell.model = model;
        }
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 105;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(self.isCangetCoupon)
    {
        Fcgo_CouponRunModel *model = self.couponArray[indexPath.row];
        //点击领取优惠券
        [self requestGetCouponWithModel:model];
    }
}

#pragma mark Lazy method

- (UITableView *)table
{
    if (!_table) {
        UITableView *table    = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, KScreenHeight - kNavigationHeight - 40) style:UITableViewStylePlain];
        table.backgroundColor = UIBackGroundColor;
        table.separatorStyle  = 0;
        table.delegate        = self;
        table.dataSource      = self;
        table.alpha           = 1;
        
        UIView *footerView   = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 5)];
        footerView.backgroundColor = UIBackGroundColor;
        table.tableFooterView = footerView;
        _table                = table;
        if (@available(iOS 11.0, *)) {
            table.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return _table;
}

- (NSMutableArray *)couponArray
{
    if (!_couponArray) {
        _couponArray = [[NSMutableArray alloc]init];
    }
    return _couponArray;
}

@end
