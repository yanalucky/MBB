//
//  PaySuccessViewController.m
//  BabyDemo
//
//  Created by 陈彦 on 16/7/22.
//  Copyright © 2016年 elsa. All rights reserved.
//

#import "PaySuccessViewController.h"
#import "FillInfoViewController.h"
#import "NetRequestManage.h"
#import "AddOtherViewController.h"
#import "LeftViewController.h"
#import "RickyNavViewController.h"
#import "UMMobClick/MobClick.h"


@interface PaySuccessViewController (){
    int _userRole;
    NSArray *breakMonthArr;
}

@end

@implementation PaySuccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [MobClick event:@"paySuccess"];

    
    self.navigationController.navigationBarHidden = YES;
    [self createInterface];
    // Do any additional setup after loading the view.
}
-(void)createInterface{
    
    _userRole = [[[NSUserDefaults standardUserDefaults] objectForKey:@"userRole"] intValue];
    
    self.view.backgroundColor = MBColor(225, 253, 255, 1);
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor whiteColor];
    view.layer.masksToBounds = YES;
    view.layer.cornerRadius = 10*Ratio;
    [self.view addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(300*Ratio, 281*Ratio));
    }];
    
    
    UILabel *success = [[UILabel alloc] init];
    [success makeLabelWithText:@"支付成功！" andTextColor:MBColor(162, 108, 231, 1) andFont:[UIFont yaHeiFontOfSize:18*Ratio]];
    success.textAlignment = NSTextAlignmentCenter;
    [view addSubview:success];
    [success mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(view);
        make.size.mas_equalTo(CGSizeMake(110*Ratio, 30*Ratio));
        make.top.equalTo(view).offset(56*Ratio);
    }];
    
    
    
    
    
    UIImageView *img = [[UIImageView alloc] init];
    img.image = [UIImage imageNamed:@"buy_gou_02"];
    [view addSubview:img];
    [img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(20*Ratio, 20*Ratio));
        make.right.equalTo(success.mas_left);
        make.centerY.equalTo(success);
    }];
    
    UILabel *thankLab = [[UILabel alloc] init];
    [thankLab makeLabelWithText:[NSString stringWithFormat:@"感谢您的购买，会员服务已经%@！",(_isRegist == YES)?@"开通":((_userRole == 0)?@"开通":@"续费")] andTextColor:MBColor(101, 102, 103, 1) andFont:[UIFont yaHeiFontOfSize:12*Ratio]];
    thankLab.textAlignment = NSTextAlignmentCenter;
    
    [view addSubview:thankLab];
    [thankLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(250*Ratio, 20*Ratio));
        make.top.equalTo(success.mas_bottom).offset(30*Ratio);
        make.centerX.equalTo(view);
    }];
    
    UILabel *thankLab1 = [[UILabel alloc] init];
    [thankLab1 makeLabelWithText:@"在使用中如有疑问请致电" andTextColor:MBColor(101, 102, 103, 1) andFont:[UIFont yaHeiFontOfSize:12*Ratio]];
    [view addSubview:thankLab1];
    [thankLab1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(225*Ratio, 20*Ratio));
        make.top.equalTo(thankLab.mas_bottom).offset(10*Ratio);
        make.centerX.equalTo(view);
    }];
    UIButton *phone = [UIButton buttonWithType:UIButtonTypeCustom];
    [phone setTitle:@"021-6433 5531" forState:UIControlStateNormal];
    [phone setTitleColor:MBColor(250, 109, 166, 1) forState:UIControlStateNormal];
    [phone addTarget:self action:@selector(phoneAction:) forControlEvents:UIControlEventTouchUpInside];
    phone.titleLabel.font = [UIFont yaHeiFontOfSize:12*Ratio];
    [view addSubview:phone];
    [phone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100*Ratio, 20*Ratio));
        make.centerY.equalTo(thankLab1);
        make.right.equalTo(thankLab1);
    }];
    
    
    UIButton *useBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [useBtn setTitle:@"立即使用" forState:UIControlStateNormal];
    [useBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    
    [useBtn addTarget:self action:@selector(nowUse:) forControlEvents:UIControlEventTouchUpInside];
    [useBtn setBackgroundImage:[UIImage imageNamed:@"buy_btn"] forState:UIControlStateNormal];
    
    [view addSubview:useBtn];
    [useBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100*Ratio, 28*Ratio));
        make.centerX.equalTo(view);
        make.bottom.equalTo(view).offset(-65*Ratio);
    }];
    
    
    
    
}

