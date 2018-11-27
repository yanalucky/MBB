//
//  FillInfoViewController.m
//  BabyDemo
//
//  Created by 陈彦 on 16/6/7.
//  Copyright © 2016年 elsa. All rights reserved.
//

#import "FillInfoViewController.h"
#import "NetRequestManage.h"
#import "SVProgressHUD.h"

#import "LoginDataModels.h"
#import "Time.h"

#import "LeftViewController.h"
#import "RickyNavViewController.h"

#import "CYAlertView.h"

#import "CYRecordAlertView.h"
#import "AppDelegate.h"


@interface FillInfoViewController ()<UITextFieldDelegate>{
    UIView *contentView;
    
    UIView *pickerBgView;//选择器
    UIDatePicker *picker;
    NSDateFormatter *format;
    NSMutableDictionary *totalDic;
    NSMutableArray *deliveryArr;//分娩方式
    BOOL isHaslowwei;
    BOOL isHasfirstheart;
    float _totHeight;
    
    UIScrollView *sc;
    float chaZhi;
    
    LoginUser *user;

}

@end

@implementation FillInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    totalDic = [[NSMutableDictionary alloc] init];
    deliveryArr = [[NSMutableArray alloc] init];
    isHaslowwei = NO;
    isHasfirstheart = NO;
    _totHeight = 0.0;
    [self createInterface];
    // Do any additional setup after loading the view.
}


-(void)addLine:(CGFloat)height{
    UILabel *line = [[UILabel alloc] init];
    line.backgroundColor = MBColor(252, 236, 246, 1);
    [contentView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(contentView);
        make.centerX.equalTo(contentView);
        make.height.mas_equalTo(0.5);
        make.top.equalTo(contentView).offset(height*Ratio);
    }];
    
}
-(void)createInterface{
    
    if ([self respondsToSelector:@selector(automaticallyAdjustsScrollViewInsets)]) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    sc = [[UIScrollView alloc] init];
    sc.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:sc];
    
    [sc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(self.view);
        make.center.equalTo(self.view);
    }];
    
    contentView = [[UIView alloc] init];
    
    [sc addSubview:contentView];
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(sc);
        make.edges.equalTo(sc);
    }];
    contentView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(resign:)];
    [contentView addGestureRecognizer:tap];
    
    UILabel *title = [[UILabel alloc] init];
    [title makeLabelWithText:@"完善信息" andTextColor:MBColor(250, 109, 166, 1) andFont:[UIFont yaHeiFontOfSize:21*Ratio]];
    title.textAlignment = NSTextAlignmentCenter;
    [contentView addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(contentView);
        make.top.equalTo(contentView).offset(30*Ratio);
        make.size.mas_equalTo(CGSizeMake(100*Ratio, 24*Ratio));
    }];
    
    UILabel *tishi = [[UILabel alloc] init];
    [tishi makeLabelWithText:@"萌宝的出生信息对医生的评估非常重要，请认真填写" andTextColor:MBColor(151, 152, 153, 1) andFont:[UIFont yaHeiFontOfSize:9*Ratio]];
    tishi.textAlignment = NSTextAlignmentCenter;
    [contentView addSubview:tishi];
    [tishi mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(contentView);
        make.top.equalTo(title.mas_bottom).offset(10*Ratio);
        make.size.mas_equalTo(CGSizeMake(240*Ratio, 12*Ratio));
    }];
    
    
    [self addLine:89];
    
    UILabel *lab0 = [[UILabel alloc] init];
    [lab0 makeLabelWithText:@"宝宝姓名" andTextColor:MBColor(151, 152, 153, 1) andFont:[UIFont yaHeiFontOfSize:14*Ratio]];
    [contentView addSubview:lab0];
    [lab0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView).offset(15*Ratio);
        make.size.mas_equalTo(CGSizeMake(109*Ratio, 14*Ratio));
        make.top.equalTo(tishi.mas_bottom).offset(30*Ratio);
    }];
    
    

    user = [[LoginUser alloc] initWithDictionary:[[NSUserDefaults standardUserDefaults] objectForKey:@"user"]];
    BOOL canChangeUser = YES;
#pragma mark = 宝宝姓名
    UITextField *babayName = [[UITextField alloc] init];
    babayName.tag = 1240;
    
    if (user.truename&&user.truename.length > 0 ) {
     
        babayName.text = user.truename;
        canChangeUser = NO;
        
    }else{
        babayName.text = @"";
    }
    babayName.enabled = canChangeUser;
    [babayName setBackground:[UIImage imageNamed:@"buy_info_input"]];
    [babayName setLeftViewOfBlankforWidth:23*Ratio];
    babayName.delegate = self;
    babayName.keyboardType = UIKeyboardTypeDefault;
    [contentView addSubview:babayName];
    [babayName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(138*Ratio, 23*Ratio));
        make.centerY.equalTo(lab0);
        make.right.equalTo(contentView).offset(-44*Ratio);
    }];
    
    [self addLine:(89+48)];
    
    UILabel *lab1 = [[UILabel alloc] init];
    [lab1 makeLabelWithText:@"宝宝性别" andTextColor:MBColor(151, 152, 153, 1) andFont:[UIFont yaHeiFontOfSize:14*Ratio]];
    [contentView addSubview:lab1];
    [lab1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView).offset(15*Ratio);
        make.size.mas_equalTo(CGSizeMake(109*Ratio, 14*Ratio));
        make.top.equalTo(lab0).offset(48*Ratio);
    }];
    
