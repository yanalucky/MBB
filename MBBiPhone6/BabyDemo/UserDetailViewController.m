//
//  UserDetailViewController.m
//  BabyDemo
//
//  Created by 陈彦 on 16/5/27.
//  Copyright © 2016年 elsa. All rights reserved.
//

#import "UserDetailViewController.h"
#import "BabyDetailCell.h"
#import "LoginUser.h"

#import "NetRequestManage.h"
#import "CYRecordAlertView.h"
#import "AppDelegate.h"

@interface UserDetailViewController ()<UIScrollViewDelegate,UITextFieldDelegate>{
    
    LoginUser *user;
    UIScrollView *sc;
    
    float chaZhi;
    
    
    UIButton *_rightBtn;

    UIView *_hiddenView;
    
    
    
    //可修改信息
    UITextField *babyTime;
    UITextField *birthPlace;
    UITextField *bornLength;
    UITextField *numberOfFetus;
    UITextField *nativePlace;
    UITextField *nationality;
    UITextField *nation;
    
}

@end

@implementation UserDetailViewController

- (void)viewDidLoad {
    NSDictionary *userDic = [[NSUserDefaults standardUserDefaults] objectForKey:@"user"];
    NSLog(@"userDic = %@",userDic);
    user = [[LoginUser alloc] initWithDictionary:userDic];
    [super viewDidLoad];
    self.title = @"宝宝信息";
    self.view.backgroundColor = [UIColor whiteColor];
//    self.navigationController.interactivePopGestureRecognizer.delegate = nil;
    [self createInterface];
    
    // Do any additional setup after loading the view.
}

-(void)commit:(UIButton *)button{
    
    [self.view endEditing:YES];

    button.selected = !button.selected;
    _hiddenView.hidden = button.selected;
    if (_hiddenView.hidden) {
        [babyTime setBackground:[UIImage imageNamed:@"chouti_geren"]];
        babyTime.textAlignment = NSTextAlignmentLeft;
        [bornLength setBackground:[UIImage imageNamed:@"chouti_geren"]];
        bornLength.textAlignment = NSTextAlignmentLeft;
        [birthPlace setBackground:[UIImage imageNamed:@"chouti_geren"]];
        birthPlace.textAlignment = NSTextAlignmentLeft;
        [numberOfFetus setBackground:[UIImage imageNamed:@"chouti_geren"]];
        numberOfFetus.textAlignment = NSTextAlignmentLeft;
        [nativePlace setBackground:[UIImage imageNamed:@"chouti_geren"]];
        nativePlace.textAlignment = NSTextAlignmentLeft;
        [nationality setBackground:[UIImage imageNamed:@"chouti_geren"]];
        nationality.textAlignment = NSTextAlignmentLeft;
        [nation setBackground:[UIImage imageNamed:@"chouti_geren"]];
        nation.textAlignment = NSTextAlignmentLeft;
    }else{
        [babyTime setBackground:nil];
        babyTime.textAlignment = NSTextAlignmentRight;
        [bornLength setBackground:nil];
        bornLength.textAlignment = NSTextAlignmentRight;
        [birthPlace setBackground:nil];
        birthPlace.textAlignment = NSTextAlignmentRight;
        [numberOfFetus setBackground:nil];
        numberOfFetus.textAlignment = NSTextAlignmentRight;
        [nativePlace setBackground:nil];
        nativePlace.textAlignment = NSTextAlignmentRight;
        [nationality setBackground:nil];
        nationality.textAlignment = NSTextAlignmentRight;
        [nation setBackground:nil];
        nation.textAlignment = NSTextAlignmentRight;
        
    }
    

    if (!button.selected) {
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        [dic setObject:babyTime.text forKey:@"bornTime"];
        [dic setObject:birthPlace.text forKey:@"bornPlace"];
        [dic setObject:bornLength.text forKey:@"bornHeight"];
        [dic setObject:numberOfFetus.text forKey:@"parity"];
        [dic setObject:nativePlace.text forKey:@"nativePlace"];
        [dic setObject:nationality.text forKey:@"nationality"];
        [dic setObject:nation.text forKey:@"nation"];
        
        [NetRequestManage saveUserWithUserId:[[NSUserDefaults standardUserDefaults] objectForKey:@"userId"] andBabyInfoDic:dic successBlocks:^(NSData *data, NetRequestManage *saveUser) {
            
            NSString *str = [[NSString alloc] initWithData:saveUser.resultData encoding:NSUTF8StringEncoding];
            
            NSLog(@"saveUser = %@",str);
            
            NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:saveUser.resultData options:NSJSONReadingMutableContainers error:nil];
            if (([[dictionary objectForKey:@"errorId"] intValue] == 0)&&([[[dictionary objectForKey:@"result"] objectForKey:@"isSaveUser"] intValue] == 1)) {
                NSLog(@"修改个人信息成功！");
                CYRecordAlertView *alert = [self.view.window viewWithTag:9999];
                [alert alertViewWith:@"修改个人信息成功！" andDetailTitle:nil  andButtonTitle:@"0"];
                [alert layoutSubviews];
                NSDictionary *userDic = [[NSUserDefaults standardUserDefaults] objectForKey:@"user"];
                NSMutableDictionary *userMutableDic = [[NSMutableDictionary alloc] initWithDictionary:userDic];
                [userMutableDic setObject:babyTime.text forKey:@"borntime"];
                [userMutableDic setObject:birthPlace.text forKey:@"bornplace"];
                [userMutableDic setObject:bornLength.text forKey:@"bornheight"];
                [userMutableDic setObject:numberOfFetus.text forKey:@"parity"];
                [userMutableDic setObject:nativePlace.text forKey:@"nativeplace"];
                [userMutableDic setObject:nationality.text forKey:@"nationality"];
                [userMutableDic setObject:nation.text forKey:@"nation"];
                [[NSUserDefaults standardUserDefaults] setObject:userMutableDic forKey:@"user"];
                
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
            
        } andFailedBlocks:^(NSError *error, NetRequestManage *saveUser) {
            
            NSLog(@"saveUserError = %@",error.localizedDescription);
            
        }];
    }
   
}

