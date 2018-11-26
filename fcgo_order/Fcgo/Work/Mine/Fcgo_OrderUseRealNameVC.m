//
//  Fcgo_OrderUseRealNameVC.m
//  Fcgo
//
//  Created by huafanxiao on 2017/6/24.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_OrderUseRealNameVC.h"
#import "Fcgo_OrderConfirmRealNameTableCell.h"
#import "Fcgo_OrderConfirmNoneImageRealNameTableCell.h"
#import "Fcgo_RealNameVC.h"
#import "Fcgo_AddRealNameVC.h"


@interface Fcgo_OrderUseRealNameVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView    *table;
@property (nonatomic,strong) NSMutableArray *listArray;
@property (nonatomic,strong) UIButton       *addNewRealNameBtn;
@end

@implementation Fcgo_OrderUseRealNameVC
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self requestRealNameList];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}
#pragma mark - private method
//- (void)requestRealName
//{
//    WEAKSELF(weakSelf);
//    [WSProgressHUD showWithStatus:@"数据更新中..." maskType:WSProgressHUDMaskTypeClear];
//    NSMutableDictionary   *paremtes = [NSMutableDictionary dictionary];
//    NSMutableArray *goodsArray = [NSMutableArray array];
//    for (int i = 0; i < self.model.listArray.count; i ++) {
//        Fcgo_OrderGoodsModel *model = self.model.listArray[i];
//        NSDictionary *dict = @{@"goodsNumber":[NSString stringWithFormat:@"%@",model.goodsTypeBo.goodsNumber],
//                               @"goodsType":model.goodsTypeBo.goodsType,
//                               @"goodsValue":[NSString stringWithFormat:@"%@",model.goodsTypeBo.goodsValue],
//                               };
//        [goodsArray addObject:dict];
//    }
//    NSString *jsonStr=[Fcgo_publicNetworkTools arrayToJson:goodsArray];
//    [paremtes  setObjectWithNullValidate:jsonStr forKey:@"goods"];
//
//    [Fcgo_NetworkManager postRequest:NSFormatHeardMeThodUrl(ServiceLocalTypeOne, REALNAMEMETHOD, @"getCanUseRealNameList")
//                          parametersContentCommon:nil successBlock:^(BOOL success, id responseObject, NSString *msg) {
//        [WSProgressHUD dismiss];
//        NSNumber *errCode = responseObject[@"errorCode"];
//        if (errCode.intValue == 0) {
//            [weakSelf.listArray removeAllObjects];
//            NSArray   *realNameArray = responseObject[@"data"];
//            if (realNameArray.count<=0) {
//                weakSelf.navigationView.navRightTitleBtn.hidden = 1;
//                if (self.selectedBlock) {
//                    self.selectedBlock(nil);
//                }
//
//            }
//            else {
//                weakSelf.navigationView.navRightTitleBtn.hidden = 0;
//                for (int i = 0; i < realNameArray.count; i ++) {
//                    NSDictionary *realNameDict = realNameArray[i];
//                    Fcgo_RealNameModel *model = [Fcgo_RealNameModel yy_modelWithDictionary:realNameDict];
//                    [weakSelf.listArray addObject:model];
//                }
//                [weakSelf.table reloadData];
//            }
//        }
//    } failureBlock:^(NSString *description) {
//    }];
//}


- (void)requestRealNameList
{
    if (![Fcgo_Tools isNetworkConnected]) {
        [WSProgressHUD showImage:nil status:@"亲,没联网啊"];
       return;
    }
    WEAKSELF(weakSelf);
    NSMutableDictionary  *muatble = [NSMutableDictionary dictionary];
    [WSProgressHUD showWithStatus:@"数据加载中..." maskType:(WSProgressHUDMaskTypeDefault)];
    [Fcgo_NetworkManager postRequest:NSFormatHeardMeThodUrl(ServiceLocalTypeOne,REALNAMEMETHOD, @"list") parametersContentCommon:muatble successBlock:^(BOOL success, id responseObject, NSString *msg) {
        if (success) {
            [weakSelf.listArray removeAllObjects];
            NSArray   *realNameArray = responseObject[@"data"];
            if (realNameArray.count<=0) {
                weakSelf.navigationView.navRightTitleBtn.hidden = 1;
                if (self.selectedBlock) {
                    self.selectedBlock(nil);
                }
                
            }
            else {
                weakSelf.navigationView.navRightTitleBtn.hidden = 0;
                for (int i = 0; i < realNameArray.count; i ++) {
                    NSDictionary *realNameDict = realNameArray[i];
                    Fcgo_RealNameModel *model = [Fcgo_RealNameModel yy_modelWithDictionary:realNameDict];
                    [weakSelf.listArray addObject:model];
                }
                [weakSelf.table reloadData];
            }
        }
        
    } failureBlock:^(NSString *description) {
    }];
}

