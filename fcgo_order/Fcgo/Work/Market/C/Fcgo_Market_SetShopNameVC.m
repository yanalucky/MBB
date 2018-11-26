//
//  Fcgo_Market_SetShopNameVC.m
//  Fcgo
//
//  Created by huafanxiao on 2017/8/2.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_Market_SetShopNameVC.h"

#import "Fcgo_SafeTableViewCell.h"

@interface Fcgo_Market_SetShopNameVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UIButton    *confirmBtn;
@property (nonatomic,strong) UITableView *table;

@end

@implementation Fcgo_Market_SetShopNameVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupUI];
}

- (void)setupUI;
{
    WEAKSELF(weakSelf)
    
    self.view.backgroundColor = UIBackGroundColor;
    [self.navigationView setupBackBtnBlock:^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    }];
    [self.navigationView setupTitleLabelWithTitle:@"店铺名称"];
    
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
    WEAKSELF(weakSelf);
    [Fcgo_AlertAnimationView showWithTitle:@"提示" text:@"确认修改店铺名称？" cancelTitle:@"取消" confirmTitle:@"确定" block:^{
        //发送退出请求
        [weakSelf alterTel];
    }];
}

- (void)alterTel
{
    /*
    
    Fcgo_SafeTableViewCell *cell0 = [self.table cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    if (cell0.textField.text.length<=0 || ![Fcgo_Tools valiMobile:cell0.textField.text]) {
        [WSProgressHUD showImage:nil status:@"请输入正确的手机号码"];
        return;
    }
    
    NSString *tel = [Fcgo_UserTools shared].userDict[@"userMobile"];
    NSMutableDictionary  *muatble = [NSMutableDictionary dictionary];
    [muatble  setObjectWithNullValidate:[Fcgo_Tools getDeviceId] forKey:@"udid"];
    [muatble  setObjectWithNullValidate:@"1" forKey:@"type"];
    [muatble  setObjectWithNullValidate:tel forKey:@"mobile"];
    [muatble  setObjectWithNullValidate:self.code forKey:@"recode"];
    [muatble  setObjectWithNullValidate:cell0.textField.text forKey:@"newMobile"];
    [muatble  setObjectWithNullValidate:cell1.textField.text forKey:@"newRecode"];
    [WSProgressHUD showWithStatus:@"手机号绑定中,请稍后..." maskType:WSProgressHUDMaskTypeClear];
    [Fcgo_NetworkManager postRequest:NSFormatHeardUrl(@"mer/user/changeInfo") parameters:muatble successBlock:^(BOOL success, id responseObject, NSString *msg) {
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
        
    }];*/
}

#pragma mark table delegate datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    Fcgo_SafeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"safeTableViewCell"];
    cell.textField.placeholder = @"请输入新的店铺名称";
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kAutoWidth6(50);
}

#pragma mark Lazy method

- (UITableView *)table
{
    if (!_table) {
        UITableView *table    = [[UITableView alloc]initWithFrame:CGRectMake(0, 69, kScreenWidth, KScreenHeight - 69 - kAutoWidth6(50)) style:UITableViewStylePlain];
        table.backgroundColor = UIBackGroundColor;
        table.delegate        = self;
        table.separatorStyle  = 0;
        table.dataSource      = self;
        table.alpha           = 1;
        table.tableFooterView = [UIView new];
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

