//
//  UserViewController.m
//  BabyDemo
//
//  Created by 陈彦 on 16/5/16.
//  Copyright © 2016年 elsa. All rights reserved.
//

#import "UserViewController.h"
#import "UserButton.h"
#import "LoginUser.h"
#import "ServerConfigDoctorList.h"
#import "ServerConfigHospitalList.h"

#import "UIImageView+WebCache.h"


#import "UserDetailViewController.h"

#import "NetRequestManage.h"
#import "SVProgressHUD.h"

#import "MenuViewController.h"

#import "BabySittingViewController.h"
#import "FirPageViewController.h"
#import "BuyViewController.h"
#import "UserDefaultsManager.h"
#import "AppDelegate.h"
#import "CYRecordAlertView.h"


@interface UserViewController (){
    UILabel *dateToDate;
    NSMutableArray *_currentMenu;
    NSString *_doctorName;
    NSString *_hospitalName;
    NSString *_userRole;
}

@end

@implementation UserViewController
-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = NO;
    
    if ([_userRole intValue] == 0) {
        
    }else{
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
        [SVProgressHUD show];
        [NetRequestManage getCurrentMenuWithUserId:[[NSUserDefaults standardUserDefaults] objectForKey:@"userId"] successBlocks:^(NSData *data, NetRequestManage *getCurrentMenu) {
            [SVProgressHUD dismiss];
            NSString *str = [[NSString alloc] initWithData:getCurrentMenu.resultData encoding:NSUTF8StringEncoding];
            NSLog(@"getCurrentMenu = %@",str);
            
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:getCurrentMenu.resultData options:NSJSONReadingMutableContainers error:nil];
            if ([[dic objectForKey:@"errorId"] intValue] == 0) {
                if (![[[dic objectForKey:@"result"] objectForKey:@"UserCurrentMenuList"] isKindOfClass:[NSNull class]]) {
                    if ([[[dic objectForKey:@"result"] objectForKey:@"UserCurrentMenuList"] objectForKey:@"startTime"]) {
                        
                        dateToDate.text = [NSString stringWithFormat:@"%@~%@",[[[[dic objectForKey:@"result"] objectForKey:@"UserCurrentMenuList"] objectForKey:@"startTime"] substringToIndex:10],[[[[dic objectForKey:@"result"] objectForKey:@"UserCurrentMenuList"] objectForKey:@"endTime"] substringToIndex:10]];
                        //套餐期限
                        [_currentMenu addObject:dateToDate.text];
                        
                        [_currentMenu addObject:(_doctorName)?_doctorName:@"无"];
                        [_currentMenu addObject:(_hospitalName)?_hospitalName:@"无"];
                        
                        
                        
                        
                        //套餐时长
                        NSString *path0 = [[NSBundle mainBundle] pathForResource:@"Menu" ofType:@"plist"];
                        NSDictionary *menuDic = [NSDictionary dictionaryWithContentsOfFile:path0];
                        NSString *timeOfMenu = [menuDic objectForKey:[[[dic objectForKey:@"result"] objectForKey:@"UserCurrentMenuList"] objectForKey:@"menuid"]];
                        NSArray *timeAr = [timeOfMenu componentsSeparatedByString:@","];
                        for (NSString *tim in timeAr) {
                            [_currentMenu addObject:tim];
                            
                        }
                        
                        
                    }
                    
                }

            }else{
                
                CYRecordAlertView *alert = [self.view.window viewWithTag:9999];
                [alert alertViewWith:@"错误！" andDetailTitle:[ErrorStatus errorStatus:[NSString stringWithFormat:@"%@",[dic objectForKey:@"errorId"]]]  andButtonTitle:@"0"];
                [alert layoutSubviews];
                
                
                if ([[dic objectForKey:@"errorId"] intValue] == -900) {
                    alert.clickBlocks = ^(void){
                        
                        FirPageViewController *firpage = [[FirPageViewController alloc] init];
                        firpage.isAutoLogin = YES;
                        firpage.isOverTime = YES;
                        
                        [AppDelegate sharedInstance].window.rootViewController = firpage;
                    };
                }
                
                
            }

            
            
        } andFailedBlocks:^(NSError *error, NetRequestManage *getCurrentMenu) {
            [SVProgressHUD showErrorWithStatus:error.localizedDescription];
            
        }];
    }
    

}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = MBColor(227, 252, 255, 1);
    self.navigationItem.title = @"个人中心";
    
    _currentMenu = [[NSMutableArray alloc] init];
    _userRole = [[NSUserDefaults standardUserDefaults] objectForKey:@"userRole"];

    [self createInterface];
    // Do any additional setup after loading the view.
}