- (void)addNewRealName {
    Fcgo_AddRealNameVC *vc = [[Fcgo_AddRealNameVC alloc]init];
    vc.hidesBottomBarWhenPushed = 1;
    [self.navigationController pushViewController:vc animated:1];
}

#pragma mark - delegate
#pragma mark UITableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.listArray.count > 0) {
        return [self.listArray count];
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    Fcgo_OrderConfirmRealNameTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"orderConfirmRealNameTableCell"];
    cell.arrowImageView.hidden = 1;
    if (self.listArray.count>0) {
        Fcgo_RealNameModel *model = self.listArray[indexPath.row];
        if (model.mchPicurlB && ![model.mchPicurlB isEqualToString:@""]) {
            cell.model = model;
            
        }
        else {
            Fcgo_OrderConfirmNoneImageRealNameTableCell *cell1 = [tableView dequeueReusableCellWithIdentifier:@"orderConfirmNoneImageRealNameTableCell"];
            cell1.model = model;
            return cell1;
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.listArray.count>0) {
         Fcgo_RealNameModel *model = self.listArray[indexPath.row];
        if (self.selectedBlock) {
            self.selectedBlock(model);
        }
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.listArray.count>0) {
        Fcgo_RealNameModel *model = self.listArray[indexPath.row];
        if (model.mchPicurlB && ![model.mchPicurlB isEqualToString:@""]) {
            return kAutoWidth6(60)+93;
        }
        return 83;
    }
    return 0;
}

#pragma mark - UI
- (void)setupUI {
    WEAKSELF(weakSelf)
    [self.navigationView setupBackBtnBlock:^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    }];
    [self.navigationView setupTitleLabelWithTitle:@"实名人选择"];
    [self.navigationView setupRightBtnTitle:@"管理" Block:^{
        Fcgo_RealNameVC *vc = [[Fcgo_RealNameVC alloc]init];
        vc.hidesBottomBarWhenPushed = 1;
        [weakSelf.navigationController pushViewController:vc animated:1];
        
    }];
    [self.addNewRealNameBtn addTarget:self action:@selector(addNewRealName) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.addNewRealNameBtn];
    [self.addNewRealNameBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_offset(0);
        make.height.mas_offset(kAutoWidth6(50));
    }];
    [self.table registerNib:[UINib nibWithNibName:NSStringFromClass([Fcgo_OrderConfirmRealNameTableCell class]) bundle:nil] forCellReuseIdentifier:@"orderConfirmRealNameTableCell"];
    [self.table registerNib:[UINib nibWithNibName:NSStringFromClass([Fcgo_OrderConfirmNoneImageRealNameTableCell class]) bundle:nil] forCellReuseIdentifier:@"orderConfirmNoneImageRealNameTableCell"];
    [self.view addSubview:self.table];
}

#pragma mark Lazy method
- (UITableView *)table {
    if (!_table) {
        UITableView *table    = [[UITableView alloc]initWithFrame:CGRectMake(0, kNavigationHeight, kScreenWidth, KScreenHeight-kNavigationHeight-kAutoWidth6(50)) style:UITableViewStylePlain];
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

- (NSMutableArray *)listArray {
    if (!_listArray) {
        _listArray = [[NSMutableArray alloc]init];
    }
    return _listArray;
}

- (UIButton *)addNewRealNameBtn {
    if (!_addNewRealNameBtn) {
        _addNewRealNameBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        _addNewRealNameBtn.titleLabel.font = UIFontSize(16);
        [_addNewRealNameBtn setTitle:@"添加实名认证" forState:UIControlStateNormal];
        [_addNewRealNameBtn setTitleColor:UIFontWhiteColor forState:UIControlStateNormal];
        [_addNewRealNameBtn setBackgroundColor:UIFontRedColor];
    }
    return _addNewRealNameBtn;
}
@end
