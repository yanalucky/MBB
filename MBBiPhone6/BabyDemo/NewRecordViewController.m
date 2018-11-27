//
//  NewRecordViewController.m
//  BabyDemo
//
//  Created by 陈彦 on 16/4/5.
//  Copyright © 2016年 elsa. All rights reserved.
//


//_recordStatus

//  0新用户，1未提交，2已提交，3已发送给医生，4医生已反馈，5医生已阅读，6已跳过医生

//TimeStatus =1是提前提交   TimeStatus =0是当天提交   TimeStatus =2是延时提交



#import "NewRecordViewController.h"
#import "DataView.h"
#import "BodyLengthViewController.h"
#import "FeedViewController.h"
#import "SleepViewController.h"
#import "UIImageView+WebCache.h"
#import "LoginUser.h"
#import "FeatureViewController.h"
#import "NetRequestManage.h"
#import "CYAlertView.h"
#import "CYRecordAlertView.h"
#import "ErrorStatus.h"

#import "FirPageViewController.h"

#import "AppDelegate.h"
#import "LeftViewController.h"

#define TEXTCOLOR MBColor(101, 102, 103, 1)
#import "UMMobClick/MobClick.h"



@interface NewRecordViewController (){
    
    UIImageView *header;
    
    UIButton *_rightBtn;
    NSArray *_bringBabyDataArr;
    NSArray *_helpAddArr;
    
    LoginUser *user;
    
    UIScrollView *sc;
    
    DataView *bodyLengthView;
    DataView *bodyWeight;
    DataView *headSide;
    DataView *chest;
    
    
    UIView *lineView1;  //喂养部分
    DataView *feed;
    DataView *feedNumb;
    DataView *OtherFeed;
    DataView *otherFeedNumb;
    
    DataView *nightSleep;
    DataView *daySleep;
    DataView *defecateDay;
    DataView *defecateNum;
    DataView *urinate;
    
    
    UIButton *growUpBtn;
    
    NSMutableArray *_bringBabyKnowledge;
    NSMutableArray *_feedOther;
    
    NSString *_featurStr;
    
    
    UILabel *remindMe;
    
    
    
//    NSString *showTime;
    
    BOOL _isSure;
}

@end

@implementation NewRecordViewController
-(void)viewWillAppear:(BOOL)animated{
    NSLog(@"_featureStr = |%@|",_featurStr);

    if (self.month > 12) {
        [feed mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@(0));
        }];
        feed.button.hidden = YES;
        [feedNumb mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@(0));
        }];
        feedNumb.button.hidden = YES;
        [lineView1 mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@(122*Ratio));
        }];
    }

//    [header sd_setImageWithURL:[NSURL URLWithString:[NSString urlStringOfImage:user.headimg]]];
    NSString *path = NSHomeDirectory();
    NSString *jpgImagePath = [path stringByAppendingPathComponent:@"Documents/header.jpg"];
    header.image = [[UIImage alloc] initWithContentsOfFile:jpgImagePath];
    
//    NSArray *showTimeArr = [_showTime componentsSeparatedByString:@"-"];
//    remindMe.text = (([[[NSUserDefaults standardUserDefaults] objectForKey:@"userRole"] intValue] == 0)||(_showTime.length<9))?@"":[NSString  stringWithFormat:@"* 为了让医生准确对萌宝作出生长发育评估，请您在%@年%@月%@日准时提交萌宝的各项记录哦~",showTimeArr[0],showTimeArr[1],showTimeArr[2],(_timeStatus < 2)?@"准时":@"之前"];
//    NSLog(@"remindMe.text = %@",remindMe.text);

}

- (void)viewDidLoad {
    [super viewDidLoad];
    _isSure = NO;
    _featurStr = _recordStar.feature;
//    self.navigationController.interactivePopGestureRecognizer.delegate = nil;
    self.view.backgroundColor = MBColor(225, 253, 255, 1);
#pragma mark = 清理图片缓存
    NSDictionary *userDic = [[NSUserDefaults standardUserDefaults] objectForKey:@"user"];
    NSLog(@"userDic = %@",userDic);
    user = [[LoginUser alloc] initWithDictionary:userDic];
    
#pragma mark = 头像
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 32*Ratio, 32*Ratio)];
    header = [[UIImageView alloc] init];
    header.backgroundColor = [UIColor whiteColor];
    header.layer.masksToBounds = YES;
    header.layer.cornerRadius = 16*Ratio;
    header.layer.borderColor = MBColor(254, 193, 225, 1).CGColor;
    header.layer.borderWidth = 2;
//    [header sd_setImageWithURL:[NSURL URLWithString:[NSString urlStringOfImage:user.headimg]]  placeholderImage:([user.sex intValue] == 0)?[UIImage imageNamed:@"shouye_girl"]:[UIImage imageNamed:@"shouye_boy"]];
    
    
    NSString *path = NSHomeDirectory();
    NSString *jpgImagePath = [path stringByAppendingPathComponent:@"Documents/header.jpg"];
    header.image = [[UIImage alloc] initWithContentsOfFile:jpgImagePath];
    [headerView addSubview:header];
    [header mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(headerView);
        make.size.equalTo(headerView);
    }];
    NSLog(@"headimg = %@",[NSString urlStringOfImage:user.headimg]);
    self.navigationItem.titleView = headerView;
    
    
    
#pragma mark - 右侧按钮
    
    _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _rightBtn.frame = CGRectMake(0, 0, 39*Ratio, 20*Ratio);
    [_rightBtn setTitle:@"提交" forState:UIControlStateNormal];
    
    [_rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_rightBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
    [_rightBtn addTarget:self action:@selector(commit:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_rightBtn];
    _rightBtn.hidden = _isHiddenSubmit;
    
    
    
    
    //育儿知识的按钮文本
    _bringBabyDataArr = @[@"辅食添加",@"奶量",@"营养状况",@"体重增长",@"身长增长",@"运动能力",@"语言发展",@"社交能力",@"心理活动",@"认知发展"];
   

    //育儿知识
    
     //辅食添加的按钮文本
//    _helpAddArr = @[@"水果",@"蔬菜",@"蛋类",@"谷薯类",@"奶类及制品",@"禽类及鱼虾类",@"豆类及豆制品"];
    _helpAddArr = @[@"水果类",@"蔬菜类",@"鱼虾贝类",@"肉类(畜禽)",@"面食类(谷类)",@"蛋类",@"其他(蛋糕、饼干等)"];
    //辅食添加
    _feedOther = [[NSMutableArray alloc] init];
    
    [self createInterface];
    
    
}
-(void)createInterface{
    if ([self.view respondsToSelector:@selector(automaticallyAdjustsScrollViewInsets)]) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    sc = [[UIScrollView alloc] init];
    
    [self.view addSubview:sc];
    [sc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.left.and.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
        
    }];
    UIView *contentView = [[UIView alloc] init];
    contentView.backgroundColor = MBColor(225, 253, 255, 1);
    [sc addSubview:contentView];
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(sc);
        make.width.equalTo(sc);
    }];