-(void)phoneAction:(UIButton *)button{
    
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",@"021-64335531"];
    //            NSLog(@"str======%@",str);
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
}

-(void)nowUse:(UIButton *)button{
    
    NSLog(@"请您完善信息 ");

    if (_isRegist) {
        FillInfoViewController *fvc = [[FillInfoViewController alloc] init];
        fvc.doctorId = _doctorId;
        fvc.hospitalId = _hospitalId;
        fvc.menuId = _menuId;
        fvc.isLong = _isLong;
        [self presentViewController:fvc animated:YES completion:nil];
    }else{
        if (_userRole == 0) {
            
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                
                FillInfoViewController *fvc = [[FillInfoViewController alloc] init];
                fvc.doctorId = _doctorId;
                fvc.hospitalId = _hospitalId;
                fvc.menuId = _menuId;
                fvc.isLong = YES;
                [self presentViewController:fvc animated:YES completion:nil];
                
            }];
            
            
        }else {
            
            [self payAfterAddRecord];
            
            
        }
    }
    
    
}


#pragma mark - 付费用户续费补足

-(void)payAfterAddRecord{
    
    
    
    [NetRequestManage getBreakMonthsWithUserId:[[NSUserDefaults standardUserDefaults] objectForKey:@"userId"] successBlocks:^(NSData *data, NetRequestManage *getBreakMonths) {
        
        NSString *str = [[NSString alloc] initWithData:getBreakMonths.resultData encoding:NSUTF8StringEncoding];
        NSLog(@"getBreakMonths = %@",str);
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:getBreakMonths.resultData options:NSJSONReadingMutableContainers error:nil];
        if ([[dic objectForKey:@"errorId"] intValue] == 0) {
            
            if (![[[dic objectForKey:@"result"] objectForKey:@"breakMonths"] isKindOfClass:[NSNull class]]) {
                
                
                NSString *breakMon = [[dic objectForKey:@"result"] objectForKey:@"breakMonths"];
                if (breakMon.length > 0) {
                    breakMonthArr = nil;
                    if (breakMon.length > 1) {
                        breakMonthArr = [breakMon componentsSeparatedByString:@","];
                        
                    }else{
                        breakMonthArr = @[breakMon];
                    }
                    
                    
                    [self showAlertView];
                   
                    
                    
                }else{
                    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                        LeftViewController *left = [[LeftViewController alloc] init];
                        RickyNavViewController *nav = [[RickyNavViewController alloc] initWithRootViewController:left];

                        [AppDelegate sharedInstance].window.rootViewController = nav;
                    }];
                    
                }
                
                
            }else{
                [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                    LeftViewController *left = [[LeftViewController alloc] init];
                    RickyNavViewController *nav = [[RickyNavViewController alloc] initWithRootViewController:left];

                    [AppDelegate sharedInstance].window.rootViewController = nav;
                }];
                
            }
            
        }
        
        
        
        
    } andFailedBlocks:^(NSError *error, NetRequestManage *getBreakMonths) {
        
        NSLog(@"error = %@",error.localizedDescription);
        
    }];
    
    
    
    
    
}
-(void)showAlertView{
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
        make.size.mas_equalTo(CGSizeMake(250*Ratio, 110*Ratio));
        make.center.equalTo(ciew);
    }];
    
    UIButton *cancel = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancel setBackgroundImage:[UIImage imageNamed:@"cancel"] forState:UIControlStateNormal];
    [cancel addTarget:self action:@selector(cancelAction0:) forControlEvents:UIControlEventTouchUpInside];
    
    [alert addSubview:cancel];
    [cancel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(alert).offset(10*Ratio);
        make.right.equalTo(alert).offset(-10*Ratio);
        make.size.mas_equalTo(CGSizeMake(10*Ratio, 10*Ratio));
    }];
    
    
    //WithFrame:CGRectMake(20*Ratio, 0 , 200*Ratio, 87*Ratio)
    UILabel *titlLabel = [[UILabel alloc] init];
    [titlLabel makeLabelWithText:@"为使生长曲线更加精确请补充之前的月龄的体格生长记录" andTextColor:MBColor(101, 102, 103, 1) andFont:[UIFont yaHeiFontOfSize:12*Ratio]];
    titlLabel.textAlignment = NSTextAlignmentCenter;
    titlLabel.numberOfLines = 0;
    [alert addSubview:titlLabel];
    [titlLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(180*Ratio, 37*Ratio));
        make.centerX.equalTo(alert);
        make.top.equalTo(alert).offset(16*Ratio);
        
        
    }];
    
    UILabel *redLabel = [[UILabel alloc] init];
    [redLabel makeLabelWithText:@"(只有一次补充机会)" andTextColor:MBColor(250, 109, 166, 1) andFont:[UIFont yaHeiFontOfSize:9*Ratio]];
    redLabel.textAlignment = NSTextAlignmentCenter;
    [alert addSubview:redLabel];
    [redLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(alert);
        make.top.equalTo(titlLabel.mas_bottom);
        make.height.equalTo(@(15*Ratio));
        make.centerX.equalTo(alert);
    }];
    //WithFrame:CGRectMake(0, 88*Ratio, 240*Ratio, 1)
    UILabel *lin = [[UILabel alloc] init];
    lin.backgroundColor = MBColor(250, 109, 166, 1);
    [alert addSubview:lin];
    [lin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(250*Ratio, 1));
        make.centerX.equalTo(ciew);
        make.top.equalTo(redLabel.mas_bottom).offset(10*Ratio);
    }];
    
    //continueBtn.frame = CGRectMake(20*Ratio, 89*Ratio, 200*Ratio, 38*Ratio);
    
    UIButton *continueBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [continueBtn setTitleColor:MBColor(250, 109, 166, 1) forState:UIControlStateNormal];
    [continueBtn setTitle:@"确定" forState:UIControlStateNormal];
    [continueBtn addTarget:self action:@selector(continueAction:) forControlEvents:UIControlEventTouchUpInside];
    continueBtn.titleLabel.font = [UIFont yaHeiFontOfSize:16*Ratio];
    [alert addSubview:continueBtn];
    [continueBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(121*Ratio, 38*Ratio));
        make.right.equalTo(alert);
        make.bottom.equalTo(alert);
        
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
    [cancelBtn setTitle:@"跳过" forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(cancelAction:) forControlEvents:UIControlEventTouchUpInside];
    cancelBtn.titleLabel.font = [UIFont yaHeiFontOfSize:16*Ratio];
    [alert addSubview:cancelBtn];
    [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(121*Ratio, 38*Ratio));
        make.left.equalTo(alert);
        make.bottom.equalTo(alert);
        
    }];

    
    [self.view.window bringSubviewToFront:ciew];
    
    
}

-(void)continueAction:(UIButton *)button{
    
    
    
    UIView *ciew = [self.view.window viewWithTag:6666];
    ciew.hidden = YES;
    [self.view.window sendSubviewToBack:ciew];
    
    
    
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        AddOtherViewController *avc = [[AddOtherViewController alloc] init];
        avc.breakArr = breakMonthArr;
        [self.navigationController pushViewController:avc animated:YES];
        //                        [AppDelegate sharedInstance].window.rootViewController = avc;
    }];
    
}
-(void)cancelAction:(UIButton *)button{
    
    UIView *ciew = [self.view.window viewWithTag:6666];
    ciew.hidden = YES;
    [self.view.window sendSubviewToBack:ciew];
    
    
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        LeftViewController *left = [[LeftViewController alloc] init];
        RickyNavViewController *nav = [[RickyNavViewController alloc] initWithRootViewController:left];
        
        [AppDelegate sharedInstance].window.rootViewController = nav;
    }];

    
}

-(void)cancelAction0:(UIButton *)button{
    
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
