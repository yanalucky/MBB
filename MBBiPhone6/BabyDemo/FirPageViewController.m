//
//  FirPageViewController.m
//  BabyDemo
//
//  Created by 陈彦 on 16/5/3.
//  Copyright © 2016年 elsa. All rights reserved.
//

#import "FirPageViewController.h"
#import "RegisterViewController.h"
#import "LoginViewController.h"

#import "Reachability.h"
#import "UserDefaultsManager.h"

#import "NetRequestManage.h"
#import "LoginDataModels.h"
#import "Time.h"
#import "FillInfoViewController.h"
#import "CYAlertView.h"
#import "LeftViewController.h"
#import "RickyNavViewController.h"
#import "AppDelegate.h"
#import "UIImageView+WebCache.h"
#import "CYRecordAlertView.h"


@interface FirPageViewController (){
    
    BOOL _isFirstUser;
    
    UIImageView *_loadingView;
    UILabel *_loadPrecent;
    UIView *loadView;
    UIImageView *_crawlBabyView;
    
    
    BOOL _isConnection;
    
}


@end

@implementation FirPageViewController


#pragma mark - 检测WiFi
-(void)checkVersion{
    
    NSURL *url = [NSURL URLWithString:@"http://www.mengbaobao.com/imageServer/serverVersion.txt"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSData *received = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    NSString *str = [[NSString alloc] initWithData:received encoding:NSUTF8StringEncoding];
    
    NSLog(@"str = %@",str);
    
    if (str) {
        NSArray *verAndMessage = [str componentsSeparatedByString:@"*"];

        NSArray *versionArr = [verAndMessage[0] componentsSeparatedByString:@"."];
        NSLog(@"versionArr = %@",versionArr);
        //            NSArray *oldVersionArr = @[@"1",@"1",@"1"];
        NSArray *oldVersionArr = [CURRENTVERSION componentsSeparatedByString:@"."];
        
        for (int i=0; i<3; i++) {
            NSLog(@"%d",[oldVersionArr[i] intValue]);
            if (([versionArr[i] intValue] - [oldVersionArr[i] intValue]) < 0) {
                break;
            }
            if (([versionArr[i] intValue] - [oldVersionArr[i] intValue])>0) {
                NSString *haha = verAndMessage[1];
                NSMutableString *titl = [[NSMutableString alloc] initWithString:haha];
                [titl replaceOccurrencesOfString:@"," withString:@"\n" options:NSCaseInsensitiveSearch range:NSMakeRange(0, titl.length)];
                NSLog(@"titl  =  %@",titl);
                //                    NSString *titl = @"新版本特性\n  1.修复了部分bug\n  2.优化了部分交互设计\n  3.新增了一些功能\n  4.新增了引导页";
                [self showAlertView:titl andCanCancel:(i==2)?YES:NO andVersionNum:verAndMessage[0]];
                NSLog(@"%d,%d",[versionArr[i] intValue] - [oldVersionArr[i] intValue],i);
                return;
                
            }
            
        }
        
        if (_isOverTime == YES) {
            
            [self checkNetworkState];
            
        }else{
            
            [self autoLogin];
            
        }
        
    }

    /*
    [NetRequestManage vesionUpdateSuccessBlocks:^(NSData *data, NetRequestManage *load) {

        NSString *str = [[NSString alloc] initWithData:load.resultData encoding:NSUTF8StringEncoding];
        NSLog(@"checkVersion = %@",str);
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:load.resultData options:NSJSONReadingMutableContainers error:nil];
        if ([[dic objectForKey:@"errorId"] intValue] == 0) {
            NSString *versionStr = [[dic objectForKey:@"result"] objectForKey:@"babyMobileVersion"];
            NSArray *versionArr = [versionStr componentsSeparatedByString:@"."];
            NSLog(@"versionArr = %@",versionArr);
            //            NSArray *oldVersionArr = @[@"1",@"1",@"1"];
            NSArray *oldVersionArr = [CURRENTVERSION componentsSeparatedByString:@"."];
            
            for (int i=0; i<3; i++) {
                NSLog(@"%d",[oldVersionArr[i] intValue]);
                if (([versionArr[i] intValue] - [oldVersionArr[i] intValue]) < 0) {
                    break;
                }
                if (([versionArr[i] intValue] - [oldVersionArr[i] intValue])>0) {
                    NSString *haha = [[dic objectForKey:@"result"] objectForKey:@"babyMobileUpdateInfo"];
                    NSMutableString *titl = [[NSMutableString alloc] initWithString:haha];
                    [titl replaceOccurrencesOfString:@"," withString:@"\n" options:NSCaseInsensitiveSearch range:NSMakeRange(0, titl.length)];
                    NSLog(@"titl  =  %@",titl);
//                    NSString *titl = @"新版本特性\n  1.修复了部分bug\n  2.优化了部分交互设计\n  3.新增了一些功能\n  4.新增了引导页";
                    [self showAlertView:titl andCanCancel:(i==2)?YES:NO andVersionNum:versionStr];
                    NSLog(@"%d,%d",[versionArr[i] intValue] - [oldVersionArr[i] intValue],i);
                    return;
                    
                }
                
            }

            if (_isOverTime == YES) {
                
                [self checkNetworkState];
                
            }else{
                
                [self autoLogin];
                
            }
            
        }
        
    } andfailedBlocks:^(NSError *error, NetRequestManage *load) {
        NSLog(@"error = %@",error.localizedDescription);
    }];
    
    
    
    */
}

-(void)showAlertView:(NSString *)str andCanCancel:(BOOL)isCancel andVersionNum:(NSString *)versionStr{
    UIView *ciew = [self.view.window viewWithTag:6666];
    ciew.hidden = NO;
    for (int i=0; i<[ciew.subviews count]; i++) {
        UIView *ve = ciew.subviews[i];
        [ve removeFromSuperview];
    }
    ciew.backgroundColor = [UIColor colorWithRed:12/255.0 green:12/255.0 blue:12/255.0 alpha:0.5];
    //WithFrame:CGRectMake(40*Ratio, 222*Ratio, 240*Ratio, 125*Ratio)
//    UIView *alert = [[UIView alloc] init];
    UIImageView *alert = [[UIImageView alloc] init];
    alert.image = [UIImage imageNamed:@"tanchuang"];
//    alert.backgroundColor = [UIColor clearColor];
//    alert.layer.masksToBounds = YES;
//    alert.layer.cornerRadius = 10;
//    alert.alpha = 1;
    alert.userInteractionEnabled = YES;
    [ciew addSubview:alert];
    [alert mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(294*Ratio, 297.5*Ratio));
        make.center.equalTo(ciew);
    }];
    
    //WithFrame:CGRectMake(20*Ratio, 0 , 200*Ratio, 87*Ratio)
    
    
    UILabel *howManyLab = [[UILabel alloc] init];
    int num = 0;
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"arcrandom"]) {
        int temp = [[[NSUserDefaults standardUserDefaults] objectForKey:@"arcrandom"] intValue];
        num = arc4random()%(96-temp) + temp;
        [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInt:num] forKey:@"arcrandom"];
    }else{
        num = arc4random()%(96-80) + 80;
        [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInt:num] forKey:@"arcrandom"];

    }
    
    
    NSLog(@"随机数 = %d",num);
    [howManyLab makeLabelWithText:[NSString stringWithFormat:@"%d%%的用户正在使用新版本V%@",num,versionStr] andTextColor:MBColor(101, 102, 103, 1) andFont:[UIFont yaHeiFontOfSize:14*Ratio]];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:howManyLab.text];;
    [attributedString addAttribute:NSForegroundColorAttributeName value:MBColor(250, 109, 166, 1) range:NSMakeRange(0,3)];
    [attributedString addAttribute:NSForegroundColorAttributeName value:MBColor(250, 109, 166, 1) range:NSMakeRange(13,6)];
    howManyLab.attributedText = attributedString;
    [alert addSubview:howManyLab];
    [howManyLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(alert).offset(21*Ratio);
        make.right.equalTo(alert).offset(-21*Ratio);
        make.height.equalTo(@(15*Ratio));
        make.top.equalTo(alert).offset(120*Ratio);

    }];
    UIScrollView *titleSc = [[UIScrollView alloc] init];
    titleSc.bounces = NO;
    titleSc.showsVerticalScrollIndicator = YES;
    [alert addSubview:titleSc];
    [titleSc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(alert).offset(135*Ratio);
        make.left.equalTo(alert).offset(21*Ratio);
        make.right.equalTo(alert).offset(-21*Ratio);
        make.height.equalTo(@(120*Ratio));
    }];
    
    
    UILabel *titlLabel = [[UILabel alloc] init];
    [titlLabel makeLabelWithText:str andTextColor:MBColor(101, 102, 103, 1) andFont:[UIFont yaHeiFontOfSize:14*Ratio]];
    titlLabel.numberOfLines = 0;
    [titleSc addSubview:titlLabel];
    CGSize size = [titlLabel sizeThatFits:CGSizeMake(256*Ratio, 1111*Ratio)];
    [titlLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(titleSc);
        make.edges.equalTo(titleSc);
        make.top.equalTo(titleSc);
        make.height.mas_equalTo(size.height + 30);
    }];
    
    
    
    
    
    //WithFrame:CGRectMake(0, 88*Ratio, 240*Ratio, 1)
