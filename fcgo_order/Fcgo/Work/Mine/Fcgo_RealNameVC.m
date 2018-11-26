//
//  Fcgo_RealNameVC.m
//  Fcgo
//
//  Created by huafanxiao on 2017/6/5.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_RealNameVC.h"
#import "Fcgo_RealNameTableCell.h"
#import "Fcgo_RealNameNoImageTableCell.h"
#import "Fcgo_AddRealNameVC.h"
#import "Fcgo_RealNameModel.h"

@interface Fcgo_RealNameVC ()<UITableViewDelegate,UITableViewDataSource,AddOrEditRealNameDelegate>

@property (nonatomic,strong) UITableView      *table;
@property (nonatomic,strong) NSMutableArray   *listArray;
@property (nonatomic,strong) UIButton         *addNewRealNameBtn;
@property (nonatomic,assign) NSInteger         defaultIndex;

@end

@implementation Fcgo_RealNameVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    [WSProgressHUD showWithStatus:@"数据加载..." maskType:WSProgressHUDMaskTypeClear];
    [self requestRealNameList];
}
#pragma mark - private method
- (void)requestRealNameList {
    if (![Fcgo_Tools isNetworkConnected]) {
        [WSProgressHUD showImage:nil status:@"亲,没联网啊"];
        [self showUIData:NO];
        return;
    }
    WEAKSELF(weakSelf);
    NSMutableDictionary  *muatble = [NSMutableDictionary dictionary];
    [WSProgressHUD showWithStatus:@"数据加载中..." maskType:(WSProgressHUDMaskTypeDefault)];
    [Fcgo_NetworkManager postRequest:NSFormatHeardMeThodUrl(ServiceLocalTypeOne,REALNAMEMETHOD, @"list") parametersContentCommon:muatble successBlock:^(BOOL success, id responseObject, NSString *msg) {
        [weakSelf.listArray removeAllObjects];
        if (success) {
            [weakSelf showUIData:1];
            NSArray   *listArray = responseObject[@"data"];
            for (int i = 0; i < listArray.count; i ++) {
                NSDictionary *realNameDict = listArray[i];
                Fcgo_RealNameModel *model = [Fcgo_RealNameModel yy_modelWithDictionary:realNameDict];
                if (model.f_default.intValue == 1) {
                    weakSelf.defaultIndex = i;
                }
                [weakSelf.listArray addObject:model];
            }
            if (weakSelf.listArray.count<=0) {
                [weakSelf showMoreUIData:0];
            }
            else {
                [weakSelf showMoreUIData:1];
            }
            [weakSelf.table reloadData];
        }
        else {
            [weakSelf showUIData:0];
        }
        [self.table.mj_header endRefreshing];
    } failureBlock:^(NSString *description) {
        [weakSelf showUIData:0];
    }];
}

- (void)showUIData:(BOOL)isShow {
    [self showNoControl:!isShow titleString:@"网络错误,点击重新加载" imageString:@"ico_no-wifi"];
    self.table.hidden = !isShow;
}

- (void)showMoreUIData:(BOOL)isShow {
    [self showNoControl:!isShow titleString:@"暂无实名人" imageString:@"ico_no-id"];
    self.table.hidden = !isShow;
}

//从添加或者编辑页返回回调调取接口数据刷新
- (void)finishAddOrEditRealName {
    [WSProgressHUD showWithStatus:@"数据加载中..." maskType:WSProgressHUDMaskTypeClear];
    [self requestRealNameList];
}

