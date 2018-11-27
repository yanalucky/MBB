  //
//  ChangePwdViewController.m
//  BabyDemo
//
//  Created by 陈彦 on 16/5/31.
//  Copyright © 2016年 elsa. All rights reserved.
//

#import "ChangePwdViewController.h"

#import "NetRequestManage.h"
#import "SVProgressHUD.h"
#import "CYAlertView.h"
#import "CYRecordAlertView.h"

#import "AppDelegate.h"

@interface ChangePwdViewController ()<UITextFieldDelegate>{
    UILabel *tishiLabel;
}

@end

@implementation ChangePwdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"修改密码";
    self.view.backgroundColor = [UIColor whiteColor];
//    self.navigationController.interactivePopGestureRecognizer.delegate = nil;
    [self createInterface];
    // Do any additional setup after loading the view.
}
-(void)createInterface{
    UITextField *lastField = nil;
    NSArray *arr = @[@"旧密码",@"新密码（6~16位区分大小写）",@"新密码（再输入一次新密码）"];
    for (int i=0; i<3; i++) {
        UITextField *textfield = [[UITextField alloc] init];
        [textfield setBackground:[UIImage imageNamed:@"shezhi_input"]];
        [textfield setPlaceholder:arr[i]];
        textfield.font = [UIFont yaHeiFontOfSize:12*Ratio];
        [textfield setLeftViewOfBlankforWidth:8*Ratio];
        textfield.delegate = self;
        textfield.secureTextEntry = YES;
        textfield.tag = 1267+i;
        [self.view addSubview:textfield];
        [textfield mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(301*Ratio, 44*Ratio));
            make.centerX.equalTo(self.view);
            if (lastField) {
                make.top.equalTo(lastField.mas_bottom).offset(10*Ratio);
            }else{
                make.top.equalTo(self.view).offset(25*Ratio);
            }
            
        }];
        lastField = textfield;
        
    }
    
    
    tishiLabel = [[UILabel alloc] init];
    [tishiLabel makeLabelWithText:@"" andTextColor:MBColor(250, 109, 166, 1) andFont:[UIFont yaHeiFontOfSize:12*Ratio]];
    tishiLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:tishiLabel];
    [tishiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(301*Ratio, 30*Ratio));
        make.top.equalTo(lastField.mas_bottom);
        make.left.equalTo(lastField);
        
    }];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageNamed:@"shezhi__btn_queding"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(changePwd:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(300*Ratio, 40*Ratio));
        make.top.equalTo(lastField.mas_bottom).offset(30*Ratio);
        make.centerX.equalTo(self.view);
    }];
}
-(void)changePwd:(UIButton *)button{
    [self.view endEditing:YES];
    
    UITextField *textField0 = [self.view viewWithTag:1267];
    if ([textField0.text isEqualToString:[[NSUserDefaults standardUserDefaults] objectForKey:@"pwd"]]) {
        UITextField *textField1 = [self.view viewWithTag:1268];
        UITextField *textField2 = [self.view viewWithTag:1269];
        if ([textField1.text isEqualToString:textField2.text]) {
            tishiLabel.text = @"";
            
            [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
            [SVProgressHUD show];
            [NetRequestManage editPwdWithUserId:[[NSUserDefaults standardUserDefaults] objectForKey:@"userId"] andOldPwd:textField0.text andNewPwd:textField1.text successBlocks:^(NSData *data, NetRequestManage *editPwd) {
                
                [SVProgressHUD dismiss];
                
                NSString *str = [[NSString alloc]initWithData:editPwd.resultData encoding:NSUTF8StringEncoding];
                NSLog(@"editPwd = %@",str);
                
                
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:editPwd.resultData options:NSJSONReadingMutableContainers error:nil];
                if (([[dic objectForKey:@"errorId"] intValue] == 0)&&([[[dic objectForKey:@"result"] objectForKey:@"isEditPwd"] intValue] == 1)) {
                    NSLog(@"修改密码成功！");
                    
                    CYRecordAlertView *alert = [self.view.window viewWithTag:9999];
                    [alert alertViewWith:@"修改密码成功！" andDetailTitle:nil  andButtonTitle:@"0"];
                    [alert layoutSubviews];
                    
                    
                    [[NSUserDefaults standardUserDefaults] setObject:textField2.text forKey:@"pwd"];
                    textField0.text = @"";
                    textField1.text = @"";
                    textField2.text = @"";
                }else{
                    
                    CYRecordAlertView *alert = [self.view.window viewWithTag:9999];
                    [alert alertViewWith:@"错误！" andDetailTitle:[ErrorStatus errorStatus:[NSString stringWithFormat:@"%@",[dic objectForKey:@"errorId"]]]  andButtonTitle:@"0"];
                    [alert layoutSubviews];
                    
                    
                    if ([[dic objectForKey:@"errorId"] intValue] == -900) {
                        alert.clickBlocks = ^(void){
                            
                            FirPageViewController *firpage = [[FirPageViewController alloc] init];
                            firpage.isAutoLogin = YES;
                            firpage.isOverTime = NO;
                            [AppDelegate sharedInstance].window.rootViewController = firpage;
                        };
                    }
                    
                    
                }
                
                
            } andFailedBlocks:^(NSError *error, NetRequestManage *editPwd) {
                
                [SVProgressHUD showErrorWithStatus:error.localizedDescription];
                
            }];
            
            
            
        }else{
            
            tishiLabel.text = @"前后密码输入不一致";
            NSLog(@"前后密码输入不一致");
            
        }
        
    }else{
        CYAlertView *alert = [self.view.window viewWithTag:8888];
        alert.hidden = NO;
        [alert showStatus:@"-20"];
        [alert layoutSubviews];
        
    }
    
}

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    

}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    
    if (textField.tag == 1267) {
        if (![textField.text isEqualToString:[[NSUserDefaults standardUserDefaults] objectForKey:@"pwd"]]) {
            
            tishiLabel.text = @"旧密码输入错误";

            NSLog(@"旧密码输入错误");
//            [self.view reloadInputViews];
        }else{
            tishiLabel.text = @"";

        }

    }
}

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