-(void)createInterface{
    
    
    
#pragma mark - 右侧按钮
    
    _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _rightBtn.frame = CGRectMake(0, 0, 39*Ratio, 20*Ratio);
    [_rightBtn setTitle:@"修改" forState:UIControlStateNormal];
    [_rightBtn setTitle:@"保存" forState:UIControlStateSelected];
    _rightBtn.titleLabel.font = [UIFont yaHeiFontOfSize:15*Ratio];

    [_rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [_rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateDisabled];
    [_rightBtn addTarget:self action:@selector(commit:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_rightBtn];
    
    _rightBtn.hidden = ([[[NSUserDefaults standardUserDefaults] objectForKey:@"userRole"] intValue] == 0)?YES:NO;
    
    
    if ([self respondsToSelector:@selector(automaticallyAdjustsScrollViewInsets)]) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    NSArray *arr = @[@"宝宝姓名",@"性别",@"出生年月",@"出生时间",@"出生地",@"出生体重",@"出生身长",@"出生状况",@"分娩方式",@"胎次",@"产次",@"新生儿疾病筛查",@"籍贯",@"国籍",@"民族"];
    
    sc = [[UIScrollView alloc] init];
    sc.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:sc];
    
    [sc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(self.view);
        make.center.equalTo(self.view);
    }];
    
    UIView *contentView = [[UIView alloc] init];
    [sc addSubview:contentView];
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(sc);
        make.edges.equalTo(sc);
    }];
    contentView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(resign:)];
    [contentView addGestureRecognizer:tap];
    
    UIView *lastView = nil;
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"userRole"] intValue] == 0) {
        
        for (int i=0; i<5; i++) {
            BabyDetailCell *view = [[BabyDetailCell alloc] init];
            if (i<3) {
                view.title.text = arr[i];
            }else if(i==3){
                view.title.text =@"出生体重";
            }else{
                view.title.text = @"出生身长";
            }
            
            
            [contentView addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(CGSizeMake(320*Ratio, 43*Ratio));
                make.centerX.equalTo(self.view);
                if (lastView) {
                    make.top.equalTo(lastView.mas_bottom);
                }else{
                    make.top.equalTo(contentView);
                }
            }];
            
            lastView = view;
        }
        [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(lastView);
        }];
        
        
        
