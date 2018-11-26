//
//  Fcgo_OrderDetailVC.m
//  Fcgo
//
//  Created by huafanxiao on 2017/5/25.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_OrderDetailVC.h"

#import "Fcgo_OrderDetailTableHeaderView.h"
#import "Fcgo_OrderDetailTopTableViewCell.h"
#import "Fcgo_OrderDetailGoodsTableViewCell.h"
#import "Fcgo_OrderDetailBottomTableViewCell.h"

#import "Fcgo_OrderDetailBottomView.h"
#import "Fcgo_LogisticsVC.h"
#import "Fcgo_ApplyAfterSalesServiceVC.h"
#import "Fcgo_OrderDetailModel.h"
#import "Fcgo_GoodsDetailVC.h"
#import "Fcgo_OrderPayVC.h"
#import "Fcgo_AfterSalesService_DetailVC.h"
#import "Fcgo_OrderDetailLeftMessageTableViewCell.h"
#import "Fcgo_ContactServiceVC.h"
#import "Fcgo_AfterServiceStyleVC.h"
#import "Fcgo_ApplyHistoryVC.h"


@interface Fcgo_OrderDetailVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView                *table;
@property (nonatomic,strong) Fcgo_OrderDetailBottomView *bottomView;
@property (nonatomic,strong) Fcgo_OrderDetailModel     *detailModel;
@end

@implementation Fcgo_OrderDetailVC

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    if (self && self.disappearBlock) {
        self.disappearBlock();
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [self.bottomView showWithAnimation];
    [super viewDidAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    [self requestLoadOrderDetail];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(requestLoadOrderDetail) name:@"applyFinish" object:nil];
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - private method


- (void)requestOrderDetail
{
    WEAKSELF(weakSelf);
    NSMutableDictionary  *muatble = [NSMutableDictionary dictionary];
    [muatble  setObjectWithNullValidate:[NSString stringWithFormat:@"%@",self.orderId] forKey:@"id"];
    [Fcgo_NetworkManager postRequest:NSFormatHeardMeThodUrl(ServiceLocalTypeOne, ORDERMETHOD, @"orderDetail") parametersContentCommon:muatble successBlock:^(BOOL success, id responseObject, NSString *msg) {
        [weakSelf.table.mj_header endRefreshing];
        if (success) {
            NSDictionary *data = responseObject[@"data"];
            weakSelf.detailModel = [Fcgo_OrderDetailModel yy_modelWithDictionary:data];
            NSTimeInterval time = [[NSDate date] timeIntervalSince1970];
            long long dTime = [[NSNumber numberWithDouble:time] longLongValue];
            long long nowTime = weakSelf.detailModel.now.longLongValue / 1000.0;
            weakSelf.detailModel.time_interval = nowTime - dTime;
            
            weakSelf.bottomView.orderType = weakSelf.detailModel.orderStatus.intValue;
            [weakSelf.table reloadData];
        }
    } failureBlock:^(NSString *description) {
        [weakSelf.table.mj_header endRefreshing];
    }];
}

- (void)requestLoadOrderDetail
{
    [WSProgressHUD showWithStatus:@"加载中"];
    [self requestOrderDetail];
}

- (void)pay {
    WEAKSELF(weakSelf);
    Fcgo_OrderPayVC *vc = [[Fcgo_OrderPayVC alloc] init];
    vc.orderNo = self.detailModel.orderNo;
    vc.hidesBottomBarWhenPushed = 1;
    vc.paySuccessBlock = ^{
        [weakSelf requestOrderDetail];
    };
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)cancel {
    WEAKSELF(weakSelf);
    NSMutableDictionary  *muatble = [NSMutableDictionary dictionary];
    [muatble  setObjectWithNullValidate:[NSString stringWithFormat:@"%@",self.orderId] forKey:@"orderId"];
    [WSProgressHUD showWithStatus:@"加载中..." maskType:(WSProgressHUDMaskTypeDefault)];
    [Fcgo_NetworkManager postRequest:NSFormatHeardMeThodUrl(ServiceLocalTypeOne, ORDERMETHOD, @"cancelOrder") parametersContentCommon:muatble successBlock:^(BOOL success, id responseObject, NSString *msg) {
       if (success) {
            [WSProgressHUD showImage:nil status:@"取消成功"];
           dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.7 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
               [weakSelf requestLoadOrderDetail];
           });
        }
    } failureBlock:^(NSString *description) {
        
    }];
}