- (void)setDefaultAdressWithModel:(Fcgo_RealNameModel *)model {
    WEAKSELF(weakSelf);
    [Fcgo_AlertAnimationView showWithTitle:@"提示" text:@"确认修改默认人?" cancelTitle:@"取消" confirmTitle:@"确定" block:^{
        NSMutableDictionary  *muatble = [NSMutableDictionary dictionary];
        //[muatble setObjectWithNullValidate:@"32" forKey:@"merId"];
        //[muatble setObjectWithNullValidate:[Fcgo_UserTools shared].userDict[@"id"] forKey:@"merId"];
        [muatble setObjectWithNullValidate:model.f_realName_id forKey:@"id"];
        [WSProgressHUD showWithStatus:@"数据加载..." maskType:WSProgressHUDMaskTypeClear];
        [Fcgo_NetworkManager postRequest:NSFormatHeardMeThodUrl(ServiceLocalTypeOne,REALNAMEMETHOD, @"setFault") parametersContentCommon:muatble successBlock:^(BOOL success, id responseObject, NSString *msg) {
            if (success) {
                NSNumber *errCode = responseObject[@"errorCode"];
                if (errCode.intValue == 0) {
                    [WSProgressHUD showSuccessWithStatus:@"设置成功"];
                    Fcgo_RealNameTableCell *cell = [weakSelf.table cellForRowAtIndexPath:[NSIndexPath indexPathForRow:weakSelf.defaultIndex inSection:0]];
                    Fcgo_RealNameModel *model2 = weakSelf.listArray[weakSelf.defaultIndex];
                    model2.f_default = @0;
                    [weakSelf.listArray replaceObjectAtIndex:weakSelf.defaultIndex withObject:model2];
                    cell.defultBtn.select = NO;
                    [cell.defultBtn setBackgroundImage:[UIImage imageNamed:@"select_off"] forState:UIControlStateNormal];
                    
                    int index = 0;
                    for (int i = 0; i < weakSelf.listArray.count; i++) {
                        Fcgo_RealNameModel *model1 = weakSelf.listArray[i];
                        if (model.f_realName_id.intValue == model1.f_realName_id.intValue ) {
                            model.f_default = @1;
                            [weakSelf.listArray replaceObjectAtIndex:i withObject:model];
                            index = i;
                        }
                    }
                    Fcgo_RealNameTableCell *cell1 = [weakSelf.table cellForRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
                    cell1.defultBtn.select = YES;
                    [cell1.defultBtn setBackgroundImage:[UIImage imageNamed:@"select_on"] forState:UIControlStateNormal];
                    weakSelf.defaultIndex = index;
                }
            }
        } failureBlock:^(NSString *description) {
            
        }];
    }];
}

- (void)deleteAdressWithModel:(Fcgo_RealNameModel *)model {
    if (model.f_default.integerValue == 1) {
        [WSProgressHUD showImage:nil status:@"请不要删除默认实名人哟~"];
        return;
    }
    WEAKSELF(weakSelf);
    [Fcgo_AlertAnimationView showWithTitle:@"提示" text:@"确认删除实名人?" cancelTitle:@"取消" confirmTitle:@"确定" block:^{
        NSMutableDictionary  *muatble = [NSMutableDictionary dictionary];
        [muatble setObjectWithNullValidate:model.f_realName_id forKey:@"id"];
        [WSProgressHUD showWithStatus:@"数据删除中..." maskType:WSProgressHUDMaskTypeClear];
        [Fcgo_NetworkManager postRequest:NSFormatHeardMeThodUrl(ServiceLocalTypeOne,REALNAMEMETHOD, @"del") parametersContentCommon:muatble successBlock:^(BOOL success, id responseObject, NSString *msg) {
            [WSProgressHUD dismiss];
            if (success) {
                [WSProgressHUD showSuccessWithStatus:@"删除成功"];
                for (int i = 0; i < weakSelf.listArray.count; i++) {
                    Fcgo_RealNameModel *model1 = weakSelf.listArray[i];
                    if (model.f_realName_id.intValue == model1.f_realName_id.intValue ) {
                        //在预下单界面，如果实名认证管理，删除，发送通知，改变预下单界面的实名选择
                        [[NSNotificationCenter defaultCenter]postNotificationName:@"deleteRealName" object:model];
                        
                        [weakSelf.listArray removeObject:model];
                        [weakSelf.table deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:i inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
                    }
                }
                if (weakSelf.listArray.count<=0) {
                    [weakSelf showMoreUIData:0];
                }
            }
            [weakSelf.table.mj_header endRefreshing];
        } failureBlock:^(NSString *description) {
            [weakSelf.table.mj_header endRefreshing];
        }];
    }];
}

- (void)confirm {
    Fcgo_AddRealNameVC *vc = [[Fcgo_AddRealNameVC alloc]init];
    vc.hidesBottomBarWhenPushed = 1;
    vc.delegate = self;
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
    WEAKSELF(weakSelf)
    Fcgo_RealNameTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"realNameTableCell"];
    if (self.listArray.count > 0) {
        Fcgo_RealNameModel *model = self.listArray[indexPath.row];
        if (model.mchPicurlB && ![model.mchPicurlB isEqualToString:@""]) {
            cell.model = model;
            
        }
        else {
            Fcgo_RealNameNoImageTableCell *cell1 = [tableView dequeueReusableCellWithIdentifier:@"realNameNoImageTableCell"];
            cell1.model = model;
            cell1.defaultBlock = ^(Fcgo_RealNameModel *model) {
                [weakSelf setDefaultAdressWithModel:model];
            };
            cell1.editBlock = ^(Fcgo_RealNameModel *model) {
                Fcgo_AddRealNameVC *vc = [[Fcgo_AddRealNameVC alloc]init];
                vc.hidesBottomBarWhenPushed = 1;
                vc.delegate = weakSelf;
                vc.model = model;
                [self.navigationController pushViewController:vc animated:1];
            };
            cell1.deleteBlock = ^(Fcgo_RealNameModel *model) {
                [weakSelf deleteAdressWithModel:model];
            };
            return cell1;
        }
    }
    cell.defaultBlock = ^(Fcgo_RealNameModel *model) {
        [weakSelf setDefaultAdressWithModel:model];
    };
    cell.editBlock = ^(Fcgo_RealNameModel *model) {
        Fcgo_AddRealNameVC *vc = [[Fcgo_AddRealNameVC alloc]init];
        vc.hidesBottomBarWhenPushed = 1;
        vc.delegate = weakSelf;
        vc.model = model;
        [self.navigationController pushViewController:vc animated:1];
    };
    cell.deleteBlock = ^(Fcgo_RealNameModel *model) {
        [weakSelf deleteAdressWithModel:model];
    };
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.listArray.count > 0) {
        Fcgo_RealNameModel *model = self.listArray[indexPath.row];
        if (model.mchPicurlB && ![model.mchPicurlB isEqualToString:@""]) {
            return 123 + 100/1.6;
        }
    }
    return 123;
}

#pragma mark - UI
- (void)setupUI; {
    WEAKSELF(weakSelf)
    [self.navigationView setupBackBtnBlock:^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    }];
    [self.navigationView setupTitleLabelWithTitle:@"实名认证"];
    
    [self.table registerNib:[UINib nibWithNibName:NSStringFromClass([Fcgo_RealNameTableCell class]) bundle:nil] forCellReuseIdentifier:@"realNameTableCell"];
    [self.table registerNib:[UINib nibWithNibName:NSStringFromClass([Fcgo_RealNameNoImageTableCell class]) bundle:nil] forCellReuseIdentifier:@"realNameNoImageTableCell"];
    
    self.table.mj_header = [Fcgo_RefreshNormalHeader headerRefreshBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf requestRealNameList];
        });
    }];
    
    [self.view addSubview:self.table];
    
    [self.addNewRealNameBtn addTarget:self action:@selector(confirm) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.addNewRealNameBtn];
    [self.addNewRealNameBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_offset(0);
        make.height.mas_offset(kAutoWidth6(50));
    }];
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