#pragma mark = 名字
        
        UILabel *babyName = [[UILabel alloc] init];
        babyName.textColor = MBColor(179, 179, 179, 1);
        babyName.font = [UIFont yaHeiFontOfSize:12*Ratio];
        babyName.textAlignment = NSTextAlignmentRight;
        babyName.text = user.truename;
        [contentView addSubview:babyName];
        [babyName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(contentView).offset(-30*Ratio);
            make.centerY.equalTo(contentView.mas_top).offset(21.5*Ratio);
            make.size.mas_equalTo(CGSizeMake(80*Ratio, 24*Ratio));
        }];
        
#pragma mark = 性别
        
        UILabel *sex = [[UILabel alloc] init];
        sex.textColor = MBColor(179, 179, 179, 1);
        sex.font = [UIFont yaHeiFontOfSize:12*Ratio];
        sex.textAlignment = NSTextAlignmentRight;
        sex.text = ([user.sex boolValue] == 1)?@"男":@"女";
        [contentView addSubview:sex];
        [sex mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(contentView).offset(-30*Ratio);
            make.centerY.equalTo(contentView.mas_top).offset(21.5*Ratio*3);
            make.size.mas_equalTo(CGSizeMake(80*Ratio, 24*Ratio));
        }];
        
#pragma mark = 出生年月
        
        UILabel *birthday = [[UILabel alloc] init];
        birthday.textColor = MBColor(179, 179, 179, 1);
        birthday.font = [UIFont yaHeiFontOfSize:12*Ratio];
        birthday.textAlignment = NSTextAlignmentRight;
        birthday.text = [user.birthday substringToIndex:10];
        [contentView addSubview:birthday];
        [birthday mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(contentView).offset(-30*Ratio);
            make.centerY.equalTo(contentView.mas_top).offset(21.5*Ratio*5);
            make.size.mas_equalTo(CGSizeMake(80*Ratio, 24*Ratio));
        }];
        
        
        

#pragma mark = 出生体重
        
        UILabel *birthWeight = [[UILabel alloc] init];
        birthWeight.textColor = MBColor(179, 179, 179, 1);
        birthWeight.font = [UIFont yaHeiFontOfSize:12*Ratio];
        birthWeight.textAlignment = NSTextAlignmentRight;
        birthWeight.text = [NSString stringWithFormat:@"%@  kg",user.bornweight];
        [contentView addSubview:birthWeight];
        [birthWeight mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(contentView).offset(-30*Ratio);
            make.centerY.equalTo(contentView.mas_top).offset(21.5*Ratio*7);
            make.size.mas_equalTo(CGSizeMake(80*Ratio, 24*Ratio));
        }];
        
        
#pragma mark = 出生身长
        
        
        
        UILabel *birthHeight = [[UILabel alloc] init];
        birthHeight.textColor = MBColor(179, 179, 179, 1);
        birthHeight.font = [UIFont yaHeiFontOfSize:12*Ratio];
        birthHeight.textAlignment = NSTextAlignmentRight;
        birthHeight.text = [NSString stringWithFormat:@"%@  cm",user.bornheight];
        [contentView addSubview:birthHeight];
        [birthHeight mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(contentView).offset(-30*Ratio);
            make.centerY.equalTo(contentView.mas_top).offset(21.5*Ratio*9);
            make.size.mas_equalTo(CGSizeMake(80*Ratio, 24*Ratio));
        }];
        
        
        
