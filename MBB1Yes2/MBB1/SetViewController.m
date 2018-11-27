//
//  SetViewController.m
//  MBB
//
//  Created by 陈彦 on 15/9/1.
//  Copyright (c) 2015年 elsa. All rights reserved.
//

#import "SetViewController.h"
#import "NetRequestManage.h"
#import "TAlertView.h"
#import "LoginViewController.h"
#import "ErrorStatus.h"
#import "CYOverRunView.h"


@interface SetViewController (){
    UILabel *_label0;
    UILabel *_label1;
    BOOL _isAccessory;
    int _tagOfTextfield;
}

@end

@implementation SetViewController


#pragma mark - 自定义 alertview 相关
-(void)overRun{
    CYOverRunView *ciew = [self.view.window viewWithTag:999];
    ciew.hidden = NO;
    ciew.clickBlocks = ^(void){
        
        [self.tabBarController dismissViewControllerAnimated:NO completion:nil];
    };
    [self.view.window bringSubviewToFront:ciew];
}
-(void)alertViewWith:(NSString *)errorSts withImageName:(NSString *)imageName{
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
    
    
    UIImageView *header00 = [[UIImageView alloc] initWithFrame:CGRectMake((_alert.frame.size.width - 50)/2, (_alert.frame.size.height-49)/2-30, 50, 49)];
    header00.image = [UIImage imageNamed:imageName ofSex:self.sex];

    
    [_alert addSubview:header00];
    
    
    UILabel *labe = [[UILabel alloc] initWithFrame:CGRectMake(10, header00.frame.size.height+header00.frame.origin.y + 15, _alert.frame.size.width-20, 50)];
    
    labe.text = errorSts;
    labe.textColor = self.wordColor;
    labe.textAlignment = NSTextAlignmentCenter;
    labe.font = [UIFont yaHeiFontOfSize:16];
    labe.numberOfLines = 2;
    
    [_alert addSubview:labe];
    
    
    
    [ciew addSubview:_alert];
    
    
    
    //                [self.view.window updateConstraints];
    [self.view.window bringSubviewToFront:ciew];
}


-(void)viewDidAppear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(accessoryViewShow:) name:UITextFieldTextDidChangeNotification object:nil];
}
-(void)viewDidDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];
    
}

-(void)accessoryViewShow:(NSNotificationCenter *)info{
    UITextField *textF = [_right0 viewWithTag:_tagOfTextfield];
    UITextField *textAccess = [textF.inputAccessoryView viewWithTag:8000];
    if (_isAccessory) {
        textF.text = textAccess.text;
    }else{
        textAccess.text = textF.text;
    }
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
    
    
    
    UITextField *text1 = (UITextField *)[self.view viewWithTag:_tagOfTextfield];
    [text1 resignFirstResponder];
    
    
    
}


-(void)removeText:(UIButton *)button{
    UITextField *textAccess = (UITextField *)[button.superview viewWithTag:8000];
    
    textAccess.text = nil;
    [textAccess resignFirstResponder];
    
    
    UITextField *text2 = (UITextField *)[self.view viewWithTag:_tagOfTextfield];
    text2.text = nil;
    
    [text2 resignFirstResponder];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    _tagOfTextfield = 360;
    _isAccessory = NO;
    
    [self createInterface];
    // Do any additional setup after loading the view.
}
-(void)createInterface{
    NSArray *arr = @[@"修改密码",@"关于我们"];
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(216, 231, 234, 57);
    [button setBackgroundImage:[UIImage imageNamed:@"xinxi-kuang" ofSex:self.sex] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"xinxi-kuang2" ofSex:self.sex] forState:UIControlStateSelected];
    [button setBackgroundImage:[UIImage imageNamed:@"xinxi-kuang2" ofSex:self.sex] forState:UIControlStateHighlighted];
    button.tag = 350;
    [button setTitle:arr[0] forState:UIControlStateNormal];
    [button setTitleColor:self.wordColor forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont yaHeiFontOfSize:18];
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame = CGRectMake(216, 339, 234, 57);
    [button1 setBackgroundImage:[UIImage imageNamed:@"xinxi-kuang" ofSex:self.sex] forState:UIControlStateNormal];
    [button1 setBackgroundImage:[UIImage imageNamed:@"xinxi-kuang2" ofSex:self.sex] forState:UIControlStateSelected];
    button1.tag = 351;
    [button1 setBackgroundImage:[UIImage imageNamed:@"xinxi-kuang2" ofSex:self.sex] forState:UIControlStateHighlighted];
    [button1 setTitle:arr[1] forState:UIControlStateNormal];
    [button1 setTitleColor:self.wordColor forState:UIControlStateNormal];
    button1.titleLabel.font = [UIFont yaHeiFontOfSize:18];
    [button1 addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button1];
    
    
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    button2.frame = CGRectMake(216, 581, 234, 57);
    [button2 setBackgroundImage:[UIImage imageNamed:@"shezhi-tuichu"] forState:UIControlStateNormal];
    [button2 setBackgroundImage:[UIImage imageNamed:@"shezhi-tuichu"] forState:UIControlStateSelected];
    [button2 setBackgroundImage:[UIImage imageNamed:@"shezhi-tuichu"] forState:UIControlStateHighlighted];
    button2.tag = 352;
    [button2 setTitleColor:self.wordColor forState:UIControlStateNormal];
    button2.titleLabel.font = [UIFont yaHeiFontOfSize:17];
    [button2 addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button2];
    [self createRightViews];
}