#pragma mark = 宝宝性别
    UIButton *sexBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [sexBtn setImage:[UIImage imageNamed:@"denglu_girl"] forState:UIControlStateNormal];
    [sexBtn setImage:[UIImage imageNamed:@"denglu_girl_set"] forState:UIControlStateSelected];
    [sexBtn setTitle:@"女" forState:UIControlStateNormal];
    sexBtn.tag = 1220;
    [sexBtn addTarget:self action:@selector(selSex:) forControlEvents:UIControlEventTouchUpInside];
    if (canChangeUser == NO) {
        if ([user.sex intValue] == 1) {
            [sexBtn setImage:[UIImage imageNamed:@"denglu_girl"] forState:UIControlStateDisabled];

        }else{
            [sexBtn setImage:[UIImage imageNamed:@"denglu_girl_set"] forState:UIControlStateDisabled];

        }

    }
    [sexBtn setTitleColor:MBColor(151, 152, 153, 1) forState:UIControlStateNormal];
    [contentView addSubview:sexBtn];
    [sexBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(lab1);
        make.left.equalTo(contentView).offset(140*Ratio);
        make.size.mas_equalTo(CGSizeMake(70*Ratio, 29*Ratio));
    }];
    
    UIButton *sexBtn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [sexBtn1 setImage:[UIImage imageNamed:@"denglu_boy"] forState:UIControlStateNormal];
    [sexBtn1 setImage:[UIImage imageNamed:@"denglu_boy_set"] forState:UIControlStateSelected];
    [sexBtn1 setTitle:@"男" forState:UIControlStateNormal];
    sexBtn1.tag = 1221;
    if (canChangeUser == NO) {
        if ([user.sex intValue] == 1) {
            [sexBtn1 setImage:[UIImage imageNamed:@"denglu_boy_set"] forState:UIControlStateDisabled];
            
        }else{
            [sexBtn1 setImage:[UIImage imageNamed:@"denglu_boy"] forState:UIControlStateDisabled];
            
        }
        
    }
    [sexBtn1 setTitleColor:MBColor(151, 152, 153, 1) forState:UIControlStateNormal];
    [sexBtn1 addTarget:self action:@selector(selSex:) forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview:sexBtn1];
    [sexBtn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(lab1);
        make.left.equalTo(contentView).offset(215*Ratio);
        make.size.mas_equalTo(CGSizeMake(70*Ratio, 29*Ratio));
    }];
    sexBtn.enabled = canChangeUser;
    sexBtn1.enabled = canChangeUser;
    

    
    [self addLine:(89+48+48)];
    
    UILabel *lab2 = [[UILabel alloc] init];
    [lab2 makeLabelWithText:@"出生日期" andTextColor:MBColor(151, 152, 153, 1) andFont:[UIFont yaHeiFontOfSize:14*Ratio]];
    [contentView addSubview:lab2];
    [lab2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView).offset(15*Ratio);
        make.size.mas_equalTo(CGSizeMake(109*Ratio, 14*Ratio));
        make.top.equalTo(lab1).offset(48*Ratio);
    }];

#pragma mark = 选择器
    
    pickerBgView = [[UIView alloc] init];
    pickerBgView.backgroundColor = MBColor(190, 191, 192, 0.5);
    pickerBgView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pickerViewClick:)];
    [pickerBgView addGestureRecognizer:tap1];
    
    [self.view addSubview:pickerBgView];
    [pickerBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(self.view);
        make.center.equalTo(self.view);
    }];
    
    
    picker = [[UIDatePicker alloc] init];
    picker.datePickerMode = UIDatePickerModeDate;
    picker.backgroundColor = [UIColor whiteColor];
    format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy-MM-dd"];
    [picker setDate:[format dateFromString:[[NSString stringWithFormat:@"%@",[[NSDate date] dateByAddingTimeInterval:60*60*8]] substringToIndex:10]] animated:NO];
    
//    NSDate *nowDate = [[NSDate date] dateByAddingTimeInterval:60*60*8];
    
//    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    [dateComponents setMonth:-36];
//    NSDate *newDate = [calendar dateByAddingComponents:dateComponents toDate:nowDate options:0];
    NSDateComponents *dateComponents1 = [[NSDateComponents alloc] init];
    [dateComponents1 setDay:-25];
//    NSDate *nowDate1 = [calendar dateByAddingComponents:dateComponents1 toDate:nowDate options:0];
//    NSString *nowDateStr = [[NSString stringWithFormat:@"%@",nowDate] substringToIndex:10];
//    NSString *newDateStr = [[NSString stringWithFormat:@"%@",newDate] substringToIndex:10];
//    [picker setMaximumDate:nowDate1];
//    [picker setMinimumDate:newDate];
    [picker addTarget:self action:@selector(selDate:) forControlEvents:UIControlEventValueChanged];
    [pickerBgView addSubview:picker];
    [picker mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(pickerBgView);
        
        make.size.mas_equalTo(CGSizeMake(320*Ratio, 215*Ratio));
        make.centerX.equalTo(pickerBgView);
    }];
    [self.view bringSubviewToFront:pickerBgView];
    
    pickerBgView.hidden = YES;
    

    
    
    