//    UILabel *lin = [[UILabel alloc] init];
//    lin.backgroundColor = MBColor(250, 109, 166, 1);
//    [alert addSubview:lin];
//    [lin mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.size.mas_equalTo(CGSizeMake(244*Ratio, 1));
//        make.centerX.equalTo(ciew);
//        make.top.equalTo(titlLabel.mas_bottom);
//    }];
    
    //continueBtn.frame = CGRectMake(20*Ratio, 89*Ratio, 200*Ratio, 38*Ratio);
    UIButton *continueBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    continueBtn.backgroundColor = MBColor(238, 66, 153, 1);
    
    continueBtn.layer.shadowColor = MBColor(238, 66, 153, 1).CGColor;
    continueBtn.layer.shadowOffset = CGSizeMake(0, 5);
    continueBtn.layer.shadowOpacity = 0.3;
//    continueBtn.layer.masksToBounds = YES;
//    continueBtn.layer.cornerRadius = 17.5;
    [continueBtn setBackgroundImage:[UIImage imageNamed:@"tanchuang_btn"] forState:UIControlStateNormal];
    [continueBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [continueBtn setTitle:@"立即更新" forState:UIControlStateNormal];

    [continueBtn addTarget:self action:@selector(versionAction:) forControlEvents:UIControlEventTouchUpInside];
    continueBtn.titleLabel.font = [UIFont yaHeiFontOfSize:16*Ratio];
    [alert addSubview:continueBtn];
    [continueBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(233*Ratio, 35*Ratio));
            make.centerX.equalTo(alert);
            make.bottom.equalTo(alert).offset(-20*Ratio);
    }];
        
    if (isCancel == YES) {
       
//        
//        UILabel *lin1 = [[UILabel alloc] init];
//        lin1.backgroundColor = [UIColor whiteColor];
//        [alert addSubview:lin1];
//        [lin1 mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.size.mas_equalTo(CGSizeMake(1, 50*Ratio));
//            make.centerX.equalTo(ciew);
//            make.top.equalTo(alert.mas_bottom);
//        }];
        UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [cancelBtn setBackgroundImage:[UIImage imageNamed:@"tanchuang_close"] forState:UIControlStateNormal];
        [cancelBtn addTarget:self action:@selector(cancelAction:) forControlEvents:UIControlEventTouchUpInside];
        cancelBtn.titleLabel.font = [UIFont yaHeiFontOfSize:16*Ratio];
        [ciew addSubview:cancelBtn];
        [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.size.mas_equalTo(CGSizeMake(25*Ratio, 25*Ratio));
            make.centerX.equalTo(alert);
            make.top.equalTo(alert.mas_bottom).offset(23*Ratio);
            
        }];
    }
    
    
    
    [self.view.window bringSubviewToFront:ciew];
    
    
}
-(void)cancelAction:(UIButton *)button{
    
    UIView *ciew = [self.view.window viewWithTag:6666];
    ciew.hidden = YES;
    ciew.backgroundColor = [UIColor colorWithRed:120/255.0 green:120/255.0 blue:120/255.0 alpha:0.3];
    
    for (int i=0; i<[ciew.subviews count]; i++) {
        UIView *ve = ciew.subviews[i];
        [ve removeFromSuperview];
    }

    [self.view.window sendSubviewToBack:ciew];
    
    if (_isOverTime == YES) {
        
        [self checkNetworkState];
        
    }else{
        
        [self autoLogin];
        
    }
}
-(void)versionAction:(UIButton *)button{
    
    
    /*
    UIView *ciew = [self.view.window viewWithTag:6666];
    ciew.hidden = NO;
    ciew.backgroundColor = [UIColor colorWithRed:120/255.0 green:120/255.0 blue:120/255.0 alpha:0.3];
   
    for (int i=0; i<[ciew.subviews count]; i++) {
        UIView *ve = ciew.subviews[i];
        [ve removeFromSuperview];
    }
    [self.view.window sendSubviewToBack:ciew];
     */
    
    
    
//    https://itunes.apple.com/us/app/meng-bao-bao-bao-bao-sheng/id1141279090?l=zh&ls=1&mt=8

//  评论入口
//  itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=%d
    NSString *updateUrlString = [NSString stringWithFormat:@"https://itunes.apple.com/us/app/meng-bao-bao-bao-bao-sheng/id1141279090?l=zh&ls=1&mt=8"];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:updateUrlString]];
}