#pragma mark = 生长发育
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = [UIColor whiteColor];
    [contentView addSubview:lineView];
    
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contentView);
        make.left.and.right.equalTo(contentView);
        make.height.equalTo(@(122*Ratio));
    }];
    
    
    

    UIImageView *leftView0 = [[UIImageView alloc] init];
    leftView0.image = [UIImage imageNamed:@"jilu_01"];
    [lineView addSubview:leftView0];
    [leftView0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(13.5*Ratio));
        make.top.equalTo(@(10*Ratio));
        make.size.mas_equalTo(CGSizeMake(18*Ratio, 18*Ratio));
        
    }];

    
    UILabel *title0 = [[UILabel alloc] init];

    [title0 makeLabelWithText:@"生长发育" andTextColor:TEXTCOLOR andFont:[UIFont yaHeiFontOfSize:14*Ratio]];
    
    [lineView addSubview:title0];
    [title0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(leftView0);
        make.left.equalTo(leftView0.mas_right).offset(11*Ratio);
        make.size.mas_equalTo(CGSizeMake(60*Ratio, 15*Ratio));
    }];
    
   [lineView addLineWithY:35];
    

    
    
    bodyLengthView = [[DataView alloc]init];
    
    [bodyLengthView makeViewWithTitle:@"身长" andUnit:@"cm" andNumberData:((_recordStar != nil)?_recordStar.height:@"0.00")];
    bodyLengthView.button.tag = 1101;
    bodyLengthView.button.enabled = _canChangeData;
    [bodyLengthView.button addTarget:self action:@selector(changeBodyLength:) forControlEvents:UIControlEventTouchUpInside];
    [lineView addSubview:bodyLengthView];
    [bodyLengthView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lineView).offset(43*Ratio);
        make.top.equalTo(title0.mas_bottom).offset(10*Ratio);
        make.size.mas_equalTo(CGSizeMake(128*Ratio, 43*Ratio));
    }];
    
    bodyWeight = [[DataView alloc]init];
    bodyWeight.button.tag = 1102;
    [bodyWeight makeViewWithTitle:@"体重" andUnit:@"kg" andNumberData:((_recordStar != nil)?_recordStar.weight:@"0.00")];
    bodyWeight.button.enabled = _canChangeData;
    [bodyWeight.button addTarget:self action:@selector(changeBodyLength:) forControlEvents:UIControlEventTouchUpInside];
    [lineView addSubview:bodyWeight];
    [bodyWeight mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bodyLengthView.mas_right).offset(10*Ratio);
        make.top.equalTo(title0.mas_bottom).offset(10*Ratio);
        make.size.mas_equalTo(CGSizeMake(128*Ratio, 43*Ratio));
    }];
    [lineView addLineWithY:78];
    
    headSide = [[DataView alloc]init];
    headSide.button.tag = 1103;
    headSide.button.enabled = _canChangeData;
    [headSide makeViewWithTitle:@"头围" andUnit:@"cm" andNumberData:((_recordStar != nil)?_recordStar.headcircumference:@"0.00")];
    [headSide.button addTarget:self action:@selector(changeBodyLength:) forControlEvents:UIControlEventTouchUpInside];

    [lineView addSubview:headSide];
    [headSide mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lineView).offset(43*Ratio);
        make.top.equalTo(bodyLengthView.mas_bottom).offset(Ratio);
        make.size.mas_equalTo(CGSizeMake(128*Ratio, 43*Ratio));
    }];
    
    chest = [[DataView alloc]init];
    chest.button.tag = 1104;
    chest.button.enabled = _canChangeData;
    [chest makeViewWithTitle:@"胸围" andUnit:@"cm" andNumberData:((_recordStar != nil)?_recordStar.chestcircumference:@"0.00")];
    [chest.button addTarget:self action:@selector(changeBodyLength:) forControlEvents:UIControlEventTouchUpInside];
    [lineView addSubview:chest];
    [chest mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headSide.mas_right).offset(10*Ratio);
        make.top.equalTo(bodyLengthView.mas_bottom).offset(Ratio);
        make.size.mas_equalTo(CGSizeMake(128*Ratio, 43*Ratio));
    }];
    