#pragma mark = 出生日期
    NSArray *dateArr = @[@"年",@"月",@"日",@"1970",@"01"];
    NSArray *birthdayArr = nil;
    if (canChangeUser == NO) {
        birthdayArr = [user.birthday componentsSeparatedByString:@"-"];
    }
    for (int i=0; i<3; i++) {
        UILabel *date = [[UILabel alloc] init];
        [date makeLabelWithText:dateArr[i] andTextColor:MBColor(151, 152, 153, 1) andFont:[UIFont yaHeiFontOfSize:14*Ratio]];
        [contentView addSubview:date];
        [date mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(lab2);
            make.size.mas_equalTo(CGSizeMake(16*Ratio, 16*Ratio));
            make.right.equalTo(contentView).offset(-16*Ratio-(60*Ratio*(2-i)));
        }];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = 1231+i;
        [button setBackgroundImage:[UIImage imageNamed:(i>0)?(@"denglu_day_small"):(@"denglu_day_big")] forState:UIControlStateNormal];
        [button setTitleColor:MBColor(151, 152, 153, 1) forState:UIControlStateNormal];
        [button setTitle:(i==0)?dateArr[3]:dateArr[4] forState:UIControlStateNormal];
        button.titleEdgeInsets = UIEdgeInsetsMake(0, -13*Ratio, 0, 0);
        
        if (birthdayArr) {
            
            button.enabled = NO;
            [button setTitle:birthdayArr[i] forState:UIControlStateDisabled];
            
        }
        [button addTarget:self action:@selector(dateClick:) forControlEvents:UIControlEventTouchUpInside];
        [contentView addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(date);
            make.size.mas_equalTo(CGSizeMake((i>0)?(43*Ratio):(53*Ratio), 23*Ratio));
            make.right.equalTo(date.mas_left);
        }];
    }

    [self addLine:(89+48+48+48)];
    
    UILabel *lab3 = [[UILabel alloc] init];
    [lab3 makeLabelWithText:@"出生体重" andTextColor:MBColor(151, 152, 153, 1) andFont:[UIFont yaHeiFontOfSize:14*Ratio]];
    
    [contentView addSubview:lab3];
    [lab3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView).offset(15*Ratio);
        make.size.mas_equalTo(CGSizeMake(109*Ratio, 14*Ratio));
        make.top.equalTo(lab2).offset(48*Ratio);
    }];
#pragma mark = 出生体重
    UITextField *weight = [[UITextField alloc] init];
    weight.tag = 1241;
    [weight setBackground:[UIImage imageNamed:@"buy_info_input"]];
    [weight setLeftViewOfBlankforWidth:23*Ratio];
    
    weight.delegate = self;
    [weight addTarget:self action:@selector(reformatAsPhoneNumber:) forControlEvents:UIControlEventValueChanged];
    weight.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    if (canChangeUser == NO) {
        
        weight.text = user.bornweight;
        weight.enabled = NO;
    }
    [contentView addSubview:weight];
    [weight mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(138*Ratio, 23*Ratio));
        make.centerY.equalTo(lab3);
        make.right.equalTo(contentView).offset(-44*Ratio);
    }];
    
    UILabel *unit0 = [[UILabel alloc] init];
    [unit0 makeLabelWithText:@"kg" andTextColor:MBColor(151, 152, 153, 1) andFont:[UIFont yaHeiFontOfSize:14*Ratio]];
    [contentView addSubview:unit0];
    [unit0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(19*Ratio, 19*Ratio));
        make.centerY.equalTo(lab3);
        make.left.equalTo(weight.mas_right).offset(12*Ratio);
    }];
    
    
    [self addLine:(89+48+48+48+48)];
    
    UILabel *lab4 = [[UILabel alloc] init];
    [lab4 makeLabelWithText:@"出生身长" andTextColor:MBColor(151, 152, 153, 1) andFont:[UIFont yaHeiFontOfSize:14*Ratio]];
    [contentView addSubview:lab4];
    [lab4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView).offset(15*Ratio);
        make.size.mas_equalTo(CGSizeMake(109*Ratio, 14*Ratio));
        make.top.equalTo(lab3).offset(48*Ratio);
    }];
#pragma mark = 出生身长
    UITextField *height = [[UITextField alloc] init];
    height.tag = 1242;
    [height setBackground:[UIImage imageNamed:@"buy_info_input"]];
    [height setLeftViewOfBlankforWidth:23*Ratio];
    height.delegate = self;
    [height addTarget:self action:@selector(reformatAsPhoneNumber:) forControlEvents:UIControlEventValueChanged];

    height.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    if (canChangeUser == NO) {
        height.enabled = NO;
        height.text = user.bornheight;
    }
    [contentView addSubview:height];
    [height mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(138*Ratio, 23*Ratio));
        make.centerY.equalTo(lab4);
        make.right.equalTo(contentView).offset(-44*Ratio);
    }];
    
    UILabel *unit1 = [[UILabel alloc] init];
    [unit1 makeLabelWithText:@"cm" andTextColor:MBColor(151, 152, 153, 1) andFont:[UIFont yaHeiFontOfSize:14*Ratio]];
    [contentView addSubview:unit1];
    [unit1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(21*Ratio, 19*Ratio));
        make.centerY.equalTo(lab4);
        make.left.equalTo(height.mas_right).offset(12*Ratio);
    }];

    [self addLine:(89+48+48+48+48+48)];
    _totHeight = 89+48+48+48+48+48;
    if (_isLong) {
        UILabel *lab5 = [[UILabel alloc] init];
        [lab5 makeLabelWithText:@"妈妈的孕周" andTextColor:MBColor(151, 152, 153, 1) andFont:[UIFont yaHeiFontOfSize:14*Ratio]];
        [contentView addSubview:lab5];
        [lab5 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(contentView).offset(15*Ratio);
            make.size.mas_equalTo(CGSizeMake(109*Ratio, 14*Ratio));
            make.top.equalTo(lab4).offset(48*Ratio);
        }];
#pragma mark = 妈妈孕周
        UITextField *week = [[UITextField alloc] init];
        week.tag = 1243;
        [week setBackground:[UIImage imageNamed:@"buy_info_input"]];
        [week setLeftViewOfBlankforWidth:23*Ratio];
        week.delegate = self;
        week.keyboardType = UIKeyboardTypeNumberPad;
        [week addTarget:self action:@selector(reformatAsPhoneNumber:) forControlEvents:UIControlEventValueChanged];

        [contentView addSubview:week];
        [week mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(138*Ratio, 23*Ratio));
            make.centerY.equalTo(lab5);
            make.right.equalTo(contentView).offset(-44*Ratio);
        }];
        
        UILabel *unit2 = [[UILabel alloc] init];
        [unit2 makeLabelWithText:@"周" andTextColor:MBColor(151, 152, 153, 1) andFont:[UIFont yaHeiFontOfSize:14*Ratio]];
        [contentView addSubview:unit2];
        [unit2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(21*Ratio, 19*Ratio));
            make.centerY.equalTo(lab5);
            make.left.equalTo(height.mas_right).offset(12*Ratio);
        }];
        
        [self addLine:(89+48+48+48+48+48+48)];
        
        UILabel *lab6 = [[UILabel alloc] init];
        [lab6 makeLabelWithText:@"胎次" andTextColor:MBColor(151, 152, 153, 1) andFont:[UIFont yaHeiFontOfSize:14*Ratio]];
        [contentView addSubview:lab6];
        [lab6 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(contentView).offset(15*Ratio);
            make.size.mas_equalTo(CGSizeMake(109*Ratio, 14*Ratio));
            make.top.equalTo(lab5).offset(48*Ratio);
        }];
