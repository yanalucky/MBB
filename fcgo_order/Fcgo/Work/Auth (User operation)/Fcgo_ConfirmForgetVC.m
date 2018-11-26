//
//  Fcgo_ConfirmForgetVC.m
//  Fcgo
//
//  Created by huafanxiao on 2017/6/9.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_ConfirmForgetVC.h"
#import "Fcgo_SafeTableViewCell.h"

@interface Fcgo_ConfirmForgetVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UIButton    *confirmBtn;
@property (nonatomic,strong) UITableView *table;
@property (nonatomic,strong) NSArray     *titleArray;

@end

@implementation Fcgo_ConfirmForgetVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupUI];
}

- (void)setupUI;
{
    WEAKSELF(weakSelf)
    [self.navigationView setupBackBtnBlock:^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    }];
    [self.navigationView setupTitleLabelWithTitle:@"重设登录密码"];
    
    self.titleArray = @[@"请输入新密码",@"请再次输入密码"];
    
    [self.table registerNib:[UINib nibWithNibName:NSStringFromClass([Fcgo_SafeTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"safeTableViewCell"];
    [self.view addSubview:self.table];
    
    [self.confirmBtn addTarget:self action:@selector(confirm) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.confirmBtn];
    [self.confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_offset(0);
        make.height.mas_offset(kAutoWidth6(50));
    }];
}

- (void)confirm
{
    Fcgo_SafeTableViewCell *cell0 = [self.table cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    if (cell0.textField.text.length < 6) {
        [WSProgressHUD showImage:nil status:@"密码长度不能少于6位"];
        return;
    }
    Fcgo_SafeTableViewCell *cell1 = [self.table cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    if (![cell1.textField.text isEqualToString:cell0.textField.text]) {
        [WSProgressHUD showImage:nil status:@"两次密码不一致"];
        return;
    }
    NSMutableDictionary  *muatble = [NSMutableDictionary dictionary];
    [muatble  setObjectWithNullValidate:cell0.textField.text forKey:@"password"];
    [muatble  setObjectWithNullValidate:self.tel forKey:@"mobile"];
    [WSProgressHUD showWithStatus:@"重置密码中,请稍后..." maskType:WSProgressHUDMaskTypeClear];
    
    
//    NSMutableDictionary  *muatble =[[NSMutableDictionary  alloc] init];
//    [muatble  setObjectWithNullValidate:self.passwordTF.text forKey:@"password"];
//    [muatble  setObjectWithNullValidate:self.telTF.text forKey:@"loginName"];
//    [muatble  setObjectWithNullValidate:Dev_logSource forKey:@"loginSource"];
    [Fcgo_NetworkManager postRequest:NSFormatHeardMeThodUrl(ServiceLocalTypeOne,@"mch/user/", @"forgetPassword") parametersContentCommon:muatble successBlock:^(BOOL success, id responseObject, NSString *msg) {

        if (success) {
            [WSProgressHUD showImage:nil status:@"修改成功,请重新登录"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [Fcgo_Delegate setLoginVCToRootVC];
            });
        }
     } failureBlock:^(NSString *description) {}];
}

#pragma mark table delegate datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Fcgo_SafeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"safeTableViewCell"];
    cell.textField.placeholder = self.titleArray[indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        return kAutoWidth6(30);
    }
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
        UITableView *table    = [[UITableView alloc]initWithFrame:CGRectMake(0, kNavigationHeight, kScreenWidth, KScreenHeight - kNavigationHeight-kAutoWidth6(50)) style:UITableViewStylePlain];
        table.backgroundColor = UIBackGroundColor;
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

- (UIButton *)confirmBtn
{
    if (!_confirmBtn) {
        _confirmBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        _confirmBtn.titleLabel.font = UIFontSize(16);
        [_confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_confirmBtn setTitleColor:UIFontWhiteColor forState:UIControlStateNormal];
        [_confirmBtn setBackgroundColor:UIFontRedColor];
    }
    return _confirmBtn;
}

@end

