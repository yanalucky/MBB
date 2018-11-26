//
//  Fcgo_ChangeTelVC.m
//  Fcgo
//
//  Created by huafanxiao on 2017/6/7.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_ChangeTelVC.h"
#import "Fcgo_SafeTelTableViewCell.h"
#import "Fcgo_SafeCodeTableViewCell.h"

#import "Fcgo_ConfirmTelVC.h"


@interface Fcgo_ChangeTelVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UIButton    *confirmBtn;
@property (nonatomic,strong) UITableView *table;
@property (nonatomic,strong) NSString    *code;

@end

@implementation Fcgo_ChangeTelVC

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
    [self.navigationView setupTitleLabelWithTitle:@"修改登录绑定手机"];

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
    Fcgo_SafeCodeTableViewCell *cell0 = [self.table cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
    if (cell0.textField.text.length<=0 ) {
        [WSProgressHUD showImage:nil status:@"请输入正确的验证码"];
        return;
    }
    NSString *tel = [Fcgo_UserTools shared].userDict[@"opPhone"];
    NSMutableDictionary  *muatble = [NSMutableDictionary dictionary];
    [muatble  setObjectWithNullValidate:@"2" forKey:@"sendType"];
    [muatble  setObjectWithNullValidate:@"3" forKey:@"useType"];
    [muatble  setObjectWithNullValidate:tel forKey:@"mobile"];
    [muatble  setObjectWithNullValidate:cell0.textField.text forKey:@"code"];
    [Fcgo_NetworkManager postRequest:NSFormatHeardMeThodUrl(ServiceLocalTypeOne,COMMONMETHOD,@"checkSendCode") parametersContentCommon:muatble successBlock:^(BOOL success, id responseObject, NSString *msg) {
        if (success) {
            Fcgo_ConfirmTelVC *vc = [[Fcgo_ConfirmTelVC alloc]init];
            vc.hidesBottomBarWhenPushed = 1;
            [self.navigationController pushViewController:vc animated:YES];
        }
    } failureBlock:^(NSString *description) {}];
}

- (void)sendCodeBtn:(UIButton *)btn
{
    NSString *tel = [Fcgo_UserTools shared].userDict[@"opPhone"];
    NSMutableDictionary  *muatble = [NSMutableDictionary dictionary];
    [muatble  setObjectWithNullValidate:@"2" forKey:@"sendType"];
    [muatble  setObjectWithNullValidate:@"3" forKey:@"useType"];
    [muatble  setObjectWithNullValidate:tel forKey:@"mobile"];
    [Fcgo_NetworkManager postRequest:NSFormatHeardMeThodUrl(ServiceLocalTypeOne,COMMONMETHOD,@"sendCode") parametersContentCommon:muatble successBlock:^(BOOL success, id responseObject, NSString *msg) {
        if (success) {
           [Fcgo_Tools timeDownWithBtn:btn];
        }
    } failureBlock:^(NSString *description) {}];
}

#pragma mark table delegate datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WEAKSELF(weakSelf);
    if (indexPath.section == 0)
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
    if (indexPath.section == 0) {
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
    
    if(section == 1)
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
        table.separatorStyle  = 0;
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
