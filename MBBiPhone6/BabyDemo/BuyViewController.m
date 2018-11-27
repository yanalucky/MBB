//
//  BuyViewController.m
//  BabyDemo
//
//  Created by 陈彦 on 16/7/11.
//  Copyright © 2016年 elsa. All rights reserved.
//

#import "BuyViewController.h"
#import "BuyDoctorViewController.h"
#import "CYRecordAlertView.h"
#import "NetRequestManage.h"
#import "NewRecordViewController.h"
#import "AppDelegate.h"

@interface BuyViewController (){
    
    NSString *_currentMenuStr;

    int babyLastMonth;
    NSString *_userRole;
    
}

@end

@implementation BuyViewController
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
    [continueBtn setTitle:@"返回" forState:UIControlStateNormal];
    [continueBtn addTarget:self action:@selector(cancelAction:) forControlEvents:UIControlEventTouchUpInside];
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
    [cancelBtn setTitle:@"继续" forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(continueAction:) forControlEvents:UIControlEventTouchUpInside];
    cancelBtn.titleLabel.font = [UIFont yaHeiFontOfSize:16*Ratio];
    [alert addSubview:cancelBtn];
    [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(121*Ratio, 38*Ratio));
        make.right.equalTo(alert);
        make.top.equalTo(titlLabel.mas_bottom);
        
    }];
    
    
    [self.view.window bringSubviewToFront:ciew];
    
    
}

-(void)cancelAction:(UIButton *)button{
    UIView *ciew = [self.view.window viewWithTag:6666];
    ciew.hidden = YES;
    [self.view.window sendSubviewToBack:ciew];
    [self.navigationController popViewControllerAnimated:YES];
    
}
-(void)continueAction:(UIButton *)button{
    UIView *ciew = [self.view.window viewWithTag:6666];
    ciew.hidden = YES;
    [self.view.window sendSubviewToBack:ciew];
    
    NewRecordViewController *newRecord = [[NewRecordViewController alloc] init];
    
    newRecord.month = [[[NSUserDefaults standardUserDefaults] objectForKey:@"month"] intValue];
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"firstRecordDic"]) {
        if (![[[NSUserDefaults standardUserDefaults] objectForKey:@"firstRecordDic"] isKindOfClass:[NSNull class]]) {
            
            RecordStarRecordStar *rStar = [[RecordStarRecordStar alloc] initWithDictionary:[[NSUserDefaults standardUserDefaults] objectForKey:@"firstRecordDic"]];

            newRecord.recordStar = rStar;
            newRecord.theLastRecordStr = rStar.recordid;

            
        }
    }
    newRecord.isHiddenSubmit = NO;
    newRecord.canChangeData = YES;
    newRecord.showTime = nil;
    newRecord.recordStatus = @"0";
    newRecord.timeStatus = 0;
    [self.navigationController pushViewController:newRecord animated:YES];
}

-(void)viewWillAppear:(BOOL)animated{
     self.navigationController.navigationBarHidden = NO;
}