#pragma mark = 喂养
    
    lineView1 = [[UIView alloc] init];
    lineView1.backgroundColor = [UIColor whiteColor];
    [contentView addSubview:lineView1];
    [lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(contentView);
        make.top.equalTo(lineView.mas_bottom).offset(10*Ratio);
        make.height.equalTo(@(210*Ratio));
    }];
    
    
    
    UIImageView *leftView1 = [[UIImageView alloc] init];
    leftView1.image = [UIImage imageNamed:@"jilu_02"];
    [lineView1 addSubview:leftView1];
    [leftView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(13.5*Ratio));
        make.top.equalTo(@(10*Ratio));
        make.size.mas_equalTo(CGSizeMake(18*Ratio, 18*Ratio));
        
    }];
    
    
    UILabel *title1 = [[UILabel alloc] init];
    
    [title1 makeLabelWithText:@"喂养" andTextColor:TEXTCOLOR andFont:[UIFont yaHeiFontOfSize:14*Ratio]];
    
    [lineView1 addSubview:title1];
    [title1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(leftView1);
        make.left.equalTo(leftView1.mas_right).offset(11*Ratio);
        make.size.mas_equalTo(CGSizeMake(60*Ratio, 15*Ratio));
    }];
    
    [lineView1 addLineWithY:35];


    feed = [[DataView alloc]init];
    [feed makeViewWithTitle:@"人乳喂养量" andUnit:@"ml/次" andNumberData:((_recordStar != nil)?_recordStar.breastfeedingml:@"0")];
    feed.button.tag = 1105;
    [feed.button addTarget:self action:@selector(feedClick:) forControlEvents:UIControlEventTouchUpInside];
    feed.button.enabled = _canChangeData;
    [lineView1 addSubview:feed];
    [feed mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lineView1).offset(43*Ratio);
        make.top.equalTo(title1.mas_bottom).offset(10*Ratio);
        make.width.mas_equalTo(265*Ratio);
        make.height.mas_equalTo(43*Ratio);
    }];
    [lineView1 addLineWithY:78];
    
    feedNumb = [[DataView alloc]init];
    [feedNumb makeViewWithTitle:@"人乳喂养次数" andUnit:@"次/天" andNumberData:((_recordStar != nil)?_recordStar.breastfeedingcount:@"0")];
    feedNumb.button.tag = 1106;
    feedNumb.button.enabled = _canChangeData;
    [feedNumb.button addTarget:self action:@selector(feedClick:) forControlEvents:UIControlEventTouchUpInside];
    [lineView1 addSubview:feedNumb];
    [feedNumb mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(lineView1).offset(43*Ratio);
        make.top.equalTo(feed.mas_bottom).offset(Ratio);
        make.width.mas_equalTo(265*Ratio);
        make.height.mas_equalTo(43*Ratio);
        
    }];
    [lineView1 addLineWithY:122];
    OtherFeed = [[DataView alloc] init];
    [OtherFeed makeViewWithTitle:@"配方奶喂养量" andUnit:@"ml/次" andNumberData:((_recordStar != nil)?_recordStar.milkfeedingml:@"0")];
    OtherFeed.button.tag = 1107;
    OtherFeed.button.enabled = _canChangeData;
    [OtherFeed.button addTarget:self action:@selector(feedClick:) forControlEvents:UIControlEventTouchUpInside];
    [lineView1 addSubview:OtherFeed];
    [OtherFeed mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(lineView1).offset(43*Ratio);
        make.top.equalTo(feedNumb.mas_bottom).offset(Ratio);
        make.width.mas_equalTo(265*Ratio);
        make.height.mas_equalTo(43*Ratio);
        
    }];
    [lineView1 addLineWithY:165];
    otherFeedNumb = [[DataView alloc]init];
    [otherFeedNumb makeViewWithTitle:@"配方奶喂养次数" andUnit:@"次/天" andNumberData:((_recordStar != nil)?_recordStar.milkfeedingcount:@"0")];
    otherFeedNumb.button.tag = 1108;
    otherFeedNumb.button.enabled = _canChangeData;
    [otherFeedNumb.button addTarget:self action:@selector(feedClick:) forControlEvents:UIControlEventTouchUpInside];
    [lineView1 addSubview:otherFeedNumb];
    [otherFeedNumb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lineView1).offset(43*Ratio);
        make.top.equalTo(OtherFeed.mas_bottom).offset(Ratio);
        make.size.mas_equalTo(CGSizeMake(265*Ratio, 43*Ratio));
    }];
    
    
#pragma mark = 睡眠及排便、排尿
    UIView *lineView2 = [[UIView alloc] init];
    lineView2.backgroundColor = [UIColor whiteColor];
    [contentView addSubview:lineView2];
    [lineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(contentView);
        make.top.equalTo(lineView1.mas_bottom).offset(10*Ratio);
        make.height.equalTo(@(174*Ratio));
    }];
    
    nightSleep = [[DataView alloc] init];
    [nightSleep makeViewWithTitle:@"夜间睡眠" andUnit:@"h/天" andNumberData:((_recordStar != nil)?_recordStar.nighttimesleep:@"0")];
    nightSleep.button.tag = 1109;
    nightSleep.button.enabled = _canChangeData;
    [nightSleep.button addTarget:self action:@selector(changeSleepTime:) forControlEvents:UIControlEventTouchUpInside];
    
    [lineView2 addSubview:nightSleep];
    
    [nightSleep mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lineView2).offset(43*Ratio);
        make.top.equalTo(lineView2);
        make.size.mas_equalTo(CGSizeMake(265*Ratio, 43*Ratio));
    }];
    UIImageView *leftView2 = [[UIImageView alloc] init];
    leftView2.image = [UIImage imageNamed:@"jilu_03"];
    [lineView2 addSubview:leftView2];
    [leftView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(13.5*Ratio));
        make.centerY.equalTo(nightSleep);
        make.size.mas_equalTo(CGSizeMake(18*Ratio, 18*Ratio));
        
    }];
    [lineView2 addLineWithY:43];
    daySleep = [[DataView alloc] init];
    
    daySleep.button.tag = 1110;
    [daySleep.button addTarget:self action:@selector(changeSleepTime:) forControlEvents:UIControlEventTouchUpInside];
    daySleep.button.enabled = _canChangeData;
    [daySleep makeViewWithTitle:@"日间睡眠" andUnit:@"h/天" andNumberData:((_recordStar != nil)?_recordStar.daytimesleep:@"0")];
    [lineView2 addSubview:daySleep];
    [daySleep mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lineView2).offset(43*Ratio);
        make.top.equalTo(nightSleep.mas_bottom).offset(Ratio);
        make.size.mas_equalTo(CGSizeMake(265*Ratio, 43*Ratio));
    }];
    UIImageView *leftView3 = [[UIImageView alloc] init];
    leftView3.image = [UIImage imageNamed:@"jilu_04"];
    [lineView2 addSubview:leftView3];
    [leftView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(13.5*Ratio));
        make.centerY.equalTo(daySleep);
        make.size.mas_equalTo(CGSizeMake(18*Ratio, 18*Ratio));
        
    }];
    [lineView2 addLineWithY:86];
    defecateDay = [[DataView alloc] init];
    defecateDay.button.tag = 1111;
    [defecateDay makeViewWithTitle:@"排便" andUnit:@"天" andNumberData:((_recordStar != nil)?_recordStar.cacationdays:@"0")];
    [defecateDay.button addTarget:self action:@selector(changeSleepTime:) forControlEvents:UIControlEventTouchUpInside];
    defecateDay.button.enabled = _canChangeData;
    
    [lineView2 addSubview:defecateDay];
    [defecateDay mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lineView2).offset(43*Ratio);
        make.top.equalTo(daySleep.mas_bottom).offset(Ratio);
        make.size.mas_equalTo(CGSizeMake(175*Ratio, 43*Ratio));
    }];
    defecateNum = [[DataView alloc] init];
    defecateNum.button.tag = 1112;
    defecateNum.button.enabled = _canChangeData;
    [defecateNum makeViewWithTitle:nil andUnit:@"次" andNumberData:((_recordStar != nil)?_recordStar.cacation:@"0")];
    [defecateNum.button addTarget:self action:@selector(changeSleepTime:) forControlEvents:UIControlEventTouchUpInside];

    
    [lineView2 addSubview:defecateNum];
    [defecateNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(defecateDay.mas_right).offset(Ratio);
        make.top.equalTo(daySleep.mas_bottom).offset(Ratio);
        make.size.mas_equalTo(CGSizeMake(90*Ratio, 43*Ratio));
    }];
    UIImageView *leftView4 = [[UIImageView alloc] init];
    leftView4.image = [UIImage imageNamed:@"jilu_05"];
    [lineView2 addSubview:leftView4];
    [leftView4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(13.5*Ratio));
        make.centerY.equalTo(defecateDay);
        make.size.mas_equalTo(CGSizeMake(18*Ratio, 18*Ratio));
        
    }];
    
    [lineView2 addLineWithY:86+43];
    urinate = [[DataView alloc] init];
    urinate.button.tag = 1113;
    [urinate makeViewWithTitle:@"排尿" andUnit:@"次/天" andNumberData:((_recordStar != nil)?_recordStar.urinate:@"0")];
    [urinate.button addTarget:self action:@selector(changeSleepTime:) forControlEvents:UIControlEventTouchUpInside];
    urinate.button.enabled = _canChangeData;
    [lineView2 addSubview:urinate];
    [urinate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lineView2).offset(43*Ratio);
        make.top.equalTo(defecateDay.mas_bottom).offset(Ratio);
        make.size.mas_equalTo(CGSizeMake(265*Ratio, 43*Ratio));
    }];
    UIImageView *leftView5 = [[UIImageView alloc] init];
    leftView5.image = [UIImage imageNamed:@"jilu_06"];
    [lineView2 addSubview:leftView5];
    [leftView5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(13.5*Ratio));
        make.centerY.equalTo(urinate);
        make.size.mas_equalTo(CGSizeMake(18*Ratio, 18*Ratio));
        
    }];
    
    
    