-(void)buttonClick:(UIButton *)button{
    
    if (button.tag == 350) {
       
        for (id view in _right0.subviews) {
            if ([view isKindOfClass:[UITextField class]]) {
                UITextField *tex = (UITextField *)view;
                tex.text = nil;
                _label1.hidden = YES;
                _label0.hidden = YES;
            }
        }
        [_right0 updateConstraints];
        [self.view bringSubviewToFront:_right0];
    }
    else if (button.tag == 351){
        [self.view bringSubviewToFront:_right1];
    }else if (button.tag == 352){
        LoginViewController *login = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"LoginViewController"];
        [self.tabBarController dismissViewControllerAnimated:NO completion:nil];
    }
    for (int i=0; i<3; i++) {
        UIButton *but = (UIButton *)[self.view viewWithTag:350+i];
        but.selected = NO;
    }
    button.selected = YES;
}

-(void)createRightViews{
    _right0 = [[UIView alloc] initWithFrame:FRAMEOFRIGHTVIEW];
    _right0.userInteractionEnabled = YES;
    _right0.backgroundColor = self.bgColor;
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake((_right0.frame.size.width - 190)/2, 90, 190, 51)];
    title.text = @"修改密码";
    title.font = [UIFont yaHeiFontOfSize:27];
    title.textColor = self.wordColor;
    title.textAlignment = NSTextAlignmentCenter;
    [_right0 addSubview:title];
    _oldPasswordTF = [[UITextField alloc] initWithFrame:CGRectMake((_right0.frame.size.width - 234)/2, 167, 234, 57)];
    [_oldPasswordTF setBackground:[UIImage imageNamed:@"jilu-shuru" ofSex:self.sex]];
    _oldPasswordTF.placeholder = @"请输入旧密码";
    _oldPasswordTF.secureTextEntry = YES;
    [_oldPasswordTF setLeftViewOfBlankforWidth:8];

    _oldPasswordTF.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
