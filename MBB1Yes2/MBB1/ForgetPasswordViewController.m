//
//  ForgetPasswordViewController.m
//  MBB1
//
//  Created by 陈彦 on 15/9/6.
//  Copyright (c) 2015年 elsa. All rights reserved.
//

#import "ForgetPasswordViewController.h"
#import "NetRequestManage.h"
#import "ErrorStatus.h"
#import "ReplacePwdViewController.h"
@interface ForgetPasswordViewController ()<UITextFieldDelegate>{
    int _rightTagOfTextField;//子键盘相关
    BOOL _isAccessoryView;//子键盘相关
}

@end

@implementation ForgetPasswordViewController
-(void)viewWillAppear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(infoAction:) name:UITextFieldTextDidChangeNotification object:nil];
}
-(UIInterfaceOrientationMask)supportedInterfaceOrientations{
    
    return UIInterfaceOrientationMaskLandscape;
}

-(BOOL)shouldAutorotate{
    return YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _rightTagOfTextField = 5000;
    _isAccessoryView = NO;
    self.userName.tag = 5000;
    self.mailBox.tag = 5001;
    self.userName.delegate = self;
    self.mailBox.delegate = self;
    [self setInputAccessoryViewByElsa:self.userName];
    [self setInputAccessoryViewByElsa:self.mailBox];
    
    
    UIView *leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 50, 24)];
    UIImageView *iv = [[UIImageView alloc]initWithFrame:CGRectMake(15, 0, 23, 24)];
    iv.image = [[UIImage imageNamed:@"denglu-admin"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [leftView addSubview:iv];
    self.userName.leftView = leftView;
    self.userName.leftViewMode = UITextFieldViewModeAlways;
    UIView *leftView1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 50, 24)];
    UIImageView *iv1 = [[UIImageView alloc]initWithFrame:CGRectMake(15, 0, 30, 24)];
    iv1.image = [[UIImage imageNamed:@"denglu-mail"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [leftView1 addSubview:iv1];
    self.mailBox.leftView = leftView1;
    self.mailBox.leftViewMode = UITextFieldViewModeAlways;
    
    
    [self.userName setValue:[UIColor colorWithRed:130/255.0 green:130/255.0 blue:130/255.0 alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
    [self.userName setValue:[UIFont yaHeiFontOfSize:19] forKeyPath:@"_placeholderLabel.font"];
    [self.mailBox setValue:[UIColor colorWithRed:130/255.0 green:130/255.0 blue:130/255.0 alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
    [self.mailBox setValue:[UIFont yaHeiFontOfSize:19] forKeyPath:@"_placeholderLabel.font"];
    self.userName.font = [UIFont yaHeiFontOfSize:19];
    self.mailBox.font = [UIFont yaHeiFontOfSize:19];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)setInputAccessoryViewByElsa:(UITextField *)textF{
    UIView *view0 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 1024, 44)];
    
    UITextField *text = [[UITextField alloc] initWithFrame:CGRectMake(5, 5, view0.frame.size.width-150, view0.frame.size.height-10)];
    text.delegate = self;
    text.tag = 8000;
    [text setLeftViewOfBlankforWidth:8];
    //    [text addObserver:self forKeyPath:@"text" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    text.backgroundColor = [UIColor whiteColor];
    text.borderStyle = UITextBorderStyleRoundedRect;
    text.placeholder = textF.placeholder;
    text.text = textF.text;
    [view0 addSubview:text];
    
    
    UIButton *finish = [UIButton buttonWithType:UIButtonTypeCustom];
    finish.frame = CGRectMake(view0.frame.size.width-140, 5, 60, view0.frame.size.height-10);
    [finish setTitle:@"完成" forState:UIControlStateNormal];
    [finish setTitleColor:BOY_WORDCOLOR forState:UIControlStateNormal];
    [finish addTarget:self action:@selector(finishAction:) forControlEvents:UIControlEventTouchUpInside];
    [view0 addSubview:finish];
    
    UIButton *remov = [UIButton buttonWithType:UIButtonTypeCustom];
    remov.frame = CGRectMake(view0.frame.size.width-70, 5, 60, view0.frame.size.height-10);
    [remov setTitle:@"取消" forState:UIControlStateNormal];
    [remov setTitleColor:BOY_WORDCOLOR forState:UIControlStateNormal];
    [remov addTarget:self action:@selector(removeText:) forControlEvents:UIControlEventTouchUpInside];
    [view0 addSubview:remov];
    
    view0.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1];
    [textF setInputAccessoryView:view0];
}
-(void)finishAction:(UIButton *)button{
    
    UITextField *textAccess = (UITextField *)[button.superview viewWithTag:8000];
    [textAccess resignFirstResponder];
    
    
    
    UITextField *text1 = (UITextField *)[self.view viewWithTag:_rightTagOfTextField];
    [text1 resignFirstResponder];
    
    
    
}


-(void)removeText:(UIButton *)button{
    UITextField *textAccess = (UITextField *)[button.superview viewWithTag:8000];
    
    textAccess.text = nil;
    [textAccess resignFirstResponder];
    
    
    UITextField *text2 = (UITextField *)[self.view viewWithTag:_rightTagOfTextField];
    text2.text = nil;
    
    [text2 resignFirstResponder];
}
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    if (textField.tag == 5000 || textField.tag == 5001) {
        _rightTagOfTextField = textField.tag;
    }else{
    }
    
}
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if (textField.tag == 8000) {
        _isAccessoryView = YES;
    }else{
        _isAccessoryView = NO;
    }
    return YES;
}
-(BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
-(void)infoAction:(NSNotificationCenter *)center{
    UITextField *text = (UITextField *)[self.view viewWithTag:_rightTagOfTextField];
    UITextField *textAccess = (UITextField *)[text.inputAccessoryView viewWithTag:8000];
    if (_isAccessoryView) {
        text.text = textAccess.text;
        
        
    }else{
        
        textAccess.text = text.text;
        
    }
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)sendMessage:(id)sender {
    
    if (self.userName.text.length>0&&self.mailBox.text.length>0) {
        [NetRequestManage getPwdByAccountName:self.userName.text andAccountEmail:self.mailBox.text successBlocks:^(NSData *data, NetRequestManage *load) {
            NSString *str = [[NSString alloc] initWithData:load.resultData encoding:NSUTF8StringEncoding];
            //        NSLog(@"忘记密码：%@",str);
            
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:load.resultData options:NSJSONReadingMutableContainers error:nil];
            NSString *erro = [dict objectForKey:@"errorId"];
            
            ReplacePwdViewController *replace = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"ReplacePwdViewController"];
            
            
            replace.messagerStr = [ErrorStatus errorStatus:erro parmStr:nil];
            if ([erro intValue] == 0) {
                replace.messagerStr = [NSString stringWithFormat:@"系统已发送邮件到%@，请您登陆邮箱获得新的密码",self.mailBox.text];
            }
            
            //        NSLog(@"%@",[ErrorStatus errorStatus:erro parmStr:nil]);
            //        NSLog(@"%@",replace.messagerStr);
            [self presentViewController:replace animated:NO completion:nil];
            
            
        } andfailedBlocks:^(NSError *error, NetRequestManage *load) {
            NSLog(@"error = %@",error.description);
        }];
    }else{
        
        [self alertViewWith:@"※请填写账号或绑定的邮箱"];
    }
    
    
    
}