-(void)returnBtn:(UIButton *)button{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)createInterface{
    
    
    
#pragma mark =  左边按钮
    
    
//    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//    //    [button setImage:[UIImage imageNamed:@"shouye_top_left"] forState:UIControlStateNormal];
//    [button setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
//    button.selected = NO;
//    [button addTarget:self action:@selector(returnBtn:) forControlEvents:UIControlEventTouchUpInside];
//    button.frame = CGRectMake(0, 0, 10*Ratio, 18*Ratio);
//    
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
#pragma mark = 个人信息
    UIView *userMaterial = [[UIView alloc] init];
    userMaterial.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:userMaterial];
    [userMaterial mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self.view);
        make.top.equalTo(self.view);
        make.height.mas_equalTo(78*Ratio);
    }];
    NSDictionary *userDic = [[NSUserDefaults standardUserDefaults] objectForKey:@"user"];
    NSLog(@"userDic = %@",userDic);
    LoginUser *user = [[LoginUser alloc] initWithDictionary:userDic];
    UIImageView *header = [[UIImageView alloc] init];
//    header.image = [UIImage imageNamed:@"chouti_07"];
//    [header sd_setImageWithURL:[NSURL URLWithString:[NSString urlStringOfImage:user.headimg]] placeholderImage:[UIImage imageNamed:@"chouti_01"]];

    header.layer.masksToBounds = YES;
    header.layer.cornerRadius = 25.5*Ratio;
    NSString *path = NSHomeDirectory();
    NSString *jpgImagePath = [path stringByAppendingPathComponent:@"Documents/header.jpg"];
    header.image = [[UIImage alloc] initWithContentsOfFile:jpgImagePath];
    
    [userMaterial addSubview:header];
    [header mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(51*Ratio, 51*Ratio));
        make.left.equalTo(userMaterial).offset(15*Ratio);
        make.centerY.equalTo(userMaterial);
    }];
    
    UILabel *name = [[UILabel alloc] init];
    [name makeLabelWithText:user.truename andTextColor:MBColor(54, 54, 54, 1) andFont:[UIFont yaHeiFontOfSize:13*Ratio]];
    [userMaterial addSubview:name];
    [name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(userMaterial).offset(15*Ratio);
        make.left.equalTo(header.mas_right).offset(10*Ratio);
        make.size.mas_equalTo(CGSizeMake(100*Ratio, 18*Ratio));
    }];
    
    /*
     
    UIButton *userStyle = [UIButton buttonWithType:UIButtonTypeCustom];
    userStyle.backgroundColor = MBColor(227, 190, 114, 1);
    [userStyle setTitle:@"半年会员" forState:UIControlStateNormal];
    userStyle.titleLabel.font = [UIFont yaHeiFontOfSize:9*Ratio];
    [userStyle setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    userStyle.layer.masksToBounds = YES;
    userStyle.layer.cornerRadius = 6*Ratio;
    [userMaterial addSubview:userStyle];
    [userStyle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(name);
        make.top.equalTo(name.mas_bottom).offset(3*Ratio);
        make.size.mas_equalTo(CGSizeMake(40*Ratio, 12*Ratio));
    }];
     
    */
    UILabel *contract = [[UILabel alloc] init];
    [contract makeLabelWithText:@"服务期限" andTextColor:MBColor(131, 131, 131, 1) andFont:[UIFont yaHeiFontOfSize:9*Ratio]];
    [userMaterial addSubview:contract];
    [contract mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(name);
        make.top.equalTo(name.mas_bottom).offset(8*Ratio);
        make.size.mas_equalTo(CGSizeMake(40*Ratio, 10*Ratio));
    }];
    UILabel *serialNumTt = [[UILabel alloc] init];
    [serialNumTt makeLabelWithText:@"档案编号" andTextColor:MBColor(131, 131, 131, 1) andFont:[UIFont yaHeiFontOfSize:9*Ratio]];
    [userMaterial addSubview:serialNumTt];
    [serialNumTt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contract.mas_right).offset(111*Ratio);
        make.top.equalTo(name.mas_bottom).offset(8*Ratio);
        make.size.mas_equalTo(CGSizeMake(40*Ratio, 10*Ratio));
    }];
    
    dateToDate = [[UILabel alloc] init];
    [dateToDate makeLabelWithText:@"无" andTextColor:MBColor(131, 131, 131, 1) andFont:[UIFont yaHeiFontOfSize:9*Ratio]];
    [userMaterial addSubview:dateToDate];
    [dateToDate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(name);
        make.top.equalTo(contract.mas_bottom).offset(5*Ratio);
        make.size.mas_equalTo(CGSizeMake(145*Ratio, 9*Ratio));
    }];
    
    UILabel *serialNum = [[UILabel alloc] init];
    [serialNum makeLabelWithText:[NSString stringWithFormat:@"%@",(user.filecode)?user.filecode:@"无"] andTextColor:MBColor(131, 131, 131, 1) andFont:[UIFont yaHeiFontOfSize:9*Ratio]];
    [userMaterial addSubview:serialNum];
    [serialNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(serialNumTt);
        make.top.equalTo(serialNumTt.mas_bottom).offset(5*Ratio);
        make.size.mas_equalTo(CGSizeMake(145*Ratio, 9*Ratio));
    }];
    
    
    
