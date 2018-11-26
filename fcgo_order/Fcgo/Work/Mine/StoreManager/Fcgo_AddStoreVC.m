//
//  Fcgo_AddStoreVC.m
//  Fcgo
//
//  Created by huafanxiao on 2017/11/24.
//  Copyright © 2017年 Fcg. All rights reserved.
//

#import "Fcgo_AddStoreVC.h"

#import "Fcgo_AddStorePhotoCell.h"
#import "Fcgo_AddStoreChoseCell.h"
#import "Fcgo_AddStoreInputTestCell.h"

#import "Fcgo_AddStoreIDVC.h"

@interface Fcgo_AddStoreVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView    *table;
@property (nonatomic,strong) NSArray *storeMsgArray;
@property (nonatomic,strong) UIButton       *saveBtn;
@property (nonatomic,strong) Fcgo_ExterAddressPickerView *pickerView;
@end

@implementation Fcgo_AddStoreVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupUI];
    self.storeMsgArray = @[@[@"店铺照片",@""],@[@"店铺名称",@"请输入店铺名称"],@[@"店铺类型",@"请选择店铺类型"],@[@"所在城市",@"请选择所在城市"],@[@"店铺地址",@"请输入店铺地址"],@[@"联系电话",@"请输入联系人电话"],@[@"店铺证件",@"请上传店铺证件"]];
}

- (void)setupUI;
{
    WEAKSELF(weakSelf)
    [self.navigationView setupBackBtnBlock:^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    }];
    [self.navigationView setupTitleLabelWithTitle:@"添加新门店"];
    
    [self.table registerNib:[UINib nibWithNibName:NSStringFromClass([Fcgo_AddStorePhotoCell class]) bundle:nil] forCellReuseIdentifier:@"addStorePhotoCell"];
    [self.table registerNib:[UINib nibWithNibName:NSStringFromClass([Fcgo_AddStoreChoseCell class]) bundle:nil] forCellReuseIdentifier:@"addStoreChoseCell"];
    
    
    [self.table registerNib:[UINib nibWithNibName:NSStringFromClass([Fcgo_AddStoreInputTestCell class]) bundle:nil] forCellReuseIdentifier:@"addStoreInputTestCell"];
    
    [self.view insertSubview:self.table belowSubview:self.navigationView];
    
    [self.saveBtn addTarget:self action:@selector(addStoreClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.saveBtn];
    [self.saveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_offset(0);
        make.height.mas_offset(kAutoWidth6(50));
    }];
    
    [self.view addSubview:self.pickerView];
}

- (void)addStoreClick
{
    
}

#pragma mark table delegate datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.storeMsgArray.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    if(indexPath.row == 0)
    {
        Fcgo_AddStorePhotoCell *cell0 = [tableView dequeueReusableCellWithIdentifier:@"addStorePhotoCell"];
        cell = cell0;
    }
    else  if(indexPath.row == 1 || indexPath.row == 4 || indexPath.row == 5){
        Fcgo_AddStoreInputTestCell *cell1 = [tableView dequeueReusableCellWithIdentifier:@"addStoreInputTestCell"];
        cell1.titleLabel.text = self.storeMsgArray[indexPath.row][0];
        cell1.textField.placeholder = self.storeMsgArray[indexPath.row][1];
        cell = cell1;
    }
    else{
        Fcgo_AddStoreChoseCell *cell2 = [tableView dequeueReusableCellWithIdentifier:@"addStoreChoseCell"];
        cell2.titleLabel.text = self.storeMsgArray[indexPath.row][0];
        cell2.choseLabel.text = self.storeMsgArray[indexPath.row][1];
        cell = cell2;
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0)
    {
        return 84;
    }
    return kAutoWidth6(50);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.view endEditing:YES];
    
    if (indexPath.row == 2) {
        //店铺类型
        WEAKSELF(weakSelf)
        [Fcgo_SheetAnimationView showWithArray:@[@"店长",@"店员"] DidSelectedBlock:^(NSInteger index) {
        }];
    }
    else if(indexPath.row == 3){
        //选择地区
        [self.pickerView show];
    }
    else if(indexPath.row == 6){
        //上传店铺证件
        Fcgo_AddStoreIDVC *vc = [[Fcgo_AddStoreIDVC alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark Lazy method

- (UITableView *)table
{
    if (!_table) {
        UITableView *table = [[UITableView alloc]initWithFrame:CGRectMake(0, kNavigationHeight, kScreenWidth, KScreenHeight - kNavigationHeight-kAutoWidth6(50)) style:UITableViewStylePlain];
        table.delegate = self;
        table.dataSource = self;
        table.backgroundColor = UIBackGroundColor;
        table.separatorStyle = UITableViewCellSeparatorStyleNone;
        table.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
        _table = table;
        if (@available(iOS 11.0, *)) {
            table.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return _table;
}

- (UIButton *)saveBtn
{
    if (!_saveBtn) {
        _saveBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        _saveBtn.titleLabel.font = UIFontSize(16);
        [_saveBtn setTitle:@"保存" forState:UIControlStateNormal];
        [_saveBtn setTitleColor:UIFontWhiteColor forState:UIControlStateNormal];
        [_saveBtn setBackgroundColor:UIFontRedColor];
    }
    return _saveBtn;
}

- (Fcgo_ExterAddressPickerView *)pickerView
{
    WEAKSELF(weakSelf)
    if (!_pickerView) {
        _pickerView = [[Fcgo_ExterAddressPickerView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, KScreenHeight) selectAddressBlock:^(NSMutableDictionary *addressDict) {
            //weakSelf.addressDict = addressDict;
//            Fcgo_GoodsDetailSection1Cell *cell = [weakSelf.table cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
//            //            NSLog(@"addressDict = %@",addressDict);
//            cell.choseLabel.text = [NSString stringWithFormat:@"%@%@",addressDict[@"city"][@"areaName"],addressDict[@"area"][@"areaName"]];
//            
//            cell.choseLabel.textColor = UIFontMainGrayColor;
        }];
    }
    return _pickerView;
}

@end


