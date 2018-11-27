//
//  BabySittingViewController.m
//  BabyDemo
//
//  Created by 陈彦 on 16/7/7.
//  Copyright © 2016年 elsa. All rights reserved.
//

#import "BabySittingViewController.h"
#import "NetRequestManage.h"
#import "LoginUser.h"
#import "CYRecordAlertView.h"



@interface BabySittingViewController ()<UITextFieldDelegate>{
    
    LoginUser *user;

    
    UIButton *_rightBtn;
    UIView *whiteView;
    UIView *_hiddenView;
}

@end

@implementation BabySittingViewController


-(void)commit:(UIButton *)button{
    [self.view endEditing:YES];
    
    button.selected = !button.selected;
    _hiddenView.hidden = button.selected;
    
    if (_hiddenView.hidden) {
//        [babyTime setBackground:[UIImage imageNamed:@"chouti_geren"]];
//        babyTime.textAlignment = NSTextAlignmentLeft;
        for (int i=0; i<6; i++) {
            UITextField *textField = (UITextField *)[whiteView viewWithTag:1260+i];
            if (i>2) {
                [textField setBackground:[UIImage imageNamed:@"kuang"]];

            }else{
                [textField setBackground:[UIImage imageNamed:@"chouti_geren"]];

            }
            textField.textAlignment = NSTextAlignmentLeft;
        }
        
    }else{
//        [babyTime setBackground:nil];
//        babyTime.textAlignment = NSTextAlignmentRight;
        for (int i=0; i<6; i++) {
            UITextField *textField = (UITextField *)[whiteView viewWithTag:1260+i];
            [textField setBackground:nil];
            textField.textAlignment = NSTextAlignmentRight;
        }
        
    }

    if (!button.selected) {
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
       
        NSArray *arr = @[@"linkmanName",@"linkman",@"linkmansex",@"linkmanMobile",@"linkmanEmail",@"emergencyPhone"];
        NSArray *keyArr = @[@"linkmanname",@"linkman",@"linkmansex",@"linkmanmobile",@"linkmanemail",@"emergencyphone"];
        for (int i=0; i<6; i++) {
            UITextField *textfield = [whiteView viewWithTag:1260+i];
            [dic setObject:textfield.text forKey:arr[i]];
            
        }
        
        
        
        [NetRequestManage editLinkmanWithUserId:[[NSUserDefaults standardUserDefaults] objectForKey:@"userId"] andLinkmanInfoDic:dic successBlocks:^(NSData *data, NetRequestManage *editLinkman) {
            
            
            NSString *str = [[NSString alloc] initWithData:editLinkman.resultData encoding:NSUTF8StringEncoding];
            
            NSLog(@"editLinkman = %@",str);
            
            NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:editLinkman.resultData options:NSJSONReadingMutableContainers error:nil];

            if (([[dictionary objectForKey:@"errorId"] intValue] == 0)&&([[[dictionary objectForKey:@"result"] objectForKey:@"isEditLinkman"] intValue] == 1)) {
                NSLog(@"修改联系人信息成功！");
                
                CYRecordAlertView *alert = [self.view.window viewWithTag:9999];
                [alert alertViewWith:@"修改联系人信息成功！" andDetailTitle:nil  andButtonTitle:@"0"];
                [alert layoutSubviews];
                
                NSDictionary *userDic = [[NSUserDefaults standardUserDefaults] objectForKey:@"user"];
                NSMutableDictionary *userMutableDic = [[NSMutableDictionary alloc] initWithDictionary:userDic];
                
                
                for (int i=0; i<6; i++) {
                    UITextField *textfield = [whiteView viewWithTag:1260+i];
                    [userMutableDic setObject:textfield.text forKey:keyArr[i]];
                    
                }
                
                [[NSUserDefaults standardUserDefaults] setObject:userMutableDic forKey:@"user"];
                
            }else{
                
                CYRecordAlertView *alert = [self.view.window viewWithTag:9999];
                [alert alertViewWith:@"错误！" andDetailTitle:[ErrorStatus errorStatus:[NSString stringWithFormat:@"%@",[dictionary objectForKey:@"errorId"]]]  andButtonTitle:@"0"];
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
            
            
        } andFailedBlocks:^(NSError *error, NetRequestManage *editLinkman) {
            
            NSLog(@"editLinkmanError = %@",error.localizedDescription);
            
        }];
        
        
    }
   
     
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"联系人信息";
    
    NSDictionary *userDic = [[NSUserDefaults standardUserDefaults] objectForKey:@"user"];
//    NSLog(@"userDic = %@",userDic);
    user = [[LoginUser alloc] initWithDictionary:userDic];
    
    
    self.view.backgroundColor = MBColor(241, 255, 255, 1);
#pragma mark - 右侧按钮
    
    _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _rightBtn.frame = CGRectMake(0, 0, 39*Ratio, 20*Ratio);
    [_rightBtn setTitle:@"修改" forState:UIControlStateNormal];
    [_rightBtn setTitle:@"保存" forState:UIControlStateSelected];
    _rightBtn.titleLabel.font = [UIFont yaHeiFontOfSize:15*Ratio];
    
    [_rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_rightBtn addTarget:self action:@selector(commit:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_rightBtn];
    
    
    [self createInterface];
    // Do any additional setup after loading the view.
}

-(void)createInterface{
    //背景白
    whiteView = [[UIView alloc] init];
    whiteView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:whiteView];
    [whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.view);
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view);
        make.height.mas_equalTo(258.5*Ratio);
    }];
    
    NSArray *textArr = @[@"联系人姓名",@"联系人与宝宝关系",@"性别",@"电话",@"邮箱",@"紧急联系电话"];
    NSArray *arr2 = @[(user.linkmanname)?user.linkmanname:@"",(user.linkman)?user.linkman:@"",(user.linkmansex)?(([user.linkmansex intValue] == 1)?@"男":@"女"):@"",(user.linkmanmobile)?user.linkmanmobile:@"",(user.linkmanemail)?user.linkmanemail:@"",(user.emergencyphone)?user.emergencyphone:@""];

    UILabel *lastLab = nil;
    for (int i=0; i<6; i++) {
        UILabel *label = [[UILabel alloc] init];
        [label makeLabelWithText:textArr[i] andTextColor:MBColor(102, 103, 104, 1) andFont:[UIFont yaHeiFontOfSize:13*Ratio]];
        [whiteView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(whiteView).offset(10*Ratio);
            make.size.mas_equalTo(CGSizeMake(121*Ratio, 43*Ratio));
            if (lastLab) {
                make.top.equalTo(lastLab.mas_bottom);
            }else{
                make.top.equalTo(whiteView);
            }
        }];
        
        lastLab = label;
        
        
        UILabel *line = [[UILabel alloc] init];
        line.backgroundColor = MBColor(251, 218, 236, 1);
        [whiteView addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@(0.5*Ratio));
            make.left.equalTo(whiteView).offset(10*Ratio);
            make.right.equalTo(whiteView).offset(-10*Ratio);
            make.top.equalTo(label);
            
        }];
        
        
        UITextField *textfield = [[UITextField alloc] init];
        textfield.tag = 1260+i;
