//
//  Fcgo_AfterSalesService_DetailVC.m
//  Fcgo
//
//  Created by huafanxiao on 2017/6/14.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_AfterSalesService_DetailVC.h"
#import "Fcgo_ServiceDetailSection0Row0Cell.h"
#import "Fcgo_ServiceDetailSection0Row1Cell.h"
#import "Fcgo_ServiceDetailSection1Row0Cell.h"
#import "Fcgo_ServiceDetailSection2Row0Cell.h"
#import "Fcgo_ServiceDetailSection3Row0Cell.h"
#import "Fcgo_AfterSalesService_DetailModel.h"
#import "Fcgo_ContactServiceVC.h"

@interface Fcgo_AfterSalesService_DetailVC ()<UITableViewDelegate,UITableViewDataSource,LrdOutputViewDelegate>

@property (nonatomic,strong) UITableView    *table;
@property (nonatomic,strong) NSArray        *titleArray;
@property (nonatomic,strong) NSArray        *dataArray;
@property (nonatomic,strong) UIButton       *loginoutBtn;
@property (nonatomic,strong) Fcgo_AfterSalesService_DetailModel *detailModel;

@end

@implementation Fcgo_AfterSalesService_DetailVC

- (void)requestOrderRefundDeatil
{
    if (![Fcgo_Tools isNetworkConnected]) {
        [WSProgressHUD showImage:nil status:@"亲,没联网啊"];
        [self showUIData:NO];
        return;
    }
    WEAKSELF(weakSelf);
    NSMutableDictionary  *paremetwers = [NSMutableDictionary dictionary];
    [paremetwers setObjectWithNullValidate:self.f_apply_id forKey:@"id"];
    [Fcgo_NetworkManager postRequest:NSFormatHeardUrl(@"order/refund_detail") parametersContentCommon:paremetwers successBlock:^(BOOL success, id responseObject, NSString *msg) {
        [weakSelf.table.mj_header endRefreshing];
        if (success) { 
            [weakSelf showUIData:1];
            weakSelf.detailModel = [Fcgo_AfterSalesService_DetailModel yy_modelWithDictionary:(NSDictionary *)responseObject[@"data"]];
            NSString *string = responseObject[@"data"][@"f_refund_picurl"];
            NSArray *f_refund_picurl = [string componentsSeparatedByString:@","];
            weakSelf.detailModel.f_refund_picurlArray = f_refund_picurl;
            [self.table reloadData];
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
    self.table.hidden = !isShow;
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupUI];
    [self requestOrderRefundDeatil];
}

- (void)setupUI;
{
    self.view.backgroundColor = UIBackGroundColor;
    self.titleArray = @[@"",@"退款原因",@"客服回复"];
    
    WEAKSELF(weakSelf)
    [self.navigationView setupBackBtnBlock:^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    }];
    [self.navigationView setupTitleLabelWithTitle:@"售后详情"];
    
    [self.navigationView setupMoreBtnBlock:^{
        [weakSelf more];
    }];
    [self.table registerNib:[UINib nibWithNibName:NSStringFromClass([Fcgo_ServiceDetailSection0Row0Cell class]) bundle:nil] forCellReuseIdentifier:@"serviceDetailSection0Row0Cell"];
    [self.table registerNib:[UINib nibWithNibName:NSStringFromClass([ Fcgo_ServiceDetailSection0Row1Cell class]) bundle:nil] forCellReuseIdentifier:@"serviceDetailSection0Row1Cell"];
    [self.table registerNib:[UINib nibWithNibName:NSStringFromClass([Fcgo_ServiceDetailSection1Row0Cell class]) bundle:nil] forCellReuseIdentifier:@"serviceDetailSection1Row0Cell"];
    [self.table registerNib:[UINib nibWithNibName:NSStringFromClass([Fcgo_ServiceDetailSection3Row0Cell class]) bundle:nil] forCellReuseIdentifier:@"serviceDetailSection3Row0Cell"];
    [self.table registerNib:[UINib nibWithNibName:NSStringFromClass([Fcgo_ServiceDetailSection2Row0Cell class]) bundle:nil] forCellReuseIdentifier:@"serviceDetailSection2Row0Cell"];
    
    self.table.mj_header = [Fcgo_RefreshNormalHeader headerRefreshBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf.table.mj_header endRefreshing];
        });
    }];
    [self.view insertSubview:self.table belowSubview:self.navigationView];
    
    self.dataArray = @[
                       [[LrdCellModel alloc] initWithTitle:@"取消售后" imageName:@"cancelAfter"],
                       [[LrdCellModel alloc] initWithTitle:@"联系我们" imageName:@"icon_kefu"]];
}