//    [_oldPasswordTF setValue:WORDDARKCOLOR forKeyPath:@"_placeholderLabel.textColor"];
//    [_oldPasswordTF setValue:[UIFont yaHeiFontOfSize:15] forKeyPath:@"_placeholderLabel.font"];
    _oldPasswordTF.delegate = self;
    _oldPasswordTF.tag = 360;
    [self setInputAccessoryViewByElsa:_oldPasswordTF];
    [_right0 addSubview:_oldPasswordTF];
    _label0 = [[UILabel alloc] initWithFrame:CGRectMake((_right0.frame.size.width - 200)/2, 238, 200, 27)];
    _label0.font = [UIFont yaHeiFontOfSize:14];
    _label0.textColor = self.wordColor;
    [_right0 addSubview:_label0];
    _label0.hidden = YES;
    
    
    _xinPasswordTF = [[UITextField alloc] initWithFrame:CGRectMake((_right0.frame.size.width - 234)/2, 279, 234, 57)];
    [_xinPasswordTF setBackground:[UIImage imageNamed:@"jilu-shuru" ofSex:self.sex]];
    _xinPasswordTF.placeholder = @"请输入新密码";
    _xinPasswordTF.delegate = self;
    _xinPasswordTF.tag = 361;
    _xinPasswordTF.secureTextEntry = YES;
    [_xinPasswordTF setLeftViewOfBlankforWidth:8];

    _xinPasswordTF.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    [self setInputAccessoryViewByElsa:_xinPasswordTF];
    [_right0 addSubview:_xinPasswordTF];
    _repeatPasswordTF = [[UITextField alloc] initWithFrame:CGRectMake((_right0.frame.size.width - 234)/2, 360, 234, 57)];
    [_repeatPasswordTF setBackground:[UIImage imageNamed:@"jilu-shuru" ofSex:self.sex]];
    _repeatPasswordTF.placeholder = @"请再次输入新密码";
    _repeatPasswordTF.delegate = self;
    _repeatPasswordTF.tag = 362;
    _repeatPasswordTF.secureTextEntry = YES;
    [_repeatPasswordTF setLeftViewOfBlankforWidth:8];
    _repeatPasswordTF.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    [self setInputAccessoryViewByElsa:_repeatPasswordTF];
    [_right0 addSubview:_repeatPasswordTF];
    _label1 = [[UILabel alloc] initWithFrame:CGRectMake((_right0.frame.size.width - 200)/2, 433, 300, 27)];
    _label1.font = [UIFont yaHeiFontOfSize:14];
    _label1.textColor = self.wordColor;
    
    [_right0 addSubview:_label1];
    _label1.hidden = YES;
    
    _determineBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _determineBtn.frame = CGRectMake((_right0.frame.size.width - 234)/2, 517, 234, 57);
    [_determineBtn setBackgroundImage:[UIImage imageNamed:@"xinxi-querenxiugai" ofSex:self.sex] forState:UIControlStateNormal];
    [_determineBtn setBackgroundImage:[UIImage imageNamed:@"xinxi-querenxiugai2" ofSex:self.sex] forState:UIControlStateHighlighted];
    [_determineBtn setBackgroundImage:[UIImage imageNamed:@"xinxi-querenxiugai2" ofSex:self.sex] forState:UIControlStateSelected];
    [_determineBtn addTarget:self action:@selector(alterAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [_right0 addSubview:_determineBtn];

    [self.view addSubview:_right0];
    
    
    
    
    _right1 = [[UIView alloc] initWithFrame:FRAMEOFRIGHTVIEW];
    _right1.backgroundColor = self.bgColor;
    [self.view addSubview:_right1];
    [self createRight1];
    
    [self.view bringSubviewToFront:_right0];
}
-(void)alterAction:(UIButton *)button{
    NSString *use = [[NSUserDefaults standardUserDefaults] objectForKey:@"userId"];
    NSString *oldPwd = [[NSUserDefaults standardUserDefaults] objectForKey:@"password"];
    NSString *newPwd;
    __block NSString *show;
    UITextField *text0 = (UITextField *)[_right0 viewWithTag:360];
    UITextField *text1 = (UITextField *)[_right0 viewWithTag:361];
    UITextField *text2 = (UITextField *)[_right0 viewWithTag:362];
    if ([text0.text isEqualToString:oldPwd]) {
        if ([text1.text isEqualToString:text2.text]) {
            if (text1.text.length > 0) {
                newPwd = text2.text;
                [NetRequestManage setPasswordWithUserId:use oldPwd:oldPwd newPwd:newPwd successBlocks:^(NSData *data, NetRequestManage *loadUser) {
                    
                    
                    
                    
                    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:loadUser.resultData options:NSJSONReadingMutableContainers error:nil];
                    if ([[dic objectForKey:@"errorId"] intValue] == -900) {
                        [self overRun];
                    }
                    
                    [self alertViewWith:@"修改成功！" withImageName:@"caidan-morentouxiang-small"];
//                    show = @"修改成功"; NSLog(@"show = %@",show);
//                    TAlertView *alee = [[TAlertView alloc] initWithTitle:show andMessage:nil];
//                    alee.imageName = @"0-jilu-error";
//                    [alee show];
                } andFailedBlocks:^(NSError *error, NetRequestManage *loadUser) {
                    NSLog(@"error = %@",error.description);
                }];
            }else{
//                if ([errorSts intValue] == 0) {
//                    header00.image = [UIImage imageNamed:@"caidan-morentouxiang-small" ofSex:self.sex];
//                }else{
//                    header00.image = [UIImage imageNamed:@"jilu-error" ofSex:self.sex];
//                }
                [self alertViewWith:@"※请输入新密码" withImageName:@"jilu-error"];
                
            }
            
        }else{
            
            [self alertViewWith:@"前后密码输入不一致，请重新输入" withImageName:@"jilu-error"];
//            show = @"前后密码输入不一致，请重新输入";
//            TAlertView *alee = [[TAlertView alloc] initWithTitle:show andMessage:nil];
//            alee.imageName = @"0-jilu-error";
//            [alee show];
        }
    }else{
        
        
        [self alertViewWith:@"密码错误" withImageName:@"jilu-error"];
//        show = @"密码错误";
//        TAlertView *alee = [[TAlertView alloc] initWithTitle:show andMessage:nil];
//        alee.imageName = @"0-jilu-error";
//        [alee show];
    }
    
}