- (void)service {
//    UIWebView *webview = [[UIWebView alloc] init];
//    [webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",[[Fcgo_UserTools shared] tel]]]]];
//    [[[UIApplication sharedApplication] keyWindow] addSubview:webview];
    if (self.detailModel) {
        Fcgo_OrderListGoodsModel *obj = [self.detailModel.goodsList firstObject];
        NSMutableDictionary *dict = @{}.mutableCopy;
        [dict setValue:self.detailModel.orderNo forKey:commodityInfoTitle];
        [dict setValue:obj.goodsName forKey:commodityInfoDes];
        [dict setValue:obj.picurl forKey:commodityInfoPic];
        [dict setValue:@"从订单详情进入" forKey:commodityInfoNote];
        [[Fcgo_QYIM_JumpTools sharedInstance] qy_jumpWithTitle:nil
                                                     urlString:nil
                                                    customInfo:nil
                                                  sessionTitle:nil
                                       commodityInfoDictionary:dict.copy];
    }
}

- (void)remind
{
    [WSProgressHUD showWithStatus:@"加载中..." maskType:WSProgressHUDMaskTypeClear];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [WSProgressHUD showImage:nil status:@"提醒成功"];
    });
    
    
//    NSMutableDictionary  *muatble = [NSMutableDictionary dictionary];
//    [muatble  setObjectWithNullValidate:[NSString stringWithFormat:@"%@",self.orderId] forKey:@"orderChildId"];
//    [Fcgo_NetworkManager postRequest:NSFormatHeardMeThodUrl(ServiceLocalTypeOne, ORDERMETHOD, @"notifySendGoods") parametersContentCommon:muatble successBlock:^(BOOL success, id responseObject, NSString *msg) {
//        if (success) {
//            [WSProgressHUD showImage:nil status:@"提醒成功"];
//        }
//    } failureBlock:^(NSString *description) {
//
//    } loading:YES];
}

//- (void)signWithModel:(Fcgo_OrderListGoodsModel *)goodsModel {
//    WEAKSELF(weakSelf);
//    NSMutableDictionary  *muatble = [NSMutableDictionary dictionary];
//    [muatble  setObjectWithNullValidate:[NSString stringWithFormat:@"%@",self.orderId] forKey:@"orderId"];
//    [muatble setObjectWithNullValidate:goodsModel.orderChildId forKey:@"orderChildId"]; /// orderChildId
//    [Fcgo_NetworkManager postRequest:NSFormatHeardMeThodUrl(ServiceLocalTypeOne, ORDERMETHOD, @"receiveAllGoods") parametersContentCommon:muatble successBlock:^(BOOL success, id responseObject, NSString *msg) {
//        if (success) {
//            [WSProgressHUD showImage:nil status:@"签收成功"];
//            [weakSelf requestOrderDetail];
//        }
//    } failureBlock:^(NSString *description) {
//
//    }];
//}

- (void)sign
{
    WEAKSELF(weakSelf);
    NSMutableDictionary  *muatble = [NSMutableDictionary dictionary];
    [muatble  setObjectWithNullValidate:[NSString stringWithFormat:@"%@",self.orderId] forKey:@"orderId"];
    //[muatble setObjectWithNullValidate:goodsModel.orderChildId forKey:@"orderChildId"]; /// orderChildId
    [WSProgressHUD showWithStatus:@"加载中..." maskType:(WSProgressHUDMaskTypeDefault)];
    [Fcgo_NetworkManager postRequest:NSFormatHeardMeThodUrl(ServiceLocalTypeOne, ORDERMETHOD, @"receiveAllGoods") parametersContentCommon:muatble successBlock:^(BOOL success, id responseObject, NSString *msg) {
        if (success) {
            [WSProgressHUD showImage:nil status:@"签收成功"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                 [weakSelf requestOrderDetail];
            });
        }
    } failureBlock:^(NSString *description) {
        
    }];
}
- (void)seeAfterSales:(Fcgo_OrderListGoodsModel *)goodsModel {
    Fcgo_ApplyHistoryVC *vc = [[Fcgo_ApplyHistoryVC alloc] init];
    vc.applyId = goodsModel.afterSaleId;
    [self.navigationController pushViewController:vc animated:1];
}

