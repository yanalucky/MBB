//
//  LoginViewController.m
//  BabyDemo
//
//  Created by 陈彦 on 16/5/3.
//  Copyright © 2016年 elsa. All rights reserved.
//

#import "LoginViewController.h"
#import "LeftViewController.h"
#import "RickyNavViewController.h"
#import "NetRequestManage.h"
#import "LoginDataModels.h"
#import "ServerConfigDataModels.h"
#import "Time.h"
#import "SVProgressHUD.h"

#import "FillInfoViewController.h"
#import "CYAlertView.h"
#import "ForgotPwdViewController.h"
#import "AppDelegate.h"
#import "UserDefaultsManager.h"

@interface LoginViewController (){
    
    BOOL _isFirstUser;
    
    
    NSString    *_previousTextFieldContent;
    UITextRange *_previousSelection;

    
}

@end

@implementation LoginViewController




- (void)viewDidLoad {
    [super viewDidLoad];
    _isFirstUser = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    [self createInterface];
    // Do any additional setup after loading the view.
}
-(void)createInterface{
    
    
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setImage:[UIImage imageNamed:@"back1"] forState:UIControlStateNormal];
    [leftBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -30, 0, 0)];
    [leftBtn addTarget:self action:@selector(returnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:leftBtn];
    [leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(Ratio);
        make.top.equalTo(self.view).offset(20*Ratio);
        make.size.mas_equalTo(CGSizeMake(50*Ratio, 35*Ratio));
    }];
    
    UIImageView *logo = [[UIImageView alloc] init];
    logo.image = [UIImage imageNamed:@"login_logo"];
    [self.view addSubview:logo];
    [logo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(152*Ratio, 40*Ratio));
        make.top.equalTo(self.view).offset(60*Ratio);
    }];
    
    NSArray *leftImageArr = @[@"user",@"password"];
    NSArray *placeHolderArr = @[@"手机号",@"密码（6-16位数字、字母）"];
    UITextField *lastField = nil;
    for (int i=0; i<2; i++) {
        UITextField *textfield = [[UITextField alloc] init];
        textfield.tag = 1202+i;
        UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40*Ratio, 50*Ratio)];
        UIImageView *leftImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20*Ratio, 20*Ratio)];
        leftImg.image = [UIImage imageNamed:leftImageArr[i]];
        [leftView addSubview:leftImg];
        [leftImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(leftView);
            make.size.mas_equalTo(CGSizeMake(20*Ratio, 20*Ratio));
        }];
        textfield.leftViewMode = UITextFieldViewModeAlways;
        textfield.leftView = leftView;
        textfield.backgroundColor = MBColor(245, 245, 245, 1);
        [textfield setValue:[UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
        [textfield setValue:[UIFont yaHeiFontOfSize:13*Ratio] forKeyPath:@"_placeholderLabel.font"];
        textfield.placeholder = placeHolderArr[i];
        textfield.font = [UIFont yaHeiFontOfSize:13*Ratio];
        if (i==0) {
            textfield.clearButtonMode = UITextFieldViewModeAlways;
            [textfield addTarget:self action:@selector(reformatAsPhoneNumber:) forControlEvents:UIControlEventEditingChanged];

        }
        if (i==1) {
            textfield.secureTextEntry = YES;
        }
        
        textfield.delegate = self;
        [self.view addSubview:textfield];
        [textfield mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.and.right.equalTo(self.view);
            make.height.mas_equalTo(50*Ratio);
            if (i==0) {
                make.top.equalTo(logo.mas_bottom).offset(30*Ratio);
                
                
                if ([[NSUserDefaults standardUserDefaults] objectForKey:@"userName"]) {
                    NSString *strUserName = [[NSUserDefaults standardUserDefaults] objectForKey:@"userName"];
                    NSMutableString *strUserNameMultable = [[NSMutableString alloc] initWithString:strUserName];
                    [strUserNameMultable insertString:@" " atIndex:3];
                    [strUserNameMultable insertString:@" " atIndex:8];
//                    NSLog(@"strUserNameMultable = %@",strUserNameMultable);
                    textfield.text = strUserNameMultable;
                }
                
            }else{  
                make.top.equalTo(lastField.mas_bottom).offset(Ratio);
                textfield.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
                textfield.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"pwd"];;
            }
        }];
        
        lastField = textfield;
    }
    
#pragma mark = 完成
    
    UIButton *login = [UIButton buttonWithType:UIButtonTypeCustom];
    [login addTarget:self action:@selector(loginAction:) forControlEvents:UIControlEventTouchUpInside];
    login.layer.masksToBounds = YES;
    login.layer.cornerRadius = 10;
    [login setTitle:@"登录" forState:UIControlStateNormal];
    [login setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [login setBackgroundColor:MBColor(252, 109, 166, 1)];
    login.titleLabel.font = [UIFont yaHeiFontOfSize:15*Ratio];
    [self.view addSubview:login];
    [login mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(10*Ratio);
        make.right.equalTo(self.view).offset(-10*Ratio);
        make.top.equalTo(lastField.mas_bottom).offset(37*Ratio);
        make.height.mas_equalTo(40*Ratio);
    }];