- (BOOL)checkNetworkState
{
    // 1.检测wifi状态
    Reachability *wifi = [Reachability reachabilityForLocalWiFi];
    
    // 2.检测手机是否能上网络
    Reachability *conn = [Reachability reachabilityForInternetConnection];
    
    
    // 3.判断网络状态
    if ([wifi currentReachabilityStatus] != NotReachable) {
        // 有wifi
        NSLog(@"有wifi");
        
        [self autoLogin];
        return YES;
        
    } else if ([conn currentReachabilityStatus] != NotReachable) {
        // 没有使用wifi, 使用手机自带网络进行上网
        NSLog(@"使用手机自带网络进行上网");
        [self showAlertView:@"1"];

//        CYRecordAlertView *alert = [self.window viewWithTag:9999];
//        [alert alertViewWith:@"提示" andDetailTitle:@"当前非WiFi状态，可能会产生流量费用，确认下载？"  andButtonTitle:@"0"];
//        [alert layoutSubviews];
        
        return YES;
        
    } else {
        // 没有网络
        NSLog(@"没有网络");
        
        [self showAlertView:@"2"];
        return NO;
//        CYRecordAlertView *alert = [self.window viewWithTag:9999];
//        [alert alertViewWith:@"提示" andDetailTitle:@"当前无网络，无法打开！"  andButtonTitle:@"0"];
//        [alert layoutSubviews];
    }
    
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
    [titlLabel makeLabelWithText:([str intValue] == 1)?@"当前不在WiFi状态下，可能会产生流量费用":@"当前无网络，无法打开！" andTextColor:MBColor(101, 102, 103, 1) andFont:[UIFont yaHeiFontOfSize:14*Ratio]];
    titlLabel.textAlignment = NSTextAlignmentCenter;
    titlLabel.numberOfLines = 0;
    [alert addSubview:titlLabel];
    [titlLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(200*Ratio, ([str intValue] == 1)?87*Ratio:125*Ratio));
        make.centerX.equalTo(alert);
        make.top.equalTo(alert);
        
    }];
    
    //WithFrame:CGRectMake(0, 88*Ratio, 240*Ratio, 1)
    
    
    //continueBtn.frame = CGRectMake(20*Ratio, 89*Ratio, 200*Ratio, 38*Ratio);
    
    if ([str intValue] == 1) {
        
        UILabel *lin = [[UILabel alloc] init];
        lin.backgroundColor = MBColor(250, 109, 166, 1);
        [alert addSubview:lin];
        [lin mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(244*Ratio, 1));
            make.centerX.equalTo(ciew);
            make.top.equalTo(titlLabel.mas_bottom);
        }];
        
        
        UIButton *continueBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [continueBtn setTitleColor:MBColor(250, 109, 166, 1) forState:UIControlStateNormal];
        [continueBtn setTitle:@"继续" forState:UIControlStateNormal];
        [continueBtn addTarget:self action:@selector(continueAction:) forControlEvents:UIControlEventTouchUpInside];
        continueBtn.titleLabel.font = [UIFont yaHeiFontOfSize:16*Ratio];
        [alert addSubview:continueBtn];
        [continueBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(200*Ratio, 38*Ratio));
            make.centerX.equalTo(ciew);
            make.top.equalTo(titlLabel.mas_bottom);
        }];
    }
    
    
    
    
    [self.view.window bringSubviewToFront:ciew];
    
    
}
-(void)continueAction:(UIButton *)button{
    
    
    
    [self autoLogin];
}