- (void)again {
    if (self.detailModel) {
        Fcgo_GoodsDetailVC *vc = [[Fcgo_GoodsDetailVC alloc]init];
        Fcgo_OrderListGoodsModel *goodsModel = [self.detailModel.goodsList firstObject];
        vc.goodsType = @"normal";
        vc.goodsValue = [NSString stringWithFormat:@"%@",goodsModel.goodsId];
        vc.hidesBottomBarWhenPushed = 1;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark - delegate
#pragma mark UITableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.detailModel) {
        if (section == 0) {
            return 1;
        }
        else if (section == 1) {
            if (self.detailModel.remark && ![self.detailModel.remark isEqualToString:@""]) {
                return 1;
            }
            return 0;
        }
        else if (section>1 && section <= self.detailModel.goodsList.count + 1) {
            return 1;
        }
        return 7;
    }
    return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.detailModel) {
        return self.detailModel.goodsList.count + 3;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WEAKSELF(weakSelf)
    if (indexPath.section == 0) {
        Fcgo_OrderDetailTopTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"orderDetailTopTableViewCell"];
        if (self.detailModel) {
            cell.model = self.detailModel;
        }
        cell.timeFinishBlock = ^{
           [weakSelf requestOrderDetail];
        };
        return cell;
    }
    if(indexPath.section == 1) {
        Fcgo_OrderDetailLeftMessageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"orderDetailLeftMessageTableViewCell"];
        if (self.detailModel) {
            cell.model = self.detailModel;
        }
        return cell;
    }
    if (self.detailModel) {
        if(indexPath.section > 1 && indexPath.section <= self.detailModel.goodsList.count + 1) {
            Fcgo_OrderDetailGoodsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"orderDetailGoodsTableViewCell"];
            Fcgo_OrderListGoodsModel *goodsModel = self.detailModel.goodsList[indexPath.section - 2];
            cell.goodsModel = goodsModel;
            cell.applyBlock = ^(Fcgo_OrderListGoodsModel *goodsModel,Fcgo_IndexButton *btn){
                if (!btn.select) {
                    Fcgo_AfterSalesServiceListModel *model = [[Fcgo_AfterSalesServiceListModel alloc] init];
                    model.goodsName = goodsModel.goodsName;
                    model.goodsBuynum = goodsModel.num;
                    model.goodsSkuPicurl = goodsModel.picurl;
                    model.properties = goodsModel.property;
                    model.texe = goodsModel.texe;
                    model.f_apply_id = goodsModel.orderChildId;
                    model.allPriceYUAN = goodsModel.priceYUAN;
                    model.freightYUAN = goodsModel.freightYUAN;
                    Fcgo_AfterServiceStyleVC *vc = [[Fcgo_AfterServiceStyleVC alloc] init];
                    vc.model = model;
                    vc.backVC = weakSelf;
                    [weakSelf.navigationController pushViewController:vc animated:1];
                }
                else {
                    [weakSelf seeAfterSales:goodsModel];
                }
            };
//            cell.signBlock = ^(Fcgo_OrderListGoodsModel *goodsModel){
//                [weakSelf signWithModel:goodsModel];
//            };
            return cell;
        }
    }
    Fcgo_OrderDetailBottomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"orderDetailBottomTableViewCell"];
    if (self.detailModel) {
        [cell setupWithModel:self.detailModel Index:indexPath.row];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.detailModel) {
        if (indexPath.section == 0) {
            CGFloat height = [self.detailModel.acceptAddress boundingRectWithSize:CGSizeMake(kScreenWidth - 65, 1000) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:UIFontSize(14)} context:nil].size.height;
            return 77+57+height;
        }
        if (indexPath.section == 1) {
            if (self.detailModel.remark && ![self.detailModel.remark isEqualToString:@""]) {
                NSString *string = self.detailModel.remark;
                CGFloat height = [string boundingRectWithSize:CGSizeMake(kScreenWidth - 100, 1000) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:UIFontSize(13)} context:nil].size.height;
                
                if (height+20<45) {
                    return 45;
                }
                return height+20;
            }
            return 0;
        }
        if(indexPath.section>1 && indexPath.section <= self.detailModel.goodsList.count+1) {
            Fcgo_OrderListGoodsModel *goodsModel = self.detailModel.goodsList[indexPath.section - 2];
            
            CGFloat height1 = [goodsModel.goodsName boundingRectWithSize:CGSizeMake(kScreenWidth - kAutoWidth6(70) - 42, 1000) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:UIFontSize(14)} context:nil].size.height;
            CGFloat height = [[NSString stringWithFormat:@"%@ 数量X%@",goodsModel.property,goodsModel.num]  boundingRectWithSize:CGSizeMake(kScreenWidth - kAutoWidth6(70) - 42, 1000) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:UIFontSize(12)} context:nil].size.height;
            if (goodsModel.orderGoodsStatus.intValue == -2 ||goodsModel.orderGoodsStatus.intValue == 3  ||
                goodsModel.orderGoodsStatus.intValue == 10 ||
                goodsModel.orderGoodsStatus.intValue == 20 ||
                goodsModel.orderGoodsStatus.intValue == 30 ||
                goodsModel.orderGoodsStatus.intValue == 40) {
                return 58+30 + height + height1;
            }
            else {
                if (kAutoWidth6(100)>56 + height + height1) {
                    return kAutoWidth6(70)+30;
                }
                return 56 + height + height1;
            }
        }
    }
    return 25;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.detailModel) {
        if (indexPath.section == 1) {
            return;
        }
        if(indexPath.section > 1 && indexPath.section <= self.detailModel.goodsList.count + 1) {
            Fcgo_OrderListGoodsModel *goodsModel = self.detailModel.goodsList[indexPath.section - 2];
            Fcgo_GoodsDetailVC *vc = [[Fcgo_GoodsDetailVC alloc] init];
            vc.goodsValue = [NSString stringWithFormat:@"%@",goodsModel.goodsId];
            vc.goodsType = @"normal";
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    WEAKSELF(weakSelf)
    if (self.detailModel) {
        if(section>1 && section <= self.detailModel.goodsList.count+1) {
            Fcgo_OrderDetailTableHeaderView *headView = [Fcgo_OrderDetailTableHeaderView headViewWithTableView:tableView];
            Fcgo_OrderListGoodsModel *goodsModel = self.detailModel.goodsList[section - 2];
            //headView.titleLabel.text = [NSString stringWithFormat:@"包裹%ld",(long)section-1];
            headView.arrowImageView.hidden = 1;
            [headView.arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(headView.contentView.mas_centerY);
                make.right.mas_offset(-15);
                make.width.mas_offset(16*19/36);
                make.height.mas_offset(16);
            }];
            headView.arrowImageView.hidden = 1;
            headView.orderStatusLabel.hidden = 1;
            
            [headView.orderStatusLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_offset(-15);
                make.centerY.mas_equalTo(headView.arrowImageView);
            }];
            if (goodsModel.orderGoodsStatus.intValue == 20 || goodsModel.orderGoodsStatus.intValue == 40||goodsModel.orderGoodsStatus.intValue == 100) {
                headView.arrowImageView.hidden = 0;
                headView.orderStatusLabel.hidden = 0;
                [headView.arrowImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(headView.contentView.mas_centerY);
                    make.right.mas_offset(-15);
                    make.width.mas_offset(16*19/36);
                    make.height.mas_offset(16);
                }];
                [headView.orderStatusLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.right.mas_equalTo(headView.arrowImageView.mas_left).mas_offset(-10);
                    make.centerY.mas_equalTo(headView.arrowImageView);
                }];
                
                headView.orderStatusLabel.text = @"查看物流";
            }
            
            NSString *status;
            if (goodsModel.orderGoodsStatus.intValue == -2)
            {
                status = @"供应商未接受订单";
            }
            else if (goodsModel.orderGoodsStatus.intValue == 1)
            {
                status = @"待付款";
            }
            else if (goodsModel.orderGoodsStatus.intValue == 2)
            {
                status = @"待审核";
                
            }
            else if (goodsModel.orderGoodsStatus.intValue == 3)
            {
                status = @"已支付";
            }
            else if (goodsModel.orderGoodsStatus.intValue == 10)
            {
                status = @"已受理";
                
            }
            else if (goodsModel.orderGoodsStatus.intValue == 20)
            {
                status = @"已发货";
            }
            else if (goodsModel.orderGoodsStatus.intValue == 30)
            {
                status = @"清关不通过";
            }
            else if (goodsModel.orderGoodsStatus.intValue == 40)
            {
                status = @"已签收";
            }
            else if (goodsModel.orderGoodsStatus.intValue == 50)
            {
                status = @"已取消";
            }
            else if (goodsModel.orderGoodsStatus.intValue == 60)
            {
                status = @"退款完成";
            }
            else if (goodsModel.orderGoodsStatus.intValue == 100)
            {
                status = @"已完成";
            }
            
            headView.titleLabel.text = status;
            