#pragma mark = 忘记密码
    UIButton *forgetPwd = [UIButton buttonWithType:UIButtonTypeCustom];
    [forgetPwd setTitleColor:MBColor(204, 204, 204, 1) forState:UIControlStateNormal];
    [forgetPwd setTitle:@"忘记密码？" forState:UIControlStateNormal];
    forgetPwd.titleLabel.font = [UIFont yaHeiFontOfSize:13*Ratio];
    [forgetPwd addTarget:self action:@selector(forgotPwd:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:forgetPwd];
    [forgetPwd mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(75*Ratio, 16*Ratio));
        make.right.equalTo(self.view);
        make.top.equalTo(login.mas_bottom).offset(10*Ratio);
    }];

}
#pragma mark - 返回
-(void)returnAction:(UIButton *)buton{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - 忘记密码
-(void)forgotPwd:(UIButton *)button{
    
    ForgotPwdViewController *fvc = [[ForgotPwdViewController alloc] init];
    [self presentViewController:fvc animated:YES completion:nil];
    
    
}
#pragma mark - 登录

-(void)loginAction:(UIButton *)button{
    
    

    NSLog(@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"FirstUser"]);
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"FirstUser"]) {
        if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"FirstUser"] isEqualToString:@"NO"]) {
            //重登 
            
            _isFirstUser = NO;
        }
    }
    [self.view endEditing:YES];
    UITextField *textField0 = [self.view viewWithTag:1202];
    UITextField *textField1 = [self.view viewWithTag:1203];
    NSString *name = textField0.text;
    NSString *pwd = textField1.text;
    
    
    [UserDefaultsManager clearUserInfomation];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    [SVProgressHUD show];
    
    NSMutableString *fextFieldMutableStr = [NSMutableString stringWithString:name];
    if ([fextFieldMutableStr containsString:@" "]) {
        [fextFieldMutableStr replaceOccurrencesOfString:@" " withString:@"" options:NSRegularExpressionSearch range:NSMakeRange(0, fextFieldMutableStr.length)];
        
    }
    [NetRequestManage LoginRequestAccountName:fextFieldMutableStr andAccountPassword:pwd successBlocks:^(NSData *data, NetRequestManage *load) {
        NSString *str = [[NSString alloc] initWithData:load.resultData encoding:NSUTF8StringEncoding];
        NSLog(@"login = %@",str);
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:load.resultData options:NSJSONReadingMutableContainers error:nil];
        
        
        if ([[dic objectForKey:@"errorId"] intValue] == 0) {

            LoginObject *login = [[LoginObject alloc] initWithDictionary:dic];
            [[NSUserDefaults standardUserDefaults] setObject:fextFieldMutableStr forKey:@"userName"];
            [[NSUserDefaults standardUserDefaults] setObject:pwd forKey:@"pwd"];
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
//            NSLog(@"path = %@     jpgImagePath = %@",path,jpgImagePath);
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
                    NSLog(@"time = %@",tim);
                    
                    [[NSUserDefaults standardUserDefaults] setObject:nowMonth forKey:@"month"];
                    [[NSUserDefaults standardUserDefaults]setObject:tim forKey:@"monthTime"];
                    [self sercon];
                }else if([login.result.birthdayError intValue] == 1){//付费用户未完善信息
                    [SVProgressHUD dismiss];

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
                NSLog(@"time = %@",tim);
                [[NSUserDefaults standardUserDefaults] setObject:nowMonth forKey:@"month"];
                [[NSUserDefaults standardUserDefaults]setObject:tim forKey:@"monthTime"];
                
                [self webUserServerConfig];
                
                
            }

            

           
            
        }else{
            [SVProgressHUD dismiss];
            CYAlertView *alert = [self.view.window viewWithTag:8888];
            alert.hidden = NO;
            [alert showStatus:[NSString stringWithFormat:@"%@",[dic objectForKey:@"errorId"]]];
            [alert layoutSubviews];
        }
        
        
        
        
    } andfailedBlocks:^(NSError *error, NetRequestManage *load) {
        
        NSLog(@"error = %@",error.localizedDescription);
        [SVProgressHUD showErrorWithStatus:error.localizedDescription];
    }];
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
            
//            NSLog(@"doctorDic = %@",doctorDic);

            [[NSUserDefaults standardUserDefaults] setObject:doctorDic forKey:@"doctorDic"];
            
            