//        bornLength = [[UITextField alloc] init];
//        bornLength.layer.masksToBounds = YES;
//        bornLength.layer.cornerRadius = 12.5*Ratio;
//        bornLength.layer.borderColor = MBColor(179, 179, 179, 1).CGColor;
//        bornLength.delegate = self;
//        bornLength.layer.borderWidth = 0.5*Ratio;
//        bornLength.text = user.bornheight;
//        bornLength.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
//        [bornLength  setLeftViewOfBlankforWidth:8*Ratio];
//        [contentView addSubview:bornLength];
//        [bornLength mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.size.mas_equalTo(CGSizeMake(70*Ratio, 25*Ratio));
//            make.centerY.equalTo(contentView.mas_top).offset(21.5*Ratio*9);
//            make.right.equalTo(contentView).offset(-30*Ratio);
//        }];
      

        
        
    }else{
       
        
        for (int i=0; i<15; i++) {
            BabyDetailCell *view = [[BabyDetailCell alloc] init];
            view.title.text = arr[i];
            
            [contentView addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(CGSizeMake(320*Ratio, 43*Ratio));
                make.centerX.equalTo(self.view);
                if (lastView) {
                    make.top.equalTo(lastView.mas_bottom);
                }else{
                    make.top.equalTo(contentView);
                }
            }];
            
            lastView = view;
        }
        [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(lastView);
        }];
        
        
        
#pragma mark = 名字
        
        UILabel *babyName = [[UILabel alloc] init];
        babyName.textColor = MBColor(179, 179, 179, 1);
        babyName.font = [UIFont yaHeiFontOfSize:12*Ratio];
        babyName.textAlignment = NSTextAlignmentRight;
        babyName.text = user.truename;
        [contentView addSubview:babyName];
        [babyName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(contentView).offset(-30*Ratio);
            make.centerY.equalTo(contentView.mas_top).offset(21.5*Ratio);
            make.size.mas_equalTo(CGSizeMake(80*Ratio, 24*Ratio));
        }];
        
#pragma mark = 性别
        
        UILabel *sex = [[UILabel alloc] init];
        sex.textColor = MBColor(179, 179, 179, 1);
        sex.font = [UIFont yaHeiFontOfSize:12*Ratio];
        sex.textAlignment = NSTextAlignmentRight;
        sex.text = ([user.sex boolValue] == 1)?@"男":@"女";
        [contentView addSubview:sex];
        [sex mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(contentView).offset(-30*Ratio);
            make.centerY.equalTo(contentView.mas_top).offset(21.5*Ratio*3);
            make.size.mas_equalTo(CGSizeMake(80*Ratio, 24*Ratio));
        }];
        
#pragma mark = 出生年月
        
        UILabel *birthday = [[UILabel alloc] init];
        birthday.textColor = MBColor(179, 179, 179, 1);
        birthday.font = [UIFont yaHeiFontOfSize:12*Ratio];
        birthday.textAlignment = NSTextAlignmentRight;
        birthday.text = [user.birthday substringToIndex:10];
        [contentView addSubview:birthday];
        [birthday mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(contentView).offset(-30*Ratio);
            make.centerY.equalTo(contentView.mas_top).offset(21.5*Ratio*5);
            make.size.mas_equalTo(CGSizeMake(80*Ratio, 24*Ratio));
        }];
        
        
        
#pragma mark = 出生时间
        babyTime = [[UITextField alloc] init];
        

        babyTime.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
        babyTime.delegate = self;
        babyTime.text = user.borntime;
        [babyTime setLeftViewOfBlankforWidth:8*Ratio];
        babyTime.textAlignment = NSTextAlignmentRight;
        [babyTime setBackground:nil];
        [contentView addSubview:babyTime];
        [babyTime mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(70*Ratio, 25*Ratio));
            make.centerY.equalTo(contentView.mas_top).offset(21.5*Ratio*7);
            make.right.equalTo(contentView).offset(-30*Ratio);
        }];
        
        
#pragma mark = 出生地
        birthPlace = [[UITextField alloc] init];
        
        birthPlace.textAlignment = NSTextAlignmentRight;
        birthPlace.keyboardType = UIKeyboardTypeDefault;
        birthPlace.delegate = self;
        birthPlace.text = user.bornplace;
        [birthPlace setLeftViewOfBlankforWidth:8*Ratio];
        [birthPlace setBackground:nil];
        [contentView addSubview:birthPlace];
        [birthPlace mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(70*Ratio, 25*Ratio));
            make.centerY.equalTo(contentView.mas_top).offset(21.5*Ratio*9);
            make.right.equalTo(contentView).offset(-30*Ratio);
        }];
