//
//  Fcgo_AddStoreIDVC.m
//  Fcgo
//
//  Created by huafanxiao on 2017/11/24.
//  Copyright © 2017年 Fcg. All rights reserved.
//

#import "Fcgo_AddStoreIDVC.h"
#import "Fcgo_AddStorePhotoCell.h"

@interface Fcgo_AddStoreIDVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView    *table;
@property (nonatomic,strong) NSArray        *storeIDArray;

@end

@implementation Fcgo_AddStoreIDVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupUI];
    self.storeIDArray = @[@"营业执照",@"身份证",@"食品许可证"];
}

- (void)setupUI;
{
    WEAKSELF(weakSelf)
    [self.navigationView setupBackBtnBlock:^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    }];
    [self.navigationView setupTitleLabelWithTitle:@"店铺证件"];
    
    [self.table registerNib:[UINib nibWithNibName:NSStringFromClass([Fcgo_AddStorePhotoCell class]) bundle:nil] forCellReuseIdentifier:@"addStorePhotoCell"];
    [self.view insertSubview:self.table belowSubview:self.navigationView];
}

#pragma mark table delegate datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.storeIDArray.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Fcgo_AddStorePhotoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"addStorePhotoCell"];
    cell.storePhotoLabel.text = self.storeIDArray[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 84;
}


#pragma mark Lazy method

- (UITableView *)table
{
    if (!_table) {
        UITableView *table = [[UITableView alloc]initWithFrame:CGRectMake(0, kNavigationHeight, kScreenWidth, KScreenHeight - kNavigationHeight) style:UITableViewStylePlain];
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

@end



