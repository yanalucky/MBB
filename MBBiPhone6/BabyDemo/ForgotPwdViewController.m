//
//  ForgotPwdViewController.m
//  BabyDemo
//
//  Created by 陈彦 on 16/7/25.
//  Copyright © 2016年 elsa. All rights reserved.
//

#import "ForgotPwdViewController.h"
#import "NetRequestManage.h"
#import "CYAlertView.h"
#import "SVProgressHUD.h"
#import "CYRecordAlertView.h"


@interface ForgotPwdViewController ()<UITextFieldDelegate>{
    
    UIButton *textBtn;
    //定时器
    NSTimer *_timer;
    
    
    BOOL _isSixty;   //判断当前定时器是否处于开启状态
    
    
    NSString *code;
    
    
    
    
    NSString    *_previousTextFieldContent;
    UITextRange *_previousSelection;
}


@end

@implementation ForgotPwdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self createInterface];
    
    [self createTimer];
    
    // Do any additional setup after loading the view.
}

#pragma mark - 返回
-(void)returnAction:(UIButton *)buton{
    [self dismissViewControllerAnimated:YES completion:nil];
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
    
    
    UILabel *title = [[UILabel alloc] init];
    title.textAlignment = NSTextAlignmentCenter;
    [title makeLabelWithText:@"设置新密码" andTextColor:MBColor(252, 109, 166, 1) andFont:[UIFont yaHeiFontOfSize:23*Ratio]];
    [self.view addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(130*Ratio, 25*Ratio));
        make.top.equalTo(self.view).offset(55*Ratio);
    }];
    
    NSArray *leftImageArr = @[@"user",@"yanzheng",@"password"];
    NSArray *placeHolderArr = @[@"手机号",@"验证码",@"密码（6-16位数字、字母）"];
    UITextField *lastField = nil;
    for (int i=0; i<3; i++) {
        UITextField *textfield = [[UITextField alloc] init];
        textfield.tag = 1273+i;
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
        if (i == 0) {
            textfield.keyboardType = UIKeyboardTypeNamePhonePad;
            [textfield addTarget:self action:@selector(reformatAsPhoneNumber:) forControlEvents:UIControlEventEditingChanged];

        }else{
            textfield.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
        }
        
        
        [textfield setValue:[UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
        [textfield setValue:[UIFont yaHeiFontOfSize:13*Ratio] forKeyPath:@"_placeholderLabel.font"];
        textfield.placeholder = placeHolderArr[i];
        textfield.font = [UIFont yaHeiFontOfSize:13*Ratio];
        if (i==0) {
            textfield.clearButtonMode = UITextFieldViewModeAlways;
        }
        if (i==2) {
            textfield.secureTextEntry = YES;
        }
       
        textfield.delegate = self;
        [self.view addSubview:textfield];
        [textfield mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.and.right.equalTo(self.view);
            make.height.mas_equalTo(50*Ratio);
            if (i==0) {
                make.top.equalTo(title.mas_bottom).offset(30*Ratio);
            }else if (i==1){
                make.top.equalTo(lastField.mas_bottom).offset(Ratio);
            }else{
                make.top.equalTo(lastField.mas_bottom).offset(15*Ratio);
            }
        }];
        
        lastField = textfield;
        
        
        
    }
    
#pragma mark = 验证码Btn
    
    textBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    textBtn.layer.masksToBounds = YES;
    textBtn.layer.cornerRadius = 12*Ratio;
    [textBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [textBtn addTarget:self action:@selector(yanZhengMa:) forControlEvents:UIControlEventTouchUpInside];
    textBtn.titleLabel.font = [UIFont yaHeiFontOfSize:13*Ratio];
    [textBtn setBackgroundColor:MBColor(252, 109, 166, 1)];
    [self.view addSubview:textBtn];
    [textBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(75*Ratio, 24*Ratio));
        make.right.equalTo(self.view).offset(-15*Ratio);
        make.top.equalTo(self.view).offset(174*Ratio);
    }];
    
    
    
