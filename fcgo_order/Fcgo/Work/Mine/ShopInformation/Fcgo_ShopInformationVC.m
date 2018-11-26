//
//  Fcgo_ShopInformationVC.m
//  Fcgo
//
//  Created by huafanxiao on 2017/5/23.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_ShopInformationVC.h"
#import "Fcgo_ShopInformationTableViewCell.h"

@interface Fcgo_ShopInformationVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView    *table;
@property (nonatomic,strong) NSArray        *titleArray;
@property (nonatomic,strong) NSArray        *descriptionArray;
@end

@implementation Fcgo_ShopInformationVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupUI];
}

- (void)setupUI;
{
    /*{
     storeNo = "209920171028526490",
     storeId = 7,
     storeCity = "320100",
     storeProvince = "320000",
     storeAddressDetail = "江苏省南京市市辖区测试",
     storeMobile = "17712429646",
     storeArea = "320101",
     opNo = "123",
     type = 1,
     token = "e0b4cddb-5346-4f66-bada-899892f054ad",
     createTime = "2017-10-28 16:30:10",
     adminId = 29,
     operatorId = 6,
     storeContact = "谢伟",
     storeName = "测试",
     mchId = 0,
     opName = "谢伟",
     opPhone = "17712429646",
     updateTime = "2017-10-28 16:30:10",
     }*/
    
    self.titleArray = @[
                        @"门店名称",
                        @"门店类型",
                        //@"门店所属地区",
                        @"联  系  人",
                        @"联系电话",
                        @"收货地址",
                        ];
    
    self.descriptionArray = @[
                              [Fcgo_UserTools shared].userDict[@"storeName"] ?: @"",
                        //[Fcgo_UserTools shared].userDict[@""],
                        @"合作店",
                        //[Fcgo_UserTools shared].userDict[@"addressFormal"] ?: @"",//storeAddressDetail  storeAddressPrefix
                        [Fcgo_UserTools shared].userDict[@"opName"] ?: @"",
                        [Fcgo_UserTools shared].userDict[@"opPhone"] ?: @"",
                        [Fcgo_UserTools shared].userDict[@"storeAddressDetail"] ?: @""
                        ];
    WEAKSELF(weakSelf)
    [self.navigationView setupBackBtnBlock:^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    }];
    [self.navigationView setupTitleLabelWithTitle:@"账户信息"];
    
    [self.table registerNib:[UINib nibWithNibName:NSStringFromClass([Fcgo_ShopInformationTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"shopInformationTableViewCell"];
    [self.view insertSubview:self.table belowSubview:self.navigationView];
}

#pragma mark table delegate datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.titleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Fcgo_ShopInformationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"shopInformationTableViewCell"];
    cell.titleLabel.text = self.titleArray[indexPath.row];
    cell.descriptionLabel.text = self.descriptionArray[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kAutoWidth6(50);
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.5;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footerView = [[UIView alloc]init];
    footerView.backgroundColor = UINavSepratorLineColor;
    return footerView;
}

#pragma mark Lazy method

- (UITableView *)table
{
    if (!_table) {
        UITableView *table = [[UITableView alloc]initWithFrame:CGRectMake(0, kNavigationHeight, kScreenWidth, KScreenHeight - kNavigationHeight) style:UITableViewStylePlain];
        table.delegate = self;
        table.dataSource = self;
        table.backgroundColor = UIBackGroundColor;
        _table = table;
        if (@available(iOS 11.0, *)) {
            table.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return _table;
}
@end