#pragma mark = 胎次
        UITextField *babyNum = [[UITextField alloc] init];
        babyNum.tag = 1244;
        [babyNum setBackground:[UIImage imageNamed:@"buy_info_input"]];
        [babyNum setLeftViewOfBlankforWidth:23*Ratio];
        
        babyNum.delegate = self;
        [babyNum addTarget:self action:@selector(reformatAsPhoneNumber:) forControlEvents:UIControlEventValueChanged];

        babyNum.keyboardType = UIKeyboardTypeNumberPad;
        [contentView addSubview:babyNum];
        [babyNum mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(138*Ratio, 23*Ratio));
            make.centerY.equalTo(lab6);
            make.right.equalTo(contentView).offset(-44*Ratio);
        }];
        
        UILabel *unit3 = [[UILabel alloc] init];
        [unit3 makeLabelWithText:@"次" andTextColor:MBColor(151, 152, 153, 1) andFont:[UIFont yaHeiFontOfSize:14*Ratio]];
        [contentView addSubview:unit3];
        [unit3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(21*Ratio, 19*Ratio));
            make.centerY.equalTo(lab6);
            make.left.equalTo(height.mas_right).offset(12*Ratio);
        }];
        
        
        
        [self addLine:(89+48+48+48+48+48+48+48)];
        
        UILabel *lab7 = [[UILabel alloc] init];
        [lab7 makeLabelWithText:@"出生状况" andTextColor:MBColor(151, 152, 153, 1) andFont:[UIFont yaHeiFontOfSize:14*Ratio]];
        [contentView addSubview:lab7];
        [lab7 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(contentView).offset(15*Ratio);
            make.size.mas_equalTo(CGSizeMake(109*Ratio, 14*Ratio));
            make.top.equalTo(lab6).offset(48*Ratio);
        }];