//        textfield.layer.masksToBounds = YES;
//        textfield.layer.cornerRadius = 12*Ratio;
//        textfield.layer.borderColor = MBColor(179, 179, 179, 1).CGColor;
//        textfield.layer.borderWidth = 0.5*Ratio;
        [textfield setBackground:nil];

        textfield.textAlignment = NSTextAlignmentRight;
        textfield.keyboardType = UIKeyboardTypeDefault;
        if (i > 2) {
            if (i==4) {
                textfield.keyboardType = UIKeyboardTypeEmailAddress;
            }else{
                textfield.keyboardType = UIKeyboardTypePhonePad;
            }
        }
        textfield.delegate = self;
        textfield.text = arr2[i];
        [textfield setLeftViewOfBlankforWidth:8*Ratio];
        [whiteView addSubview:textfield];
        [textfield mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake((i>2)?(120*Ratio):((i==0)?80*Ratio:60*Ratio), 24*Ratio));
            make.centerY.equalTo(label);
            make.right.equalTo(whiteView).offset(-30*Ratio);
        }];

        
    }
    
    
    _hiddenView = [[UIView alloc] init];
    _hiddenView.backgroundColor = [UIColor clearColor];
    [whiteView addSubview:_hiddenView];
    [_hiddenView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(whiteView);
        make.center.equalTo(whiteView);
    }];
    
    
    
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
