//
//  Fcgo_ChangePasswordVC.m
//  Fcgo
//
//  Created by huafanxiao on 2017/6/7.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_ChangePasswordVC.h"
#import "Fcgo_SafeTableViewCell.h"
#import "Fcgo_SafeTelTableViewCell.h"
#import "Fcgo_SafeCodeTableViewCell.h"

@interface Fcgo_ChangePasswordVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UIButton    *confirmBtn;
@property (nonatomic,strong) UITableView *table;
@property (nonatomic,strong) NSArray     *titleArray;

@end

@implementation Fcgo_ChangePasswordVC

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
    [self.navigationView setupTitleLabelWithTitle:@"修改登录密码"];
    
    self.titleArray = @[@"请输入新密码",@"请再次输入密码"];
    
    [self.table registerNib:[UINib nibWithNibName:NSStringFromClass([Fcgo_SafeTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"safeTableViewCell"];
    [self.table registerNib:[UINib nibWithNibName:NSStringFromClass([Fcgo_SafeTelTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"safeTelTableViewCell"];
    [self.table registerNib:[UINib nibWithNibName:NSStringFromClass([Fcgo_SafeCodeTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"safeCodeTableViewCell"];
    
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
    Fcgo_SafeCodeTableViewCell *cell3 = [self.table cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:2]];
    if (cell3.textField.text.length<=0 ) {
        [WSProgressHUD showImage:nil status:@"请输入正确的验证码"];
        return;
    }
    NSMutableDictionary  *muatble = [NSMutableDictionary dictionary];
    [muatble  setObjectWithNullValidate:cell3.textField.text forKey:@"code"];
    [muatble  setObjectWithNullValidate:cell0.textField.text forKey:@"password"];
    [WSProgressHUD showWithStatus:@"修改密码中,请稍后..." maskType:WSProgressHUDMaskTypeClear];
    [Fcgo_NetworkManager postRequest:NSFormatHeardMeThodUrl(ServiceLocalTypeOne,@"mch/user/", @"changePasswd") parametersContentCommon:muatble successBlock:^(BOOL success, id responseObject, NSString *msg) {
       if (success) {
            
            NSNumber *errCode = responseObject[@"errorCode"];
            if (errCode.intValue == 0) {
                [WSProgressHUD showImage:nil status:@"修改成功,请重新登录"];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [Fcgo_Delegate setLoginVCToRootVC];
                });
            }
            else
            {
                
            }
        }
        else
        {
            
        }
    } failureBlock:^(NSString *description) {
        
    }];
}

- (void)sendCodeBtn:(UIButton *)btn
{
    NSMutableDictionary  *muatble = [NSMutableDictionary dictionary];
    [muatble  setObjectWithNullValidate:@"2" forKey:@"sendType"];
    [muatble  setObjectWithNullValidate:@"1" forKey:@"useType"];
    [Fcgo_NetworkManager postRequest:NSFormatHeardMeThodUrl(ServiceLocalTypeOne,COMMONMETHOD,@"sendCode") parametersContentCommon:muatble successBlock:^(BOOL success, id responseObject, NSString *msg) {
        if (success) {
            [Fcgo_Tools timeDownWithBtn:btn];
        }
    } failureBlock:^(NSString *description) {}];
}

#pragma mark table delegate datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 2;
    }
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WEAKSELF(weakSelf);
    if (indexPath.section == 0) {
        Fcgo_SafeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"safeTableViewCell"];
        cell.textField.placeholder = self.titleArray[indexPath.row];
        
        return cell;
    }
    else if (indexPath.section == 1)
    {
        Fcgo_SafeTelTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"safeTelTableViewCell"];
        NSString *tel = [Fcgo_UserTools shared].userDict[@"opPhone"];
        //前边三个
        NSString *tel1  = [tel substringToIndex:3];
        NSString *tel2  = [tel substringFromIndex:8];
        NSString *phone = [NSString stringWithFormat:@"%@*****%@",tel1,tel2];
        cell.titleLabel.text = [NSString stringWithFormat:@"已绑手机号码  %@",phone];
        return cell;
    }
    
    Fcgo_SafeCodeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"safeCodeTableViewCell"];
    cell.textField.placeholder = @"请输入验证码";
    cell.sendBlock = ^(UIButton *btn){
        //发送验证码
        [weakSelf sendCodeBtn:btn];
    };
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
    
    if(section == 2)
    {
        footerView.backgroundColor = UINavSepratorLineColor;
        
    }else{
        footerView.backgroundColor = UIBackGroundColor;
    }
    
   
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
        table.scrollEnabled   = 0;
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