#pragma mark - 自动登录

-(void)autoLogin{
    
    
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"userName"]&&[[NSUserDefaults standardUserDefaults] objectForKey:@"pwd"]&&(_isAutoLogin == YES)) {
        NSLog(@"可以自动登录");
        UIView *ciew = [self.view.window viewWithTag:6666];
        ciew.hidden = YES;
        [self.view.window sendSubviewToBack:ciew];
        
        
        NSLog(@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"FirstUser"]);
        if ([[NSUserDefaults standardUserDefaults] objectForKey:@"FirstUser"]) {
            if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"FirstUser"] isEqualToString:@"NO"]) {
                //重登
                
                _isFirstUser = NO;
            }
        }
        
        _crawlBabyView.hidden = NO;
        [_crawlBabyView startAnimating];

        loadView.hidden = NO;
        
        [_loadingView startAnimating];
        
        
        [NetRequestManage LoginRequestAccountName:[[NSUserDefaults standardUserDefaults] objectForKey:@"userName"] andAccountPassword:[[NSUserDefaults standardUserDefaults] objectForKey:@"pwd"] successBlocks:^(NSData *data, NetRequestManage *load) {
            NSString *str = [[NSString alloc] initWithData:load.resultData encoding:NSUTF8StringEncoding];
            NSLog(@"login = %@",str);
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:load.resultData options:NSJSONReadingMutableContainers error:nil];
            
            
            if ([[dic objectForKey:@"errorId"] intValue] == 0) {
                
                LoginObject *login = [[LoginObject alloc] initWithDictionary:dic];
                
                [[NSUserDefaults standardUserDefaults] setObject:login.result.user.userid forKey:@"userId"];
                [[NSUserDefaults standardUserDefaults] setObject:login.result.sessionId forKey:@"sessionId"];
                [[NSUserDefaults standardUserDefaults] setObject:login.result.userRole forKey:@"userRole"];
                NSDictionary *user = [[dic objectForKey:@"result"] objectForKey:@"User"];
                [[NSUserDefaults standardUserDefaults] setObject:user forKey:@"user"];
                
                UIImage *headerImg = nil;
                
                if ([user objectForKey:@"headimg"]) {
                    if ([[user objectForKey:@"headimg"] length] > 0) {
                        
                        headerImg = [[UIImage alloc] initWithData:[[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:[NSString urlStringOfImage:[user objectForKey:@"headimg"]]]]];
                        
                    }else{
                        
                        if ([[user objectForKey:@"sex"] intValue] == 1) {
                            headerImg = [UIImage imageNamed:@"shouye_boy"];
                        }else{
                            headerImg = [UIImage imageNamed:@"shouye_girl"];
                        }
                    }
                }else{
                    if ([[user objectForKey:@"sex"] intValue] == 1) {
                        headerImg = [UIImage imageNamed:@"shouye_boy"];
                    }else{
                        headerImg = [UIImage imageNamed:@"shouye_girl"];
                    }
                }
                
                NSData *headerData = UIImageJPEGRepresentation(headerImg, 0.25);
                NSString *path = NSHomeDirectory();
                NSString *jpgImagePath = [path stringByAppendingPathComponent:@"Documents/header.jpg"];
//                NSLog(@"path = %@     jpgImagePath = %@",path,jpgImagePath);
                NSFileManager *manager = [NSFileManager defaultManager];
                NSString *contents = [[NSBundle mainBundle] pathForResource:jpgImagePath ofType:@"jpg"];
                if(contents){
                    [manager removeItemAtPath:path error:nil];
                }
                [headerData writeToFile:jpgImagePath atomically:YES];
                
                
                
                
                if ([login.result.userRole intValue] == 1) {//付费用户
                    
                    
                    
                    if ([login.result.birthdayError intValue] == 0) {//付费用户已完善信息
                        
                        
                        NSString *now = [[NSString stringWithFormat:@"%@",[[NSDate date] dateByAddingTimeInterval:60*60*8]] substringToIndex:10];
                        NSArray *tim = [Time timewithBirth:login.result.user.birthday andNow:now];
                        
                        NSString *nowMonth = [NSString stringWithFormat:@"%d",[tim[0] intValue]*12+[tim[1] intValue]];
//                        NSLog(@"time = %@",tim);
                        
                        [[NSUserDefaults standardUserDefaults] setObject:nowMonth forKey:@"month"];
                        [[NSUserDefaults standardUserDefaults]setObject:tim forKey:@"monthTime"];
                        _loadPrecent.text = @"50%";
                        [self sercon];
                    }else if([login.result.birthdayError intValue] == 1){//付费用户未完善信息
                        
                        FillInfoViewController *fvc = [[FillInfoViewController alloc] init];
                        fvc.menuId = login.result.menuid;
                        fvc.doctorId = login.result.user.doctorid;
                        fvc.hospitalId = login.result.user.hospitalid;
                        fvc.isLong = YES;
                        [self presentViewController:fvc animated:YES completion:nil];
                        
                    }
                    
                }else if ([login.result.userRole intValue] == 0){//免费用户
                    
                    NSString *now = [[NSString stringWithFormat:@"%@",[[NSDate date] dateByAddingTimeInterval:60*60*8]] substringToIndex:10];
                    NSArray *tim = [Time timewithBirth:login.result.user.birthday andNow:now];
                    
                    NSString *nowMonth = [NSString stringWithFormat:@"%d",[tim[0] intValue]*12+[tim[1] intValue]];
//                    NSLog(@"time = %@",tim);
                    [[NSUserDefaults standardUserDefaults] setObject:nowMonth forKey:@"month"];
                    [[NSUserDefaults standardUserDefaults]setObject:tim forKey:@"monthTime"];
                    
                    _loadPrecent.text = @"50%";

                    [self webUserServerConfig];
                    
                    
                }
                
                
                
                
                
            }else{
                [_crawlBabyView stopAnimating];
                [_loadingView stopAnimating];
                loadView.hidden = YES;
                _crawlBabyView.hidden = YES;
                CYAlertView *alert = [self.view.window viewWithTag:8888];
                alert.hidden = NO;
                [alert showStatus:[NSString stringWithFormat:@"%@",[dic objectForKey:@"errorId"]]];
                [alert layoutSubviews];
            }
            
            
            
            
        } andfailedBlocks:^(NSError *error, NetRequestManage *load) {
            
            NSLog(@"error = %@",error.localizedDescription);
        }];
        
    }else{
        UIView *ciew = [self.view.window viewWithTag:6666];
        ciew.hidden = YES;
        [self.view.window sendSubviewToBack:ciew];
    }
}
-(void)webUserServerConfig{
    [NetRequestManage webUserInitServerConfigureWithUserId:[[NSUserDefaults standardUserDefaults] objectForKey:@"userId"]  successBlocks:^(NSData *data, NetRequestManage *webUserInitServerConfigure) {
        NSString *str = [[NSString alloc] initWithData:webUserInitServerConfigure.resultData encoding:NSUTF8StringEncoding];
        NSLog(@"webUserInitServerConfigure = %@",str);
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:webUserInitServerConfigure.resultData options:NSJSONReadingMutableContainers error:nil];
        if ([[dic objectForKey:@"errorId"] intValue] == 0) {
            
            
            
            
#pragma mark = 医院
            
            NSArray *hospitalArray = [[dic objectForKey:@"result"] objectForKey:@"HospitalList"];
            [[NSUserDefaults standardUserDefaults] setObject:hospitalArray forKey:@"HospitalListArr"];

            NSMutableDictionary *hospitalDic = [[NSMutableDictionary alloc] init];
            for (int i=0; i<hospitalArray.count; i++) {
                [hospitalDic setObject:[hospitalArray objectAtIndex:i] forKey:[[hospitalArray objectAtIndex:i] objectForKey:@"hospitalid"]];
            }
            [[NSUserDefaults standardUserDefaults] setObject:hospitalDic forKey:@"hospitalDic"];
            
#pragma mark = 医生
            
            NSArray *doctorArray = [[dic objectForKey:@"result"] objectForKey:@"DoctorList"];
            [[NSUserDefaults standardUserDefaults] setObject:doctorArray forKey:@"DoctorListArr"];

            NSMutableDictionary *doctorDic = [[NSMutableDictionary alloc] init];
            for (int i=0; i<doctorArray.count; i++) {
                
                [doctorDic setObject:[doctorArray objectAtIndex:i] forKey:[[doctorArray objectAtIndex:i] objectForKey:@"doctorid"]];
                
            }
//                            NSLog(@"doctorDic = %@",doctorDic);
            
            [[NSUserDefaults standardUserDefaults] setObject:doctorDic forKey:@"doctorDic"];
            
            
#pragma mark = 沙龙 TheLatestThreeSalonList
            
            NSArray *salonArray = [[dic objectForKey:@"result"] objectForKey:@"TheLatestThreeSalonList"];
            NSMutableDictionary *salonDic = [[NSMutableDictionary alloc] init];
            for (int i=0; i<salonArray.count; i++) {
                
                [salonDic setObject:[salonArray objectAtIndex:i] forKey:[[salonArray objectAtIndex:i] objectForKey:@"salonid"]];
                //                NSLog(@"doctorDic = %@",doctorDic);
            }
            
            
            [[NSUserDefaults standardUserDefaults] setObject:salonDic forKey:@"salonDic"];
            
            
            
            [_crawlBabyView stopAnimating];
            [_loadingView stopAnimating];
            _loadPrecent.text = @"100%";

            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                
                LeftViewController *left = [[LeftViewController alloc] init];
                
               
                RickyNavViewController *nav = [[RickyNavViewController alloc] initWithRootViewController:left];
                [AppDelegate sharedInstance].window.rootViewController = nav;
                
            }];
            
        }else{
            
            [_crawlBabyView stopAnimating];
            [_loadingView stopAnimating];
            _crawlBabyView.hidden = YES;
            loadView.hidden = YES;
            CYAlertView *alert = [self.view.window viewWithTag:8888];
            alert.hidden = NO;
            [alert showStatus:[NSString stringWithFormat:@"%@",[dic objectForKey:@"errorId"]]];
            [alert layoutSubviews];
            
            
        }
        
        
        
        
        
        
        
    } andFailedBlocks:^(NSError *error, NetRequestManage *webUserInitServerConfigure) {
        NSLog(@"webUserServerConfig = %@",error.localizedDescription);
    }];
}

