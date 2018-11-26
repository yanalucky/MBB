//
//  Fcgo_LogisticsVC.m
//  Fcgo
//
//  Created by huafanxiao on 2017/5/25.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

/*
 {
     "com": "zhongtong",
     "data": "[{\"context\":\"[沭阳] [宿迁市] [沭阳]的派件已签收 感谢使用中通快递,期待再次为您服务!\",\"ftime\":\"2017-05-05 13:46:34\",\"time\":\"2017-05-05 13:46:34\"},{\"context\":\"[沭阳] [宿迁市] [沭阳]的徐增雨正在第1次派件 电话:18451805999 请保持电话畅通、耐心等待\",\"ftime\":\"2017-05-05 13:30:34\",\"time\":\"2017-05-05 13:30:34\"},{\"context\":\"[沭阳] [宿迁市] 快件到达 [沭阳]\",\"ftime\":\"2017-05-05 08:18:07\",\"time\":\"2017-05-05 08:18:07\"},{\"context\":\"[淮安中转] [淮安市] 快件离开 [淮安中转]已发往[沭阳]\",\"ftime\":\"2017-05-05 04:28:03\",\"time\":\"2017-05-05 04:28:03\"},{\"context\":\"[深圳中心] [深圳市] 快件离开 [深圳中心]已发往[淮安中转]\",\"ftime\":\"2017-05-04 02:59:32\",\"time\":\"2017-05-04 02:59:32\"},{\"context\":\"[深圳中心] [深圳市] 快件到达 [深圳中心]\",\"ftime\":\"2017-05-04 02:57:35\",\"time\":\"2017-05-04 02:57:35\"},{\"context\":\"[深圳南湾] [深圳市] 快件离开 [深圳南湾]已发往[淮安中转]\",\"ftime\":\"2017-05-03 23:41:58\",\"time\":\"2017-05-03 23:41:58\"},{\"context\":\"[深圳南湾] [深圳市] [深圳南湾]的徐雷已收件 电话:18680399969\",\"ftime\":\"2017-05-03 17:59:51\",\"time\":\"2017-05-03 17:59:51\"}]",
     "expressPcUrl": "http://www.zt.com",
     "expressWapUrl": "http://wap.zt.com",
     "id": 57,
     "name": "",
     "nu": "534489674437",
     "state": "0"
 }
 */

#import "Fcgo_LogisticsVC.h"
#import "Fcgo_LogisticsDetailTableViewCell.h"
#import "Fcgo_LogisticsHeaderView.h"
#import "Fcgo_NoLogisticsDetailCell.h"

@interface Fcgo_LogisticsVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView    *table;
//@property (nonatomic,strong) NSMutableArray *freightArray;
//@property (nonatomic,strong) NSMutableArray *showArray;
@property (nonatomic, strong) NSMutableArray    *dataArray;
@end

@implementation Fcgo_LogisticsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    [self requestLogistics];
}
#pragma mark - private method
- (void)requestData:(Fcgo_OrderExpressModel *)model block:(void(^)(void))block {
    WEAKSELF(weakSelf);
    NSMutableDictionary  *muatble = [NSMutableDictionary dictionary];
    [muatble  setObjectWithNullValidate:[NSString stringWithFormat:@"%@",model.expressId] forKey:@"expressId"];
    [muatble  setObjectWithNullValidate:[NSString stringWithFormat:@"%@",model.expressNo] forKey:@"expressNo"];
    NSString *urlString = NSFormatHeardMeThodUrl(ServiceLocalTypeOne, ORDERMETHOD, @"express");
    [Fcgo_NetworkManager postRequest:urlString parametersContentCommon:muatble successBlock:^(BOOL success, id responseObject, NSString *msg) {
        if (success) {
            NSDictionary *datadict = responseObject[@"data"];
            if(!datadict) return ;
            Fcgo_OrderExpressUnit *obj = [Fcgo_OrderExpressUnit yy_modelWithDictionary:datadict];
            obj.open = YES;
            obj.com = model.expressName;
            [weakSelf.dataArray addObject:obj];
        }
        !block?:block();
    } failureBlock:^(NSString *description) {
        !block?:block();
    }];
}

- (void)requestLogistics {
    //BNMIOS171123100551309922 
    [self.dataArray removeAllObjects];
    WEAKSELF(weakSelf);
    dispatch_group_t group = dispatch_group_create();
    for (int i = 0; i < self.model.orderExpress.count; i ++) {
        Fcgo_OrderExpressModel *expressObj = self.model.orderExpress[i];
        dispatch_group_async(group, dispatch_get_global_queue(0, 0), ^{
            dispatch_group_enter(group);
            [weakSelf requestData:expressObj block:^{
                dispatch_group_leave(group);
            }];
        });
    }
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        if (!weakSelf.dataArray.count) {
            for (Fcgo_OrderExpressModel *obj in weakSelf.model.orderExpress) {
                Fcgo_OrderExpressUnit *unit = [[Fcgo_OrderExpressUnit alloc] init];
                unit.com = obj.expressName;
                unit.nu = obj.expressNo;
                [weakSelf.dataArray addObject:unit];
            }
        }
        // 只有一个物流时默认打开，有一个以上的默认不打开
        if (weakSelf.dataArray.count > 1) {
            for (Fcgo_OrderExpressUnit *unit in weakSelf.dataArray) {
                unit.open = NO;
            }
        }
        [weakSelf.table.mj_header endRefreshing];
        [weakSelf.table reloadData];
    });
}