#pragma mark = 出生体重
        
        UILabel *birthWeight = [[UILabel alloc] init];
        birthWeight.textColor = MBColor(179, 179, 179, 1);
        birthWeight.font = [UIFont yaHeiFontOfSize:12*Ratio];
        birthWeight.textAlignment = NSTextAlignmentRight;
        birthWeight.text = [NSString stringWithFormat:@"%@  kg",user.bornweight];
        [contentView addSubview:birthWeight];
        [birthWeight mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(contentView).offset(-30*Ratio);
            make.centerY.equalTo(contentView.mas_top).offset(21.5*Ratio*11);
            make.size.mas_equalTo(CGSizeMake(80*Ratio, 24*Ratio));
        }];
        
        
#pragma mark = 出生身长
        bornLength = [[UITextField alloc] init];
        bornLength.delegate = self;
        bornLength.textAlignment = NSTextAlignmentRight;
        bornLength.text = user.bornheight;
        bornLength.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
        [bornLength  setLeftViewOfBlankforWidth:8*Ratio];
        [bornLength setBackground:nil];
        [contentView addSubview:bornLength];
        [bornLength mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(70*Ratio, 25*Ratio));
            make.centerY.equalTo(contentView.mas_top).offset(21.5*Ratio*13);
            make.right.equalTo(contentView).offset(-30*Ratio);
        }];
        
        
        NSArray *buttonArr = @[@"足月儿",@"早产儿",@"低出生体重",@"先心儿",@"顺产",@"臀助",@"产钳",@"剖宫产",@"胎头吸引",@"CH",@"PKU",@"CAH",@"G6PD",@"听力"];
