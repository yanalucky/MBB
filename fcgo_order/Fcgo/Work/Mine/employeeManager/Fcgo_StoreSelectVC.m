//
//  Fcgo_StoreSelectVC.m
//  Fcgo
//
//  Created by by_r on 2017/11/24.
//  Copyright © 2017年 Fcg. All rights reserved.
//

#import "Fcgo_StoreSelectVC.h"

@interface Fcgo_StoreSelectVC ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView         *myTableView;
@property (nonatomic, strong) NSMutableArray       *dataArray;
@end

@implementation Fcgo_StoreSelectVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupUI];
}

#pragma mark - delegate
#pragma mark UITableView
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}

#pragma mark - UI
- (void)setupUI {
    WEAKSELF(weakSelf);
    self.view.backgroundColor = UIBackGroundColor;
    [self.navigationView setupTitleLabelWithTitle:@"所在门店"];
    [self.navigationView setupBackBtnBlock:^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    }];
    CGFloat bottomHeight = 50.f;
    // table
    UITableView *table = [[UITableView alloc] initWithFrame:CGRectMake(0, kNavigationHeight, kScreenWidth, KScreenHeight - kNavigationHeight - bottomHeight)];
    table.delegate = self;
    table.dataSource = self;
    table.backgroundColor = self.view.backgroundColor;
    table.tableFooterView = [UIView new];
    table.rowHeight = 50.f;
//    [table registerClass:[Fcgo_EmployeeCell class] forCellReuseIdentifier:employeeIdentifier];
    [self.view insertSubview:table belowSubview:self.navigationView];
    _myTableView = table;
}

#pragma mark - lazy load
- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = @[].mutableCopy;
    }
    return _dataArray;
}

@end