#pragma mark = 发育行为观察
    UIButton *growUp = [UIButton buttonWithType:UIButtonTypeCustom];
    
    growUp.backgroundColor = [UIColor whiteColor];
    [growUp addTarget:self action:@selector(growUpAction:) forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview:growUp];
    [growUp mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(contentView);
        make.top.equalTo(lineView2.mas_bottom).offset(10*Ratio);
        make.height.equalTo(@(43*Ratio));
    }];
    UIImageView *leftView6 = [[UIImageView alloc] init];
    leftView6.image = [UIImage imageNamed:@"jilu_07"];
    [growUp addSubview:leftView6];
    [leftView6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(13.5*Ratio));
        make.centerY.equalTo(growUp);
        make.size.mas_equalTo(CGSizeMake(18*Ratio, 18*Ratio));
        
    }];
    [growUp addSubview:leftView6];
    [leftView6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(13.5*Ratio));
        make.centerY.equalTo(growUp);
        make.size.mas_equalTo(CGSizeMake(18*Ratio, 18*Ratio));
        
    }];
    UILabel *growUpTitle = [[UILabel alloc] init];
    [growUpTitle makeLabelWithText:@"发育行为观察" andTextColor:TEXTCOLOR andFont:[UIFont yaHeiFontOfSize:14*Ratio]];
    [growUp addSubview:growUpTitle];
    [growUpTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(growUp).offset(43*Ratio);
        make.centerY.equalTo(growUp);
        make.size.mas_equalTo(CGSizeMake(90*Ratio, 15*Ratio));
    }];
    
    growUpBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [growUpBtn setBackgroundImage:[UIImage imageNamed:@"jilu_fayu"] forState:UIControlStateNormal];
    [growUpBtn setBackgroundImage:[UIImage imageNamed:@"jilu_fayu_set"] forState:UIControlStateSelected];
    [growUpBtn addTarget:self action:@selector(growUpAction:) forControlEvents:UIControlEventTouchUpInside];
    [growUp addSubview:growUpBtn];
    [growUpBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(growUp).offset(-15*Ratio);
        make.centerY.equalTo(growUp);
        make.size.mas_equalTo(CGSizeMake(20*Ratio, 20*Ratio));
    }];
    
    if ((_canChangeData == NO)&&(_featurStr.length > 0)) {
        growUpBtn.selected = YES;
    }
#pragma mark = 育儿知识
    
   
    UIView *bringBaby = [[UIView alloc] init];
    bringBaby.backgroundColor = [UIColor whiteColor];
    [contentView addSubview:bringBaby];
    [bringBaby mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(contentView);
        make.top.equalTo(growUp.mas_bottom).offset(10*Ratio);
        make.height.equalTo(@(137*Ratio));
    }];
    UIImageView *leftView7 = [[UIImageView alloc] init];
    leftView7.image = [UIImage imageNamed:@"jilu_08"];
    [bringBaby addSubview:leftView7];
    [leftView7 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(13.5*Ratio));
        make.top.equalTo(bringBaby).offset(14*Ratio);
        make.size.mas_equalTo(CGSizeMake(18*Ratio, 18*Ratio));
        
    }];
    UILabel *bringBabyTitle = [[UILabel alloc] init];
    [bringBabyTitle makeLabelWithText:@"请选择本月您最想与医生交流的育儿问题" andTextColor:MBColor(103, 103, 103, 1) andFont:[UIFont yaHeiFontOfSize:13*Ratio]];
    [bringBaby addSubview:bringBabyTitle];
    [bringBabyTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bringBaby).offset(43*Ratio);
        make.centerY.equalTo(leftView7);
        make.size.mas_equalTo(CGSizeMake(300*Ratio, 15*Ratio));
    }];
    //用来记录宽度
    CGFloat width = 20 * Ratio;
    //用来记录高度
    CGFloat hight = 39 * Ratio;
    //横着的button之间的间隔
    CGFloat Hspace = 10 * Ratio;
    //竖直方向上的button的间隔
    CGFloat Vspace = 10 * Ratio;
    //记录行数(你的奇数行和偶数行的第一个button离左边的距离不一样)
    int line = 0;
    NSLog(@"_recordStar.questionid = %@",_recordStar);
    if (_recordStar.questionid.length > 0){
        NSArray *bringCurrentArr = [_recordStar.questionid componentsSeparatedByString:@","];
        
        _bringBabyKnowledge = [NSMutableArray arrayWithArray:bringCurrentArr];
        
        
    }else{
         _bringBabyKnowledge = [[NSMutableArray alloc] init];
    }