#pragma mark = 出生状况
        UIButton *lastBtn = nil;
        for (int i=0; i<4; i++) {
            UIButton *butt = [UIButton buttonWithType:UIButtonTypeCustom];
            [butt setTitle:buttonArr[i] forState:UIControlStateNormal];
            [butt setTitleColor:MBColor(179, 179, 179, 1) forState:UIControlStateNormal];
            butt.layer.masksToBounds = YES;
            butt.titleLabel.font = [UIFont yaHeiFontOfSize:12*Ratio];
            
            butt.layer.cornerRadius = 12.5*Ratio;
            butt.layer.borderWidth = 0.5;
            butt.layer.borderColor = MBColor(179, 179, 179, 1).CGColor;
            
            if (i == ([user.borntype intValue]-1)) {
                butt.backgroundColor = MBColor(250, 109, 166, 1);
                [butt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                
            }
            if (i == 2) {
                if ([user.haslowweight intValue] == 1) {
                    butt.backgroundColor = MBColor(250, 109, 166, 1);
                    [butt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                    
                }
            }
            
            if (i == 3) {
                if ([user.hasfirstheart intValue] == 1) {
                    butt.backgroundColor = MBColor(250, 109, 166, 1);
                    [butt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                    
                }
            }
            [contentView addSubview:butt];
            [butt mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(contentView.mas_top).offset(21.5 * Ratio * 15);
                make.size.mas_equalTo(CGSizeMake((i==2)?65*Ratio:50*Ratio, 25*Ratio));
                if (lastBtn) {
                    make.left.equalTo(lastBtn.mas_right).offset(2.5*Ratio);
                }else{
                    make.left.equalTo(contentView).offset(86*Ratio);
                }
            }];
            lastBtn = butt;
        }
        
        
        //    @"顺产",@"臀助",@"产钳",@"剖宫产",@"胎头吸引"
        
#pragma mark = 分娩方式
        NSArray *deliveryArr =nil;
        if (user.deliverymethods.length > 0) {
            deliveryArr = [user.deliverymethods componentsSeparatedByString:@","];
        }
        lastBtn = nil;
        for (int i=0; i<5; i++) {
            UIButton *butt = [UIButton buttonWithType:UIButtonTypeCustom];
            [butt setTitle:buttonArr[i+4] forState:UIControlStateNormal];
            butt.titleLabel.font = [UIFont yaHeiFontOfSize:12*Ratio];
            [butt setTitleColor:MBColor(179, 179, 179, 1) forState:UIControlStateNormal];
            butt.layer.masksToBounds = YES;
            butt.layer.cornerRadius = 12.5*Ratio;
            butt.layer.borderWidth = 0.5;
            butt.layer.borderColor = MBColor(179, 179, 179, 1).CGColor;
            NSString *str = [NSString stringWithFormat:@"%d",i];
            if ([deliveryArr containsObject:str]) {
                butt.backgroundColor = MBColor(250, 109, 166, 1);
                [butt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                
            }
            [contentView addSubview:butt];
            [butt mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(contentView.mas_top).offset(21.5 * Ratio * 17);
                make.size.mas_equalTo(CGSizeMake((i==4)?(60*Ratio):((i==3)?50*Ratio:35*Ratio), 25*Ratio));
                if (lastBtn) {
                    make.left.equalTo(lastBtn.mas_right).offset(2.5*Ratio);
                }else{
                    make.left.equalTo(contentView).offset(86*Ratio);
                }
            }];
            lastBtn = butt;
        }
        
        
        
        
        
        
        
        
        
        
        
#pragma mark = 胎次
        
        UILabel *numberOfGive = [[UILabel alloc] init];
        numberOfGive.textColor = MBColor(179, 179, 179, 1);
        numberOfGive.font = [UIFont yaHeiFontOfSize:12*Ratio];
        numberOfGive.textAlignment = NSTextAlignmentRight;
        numberOfGive.text = user.gravidity;
        [contentView addSubview:numberOfGive];
        [numberOfGive mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(contentView).offset(-30*Ratio);
            make.centerY.equalTo(contentView.mas_top).offset(21.5*Ratio*19);
            make.size.mas_equalTo(CGSizeMake(80*Ratio, 24*Ratio));
        }];
        
#pragma mark = 产次
        numberOfFetus = [[UITextField alloc] init];
        numberOfFetus.delegate = self;
        numberOfFetus.textAlignment = NSTextAlignmentRight;
        numberOfFetus.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
        numberOfFetus.text = user.parity;
        [numberOfFetus setLeftViewOfBlankforWidth:8*Ratio];
        [numberOfFetus setBackground:nil];
        [contentView addSubview:numberOfFetus];
        [numberOfFetus mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(70*Ratio, 25*Ratio));
            make.centerY.equalTo(contentView.mas_top).offset(21.5*Ratio*21);
            make.right.equalTo(contentView).offset(-30*Ratio);
        }];
        
        
#pragma mark = 疾病筛查
        NSArray *diseasescreenArr =nil;
        if (user.diseasescreening.length > 0) {
            diseasescreenArr = [user.diseasescreening componentsSeparatedByString:@"|"];
        }
        lastBtn = nil;
        for (int i=0; i<5; i++) {
            UIButton *butt = [UIButton buttonWithType:UIButtonTypeCustom];
            [butt setTitle:buttonArr[i+9] forState:UIControlStateNormal];
            [butt setTitleColor:MBColor(179, 179, 179, 1) forState:UIControlStateNormal];
            butt.titleLabel.font = [UIFont yaHeiFontOfSize:12*Ratio];
            
            
            butt.layer.masksToBounds = YES;
            butt.layer.cornerRadius = 12.5*Ratio;
            butt.layer.borderWidth = 0.5;
            butt.layer.borderColor = MBColor(179, 179, 179, 1).CGColor;
            NSString *str = [NSString stringWithFormat:@"%d",i];
            if ([diseasescreenArr containsObject:str]) {
                butt.backgroundColor = MBColor(250, 109, 166, 1);
                [butt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                
            }
            [contentView addSubview:butt];
            [butt mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(contentView.mas_top).offset(21.5 * Ratio * 23);
                make.size.mas_equalTo(CGSizeMake((i==3)?35*Ratio:30*Ratio, 25*Ratio));
                if (lastBtn) {
                    make.left.equalTo(lastBtn.mas_right).offset(2.5*Ratio);
                }else{
                    make.left.equalTo(contentView).offset(145*Ratio);
                }
                
            }];
            lastBtn = butt;
        }
        
        
        