#pragma mark = 医生信息
    UILabel *title1 = [[UILabel alloc] init];
    [title1 makeLabelWithText:@"专属医生信息" andTextColor:MBColor(54, 54, 54, 1) andFont:[UIFont yaHeiFontOfSize:12*Ratio]];
    [self.view addSubview:title1];
    [title1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(userMaterial.mas_bottom).offset(10*Ratio);
        make.left.equalTo(self.view).offset(40*Ratio);
        make.size.mas_equalTo(CGSizeMake(75*Ratio, 14*Ratio));
    }];
    ServerConfigDoctorList *userDoctor = [[ServerConfigDoctorList alloc] initWithDictionary:[[[NSUserDefaults standardUserDefaults] objectForKey:@"doctorDic"] objectForKey:user.doctorid]];
    ServerConfigHospitalList *userDocHospital = [[ServerConfigHospitalList alloc] initWithDictionary:[[[NSUserDefaults standardUserDefaults] objectForKey:@"hospitalDic"] objectForKey:userDoctor.hospitalid]];
    UILabel *doctorDetail = [[UILabel alloc] init];
    
    _doctorName = userDoctor.doctorname;
    _hospitalName = userDocHospital.hospitalname;
    [doctorDetail makeLabelWithText:[NSString stringWithFormat:@"%@ | %@",(userDoctor.doctorname)?userDoctor.doctorname:@"无",(userDocHospital.hospitalname)?userDocHospital.hospitalname:@"无"] andTextColor:MBColor(54, 54, 54, 1) andFont:[UIFont yaHeiFontOfSize:9*Ratio]];
    [self.view addSubview:doctorDetail];
    
    [doctorDetail mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(title1.mas_bottom).offset(5*Ratio);
        make.left.equalTo(title1);
        make.size.mas_equalTo(CGSizeMake(270*Ratio, 10*Ratio));
        
    }];
    
    
    UserButton *serve = [UserButton buttonWithType:UIButtonTypeCustom];
    [serve makeViewWithTitle:@"服务套餐信息" andLeftImageName:@"chouti_info_1"];
    [serve addTarget:self action:@selector(currentServeInfo:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:serve];
    [serve mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self.view);
        make.top.equalTo(doctorDetail.mas_bottom).offset(10*Ratio);
        make.height.mas_equalTo(43*Ratio);
    }];
    UIButton *xufei = [UIButton buttonWithType:UIButtonTypeCustom];
   
    [xufei setBackgroundImage:[UIImage imageNamed:@"btn_chouti_info_goumai"] forState:UIControlStateNormal];
    [xufei setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [xufei setTitle:([_userRole intValue] == 0)?@"购买":@"续费" forState:UIControlStateNormal];
    xufei.titleLabel.font = [UIFont yaHeiFontOfSize:13*Ratio];
    [xufei addTarget:self action:@selector(buyAction:) forControlEvents:UIControlEventTouchUpInside];
    [serve addSubview:xufei];
    [xufei mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(50*Ratio, 20*Ratio));
        make.center.equalTo(serve);
        
        
    }];
    
    UserButton *babyInfo = [UserButton buttonWithType:UIButtonTypeCustom];
    [babyInfo makeViewWithTitle:@"宝宝信息" andLeftImageName:@"chouti_info_2"];
    [babyInfo addTarget:self action:@selector(userDetail:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:babyInfo];
    [babyInfo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self.view);
        make.top.equalTo(serve.mas_bottom).offset(1);
        make.height.mas_equalTo(43*Ratio);
    }];
    
    
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"userRole"] intValue] != 0){
        
    
        UserButton *phonePersonInfo = [UserButton buttonWithType:UIButtonTypeCustom];
        [phonePersonInfo makeViewWithTitle:@"常用联系人信息" andLeftImageName:@"chouti_info_5"];
        [phonePersonInfo addTarget:self action:@selector(phonePersonInformation:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:phonePersonInfo];
        [phonePersonInfo mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.and.right.equalTo(self.view);
            make.top.equalTo(babyInfo.mas_bottom).offset(10*Ratio);
            make.height.mas_equalTo(43*Ratio);
        }];
    }
    
    
    
    