//    NSArray *bringCurrentArr = [_recordStar.questionid componentsSeparatedByString:@","];
//    _bringBabyKnowledge = [NSMutableArray arrayWithArray:bringCurrentArr];
    for (int i = 0; i < _bringBabyDataArr.count; i++) {
        
        
        
        
        UIButton *bringBabyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        bringBabyBtn.layer.masksToBounds = YES;
        bringBabyBtn.layer.cornerRadius = 10;
        bringBabyBtn.layer.borderColor = MBColor(239, 239, 239, 1).CGColor;
        bringBabyBtn.layer.borderWidth = 1*Ratio;
        [bringBabyBtn setBackgroundColor:[UIColor lightTextColor]];

        [bringBabyBtn setTitleColor:MBColor(121, 122, 123, 1) forState:UIControlStateNormal];
        [bringBabyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [bringBabyBtn setTitle:_bringBabyDataArr[i] forState:UIControlStateNormal];
        bringBabyBtn.titleLabel.font = [UIFont yaHeiFontOfSize:11*Ratio];
        bringBabyBtn.tag = 1120+i;
        NSString *bringStr = [NSString stringWithFormat:@"%d",i+1];
        if ([_bringBabyKnowledge containsObject:bringStr]) {
            bringBabyBtn.selected = YES;
            bringBabyBtn.backgroundColor = [UIColor colorWithRed:241/255.0 green:62/255.0 blue:153/255.0 alpha:1];

        }
        [bringBabyBtn addTarget:self action:@selector(BringBabyClick:) forControlEvents:UIControlEventTouchUpInside];
        [bringBaby addSubview:bringBabyBtn];
        //button的宽度
        CGFloat buttonWidth = ([bringBabyBtn sizeThatFits:CGSizeMake(200, 22)].width + 10)*Ratio;
        //单当前的宽度+按钮的宽度+间隔 > 屏幕的宽度的时候  说明 换行
        if((width + buttonWidth + Hspace) > self.view.bounds.size.width){
            
            
            if(line%2 == 1){
                
                //当奇数行的时候 离左边为20
                width = 20 * Ratio;
            }else{
                
                //当偶数行的时候 离左边为40
                width = 40 * Ratio;
            }
            
            //行数++
            line++;
            //高度++
            hight = hight+Vspace+(22*Ratio);
        }
        
        //设置按钮的位置
//        button.frame = CGRectMake(width, hight, buttonWidth, 50);
        [bringBabyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(bringBaby).offset(width);
            make.top.equalTo(bringBaby).offset(hight);
            make.size.mas_equalTo(CGSizeMake(buttonWidth, (22*Ratio)));
        }];
        
        //设置记录当前行的已经排布按钮的宽度
        width = width+buttonWidth+Hspace;
        
    }

#pragma mark = 辅食添加
    
    
    NSArray *feedOtherOldArr = nil;
    if (_recordStar != nil) {
        
        if (_recordStar.complementarytype&&_recordStar.complementarytype.length > 0) {
            
            feedOtherOldArr = [_recordStar.complementarytype componentsSeparatedByString:@","];
        }
    }
    UIView *helpAdd = [[UIView alloc] init];
    helpAdd.backgroundColor = [UIColor whiteColor];
    [contentView addSubview:helpAdd];
    [helpAdd mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(contentView);
        make.top.equalTo(bringBaby.mas_bottom).offset(10*Ratio);
        make.height.equalTo(@(121*Ratio));
    }];
    UIImageView *leftView8 = [[UIImageView alloc] init];
    leftView8.image = [UIImage imageNamed:@"jilu_09"];
    [helpAdd addSubview:leftView8];
    [leftView8 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(13.5*Ratio));
        make.top.equalTo(helpAdd).offset(14*Ratio);
        make.size.mas_equalTo(CGSizeMake(18*Ratio, 18*Ratio));
        
    }];
    UILabel *helpAddTitle = [[UILabel alloc] init];
    [helpAddTitle makeLabelWithText:@"辅食添加" andTextColor:MBColor(103, 103, 103, 1) andFont:[UIFont yaHeiFontOfSize:13*Ratio]];
    [helpAdd addSubview:helpAddTitle];
    [helpAddTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(helpAdd).offset(43*Ratio);
        make.centerY.equalTo(leftView8);
        make.size.mas_equalTo(CGSizeMake(300*Ratio, 15*Ratio));
    }];
    
    UILabel *helpAddTitle1 = [[UILabel alloc] init];
    [helpAddTitle1 makeLabelWithText:@"请选择本月给萌宝添加的辅食类别" andTextColor:MBColor(151, 152, 153, 1) andFont:[UIFont yaHeiFontOfSize:9*Ratio]];
    [helpAdd addSubview:helpAddTitle1];
    [helpAddTitle1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(helpAdd).offset(43*Ratio);
        make.top.equalTo(helpAddTitle.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(300*Ratio, 15*Ratio));
    }];
    
    
    //用来记录宽度
    width = 20 * Ratio;
    //用来记录高度 1.0.0  == 39
    hight = 55 * Ratio;
    //横着的button之间的间隔
    Hspace = 8 * Ratio;
    //竖直方向上的button的间隔
    Vspace = 10 * Ratio;
    //记录行数(你的奇数行和偶数行的第一个button离左边的距离不一样)
    line = 0;
    if (_recordStar.complementarytype.length > 0) {
        NSArray *helpAddCurrentArr = [_recordStar.complementarytype componentsSeparatedByString:@","];
        _feedOther = [NSMutableArray arrayWithArray:helpAddCurrentArr];
    }else{
        _feedOther = [[NSMutableArray alloc] init];
    }
    

    for (int i = 0; i < _helpAddArr.count; i++) {
        
        
        
        
        UIButton *helpAddBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        helpAddBtn.layer.masksToBounds = YES;
        helpAddBtn.layer.cornerRadius = 10;
        helpAddBtn.layer.borderColor = MBColor(239, 239, 239, 1).CGColor;
        helpAddBtn.layer.borderWidth = 1*Ratio;
        [helpAddBtn setBackgroundColor:[UIColor lightTextColor]];
        NSString *helpStr = [NSString stringWithFormat:@"%d",i+1];
        if ([_feedOther containsObject:helpStr]) {
            helpAddBtn.selected = YES;
            helpAddBtn.backgroundColor = [UIColor colorWithRed:241/255.0 green:62/255.0 blue:153/255.0 alpha:1];
            
        }
        [helpAddBtn setTitleColor:MBColor(121, 122, 123, 1) forState:UIControlStateNormal];
        [helpAddBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [helpAddBtn setTitle:_helpAddArr[i] forState:UIControlStateNormal];
        helpAddBtn.tag = 1140+i;
        helpAddBtn.titleLabel.font = [UIFont yaHeiFontOfSize:11*Ratio];

        NSString *bringStr = [NSString stringWithFormat:@"%d",i+1];

        if ([_feedOther containsObject:bringStr]) {
            helpAddBtn.selected = YES;
            helpAddBtn.backgroundColor = [UIColor colorWithRed:241/255.0 green:62/255.0 blue:153/255.0 alpha:1];
            
        }
//        for (NSString *num in feedOtherOldArr) {
//            if ([num intValue] == (i+1)) {
//                helpAddBtn.selected = YES;
//            }
//        }
        [helpAddBtn addTarget:self action:@selector(feedOtherClick:) forControlEvents:UIControlEventTouchUpInside];
        [helpAdd addSubview:helpAddBtn];
        //button的宽度
        CGFloat buttonWidth = ([helpAddBtn sizeThatFits:CGSizeMake(200, 22)].width + 10)*Ratio;
        //单当前的宽度+按钮的宽度+间隔 > 屏幕的宽度的时候  说明 换行
        if((width + buttonWidth + Hspace) > self.view.bounds.size.width){
            
            
            width = 20 * Ratio;
            
            //行数++
            line++;
            //高度++
            hight = hight+Vspace+(22*Ratio);
            Hspace = 8 * Ratio;
        }
        
        
        //设置按钮的位置
        //        button.frame = CGRectMake(width, hight, buttonWidth, 50);
        [helpAddBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(helpAdd).offset(width);
            make.top.equalTo(helpAdd).offset(hight);
            make.size.mas_equalTo(CGSizeMake(buttonWidth, (22*Ratio)));
        }];
        
        //设置记录当前行的已经排布按钮的宽度
        width = width+buttonWidth+Hspace;
        
    }
    