#pragma mark = 籍贯
        nativePlace = [[UITextField alloc] init];
        nativePlace.delegate = self;
        nativePlace.textAlignment = NSTextAlignmentRight;
        nativePlace.keyboardType = UIKeyboardTypeDefault;
        nativePlace.text = user.nativeplace;
        [nativePlace setLeftViewOfBlankforWidth:8*Ratio];
        [nativePlace setBackground:nil];
        [contentView addSubview:nativePlace];
        [nativePlace mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(70*Ratio, 25*Ratio));
            make.centerY.equalTo(contentView.mas_top).offset(21.5*Ratio*25);
            make.right.equalTo(contentView).offset(-30*Ratio);
        }];
#pragma mark = 国籍
        nationality = [[UITextField alloc] init];
        nationality.delegate = self;
        nationality.textAlignment = NSTextAlignmentRight;
        nationality.keyboardType = UIKeyboardTypeDefault;
        nationality.text = user.nationality;
        [nationality setLeftViewOfBlankforWidth:8*Ratio];
        [nationality setBackground:nil];
        [contentView addSubview:nationality];
        [nationality mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(70*Ratio, 25*Ratio));
            make.centerY.equalTo(contentView.mas_top).offset(21.5*Ratio*27);
            make.right.equalTo(contentView).offset(-30*Ratio);
        }];
#pragma mark = 民族
        nation = [[UITextField alloc] init];
        nation.delegate = self;
        nation.textAlignment = NSTextAlignmentRight;
        nation.keyboardType = UIKeyboardTypeDefault;
        [nation setLeftViewOfBlankforWidth:8*Ratio];
        [nation setBackground:nil];
        nation.text = user.nation;
        [contentView addSubview:nation];
        [nation mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(70*Ratio, 25*Ratio));
            make.centerY.equalTo(contentView.mas_top).offset(21.5*Ratio*29);
            make.right.equalTo(contentView).offset(-30*Ratio);
        }];
        
        
        
        _hiddenView = [[UIView alloc] init];
        _hiddenView.backgroundColor = [UIColor clearColor];
        [contentView addSubview:_hiddenView];
        [_hiddenView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.equalTo(contentView);
            make.center.equalTo(contentView);
        }];
        

    }
    
}


#pragma mark - textField代理相关

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    
    [textField becomeFirstResponder];
    //当键盘遮盖住输入框时，调整偏移量
    chaZhi = textField.frame.origin.y - sc.contentOffset.y - ((568 - 350)*Ratio);
    if (chaZhi > 0) {
        [UIView animateWithDuration:0.5 animations:^{
            sc.contentOffset = CGPointMake(0, sc.contentOffset.y + chaZhi);
        }];
        [self.view layoutIfNeeded];
    }
//    NSLog(@"cell高度：%f  - 偏移量：%f -  显示高度：%f",[textField superview].frame.origin.y ,_tableView.contentOffset.y,((568 - 129 - 64- 44)*Ratio));
    
    NSLog(@"差值 %f",chaZhi);
    
    NSLog(@"%@",NSStringFromCGRect(textField.frame));
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    if (chaZhi > 0) {
        [UIView animateWithDuration:0.5 animations:^{
            sc.contentOffset = CGPointMake(0, sc.contentOffset.y - chaZhi);
        }];
        [self.view layoutIfNeeded];
        chaZhi = 0;
    }
    
   
    [textField resignFirstResponder];
}

#pragma mark - 收键盘
-(void)resign:(UITapGestureRecognizer *)tap{
    
    if (chaZhi > 0) {
        
        [UIView animateWithDuration:0.5 animations:^{
            sc.contentOffset = CGPointMake(0, sc.contentOffset.y - chaZhi);
        }];
        [self.view layoutIfNeeded];
        chaZhi = 0;
        
        
        
    }
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