#pragma mark = 出生状况
        
        NSArray *labArr7 = @[@"足月儿",@"早产儿"];
        for (int i=0; i<2; i++) {
            UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];
            but.tag = 1222+i;
            but.backgroundColor = [UIColor whiteColor];
            but.layer.masksToBounds = YES;
            but.layer.cornerRadius = 11.5*Ratio;
            but.layer.borderWidth = 0.2;
            but.layer.borderColor = MBColor(151, 152, 153, 1).CGColor;
            but.backgroundColor = [UIColor whiteColor];
            [but setTitle:labArr7[i] forState:UIControlStateNormal];
            [but setTitleColor:MBColor(151, 152, 153, 1) forState:UIControlStateNormal];
            [but setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
            but.titleLabel.font = [UIFont yaHeiFontOfSize:12*Ratio];
            [but addTarget:self action:@selector(birth:) forControlEvents:UIControlEventTouchUpInside];
            [contentView addSubview:but];
            [but mas_makeConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(CGSizeMake(50*Ratio, 23*Ratio));
                make.centerY.equalTo(lab7);
                make.right.equalTo(contentView).offset(-53*Ratio-((1-i)*Ratio*74));
            }];
        }
        [self addLine:(89+48+48+48+48+48+48+48+48)];
        
        UILabel *lab8 = [[UILabel alloc] init];
        [lab8 makeLabelWithText:@"低出生体重" andTextColor:MBColor(151, 152, 153, 1) andFont:[UIFont yaHeiFontOfSize:14*Ratio]];
        [contentView addSubview:lab8];
        [lab8 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(contentView).offset(15*Ratio);
            make.size.mas_equalTo(CGSizeMake(109*Ratio, 14*Ratio));
            make.top.equalTo(lab7).offset(48*Ratio);
        }];
        
        UIButton *isTrue = [UIButton buttonWithType:UIButtonTypeCustom];
        [isTrue setBackgroundImage:[UIImage imageNamed:@"jilu_fayu"] forState:UIControlStateNormal];
        [isTrue setBackgroundImage:[UIImage imageNamed:@"jilu_fayu_set"] forState:UIControlStateSelected];
        isTrue.tag = 1224;
        [isTrue addTarget:self action:@selector(lowWeight:) forControlEvents:UIControlEventTouchUpInside];
        [contentView addSubview:isTrue];
        [isTrue mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(21*Ratio, 21*Ratio));
            make.centerY.equalTo(lab8);
            make.right.equalTo(contentView).offset(-17*Ratio);
        }];
        
        
        [self addLine:(89+48+48+48+48+48+48+48+48+48)];
        
        UILabel *lab9 = [[UILabel alloc] init];
        [lab9 makeLabelWithText:@"先心儿" andTextColor:MBColor(151, 152, 153, 1) andFont:[UIFont yaHeiFontOfSize:14*Ratio]];
        [contentView addSubview:lab9];
        [lab9 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(contentView).offset(15*Ratio);
            make.size.mas_equalTo(CGSizeMake(109*Ratio, 14*Ratio));
            make.top.equalTo(lab8).offset(48*Ratio);
        }];
        
        UIButton *isTrue1 = [UIButton buttonWithType:UIButtonTypeCustom];
        [isTrue1 setBackgroundImage:[UIImage imageNamed:@"jilu_fayu"] forState:UIControlStateNormal];
        [isTrue1 setBackgroundImage:[UIImage imageNamed:@"jilu_fayu_set"] forState:UIControlStateSelected];
        isTrue1.tag = 1225;
        [isTrue1 addTarget:self action:@selector(lowWeight:) forControlEvents:UIControlEventTouchUpInside];
        
        [contentView addSubview:isTrue1];
        [isTrue1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(21*Ratio, 21*Ratio));
            make.centerY.equalTo(lab9);
            make.right.equalTo(contentView).offset(-17*Ratio);
        }];
        
        [self addLine:(89+48+48+48+48+48+48+48+48+48+48)];
        
        UILabel *lab10 = [[UILabel alloc] init];
        [lab10 makeLabelWithText:@"分娩方式" andTextColor:MBColor(151, 152, 153, 1) andFont:[UIFont yaHeiFontOfSize:14*Ratio]];
        [contentView addSubview:lab10];
        [lab10 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(contentView).offset(15*Ratio);
            make.size.mas_equalTo(CGSizeMake(109*Ratio, 14*Ratio));
            make.top.equalTo(lab9).offset(48*Ratio);
        }];
        
        
        NSArray *labArr10 = @[@"顺产",@"臀助",@"产钳",@"剖宫产",@"胎头吸引"];
        for (int i=0; i<3; i++) {
            UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];
            but.tag = 1226+i;
            but.layer.masksToBounds = YES;
            but.layer.cornerRadius = 11.5*Ratio;
            but.layer.borderWidth = 0.2;
            but.layer.borderColor = MBColor(151, 152, 153, 1).CGColor;
            but.backgroundColor = [UIColor whiteColor];
            [but setTitle:labArr10[i] forState:UIControlStateNormal];
            [but setTitleColor:MBColor(151, 152, 153, 1) forState:UIControlStateNormal];
            [but setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
            but.titleLabel.font = [UIFont yaHeiFontOfSize:12*Ratio];
            [but addTarget:self action:@selector(theWay:) forControlEvents:UIControlEventTouchUpInside];
            [contentView addSubview:but];
            [but mas_makeConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(CGSizeMake(50*Ratio, 23*Ratio));
                make.centerY.equalTo(lab10);
                make.right.equalTo(contentView).offset(-15*Ratio-((2-i)*Ratio*72.5));
            }];
        }
        for (int i=0; i<2; i++) {
            UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];
            but.tag = 1226+3+i;
            but.layer.masksToBounds = YES;
            but.layer.cornerRadius = 11.5*Ratio;
            but.layer.borderWidth = 0.2;
            but.layer.borderColor = MBColor(151, 152, 153, 1).CGColor;
            but.backgroundColor = [UIColor whiteColor];
            [but setTitle:labArr10[3+i] forState:UIControlStateNormal];
            [but setTitleColor:MBColor(151, 152, 153, 1) forState:UIControlStateNormal];
            [but setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
            but.titleLabel.font = [UIFont yaHeiFontOfSize:12*Ratio];
            [but addTarget:self action:@selector(theWay:) forControlEvents:UIControlEventTouchUpInside];
            [contentView addSubview:but];
            [but mas_makeConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(CGSizeMake(70*Ratio, 23*Ratio));
                make.top.equalTo(lab10.mas_bottom).offset(13*Ratio);
                make.right.equalTo(contentView).offset(-41*Ratio-((1-i)*Ratio*94));
            }];
            
        }
        
        
        [self addLine:(89+48+48+48+48+48+48+48+48+48+48+83)];
        
        
        
        UILabel *lab11 = [[UILabel alloc] init];
        [lab11 makeLabelWithText:@"紧急联系电话" andTextColor:MBColor(151, 152, 153, 1) andFont:[UIFont yaHeiFontOfSize:14*Ratio]];
        [contentView addSubview:lab11];
        [lab11 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(contentView).offset(15*Ratio);
            make.size.mas_equalTo(CGSizeMake(109*Ratio, 14*Ratio));
            make.top.equalTo(lab10).offset(83*Ratio);
        }];
        
        
#pragma mark = 紧急联系电话
        UITextField *phone = [[UITextField alloc] init];
        phone.tag = 1245;
        [phone setBackground:[UIImage imageNamed:@"buy_info_input"]];
        [phone setLeftViewOfBlankforWidth:23*Ratio];
        phone.delegate = self;
        [phone addTarget:self action:@selector(reformatAsPhoneNumber:) forControlEvents:UIControlEventValueChanged];

        phone.keyboardType = UIKeyboardTypePhonePad;
        [contentView addSubview:phone];
        [phone mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(138*Ratio, 23*Ratio));
            make.centerY.equalTo(lab11);
            make.right.equalTo(contentView).offset(-44*Ratio);
        }];
        
        
        [self addLine:(89+48+48+48+48+48+48+48+48+48+48+83+48)];
        
        _totHeight = 89+48+48+48+48+48+48+48+48+48+48+83+48;
        
    }
    
    
    
    UIButton *finish = [UIButton buttonWithType:UIButtonTypeCustom];
    [finish setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [finish setTitle:@"完成" forState:UIControlStateNormal];
    finish.backgroundColor = MBColor(250, 109, 166, 1);
    finish.layer.masksToBounds = YES;
    finish.layer.cornerRadius = 5*Ratio;
    [finish addTarget:self action:@selector(finishAction:) forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview:finish];
    [finish mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(301*Ratio, 40.5*Ratio));
        make.centerX.equalTo(contentView);
        make.top.equalTo(contentView).offset((_totHeight+55)*Ratio);
    }];
//    image = [image resizableImageWithCapInsets:insets resizingMode:UIImageResizingModeStretch];

    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(finish).offset(50);
    }];
    
    
    
    
                                  

    
}
#pragma mark - 宝宝 —— 性别选择
-(void)selSex:(UIButton *)button{
    for (int i=0; i<2; i++) {
        UIButton *but = [contentView viewWithTag:1220+i];
        but.selected = NO;
    }
    button.selected = YES;
    [totalDic setObject:[NSString stringWithFormat:@"%d",(int)button.tag-1220] forKey:@"sex"];
    
}