#pragma mark = 退出账号
    

    UIButton *leave = [UIButton buttonWithType:UIButtonTypeCustom];
    leave.backgroundColor = [UIColor whiteColor];
    [leave setTitle:@"退出当前账号" forState:UIControlStateNormal];
    [leave setTitleColor:MBColor(250, 109, 166, 1) forState:UIControlStateNormal];
    [leave addTarget:self action:@selector(tuichu:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:leave];
    [leave mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self.view);
        make.height.mas_equalTo(53*Ratio);
        make.bottom.equalTo(self.view).offset(-160*Ratio);
    }];
    
    
    
    
}
#pragma mark - 购买

-(void)buyAction:(UIButton *)button{
    
    BuyViewController *buyVC = [[BuyViewController alloc] init];
    
    [self.navigationController pushViewController:buyVC animated:YES];
    
}
#pragma mark - 服务套餐信息

-(void)currentServeInfo:(UIButton *)button{
    
    if ([_userRole intValue] == 0) {
        //免费用户
        
    }else{
        //付费用户
        
        if (_currentMenu.count > 0) {
            MenuViewController *mvc = [[MenuViewController alloc] init];
            mvc.menuArr = _currentMenu;
            [self.navigationController pushViewController:mvc animated:YES];
        }
        
        
    }
    
    
    
}

#pragma mark - 用户信息


-(void)userDetail:(UIButton *)button{
    UserDetailViewController *uvc = [[UserDetailViewController alloc] init];
    [self.navigationController pushViewController:uvc animated:YES];
}



#pragma mark - 联系人信息phonePersonInformation

-(void)phonePersonInformation:(UIButton *)button{
    
    
    BabySittingViewController *bvc = [[BabySittingViewController alloc] init];
    [self.navigationController pushViewController:bvc animated:YES];

}