-(void)sercon{
    
    
    [NetRequestManage serverConfigRequestWithMonth:[[NSUserDefaults standardUserDefaults] objectForKey:@"month"] SuccessBlocks:^(NSData *data, NetRequestManage *serverConfig) {
        NSString *str = [[NSString alloc] initWithData:serverConfig.resultData encoding:NSUTF8StringEncoding];
        NSLog(@"serverConfig = %@",str);
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:serverConfig.resultData options:NSJSONReadingMutableContainers error:nil];
        if ([[dic objectForKey:@"errorId"] intValue] == 0) {
            
            [[NSUserDefaults standardUserDefaults] setObject:[[dic objectForKey:@"result"] objectForKey:@"needFillInRecord"] forKey:@"needFillInRecord"];
            [[NSUserDefaults standardUserDefaults] setObject:[[dic objectForKey:@"result"] objectForKey:@"needFillInFeature"] forKey:@"needFillInFeature"];
            
            if ([[dic objectForKey:@"result"] objectForKey:@"isNewBabyUser"]) {
                if (![[[dic objectForKey:@"result"] objectForKey:@"isNewBabyUser"] isKindOfClass:[NSNull class]]) {
                    [[NSUserDefaults standardUserDefaults] setObject:[[dic objectForKey:@"result"] objectForKey:@"isNewBabyUser"] forKey:@"isNewBabyUser"];
                    
                }
            }
            
#pragma mark = 发育行为
            
            NSArray *featureArr = [[dic objectForKey:@"result"] objectForKey:@"FeatureList"];
            NSMutableDictionary *featureDic = [[NSMutableDictionary alloc] init];
            for (int i=0; i<featureArr.count; i++) {
                [featureDic setObject:[featureArr objectAtIndex:i] forKey:[[featureArr objectAtIndex:i] objectForKey:@"id"]];
            }
            [[NSUserDefaults standardUserDefaults] setObject:featureDic forKey:@"featureDic"];
            
            NSLog(@"featureDic = ******%@",featureDic);
        

#pragma mark = 当月发育行为
            
            NSArray *featureByAgeArr = [[dic objectForKey:@"result"] objectForKey:@"FeatureListByAge"];
            
            [[NSUserDefaults standardUserDefaults] setObject:featureByAgeArr forKey:@"featureByAgeArr"];
            
            
#pragma mark = 医院
            
            NSArray *hospitalArray = [[dic objectForKey:@"result"] objectForKey:@"HospitalList"];
            [[NSUserDefaults standardUserDefaults] setObject:hospitalArray forKey:@"HospitalListArr"];

            NSMutableDictionary *hospitalDic = [[NSMutableDictionary alloc] init];
            for (int i=0; i<hospitalArray.count; i++) {
                [hospitalDic setObject:[hospitalArray objectAtIndex:i] forKey:[[hospitalArray objectAtIndex:i] objectForKey:@"hospitalid"]];
            }
            [[NSUserDefaults standardUserDefaults] setObject:hospitalDic forKey:@"hospitalDic"];
            
#pragma mark = 医生
            
            NSArray *doctorArray = [[dic objectForKey:@"result"] objectForKey:@"DoctorList"];
            [[NSUserDefaults standardUserDefaults] setObject:doctorArray forKey:@"DoctorListArr"];

            NSMutableDictionary *doctorDic = [[NSMutableDictionary alloc] init];
            for (int i=0; i<doctorArray.count; i++) {
                
                [doctorDic setObject:[doctorArray objectAtIndex:i] forKey:[[doctorArray objectAtIndex:i] objectForKey:@"doctorid"]];
                //                NSLog(@"doctorDic = %@",doctorDic);
            }
            
            
            [[NSUserDefaults standardUserDefaults] setObject:doctorDic forKey:@"doctorDic"];
            
            
#pragma mark = 沙龙 TheLatestThreeSalonList
            
            NSArray *salonArray = [[dic objectForKey:@"result"] objectForKey:@"TheLatestThreeSalonList"];
            NSMutableDictionary *salonDic = [[NSMutableDictionary alloc] init];
            for (int i=0; i<salonArray.count; i++) {
                
                [salonDic setObject:[salonArray objectAtIndex:i] forKey:[[salonArray objectAtIndex:i] objectForKey:@"salonid"]];
                //                NSLog(@"doctorDic = %@",doctorDic);
            }
            
            
            [[NSUserDefaults standardUserDefaults] setObject:salonDic forKey:@"salonDic"];
            
#pragma mark = 观察要点 GrowthList
            
            NSArray *growthArray = [[dic objectForKey:@"result"] objectForKey:@"GrowthList"];
            NSMutableDictionary *growthDic = [[NSMutableDictionary alloc] init];
            for (int i=0; i<growthArray.count; i++) {
                
                [growthDic setObject:[growthArray objectAtIndex:i] forKey:[[growthArray objectAtIndex:i] objectForKey:@"observeid"]];
                //                NSLog(@"doctorDic = %@",doctorDic);
            }
            
            
            [[NSUserDefaults standardUserDefaults] setObject:growthDic forKey:@"growthDic"];
            
            
            
#pragma mark = 当月要填写记录的记录ID
            
            //            [[NSUserDefaults standardUserDefaults] setObject:[[[dic objectForKey:@"result"] objectForKey:@"theLatestRecord"] objectForKey:@"recordid"] forKey:@"lastRecordId"];
            
#pragma mark = 首页通知 -- 哪些时间有通知
            NSArray *noticeTimeArr = [[dic objectForKey:@"result"] objectForKey:@"noticeTime"];
            
            if (![noticeTimeArr isKindOfClass:[NSNull class]]) {
                if (noticeTimeArr.count > 0) {
                    if (![[noticeTimeArr objectAtIndex:0] isKindOfClass:[NSNull class]]) {
                        [[NSUserDefaults standardUserDefaults] setObject:noticeTimeArr forKey:@"noticeTimeArr"];
                        
                    }
                }
            }
            
            
#pragma mark = 日历的消息记录 -- 哪些时间有记录
            NSArray *historyTimeArr = [[dic objectForKey:@"result"] objectForKey:@"historyTime"];
            
            [[NSUserDefaults standardUserDefaults] setObject:historyTimeArr forKey:@"historyTimeArr"];
            
            //#pragma mark = 日历的消息记录 -- 当天的消息记录
            //
            //            NSArray *historyRecordArr = [[dic objectForKey:@"result"] objectForKey:@"historyRecordList"];
            //
            //            [[NSUserDefaults standardUserDefaults] setObject:historyRecordArr forKey:@"historyRecordArr"];
            
#pragma mark = 记录的应提交时间
            
            [[NSUserDefaults standardUserDefaults] setObject:[[dic objectForKey:@"result"] objectForKey:@"ShowTime"] forKey:@"ShowTime"];
            
#pragma mark = 新用户没填写月记录
            [[NSUserDefaults standardUserDefaults] setObject:[[dic objectForKey:@"result"] objectForKey:@"firstRecord"] forKey:@"firstRecordDic"];
            
            
            
            [_crawlBabyView stopAnimating];
            [_loadingView stopAnimating];
            _loadPrecent.text = @"100%";

            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                LeftViewController *left = [[LeftViewController alloc] init];
               
                
                RickyNavViewController *nav = [[RickyNavViewController alloc] initWithRootViewController:left];
                [AppDelegate sharedInstance].window.rootViewController = nav;
                
            }];
            
            
        }else{
            
            [_crawlBabyView stopAnimating];
            [_loadingView stopAnimating];
            _crawlBabyView.hidden = YES;
            loadView.hidden = YES;
            CYAlertView *alert = [self.view.window viewWithTag:8888];
            alert.hidden = NO;
            
            [alert showStatus:[NSString stringWithFormat:@"%@",[dic objectForKey:@"errorId"]]];
            [alert layoutSubviews];
            
            
        }
        
        
        
        
    } andFailedBlocks:^(NSError *error, NetRequestManage *serverConfig) {
        NSLog(@"serverError = %@",error.localizedDescription);
        
    }]; 
    
}