//            if (goodsModel.afterSaleId.intValue != 0) {
//                status = @"售后处理中";
//            }
//            headView.orderStatusLabel.text = status;
//            __weak __typeof(&*headView)weakHeadView = headView;
            headView.logisticsBlock = ^{
                if (goodsModel.orderGoodsStatus.intValue == 20 ||goodsModel.orderGoodsStatus.intValue == 40 ||goodsModel.orderGoodsStatus.intValue == 100) {
                    Fcgo_LogisticsVC *vc = [[Fcgo_LogisticsVC alloc]init];
                    vc.hidesBottomBarWhenPushed = 1;
                    vc.model = goodsModel;
                    [weakSelf.navigationController pushViewController:vc animated:1];
                }
            };
            return headView;
        }
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section>1 && section <= self.detailModel.goodsList.count+1) {
        return 50;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section>1 && section <= self.detailModel.goodsList.count+1) {
        return 5;
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *footerView = [[UIView alloc]init];
    footerView.backgroundColor = UIBackGroundColor;
    return footerView;
}
#pragma mark - UI
- (void)setupUI {
    WEAKSELF(weakSelf)
    [self.navigationView setupBackBtnBlock:^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    }];
    [self.navigationView setupTitleLabelWithTitle:@"订单详情"];
    [self.table registerNib:[UINib nibWithNibName:NSStringFromClass([Fcgo_OrderDetailTopTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"orderDetailTopTableViewCell"];
    
    [self.table registerNib:[UINib nibWithNibName:NSStringFromClass([Fcgo_OrderDetailLeftMessageTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"orderDetailLeftMessageTableViewCell"];
    [self.table registerNib:[UINib nibWithNibName:NSStringFromClass([Fcgo_OrderDetailGoodsTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"orderDetailGoodsTableViewCell"];
    
    [self.table registerNib:[UINib nibWithNibName:NSStringFromClass([Fcgo_OrderDetailBottomTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"orderDetailBottomTableViewCell"];
    self.table.mj_header = [Fcgo_RefreshNormalHeader headerRefreshBlock:^{
////        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf requestOrderDetail];
////        });
    }];
    [self.view insertSubview:self.table belowSubview:self.navigationView];
    
    self.bottomView.payBlock = ^{
        [weakSelf pay];
    };
    self.bottomView.cancelBlock = ^{
        [Fcgo_AlertAnimationView showWithTitle:@"提示" text:@"确定要取消订单吗?" cancelTitle:@"取消" confirmTitle:@"确定" block:^{
            [weakSelf cancel];
        }];
    };
    self.bottomView.serviceBlock = ^{
        [weakSelf service];
    };
    self.bottomView.remindBlock = ^{
        [weakSelf remind];
    };
    
    self.bottomView.againBlock = ^{
        [weakSelf again];
    };
    self.bottomView.signBlock = ^{
        [weakSelf sign];
    };
    [self.view insertSubview:self.bottomView belowSubview:self.navigationView];
}
#pragma mark - Lazy method
- (UITableView *)table {
    if (!_table) {
        UITableView *table = [[UITableView alloc]initWithFrame:CGRectMake(0, kNavigationHeight, kScreenWidth, KScreenHeight - kAutoWidth6(60) - kNavigationHeight ) style:UITableViewStylePlain];
        table.delegate = self;
        table.dataSource = self;
        table.separatorStyle = 0;
        //table.backgroundColor = UIBackGroundColor;
        UIView *footerView   = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth,10)];
        footerView.backgroundColor = UIFontWhiteColor;
        table.tableFooterView = footerView;
        _table = table;
        if (@available(iOS 11.0, *)) {
            table.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return _table;
}

- (Fcgo_OrderDetailBottomView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[Fcgo_OrderDetailBottomView alloc]initWithFrame:CGRectMake(0, KScreenHeight, kScreenWidth, kAutoWidth6(60))];
    }
    return _bottomView;
}

@end