#pragma mark - 自定义 alertview 相关
-(void)alertViewWith:(NSString *)errorSts{
    UIView *ciew = [self.view.window viewWithTag:8888];
    ciew.hidden = NO;
    for (int i=0; i<[ciew.subviews count]; i++) {
        UIView *ve = ciew.subviews[i];
        [ve removeFromSuperview];
    }
    
    
    
    UIImageView *_alert = [[UIImageView alloc] initWithFrame:CGRectMake((self.view.frame.size.width - 400)/2, (self.view.frame.size.height - 150)/2, 400, 150)];
    _alert.backgroundColor = [UIColor whiteColor];
    _alert.layer.masksToBounds = YES;
    _alert.layer.cornerRadius = 10;
    _alert.alpha = 1;
    
    
    UIImageView *header = [[UIImageView alloc] initWithFrame:CGRectMake((_alert.frame.size.width - 50)/2, (_alert.frame.size.height-49)/2-30, 50, 49)];
    header.image = [UIImage imageNamed:@"jilu-error" ofSex:ISBOY];
    [_alert addSubview:header];
    
    
    UILabel *labe = [[UILabel alloc] initWithFrame:CGRectMake(10, header.frame.size.height+header.frame.origin.y + 15, _alert.frame.size.width-20, 30)];
    
    labe.text = errorSts;
    labe.textColor = [UIColor colorWithRed:25/255.0 green:190/255.0 blue:217/255.0 alpha:1];
    labe.textAlignment = NSTextAlignmentCenter;
    labe.font = [UIFont yaHeiFontOfSize:17];
    labe.numberOfLines = 0;
    
    [_alert addSubview:labe];
    
    
    
    [ciew addSubview:_alert];
    
    
    
    //                [self.view.window updateConstraints];
    [self.view.window bringSubviewToFront:ciew];
}


-(void)viewWillDisappear:(BOOL)animated{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];
    
}



@end