#pragma mark = 提醒
    remindMe = [[UILabel alloc] init];
    

    NSString *buttonText = nil;
    if (_showTime) {
        if ([_showTime  isEqualToString:@"0"]) {
            buttonText = @"线上提交服务结束";
        }else if(_showTime.length > 9){
            
            NSArray *showTimeArr = [_showTime componentsSeparatedByString:@"-"];
            buttonText = [NSString  stringWithFormat:@"* 为了让医生准确对萌宝作出生长发育评估，请您在%@年%@月%@日%@提交萌宝的各项记录哦~",showTimeArr[0],showTimeArr[1],showTimeArr[2],(_timeStatus < 2)?@"准时":@"之前"];
        }
    }
    

    NSString *serrfef = ([[[NSUserDefaults standardUserDefaults] objectForKey:@"userRole"] intValue] == 0)?@"":buttonText;
    
    [remindMe makeLabelWithText:serrfef andTextColor:MBColor(121, 122, 123, 1) andFont:[UIFont yaHeiFontOfSize:11*Ratio]];
    if (([[[NSUserDefaults standardUserDefaults] objectForKey:@"userRole"] intValue] != 0)&&buttonText) {
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:remindMe.text];;
        [attributedString addAttribute:NSForegroundColorAttributeName value:MBColor(250, 109, 166, 1) range:NSMakeRange(24,11)];
    
        [attributedString addAttribute:NSFontAttributeName value:[UIFont yaHeiFontOfSize:13*Ratio] range:NSMakeRange(24,11)];
        remindMe.attributedText = attributedString;
    }
    
    remindMe.numberOfLines = 0;
    [contentView addSubview:remindMe];
    [remindMe mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(helpAdd.mas_bottom).offset(10*Ratio);
        make.left.equalTo(contentView).offset(16*Ratio);
        make.right.equalTo(contentView).offset(-16*Ratio);
        make.height.equalTo(@(45*Ratio));
    }];
  
    
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(remindMe).offset((88+25)*Ratio);
    }];
    
    
    
    
}
#pragma mark - 生长发育
-(void)changeBodyLength:(UIButton *)button{
//    button.selected = YES;
    
    BodyLengthViewController *bodyLen = [[BodyLengthViewController alloc] initWithSex:[user.sex boolValue] andName:(int)button.tag - 1100];
    bodyLen.month = ((_month - 1) < 0)?0:(_month - 1);
    bodyLen.data = [button.titleLabel.text floatValue];
    [bodyLen changeDataBlock:^(NSString *number) {
        button.selected = YES;
        [button setTitle:number forState:UIControlStateSelected];
        [button setTitle:number forState:UIControlStateNormal];
        
    }];
    [self.navigationController pushViewController:bodyLen animated:YES];

}
#pragma mark - 喂养
-(void)feedClick:(UIButton *)button{

    FeedViewController *feedVC = [[FeedViewController alloc] initWithMonth:((_month - 1) < 0)?0:(_month - 1) andName:(int)(button.tag - 1104)/2+1];
    if (button.tag == 1105||button.tag == 1106) {
        feedVC.data = [feed.button.titleLabel.text intValue];
        feedVC.data1 = [feedNumb.button.titleLabel.text intValue];
        feedVC.name = 1;
    }else{
        feedVC.data = [OtherFeed.button.titleLabel.text intValue];
        feedVC.data1 = [otherFeedNumb.button.titleLabel.text intValue];
        feedVC.name = 2;
    }
    [feedVC changeDataBlock:^(NSString *number0, NSString *number1) {
        if (button.tag <= 1106) {
            feed.button.selected = YES;
            feedNumb.button.selected = YES;
            [feed.button setTitle:number0 forState:UIControlStateSelected];
            [feed.button setTitle:number0 forState:UIControlStateNormal];
            
            [feedNumb.button setTitle:number1 forState:UIControlStateSelected];
            [feedNumb.button setTitle:number1 forState:UIControlStateNormal];
        }else{
            OtherFeed.button.selected = YES;
            otherFeedNumb.button.selected = YES;
            [OtherFeed.button setTitle:number0 forState:UIControlStateSelected];
            [OtherFeed.button setTitle:number0 forState:UIControlStateNormal];
            
            [otherFeedNumb.button setTitle:number1 forState:UIControlStateSelected];
            [otherFeedNumb.button setTitle:number1 forState:UIControlStateNormal];
        }
    }];
    [self.navigationController pushViewController:feedVC animated:YES];

    
}
#pragma mark - 睡眠

-(void)changeSleepTime:(UIButton *)button{
    
    SleepViewController *bodyLen = [[SleepViewController alloc] initWithMonth:((_month - 1) < 0)?0:(_month - 1) andName:(int)button.tag - 1108];
    if (button.tag == 1111||button.tag == 1112) {
        bodyLen.data = defecateDay.button.titleLabel.text;
        bodyLen.data1 = defecateNum.button.titleLabel.text;
    }else{
        bodyLen.data = button.titleLabel.text;
        bodyLen.data1 = @"";
    }
    
    [bodyLen changeDataBlock:^(BOOL _isDefecate, NSString *number0, NSString *number1) {
        if (_isDefecate == YES) {
            defecateDay.button.selected = YES;
            defecateNum.button.selected = YES;
            [defecateDay.button setTitle:number0 forState:UIControlStateSelected];
            [defecateDay.button setTitle:number0 forState:UIControlStateNormal];

            [defecateNum.button setTitle:number1 forState:UIControlStateSelected];
            [defecateNum.button setTitle:number1 forState:UIControlStateNormal];
        }else{
            button.selected = YES;
            [button setTitle:number0 forState:UIControlStateSelected];
            [button setTitle:number0 forState:UIControlStateNormal];
        }
    }];
    [self.navigationController pushViewController:bodyLen animated:YES];
}