#pragma mark - 宝宝 -- 出生状况
-(void)birth:(UIButton *)button{
    for (int i=0; i<2; i++) {
        UIButton *but = [contentView viewWithTag:1222+i];
        but.selected = NO;
        but.backgroundColor = [UIColor whiteColor];

    }
    button.selected = YES;
    button.backgroundColor = MBColor(250, 109, 166, 1);
    [totalDic setObject:[NSString stringWithFormat:@"%d",(int)button.tag - 1221] forKey:@"borntype"];
    
}


-(void)lowWeight:(UIButton *)button{
    button.selected = !button.selected;
    if (button.tag == 1224) {
        isHaslowwei = button.selected;
    }else{
        isHasfirstheart = button.selected;
    }
    
}

#pragma mark - 分娩方式
-(void)theWay:(UIButton *)button{
    button.selected = !button.selected;
    if (button.selected) {
        button.backgroundColor = MBColor(250, 109, 166, 1);
    }else{
        button.backgroundColor = [UIColor whiteColor];
    }
    NSString *btnTag = [NSString stringWithFormat:@"%d",(int)button.tag - 1226];
    if ([deliveryArr containsObject:btnTag]) {
        [deliveryArr removeObject:btnTag];
    }else{
        [deliveryArr addObject:btnTag];
    }
    
    
}




#pragma mark - UIDatePicker代理相关

-(void)pickerViewClick:(UITapGestureRecognizer *)tap{
    if (tap.view.hidden == NO) {
        
        tap.view.hidden = YES;
        
    }
}
-(void)dateClick:(UIButton *)button{
//    NSLog(@"点击 ！");
     [self.view endEditing:YES];
    pickerBgView.hidden = NO;
    
    [self.view bringSubviewToFront:pickerBgView];
}
-(void)selDate:(UIDatePicker *)picke{
    
    NSString *date = [[NSString stringWithFormat:@"%@",[[picke date] dateByAddingTimeInterval:60*60*8]] substringToIndex:10];
    NSArray *dateSub = [date componentsSeparatedByString:@"-"];
    for (int i=0; i<3; i++) {
        UIButton *button0 = [contentView viewWithTag:1231+i];
        [button0 setTitle:[NSString stringWithFormat:@"%@",dateSub[i]] forState:UIControlStateNormal];

    }
    [totalDic setObject:date forKey:@"birthday"];
    
//    [_selectedDateBtn setTitle:[NSString stringWithFormat:@"%@月  %@",dateSub[1],dateSub[0]] forState:UIControlStateNormal];
    
    
    
    //    [_selectedDateBtn setTitle:[[NSString stringWithFormat:@"%@",[[picke date] dateByAddingTimeInterval:60*60*8]] substringToIndex:10] forState:UIControlStateNormal];
}
#pragma mark - textfield代理相关

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    
    [textField setBackground:[UIImage imageNamed:@"denglu_shuru"]];
    [textField becomeFirstResponder];
    //当键盘遮盖住输入框时，调整偏移量
    chaZhi = textField.frame.origin.y - sc.contentOffset.y - ((568 - 350)*Ratio);
    if (chaZhi > 0) {
        [UIView animateWithDuration:0.5 animations:^{
            sc.contentOffset = CGPointMake(0, sc.contentOffset.y + chaZhi);
        }];
        [self.view layoutIfNeeded];
    }
    
    sc.contentSize = CGSizeMake(320*Ratio, 1080*Ratio);

}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    
    
//    if (textField.text.length > 0) {
//        [textField setBackground:[UIImage imageNamed:@"denglu_shuru"]];
//    }else{
        [textField setBackground:[UIImage imageNamed:@"buy_info_input"]];
//    }
    
    
    
    
    if (chaZhi > 0) {
        [UIView animateWithDuration:0.5 animations:^{
            sc.contentOffset = CGPointMake(0, sc.contentOffset.y - chaZhi);
        }];
        [self.view layoutIfNeeded];
        chaZhi = 0;
    }
    
    sc.contentSize = CGSizeMake(320*Ratio, 850*Ratio);

    [textField resignFirstResponder];
    
}