- (void)more
{
    CGFloat x = kScreenWidth - 12;
    CGFloat y = kNavigationHeight+6.5;
    LrdOutputView *outputView = [[LrdOutputView alloc] initWithDataArray:self.dataArray origin:CGPointMake(x, y) width:110 height:40 direction:kLrdOutputViewDirectionRight];
    outputView.delegate = self;
    [outputView pop];
}

- (void)didSelectedAtIndexPath:(NSIndexPath *)indexPath
{
    //WEAKSELF(weakSelf)
    switch (indexPath.row) {
        case 0:
        {
            if(!self.detailModel)
            {
                [WSProgressHUD showErrorWithStatus:@"暂无数据,暂不能取消售后"];
                //[WSProgressHUD showImage:nil status:@"暂无数据"];
                return;
            }
            if (self.detailModel.f_status.intValue == 1) {
                [WSProgressHUD showErrorWithStatus:@"售后处理中,暂不能取消售后"];
                //[WSProgressHUD showImage:nil status:@"售后处理中"];
                 return;
            }
            
            if(self.detailModel.f_status.intValue == 100)
            {
                [WSProgressHUD showErrorWithStatus:@"售后已完成,不能取消售后"];
                //[WSProgressHUD showImage:nil status:@"售后已完成"];
                return;
            }
            
            if(self.detailModel.f_status.intValue == 50)
            {
                [WSProgressHUD showErrorWithStatus:@"售后已驳回,暂不能取消售后"];
                //[WSProgressHUD showImage:nil status:@"售后已驳回"];
                return;
            }
            
            //取消
            WEAKSELF(weakSelf);
            NSMutableDictionary  *muatble = [NSMutableDictionary dictionary];
            [muatble  setObjectWithNullValidate:[NSString stringWithFormat:@"%@",self.detailModel.f_order_id] forKey:@"orderId"];
            [muatble setObjectWithNullValidate:self.detailModel.f_order_goods_id forKey:@"orderGoodsId"];
            [Fcgo_NetworkManager postRequest:NSFormatHeardUrl(@"order/refundCancel") parametersContentCommon:muatble successBlock:^(BOOL success, id responseObject, NSString *msg) {
                [WSProgressHUD dismiss];
                if (success) {
                    [WSProgressHUD showImage:nil status:@"取消成功"];
                    if (weakSelf.cancelApplyBlock) {
                        weakSelf.cancelApplyBlock();
                    }
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [weakSelf.navigationController popViewControllerAnimated:YES];
                    });
                }
            } failureBlock:^(NSString *description) {
                
            }];
            
        }
            break;
        case 1:
        {
//            UIWebView *webview = [[UIWebView alloc] init];
//            [webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",[[Fcgo_UserTools shared] tel]]]]];
//            [[[UIApplication sharedApplication] keyWindow] addSubview:webview];
            Fcgo_ContactServiceVC *vc = [[Fcgo_ContactServiceVC alloc]init];
            vc.hidesBottomBarWhenPushed = 1;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
            
        default:
            break;
    }
}

#pragma mark table delegate datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 4;
    }