#pragma mark = 完成
    
    UIButton *finish = [UIButton buttonWithType:UIButtonTypeCustom];
    [finish addTarget:self action:@selector(finishAction:) forControlEvents:UIControlEventTouchUpInside];
    finish.layer.masksToBounds = YES;
    finish.layer.cornerRadius = 10;
    [finish setTitle:@"确定" forState:UIControlStateNormal];
    [finish setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [finish setBackgroundColor:MBColor(252, 109, 166, 1)];
    [self.view addSubview:finish];
    [finish mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(10*Ratio);
        make.right.equalTo(self.view).offset(-10*Ratio);
        make.top.equalTo(lastField.mas_bottom).offset(35*Ratio);
        make.height.mas_equalTo(40*Ratio);
    }];
    
}
#pragma mark - 完成
-(void)finishAction:(UIButton *)button{
    
    [self.view endEditing:YES];
   
    if (code.length  == 0) {
        CYAlertView *alert = [self.view.window viewWithTag:8888];
        alert.hidden = NO;
        [alert showStatus:@"-51"];
        [alert layoutSubviews];
        return;
    }
    UITextField *field0 = (UITextField *)[self.view viewWithTag:1273];
    UITextField *field1 = (UITextField *)[self.view viewWithTag:1274];
    UITextField *field2 = (UITextField *)[self.view viewWithTag:1275];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    [SVProgressHUD show];
    NSMutableString *fextFieldMutableStr = [NSMutableString stringWithString:field0.text];
    if ([fextFieldMutableStr containsString:@" "]) {
        [fextFieldMutableStr replaceOccurrencesOfString:@" " withString:@"" options:NSRegularExpressionSearch range:NSMakeRange(0, fextFieldMutableStr.length)];
        
    }
    [NetRequestManage saveNewPwdWithAccountName:fextFieldMutableStr andLoginPwd:field2.text andCode:code andCheckCode:field1.text successBlocks:^(NSData *data, NetRequestManage *saveNewPwd) {
        NSString *str = [[NSString alloc] initWithData:saveNewPwd.resultData encoding:NSUTF8StringEncoding];
        NSLog(@"saveNewPwd = %@",str);
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:saveNewPwd.resultData options:NSJSONReadingMutableContainers error:nil];
        
        [SVProgressHUD dismiss];
        if ([[dic objectForKey:@"errorId"] intValue] == 0) {
            
            
            CYRecordAlertView *alert = [self.view.window viewWithTag:9999];
            [alert alertViewWith:nil andDetailTitle:@"密码修改成功！"  andButtonTitle:@"0"];
            [alert layoutSubviews];
            alert.clickBlocks = ^{
                
                [self dismissViewControllerAnimated:YES completion:nil];

            };
            
            
            
        }else{
            
            CYAlertView *alert = [self.view.window viewWithTag:8888];
            alert.hidden = NO;
            [alert showStatus:[NSString stringWithFormat:@"%@",[dic objectForKey:@"errorId"]]];
            [alert layoutSubviews];
            
        }
        
       
        
        
    } andfailedBlocks:^(NSError *error, NetRequestManage *saveNewPwd) {
         NSLog(@"error = %@",error.localizedDescription);
    }];
    
}


#pragma mark -  定时器
-(void)createTimer{
    
    //第一个参数：时间间隔，单位是秒
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
    
    _isSixty = NO;
    [_timer setFireDate:[NSDate distantFuture]];
    
}
-(void)timerAction{
    NSString *subStr = [textBtn.titleLabel.text substringToIndex:textBtn.titleLabel.text.length-1];
    int numb = [subStr intValue]-1;
    if (numb < 0) {
        
        [textBtn setTitle:@"重发" forState:UIControlStateNormal];
        [_timer setFireDate:[NSDate distantFuture]];
        _isSixty = NO;
        
    }else{
        
        _isSixty = YES;
        [textBtn setTitle:[NSString stringWithFormat:@"%d秒",numb] forState:UIControlStateNormal];
    }
    
}



#pragma mark - 验证码
-(void)yanZhengMa:(UIButton *)button{
    
    //设置button的选中状态
    if (_isSixty == NO) {
        //如果当前定时器是关闭状态 --> 改为开启状态
        [self.view endEditing:YES];
        
        UITextField *field = (UITextField *)[self.view viewWithTag:1273];
        
        NSMutableString *fextFieldMutableStr = [NSMutableString stringWithString:field.text];
        if ([fextFieldMutableStr containsString:@" "]) {
            [fextFieldMutableStr replaceOccurrencesOfString:@" " withString:@"" options:NSRegularExpressionSearch range:NSMakeRange(0, fextFieldMutableStr.length)];
            
        }
        if (fextFieldMutableStr.length == 11) {
            [button setTitle:@"60秒" forState:UIControlStateNormal];
            [_timer setFireDate:[NSDate distantPast]];
            
            [NetRequestManage sendResetPasswordMessageWithPhone:fextFieldMutableStr successBlocks:^(NSData *data, NetRequestManage *sendMsg) {
                NSString *str = [[NSString alloc] initWithData:sendMsg.resultData encoding:NSUTF8StringEncoding];
                NSLog(@"sendMesg = %@",str);
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:sendMsg.resultData options:NSJSONReadingMutableContainers error:nil];
                if ([[dic objectForKey:@"errorId"] intValue] == 0) {
                    code = [[dic objectForKey:@"result"] objectForKey:@"code"];
                    
                }else{
                    [textBtn setTitle:@"重发" forState:UIControlStateNormal];
                    [_timer setFireDate:[NSDate distantFuture]];
                    CYAlertView *alert = [self.view.window viewWithTag:8888];
                    alert.hidden = NO;
                    [alert showStatus:[NSString stringWithFormat:@"%@",[dic objectForKey:@"errorId"]]];
                    [alert layoutSubviews];
                }
                
                
            } andfailedBlocks:^(NSError *error, NetRequestManage *sendMsg) {
                NSLog(@"error = %@",error.localizedDescription);
            }];
            
        }
    }
}



#pragma mark - textfield代理相关

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField.tag == 1273||textField.tag == 1274) {
        UITextField *textF = (UITextField *)[self.view viewWithTag:textField.tag + 1];
        [textField resignFirstResponder];
        [textF becomeFirstResponder];
    }
    return YES;
}


-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    
    if (textField.tag == 1273) {
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