#pragma mark = 沙龙 TheLatestThreeSalonList
            
            NSArray *salonArray = [[dic objectForKey:@"result"] objectForKey:@"TheLatestThreeSalonList"];
            NSMutableDictionary *salonDic = [[NSMutableDictionary alloc] init];
            for (int i=0; i<salonArray.count; i++) {
                
                [salonDic setObject:[salonArray objectAtIndex:i] forKey:[[salonArray objectAtIndex:i] objectForKey:@"salonid"]];
                //                NSLog(@"doctorDic = %@",doctorDic);
            }
            
            
            [[NSUserDefaults standardUserDefaults] setObject:salonDic forKey:@"salonDic"];
            
            
            
            [SVProgressHUD dismiss];

            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                
                LeftViewController *left = [[LeftViewController alloc]init];
                
                RickyNavViewController *nav = [[RickyNavViewController alloc] initWithRootViewController:left];
                [AppDelegate sharedInstance].window.rootViewController = nav;

            }];

        }else{
            
            
            [SVProgressHUD dismiss];
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
            
            
            [SVProgressHUD dismiss];
            

            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                LeftViewController *left = [[LeftViewController alloc] init];
                
                RickyNavViewController *nav = [[RickyNavViewController alloc] initWithRootViewController:left];
//                [self presentViewController:nav animated:YES completion:nil];
                [AppDelegate sharedInstance].window.rootViewController = nav;

            }];
            

        }else{
            
            
            [SVProgressHUD dismiss];
            CYAlertView *alert = [self.view.window viewWithTag:8888];
            alert.hidden = NO;
            
            [alert showStatus:[NSString stringWithFormat:@"%@",[dic objectForKey:@"errorId"]]];
            [alert layoutSubviews];
            
            
        }
        
       
        
        
    } andFailedBlocks:^(NSError *error, NetRequestManage *serverConfig) {
        NSLog(@"serverError = %@",error.localizedDescription);
        [SVProgressHUD showErrorWithStatus:error.localizedDescription];

    }]; 

}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    if (textField.tag == 1202) {
        UITextField *textF = (UITextField *)[self.view viewWithTag:1203];
        [textField resignFirstResponder];
        [textF becomeFirstResponder];
    }
    return YES;
}

#pragma mark - UITextFieldDelegate
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    
    if (textField.tag == 1202) {
        _previousSelection = textField.selectedTextRange;
        _previousTextFieldContent = textField.text;
        
        if(range.location==0) {
            if(string.integerValue >1)
            {
                return NO;
            }
        }
        
        return YES;
    }else{
        return YES;
    }
}

#pragma mark - 登录手机号分隔符

-(void)reformatAsPhoneNumber:(UITextField *)textField {
    /**
     *  判断正确的光标位置
     */
    NSUInteger targetCursorPostion = [textField offsetFromPosition:textField.beginningOfDocument toPosition:textField.selectedTextRange.start];
    NSString *phoneNumberWithoutSpaces = [self removeNonDigits:textField.text andPreserveCursorPosition:&targetCursorPostion];
    
    
    if([phoneNumberWithoutSpaces length]>11) {
        /**
         *  避免超过11位的输入
         */
        
        [textField setText:_previousTextFieldContent];
        textField.selectedTextRange = _previousSelection;
        
        return;
    }
    
    
    NSString *phoneNumberWithSpaces = [self insertSpacesEveryFourDigitsIntoString:phoneNumberWithoutSpaces andPreserveCursorPosition:&targetCursorPostion];
    
    textField.text = phoneNumberWithSpaces;
    UITextPosition *targetPostion = [textField positionFromPosition:textField.beginningOfDocument offset:targetCursorPostion];
    [textField setSelectedTextRange:[textField textRangeFromPosition:targetPostion toPosition:targetPostion]];
    
}

/**
 *  除去非数字字符，确定光标正确位置
 *
 *  @param string         当前的string
 *  @param cursorPosition 光标位置
 *
 *  @return 处理过后的string
 */
- (NSString *)removeNonDigits:(NSString *)string andPreserveCursorPosition:(NSUInteger *)cursorPosition {
    NSUInteger originalCursorPosition =*cursorPosition;
    NSMutableString *digitsOnlyString = [NSMutableString new];
    
    for (NSUInteger i=0; i<string.length; i++) {
        unichar characterToAdd = [string characterAtIndex:i];
        
        if(isdigit(characterToAdd)) {
            NSString *stringToAdd = [NSString stringWithCharacters:&characterToAdd length:1];
            [digitsOnlyString appendString:stringToAdd];
        }
        else {
            if(i<originalCursorPosition) {
                (*cursorPosition)--;
            }
        }
    }
    return digitsOnlyString;
}

/**
 *  将空格插入我们现在的string 中，并确定我们光标的正确位置，防止在空格中
 *
 *  @param string         当前的string
 *  @param cursorPosition 光标位置
 *
 *  @return 处理后有空格的string
 */
- (NSString *)insertSpacesEveryFourDigitsIntoString:(NSString *)string andPreserveCursorPosition:(NSUInteger *)cursorPosition{
    NSMutableString *stringWithAddedSpaces = [NSMutableString new];
    NSUInteger cursorPositionInSpacelessString = *cursorPosition;
    
    for (NSUInteger i=0; i<string.length; i++) {
        if(i>0)
        {
            if(i==3 || i==7) {
                [stringWithAddedSpaces appendString:@" "];
                
                if(i<cursorPositionInSpacelessString) {
                    (*cursorPosition)++;
                }
            }
        }
        
        unichar characterToAdd = [string characterAtIndex:i];
        NSString *stringToAdd = [NSString stringWithCharacters:&characterToAdd length:1];
        [stringWithAddedSpaces appendString:stringToAdd];
    }
    return stringWithAddedSpaces;
}


#pragma mark - 收键盘
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
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