#pragma mark - 发育行为观察

-(void)growUpAction:(UIButton *)button{
    FeatureViewController *fvc = [[FeatureViewController alloc] init];
    fvc.isHiddenSubmit = _isHiddenSubmit;
    fvc.canChangeData = _canChangeData;
    if (_featurStr.length > 0) {
        fvc.oldFeatureDataArr = [[_featurStr componentsSeparatedByString:@","] mutableCopy];
    }
    
    NSArray *featureArr = [[NSUserDefaults standardUserDefaults] objectForKey:@"featureByAgeArr"];
    [fvc selectFeatureBlock:^(NSString *featureString) {
        _featurStr = featureString;
        
        NSArray *temp = [_featurStr componentsSeparatedByString:@","];
        NSLog(@"temp.count =%lu featureArr.countt =%lu",(unsigned long)temp.count,(unsigned long)featureArr.count);
        if (temp.count == featureArr.count) {
            growUpBtn.selected = YES;
        }else{
            growUpBtn.selected = NO;
        }
        
    }];
    
    [self.navigationController pushViewController:fvc animated:YES];
}
#pragma mark - 育儿知识
-(void)BringBabyClick:(UIButton *)button{
    button.selected = !button.selected;
    if (button.selected) {
        button.backgroundColor = [UIColor colorWithRed:241/255.0 green:62/255.0 blue:153/255.0 alpha:1];
    }else{
        button.backgroundColor = [UIColor whiteColor];
    }
    NSString *str = [NSString stringWithFormat:@"%d",(int)button.tag - 1119];
    if ([_bringBabyKnowledge containsObject:str]) {
        [_bringBabyKnowledge removeObject:str];
    }else{
        [_bringBabyKnowledge addObject:str];
    }
}
#pragma mark - 辅食添加
-(void)feedOtherClick:(UIButton *)button{
    button.selected = !button.selected;
    if (button.selected) {
        button.backgroundColor = [UIColor colorWithRed:241/255.0 green:62/255.0 blue:153/255.0 alpha:1];
    }else{
        button.backgroundColor = [UIColor whiteColor];
    }
    NSString *str = [NSString stringWithFormat:@"%d",(int)button.tag - 1139];
    if ([_feedOther containsObject:str]) {
        [_feedOther removeObject:str];
    }else{
        [_feedOther addObject:str];
    }
}

#pragma mark - 提交按钮

-(void)commit:(UIButton *)button{
    UIView *ciew = [self.view.window viewWithTag:6666];
    ciew.hidden = YES;
    [self.view.window sendSubviewToBack:ciew];
    NSLog(@"点击");
    NSString *userRoleStr = [[NSUserDefaults standardUserDefaults] objectForKey:@"userRole"];
    NSMutableDictionary *userRecordDic = [[NSMutableDictionary alloc] init];
    
    if ([userRoleStr intValue] != 0) {
        [userRecordDic setObject:_theLastRecordStr forKey:@"recordId"];
    }
    
    [userRecordDic setObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"userId"] forKey:@"userId"];
    [userRecordDic setObject:bodyLengthView.button.titleLabel.text forKey:@"height"];
    [userRecordDic setObject:bodyWeight.button.titleLabel.text forKey:@"weight"];
    [userRecordDic setObject:headSide.button.titleLabel.text forKey:@"headCircumference"];
    [userRecordDic setObject:chest.button.titleLabel.text forKey:@"chestCircumference"];

    if (_month > 12) {
        [userRecordDic setObject:@"0" forKey:@"breastFeedingMl"];
        [userRecordDic setObject:@"0" forKey:@"breastFeedingCount"];
    }else{
        [userRecordDic setObject:feed.button.titleLabel.text forKey:@"breastFeedingMl"];
        [userRecordDic setObject:feedNumb.button.titleLabel.text forKey:@"breastFeedingCount"];
    }
    
    if ([userRoleStr intValue] != 0) {
        if(_featurStr){
            [userRecordDic setObject:_featurStr forKey:@"feature"];

        }else{
            [userRecordDic setObject:@"" forKey:@"feature"];

        }
    }
    
    [userRecordDic setObject:OtherFeed.button.titleLabel.text forKey:@"milkFeedingMl"];
    [userRecordDic setObject:otherFeedNumb.button.titleLabel.text forKey:@"milkFeedingCount"];
    [userRecordDic setObject:nightSleep.button.titleLabel.text forKey:@"nighttimeSleep"];
    [userRecordDic setObject:daySleep.button.titleLabel.text forKey:@"daytimeSleep"];
    [userRecordDic setObject:defecateDay.button.titleLabel.text forKey:@"cacationDays"];
    [userRecordDic setObject:defecateNum.button.titleLabel.text forKey:@"cacation"];
    [userRecordDic setObject:urinate.button.titleLabel.text forKey:@"urinate"];


    NSLog(@"_bringBabyKnowledge = %@",_bringBabyKnowledge);
    NSLog(@"_feedOther = %@",_feedOther);
    [userRecordDic setObject:[_bringBabyKnowledge componentsJoinedByString:@","] forKey:@"questionId"];
    [userRecordDic setObject:[_feedOther componentsJoinedByString:@","] forKey:@"complementaryType"];
    
    [userRecordDic setObject:@"" forKey:@"other"];

    if ([bodyLengthView.button.titleLabel.text intValue] != 0 &&[bodyWeight.button.titleLabel.text intValue] != 0) {
        
        
        if (([[userRecordDic objectForKey:@"feature"] length] == 0)&&([userRoleStr intValue] != 0)&&(_isSure == NO)) {
            
            
            [self showAlertView:@"*您没有勾选“发育行为观察”，请确认。"];
            
            return ;
        }
        NSLog(@"userRecordDic = %@",userRecordDic);
        [NetRequestManage submitMonthRecordWithUserRole:userRoleStr andUserRecordDic:userRecordDic successBlocks:^(NSData *data, NetRequestManage *submitMonthRecord) {
            
            NSString *str = [[NSString alloc] initWithData:submitMonthRecord.resultData encoding:NSUTF8StringEncoding];
            NSLog(@"submitMonthRecord = %@",str);
            NSDictionary *submitDic = [NSJSONSerialization JSONObjectWithData:submitMonthRecord.resultData options:NSJSONReadingMutableContainers error:nil];
            if ([[submitDic objectForKey:@"errorId"] intValue] == 0) {
                
                
                [MobClick event:@"submitRecord"];
                
                //已提交 可补足数据
                
//                [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:[NSString stringWithFormat:@"%@_%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"userId"],@"canAdd"]];

                if ([[NSUserDefaults standardUserDefaults] objectForKey:@"needFillInRecord"]) {
                    if (![[[NSUserDefaults standardUserDefaults] objectForKey:@"needFillInRecord"] isKindOfClass:[NSNull class]]) {
                        if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"needFillInRecord"] intValue] == 1) {
                            [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"needFillInRecord"];
                        }
                    }
                }
                
                if ([[NSUserDefaults standardUserDefaults] objectForKey:@"needFillInFeature"]) {
                    if (![[[NSUserDefaults standardUserDefaults] objectForKey:@"needFillInFeature"] isKindOfClass:[NSNull class]]) {
                        if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"needFillInFeature"] intValue] == 1) {
                            [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"needFillInFeature"];
                        }
                    }
                }
                
                CYRecordAlertView *alert = [self.view.window viewWithTag:9999];
                