#pragma mark - view Will Appear
-(void)viewWillAppear:(BOOL)animated{
    
    [UserDefaultsManager clearUserInfomation];
    
//    NSArray *array = [NSArray arrayWithObjects:@"11",@"584",@"241",@"82",@"432",@"768", nil];

    
//    NSArray *sortedArray = [array sortedArrayUsingSelector:@selector(compare:)];
//    
//    NSLog(@"排序后:%@",sortedArray);
    
//    NSArray *sortedArray = [array sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
//        
//        //这里的代码可以参照上面compare:默认的排序方法，也可以把自定义的方法写在这里，给对象排序
//        NSComparisonResult result = [obj1 compare:obj2];
//        return result;
//    }];
//    NSLog(@"排序后:%@",sortedArray);
    
    
}
-(void)viewDidAppear:(BOOL)animated{
    
    
    
    NSURL *url = [NSURL URLWithString:@"http://www.mengbaobao.com/imageServer/stopServer.txt"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];

    NSData *received = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    NSString *str = [[NSString alloc] initWithData:received encoding:NSUTF8StringEncoding];
    
    NSLog(@"str = %@",str);
    if ([str isEqualToString:@"1"]) {
        
        _isConnection = NO;
        CYRecordAlertView *alert = [self.view.window viewWithTag:9999];
        
        [alert alertViewWith:nil andDetailTitle:@"系统维护中... 请稍后再试！" andButtonTitle:@"0"];
        [alert layoutSubviews];
        
        alert.clickBlocks = ^(void){
            
        };
    
        

    }else{
        _isConnection = YES;
        [self checkVersion];
        
        
    }
    
    
//    UIImageView *ima = [[UIImageView alloc] init];
//    [ima sd_setImageWithURL:url];
//    if (ima.image && [ima.image isKindOfClass:[UIImage class]]) {
//        
//        NSLog(@"you");
//        
//    }
    
    
    
    
    
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _isFirstUser = YES;

    _isConnection = YES;
    self.view.backgroundColor = MBColor(238, 68, 152, 1);
    [self createInterface];
    
    
    
    

    // Do any additional setup after loading the view.
}