//    else if (section == 1)
//    {
//        return 1;
//    }
    else if (section == 1)
    {
        return 1;
    }
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.titleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if(indexPath.row == 0)
        {
            Fcgo_ServiceDetailSection0Row0Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"serviceDetailSection0Row0Cell"];
            if (self.detailModel) {
                cell.detailModel = self.detailModel;
            }
            return cell;
        }
        Fcgo_ServiceDetailSection0Row1Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"serviceDetailSection0Row1Cell"];
        if(indexPath.row == 1)
        {
            cell.titleLabel.text = @"退款金额:";
            if (self.detailModel) {
                cell.descLabel.text = [NSString stringWithFormat:@"¥ %@",self.detailModel.f_refund_money];
            }
        }
        else if(indexPath.row == 2)
        {
            cell.titleLabel.text = @"申请时间:";
            if (self.detailModel) {
                cell.descLabel.text = self.detailModel.f_created;
            }
        }
        else if(indexPath.row == 3)
        {
            cell.titleLabel.text = @"订单编号:";
            if (self.detailModel) {
                cell.descLabel.text = self.detailModel.f_refund_no;
            }
        }
        
        return cell;
    }
    
//    else if (indexPath.section == 1) {
//        Fcgo_ServiceDetailSection1Row0Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"serviceDetailSection1Row0Cell"];
//        if(indexPath.row == 0)
//        {
//            cell.titleLabel.text = @"订单编号:";
//            cell.descLabel.text = self.detailModel.f_refund_no;
//        }
//        
//        else if(indexPath.row == 1)
//        {
//            cell.titleLabel.text = @"下单时间:";
//            if (self.detailModel) {
//                cell.descLabel.text = self.detailModel.f_created;
//            }
//        }
//        return cell;
//    }
    
    else if (indexPath.section == 1) {
        Fcgo_ServiceDetailSection2Row0Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"serviceDetailSection2Row0Cell"];
        if (self.detailModel) {
            cell.detailModel = self.detailModel;
        }
        return cell;
    }
    
    Fcgo_ServiceDetailSection3Row0Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"serviceDetailSection3Row0Cell"];
    if (self.detailModel) {
        if (self.detailModel.f_refund &&![self.detailModel.f_refund isEqualToString:@""]) {
            cell.titleLabel.text = self.detailModel.f_refund;
            
        }else{
            cell.titleLabel.text = @"亲，请耐心等待审核哦";
        }
        
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && indexPath.row == 0) {
        return 60;
    }
    
    if (indexPath.section == 1 && indexPath.row == 0) {
        if(self.detailModel)
        {
            CGFloat height = [self.detailModel.f_refund_reason boundingRectWithSize:CGSizeMake(kScreenWidth - 48, 1000) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:UIFontSize(14)} context:nil].size.height;
            return 30+kAutoWidth6(70) + height;
        }
        return 0;
    }
    else if (indexPath.section == 2){
        if(self.detailModel)
        {
            CGFloat height = [self.detailModel.f_refund boundingRectWithSize:CGSizeMake(kScreenWidth - 48, 1000) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:UIFontSize(13)} context:nil].size.height;
            return 20 + height;
        }
        return 0;
    }
    
    
    return 45;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 55)];
    bgView.backgroundColor = UIBackGroundColor;
    
    UIView *whiteView = [[UIView alloc]initWithFrame:CGRectMake(0, 5, kScreenWidth, 45)];
    whiteView.backgroundColor = UIFontWhiteColor;
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, kScreenWidth-30, 45)];
    titleLabel.textColor = UIFontMainGrayColor;
    titleLabel.font = UIFontSize(15);
    titleLabel.text = self.titleArray[section];
    [whiteView addSubview:titleLabel];
    [bgView addSubview:whiteView];
    return bgView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 0;
    }
    return 55;
}

#pragma mark Lazy method

- (UITableView *)table
{
    if (!_table) {
        UITableView *table = [[UITableView alloc]initWithFrame:CGRectMake(0, kNavigationHeight, kScreenWidth, KScreenHeight - kNavigationHeight) style:UITableViewStylePlain];
        table.delegate = self;
        table.dataSource = self;
        table.separatorStyle = 0;
        table.backgroundColor = UIBackGroundColor;
        UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 5)];
        footerView.backgroundColor = UIBackGroundColor;
        table.tableFooterView = footerView;
        _table = table;
        if (@available(iOS 11.0, *)) {
            table.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return _table;
}

@end