//                NSString *newTag = [[submitDic objectForKey:@"result"] objectForKey:@"NewTag"];
                NSString *timeStatusStr = [[submitDic objectForKey:@"result"] objectForKey:@"TimeStatus"];
                
                if ([userRoleStr intValue] == 0) {
                    [alert alertViewWith:nil andDetailTitle:@"提交成功"  andButtonTitle:@"0"];
                }else{
                    if ([_recordStatus  intValue] == 0) {
                        [alert alertViewWith:@"提交成功！" andDetailTitle:@"请在一周后查看评估报告及养育指导！"  andButtonTitle:@"0"];

                    }else if([_recordStatus intValue] < 3){
                        if ([timeStatusStr intValue] == 0) {
                            [alert alertViewWith:@"提交成功！" andDetailTitle:@"请在一周后查看评估报告及养育指导！"  andButtonTitle:@"0"];
                        }else{
                            
                            
                            NSString *nextTimeStr = [[submitDic objectForKey:@"result"] objectForKey:@"NextTime"];
                            NSArray *nextTimeArr = [nextTimeStr componentsSeparatedByString:@"-"];
                           
                            [alert alertViewWith:@"提交成功！" andDetailTitle:[NSString  stringWithFormat:@"* 为了让医生准确对萌宝作出生长发育评估，请您在%@年%@月%@日准时提交萌宝的各项记录哦~",nextTimeArr[0],nextTimeArr[1],nextTimeArr[2]]  andButtonTitle:@"0"];
                        }
                    }else if ([_recordStatus intValue] == 3){
                        [alert alertViewWith:@"提交成功！" andDetailTitle:@"请在一周后查看评估报告及养育指导！"  andButtonTitle:@"0"];

                    }else{
                        [alert alertViewWith:nil andDetailTitle:@"提交成功"  andButtonTitle:@"0"];
                    }
                       
                   
                }
                
                [alert layoutSubviews];
                _recordStatus = [[submitDic objectForKey:@"result"] objectForKey:@"RecordStatus"];

                alert.clickBlocks = ^(void){
                    
                    [self.navigationController popViewControllerAnimated:YES];
                };
                
                
            }else{
                
                CYRecordAlertView *alert = [self.view.window viewWithTag:9999];
                [alert alertViewWith:@"错误！" andDetailTitle:[ErrorStatus errorStatus:[NSString stringWithFormat:@"%@",[submitDic objectForKey:@"errorId"]]]  andButtonTitle:@"0"];
                [alert layoutSubviews];
                
                
                if ([[submitDic objectForKey:@"errorId"] intValue] == -900) {
                    alert.clickBlocks = ^(void){
                        
                        FirPageViewController *firpage = [[FirPageViewController alloc] init];
                        firpage.isAutoLogin = YES;
                        firpage.isOverTime = YES;

                        [AppDelegate sharedInstance].window.rootViewController = firpage;
                        
                    };
                }
                

            }
            
            
        } andfailedBlocks:^(NSError *error, NetRequestManage *submitMonthRecord) {
            
            NSLog(@"submitMonthRecordError = %@",error.localizedDescription);
        }];
    }else{
        CYRecordAlertView *alert = [self.view.window viewWithTag:9999];
        
        [alert alertViewWith:@"提示！" andDetailTitle:@"宝妈，记录没填全哦 ？！"  andButtonTitle:@"0"];
        [alert layoutSubviews];
    }
    
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    _rightBtn.enabled = YES;
    
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
    [continueBtn setTitle:@"返回勾选" forState:UIControlStateNormal];
    [continueBtn addTarget:self action:@selector(continueAction:) forControlEvents:UIControlEventTouchUpInside];
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
    [cancelBtn setTitle:@"继续提交" forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(cancelBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    cancelBtn.titleLabel.font = [UIFont yaHeiFontOfSize:16*Ratio];
    [alert addSubview:cancelBtn];
    [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(121*Ratio, 38*Ratio));
        make.right.equalTo(alert);
        make.top.equalTo(titlLabel.mas_bottom);
        
    }];
    
    
    [self.view.window bringSubviewToFront:ciew];
    
    
}

-(void)cancelBtnAction:(UIButton *)button{
    
//    UIView *ciew = [self.view.window viewWithTag:6666];
//    ciew.hidden = YES;
//    [self.view.window sendSubviewToBack:ciew];
    _isSure = YES;
    [self commit:nil];
    
    
}

-(void)continueAction:(UIButton *)button{
    
    UIView *ciew = [self.view.window viewWithTag:6666];
    ciew.hidden = YES;
    [self.view.window sendSubviewToBack:ciew];
    
    FeatureViewController *fvc = [[FeatureViewController alloc] init];
    fvc.isHiddenSubmit = _isHiddenSubmit;
    fvc.canChangeData = _canChangeData;
    NSArray *featureArr = [[NSUserDefaults standardUserDefaults] objectForKey:@"featureByAgeArr"];
    
    if (_featurStr.length > 0) {
        fvc.oldFeatureDataArr = [[_featurStr componentsSeparatedByString:@","] mutableCopy];
    }
    
    [fvc selectFeatureBlock:^(NSString *featureString) {
        _featurStr = featureString;
        
        NSArray *temp = [_featurStr componentsSeparatedByString:@","];
        if (temp.count == featureArr.count) {
            growUpBtn.selected = YES;
        }else{
            growUpBtn.selected = NO;
        }
        
    }];
    
    [self.navigationController pushViewController:fvc animated:YES];
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