-(void)createInterface{
    UIImageView *logo = [[UIImageView alloc]init];
    logo.image = [UIImage imageNamed:@"defoult_logo"];
    [self.view addSubview:logo];
    [logo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(210*Ratio, 55*Ratio));
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).offset(122*Ratio);
    }];
    UILabel *label = [[UILabel alloc] init];
    [label makeLabelWithText:@"萌宝宝 www.mengbaobao.com" andTextColor:[UIColor whiteColor] andFont:[UIFont yaHeiFontOfSize:12*Ratio]];
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(logo.mas_bottom).offset(7*Ratio);
        make.size.mas_equalTo(CGSizeMake(200*Ratio, 18*Ratio));
    }];
    
    
    
    
    _crawlBabyView = [[UIImageView alloc] init];
    NSMutableArray *imageArr = [[NSMutableArray alloc] init];
    for (int i=0; i<15; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"pa00%.2d",i+1]];
        [imageArr addObject:image];
    }
    [_crawlBabyView setImage:[imageArr objectAtIndex:0]];
    [_crawlBabyView setAnimationImages:imageArr];
    [_crawlBabyView setAnimationDuration:0.6];
    [_crawlBabyView setAnimationRepeatCount:0];
    _crawlBabyView.hidden = YES;

    [self.view addSubview:_crawlBabyView];
    
    [_crawlBabyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(90*Ratio, 60*Ratio));
        make.centerX.equalTo(self.view);
        make.top.equalTo(label.mas_bottom).offset(30*Ratio);
    }];
    
    
    
    
    
    
    
    
    
    
    UILabel *detail = [[UILabel alloc] init];
    [detail makeLabelWithText:@"0-3岁婴幼儿生长发育管理专家" andTextColor:[UIColor whiteColor] andFont:[UIFont yaHeiFontOfSize:11*Ratio]];
    detail.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:detail];
    [detail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-30*Ratio);
        make.size.mas_equalTo(CGSizeMake(180*Ratio, 14*Ratio));
    }];
    UILabel *hadUser = [[UILabel alloc] init];
    [hadUser makeLabelWithText:@"已有账户？" andTextColor:MBColor(244, 170, 206, 1) andFont:[UIFont yaHeiFontOfSize:14]];
    [self.view addSubview:hadUser];
    [hadUser mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(detail.mas_top).offset(-53*Ratio);
        make.left.equalTo(self.view).offset(122*Ratio);
        make.size.mas_equalTo(CGSizeMake(70*Ratio, 16*Ratio));
        
    }];
    
    UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [loginBtn addTarget:self action:@selector(loginClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginBtn];
    [loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(hadUser.mas_right);
        make.centerY.equalTo(hadUser);
        make.size.mas_equalTo(CGSizeMake(37*Ratio, 17*Ratio));
    }];
    
    UIButton *regist = [UIButton buttonWithType:UIButtonTypeCustom];
    [regist setBackgroundImage:[UIImage imageNamed:@"defoult_register_btn"] forState:UIControlStateNormal];
    [regist addTarget:self action:@selector(registClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:regist];
    [regist mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(176*Ratio, 46*Ratio));
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(loginBtn.mas_top).offset(-29*Ratio);
    }];
    
    
    
    loadView = [[UIView alloc] init];
    loadView.backgroundColor = MBColor(238, 68, 152, 1);
    [self.view addSubview:loadView];
    loadView.hidden = YES;
    [loadView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.view);
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-50*Ratio);
        make.height.equalTo(@(200*Ratio));
    }];
    
    
    _loadPrecent = [[UILabel alloc] init];
    [_loadPrecent makeLabelWithText:@"0%" andTextColor:[UIColor whiteColor] andFont:[UIFont yaHeiFontOfSize:12*Ratio]];
    _loadPrecent.textAlignment = NSTextAlignmentCenter;
    [loadView addSubview:_loadPrecent];
    [_loadPrecent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(loadView);
        make.size.mas_equalTo(CGSizeMake(40*Ratio, 40*Ratio));
    }];
    
    _loadingView = [[UIImageView alloc] init];
    NSMutableArray *imageArr1 = [[NSMutableArray alloc] init];
    for (int i=0; i<12; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%d",i+1]];
        [imageArr1 addObject:image];
    }
    [_loadingView setImage:[imageArr1 objectAtIndex:0]];
    [_loadingView setAnimationImages:imageArr1];
    [_loadingView setAnimationDuration:0.6];
    [_loadingView setAnimationRepeatCount:0];
    [loadView addSubview:_loadingView];
    [_loadingView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(loadView);
        make.size.mas_equalTo(CGSizeMake(53*Ratio, 53*Ratio));
    }];
    
    
    
}