-(void)viewDidAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = NO;
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"needFillInRecord"]) {
        if (![[[NSUserDefaults standardUserDefaults] objectForKey:@"needFillInRecord"] isKindOfClass:[NSNull class]]) {
            if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"needFillInRecord"] intValue] == 1) {
                [self showAlertView:@"您需要添加记录，才能继续购买服务哦~"];
            }
        }
    }
    
}
- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.title = @"购买";
    _userRole = [[NSUserDefaults standardUserDefaults] objectForKey:@"userRole"];
    self.view.backgroundColor = MBColor(225, 253, 255, 1);
    [self createInterface];
    
    // Do any additional setup after loading the view.
}
-(void)createInterface{
    
    UILabel *label = [[UILabel alloc] init];
    [label makeLabelWithText:@"线上服务" andTextColor:MBColor(51, 52, 53, 1) andFont:[UIFont yaHeiFontOfSize:15*Ratio]];
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.view);
        make.top.equalTo(self.view);
        make.centerX.equalTo(self.view);
        make.height.mas_equalTo(36.5*Ratio);
        
    }];
    
    UIScrollView *sc = [[UIScrollView alloc] init];
    sc.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:sc];
    [sc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label.mas_bottom).offset(5*Ratio);
        make.bottom.equalTo(self.view).offset(-110*Ratio);
        make.centerX.equalTo(self.view);
        make.width.equalTo(self.view);
    }];
    
    
    
    
    
    
    
    UIImageView *image = [[UIImageView alloc] init];
    image.image = [UIImage imageNamed:@"buy_xianshang"];
    [sc addSubview:image];
    [image mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(sc);
        make.edges.equalTo(sc);
        make.height.mas_equalTo(400.5*Ratio);
    }];
    
    UIView *timeView = [[UIView alloc] init];
    timeView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:timeView];
    [timeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.view);
        make.centerX.equalTo(self.view);
        make.height.mas_equalTo(100*Ratio);
        make.bottom.equalTo(self.view);
    }];
    babyLastMonth = 0;
    if ([_userRole intValue] == 0) {
        babyLastMonth = [[[NSUserDefaults standardUserDefaults] objectForKey:@"month"] intValue];
        
        NSMutableArray *canEnbleArr = [[NSMutableArray alloc] init];
//        NSLog(@"babyLastMonth = %d",babyLastMonth);
        if ((36 - babyLastMonth) < 6) {
            [canEnbleArr addObject:@"0"];
            [canEnbleArr addObject:@"0"];
            [canEnbleArr addObject:((36 - babyLastMonth) > 0)?@"1":@"0"];
        }else if ((36 - babyLastMonth) < 12){
            [canEnbleArr addObject:@"1"];
            [canEnbleArr addObject:@"0"];
            [canEnbleArr addObject:@"0"];
        }else{
            [canEnbleArr addObject:@"1"];
            [canEnbleArr addObject:@"1"];
            [canEnbleArr addObject:@"0"];
        }
        NSArray *buyTimeArr = @[@"半年服务",@"一年服务",@"不足半年"];
        for (int i=0; i<3; i++) {
            UIButton *buyTime = [UIButton buttonWithType:UIButtonTypeCustom];
            buyTime.tag = 1270+i;
            [buyTime setBackgroundImage:[UIImage imageNamed:@"buy_time_01"] forState:UIControlStateNormal];
            [buyTime setBackgroundImage:[UIImage imageNamed:@"buy_time_02"] forState:UIControlStateSelected];
            [buyTime setBackgroundImage:[UIImage imageNamed:@"buy_time_03"] forState:UIControlStateDisabled];
            buyTime.titleLabel.textAlignment = NSTextAlignmentCenter;
            [buyTime setTitle:buyTimeArr[i] forState:UIControlStateNormal];
            [buyTime setTitleColor:MBColor(51, 51, 51, 1) forState:UIControlStateNormal];
            [buyTime addTarget:self action:@selector(buyTimeAction:) forControlEvents:UIControlEventTouchUpInside];
            buyTime.enabled = [canEnbleArr[i] boolValue];
            [timeView addSubview:buyTime];
            [buyTime mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(timeView).offset(10*Ratio);
                make.size.mas_equalTo(CGSizeMake(95*Ratio, 32*Ratio));
                make.left.equalTo(self.view).offset((10+104*i)*Ratio);
            }];
            UIImageView *dui = [[UIImageView alloc] init];
            dui.image = [UIImage imageNamed:@"buy_time_set"];
            [buyTime addSubview:dui];
            [dui mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(buyTime).offset(3*Ratio);
                make.bottom.equalTo(buyTime).offset(3*Ratio);
                make.size.mas_equalTo(CGSizeMake(13*Ratio, 13*Ratio));
            }];
            dui.hidden = YES;
        }
        
        
        UIButton *nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [nextButton setBackgroundImage:[UIImage imageNamed:@"buy_btn_xiayibu"] forState:UIControlStateNormal];
        [nextButton addTarget:self action:@selector(nextAction:) forControlEvents:UIControlEventTouchUpInside];
        [timeView addSubview:nextButton];
        [nextButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(100*Ratio, 28*Ratio));
            make.centerX.equalTo(timeView);
            make.bottom.equalTo(timeView).offset(-17*Ratio);
        }];
        
        

    }else{
        [NetRequestManage getTheLastMenuWithUserId:[[NSUserDefaults standardUserDefaults] objectForKey:@"userId"] successBlocks:^(NSData *data, NetRequestManage *getTheLastMenu) {
            
            NSString *str = [[NSString alloc] initWithData:getTheLastMenu.resultData encoding:NSUTF8StringEncoding];
            NSLog(@"getTheLastMenu = %@",str);
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:getTheLastMenu.resultData options:NSJSONReadingMutableContainers error:nil];
            babyLastMonth = [[[[dic objectForKey:@"result"] objectForKey:@"theLastMenu"] objectForKey:@"endage"] intValue];
            
            NSLog(@"babyLastMonth = %d",babyLastMonth);
            
            
            if ([[dic objectForKey:@"errorId"] intValue] == 0) {
                NSMutableArray *canEnbleArr = [[NSMutableArray alloc] init];
                NSLog(@"babyLastMonth = %d",babyLastMonth);
                if ((36 - babyLastMonth) < 6) {
                    [canEnbleArr addObject:@"0"];
                    [canEnbleArr addObject:@"0"];
                    [canEnbleArr addObject:((36 - babyLastMonth) > 0)?@"1":@"0"];
                }else if ((36 - babyLastMonth) < 12){
                    [canEnbleArr addObject:@"1"];
                    [canEnbleArr addObject:@"0"];
                    [canEnbleArr addObject:@"0"];
                }else{
                    [canEnbleArr addObject:@"1"];
                    [canEnbleArr addObject:@"1"];
                    [canEnbleArr addObject:@"0"];
                }
                NSArray *buyTimeArr = @[@"半年服务",@"一年服务",@"不足半年"];
                for (int i=0; i<3; i++) {
                    UIButton *buyTime = [UIButton buttonWithType:UIButtonTypeCustom];
                    buyTime.tag = 1270+i;
                    [buyTime setBackgroundImage:[UIImage imageNamed:@"buy_time_01"] forState:UIControlStateNormal];
                    [buyTime setBackgroundImage:[UIImage imageNamed:@"buy_time_02"] forState:UIControlStateSelected];
                    [buyTime setBackgroundImage:[UIImage imageNamed:@"buy_time_03"] forState:UIControlStateDisabled];
                    buyTime.titleLabel.textAlignment = NSTextAlignmentCenter;
                    [buyTime setTitle:buyTimeArr[i] forState:UIControlStateNormal];
                    [buyTime setTitleColor:MBColor(101, 102, 103, 1) forState:UIControlStateNormal];
                    [buyTime addTarget:self action:@selector(buyTimeAction:) forControlEvents:UIControlEventTouchUpInside];
                    buyTime.titleLabel.font = [UIFont yaHeiFontOfSize:13*Ratio];
                    buyTime.enabled = [canEnbleArr[i] boolValue];
                    [timeView addSubview:buyTime];
                    [buyTime mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.top.equalTo(timeView).offset(10*Ratio);
                        make.size.mas_equalTo(CGSizeMake(95*Ratio, 32*Ratio));
                        make.left.equalTo(self.view).offset((10+104*i)*Ratio);
                    }];
                    UIImageView *dui = [[UIImageView alloc] init];
                    dui.image = [UIImage imageNamed:@"buy_time_set"];
                    [buyTime addSubview:dui];
                    [dui mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.right.equalTo(buyTime).offset(3*Ratio);
                        make.bottom.equalTo(buyTime).offset(3*Ratio);
                        make.size.mas_equalTo(CGSizeMake(13*Ratio, 13*Ratio));
                    }];
                    dui.hidden = YES;
                }
                
                
                UIButton *nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
                [nextButton setBackgroundImage:[UIImage imageNamed:@"buy_btn_xiayibu"] forState:UIControlStateNormal];
                [nextButton addTarget:self action:@selector(nextAction:) forControlEvents:UIControlEventTouchUpInside];
                [timeView addSubview:nextButton];
                [nextButton mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.size.mas_equalTo(CGSizeMake(100*Ratio, 28*Ratio));
                    make.centerX.equalTo(timeView);
                    make.bottom.equalTo(timeView).offset(-17*Ratio);
                }];
                
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

            
            
            
            
        } andFailedBlocks:^(NSError *error, NetRequestManage *getTheLastMenu) {
            
            NSLog(@"getTheLastMenuError = %@",error.localizedDescription);
            
        }];
    }
    
    
    
    
    
    
    
  
    
}

