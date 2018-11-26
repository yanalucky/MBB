//
//  Fcgo_AddressManagerVC.m
//  Fcgo
//
//  Created by huafanxiao on 2017/5/23.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_AddressManagerVC.h"
#import "Fcgo_AddNewAdressVC.h"
#import "Fcgo_AdressTableViewCell.h"
#import "Fcgo_AddNewAdressTableViewCell.h"
#import "Fcgo_AddressModel.h"

@interface Fcgo_AddressManagerVC ()<UITableViewDelegate,UITableViewDataSource,AddOrEditAdressDelegate>

@property (nonatomic,strong) UITableView    *table;
@property (nonatomic,strong) NSMutableArray *listArray;
@property (nonatomic,strong) UIButton       *addNewAdressBtn;
@property (nonatomic,assign) NSInteger      defaultIndex;

@end

@implementation Fcgo_AddressManagerVC




- (void)reloadRequest
{
    if (![Fcgo_Tools isNetworkConnected]) {
        [WSProgressHUD showImage:nil status:@"亲,没联网啊"];
        [self showUIData:NO];
        return;
    }
    WEAKSELF(weakSelf);
    NSMutableDictionary  *muatble = [NSMutableDictionary dictionary];
    
    [Fcgo_NetworkManager postRequest:NSFormatHeardMeThodUrl(ServiceLocalTypeOne,ADDRESSMETHOD, @"storeAddressList") parametersContentCommon:muatble successBlock:^(BOOL success, id responseObject, NSString *msg) {
        [weakSelf.listArray removeAllObjects];
        if (success&(((NSArray *)responseObject[@"data"]).count != 0)) {
            [weakSelf showUIData:1];
            NSArray   *listArray = responseObject[@"data"];
            for (int i = 0; i < listArray.count; i ++) {
                NSDictionary *couponDict = listArray[i];
                Fcgo_AddressModel *model = [Fcgo_AddressModel yy_modelWithDictionary:couponDict];
                if (model.deFault.intValue == 1) {
                    weakSelf.defaultIndex = i;
                }
                [weakSelf.listArray addObject:model];
            }
            if (weakSelf.listArray.count<=0) {
                [weakSelf showMoreUIData:0];
            }else{
                [weakSelf showMoreUIData:1];
            }
            [weakSelf.table reloadData];
        }
        else
        {
            [weakSelf showUIData:0];
        }
        [WSProgressHUD dismiss];
        [self.table.mj_header endRefreshing];
    } failureBlock:^(NSString *description) {
        [weakSelf showUIData:0];
    }];
    
}

- (void)showUIData:(BOOL)isShow
{
    [self showNoControl:!isShow titleString:@"网络错误,点击重新加载" imageString:@"ico_no-wifi"];
    self.table.hidden = !isShow;
}

- (void)showMoreUIData:(BOOL)isShow
{
    [self showNoControl:!isShow titleString:@"暂无地址" imageString:@"ico_no-id"];
    self.table.hidden = !isShow;
}