-(void)tuichu:(UIButton *)button{
    [self showAlertView:@"是否退出当前账号？"];
    
    
    
    
}
-(void)showAlertView:(NSString *)str{
    UIView *ciew = [self.view.window viewWithTag:6666];
    ciew.hidden = NO;
    for (int i=0; i<[ciew.subviews count]; i++) {
        UIView *ve = ciew.subviews[i];
        [ve removeFromSuperview];
    }
    
    //WithFrame:CGRectMake(40*Ratio, 222*Ratio, 240*Ratio, 125*Ratio)
    UIView *alert = [[UIView alloc] init];
    alert.backgroundColor = [UIColor whiteColor];
    alert.layer.masksToBounds = YES;
    alert.layer.cornerRadius = 10;
    alert.alpha = 1;
    [ciew addSubview:alert];
    [alert mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(244*Ratio, 125*Ratio));
        make.center.equalTo(ciew);
    }];
    
    //WithFrame:CGRectMake(20*Ratio, 0 , 200*Ratio, 87*Ratio)
    UILabel *titlLabel = [[UILabel alloc] init];
    [titlLabel makeLabelWithText:str andTextColor:MBColor(101, 102, 103, 1) andFont:[UIFont yaHeiFontOfSize:14*Ratio]];
    titlLabel.textAlignment = NSTextAlignmentCenter;
    titlLabel.numberOfLines = 0;
    [alert addSubview:titlLabel];
    [titlLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(200*Ratio, 87*Ratio));
        make.centerX.equalTo(alert);
        make.top.equalTo(alert);
        
        
    }];
    //WithFrame:CGRectMake(0, 88*Ratio, 240*Ratio, 1)
    UILabel *lin = [[UILabel alloc] init];
    lin.backgroundColor = MBColor(250, 109, 166, 1);
    [alert addSubview:lin];
    [lin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(244*Ratio, 1));
        make.centerX.equalTo(ciew);
        make.top.equalTo(titlLabel.mas_bottom);
    }];
    
    //continueBtn.frame = CGRectMake(20*Ratio, 89*Ratio, 200*Ratio, 38*Ratio);
    UIButton *continueBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [continueBtn setTitleColor:MBColor(250, 109, 166, 1) forState:UIControlStateNormal];
    [continueBtn setTitle:@"是" forState:UIControlStateNormal];
    [continueBtn addTarget:self action:@selector(continueAction:) forControlEvents:UIControlEventTouchUpInside];
    continueBtn.titleLabel.font = [UIFont yaHeiFontOfSize:16*Ratio];
    [alert addSubview:continueBtn];
    [continueBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(121*Ratio, 38*Ratio));
        make.left.equalTo(alert);
        make.top.equalTo(titlLabel.mas_bottom);
        
    }];
    
    UILabel *lin1 = [[UILabel alloc] init];
    lin1.backgroundColor = MBColor(250, 109, 166, 1);
    [alert addSubview:lin1];
    [lin1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(1, 38*Ratio));
        make.centerX.equalTo(ciew);
        make.top.equalTo(lin);
    }];
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [cancelBtn setTitleColor:MBColor(102, 103, 104, 1) forState:UIControlStateNormal];
    [cancelBtn setTitle:@"否" forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(cancelBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    cancelBtn.titleLabel.font = [UIFont yaHeiFontOfSize:16*Ratio];
    [alert addSubview:cancelBtn];
    [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(121*Ratio, 38*Ratio));
        make.right.equalTo(alert);
        make.top.equalTo(titlLabel.mas_bottom);
        
    }];
    
    
    [self.view.window bringSubviewToFront:ciew];
    
    
}
-(void)continueAction:(UIButton *)button{
    
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"userName"];
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"pwd"];

    
    FirPageViewController *firpage = [[FirPageViewController alloc] init];
    firpage.isAutoLogin = NO;
    firpage.isOverTime = NO;
//    [self presentViewController:firpage  animated:NO completion:nil];

    [AppDelegate sharedInstance].window.rootViewController = firpage;
}

-(void)cancelBtnAction:(UIButton *)button{
    UIView *ciew = [self.view.window viewWithTag:6666];
    ciew.hidden = YES;
    [self.view.window sendSubviewToBack:ciew];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