#pragma mark - 注册
-(void)registClick:(UIButton *)button{
    
    if (_isConnection == YES) {
        RegisterViewController *rv = [[RegisterViewController alloc] init];
        [self presentViewController:rv animated:NO completion:nil];
    }else{
        CYRecordAlertView *alert = [self.view.window viewWithTag:9999];
        
        [alert alertViewWith:nil andDetailTitle:@"系统维护中... 请稍后再试！" andButtonTitle:@"0"];
        [alert layoutSubviews];
        
        alert.clickBlocks = ^(void){
            
        };

    }
    
}
#pragma mark - 登录

-(void)loginClick:(UIButton *)button{
    if (_isConnection == YES) {
        LoginViewController *login = [[LoginViewController alloc] init];
        [self presentViewController:login animated:NO completion:nil];
    }else{
        CYRecordAlertView *alert = [self.view.window viewWithTag:9999];
        
        [alert alertViewWith:nil andDetailTitle:@"系统维护中... 请稍后再试！" andButtonTitle:@"0"];
        [alert layoutSubviews];
        
        alert.clickBlocks = ^(void){
            
        };

    }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    
    return  UIStatusBarStyleLightContent;
}
//-(BOOL)shouldAutorotate{
//    return NO;
//}
//-(UIInterfaceOrientationMask)supportedInterfaceOrientations{
//    
//    return UIInterfaceOrientationMaskPortrait;
//}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