- (void)setDefaultAdressWithModel:(Fcgo_AddressModel *)model
{
    WEAKSELF(weakSelf);
    [Fcgo_AlertAnimationView showWithTitle:@"提示" text:@"确认修改默认地址?" cancelTitle:@"取消" confirmTitle:@"确定" block:^{
        NSMutableDictionary  *muatble = [NSMutableDictionary dictionary];
        [muatble setObjectWithNullValidate:model.f_address_id forKey:@"id"];
        [WSProgressHUD showWithStatus:@"数据加载..." maskType:WSProgressHUDMaskTypeClear];
        [Fcgo_NetworkManager postRequest:NSFormatHeardMeThodUrl(ServiceLocalTypeOne,ADDRESSMETHOD, @"setFault") parametersContentCommon:muatble successBlock:^(BOOL success, id responseObject, NSString *msg) {
            [WSProgressHUD dismiss];
            if (success) {
                NSNumber *errCode = responseObject[@"errorCode"];
                if (errCode.intValue == 0) {
                    [WSProgressHUD showSuccessWithStatus:@"设置成功"];
                    Fcgo_AdressTableViewCell *cell = [weakSelf.table cellForRowAtIndexPath:[NSIndexPath indexPathForRow:weakSelf.defaultIndex inSection:0]];
                    Fcgo_AddressModel *model2 = weakSelf.listArray[weakSelf.defaultIndex];
                    model2.deFault = @0;
                    [weakSelf.listArray replaceObjectAtIndex:weakSelf.defaultIndex withObject:model2];
                    cell.defultBtn.select = NO;
                    [cell.defultBtn setBackgroundImage:[UIImage imageNamed:@"select_off"] forState:UIControlStateNormal];
                    
                    int index = 0;
                    for (int i = 0; i < weakSelf.listArray.count; i++) {
                        Fcgo_AddressModel *model1 = weakSelf.listArray[i];
                        if (model.f_address_id.intValue == model1.f_address_id.intValue ) {
                            model.deFault = @1;
                            [weakSelf.listArray replaceObjectAtIndex:i withObject:model];
                            index = i;
                        }
                    }
                    Fcgo_AdressTableViewCell *cell1 = [weakSelf.table cellForRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
                    cell1.defultBtn.select = YES;
                    [cell1.defultBtn setBackgroundImage:[UIImage imageNamed:@"select_on"] forState:UIControlStateNormal];
                    weakSelf.defaultIndex = index;
//                    NSData *myEncodedObject = [NSKeyedArchiver archivedDataWithRootObject:model];
//                    [[NSUserDefaults standardUserDefaults] setObject:myEncodedObject forKey:@"defaultAddress"];
                }
                else
                {
                    
                }
            }
            else
            {
                
            }
            [WSProgressHUD dismiss];
        } failureBlock:^(NSString *description) {
            
        }];
    }];
}

- (void)deleteAdressWithModel:(Fcgo_AddressModel *)model
{
    if (model.deFault.integerValue == 1) {
        [WSProgressHUD showImage:nil status:@"请不要删除默认地址哟~"];
        return;
    }
    WEAKSELF(weakSelf);
    [Fcgo_AlertAnimationView showWithTitle:@"提示" text:@"确认删除地址?" cancelTitle:@"取消" confirmTitle:@"确定" block:^{
        NSMutableDictionary  *muatble = [NSMutableDictionary dictionary];
        [muatble setObjectWithNullValidate:model.f_address_id forKey:@"id"];
        [WSProgressHUD showWithStatus:@"地址删除中..." maskType:WSProgressHUDMaskTypeClear];
        [Fcgo_NetworkManager postRequest:NSFormatHeardMeThodUrl(ServiceLocalTypeOne,ADDRESSMETHOD, @"delAddress") parametersContentCommon:muatble successBlock:^(BOOL success, id responseObject, NSString *msg) {
            [WSProgressHUD dismiss];
            if (success) {
                NSNumber *errCode = responseObject[@"errorCode"];
                if (errCode.intValue == 0) {
                    [WSProgressHUD showSuccessWithStatus:@"删除成功"];
                    if ((model.deFault.intValue == 0)) {
                        for (int i = 0; i < weakSelf.listArray.count; i++) {
                            Fcgo_AddressModel *model1 = weakSelf.listArray[i];
                            if (model.f_address_id.intValue == model1.f_address_id.intValue ) {
                                [weakSelf.listArray removeObject:model];
                                [weakSelf.table deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:i inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
                            }
                        }
                    }
                }
            }
            [weakSelf.table.mj_header endRefreshing];
        } failureBlock:^(NSString *description) {
            [weakSelf.table.mj_header endRefreshing];
        }];
    }];
}

- (void)addOrEditAdressWithModel:(Fcgo_AddressModel *)model
{
    BOOL isEdit = NO;
    for (int i = 0; i < self.listArray.count; i ++) {
        Fcgo_AddressModel *model1= self.listArray[i];
        if (model1.f_address_id.intValue == model.f_address_id.intValue) {
            isEdit = YES;
            if (model.deFault.intValue == 1) {
                if (self.defaultIndex != i) {
                    Fcgo_AddressModel *model2= self.listArray[self.defaultIndex];
                    model2.deFault = @0;
                    [self.listArray replaceObjectAtIndex:self.defaultIndex withObject:model2];
                    [self.table reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:self.defaultIndex inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
                    self.defaultIndex = i;
                }
                
            }
            
            [self.listArray replaceObjectAtIndex:i withObject:model];
            [self.table reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:i inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
        }
    }
    
    if (isEdit == NO) {
        if (model.deFault.intValue == 1) {
            Fcgo_AddressModel *model2= self.listArray[self.defaultIndex];
            model2.deFault = @0;
            [self.listArray replaceObjectAtIndex:self.defaultIndex withObject:model2];
            [self.table reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:self.defaultIndex inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
            self.defaultIndex = 0;
        }
        [self.listArray insertObject:model atIndex:0];
        for (int i = 0; i < self.listArray.count; i ++) {
            Fcgo_AddressModel *model1= self.listArray[i];
            if (model1.deFault.intValue == 1) {
                self.defaultIndex = i;
            }
        }
        [self.table insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
    }
}




- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupUI];
    [WSProgressHUD showWithStatus:@"加载中..." maskType:WSProgressHUDMaskTypeClear];
    [self reloadRequest];
}

- (void)setupUI;
{
    WEAKSELF(weakSelf)
    [self.navigationView setupBackBtnBlock:^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    }];
    [self.navigationView setupTitleLabelWithTitle:@"地址管理"];
    
    [self.addNewAdressBtn addTarget:self action:@selector(addNewAdress) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.addNewAdressBtn];
    [self.addNewAdressBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_offset(0);
        make.height.mas_offset(kAutoWidth6(50));
    }];
    
    [self.table registerNib:[UINib nibWithNibName:NSStringFromClass([Fcgo_AdressTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"adressTableViewCell"];
    [self.table registerNib:[UINib nibWithNibName:NSStringFromClass([Fcgo_AddNewAdressTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"addNewAdressTableViewCell"];
    
    self.table.mj_header = [Fcgo_RefreshNormalHeader headerRefreshBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf reloadRequest];
        });
    }];
    [self.view addSubview:self.table];
}

- (void)addNewAdress
{
    [self pushAddNewAddressWithModel:nil];
}

- (void)pushAddNewAddressWithModel:(NSString *)string
{
    Fcgo_AddNewAdressVC *vc = [[Fcgo_AddNewAdressVC alloc]init];
    vc.hidesBottomBarWhenPushed = 1;
    vc.delegate = self;
    vc.reloadBlock = ^{
        [self reloadRequest];
    };
    [self.navigationController pushViewController:vc animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.listArray.count > 0) {
        return [self.listArray count];
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WEAKSELF(weakSelf)
    Fcgo_AdressTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"adressTableViewCell"];
    
    if (self.listArray.count > 0) {
        Fcgo_AddressModel *model = self.listArray[indexPath.row];
        cell.model = model;
    }
    cell.defaultBlock = ^(Fcgo_AddressModel *model)
    {
        [weakSelf setDefaultAdressWithModel:model];
    };
    cell.editBlock = ^(Fcgo_AddressModel *model)
    {
        Fcgo_AddNewAdressVC *vc = [[Fcgo_AddNewAdressVC alloc]init];
        vc.hidesBottomBarWhenPushed = 1;
        vc.model = model;
        vc.delegate = weakSelf;
        vc.reloadBlock = ^{
            [self reloadRequest];
        };
        [self.navigationController pushViewController:vc animated:YES];
    };
    cell.deleteBlock = ^(Fcgo_AddressModel *model)
    {
        [weakSelf deleteAdressWithModel:model];
    };
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if (indexPath.row == 1) {
//        [self pushAddNewAddressWithModel:nil];
//    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 135;
}

#pragma mark Lazy method

- (UITableView *)table
{
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

- (NSMutableArray *)listArray
{
    if (!_listArray) {
        _listArray = [[NSMutableArray alloc]init];
    }
    return _listArray;
}

- (UIButton *)addNewAdressBtn
{
    if (!_addNewAdressBtn) {
        _addNewAdressBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        _addNewAdressBtn.titleLabel.font = UIFontSize(16);
        [_addNewAdressBtn setTitle:@"添加新地址" forState:UIControlStateNormal];
        [_addNewAdressBtn setTitleColor:UIFontWhiteColor forState:UIControlStateNormal];
        [_addNewAdressBtn setBackgroundColor:UIFontRedColor];
    }
    return _addNewAdressBtn;
}

@end