#pragma mark - 购买时长
-(void)buyTimeAction:(UIButton *)button{
    if (button.selected == NO) {
        for (int i=0; i<3; i++) {
            UIButton *butt = (UIButton *)[self.view viewWithTag:1270+i];
            butt.selected = NO;
            UIImageView *duigou = (UIImageView *)[butt.subviews objectAtIndex:2];
            duigou.hidden = YES;
        }
    }
    button.selected = !button.selected;
    UIImageView *duigou = (UIImageView *)[button.subviews objectAtIndex:2];
    duigou.hidden = !button.selected;
    
    
    
    
    if (button.selected == YES) {
        if (button.tag == 1270) {
            _currentMenuStr = @"2";
        }else if (button.tag == 1271){
            _currentMenuStr = @"3";
        }else if (button.tag == 1272){
            
            _currentMenuStr = [NSString stringWithFormat:@"%d",86-(36 - babyLastMonth)];
        }
        
    }else{
        _currentMenuStr = nil;
    }
    
}


#pragma mark - 下一步

-(void)nextAction:(UIButton *)button{
    
    if (_currentMenuStr) {
        BuyDoctorViewController *buyDoctor = [[BuyDoctorViewController alloc] init];
        buyDoctor.menuStr = _currentMenuStr;
        [self.navigationController pushViewController:buyDoctor animated:YES];
    }else{
        CYRecordAlertView *alert = [self.view.window viewWithTag:9999];
        [alert alertViewWith:@"* 提示 *" andDetailTitle:@"您还没有选择为您服务的时间哦~"  andButtonTitle:@"0"];
        [alert layoutSubviews];
    }
    
    
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
