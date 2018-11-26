//
//  Fcgo_EmployeeManager.m
//  Fcgo
//
//  Created by by_r on 2017/11/24.
//  Copyright © 2017年 Fcg. All rights reserved.
//

#import "Fcgo_EmployeeManagerVC.h"
#import "Fcgo_EmployeeDetailVC.h"
#import "Fcgo_EmployeeCell.h"

static NSString *employeeIdentifier = @"cell";
@interface Fcgo_EmployeeManagerVC ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView         *myTableView;
@property (nonatomic, strong) NSMutableArray       *dataArray;
@property (nonatomic, strong) UIButton           *bottomButton;
@end

@implementation Fcgo_EmployeeManagerVC
- (void)viewDidLoad {
    [super viewDidLoad];
    WEAKSELF(weakSelf)
    [self.navigationView setupBackBtnBlock:^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    }];
    [self.navigationView setupTitleLabelWithTitle:@"员工管理"];
    
    [self setupUI];
}


- (void)setupUI
{
    WEAKSELF(weakSelf)
    UIImageView *imageView = [[UIImageView alloc]init];
    imageView.userInteractionEnabled = 1;
    imageView.image = [UIImage imageNamed:@"ico_chuizi@2x"];
    [self.view addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(100);
        make.height.width.mas_offset(kAutoWidth6(120));
        make.centerX.mas_equalTo(weakSelf.view);
    }];
    
    UILabel *midleLabel = [[UILabel alloc]init];
    midleLabel.font = UIFontSize(14);
    midleLabel.text = @"功能开发中,敬请等待";
    midleLabel.textColor = UIFontSortGrayColor;
    midleLabel.numberOfLines = 1;
    midleLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:midleLabel];
    [midleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(imageView.mas_bottom).mas_offset(35);
        make.left.mas_offset(15);
        make.right.mas_offset(-15);
    }];
}
/*
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupUI];
    [self postRequest];
}

- (void)postRequest
{
    WEAKSELF(weakSelf);
    //[WSProgressHUD showWithStatus:@"数据删除中..." maskType:WSProgressHUDMaskTypeClear];
    [Fcgo_NetworkManager postRequest:NSFormatHeardMeThodUrl(ServiceLocalTypeOne,@"mch/user/", @"listMchStoreUsers") parametersContentCommon:nil successBlock:^(BOOL success, id responseObject, NSString *msg) {
        [WSProgressHUD dismiss];
        if (success) {
            [WSProgressHUD showSuccessWithStatus:@"删除成功"];
        }
        
    } failureBlock:^(NSString *description) {
        
    }];
}

#pragma mark - private method
- (void)bottomButtonAction:(UIButton *)sender {
    
}
#pragma mark - delegate
#pragma mark UITableView
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    Fcgo_EmployeeDetailVC *vc = [[Fcgo_EmployeeDetailVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    Fcgo_EmployeeCell *cell = [tableView dequeueReusableCellWithIdentifier:employeeIdentifier];

    return cell;
}

#pragma mark - UI
- (void)setupUI {
    WEAKSELF(weakSelf);
    self.view.backgroundColor = UIBackGroundColor;
    [self.navigationView setupTitleLabelWithTitle:@"员工管理"];
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
    table.estimatedRowHeight = 80.f;
    [table registerClass:[Fcgo_EmployeeCell class] forCellReuseIdentifier:employeeIdentifier];
    [self.view insertSubview:table belowSubview:self.navigationView];
    _myTableView = table;
    // bottomView
    UIButton *bottomButton = [UIButton buttonWithType:UIButtonTypeCustom];
    bottomButton.frame = CGRectMake(0, KScreenHeight - bottomHeight, kScreenWidth, bottomHeight);
    bottomButton.backgroundColor = UIFontRedColor;
    [bottomButton setTitle:@"添加新的员工" forState:UIControlStateNormal];
    [bottomButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [bottomButton addTarget:self action:@selector(bottomButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bottomButton];
    _bottomButton = bottomButton;
}

#pragma mark - lazy load
- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = @[].mutableCopy;
    }
    return _dataArray;
}
*/
@end
