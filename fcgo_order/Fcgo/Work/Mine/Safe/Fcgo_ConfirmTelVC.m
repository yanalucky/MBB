//
//  Fcgo_ConfirmTelVC.m
//  Fcgo
//
//  Created by huafanxiao on 2017/6/7.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_ConfirmTelVC.h"
#import "Fcgo_SafeTableViewCell.h"
#import "Fcgo_SafeCodeTableViewCell.h"

@interface Fcgo_ConfirmTelVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UIButton    *confirmBtn;
@property (nonatomic,strong) UITableView *table;

@end

@implementation Fcgo_ConfirmTelVC

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
    [self.navigationView setupTitleLabelWithTitle:@"修改绑定手机"];
    
    [self.table registerNib:[UINib nibWithNibName:NSStringFromClass([Fcgo_SafeTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"safeTableViewCell"];
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
    WEAKSELF(weakSelf);
    [Fcgo_AlertAnimationView showWithTitle:@"提示" text:@"修改手机号,同时您的登录名也将会是新设置的手机号码,确认修改？" cancelTitle:@"取消" confirmTitle:@"确定" block:^{
        //发送退出请求
        [weakSelf alterTel];
    }];
}
    
- (void)alterTel
{
    Fcgo_SafeTableViewCell *cell0 = [self.table cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    if (cell0.textField.text.length<=0 || ![Fcgo_Tools valiMobile:cell0.textField.text]) {
        [WSProgressHUD showImage:nil status:@"请输入正确的手机号码"];
        return;
    }
    Fcgo_SafeCodeTableViewCell *cell1 = [self.table cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    if (cell1.textField.text.length<=0 ) {
        [WSProgressHUD showImage:nil status:@"请输入正确的验证码"];
        return;
    }
    NSMutableDictionary  *muatble = [NSMutableDictionary dictionary];
    [muatble  setObjectWithNullValidate:cell0.textField.text forKey:@"newMobile"];
    [muatble  setObjectWithNullValidate:cell1.textField.text forKey:@"code"];
    [WSProgressHUD showWithStatus:@"手机号绑定中,请稍后..." maskType:WSProgressHUDMaskTypeClear];
    [Fcgo_NetworkManager postRequest:NSFormatHeardMeThodUrl(ServiceLocalTypeOne,@"mch/user/", @"changeLoginAccount") parametersContentCommon:muatble successBlock:^(BOOL success, id responseObject, NSString *msg) {
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
    Fcgo_SafeTableViewCell *cell0 = [self.table cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    if (cell0.textField.text.length<=0 || ![Fcgo_Tools valiMobile:cell0.textField.text]) {
        [WSProgressHUD showImage:nil status:@"请输入正确的手机号码"];
        return;
    }
    NSMutableDictionary  *muatble = [NSMutableDictionary dictionary];
    [muatble  setObjectWithNullValidate:@"3" forKey:@"sendType"];
    [muatble  setObjectWithNullValidate:@"2" forKey:@"useType"];
    [muatble  setObjectWithNullValidate:cell0.textField.text forKey:@"mobile"];
    [Fcgo_NetworkManager postRequest:NSFormatHeardMeThodUrl(ServiceLocalTypeOne,COMMONMETHOD,@"sendCode") parametersContentCommon:muatble successBlock:^(BOOL success, id responseObject, NSString *msg) {
        if (success) {
            [Fcgo_Tools timeDownWithBtn:btn];
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
    WEAKSELF(weakSelf);
    if (indexPath.row == 0) {
        Fcgo_SafeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"safeTableViewCell"];
        cell.textField.placeholder = @"请输入新的手机号";
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