-(void)createRight1{
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(_right1.frame.size.width/2-75, 50, 150, 50)];
    title.text = @"关于我们";
    title.textColor = self.wordColor;
    title.textAlignment = NSTextAlignmentCenter;
    title.font = [UIFont yaHeiFontOfSize:26];
    [_right1 addSubview:title];
    
    UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(30, 120, FRAMEOFRIGHTVIEW.size.width-60, 1.5)];
    line.backgroundColor = self.wordColor;
    [_right1 addSubview:line];
    
    NSArray *arr = @[@"上海豆蒙萌健康管理咨询有限公司",@"地址：上海市漕溪北路737弄1号楼1503室",@"电话（Tel）：400-876-6060",@"邮箱：customerservice@mengbaobao.com",@"网址：www.mengbaobao.com"];
    for (int i=0; i<arr.count; i++) {
        UILabel *name = [[UILabel alloc] initWithFrame:CGRectMake(50, 130+ 40*i, 400, 30)];
        name.text = arr[i];
        name.textColor = WORDDARKCOLOR;
        name.font = [UIFont yaHeiFontOfSize:18];
        [_right1 addSubview:name];
    }
    
    
    
    
    
    UIImageView *logo = [[UIImageView alloc] initWithFrame:CGRectMake(_right1.frame.size.width/2-75, _right1.frame.size.height - 200, 150, 38)];
    logo.image = [UIImage imageNamed:@"logoVersion"];
    [_right1 addSubview:logo];
    
    
    UILabel *versionLabel = [[UILabel alloc] initWithFrame:CGRectMake(logo.frame.origin.x, logo.frame.origin.y+logo.frame.size.height+10, logo.frame.size.width, 20)];
    versionLabel.text = @"v1.0.1";
    versionLabel.textColor = WORDDARKCOLOR;
    versionLabel.textAlignment = NSTextAlignmentCenter;
    versionLabel.font = [UIFont yaHeiFontOfSize:18];
    [_right1 addSubview:versionLabel];
    
}
#pragma mark - textfield相关

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    if (textField.tag == 8000) {
        _isAccessory = YES;
    }else{
        _tagOfTextfield = textField.tag;
    }
    
}
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if (textField.tag == 8000) {
        _isAccessory = YES;
    }else{
        _isAccessory = NO;
    }
    return YES;
}
-(BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    if (textField.tag != 8000) {
        if (textField.tag == 360) {
            if (![textField.text isEqualToString:[[NSUserDefaults standardUserDefaults] objectForKey:@"password"]]) {
                _label0.text = @"密码不正确，请重新输入";
                _label0.hidden = NO;
            }else{
                _label0.hidden = YES;
            }
        }else if (textField.tag == 362){
            UITextField *text0 = (UITextField *)[_right0 viewWithTag:361];
            UITextField *text1 = (UITextField *)[_right0 viewWithTag:362];
            if (![text0.text isEqualToString:text1.text]) {
                _label1.text = @"前后密码输入不一致，请重新输入";
                _label1.hidden = NO;

            }else{
                _label1.hidden = YES;
            }
        }
    }
    
    [textField resignFirstResponder];
    return YES;
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