- (CGFloat)getHeightWithText:(NSString *)string {
    CGFloat height = [string boundingRectWithSize:CGSizeMake(kScreenWidth - 40, 1000) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:UIFontSize(14)} context:nil].size.height;
    return height;
}
#pragma mark - delegate
#pragma mark table delegate datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    Fcgo_OrderExpressUnit *unit = self.dataArray[section];
    if (unit.open) {
        return unit.dataArray.count ?: 1;
    }
    return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    Fcgo_LogisticsDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"logisticsDetailTableViewCell"];
    Fcgo_OrderExpressUnit *unit = self.dataArray[indexPath.section];
    if (unit.dataArray.count) {
        Fcgo_orderExpressData *obj = unit.dataArray[indexPath.row];
        cell.logisticsDeatilLabel.text = obj.context;
        cell.logisticsTimeLabel.text = obj.time;
        [cell updateFrameWithIndex:indexPath.row];
    }
    else {
        Fcgo_NoLogisticsDetailCell *nCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([Fcgo_NoLogisticsDetailCell class])];
        [nCell setName:unit.com url:unit.expressWapUrl];
        return cell;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    Fcgo_OrderExpressUnit *unit = self.dataArray[indexPath.section];
    if (unit.dataArray.count) {
        Fcgo_orderExpressData *obj = unit.dataArray[indexPath.row];
        NSString *contextString =  obj.context;
        CGFloat height = [contextString boundingRectWithSize:CGSizeMake(kScreenWidth - 65, 1000) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:UIFontSize(14)} context:nil].size.height;
        return 42 + height;
    }
    else {
        if ([Fcgo_Tools isNullString:unit.expressWapUrl]) {
            return 0;
        }
        NSString *com = unit.com;
        return [Fcgo_NoLogisticsDetailCell getHeightWithText:tipLogisticsStr] +
        [Fcgo_NoLogisticsDetailCell getHeightWithText:[NSString stringWithFormat:@"%@: %@",com, unit.expressWapUrl]] + 30;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    WEAKSELF(weakSelf)
    Fcgo_OrderExpressUnit *unit = self.dataArray[section];
    Fcgo_LogisticsHeaderView *headerView = [Fcgo_LogisticsHeaderView headViewWithTableView:tableView];
    headerView.freightNumLabel.text = @"运单编号:";
    headerView.freightCompanyLabel.text = @"快递公司:";
    headerView.showBtn.select = unit.open;//[self.showArray[section] intValue];
    if (unit.dataArray.count) {
        if (unit.state.intValue == 3) {
            headerView.freightState.text = @"已签收";
        }
        else {
            headerView.freightState.text = @"配送中";
        }
        headerView.freightNum.text = unit.nu;
        headerView.freightCompany.text = unit.com;
    }
    headerView.showBlock = ^(BOOL isShow){
        unit.open = !isShow;
        [weakSelf.table reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationFade];
    };
    headerView.copyBlock = ^{
        UIPasteboard* pasteboard = [UIPasteboard generalPasteboard];
        [pasteboard setString:unit.nu];
        [WSProgressHUD showImage:nil status:@"物流单号已复制"];
    };
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 67;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    Fcgo_OrderExpressUnit *unit = self.dataArray[section];
    if (unit.open) {
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
    [self.navigationView setupTitleLabelWithTitle:@"物流详情"];
    
    [self.table registerNib:[UINib nibWithNibName:NSStringFromClass([Fcgo_LogisticsDetailTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"logisticsDetailTableViewCell"];
    [self.table registerClass:[Fcgo_NoLogisticsDetailCell class] forCellReuseIdentifier:NSStringFromClass([Fcgo_NoLogisticsDetailCell class])];
    self.table.mj_header = [MJRefreshStateHeader  headerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf.table.mj_header endRefreshing];
            [weakSelf.table reloadData];
        });
    }];
    [self.view insertSubview:self.table belowSubview:self.navigationView];
}
#pragma mark Lazy method
- (UITableView *)table {
    if (!_table) {
        UITableView *table = [[UITableView alloc]initWithFrame:CGRectMake(0, kNavigationHeight, kScreenWidth, KScreenHeight - kNavigationHeight ) style:UITableViewStylePlain];
        table.delegate = self;
        table.dataSource = self;
        table.backgroundColor = UIBackGroundColor;
        table.separatorStyle = 0;
        table.tableFooterView = [UIView new];
        _table = table;
        if (@available(iOS 11.0, *)) {
            table.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return _table;
}

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = @[].mutableCopy;
    }
    return _dataArray;
}

@end