#pragma mark - 完成
-(void)finishAction:(UIButton *)button{
    
    NSArray *keyArray = @[@"username",@"bornweight",@"bornheight",@"pregnancy",@"gravidity",@"emergencyphone"];
    [self.view endEditing:YES];
    if (_isLong) {
#pragma mark = 付费用户
        
        for (int i=0; i<6; i++) {
            UITextField *name = [contentView viewWithTag:1240+i];
            NSString *nameStr = [name.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
            if (nameStr.length > 0) {
                [totalDic setObject:name.text forKey:keyArray[i]];
            }else{
                break;
            }
        }
        
        if (user.truename&&user.truename.length > 0) {
            [totalDic setObject:user.truename forKey:keyArray[0]];
            [totalDic setObject:user.bornweight forKey:keyArray[1]];
            [totalDic setObject:user.bornheight forKey:keyArray[2]];
            [totalDic setObject:user.birthday forKey:@"birthday"];
            [totalDic setObject:user.sex forKey:@"sex"];

        }
        if ([totalDic count] == 9) {
            
            
            [totalDic setObject:[NSString stringWithFormat:@"%d",isHasfirstheart] forKey:@"hasfirstheart"];
            [totalDic setObject:[NSString stringWithFormat:@"%d",isHaslowwei] forKey:@"haslowweight"];
            [totalDic setObject:[deliveryArr componentsJoinedByString:@","] forKey:@"deliverymethods"];
            [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
            [SVProgressHUD show];
//            NSLog(@"totalDic = %@",totalDic);
            [NetRequestManage babyUserRegisterWithAccountName:[[NSUserDefaults standardUserDefaults] objectForKey:@"userName"] andMenuId:_menuId andHospitalId:_hospitalId andDoctorId:_doctorId andUserRecordDic:totalDic successBlocks:^(NSData *data, NetRequestManage *babyUserRegister) {
                
                NSString *str = [[NSString alloc] initWithData:babyUserRegister.resultData encoding:NSUTF8StringEncoding];
                NSLog(@"babyUserRegister = %@",str);
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:babyUserRegister.resultData options:NSJSONReadingMutableContainers error:nil];
                if ([[dic objectForKey:@"errorId"] intValue] == 0) {
                    
                    [self loginAction];
                    
                }else{
                    
                    [SVProgressHUD dismiss];
                    CYAlertView *alert = [self.view.window viewWithTag:8888];
                    alert.hidden = NO;
                    [alert showStatus:[NSString stringWithFormat:@"%@",[dic objectForKey:@"errorId"]]];
                    [alert layoutSubviews];
                    
                }
                
                
                
                
                
                
            } andfailedBlocks:^(NSError *error, NetRequestManage *babyUserRegister) {
                
                NSLog(@"error = %@",error.localizedDescription);
                
                [SVProgressHUD showErrorWithStatus:error.localizedDescription];
                
            }];
            
        }else{
            NSLog(@"数据不全");
            CYAlertView *alert = [self.view.window viewWithTag:8888];
            alert.hidden = NO;
            [alert showStatus:@"7"];
            [alert layoutSubviews];
        }
        
    }else{
        
#pragma mark = 免费用户
        for (int i=0; i<3; i++) {
            UITextField *name = [contentView viewWithTag:1240+i];
            if (name.text.length > 0) {
                [totalDic setObject:name.text forKey:keyArray[i]];
            }else{
                break;
            }
        }
        if ([totalDic count] == 5){
            
            [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
            [SVProgressHUD show];
//            NSLog(@"totalDic = %@",totalDic);
            [NetRequestManage webUserRegisterWithAccountName:[[NSUserDefaults standardUserDefaults] objectForKey:@"userName"] andPwd:[[NSUserDefaults standardUserDefaults] objectForKey:@"pwd"] andUserRecordDic:totalDic successBlocks:^(NSData *data, NetRequestManage *webUserRegister) {
                
                NSString *str = [[NSString alloc] initWithData:webUserRegister.resultData encoding:NSUTF8StringEncoding];
                NSLog(@"webUserRegister = %@",str);
                
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:webUserRegister.resultData options:NSJSONReadingMutableContainers error:nil];
                if (([[[dic objectForKey:@"result"] objectForKey:@"isRegisterSuccess"] intValue] == 1)&&([[dic objectForKey:@"errorId"] intValue] == 0)) {
                    
                    [SVProgressHUD dismiss];
                    [self autoLoginAction];
                    
                    
                }else{
                    [SVProgressHUD dismiss];
                    CYAlertView *alert = [self.view.window viewWithTag:8888];
                    alert.hidden = NO;
                    [alert showStatus:[NSString stringWithFormat:@"%@",[dic objectForKey:@"errorId"]]];
                    [alert layoutSubviews];
                }
                
                
                
                
            } andfailedBlocks:^(NSError *error, NetRequestManage *webUserRegister) {
                
                NSLog(@"error = %@",error.localizedDescription);
                [SVProgressHUD showErrorWithStatus:error.localizedDescription];

            }];
            
        }else{
            NSLog(@"数据不全");
            CYAlertView *alert = [self.view.window viewWithTag:8888];
            alert.hidden = NO;
            [alert showStatus:@"7"];
            [alert layoutSubviews];
            
        }
        
        
        
    }
    
   
}
-(void)autoLoginAction{
    
    FirPageViewController *firpage = [[FirPageViewController alloc] init];
    firpage.isAutoLogin = YES;
    firpage.isOverTime = NO;
    
    [self presentViewController:firpage  animated:NO completion:nil];
    

}

#pragma mark - 登录
-(void)loginAction{
    
   
   
    [NetRequestManage LoginRequestAccountName:[[NSUserDefaults standardUserDefaults] objectForKey:@"userName"] andAccountPassword:[[NSUserDefaults standardUserDefaults] objectForKey:@"pwd"] successBlocks:^(NSData *data, NetRequestManage *load) {
        NSString *str = [[NSString alloc] initWithData:load.resultData encoding:NSUTF8StringEncoding];
        NSLog(@"login = %@",str);
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:load.resultData options:NSJSONReadingMutableContainers error:nil];
        LoginObject *login = [[LoginObject alloc] initWithDictionary:dic];
        
        if (login.errorId == 0) {
            
            
            [[NSUserDefaults standardUserDefaults] setObject:login.result.user.userid forKey:@"userId"];
            [[NSUserDefaults standardUserDefaults] setObject:login.result.sessionId forKey:@"sessionId"];
            NSDictionary *userDic = [[dic objectForKey:@"result"] objectForKey:@"User"];
            [[NSUserDefaults standardUserDefaults] setObject:userDic forKey:@"user"];
            
            [[NSUserDefaults standardUserDefaults] setObject:login.result.userRole forKey:@"userRole"];
            
            
            
            UIImage *headerImg = nil;
            
            if ([userDic objectForKey:@"headimg"]) {
                if ([[userDic objectForKey:@"headimg"] length] > 0) {
                    
                    headerImg = [[UIImage alloc] initWithData:[[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:[NSString urlStringOfImage:[userDic objectForKey:@"headimg"]]]]];
                    
                }else{
                    
                    if ([[userDic objectForKey:@"sex"] intValue] == 1) {
                        headerImg = [UIImage imageNamed:@"shouye_boy"];
                    }else{
                        headerImg = [UIImage imageNamed:@"shouye_girl"];
                    }
                }
            }else{
                if ([[userDic objectForKey:@"sex"] intValue] == 1) {
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
                
                
                [[NSUserDefaults standardUserDefaults] setObject:[[dic objectForKey:@"result"] objectForKey:@"needFillInRecord"] forKey:@"needFillInRecord"];
                [[NSUserDefaults standardUserDefaults] setObject:[[dic objectForKey:@"result"] objectForKey:@"needFillInFeature"] forKey:@"needFillInFeature"];
                
                NSString *now = [[NSString stringWithFormat:@"%@",[[NSDate date] dateByAddingTimeInterval:60*60*8]] substringToIndex:10];
                NSArray *tim = [Time timewithBirth:login.result.user.birthday andNow:now];
                
                NSString *nowMonth = [NSString stringWithFormat:@"%d",[tim[0] intValue]*12+[tim[1] intValue]];
//                NSLog(@"time = %@",tim);
                
                [[NSUserDefaults standardUserDefaults] setObject:nowMonth forKey:@"month"];
                [[NSUserDefaults standardUserDefaults] setObject:tim forKey:@"monthTime"];
                [self sercon];
//                if ([login.result.birthdayError intValue] == 0) {//付费用户已完善信息
//                    NSString *now = [[NSString stringWithFormat:@"%@",[[NSDate date] dateByAddingTimeInterval:60*60*8]] substringToIndex:10];
//                    NSArray *tim = [Time timewithBirth:login.result.user.birthday andNow:now];
//                    
//                    NSString *nowMonth = [NSString stringWithFormat:@"%d",[tim[0] intValue]*12+[tim[1] intValue]];
//                    NSLog(@"time = %@",tim);
//                    
//                    [[NSUserDefaults standardUserDefaults] setObject:nowMonth forKey:@"month"];
//                    [[NSUserDefaults standardUserDefaults] setObject:tim forKey:@"monthTime"];
//                    [self sercon];
//                }else if([login.result.birthdayError intValue] == 1){//付费用户未完善信息
//                    [SVProgressHUD dismiss];
//                    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
//                        
//                        FillInfoViewController *fvc = [[FillInfoViewController alloc] init];
//                        fvc.menuId = login.result.menuid;
//                        fvc.doctorId = login.result.user.doctorid;
//                        fvc.hospitalId = login.result.user.hospitalid;
//                        fvc.isLong = YES;
//                        [self presentViewController:fvc animated:YES completion:nil];
//                        
//                    }];
//                    
//                    
//                }
                
            }else if ([login.result.userRole intValue] == 0){//免费用户
                
                NSString *now = [[NSString stringWithFormat:@"%@",[[NSDate date] dateByAddingTimeInterval:60*60*8]] substringToIndex:10];
                NSArray *tim = [Time timewithBirth:login.result.user.birthday andNow:now];
                
                NSString *nowMonth = [NSString stringWithFormat:@"%d",[tim[0] intValue]*12+[tim[1] intValue]];
//                NSLog(@"time = %@",tim);
                [[NSUserDefaults standardUserDefaults] setObject:nowMonth forKey:@"month"];
                [[NSUserDefaults standardUserDefaults]setObject:tim forKey:@"monthTime"];
                [self webUserServerConfig];
                
            }
            
            
            
            
        }else{
            
            NSLog(@"errorId = %@",[dic objectForKey:@"errorId"]);
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
            
            
            
            [SVProgressHUD dismiss];
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                LeftViewController *left = [[LeftViewController alloc] init];
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
#pragma mark = 发育行为
            if ([[[dic objectForKey:@"result"] objectForKey:@"FeatureList"] isKindOfClass:[NSNull class]]) {
                
            }else{
                NSArray *featureArr = [[dic objectForKey:@"result"] objectForKey:@"FeatureList"];
                
                NSMutableDictionary *featureDic = [[NSMutableDictionary alloc] init];
                
                for (int i=0; i<featureArr.count; i++) {
                    [featureDic setObject:[featureArr objectAtIndex:i] forKey:[[featureArr objectAtIndex:i] objectForKey:@"id"]];
                }
                [[NSUserDefaults standardUserDefaults] setObject:featureDic forKey:@"featureDic"];
                
            }
            
            
            
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
#pragma mark = 新用户没填写月记录
            [[NSUserDefaults standardUserDefaults] setObject:[[dic objectForKey:@"result"] objectForKey:@"firstRecord"] forKey:@"firstRecordDic"];

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
           
            [[NSUserDefaults standardUserDefaults] setObject:[[dic objectForKey:@"result"] objectForKey:@"ShowTime"] forKey:@"ShowTime"];

            [SVProgressHUD dismiss];
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                LeftViewController *left = [[LeftViewController alloc] init];
            RickyNavViewController *nav = [[RickyNavViewController alloc] initWithRootViewController:left];
//            [self presentViewController:nav animated:YES completion:nil];
                
                [AppDelegate sharedInstance].window.rootViewController = nav;

            }];
        
        }else{
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



#pragma mark - 非数字不能键入

-(void)reformatAsPhoneNumber:(UITextField *)textField {
    NSUInteger targetCursorPostion = [textField offsetFromPosition:textField.beginningOfDocument toPosition:textField.selectedTextRange.start];
    NSString *phoneNumberWithoutSpaces = [self removeNonDigits:textField.text andPreserveCursorPosition:&targetCursorPostion];
    
    
    textField.text = phoneNumberWithoutSpaces;
    UITextPosition *targetPostion = [textField positionFromPosition:textField.beginningOfDocument offset:targetCursorPostion];
    [textField setSelectedTextRange:[textField textRangeFromPosition:targetPostion toPosition:targetPostion]];
}




- (NSString *)removeNonDigits:(NSString *)string andPreserveCursorPosition:(NSUInteger *)cursorPosition {
    NSUInteger originalCursorPosition =*cursorPosition;
    NSMutableString *digitsOnlyString = [NSMutableString new];
    
    for (NSUInteger i=0; i<string.length; i++) {
        unichar characterToAdd = [string characterAtIndex:i];
        
        if(isdigit(characterToAdd)||characterToAdd == '.') {
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
