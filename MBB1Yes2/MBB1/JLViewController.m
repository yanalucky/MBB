//
//  JLViewController.m
//  MBB
//
//  Created by 陈彦 on 15/9/1.
//  Copyright (c) 2015年 elsa. All rights reserved.
//

#import "JLViewController.h"
#import "AppDelegate.h"
#import "DetailViewController.h"
#import "ServerConfigBaseClass.h"
#import "NetRequestManage.h"
//#import "TAlertView.h"

#import "CYOverRunView.h"
#import "SvGifView.h"
#import "ErrorStatus.h"
#import "UIImageView+WebCache.h"
@interface JLViewController ()<UINavigationControllerDelegate,UITextFieldDelegate,UIAlertViewDelegate,UIScrollViewDelegate>{
    
       UIColor *wordColor;
    UIColor *bgColor;
    int tagOfTextField;
    int rightTag;
    int _month;
    NSDictionary *_record;
     NSDictionary *dataDicOfConfig;
    JLNSObject *jilu;
    UITextView *textView0;
    NSMutableArray *dataOfJLArr;
    NSMutableArray *reportData;
    NSString *_questionId;
    NSMutableArray *_featureArr;
    NSMutableArray *_featureTrueArr;
    NSMutableArray *_questionArr;
    NSMutableArray *_questionTrueArr;
    ServerConfigBaseClass *serverCon;
    NSString *questionId0;
    BOOL _isAccessoryViewTF;
    BOOL _readTag;
    UIAlertView *alert;
    NSString *_nextTime;
    UILabel *btnTitle;
    int _sizeOfFont;
    
    
    
    NSArray *_movArr;
    NSMutableArray *_netMovArr;
}

@end

@implementation JLViewController

#pragma mark - 自定义 alertview 相关
-(void)overRun{
    CYOverRunView *ciew = [self.view.window viewWithTag:999];
    ciew.hidden = NO;
    ciew.clickBlocks = ^(void){
        
        [self.tabBarController dismissViewControllerAnimated:NO completion:nil];
    };
    [self.view.window bringSubviewToFront:ciew];
}

-(void)alertViewWithTextfieldAboutHandJilu{
    UIView *ciew = [self.view.window viewWithTag:8888];
    ciew.hidden = NO;
    for (int i=0; i<[ciew.subviews count]; i++) {
        UIView *ve = ciew.subviews[i];
        [ve removeFromSuperview];
    }

    
    UIImageView *_alert = [[UIImageView alloc] initWithFrame:CGRectMake((self.view.frame.size.width - 300)/2, (self.view.frame.size.height - 150)/2, 300, 150)];
    _alert.backgroundColor = [UIColor whiteColor];
    _alert.tag = 666666;
    _alert.layer.masksToBounds = YES;
    _alert.layer.cornerRadius = 10;
    _alert.userInteractionEnabled = YES;
    _alert.alpha = 1;
    
    
    UITextField *fiele = [[UITextField alloc] initWithFrame:CGRectMake((_alert.frame.size.width - 234)/2, (_alert.frame.size.height-57)/2-30, 234, 57)];
    
    fiele.keyboardType = UIKeyboardTypeNumberPad;
    fiele.placeholder = @"请输入密码";
    fiele.delegate = self;
    fiele.userInteractionEnabled = YES;
    fiele.tag = 555555;
    fiele.background = [UIImage imageNamed:@"jilu-tijiaokuang" ofSex:self.sex];
    [fiele setLeftViewOfBlankforWidth:8];
    [self setInputAccessoryViewByElsa:fiele];
    fiele.secureTextEntry = YES;
    [fiele setValue:[UIColor colorWithRed:130/255.0 green:130/255.0 blue:130/255.0 alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
    [fiele setValue:[UIFont yaHeiFontOfSize:15] forKeyPath:@"_placeholderLabel.font"];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake((_alert.frame.size.width - 161)/2, (_alert.frame.size.height-46)/2+42, 161, 46);
    [button setBackgroundImage:[UIImage imageNamed:@"jilu-tijiaobtn" ofSex:self.sex] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont yaHeiFontOfSize:14];
    [button setTitleColor:wordColor forState:UIControlStateNormal];
    [button addTarget:self action:@selector(tijiaoAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [_alert addSubview:button];
    
    [_alert addSubview:fiele];
    
    [ciew addSubview:_alert];
    
    [self.view.window bringSubviewToFront:ciew];
}

-(void)tijiaoAction:(UIButton *)button{
    JLUserRecord *record = [[JLUserRecord alloc] init];
    if (jilu.result.userRecord.recordid) {
        record.recordid = jilu.result.userRecord.recordid;
        
    }else{
        record.recordid = @"";
    }
    if (jilu.result.userRecord.userid) {
        record.userid = jilu.result.userRecord.userid;
        
    }else{
        record.userid = @"";
    }
    if (reportData.count != 0) {
        [reportData removeAllObjects];
    }
    for (int i=0; i<11; i++) {
        UILabel *lab = (UILabel *)[self.view viewWithTag:400+i];
        [reportData addObject:lab.text];
        
        NSLog(@"lab.text = %@",lab.text);
    }
    NSLog(@"reportData = %@",reportData);
    record.height = reportData[0];
    record.weight = reportData[1];
    record.breastfeedingcount = [NSString stringWithFormat:@"%d",[reportData[2] intValue]];
    record.breastfeedingml = [NSString stringWithFormat:@"%d",[reportData[3] intValue]];
    record.milkfeedingml = [NSString stringWithFormat:@"%d",[reportData[4] intValue]];
    
    record.daytimesleep = reportData[5];
    record.nighttimesleep = reportData[6];
    record.urinate = [NSString stringWithFormat:@"%d",[reportData[7] intValue]];
    record.cacation = [NSString stringWithFormat:@"%d",[reportData[8] intValue]];
    record.headcircumference = reportData[9];
    record.chestcircumference = reportData[10];
    if ([textView0.text isEqualToString:@"请输入专属私人医生要填写的内容"]) {
        record.other = @"";
    }else{
        record.other = textView0.text;
    }
    
    
    record.feature = jilu.result.userRecord.feature;
    record.recordtime = [NSString stringWithFormat:@"%@",[NSDate date]];
    if (jilu.result.userRecord.age) {
        record.age = jilu.result.userRecord.age;
        
    }else{
        record.age = [NSString stringWithFormat:@"%d",_month+1];
    }
    record.recordstatus = jilu.result.userRecord.recordstatus;
    record.featureList = _featureTrueArr;
    record.questionid = questionId0;
    
    UITextField *textfield = [button.superview viewWithTag:555555];
    [NetRequestManage reportWithUserId:record questionsArr:_questionTrueArr password:textfield.text successBlocks:^(NSData *data, NetRequestManage *loadUser) {
        NSLog(@"提交成功！");
        NSString *str = [[NSString alloc] initWithData:loadUser.resultData encoding:NSUTF8StringEncoding];
        NSLog(@"提交记录返回值：%@",str);
        NSDictionary *dicTiJiao = [NSJSONSerialization JSONObjectWithData:loadUser.resultData options:NSJSONReadingMutableContainers error:nil];
        NSString *erro = [dicTiJiao objectForKey:@"errorId"];
        if ([erro intValue]>=0) {
            if ([erro intValue]==2) {
                _nextTime = [[dicTiJiao objectForKey:@"result"] objectForKey:@"NextTime"];
            }
            
            if ([erro intValue] == -900) {
                [self overRun];
            }
            AppDelegate *delegate = [UIApplication sharedApplication].delegate;
            if (delegate.report == 0) {
                delegate.report = 1;
            }
            NSLog(@"%@",[[dicTiJiao objectForKey:@"result"] objectForKey:@"ReadTag"]);
            if ([[[dicTiJiao objectForKey:@"result"] objectForKey:@"ReadTag"] intValue]==1) {
                if([[[dicTiJiao objectForKey:@"result"] objectForKey:@"ShowTime"] isEqualToString:@"0"]){
                    btnTitle.text = [NSString stringWithFormat:@"线上服务结束"];
                }else{
                    
                    btnTitle.text = [NSString stringWithFormat:@"请于%@提交",[[dicTiJiao objectForKey:@"result"] objectForKey:@"ShowTime"]];
                
                }
                
                
                _readTag = ![[[dicTiJiao objectForKey:@"result"] objectForKey:@"ReadTag"] boolValue];
                
                for (id sub in self.view.subviews) {
                    
                    if ([sub isKindOfClass:[UIView class]]) {
                        UIView *vvv = (UIView *)sub;
                        for (id vv in vvv.subviews) {
                            if ([vv isKindOfClass:[UIScrollView class]]) {
                                UIScrollView *ss = (UIScrollView *)vv;
                                for (id texFd in ss.subviews) {
                                    if ([texFd isKindOfClass:[UITextField class]]) {
                                        UITextField *tex = (UITextField *)texFd;
                                        tex.userInteractionEnabled = _readTag;
                                    }
                                }
                                
                            }
                            
                        }
                    }
                    
                    
                }
                [self.view updateConstraints];
            }
            
            
        }
        
        //            aler = [[UIAlertView alloc] initWithTitle:[self errorStatus:erro] message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
        //            aler.delegate = self;
        //            UIImageView *imV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
        //            imV.image = [UIImage imageNamed:@"0-jilu-error"];
        //            [aler addSubview:imV];
        //
        //            aler.userInteractionEnabled = YES;
        //            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(alertClick:)];
        //            [aler addGestureRecognizer:tap];
        //            [aler show];
        //            TAlertView *alert0 = [[TAlertView alloc]initWithTitle:[ErrorStatus errorStatus:erro parmStr:_nextTime] andMessage:nil];
        //            alert0.style = TAlertViewStyleNeutral;
        //            alert0.center = self.view.center;
        //            alert0.imageName = @"jilu-error";
        //            alert0.sex = self.sex;
        //            [alert0 show];
        
        
        [[[self.view.window viewWithTag:8888] viewWithTag:666666] removeFromSuperview];
        
        [self alertViewWith:erro];
        
        
        
        
        
    } andFailedBlocks:^(NSError *error, NetRequestManage *loadUser) {
        NSLog(@"error = %@",error.description);
    }];
}




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
    
    
    UIImageView *header00 = [[UIImageView alloc] initWithFrame:CGRectMake((_alert.frame.size.width - 50)/2, (_alert.frame.size.height-49)/2-30, 50, 49)];
    if ([errorSts intValue] == 0) {
        header00.image = [UIImage imageNamed:@"caidan-morentouxiang-small" ofSex:self.sex];
    }else{
        header00.image = [UIImage imageNamed:@"jilu-error" ofSex:self.sex];
    }
    
    [_alert addSubview:header00];
    
    
    UILabel *labe = [[UILabel alloc] initWithFrame:CGRectMake(10, header00.frame.size.height+header00.frame.origin.y + 15, _alert.frame.size.width-20, 50)];
    
    labe.text = [ErrorStatus errorStatus:errorSts parmStr:_nextTime];
    labe.textColor = wordColor;
    labe.textAlignment = NSTextAlignmentCenter;
    labe.font = [UIFont yaHeiFontOfSize:16];
    labe.numberOfLines = 2;
    
    [_alert addSubview:labe];
    
    
    
    [ciew addSubview:_alert];
    
    
    
    //                [self.view.window updateConstraints];
    [self.view.window bringSubviewToFront:ciew];
}



-(void)viewWillAppear:(BOOL)animated{
    [self.view bringSubviewToFront:_right11];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(infoAction:) name:UITextFieldTextDidChangeNotification object:nil];
    [NetRequestManage jiluWithUserId:[[NSUserDefaults standardUserDefaults] objectForKey:@"userId"] successBlocks:^(NSData *data, NetRequestManage *loadUser) {
        NSString *str = [[NSString alloc] initWithData:loadUser.resultData encoding:NSUTF8StringEncoding];
        NSLog(@"str = %@",str);
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:loadUser.resultData options:NSJSONReadingMutableContainers error:nil];
        
        if ([[dic objectForKey:@"errorId"] intValue] == -900) {
            [self overRun];
        }
        JLNSObject *ji = [[JLNSObject alloc] initWithDictionary:dic];

        jilu = ji;
        if (jilu.result) {
            if (jilu.result.userRecord) {
                if (jilu.result.userRecord.readtag) {
                    _readTag = ![jilu.result.userRecord.readtag boolValue];

                }
            }
        }
        if (dataOfJLArr.count != 0) {
            [dataOfJLArr removeAllObjects];
        }
        JLUserRecord *record = jilu.result.userRecord;
        if (record.height) {
            [dataOfJLArr addObject:record.height];
            
        }else{
            [dataOfJLArr addObject:@""];
        }
        if (record.weight) {
            [dataOfJLArr addObject:record.weight];
            
        }else{
            [dataOfJLArr addObject:@""];
        }
        if (record.breastfeedingcount) {
            [dataOfJLArr addObject:record.breastfeedingcount];
            
        }else{
            [dataOfJLArr addObject:@""];
        }
        if (record.breastfeedingml) {
            [dataOfJLArr addObject:record.breastfeedingml];
            
        }else{
            [dataOfJLArr addObject:@""];
        }
        if (record.milkfeedingml) {
            [dataOfJLArr addObject:record.milkfeedingml];
            
        }else{
            [dataOfJLArr addObject:@""];
        }
        if (record.daytimesleep) {
            [dataOfJLArr addObject:record.daytimesleep];
            
        }else{
            [dataOfJLArr addObject:@""];
        }
        if (record.nighttimesleep) {
            [dataOfJLArr addObject:record.nighttimesleep];
            
        }else{
            [dataOfJLArr addObject:@""];
        }
        if (record.urinate) {
            [dataOfJLArr addObject:record.urinate];
            
        }else{
            [dataOfJLArr addObject:@""];
        }
        if (record.cacation) {
            [dataOfJLArr addObject:record.cacation];
            
        }else{
            [dataOfJLArr addObject:@""];
        }
        if (record.headcircumference) {
            [dataOfJLArr addObject:record.headcircumference];
            
        }else{
            [dataOfJLArr addObject:@""];
        }
        
        
        if (record.chestcircumference) {
            [dataOfJLArr addObject:record.chestcircumference];
            
        }else{
            [dataOfJLArr addObject:@""];
        }
        
        if (record.feature) {
            [dataOfJLArr addObject:record.feature];
            
        }else{
            [dataOfJLArr addObject:@""];
        }
        if (record.other) {
            [dataOfJLArr addObject:record.other];
            
        }else{
            [dataOfJLArr addObject:@""];
        }
        for (int i=0; i<12; i++) {
            UILabel *number = [self.view viewWithTag:400+i];
            
            if (dataOfJLArr.count > 0 ) {
                NSString *numberData = dataOfJLArr[number.tag-400];
                if ((numberData.length != 0)||(![dataOfJLArr[i] floatValue] == 0)) {
                    number.text = dataOfJLArr[i];
                    
                }else{
                    
                    number.text = @"0.00";
                    
                    if ((number.tag == 404) || (number.tag == 403)||(number.tag == 402)||(number.tag == 407)||(number.tag == 408)||(number.tag == 411)) {
                        number.text = @"0";
                    }
                    if ((number.tag == 405)||(number.tag == 406)) {
                        number.text = @"0.0";
                        
                    }
                }
                
            }
            [self.view updateConstraints];
        }
        for (id sub in self.view.subviews) {
            
            if ([sub isKindOfClass:[UIView class]]) {
                UIView *vvv = (UIView *)sub;
                for (id vv in vvv.subviews) {
                    if ([vv isKindOfClass:[UIScrollView class]]) {
                        UIScrollView *ss = (UIScrollView *)vv;
                        for (id texFd in ss.subviews) {
                            if ([texFd isKindOfClass:[UITextField class]]) {
                                UITextField *tex = (UITextField *)texFd;
                                tex.userInteractionEnabled = _readTag;
                            }
                        }
                        
                    }
                    
                }
            }
        }
        NSMutableArray *featuredArr = [[NSMutableArray alloc] init];
        if (jilu) {
            if (jilu.result) {
                if (jilu.result.userRecord) {
                    if (jilu.result.userRecord.featureList.count > 0) {
                        for(JLFeatureList *lis in jilu.result.userRecord.featureList) {
                            [featuredArr addObject:lis.detailid];
                        }
                    }
                }
            }
        }
        NSArray *featureArr = serverCon.result.featureList;
        for (int i=0; i<_featureArr.count; i++) {
            ServerConfigFeatureList *feture = _featureArr[i];
            UIButton *buttom = (UIButton *)[[_right8 viewWithTag:6666] viewWithTag:2000+i];
            buttom.selected = NO;
            if ([featuredArr containsObject:feture.featureListIdentifier]) {
                
                buttom.selected = YES;
            }
            buttom.userInteractionEnabled = _readTag;

        }

        
     [self.view updateConstraints];
     
    } andFailedBlocks:^(NSError *error, NetRequestManage *loadUser) {
        NSLog(@"ERROR = %@",error.description);
    }];
    [self.view updateConstraints];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *arrOfMonth = [[NSUserDefaults standardUserDefaults] objectForKey:@"time"];
    
    _month = [arrOfMonth[0] intValue]*12+[arrOfMonth[1] intValue];
    
    
    if (_month == 0) {
        _month = 1;
    }

    _movArr = @[@"celiangshengao1",@"celiangtizhong1",@"celiangtouwei1",@"celiangxiongwei1",@"mrxb",@"mrws",@"mrbqs",@"mrzq",@"mrcw",@"rgwy"];
    _netMovArr = [[NSMutableArray alloc] init];
    _sizeOfFont = 17;
    _isAccessoryViewTF = YES;
    dataOfJLArr = [[NSMutableArray alloc] init];
    reportData = [[NSMutableArray alloc] init];
    _featureArr = [[NSMutableArray alloc] init];
    _questionArr = [[NSMutableArray alloc] init];
    _featureTrueArr = [[NSMutableArray alloc] init];
    _questionTrueArr = [[NSMutableArray alloc] init];
    _readTag = YES;
    
    
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    self.sex = delegate.sex;
    if (self.sex == YES) {
        wordColor = BOY_WORDCOLOR;
        bgColor = BOY_RIGHTVIEWCOLOR;
    }else{
        wordColor = GIRL_WORDCOLOR;
        bgColor = GIRL_RIGHTVIEWCOLOR;
    }
    NSFileManager *manager = [NSFileManager defaultManager];
    NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/severCon.plist"];
    if ([manager fileExistsAtPath:path]) {
        NSData *data = [NSData dataWithContentsOfFile:path];
        dataDicOfConfig = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        serverCon = [[ServerConfigBaseClass alloc] initWithDictionary:dataDicOfConfig];

    }else{
        NSLog(@"路径不存在！");
    }
//    NSArray *month = [[NSUserDefaults standardUserDefaults] objectForKey:@"time"];
//    _month = [month[0] intValue]*12+[month[1] intValue];

    NSString *path0 = [[NSBundle mainBundle] pathForResource:@"Record" ofType:@"plist"];
    NSDictionary *recordDic = [NSDictionary dictionaryWithContentsOfFile:path0];
    _record = recordDic;
    [self createLeftView];
    // Do any additional setup after loading the view.
}

-(void)createLeftView{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(185, 106-20, 300, 30)];
    
    
    label.text = @"亲爱的爸爸妈妈，";
    label.numberOfLines = 2;
    label.font = [UIFont yaHeiFontOfSize:17];
    label.textColor = WORDDARKCOLOR;
    label.shadowColor = [UIColor clearColor];
    label.textAlignment = NSTextAlignmentCenter;
    
    [self.view addSubview:label];
    UILabel *label0 = [[UILabel alloc] initWithFrame:CGRectMake(185, 106-20+30, 300, 30)];
    
    
    label0.text = @"请仔细填写，便于医生准确评估";
    label0.numberOfLines = 2;
    label0.font = [UIFont yaHeiFontOfSize:17];
    label0.textColor = WORDDARKCOLOR;
    label0.shadowColor = [UIColor clearColor];
    label0.textAlignment = NSTextAlignmentCenter;
    
    [self.view addSubview:label0];
    
    
    UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(176, 172, 311, 1)];
    line.backgroundColor = wordColor;
    [self.view addSubview:line];
    
    NSArray *textArr2 = @[@"毫升/天",@"时/晚上"];
    NSArray *textArr0 = @[@"身长",@"体重",@"奶量",@"睡眠",@"排尿",@"排便",@"头围",@"胸围",@"发育行为观察",@"问卷",@"其他"];
    NSArray *textArr1 = @[@"厘米",@"公斤",@"次",@"毫升/天",@"时/白天",@"次/天",@"次/天",@"厘米",@"厘米",@"已选特征"];
    /**
     *  button
     */
    for (int i=0; i<2; i++) {
        UIButton *button0 = [UIButton buttonWithType:UIButtonTypeCustom];
        button0.frame = CGRectMake(170, 200+35*i, 324+5, 30);
        [button0 setBackgroundImage:[UIImage imageNamed:@"jilu-xuanzhong" ofSex:self.sex] forState:UIControlStateSelected];
        [button0 addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        button0.tag = 300+i;
        [self.view addSubview:button0];
    }
    
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame = CGRectMake(170, 200+70, 324+5, 65);
    [button1 setBackgroundImage:[UIImage imageNamed:@"jilu-nailiang" ofSex:self.sex] forState:UIControlStateSelected];
    button1.tag = 302;
    [button1 addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview:button1];
    
    for (int i=3; i<11; i++) {
        UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
        button2.frame = CGRectMake(170, 340+35*(i-3), 324+5, 35);
        [button2 setBackgroundImage:[UIImage imageNamed:@"jilu-xuanzhong" ofSex:self.sex] forState:UIControlStateSelected];
        button2.tag = 300+i;
        [button2 addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];

        [self.view addSubview:button2];
    }
    
    for (int i=0; i<11; i++) {
        UILabel *labl = [[UILabel alloc] initWithFrame:CGRectMake(176, 205+35*i+((i>2)?35:0), 115, 20)];
        
        labl.text = textArr0[i];
        labl.textColor = WORDDARKCOLOR;
        labl.font = [UIFont yaHeiFontOfSize:18];
        labl.textAlignment = NSTextAlignmentLeft;
       [self.view addSubview:labl];
    }
    
    
    /**
     *  数据number
     
     */
    [NetRequestManage jiluWithUserId:[[NSUserDefaults standardUserDefaults] objectForKey:@"userId"] successBlocks:^(NSData *data, NetRequestManage *loadUser) {
        NSString *str = [[NSString alloc] initWithData:loadUser.resultData encoding:NSUTF8StringEncoding];
        NSLog(@"str = %@",str);
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:loadUser.resultData options:NSJSONReadingMutableContainers error:nil];
        
        if ([[dic objectForKey:@"errorId"] intValue] == -900) {
            [self overRun];
        }
        jilu = [[JLNSObject alloc] initWithDictionary:dic];
        _readTag = ![jilu.result.userRecord.readtag boolValue];
        
        if (dataOfJLArr.count != 0) {
            [dataOfJLArr removeAllObjects];
        }
        JLUserRecord *record = jilu.result.userRecord;
        if (record.height) {
            [dataOfJLArr addObject:record.height];
            
        }else{
            [dataOfJLArr addObject:@""];
        }
        if (record.weight) {
            [dataOfJLArr addObject:record.weight];
            
        }else{
            [dataOfJLArr addObject:@""];
        }
        if (record.breastfeedingcount) {
            [dataOfJLArr addObject:record.breastfeedingcount];
            
        }else{
            [dataOfJLArr addObject:@""];
        }
        if (record.breastfeedingml) {
            [dataOfJLArr addObject:record.breastfeedingml];
            
        }else{
            [dataOfJLArr addObject:@""];
        }
        if (record.milkfeedingml) {
            [dataOfJLArr addObject:record.milkfeedingml];
            
        }else{
            [dataOfJLArr addObject:@""];
        }
        if (record.daytimesleep) {
            [dataOfJLArr addObject:record.daytimesleep];
            
        }else{
            [dataOfJLArr addObject:@""];
        }
        if (record.nighttimesleep) {
            [dataOfJLArr addObject:record.nighttimesleep];
            
        }else{
            [dataOfJLArr addObject:@""];
        }
        if (record.urinate) {
            [dataOfJLArr addObject:record.urinate];
            
        }else{
            [dataOfJLArr addObject:@""];
        }
        if (record.cacation) {
            [dataOfJLArr addObject:record.cacation];
            
        }else{
            [dataOfJLArr addObject:@""];
        }
        if (record.headcircumference) {
            [dataOfJLArr addObject:record.headcircumference];
            
        }else{
            [dataOfJLArr addObject:@""];
        }
        
        
        if (record.chestcircumference) {
            [dataOfJLArr addObject:record.chestcircumference];
            
        }else{
            [dataOfJLArr addObject:@""];
        }
        
        if (record.feature) {
            [dataOfJLArr addObject:record.feature];
            
        }else{
            [dataOfJLArr addObject:@""];
        }
        if (record.other) {
            [dataOfJLArr addObject:record.other];
            
        }else{
            [dataOfJLArr addObject:@""];
        }
        for (int i=0; i<10; i++) {
            UILabel *number = [[UILabel alloc] initWithFrame:CGRectMake(288, 205+35*i, 60, 20)];
            
            number.tag = 400+i+((i>2)?1:0)+((i>4)?1:0);
            if (dataOfJLArr.count > 0 ) {
                NSString *numberData = dataOfJLArr[number.tag-400];
                if (numberData.length != 0) {
                    number.text = dataOfJLArr[number.tag-400];
                }else{
                    number.text = @"0.00";
                    if ((number.tag == 404) || (number.tag == 403)||(number.tag == 402)||(number.tag == 407)||(number.tag == 408)||(number.tag == 411)) {
                        number.text = @"0";
                    }
                    if ((number.tag == 405)||(number.tag == 406)) {
                        number.text = @"0.0";
                        
                    }
                }
                
            }
            
            NSLog(@"number.tag = %ld,number.text = %@",number.tag,number.text);
            number.textColor = wordColor;
            number.font = [UIFont yaHeiFontOfSize:17];
            [self.view addSubview:number];
            
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(338, 205+35*i, 100, 20)];
            label.text = textArr1[i];
            label.font = [UIFont yaHeiFontOfSize:15];
            label.textColor = WORDDARKCOLOR;
            [self.view addSubview:label];
        }
        /**
         无用label
         
         */
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(440, 205+35*2, 100, 20)];
        lab.text = textArr2[0];
        lab.textColor = WORDDARKCOLOR;
        lab.font = [UIFont yaHeiFontOfSize:15];
        [self.view addSubview:lab];
        UILabel *lab1 = [[UILabel alloc] initWithFrame:CGRectMake(440, 205+35*4, 100, 20)];
        lab1.text = textArr2[1];
        lab1.font = [UIFont yaHeiFontOfSize:15];
        lab1.textColor = WORDDARKCOLOR;
        [self.view addSubview:lab1];
        
        
        UILabel *number1 = [[UILabel alloc] initWithFrame:CGRectMake(395, 205+35*2, 50, 20)];
        number1.tag = 400+3;
        if (dataOfJLArr.count > 0 ) {
            NSString *numberData1 = dataOfJLArr[number1.tag-400];
            
            if (numberData1.length != 0) {
                number1.text = dataOfJLArr[number1.tag-400];
                
            }else{
                
                number1.text = @"0";
                
            }
        }
        
        
        number1.font = [UIFont yaHeiFontOfSize:16];
        number1.textColor = wordColor;
        [self.view addSubview:number1];
        
        UILabel *number2 = [[UILabel alloc] initWithFrame:CGRectMake(395, 205+35*4, 50, 20)];
        number2.tag = 400+6;
        if (dataOfJLArr.count > 0 ) {
            NSString *numberData2 = dataOfJLArr[number2.tag-400];
            
            if (numberData2.length != 0) {
                number2.text = dataOfJLArr[number2.tag-400];
                
            }else{
                number2.text = @"0.0";
            }
        }
        
        
        number2.font = [UIFont yaHeiFontOfSize:16];
        number2.textColor = wordColor;
        [self.view addSubview:number2];
        
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(215, 655, 234, 57);
        [button setImage:[UIImage imageNamed:@"jilu-tijiao" ofSex:self.sex] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"jilu-tijiao" ofSex:self.sex] forState:UIControlStateSelected];
        [button setImage:[UIImage imageNamed:@"jilu-tijiao" ofSex:self.sex] forState:UIControlStateHighlighted];

        btnTitle = [[UILabel alloc] initWithFrame:button.bounds];
        
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        [format setDateFormat:@"yyyy-MM-dd"];
        
        NSDate *recordTime = [format dateFromString:jilu.result.userRecord.recordtime];
        NSDate *trueRecordTime1 = [recordTime dateByAddingTimeInterval:60*60*8];
        NSDate *trueRecordTime0 = [NSDate dateWithTimeInterval:-(24*60*60) sinceDate:trueRecordTime1];
        NSLog(@"recordTime - %@ 石头人= %@",trueRecordTime0,trueRecordTime1);
        NSDate *finishDate = [trueRecordTime1 dateByAddingTimeInterval:60*60*24*6];
        NSDate *date0 = [[NSDate date] dateByAddingTimeInterval:60*60*8];
        
        NSLog(@"finishDate = %@ date0 = %@",finishDate,date0);
        if ([jilu.result.userRecord.recordstatus intValue] == 0) {
            btnTitle.text = @"提交记录";
            

        }else{
            if ([jilu.result.userRecord.readtag intValue] == 1) {
                if([jilu.result.showTime isEqualToString:@"0"]){
                    btnTitle.text = [NSString stringWithFormat:@"线上服务结束"];
                }else{
                    btnTitle.text = [NSString stringWithFormat:@"请于%@提交",jilu.result.showTime];
                }
            }else{
                if ([date0 isEqualToDate:[date0 laterDate:trueRecordTime0]]&&[date0 isEqualToDate:[date0 earlierDate:trueRecordTime1]]) {
                    
                    btnTitle.text = [NSString stringWithFormat:@"请于%@提交",jilu.result.showTime];
                    
                }else{
                    if ([date0 isEqualToDate:[date0 earlierDate:finishDate]]) {
                        btnTitle.text = [NSString stringWithFormat:@"请于%@之前提交",jilu.result.showTime];
                    }else{
                        btnTitle.text = @"已过了提交时间";
                    }
                    
                }
            }
            
            
        }
        btnTitle.textAlignment = NSTextAlignmentCenter;
        btnTitle.textColor = wordColor;
        btnTitle.font = [UIFont yaHeiFontOfSize:16];
        [button addSubview:btnTitle];
        [button addTarget:self action:@selector(handAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:button];

        [self createRightView];
        
    } andFailedBlocks:^(NSError *error, NetRequestManage *loadUser) {
        NSLog(@"ERROR = %@",error.description);
    }];
    
    
    
    
//        [dataOfJLArr addObject:record.weight];
//    [dataOfJLArr addObject:record.breastfeedingcount];
//    [dataOfJLArr addObject:record.breastfeedingml];
//    
//    [dataOfJLArr addObject:record.milkfeedingml];
//    [dataOfJLArr addObject:record.daytimesleep];
//    [dataOfJLArr addObject:record.nighttimesleep];
//    [dataOfJLArr addObject:record.urinate];
//    [dataOfJLArr addObject:record.cacation];
//    [dataOfJLArr addObject:record.headcircumference];
//    [dataOfJLArr addObject:record.chestcircumference];
//    [dataOfJLArr addObject:record.feature];
//    [dataOfJLArr addObject:record.other];
    NSLog(@"dataOfJLArr = %@",dataOfJLArr);
    
    
    
}

#pragma mark - 提交记录
-(void)handAction:(UIButton *)button{
    NSLog(@"提交记录");
//    for (int i=0; i<11; i++) {
//        UILabel *lab = (UILabel *)[self.view viewWithTag:400];
//
//    }
    [self alertViewWithTextfieldAboutHandJilu];
//    alert = [[UIAlertView alloc] initWithTitle:@"" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"提交", nil];
//    alert.delegate = self;
//    UIImageView *imV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
//    imV.image = [UIImage imageNamed:@"0-jilu-error"];
//    [alert addSubview:imV];
//    alert.alertViewStyle = UIAlertViewStyleSecureTextInput;
//    UITextField *textf = [alert textFieldAtIndex:0];
//    textf.tag = 77777;
//    textf.delegate = self;
//    [self setInputAccessoryViewByElsa:textf];
//    [alert show];
    
//    UILabel *lab = (UILabel *)[self.view viewWithTag:400];
}
/*
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    
    UITextField *textfield = [alertView textFieldAtIndex:0];

    NSLog(@"%@",textfield.text);
    NSLog(@"buttonIndex = %ld",buttonIndex);
    if (buttonIndex == 1) {
        JLUserRecord *record = [[JLUserRecord alloc] init];
        if (jilu.result.userRecord.recordid) {
            record.recordid = jilu.result.userRecord.recordid;

        }else{
            record.recordid = @"";
        }
        if (jilu.result.userRecord.userid) {
            record.userid = jilu.result.userRecord.userid;

        }else{
            record.userid = @"";
        }
        if (reportData.count != 0) {
            [reportData removeAllObjects];
        }
        for (int i=0; i<11; i++) {
            UILabel *lab = (UILabel *)[self.view viewWithTag:400+i];
            [reportData addObject:lab.text];
            
            NSLog(@"lab.text = %@",lab.text);
        }
        NSLog(@"reportData = %@",reportData);
        record.height = reportData[0];
        record.weight = reportData[1];
        record.breastfeedingcount = [NSString stringWithFormat:@"%d",[reportData[2] intValue]];
        record.breastfeedingml = [NSString stringWithFormat:@"%d",[reportData[3] intValue]];
        record.milkfeedingml = [NSString stringWithFormat:@"%d",[reportData[4] intValue]];

        record.daytimesleep = reportData[5];
        record.nighttimesleep = reportData[6];
        record.urinate = [NSString stringWithFormat:@"%d",[reportData[7] intValue]];
        record.cacation = [NSString stringWithFormat:@"%d",[reportData[8] intValue]];
        record.headcircumference = reportData[9];
        record.chestcircumference = reportData[10];
        if ([textView.text isEqualToString:@"请输入专属私人医生要填写的内容"]) {
            record.other = @"";
        }else{
            record.other = textView.text;
        }
        
        
        record.feature = jilu.result.userRecord.feature;
        record.recordtime = [NSString stringWithFormat:@"%@",[NSDate date]];
        if (jilu.result.userRecord.age) {
            record.age = jilu.result.userRecord.age;

        }else{
            record.age = [NSString stringWithFormat:@"%d",_month+1];
        }
        record.recordstatus = jilu.result.userRecord.recordstatus;
        record.featureList = _featureTrueArr;
        record.questionid = questionId0;
        [NetRequestManage reportWithUserId:record questionsArr:_questionTrueArr password:textfield.text successBlocks:^(NSData *data, NetRequestManage *loadUser) {
            NSLog(@"提交成功！");
            NSString *str = [[NSString alloc] initWithData:loadUser.resultData encoding:NSUTF8StringEncoding];
            NSLog(@"提交记录返回值：%@",str);
            NSDictionary *dicTiJiao = [NSJSONSerialization JSONObjectWithData:loadUser.resultData options:NSJSONReadingMutableContainers error:nil];
            NSString *erro = [dicTiJiao objectForKey:@"errorId"];
            if ([erro intValue]>=0) {
                if ([erro intValue]==2) {
                    _nextTime = [[dicTiJiao objectForKey:@"result"] objectForKey:@"NextTime"];
                }
                
                if ([[[dicTiJiao objectForKey:@"result"] objectForKey:@"ReadTag"] intValue]==1) {
                    btnTitle.text = [NSString stringWithFormat:@"请于%@提交",[[dicTiJiao objectForKey:@"result"] objectForKey:@"ShowTime"]];
                    
                    _readTag = ![[[dicTiJiao objectForKey:@"result"] objectForKey:@"ReadTag"] boolValue];
            
                    for (id sub in self.view.subviews) {
                        
                        if ([sub isKindOfClass:[UIView class]]) {
                            UIView *vvv = (UIView *)sub;
                            for (id vv in vvv.subviews) {
                                if ([vv isKindOfClass:[UIScrollView class]]) {
                                    UIScrollView *ss = (UIScrollView *)vv;
                                    for (id texFd in ss.subviews) {
                                        if ([texFd isKindOfClass:[UITextField class]]) {
                                            UITextField *tex = (UITextField *)texFd;
                                            tex.userInteractionEnabled = _readTag;
                                        }
                                    }
                                    
                                }
                                
                            }
                        }
                    
                       
                    }
                    [self.view updateConstraints];
                }
                

            }
            
//            aler = [[UIAlertView alloc] initWithTitle:[self errorStatus:erro] message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
//            aler.delegate = self;
//            UIImageView *imV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
//            imV.image = [UIImage imageNamed:@"0-jilu-error"];
//            [aler addSubview:imV];
//            
//            aler.userInteractionEnabled = YES;
//            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(alertClick:)];
//            [aler addGestureRecognizer:tap];
//            [aler show];
//            TAlertView *alert0 = [[TAlertView alloc]initWithTitle:[ErrorStatus errorStatus:erro parmStr:_nextTime] andMessage:nil];
//            alert0.style = TAlertViewStyleNeutral;
//            alert0.center = self.view.center;
//            alert0.imageName = @"jilu-error";
//            alert0.sex = self.sex;
//            [alert0 show];
            
            
            [self alertViewWith:[ErrorStatus errorStatus:erro parmStr:_nextTime]];
            
            
            
            
            
        } andFailedBlocks:^(NSError *error, NetRequestManage *loadUser) {
            NSLog(@"error = %@",error.description);
        }];
    }
}
*/


#pragma mark - 左侧button点击
-(void)buttonClick:(UIButton *)button{
    for (int i=0; i<11; i++) {
        UIButton *btn = (UIButton *)[self.view viewWithTag:300+i];
        btn.selected = NO;
    }
    button.selected = YES;
    UIView *view;
    if (button.tag == 300) {
        view = _right0;
       
        
    }else if (button.tag == 301){
        view = _right1;
    }else if (button.tag == 302){
        view = _right2;
    }else if (button.tag == 303){
        view = _right3;

    }else if (button.tag == 304){
        view = _right4;

    }else if (button.tag == 305){
        view = _right5;

    }else if (button.tag == 306){
        view = _right6;

    }else if (button.tag == 307){
        view = _right7;

    }else if (button.tag == 308){
        view = _right8;

    }else if (button.tag == 309){
        view = _right9;

    }else if (button.tag == 310){
        view = _right10;

        
    }
    NSArray *subViewArr = view.subviews;
    for (id vie in subViewArr) {
        if ([vie isKindOfClass:[UIScrollView class]]) {
            UIScrollView *se = (UIScrollView *)vie;
            for (id subV in se.subviews) {
                if ([subV isKindOfClass:[UITextField class]]) {
                    UITextField *textField = (UITextField *)subV;
                    UILabel *currentLabel = (UILabel *)[self.view viewWithTag:textField.tag-100];
                    textField.text = currentLabel.text;
                    if ([currentLabel.text intValue] == 0) {
                        textField.text = nil;
                    }

                }
            }
        }
    }


    
    [self.view bringSubviewToFront:view];
    rightTag = view.tag;
    
    for (int i=0; i<11; i++) {
        UIView *view = (UIView *)[self.view viewWithTag:450+i];
        for (id vi in view.subviews) {
            UITextField *textField = (UITextField *)vi;
            [textField resignFirstResponder];
        }
    }
}
-(void)createRightView{
    _right0 = [[UIView alloc] initWithFrame:FRAMEOFRIGHTVIEW];
    _right0.backgroundColor = bgColor;
    _right0.tag = 450;
    [self.view addSubview:_right0];
    
    _right1 = [[UIView alloc] initWithFrame:FRAMEOFRIGHTVIEW];
    _right1.backgroundColor = bgColor;
    _right1.tag = 451;
    [self.view addSubview:_right1];
    
    _right2 = [[UIView alloc] initWithFrame:FRAMEOFRIGHTVIEW];
    _right2.tag = 452;
    _right2.backgroundColor = bgColor;
    [self.view addSubview:_right2];
    
    _right3 = [[UIView alloc] initWithFrame:FRAMEOFRIGHTVIEW];
    _right3.backgroundColor = bgColor;
    _right3.tag = 453;

    [self.view addSubview:_right3];
    
    _right4 = [[UIView alloc] initWithFrame:FRAMEOFRIGHTVIEW];
    _right4.backgroundColor = bgColor;
    _right4.tag = 454;

    [self.view addSubview:_right4];
    
    _right5 = [[UIView alloc] initWithFrame:FRAMEOFRIGHTVIEW];
    _right5.backgroundColor = bgColor;
    _right5.tag = 455;

    [self.view addSubview:_right5];
    
    _right6 = [[UIView alloc] initWithFrame:FRAMEOFRIGHTVIEW];
    _right6.backgroundColor = bgColor;
    _right6.tag = 456;

    [self.view addSubview:_right6];
    
    _right7 = [[UIView alloc] initWithFrame:FRAMEOFRIGHTVIEW];
    _right7.backgroundColor = bgColor;
    _right7.tag = 457;

    [self.view addSubview:_right7];
    
    _right8 = [[UIView alloc] initWithFrame:FRAMEOFRIGHTVIEW];
    _right8.backgroundColor = bgColor;
    _right8.tag = 458;

    [self.view addSubview:_right8];
    
    _right9 = [[UIView alloc] initWithFrame:FRAMEOFRIGHTVIEW];
    _right9.backgroundColor = bgColor;
    _right9.tag = 459;

    [self.view addSubview:_right9];
    
    _right10 = [[UIView alloc] initWithFrame:FRAMEOFRIGHTVIEW];
    _right10.backgroundColor = bgColor;
    _right10.tag = 460;

    [self.view addSubview:_right10];

    _right11 = [[UIView alloc] initWithFrame:FRAMEOFRIGHTVIEW];
    _right11.backgroundColor = bgColor;
    _right11.tag = 461;
    
    [self.view addSubview:_right11];
    [self createRight0];
    [self createRight1];
    [self createRight2];
    [self createRight3];
    [self createRight4];
    [self createRight5];
    [self createRight6];
    [self createRight7];
    [self createRight8];
    [self createRight9];
    [self createRight10];
    [self createRight11];
    [self.view bringSubviewToFront:_right11];
}
/**
 *  右侧图
 */
#pragma mark - textAccessoryView相关

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
    [finish setTitleColor:wordColor forState:UIControlStateNormal];
    [finish addTarget:self action:@selector(finishAction:) forControlEvents:UIControlEventTouchUpInside];
    [view0 addSubview:finish];
    
    UIButton *remov = [UIButton buttonWithType:UIButtonTypeCustom];
    remov.frame = CGRectMake(view0.frame.size.width-70, 5, 60, view0.frame.size.height-10);
    [remov setTitle:@"取消" forState:UIControlStateNormal];
    [remov setTitleColor:wordColor forState:UIControlStateNormal];
    [remov addTarget:self action:@selector(removeText:) forControlEvents:UIControlEventTouchUpInside];
    [view0 addSubview:remov];
    
    view0.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1];
    [textF setInputAccessoryView:view0];
}
-(void)finishAction:(UIButton *)button{
    
    UITextField *textAccess = (UITextField *)[button.superview viewWithTag:8000];
    [textAccess resignFirstResponder];
    
    UITextField *text = (UITextField *)[[self.view viewWithTag:rightTag] viewWithTag:tagOfTextField];

    [text resignFirstResponder];
    
    UITextField *text0 = [[[self.view.window viewWithTag:8888] viewWithTag:666666] viewWithTag:555555];
    [text0 resignFirstResponder];
    
    

    
    
}


-(void)removeText:(UIButton *)button{
    UITextField *textAccess = (UITextField *)[button.superview viewWithTag:8000];
    
    textAccess.text = nil;
    [textAccess resignFirstResponder];
    
    
    UITextField *text;
    if (tagOfTextField !=0&&tagOfTextField!=555555) {
        text = (UITextField *)[[self.view viewWithTag:rightTag] viewWithTag:tagOfTextField];
        
        
    }else{
        if (tagOfTextField == 555555) {
            text = [[[self.view.window viewWithTag:8888] viewWithTag:666666] viewWithTag:555555];

        }
    }
    text.text = nil;
    [text resignFirstResponder];
   
    
    
}

#pragma mark - 身长

-(void)createRight0{
    UIScrollView *sc = [[UIScrollView alloc] initWithFrame:CGRectMake(40, 40, FRAMEOFRIGHTVIEW.size.width-80, FRAMEOFRIGHTVIEW.size.height-40)];
    sc.tag = 1234567;
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(20, 5, sc.frame.size.width-40, 44)];
    title.text = @"身长";
    title.textAlignment = NSTextAlignmentCenter;
    title.font = [UIFont yaHeiFontOfSize:30];
    title.textColor = wordColor;
    [sc addSubview:title];
    
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(sc.frame.size.width/2-117, 73, 234, 57)];
     textField.keyboardType = UIKeyboardTypeNumberPad;
    textField.placeholder = @"请输入宝宝的身长";
    textField.userInteractionEnabled = _readTag;
    textField.background = [UIImage imageNamed:@"jilu-shuru" ofSex:self.sex];
    textField.tag = 500;
    [textField setLeftViewOfBlankforWidth:8];

    UILabel *currentLabel = (UILabel *)[self.view viewWithTag:textField.tag-100];
    textField.text = currentLabel.text;
    if ([currentLabel.text intValue] == 0) {
        textField.text = nil;
    }
    
    textField.delegate = self;
    [self setInputAccessoryViewByElsa:textField];
    [sc addSubview:textField];
    
    UILabel *unit = [[UILabel alloc] initWithFrame:CGRectMake(textField.frame.origin.x+textField.frame.size.width+5, textField.frame.origin.y, 80, textField.frame.size.height)];
    unit.text = @"厘米";
    unit.textColor = WORDDARKCOLOR;
    unit.font = [UIFont yaHeiFontOfSize:22];
    [sc addSubview:unit];
    
    NSDictionary *shenchang = [_record objectForKey:@"身长"];
    NSString *cankao;
    if (self.sex == 0) {
        cankao = [shenchang objectForKey:@"参考值0"][_month-1];
    }else{
        cankao = [shenchang objectForKey:@"参考值1"][_month-1];

    }
    //    54,190
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(30, 150, FRAMEOFRIGHTVIEW.size.width-108, 20)];
    lab.text = @"参考值：";
    lab.textColor = WORDDARKCOLOR;
    lab.font = [UIFont yaHeiFontOfSize:_sizeOfFont];
    [sc addSubview:lab];
    //30
    UIImageView *spot = [[UIImageView alloc] initWithFrame:CGRectMake(lab.frame.origin.x+5, lab.frame.origin.y + 5 + 30, 11, 11)];
    spot.image = [UIImage imageNamed:@"jilu-dian" ofSex:self.sex];
    [sc addSubview:spot];
    UILabel *referTo = [[UILabel alloc] initWithFrame:CGRectMake(spot.frame.origin.x + spot.frame.size.width+5, spot.frame.origin.y-5, lab.frame.size.width - 100, 20)];
    referTo.text = cankao;
    referTo.textColor = WORDDARKCOLOR;
    referTo.font = [UIFont yaHeiFontOfSize:_sizeOfFont];
    [sc addSubview:referTo];
    sc.contentSize = CGSizeMake(sc.frame.size.width, referTo.frame.origin.y+referTo.frame.size.height);
    if ([[shenchang objectForKey:@"增长"][_month] length]>0) {
        UIImageView *spot0 = [[UIImageView alloc] initWithFrame:CGRectMake(lab.frame.origin.x+5, lab.frame.origin.y + 5 + 30 + 30, 11, 11)];
        spot0.image = [UIImage imageNamed:@"jilu-dian" ofSex:self.sex];
        [sc addSubview:spot0];
        UILabel *referTo0 = [[UILabel alloc] initWithFrame:CGRectMake(spot0.frame.origin.x + spot0.frame.size.width+5, spot0.frame.origin.y-5, lab.frame.size.width - 100, 20)];
        referTo0.text = [shenchang objectForKey:@"增长"][_month];
        referTo0.textColor = WORDDARKCOLOR;
        referTo0.font = [UIFont yaHeiFontOfSize:16];
        
        CGSize size = [referTo sizeThatFits:CGSizeMake(sc.frame.size.width-referTo.frame.origin.x, 2000)];
        referTo0.frame = CGRectMake(spot0.frame.origin.x + spot0.frame.size.width+5, spot0.frame.origin.y-5, lab.frame.size.width - 100, size.height);
        
        [sc addSubview:referTo0];
        sc.contentSize = CGSizeMake(sc.frame.size.width, referTo0.frame.origin.y+referTo0.frame.size.height);
    };
    UILabel *measure = [[UILabel alloc] initWithFrame:CGRectMake(lab.frame.origin.x, sc.contentSize.height + 10,220, 20)];
    measure.text = @"家庭正确的身长测量方法：";
    measure.textColor = WORDDARKCOLOR;
    measure.font = [UIFont yaHeiFontOfSize:_sizeOfFont];
    [sc addSubview:measure];
    NSArray *measu = [shenchang objectForKey:@"家庭正确的身长测量方法"];
    UIFont *font = [UIFont yaHeiFontOfSize:_sizeOfFont];
    NSDictionary *dict = [NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName];
    int heigt = 30;
    for (int i=0; i<[measu count]; i++) {
        
//        CGRect rect = [measu[i] boundingRectWithSize:CGSizeMake(sc.frame.size.width-referTo.frame.origin.x, 2000) options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil];
        UILabel *mesa = [[UILabel alloc] initWithFrame:CGRectMake(referTo.frame.origin.x, measure.frame.origin.y + heigt, sc.frame.size.width-referTo.frame.origin.x, 300)];
        mesa.text = measu[i];
        mesa.textColor = WORDDARKCOLOR;
        mesa.numberOfLines = 0;
        mesa.font = font;
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:mesa.text];;
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
        [paragraphStyle setLineSpacing:10];
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, mesa.text.length)];
        
        mesa.attributedText = attributedString;
        CGSize size = [mesa sizeThatFits:CGSizeMake(sc.frame.size.width-referTo.frame.origin.x, 2000)];
        mesa.frame = CGRectMake(referTo.frame.origin.x, measure.frame.origin.y + heigt, size.width, size.height);
        [sc addSubview:mesa];
        UIImageView *spot0 = [[UIImageView alloc] initWithFrame:CGRectMake(lab.frame.origin.x+5, mesa.frame.origin.y+5, 11, 11)];
        spot0.image = [UIImage imageNamed:@"jilu-dian" ofSex:self.sex];
        [sc addSubview:spot0];
        heigt = heigt + size.height+10;
    }
    sc.contentSize = CGSizeMake(sc.frame.size.width, measure.frame.origin.y + heigt);
    
    UIImageView *mov = [[UIImageView alloc] initWithFrame:CGRectMake(36,  measure.frame.origin.y + heigt+20, 360, 270)];
    mov.tag = 700;
    mov.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(movRun:)];
    
    mov.image = [UIImage imageNamed:@"celiangshengao1"];
    UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(mov.frame.size.width/2-33, mov.frame.size.height/2-33, 66, 66)];
    if (self.sex == 1) {
        iv.image = [UIImage imageNamed:@"play-1"];
    }else{
        iv.image = [UIImage imageNamed:@"play-0"];
    }
    [mov addSubview:iv];
    [mov addGestureRecognizer:tap];
    [sc addSubview:mov];
    sc.contentSize = CGSizeMake(sc.frame.size.width, sc.contentSize.height + mov.frame.size.height + 10 + 20);
    
    
    UILabel *beizhu = [[UILabel alloc] initWithFrame:CGRectMake(lab.frame.origin.x, sc.contentSize.height+10, 220, 20)];
    beizhu.text = @"备注";
    beizhu.textColor = WORDDARKCOLOR;
    beizhu.font = [UIFont yaHeiFontOfSize:_sizeOfFont];
    [sc addSubview:beizhu];
    NSArray *beiz = [shenchang objectForKey:@"备注"];
    int heigt1 = 30;
    for (int i=0; i<[beiz count]; i++) {
        
//        CGRect rect = [beiz[i] boundingRectWithSize:CGSizeMake(sc.frame.size.width-referTo.frame.origin.x, 2000) options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil];
        UILabel *mesa = [[UILabel alloc] initWithFrame:CGRectMake(referTo.frame.origin.x, beizhu.frame.origin.y + heigt1,  sc.frame.size.width-referTo.frame.origin.x, 400)];
        mesa.text = beiz[i];
        mesa.textColor = WORDDARKCOLOR;
        mesa.numberOfLines = 0;
        mesa.font = font;
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:mesa.text];;
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
        [paragraphStyle setLineSpacing:10];
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, mesa.text.length)];
        
        mesa.attributedText = attributedString;
        CGSize size = [mesa sizeThatFits:CGSizeMake(sc.frame.size.width-referTo.frame.origin.x, 2000)];
        mesa.frame = CGRectMake(referTo.frame.origin.x, beizhu.frame.origin.y + heigt1, size.width, size.height);
        
        [sc addSubview:mesa];
        UIImageView *spot0 = [[UIImageView alloc] initWithFrame:CGRectMake(lab.frame.origin.x+5, mesa.frame.origin.y+5, 11, 11)];
        spot0.image = [UIImage imageNamed:@"jilu-dian" ofSex:self.sex];
        [sc addSubview:spot0];
        heigt1 = heigt1 + size.height+10;
    }
    sc.contentSize = CGSizeMake(sc.frame.size.width, beizhu.frame.origin.y + heigt1);
    [_right0 addSubview:sc];
    
}

-(NSString *)GetLocalDocPath{
    
    //document的路径
    NSFileManager *manager = [NSFileManager defaultManager];

    NSString *path =[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
    
    path =[path stringByAppendingPathComponent:@"download"];
    //创建文件夹
    if(![manager fileExistsAtPath:path])
    {
        [manager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    return path;
}

#pragma mark - 视频播放
-(void)movRun:(UITapGestureRecognizer *)tap{
    NSURL *url = nil;
    
    if (tap.view.tag<710) {
        NSString *mov = [[NSBundle mainBundle] pathForResource:_movArr[tap.view.tag-700] ofType:@"mov"];
        url = [NSURL fileURLWithPath:mov];
        

    }else{
        NSFileManager *manager = [NSFileManager defaultManager];
        NSString *path = [NSString urlStringOfImage:[_netMovArr objectAtIndex:tap.view.tag-710]];
        NSArray *arr =[path componentsSeparatedByString:@"/"];
        
        NSString *filePath =[[self GetLocalDocPath] stringByAppendingPathComponent:[NSString stringWithFormat:@"%d/%@",_month,[arr lastObject]]];
        
        NSLog(@"filePath = %@",filePath);
        if ([manager fileExistsAtPath:filePath]){
            
            url = [NSURL fileURLWithPath:filePath];
            
        }else{
            url = [NSURL URLWithString:path];

        }
    }
    
    DetailViewController *dvc = [[DetailViewController alloc] initWithContentURL:url];
                   
    dvc.moviePlayer.scalingMode = MPMovieScalingModeAspectFit;
    dvc.moviePlayer.shouldAutoplay = YES;
    [dvc.moviePlayer prepareToPlay];
    [self presentViewController:dvc animated:NO completion:nil];
    //        [self presentMoviePlayerViewControllerAnimated:dvc];
    dvc.moviePlayer.controlStyle = MPMovieControlStyleNone;
    
    [dvc.moviePlayer.view setBackgroundColor:[UIColor clearColor]];
    //        dvc.moviewControlMode = MPMovieControlModeHidden;
    
    
}

-(void)createRight1{
    UIScrollView *sc = [[UIScrollView alloc] initWithFrame:CGRectMake(40, 40, FRAMEOFRIGHTVIEW.size.width-80, FRAMEOFRIGHTVIEW.size.height-40)];
    sc.tag = 1234567;

    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(160, 5, FRAMEOFRIGHTVIEW.size.width-400, 44)];
    title.text = @"体重";
    title.textAlignment = NSTextAlignmentCenter;
    title.font = [UIFont yaHeiFontOfSize:30];
    title.textColor = wordColor;
    [sc addSubview:title];
    
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(sc.frame.size.width/2-117, 73, 234, 57)];
    textField.keyboardType = UIKeyboardTypeNumberPad;
    textField.placeholder = @"请输入宝宝的体重";
    textField.userInteractionEnabled = _readTag;
    [textField setLeftViewOfBlankforWidth:8];

    textField.background = [UIImage imageNamed:@"jilu-shuru" ofSex:self.sex];
    textField.tag = 501;
    UILabel *currentLabel = (UILabel *)[self.view viewWithTag:textField.tag-100];

    textField.text = currentLabel.text;
    
    
    if ([currentLabel.text intValue] == 0) {
        textField.text = nil;
    }
    textField.delegate = self;
    [self setInputAccessoryViewByElsa:textField];
    [sc addSubview:textField];
    
    UILabel *unit = [[UILabel alloc] initWithFrame:CGRectMake(textField.frame.origin.x+textField.frame.size.width+5, textField.frame.origin.y, 80, textField.frame.size.height)];
    unit.text = @"公斤";
    unit.font = [UIFont yaHeiFontOfSize:22];
    unit.textColor = WORDDARKCOLOR;
    [sc addSubview:unit];
    
    NSDictionary *tizhong = [_record objectForKey:@"体重"];
    NSString *cankao;
    if (self.sex == 0) {
        cankao = [tizhong objectForKey:@"参考值0"][_month-1];
    }else{
        cankao = [tizhong objectForKey:@"参考值1"][_month-1];
        
    }
    //    54,190
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(30, 150, FRAMEOFRIGHTVIEW.size.width-108, 20)];
    lab.text = @"参考值：";
    lab.textColor = WORDDARKCOLOR;
    lab.font = [UIFont yaHeiFontOfSize:_sizeOfFont];
    [sc addSubview:lab];
    //30
    UIImageView *spot = [[UIImageView alloc] initWithFrame:CGRectMake(lab.frame.origin.x+5, lab.frame.origin.y + 5 + 30, 11, 11)];
    spot.image = [UIImage imageNamed:@"jilu-dian" ofSex:self.sex];
    [sc addSubview:spot];
    UILabel *referTo = [[UILabel alloc] initWithFrame:CGRectMake(spot.frame.origin.x + spot.frame.size.width+5, spot.frame.origin.y-5, lab.frame.size.width - 100, 20)];
    referTo.text = cankao;
    referTo.textColor = WORDDARKCOLOR;
    referTo.font = [UIFont yaHeiFontOfSize:_sizeOfFont];
    [sc addSubview:referTo];
    sc.contentSize = CGSizeMake(sc.frame.size.width, referTo.frame.origin.y+referTo.frame.size.height);
    if ([[tizhong objectForKey:@"增长"][_month] length]>0) {
        UIImageView *spot0 = [[UIImageView alloc] initWithFrame:CGRectMake(lab.frame.origin.x+5, lab.frame.origin.y + 5 + 30 + 30, 11, 11)];
        spot0.image = [UIImage imageNamed:@"jilu-dian" ofSex:self.sex];
        [sc addSubview:spot0];
        UILabel *referTo0 = [[UILabel alloc] initWithFrame:CGRectMake(spot.frame.origin.x + spot.frame.size.width+5, spot.frame.origin.y-5, lab.frame.size.width - 100, 20)];
        referTo0.text = [tizhong objectForKey:@"增长"][_month];
        referTo0.textColor = WORDDARKCOLOR;
        referTo0.font = [UIFont yaHeiFontOfSize:16];
        CGSize size = [referTo0 sizeThatFits:CGSizeMake(sc.frame.size.width-referTo.frame.origin.x, 2000)];
        referTo0.frame = CGRectMake(spot0.frame.origin.x + spot0.frame.size.width+5, spot0.frame.origin.y-5, size.width, size.height);
        [sc addSubview:referTo0];
        sc.contentSize = CGSizeMake(sc.frame.size.width, referTo0.frame.origin.y+referTo0.frame.size.height);
    };
    UILabel *measure = [[UILabel alloc] initWithFrame:CGRectMake(lab.frame.origin.x, sc.contentSize.height + 10,220, 20)];
    measure.text = @"家庭正确的身长测量方法：";
    measure.textColor = WORDDARKCOLOR;
    measure.font = [UIFont yaHeiFontOfSize:_sizeOfFont];
    [sc addSubview:measure];
    NSArray *measu = [tizhong objectForKey:@"家庭正确的身长测量方法"];
    UIFont *font = [UIFont yaHeiFontOfSize:_sizeOfFont];
    NSDictionary *dict = [NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName];
    int heigt = 30;
    for (int i=0; i<[measu count]; i++) {
        
//        CGRect rect = [measu[i] boundingRectWithSize:CGSizeMake(sc.frame.size.width-referTo.frame.origin.x, 2000) options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil];
        UILabel *mesa = [[UILabel alloc] initWithFrame:CGRectMake(referTo.frame.origin.x, measure.frame.origin.y + heigt,  sc.frame.size.width-referTo.frame.origin.x, 400)];
        mesa.text = measu[i];
        mesa.textColor = WORDDARKCOLOR;
        mesa.numberOfLines = 0;
        mesa.font = font;
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:mesa.text];;
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
        [paragraphStyle setLineSpacing:10];
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, mesa.text.length)];
        
        mesa.attributedText = attributedString;
        CGSize size = [mesa sizeThatFits:CGSizeMake(sc.frame.size.width-referTo.frame.origin.x, 2000)];
        mesa.frame = CGRectMake(referTo.frame.origin.x, measure.frame.origin.y + heigt, size.width, size.height);
        [sc addSubview:mesa];
        UIImageView *spot0 = [[UIImageView alloc] initWithFrame:CGRectMake(lab.frame.origin.x+5, mesa.frame.origin.y+5, 11, 11)];
        spot0.image = [UIImage imageNamed:@"jilu-dian" ofSex:self.sex];
        [sc addSubview:spot0];
        heigt = heigt + size.height+10;
    }
    sc.contentSize = CGSizeMake(sc.frame.size.width, measure.frame.origin.y + heigt);
    
    UIImageView *mov = [[UIImageView alloc] initWithFrame:CGRectMake(36,  measure.frame.origin.y + heigt+20, 360, 270)];
    mov.tag = 701;
    mov.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(movRun:)];
    
    mov.image = [UIImage imageNamed:@"celiangtizhong1"];
    UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(mov.frame.size.width/2-33, mov.frame.size.height/2-33, 66, 66)];
    if (self.sex == 1) {
        iv.image = [UIImage imageNamed:@"play-1"];
    }else{
        iv.image = [UIImage imageNamed:@"play-0"];
    }
    [mov addSubview:iv];
    [mov addGestureRecognizer:tap];
    [sc addSubview:mov];
    sc.contentSize = CGSizeMake(sc.frame.size.width, sc.contentSize.height + mov.frame.size.height + 10 + 20);
    
    
    UILabel *beizhu = [[UILabel alloc] initWithFrame:CGRectMake(lab.frame.origin.x, sc.contentSize.height+10, 220, 20)];
    beizhu.text = @"备注";
    beizhu.textColor = WORDDARKCOLOR;
    beizhu.font = [UIFont yaHeiFontOfSize:_sizeOfFont];
    [sc addSubview:beizhu];
    NSArray *beiz = [tizhong objectForKey:@"备注"];
    int heigt1 = 30;
    for (int i=0; i<[beiz count]; i++) {
        
//        CGRect rect = [beiz[i] boundingRectWithSize:CGSizeMake(sc.frame.size.width-referTo.frame.origin.x, 2000) options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil];
        UILabel *mesa = [[UILabel alloc] initWithFrame:CGRectMake(referTo.frame.origin.x, beizhu.frame.origin.y + heigt1,  sc.frame.size.width-referTo.frame.origin.x, 400)];
        mesa.text = beiz[i];
        mesa.textColor = WORDDARKCOLOR;
        mesa.numberOfLines = 0;
        mesa.font = font;
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:mesa.text];;
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
        [paragraphStyle setLineSpacing:10];
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, mesa.text.length)];
        
        mesa.attributedText = attributedString;
        CGSize size = [mesa sizeThatFits:CGSizeMake(sc.frame.size.width-referTo.frame.origin.x, 2000)];
        mesa.frame = CGRectMake(referTo.frame.origin.x, beizhu.frame.origin.y + heigt1, size.width, size.height);
        [sc addSubview:mesa];
        UIImageView *spot0 = [[UIImageView alloc] initWithFrame:CGRectMake(lab.frame.origin.x+5, mesa.frame.origin.y+5, 11, 11)];
        spot0.image = [UIImage imageNamed:@"jilu-dian" ofSex:self.sex];
        [sc addSubview:spot0];
        heigt1 = heigt1 + size.height+10;
    }
    sc.contentSize = CGSizeMake(sc.frame.size.width, beizhu.frame.origin.y + heigt1);
    [_right1 addSubview:sc];
    

}

-(void)createRight2{
    
    UIScrollView *sc = [[UIScrollView alloc] initWithFrame:CGRectMake(40, 40, FRAMEOFRIGHTVIEW.size.width-80, FRAMEOFRIGHTVIEW.size.height-40)];
    sc.tag = 1234567;

    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(100, 5, sc.frame.size.width-200, 44)];
    title.text = @"人乳喂养次数";
    title.textAlignment = NSTextAlignmentCenter;
    title.font = [UIFont yaHeiFontOfSize:30];
    title.textColor = wordColor;
    [sc addSubview:title];
    
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(sc.frame.size.width/2-117, 73, 234, 57)];
    textField.keyboardType = UIKeyboardTypeNumberPad;
    textField.placeholder = @"请输入人乳喂养次数";
    [textField setLeftViewOfBlankforWidth:8];

    textField.background = [UIImage imageNamed:@"jilu-shuru" ofSex:self.sex];
    textField.tag = 502;
    textField.delegate = self;
    textField.userInteractionEnabled = _readTag;
    UILabel *currentLabel = (UILabel *)[self.view viewWithTag:textField.tag-100];
    
    textField.text = currentLabel.text;
    
    if ([currentLabel.text intValue] == 0) {
        textField.text = nil;
    }
    [self setInputAccessoryViewByElsa:textField];
    [sc addSubview:textField];
    
    UILabel *unit = [[UILabel alloc] initWithFrame:CGRectMake(textField.frame.origin.x+textField.frame.size.width+5, textField.frame.origin.y, 80, textField.frame.size.height)];
    unit.text = @"次/天";
    unit.font = [UIFont yaHeiFontOfSize:22];
    unit.textColor = WORDDARKCOLOR;
    [sc addSubview:unit];
    
    UILabel *title1 = [[UILabel alloc] initWithFrame:CGRectMake(100, 5+150, sc.frame.size.width-200, 44)];
    title1.text = @"人乳喂养量";
    title1.textAlignment = NSTextAlignmentCenter;
    title1.font = [UIFont yaHeiFontOfSize:30];
    title1.textColor = wordColor;
    [sc addSubview:title1];
    
    UITextField *textField1 = [[UITextField alloc] initWithFrame:CGRectMake(sc.frame.size.width/2-117, 73+150, 234, 57)];
    textField1.keyboardType = UIKeyboardTypeNumberPad;
    textField1.placeholder = @"请输入人乳喂养量";
    [textField1 setLeftViewOfBlankforWidth:8];

    textField1.background = [UIImage imageNamed:@"jilu-shuru" ofSex:self.sex];
    textField1.tag = 503;
    textField1.delegate = self;
    textField1.userInteractionEnabled = _readTag;
    UILabel *currentLabel1 = (UILabel *)[self.view viewWithTag:textField1.tag-100];
    
    textField1.text = currentLabel1.text;
    
    if ([currentLabel.text intValue] == 0) {
        textField1.text = nil;
    }
    [self setInputAccessoryViewByElsa:textField1];
    [sc addSubview:textField1];
    
    UILabel *unit1 = [[UILabel alloc] initWithFrame:CGRectMake(textField1.frame.origin.x+textField1.frame.size.width+5, textField1.frame.origin.y, 80, textField1.frame.size.height)];
    unit1.text = @"毫升/天";
    unit1.font = [UIFont yaHeiFontOfSize:22];
    unit1.textColor = WORDDARKCOLOR;
    [sc addSubview:unit1];
    
    
    UILabel *title2 = [[UILabel alloc] initWithFrame:CGRectMake(100, 5+150+150, sc.frame.size.width-200, 44)];
    title2.text = @"配方奶喂养";
    title2.textAlignment = NSTextAlignmentCenter;
    title2.font = [UIFont yaHeiFontOfSize:30];
    title2.textColor = wordColor;
    [sc addSubview:title2];
    
    UITextField *textField2 = [[UITextField alloc] initWithFrame:CGRectMake(sc.frame.size.width/2-117, 73+150+150, 234, 57)];
    textField2.keyboardType = UIKeyboardTypeNumberPad;
    textField2.placeholder = @"请输入配方奶哺喂量";
    [textField2 setLeftViewOfBlankforWidth:8];

    textField2.background = [UIImage imageNamed:@"jilu-shuru" ofSex:self.sex];
    textField2.tag = 504;
    textField2.delegate = self;
    textField2.userInteractionEnabled = _readTag;
    UILabel *currentLabel2 = (UILabel *)[self.view viewWithTag:textField2.tag-100];
    
    textField2.text = currentLabel2.text;
    
    if ([currentLabel.text intValue] == 0) {
        textField2.text = nil;
    }
    [self setInputAccessoryViewByElsa:textField2];
    [sc addSubview:textField2];
    
    UILabel *unit2 = [[UILabel alloc] initWithFrame:CGRectMake(textField2.frame.origin.x+textField2.frame.size.width+5, textField2.frame.origin.y, 80, textField2.frame.size.height)];
    unit2.text = @"毫升/天";
    unit2.font = [UIFont yaHeiFontOfSize:22];
    unit2.textColor = WORDDARKCOLOR;
    [sc addSubview:unit2];
    sc.contentSize = CGSizeMake(sc.frame.size.width, textField2.frame.origin.y+80);
    
    
    
    
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(30, sc.contentSize.height + 10, FRAMEOFRIGHTVIEW.size.width-108, 20)];
    lab.text = @"参考值：";
    lab.textColor = WORDDARKCOLOR;
    lab.font = [UIFont yaHeiFontOfSize:_sizeOfFont];
    [sc addSubview:lab];
    //30
    UIImageView *spot = [[UIImageView alloc] initWithFrame:CGRectMake(lab.frame.origin.x+5, lab.frame.origin.y + 5 + 30, 11, 11)];
    spot.image = [UIImage imageNamed:@"jilu-dian" ofSex:self.sex];
    [sc addSubview:spot];
    UILabel *referTo = [[UILabel alloc] initWithFrame:CGRectMake(spot.frame.origin.x + spot.frame.size.width+5, spot.frame.origin.y-5, lab.frame.size.width - 100, 20)];
    NSDictionary *naiLiang = [_record objectForKey:@"奶量"];
    referTo.text = [naiLiang objectForKey:@"参考值"][_month-1];
    referTo.textColor = WORDDARKCOLOR;
    referTo.font = [UIFont yaHeiFontOfSize:_sizeOfFont];
    referTo.numberOfLines = 0;
    
    CGSize size0 = [referTo sizeThatFits:CGSizeMake(sc.frame.size.width-referTo.frame.origin.x, 2000)];
    
    referTo.frame = CGRectMake(spot.frame.origin.x + spot.frame.size.width+5, spot.frame.origin.y-5, size0.width, size0.height);
    
    
    [sc addSubview:referTo];
    sc.contentSize = CGSizeMake(sc.frame.size.width, referTo.frame.origin.y+referTo.frame.size.height+5);
    
    UIFont *font = [UIFont yaHeiFontOfSize:_sizeOfFont];
    NSDictionary *dict = [NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName];
    int heigt = 10;
    if (_month<=12) {
        UILabel *muruwei = [[UILabel alloc] initWithFrame:CGRectMake(lab.frame.origin.x, referTo.frame.origin.y + referTo.frame.size.height + heigt,220, 20)];
        muruwei.text = @"母乳喂养";
        muruwei.textColor = WORDDARKCOLOR;
        muruwei.font = [UIFont yaHeiFontOfSize:_sizeOfFont];
        [sc addSubview:muruwei];
        heigt = heigt + 30;
        
        NSArray *muru = [naiLiang objectForKey:@"0~11母乳喂养"];
        for (int i=0; i<[muru count]; i++) {
//            CGRect rect = [muru[i] boundingRectWithSize:CGSizeMake(sc.frame.size.width-referTo.frame.origin.x, 2000) options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil];
            UILabel *mesa = [[UILabel alloc] initWithFrame:CGRectMake(referTo.frame.origin.x, referTo.frame.origin.y + referTo.frame.size.height + heigt, sc.frame.size.width-referTo.frame.origin.x, 400)];
            mesa.text = muru[i];
            mesa.textColor = WORDDARKCOLOR;
            mesa.numberOfLines = 0;
            mesa.font = font;
            NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:mesa.text];;
            NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
            [paragraphStyle setLineSpacing:10];
            [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, mesa.text.length)];
            
            mesa.attributedText = attributedString;
            CGSize size = [mesa sizeThatFits:CGSizeMake(sc.frame.size.width-referTo.frame.origin.x, 2000)];
            mesa.frame = CGRectMake(referTo.frame.origin.x, referTo.frame.origin.y + referTo.frame.size.height + heigt, size.width, size.height);
            [sc addSubview:mesa];
            UIImageView *spot0 = [[UIImageView alloc] initWithFrame:CGRectMake(lab.frame.origin.x+5, mesa.frame.origin.y+5, 11, 11)];
            spot0.image = [UIImage imageNamed:@"jilu-dian" ofSex:self.sex];
            [sc addSubview:spot0];
            heigt = heigt + size.height+10;
        }
    }
    UILabel *peiFangN = [[UILabel alloc] initWithFrame:CGRectMake(lab.frame.origin.x, referTo.frame.origin.y + referTo.frame.size.height + heigt,220, 20)];
    peiFangN.text = @"配方奶喂养";
    peiFangN.textColor = WORDDARKCOLOR;
    peiFangN.font = [UIFont yaHeiFontOfSize:_sizeOfFont];
    [sc addSubview:peiFangN];
    heigt = heigt + 30;
    NSDictionary *peifang = [naiLiang objectForKey:@"配方奶喂养"];
    NSString *peifangnailiang;
    if (_month>4) {
        peifangnailiang = [peifang objectForKey:@"4个月以后"];
        
    }else{
        peifangnailiang = [peifang objectForKey:@"0~3个月"];
    }
        CGRect rect = [peifangnailiang boundingRectWithSize:CGSizeMake(sc.frame.size.width-referTo.frame.origin.x, 2000) options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil];
        UILabel *mesa = [[UILabel alloc] initWithFrame:CGRectMake(referTo.frame.origin.x, referTo.frame.origin.y + referTo.frame.size.height + heigt, rect.size.width, rect.size.height)];
        mesa.text = peifangnailiang;
        mesa.textColor = WORDDARKCOLOR;
        mesa.numberOfLines = 0;
        mesa.font = font;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:mesa.text];;
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    [paragraphStyle setLineSpacing:10];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, mesa.text.length)];
    
    mesa.attributedText = attributedString;
    CGSize size = [mesa sizeThatFits:CGSizeMake(sc.frame.size.width-referTo.frame.origin.x, 2000)];
    
    mesa.frame = CGRectMake(referTo.frame.origin.x, referTo.frame.origin.y + referTo.frame.size.height + heigt, size.width, size.height);
    [sc addSubview:mesa];
    UIImageView *spot0 = [[UIImageView alloc] initWithFrame:CGRectMake(lab.frame.origin.x+5, mesa.frame.origin.y+5, 11, 11)];
    spot0.image = [UIImage imageNamed:@"jilu-dian" ofSex:self.sex];
    [sc addSubview:spot0];
    heigt = heigt + size.height+10;
    
    UILabel *naizhipin = [[UILabel alloc] initWithFrame:CGRectMake(lab.frame.origin.x, referTo.frame.origin.y + referTo.frame.size.height + heigt,220, 20)];
    naizhipin.text = @"其他奶制品喂养";
    naizhipin.textColor = WORDDARKCOLOR;
    naizhipin.font = [UIFont yaHeiFontOfSize:_sizeOfFont];
    [sc addSubview:naizhipin];
    heigt = heigt + 30;
    NSArray *naizhi = [naiLiang objectForKey:@"其他奶制品喂养"];
    for (int i=0; i<[naizhi count]; i++) {
        
        CGRect rect = [naizhi[i] boundingRectWithSize:CGSizeMake(sc.frame.size.width-referTo.frame.origin.x, 2000) options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil];
        UILabel *mesa = [[UILabel alloc] initWithFrame:CGRectMake(referTo.frame.origin.x, referTo.frame.origin.y + referTo.frame.size.height + heigt, rect.size.width, rect.size.height+20)];
        mesa.text = naizhi[i];
        mesa.textColor = WORDDARKCOLOR;
        mesa.numberOfLines = 0;
        mesa.font = font;
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:mesa.text];;
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
        [paragraphStyle setLineSpacing:10];
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, mesa.text.length)];
        
        mesa.attributedText = attributedString;
        CGSize size = [mesa sizeThatFits:CGSizeMake(sc.frame.size.width-referTo.frame.origin.x, 2000)];
        mesa.frame = CGRectMake(referTo.frame.origin.x, referTo.frame.origin.y + referTo.frame.size.height + heigt, size.width, size.height);
        [sc addSubview:mesa];
        UIImageView *spot0 = [[UIImageView alloc] initWithFrame:CGRectMake(lab.frame.origin.x+5, mesa.frame.origin.y+5, 11, 11)];
        spot0.image = [UIImage imageNamed:@"jilu-dian" ofSex:self.sex];
        [sc addSubview:spot0];
        heigt = heigt + size.height+20+10;
    }
    int numbOfmov = 1;
    if (_month > 12) {
        numbOfmov = 1;
    }else{
        numbOfmov = 6;
    }
    
    for (int i=0; i<numbOfmov; i++) {
        UIImageView *mov = [[UIImageView alloc] initWithFrame:CGRectMake(36,  referTo.frame.origin.y + referTo.frame.size.height + heigt+20, 360, 270)];
        
        mov.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(movRun:)];
        if (numbOfmov == 1) {
            mov.image = [UIImage imageNamed:_movArr[_movArr.count - 1]];
            mov.tag = 704+5;

        }else{
            mov.image = [UIImage imageNamed:_movArr[4+i]];
            mov.tag = 704+i;
        }
        UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(mov.frame.size.width/2-33, mov.frame.size.height/2-33, 66, 66)];
        if (self.sex == 1) {
            iv.image = [UIImage imageNamed:@"play-1"];
        }else{
            iv.image = [UIImage imageNamed:@"play-0"];
        }
        [mov addSubview:iv];
        [mov addGestureRecognizer:tap];
        [sc addSubview:mov];
        heigt = heigt + mov.frame.size.height;
    }
    
    sc.contentSize = CGSizeMake(sc.frame.size.width, referTo.frame.origin.y + referTo.frame.size.height + heigt + 30);
    [_right2 addSubview:sc];

}
-(void)createRight3{
    
    UIScrollView *sc = [[UIScrollView alloc] initWithFrame:CGRectMake(40, 40, FRAMEOFRIGHTVIEW.size.width-80, FRAMEOFRIGHTVIEW.size.height-40)];
    sc.tag = 1234567;

    
    
    [_right3 addSubview:sc];
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(100, 5, sc.frame.size.width-200, 44)];
    title.text = @"夜间睡眠时间";
    title.textAlignment = NSTextAlignmentCenter;
    title.font = [UIFont yaHeiFontOfSize:30];
    title.textColor = wordColor;
    [sc addSubview:title];
    
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(sc.frame.size.width/2-117, 73, 234, 57)];
    textField.keyboardType = UIKeyboardTypeNumberPad;
    textField.placeholder = @"请输入夜间睡眠时间";
    [textField setLeftViewOfBlankforWidth:8];

    textField.background = [UIImage imageNamed:@"jilu-shuru" ofSex:self.sex];
    textField.tag = 505;
    textField.delegate = self;
    textField.userInteractionEnabled = _readTag;
    UILabel *currentLabel = (UILabel *)[self.view viewWithTag:textField.tag-100];
    
    textField.text = currentLabel.text;
    
    if ([currentLabel.text intValue] == 0) {
        textField.text = nil;
    }
    [self setInputAccessoryViewByElsa:textField];
    [sc addSubview:textField];
    
    UILabel *unit = [[UILabel alloc] initWithFrame:CGRectMake(textField.frame.origin.x+textField.frame.size.width+5, textField.frame.origin.y, 80, textField.frame.size.height)];
    unit.text = @"小时/天";
    unit.font = [UIFont yaHeiFontOfSize:22];
    unit.textColor = WORDDARKCOLOR;
    [sc addSubview:unit];
    
    
   
    UILabel *title1 = [[UILabel alloc] initWithFrame:CGRectMake(100, 5+150, sc.frame.size.width-200, 44)];
    title1.text = @"白天睡眠时间";
    title1.textAlignment = NSTextAlignmentCenter;
    title1.font = [UIFont yaHeiFontOfSize:30];
    title1.textColor = wordColor;
    [sc addSubview:title1];
    
    UITextField *textField1 = [[UITextField alloc] initWithFrame:CGRectMake(sc.frame.size.width/2-117, 73+150, 234, 57)];
    textField1.keyboardType = UIKeyboardTypeNumberPad;
    textField1.placeholder = @"请输入白天睡眠时间";
    textField1.background = [UIImage imageNamed:@"jilu-shuru" ofSex:self.sex];
    textField1.tag = 506;
    [self setInputAccessoryViewByElsa:textField1];
    textField1.delegate = self;
    [textField1 setLeftViewOfBlankforWidth:8];

    textField1.userInteractionEnabled = _readTag;
    UILabel *currentLabel1 = (UILabel *)[self.view viewWithTag:textField1.tag-100];
    
    textField1.text = currentLabel1.text;
    
    if ([currentLabel.text intValue] == 0) {
        textField1.text = nil;
    }
    [sc addSubview:textField1];
    
    UILabel *unit1 = [[UILabel alloc] initWithFrame:CGRectMake(textField1.frame.origin.x+textField1.frame.size.width+5, textField1.frame.origin.y, 80, textField1.frame.size.height)];
    unit1.text = @"小时/天";
    unit1.font = [UIFont yaHeiFontOfSize:22];
    unit1.textColor = WORDDARKCOLOR;
    [sc addSubview:unit1];
    
    NSDictionary *shuimian = [_record objectForKey:@"睡眠"];
    NSArray *yejian = [shuimian objectForKey:@"夜间睡眠时间"];
    NSArray *rijian = [shuimian objectForKey:@"日间睡眠时间"];
    NSArray *zongji = [shuimian objectForKey:@"总计睡眠时间"];
    NSString *str = [NSString stringWithFormat:@"%d个月的宝宝，平均夜间睡眠时间为%@，平均日间睡眠时间为%@，平均总计睡眠时间为%@",_month,yejian[_month-1],rijian[_month-1],zongji[_month-1]];
    
    //150
    
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(30, unit1.frame.origin.y + unit1.frame.size.height + 10, sc.frame.size.width-60, 150)];
    lab.text = str;
    lab.textColor = WORDDARKCOLOR;
    lab.numberOfLines = 3;
    lab.font = [UIFont yaHeiFontOfSize:_sizeOfFont];
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:lab.text];;
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    [paragraphStyle setLineSpacing:10];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, lab.text.length)];
    
    lab.attributedText = attributedString;
    CGSize size = [lab sizeThatFits:CGSizeMake(sc.frame.size.width-60, 2000)];
    lab.frame = CGRectMake(30, unit1.frame.origin.y + unit1.frame.size.height + 10, size.width, size.height);
    
    [sc addSubview:lab];
    
    sc.contentSize = CGSizeMake(sc.frame.size.width, lab.frame.origin.y + lab.frame.size.height + 10);
}
-(void)createRight4{
    
    UIScrollView *sc = [[UIScrollView alloc] initWithFrame:CGRectMake(40, 40, FRAMEOFRIGHTVIEW.size.width-80, FRAMEOFRIGHTVIEW.size.height-40)];
    sc.tag = 1234567;

    
    
    [_right4 addSubview:sc];
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(100, 5, sc.frame.size.width-200, 44)];
    title.text = @"排尿次数";
    title.textAlignment = NSTextAlignmentCenter;
    title.font = [UIFont yaHeiFontOfSize:30];
    title.textColor = wordColor;
    [sc addSubview:title];
    
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(sc.frame.size.width/2-117, 73, 234, 57)];
    textField.keyboardType = UIKeyboardTypeNumberPad;
    textField.placeholder = @"请输入排尿次数";
    [textField setLeftViewOfBlankforWidth:8];

    textField.background = [UIImage imageNamed:@"jilu-shuru" ofSex:self.sex];
    textField.tag = 507;
    textField.delegate = self;
    textField.userInteractionEnabled = _readTag;
    UILabel *currentLabel = (UILabel *)[self.view viewWithTag:textField.tag-100];
    
    textField.text = currentLabel.text;
    
    if ([currentLabel.text intValue] == 0) {
        textField.text = nil;
    }
    [self setInputAccessoryViewByElsa:textField];
    [sc addSubview:textField];
    
    UILabel *unit = [[UILabel alloc] initWithFrame:CGRectMake(textField.frame.origin.x+textField.frame.size.width+5, textField.frame.origin.y, 80, textField.frame.size.height)];
    unit.text = @"次";
    unit.font = [UIFont yaHeiFontOfSize:22];
    unit.textColor = WORDDARKCOLOR;
    [sc addSubview:unit];

    NSArray *painiao = [_record objectForKey:@"排尿"];
    
    //150
    
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(30, unit.frame.origin.y + unit.frame.size.height + 10, sc.frame.size.width-40, 150)];
    lab.text = painiao[0];
    NSLog(@"painiao = %@",painiao[0]);
    lab.textColor = WORDDARKCOLOR;
    lab.numberOfLines = 0;
    lab.font = [UIFont yaHeiFontOfSize:_sizeOfFont];
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:lab.text];;
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    [paragraphStyle setLineSpacing:10];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, lab.text.length)];
    
    lab.attributedText = attributedString;
    CGSize size = [lab sizeThatFits:CGSizeMake(sc.frame.size.width-40, 2000)];
    lab.frame = CGRectMake(30, unit.frame.origin.y + unit.frame.size.height + 10, size.width, size.height);
    
    [sc addSubview:lab];
    
    UILabel *lab1 = [[UILabel alloc] initWithFrame:CGRectMake(30, lab.frame.origin.y + lab.frame.size.height + 20, sc.frame.size.width-40, 150)];
    lab1.text = painiao[1];
    lab1.textColor = WORDDARKCOLOR;
    lab1.numberOfLines = 3;
    lab1.font = [UIFont yaHeiFontOfSize:_sizeOfFont];
    
    NSMutableAttributedString *attributedString1 = [[NSMutableAttributedString alloc]initWithString:lab1.text];;
    NSMutableParagraphStyle *paragraphStyle1 = [[NSMutableParagraphStyle alloc]init];
    [paragraphStyle1 setLineSpacing:10];
    [attributedString1 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, lab1.text.length)];
    
    lab1.attributedText = attributedString1;
    CGSize size1 = [lab1 sizeThatFits:CGSizeMake(sc.frame.size.width-40, 2000)];
    lab1.frame = CGRectMake(30, lab.frame.origin.y + lab.frame.size.height + 20, size1.width, size1.height);
    
    [sc addSubview:lab1];

    
    sc.contentSize = CGSizeMake(sc.frame.size.width, lab1.frame.origin.y + lab1.frame.size.height + 10);
}
-(void)createRight5{
    UIScrollView *sc = [[UIScrollView alloc] initWithFrame:CGRectMake(40, 40, FRAMEOFRIGHTVIEW.size.width-80, FRAMEOFRIGHTVIEW.size.height-40)];
    sc.tag = 1234567;

    
    [_right5 addSubview:sc];
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(100, 5, sc.frame.size.width-200, 44)];
    title.text = @"排便次数";
    title.textAlignment = NSTextAlignmentCenter;
    title.font = [UIFont yaHeiFontOfSize:30];
    title.textColor = wordColor;
    [sc addSubview:title];
    
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(sc.frame.size.width/2-117, 73, 234, 57)];
    textField.keyboardType = UIKeyboardTypeNumberPad;
    textField.placeholder = @"请输入排便次数";
    [textField setLeftViewOfBlankforWidth:8];

    textField.background = [UIImage imageNamed:@"jilu-shuru" ofSex:self.sex];
    textField.tag = 508;
    textField.delegate = self;
    textField.userInteractionEnabled = _readTag;
    UILabel *currentLabel = (UILabel *)[self.view viewWithTag:textField.tag-100];
    
    textField.text = currentLabel.text;
    
    if ([currentLabel.text intValue] == 0) {
        textField.text = nil;
    }
    [self setInputAccessoryViewByElsa:textField];
    [sc addSubview:textField];
    
    UILabel *unit = [[UILabel alloc] initWithFrame:CGRectMake(textField.frame.origin.x+textField.frame.size.width+5, textField.frame.origin.y, 80, textField.frame.size.height)];
    unit.text = @"次";
    unit.font = [UIFont yaHeiFontOfSize:22];
    unit.textColor = WORDDARKCOLOR;
    [sc addSubview:unit];
    
    NSArray *shuimian = [_record objectForKey:@"排便"];
    
    //150
    
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(30, unit.frame.origin.y + unit.frame.size.height + 10, sc.frame.size.width-40, 150)];
    lab.text = shuimian[_month-1];
    lab.textColor = WORDDARKCOLOR;
    lab.numberOfLines = 0;
    lab.font = [UIFont yaHeiFontOfSize:_sizeOfFont];
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:lab.text];;
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    [paragraphStyle setLineSpacing:10];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, lab.text.length)];
    
    lab.attributedText = attributedString;
    CGSize size = [lab sizeThatFits:CGSizeMake(sc.frame.size.width-40, 2000)];
    lab.frame = CGRectMake(30, unit.frame.origin.y + unit.frame.size.height + 10, size.width, size.height);
    
    [sc addSubview:lab];
    
    sc.contentSize = CGSizeMake(sc.frame.size.width, lab.frame.origin.y + lab.frame.size.height + 10);

}
-(void)createRight6{
    
    UIScrollView *sc = [[UIScrollView alloc] initWithFrame:CGRectMake(40, 40, FRAMEOFRIGHTVIEW.size.width-80, FRAMEOFRIGHTVIEW.size.height-40)];
    sc.tag = 1234567;

    
    [_right6 addSubview:sc];
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(160, 5, FRAMEOFRIGHTVIEW.size.width-400, 44)];
    title.text = @"头围";
    title.textAlignment = NSTextAlignmentCenter;
    title.font = [UIFont yaHeiFontOfSize:30];
    title.textColor = wordColor;
    [sc addSubview:title];
    
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(sc.frame.size.width/2-117, 73, 234, 57)];
    textField.keyboardType = UIKeyboardTypeNumberPad;
    textField.placeholder = @"请输入宝宝头围";
    [textField setLeftViewOfBlankforWidth:8];

    textField.background = [UIImage imageNamed:@"jilu-shuru" ofSex:self.sex];
    textField.tag = 509;
    textField.delegate = self;
    textField.userInteractionEnabled = _readTag;
    UILabel *currentLabel = (UILabel *)[self.view viewWithTag:textField.tag-100];
    
    textField.text = currentLabel.text;
    if ([currentLabel.text intValue] == 0) {
        textField.text = nil;
    }
    [self setInputAccessoryViewByElsa:textField];
    [sc addSubview:textField];
    
    UILabel *unit = [[UILabel alloc] initWithFrame:CGRectMake(textField.frame.origin.x+textField.frame.size.width+5, textField.frame.origin.y, 80, textField.frame.size.height)];
    unit.text = @"厘米";
    unit.font = [UIFont yaHeiFontOfSize:22];
    unit.textColor = WORDDARKCOLOR;
    [sc addSubview:unit];
    
    NSDictionary *touwei = [_record objectForKey:@"头围"];
    NSArray *canK = [touwei objectForKey:@"参考值"];
    
    NSString *cankao;
    
    if (self.sex == 0) {
        cankao = [canK[0] objectForKey:@"参考值0"][_month-1];
    }else{
        cankao = [canK[0] objectForKey:@"参考值1"][_month-1];
        
    }
    //    54,190
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(30, 150, FRAMEOFRIGHTVIEW.size.width-120, 20)];
    lab.text = @"参考值：";
    lab.textColor = WORDDARKCOLOR;
    lab.font = [UIFont yaHeiFontOfSize:_sizeOfFont];
    [sc addSubview:lab];
    //30
    if (cankao.length > 0) {
        UIImageView *spot = [[UIImageView alloc] initWithFrame:CGRectMake(lab.frame.origin.x+5, lab.frame.origin.y + 5 + 30, 11, 11)];
        spot.image = [UIImage imageNamed:@"jilu-dian" ofSex:self.sex];
        [sc addSubview:spot];
        UILabel *referTo = [[UILabel alloc] initWithFrame:CGRectMake(spot.frame.origin.x + spot.frame.size.width+5, spot.frame.origin.y-5, lab.frame.size.width - 100, 20)];
        referTo.text = cankao;
        referTo.textColor = WORDDARKCOLOR;
        referTo.font = [UIFont yaHeiFontOfSize:_sizeOfFont];
        [sc addSubview:referTo];
        sc.contentSize = CGSizeMake(sc.frame.size.width, referTo.frame.origin.y+referTo.frame.size.height);
    }
    
    NSArray *cankaozhi = [touwei objectForKey:@"参考值"][1][_month-1];
    int heigt = 30;
    for (int i=0; i<[cankaozhi count]; i++) {
        UIImageView *spot0 = [[UIImageView alloc] initWithFrame:CGRectMake(lab.frame.origin.x+5, lab.frame.origin.y + 5 + 30  + heigt+5, 11, 11)];
        spot0.image = [UIImage imageNamed:@"jilu-dian" ofSex:self.sex];
        [sc addSubview:spot0];
        UILabel *referTo0 = [[UILabel alloc] initWithFrame:CGRectMake(spot0.frame.origin.x + spot0.frame.size.width+5, spot0.frame.origin.y-10, lab.frame.size.width - 100, 20)];
        referTo0.text = cankaozhi[i];
        referTo0.textColor = WORDDARKCOLOR;
        referTo0.numberOfLines = 0;
        referTo0.font = [UIFont yaHeiFontOfSize:_sizeOfFont];
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:referTo0.text];;
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
        [paragraphStyle setLineSpacing:10];
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, referTo0.text.length)];
        
        referTo0.attributedText = attributedString;
        CGSize size = [referTo0 sizeThatFits:CGSizeMake(sc.frame.size.width-referTo0.frame.origin.x, 2000)];
        referTo0.frame = CGRectMake(spot0.frame.origin.x + spot0.frame.size.width+5, spot0.frame.origin.y-8, size.width, size.height);
        [sc addSubview:referTo0];
        heigt = heigt + 30;
        sc.contentSize = CGSizeMake(sc.frame.size.width, referTo0.frame.origin.y+referTo0.frame.size.height);
    }
    
    UILabel *measure = [[UILabel alloc] initWithFrame:CGRectMake(lab.frame.origin.x, sc.contentSize.height + 30,220, 20)];
    measure.text = @"家庭正确的身长测量方法：";
    measure.textColor = WORDDARKCOLOR;
    measure.font = [UIFont yaHeiFontOfSize:_sizeOfFont];
    [sc addSubview:measure];
    NSArray *measu = [touwei objectForKey:@"家庭正确头围测量方法"];
    UIFont *font = [UIFont yaHeiFontOfSize:_sizeOfFont];
//    NSDictionary *dict = [NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName];
    
    for (int i=0; i<[measu count]; i++) {
        
        //        CGRect rect = [measu[i] boundingRectWithSize:CGSizeMake(sc.frame.size.width-referTo.frame.origin.x, 2000) options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil];
        UILabel *mesa = [[UILabel alloc] initWithFrame:CGRectMake(lab.frame.origin.x+5+16, measure.frame.origin.y + heigt, sc.frame.size.width-lab.frame.origin.x+5+16, 300)];
        mesa.text = measu[i];
        mesa.textColor = WORDDARKCOLOR;
        mesa.numberOfLines = 0;
        mesa.font = font;
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:mesa.text];;
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
        [paragraphStyle setLineSpacing:10];
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, mesa.text.length)];
        
        mesa.attributedText = attributedString;
        CGSize size = [mesa sizeThatFits:CGSizeMake(sc.frame.size.width-lab.frame.origin.x-20, 2000)];
        mesa.frame = CGRectMake(lab.frame.origin.x+5+16, measure.frame.origin.y + heigt, size.width, size.height);
        [sc addSubview:mesa];
        UIImageView *spot0 = [[UIImageView alloc] initWithFrame:CGRectMake(lab.frame.origin.x+5, mesa.frame.origin.y+5, 11, 11)];
        spot0.image = [UIImage imageNamed:@"jilu-dian" ofSex:self.sex];
        [sc addSubview:spot0];
        heigt = heigt + size.height+10;
    }
    sc.contentSize = CGSizeMake(sc.frame.size.width, measure.frame.origin.y + heigt);
    
    UIImageView *mov = [[UIImageView alloc] initWithFrame:CGRectMake(36,  measure.frame.origin.y + heigt+20, 360, 270)];
    mov.tag = 702;
    mov.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(movRun:)];
    
    mov.image = [UIImage imageNamed:@"celiangtouwei1"];
    UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(mov.frame.size.width/2-33, mov.frame.size.height/2-33, 66, 66)];
    if (self.sex == 1) {
        iv.image = [UIImage imageNamed:@"play-1"];
    }else{
        iv.image = [UIImage imageNamed:@"play-0"];
    }
    [mov addSubview:iv];
    [mov addGestureRecognizer:tap];
    [sc addSubview:mov];
    sc.contentSize = CGSizeMake(sc.frame.size.width, sc.contentSize.height + mov.frame.size.height + 10 + 20);
    
    
    UILabel *beizhu = [[UILabel alloc] initWithFrame:CGRectMake(lab.frame.origin.x, sc.contentSize.height+10, 220, 20)];
    beizhu.text = @"备注";
    beizhu.textColor = WORDDARKCOLOR;
    beizhu.font = [UIFont yaHeiFontOfSize:_sizeOfFont];
    [sc addSubview:beizhu];
    NSString *beiz = [touwei objectForKey:@"备注"];
    int heigt1 = 30;
    UILabel *mesa = [[UILabel alloc] initWithFrame:CGRectMake(lab.frame.origin.x+5+16, beizhu.frame.origin.y + beizhu.frame.size.height + 10, sc.frame.size.width-lab.frame.origin.x+5+16, 400)];
    mesa.text = beiz;
    mesa.textColor = WORDDARKCOLOR;
    mesa.numberOfLines = 0;
    mesa.font = font;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:mesa.text];;
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    [paragraphStyle setLineSpacing:10];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, mesa.text.length)];
    
    mesa.attributedText = attributedString;
    CGSize size = [mesa sizeThatFits:CGSizeMake(sc.frame.size.width-lab.frame.origin.x-20, 2000)];
    mesa.frame = CGRectMake(lab.frame.origin.x+5+16,beizhu.frame.origin.y + beizhu.frame.size.height + 10, size.width, size.height);
//    mesa.backgroundColor = [UIColor redColor];
    [sc addSubview:mesa];
    UIImageView *spot0 = [[UIImageView alloc] initWithFrame:CGRectMake(lab.frame.origin.x+5, mesa.frame.origin.y+5, 11, 11)];
    spot0.image = [UIImage imageNamed:@"jilu-dian" ofSex:self.sex];
    [sc addSubview:spot0];
    heigt1 = heigt1 + size.height+10;
    
    sc.contentSize = CGSizeMake(sc.frame.size.width, beizhu.frame.origin.y + heigt1);
    
    

}
-(void)createRight7{
    
    
    UIScrollView *sc = [[UIScrollView alloc] initWithFrame:CGRectMake(40, 40, FRAMEOFRIGHTVIEW.size.width-80, FRAMEOFRIGHTVIEW.size.height-40)];
    sc.tag = 1234567;

    
    [_right7 addSubview:sc];
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(160, 5, FRAMEOFRIGHTVIEW.size.width-400, 44)];
    title.text = @"胸围";
    title.textAlignment = NSTextAlignmentCenter;
    title.font = [UIFont yaHeiFontOfSize:30];
    title.textColor = wordColor;
    [sc addSubview:title];
    
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(sc.frame.size.width/2-117, 73, 234, 57)];
    textField.keyboardType = UIKeyboardTypeNumberPad;
    textField.placeholder = @"请输入宝宝胸围";
    [textField setLeftViewOfBlankforWidth:8];

    textField.background = [UIImage imageNamed:@"jilu-shuru" ofSex:self.sex];
    textField.tag = 510;
    textField.delegate = self;
    textField.userInteractionEnabled = _readTag;
    UILabel *currentLabel = (UILabel *)[self.view viewWithTag:textField.tag-100];
    
    textField.text = currentLabel.text;
    if ([currentLabel.text intValue] == 0) {
        textField.text = nil;
    }
    [self setInputAccessoryViewByElsa:textField];
    [sc addSubview:textField];
    
    UILabel *unit = [[UILabel alloc] initWithFrame:CGRectMake(textField.frame.origin.x+textField.frame.size.width+5, textField.frame.origin.y, 80, textField.frame.size.height)];
    unit.text = @"厘米";
    unit.font = [UIFont yaHeiFontOfSize:22];
    unit.textColor = WORDDARKCOLOR;
    [sc addSubview:unit];
    
    NSDictionary *xiongwei = [_record objectForKey:@"胸围"];
    NSArray *canK = [xiongwei objectForKey:@"参考值"];
    
    NSString *cankao;
    
    if (self.sex == 0) {
        cankao = [canK[0] objectForKey:@"参考值0"][_month-1];
    }else{
        cankao = [canK[0] objectForKey:@"参考值1"][_month-1];
        
    }
    //    54,190
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(30, 150, FRAMEOFRIGHTVIEW.size.width-108, 20)];
    lab.text = @"参考值：";
    lab.textColor = WORDDARKCOLOR;
    lab.font = [UIFont yaHeiFontOfSize:_sizeOfFont];
    [sc addSubview:lab];
    //30
    UIImageView *spot = [[UIImageView alloc] initWithFrame:CGRectMake(lab.frame.origin.x+5, lab.frame.origin.y + 5 + 30, 11, 11)];
    spot.image = [UIImage imageNamed:@"jilu-dian" ofSex:self.sex];
    [sc addSubview:spot];
    UILabel *referTo = [[UILabel alloc] initWithFrame:CGRectMake(spot.frame.origin.x + spot.frame.size.width+5, spot.frame.origin.y-5, lab.frame.size.width - 100, 20)];
    referTo.text = cankao;
    referTo.textColor = WORDDARKCOLOR;
    referTo.font = [UIFont yaHeiFontOfSize:_sizeOfFont];
    [sc addSubview:referTo];
    sc.contentSize = CGSizeMake(sc.frame.size.width, referTo.frame.origin.y+referTo.frame.size.height);
    NSArray *cankaozhi = [xiongwei objectForKey:@"参考值"][1][_month-1];
    int heigt = 30;
    for (int i=0; i<[cankaozhi count]; i++) {
        UIImageView *spot0 = [[UIImageView alloc] initWithFrame:CGRectMake(lab.frame.origin.x+5, lab.frame.origin.y + 5 + 30  + heigt+5, 11, 11)];
        spot0.image = [UIImage imageNamed:@"jilu-dian" ofSex:self.sex];
        [sc addSubview:spot0];
        UILabel *referTo0 = [[UILabel alloc] initWithFrame:CGRectMake(spot0.frame.origin.x + spot0.frame.size.width+5, spot0.frame.origin.y-10, lab.frame.size.width - 100, 20)];
        referTo0.text = cankaozhi[i];
        referTo0.textColor = WORDDARKCOLOR;
        referTo0.numberOfLines = 0;
        referTo0.font = [UIFont yaHeiFontOfSize:_sizeOfFont];
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:referTo0.text];;
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
        [paragraphStyle setLineSpacing:10];
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, referTo0.text.length)];
        
        referTo0.attributedText = attributedString;
        CGSize size = [referTo0 sizeThatFits:CGSizeMake(sc.frame.size.width-referTo0.frame.origin.x, 2000)];
        referTo0.frame = CGRectMake(spot0.frame.origin.x + spot0.frame.size.width+5, spot0.frame.origin.y-8, size.width, size.height);
        [sc addSubview:referTo0];
        heigt = heigt + 30;
        sc.contentSize = CGSizeMake(sc.frame.size.width, referTo0.frame.origin.y+referTo0.frame.size.height);
    }
    
    UILabel *measure = [[UILabel alloc] initWithFrame:CGRectMake(lab.frame.origin.x, sc.contentSize.height + 30,220, 20)];
    measure.text = @"家庭正确的身长测量方法：";
    measure.textColor = WORDDARKCOLOR;
    measure.font = [UIFont yaHeiFontOfSize:_sizeOfFont];
    [sc addSubview:measure];
    NSArray *measu = [xiongwei objectForKey:@"家庭正确头围测量方法"];
    UIFont *font = [UIFont yaHeiFontOfSize:_sizeOfFont];
    //    NSDictionary *dict = [NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName];
    
    for (int i=0; i<[measu count]; i++) {
        
        //        CGRect rect = [measu[i] boundingRectWithSize:CGSizeMake(sc.frame.size.width-referTo.frame.origin.x, 2000) options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil];
        UILabel *mesa = [[UILabel alloc] initWithFrame:CGRectMake(referTo.frame.origin.x, measure.frame.origin.y + heigt, sc.frame.size.width-referTo.frame.origin.x, 300)];
        mesa.text = measu[i];
        mesa.textColor = WORDDARKCOLOR;
        mesa.numberOfLines = 0;
        mesa.font = font;
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:mesa.text];;
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
        [paragraphStyle setLineSpacing:10];
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, mesa.text.length)];
        
        mesa.attributedText = attributedString;
        CGSize size = [mesa sizeThatFits:CGSizeMake(sc.frame.size.width-referTo.frame.origin.x, 2000)];
        mesa.frame = CGRectMake(referTo.frame.origin.x, measure.frame.origin.y + heigt, size.width, size.height);
        [sc addSubview:mesa];
        UIImageView *spot0 = [[UIImageView alloc] initWithFrame:CGRectMake(lab.frame.origin.x+5, mesa.frame.origin.y+5, 11, 11)];
        spot0.image = [UIImage imageNamed:@"jilu-dian" ofSex:self.sex];
        [sc addSubview:spot0];
        heigt = heigt + size.height+10;
    }
    sc.contentSize = CGSizeMake(sc.frame.size.width, measure.frame.origin.y + heigt);
    
    UIImageView *mov = [[UIImageView alloc] initWithFrame:CGRectMake(36,  measure.frame.origin.y + heigt+20, 360, 270)];
    mov.tag = 703;
    
    mov.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(movRun:)];
    
    mov.image = [UIImage imageNamed:@"celiangxiongwei1"];
    UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(mov.frame.size.width/2-33, mov.frame.size.height/2-33, 66, 66)];
    if (self.sex == 1) {
        iv.image = [UIImage imageNamed:@"play-1"];
    }else{
        iv.image = [UIImage imageNamed:@"play-0"];
    }
    [mov addSubview:iv];
    [mov addGestureRecognizer:tap];
    [sc addSubview:mov];
    sc.contentSize = CGSizeMake(sc.frame.size.width, sc.contentSize.height + mov.frame.size.height + 10 + 20);
    
    
    UILabel *beizhu = [[UILabel alloc] initWithFrame:CGRectMake(lab.frame.origin.x, sc.contentSize.height+10, 220, 20)];
    beizhu.text = @"备注";
    beizhu.textColor = WORDDARKCOLOR;
    beizhu.font = [UIFont yaHeiFontOfSize:_sizeOfFont];
    [sc addSubview:beizhu];
    NSString *beiz = [xiongwei objectForKey:@"备注"];
    int heigt1 = 30;
    UILabel *mesa = [[UILabel alloc] initWithFrame:CGRectMake(referTo.frame.origin.x, beizhu.frame.origin.y + heigt1,  sc.frame.size.width-referTo.frame.origin.x, 400)];
    mesa.text = beiz;
    mesa.textColor = WORDDARKCOLOR;
    mesa.numberOfLines = 0;
    mesa.font = font;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:mesa.text];;
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    [paragraphStyle setLineSpacing:10];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, mesa.text.length)];
    
    mesa.attributedText = attributedString;
    CGSize size = [mesa sizeThatFits:CGSizeMake(sc.frame.size.width-referTo.frame.origin.x, 2000)];
    mesa.frame = CGRectMake(referTo.frame.origin.x, beizhu.frame.origin.y + heigt1, size.width, size.height);
    
    [sc addSubview:mesa];
    UIImageView *spot0 = [[UIImageView alloc] initWithFrame:CGRectMake(lab.frame.origin.x+5, mesa.frame.origin.y+5, 11, 11)];
    spot0.image = [UIImage imageNamed:@"jilu-dian" ofSex:self.sex];
    [sc addSubview:spot0];
    heigt1 = heigt1 + size.height+10;
    
    sc.contentSize = CGSizeMake(sc.frame.size.width, beizhu.frame.origin.y + heigt1);
    
    
    

}
#pragma mark - 特征

-(void)createRight8{
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(100, 20, FRAMEOFRIGHTVIEW.size.width-200, 44)];
    title.text = @"宝宝健康观察";
    title.textAlignment = NSTextAlignmentCenter;
    title.font = [UIFont yaHeiFontOfSize:30];
    title.textColor = wordColor;
    [_right8 addSubview:title];
    UILabel *detail = [[UILabel alloc] initWithFrame:CGRectMake(50, 64, FRAMEOFRIGHTVIEW.size.width-100, 44)];
    detail.text = @"*如果宝宝出现了以下行为特征，请在特征前面打上勾";
    detail.textAlignment = NSTextAlignmentCenter;
    detail.font = [UIFont yaHeiFontOfSize:_sizeOfFont];
    detail.textColor = WORDDARKCOLOR;
    [_right8 addSubview:detail];
    
    UIScrollView *sc = [[UIScrollView alloc] initWithFrame:CGRectMake(40, 110, FRAMEOFRIGHTVIEW.size.width-80, FRAMEOFRIGHTVIEW.size.height-90)];
    
    sc.tag = 1234567;
    
    [_right8 addSubview:sc];
   
    if (dataDicOfConfig.count>0) {
        
        
        NSArray *featureArr = serverCon.result.featureList;
        int height = 0;
        int x = 30;
        int width = sc.frame.size.width-x*2;
        NSString *title;
        int i=0;
        int featureNumber = 0;
        NSMutableArray *featuredArr = [[NSMutableArray alloc] init];
        if (jilu) {
            if (jilu.result) {
                if (jilu.result.userRecord) {
                    if (jilu.result.userRecord.featureList.count > 0) {
                        for(JLFeatureList *lis in jilu.result.userRecord.featureList) {
                            [featuredArr addObject:lis.detailid];
                        }
                    }
                }
            }
        }
        for (ServerConfigFeatureList *featur in featureArr) {
            if (featur.monthage  == _month) {
                if ([featur.featurename isEqualToString:title]) {
                    
                    
                }else{
                    UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(x, height, width, 1)];
                    line.backgroundColor = wordColor;
                    [sc addSubview:line];
                    height = height + 10;
                    UILabel *titl = [[UILabel alloc] initWithFrame:CGRectMake(x, height , 200, 30)];
                    titl.text = featur.featurename;
                    titl.textColor = wordColor;
                    titl.font = [UIFont yaHeiFontOfSize:_sizeOfFont];
                    [sc addSubview:titl];
                    height = height + titl.frame.size.height + 10 ;
                    title = featur.featurename;
                }
                UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
                button.frame = CGRectMake(x, height, width, 30);
                [_featureArr addObject:featur];
                [button setTitle:featur.detaildesc forState:UIControlStateNormal];
                [button setTitleColor:WORDDARKCOLOR forState:UIControlStateNormal];
                [button setImage:[UIImage imageNamed:@"0-jilu-dagou0"] forState:UIControlStateNormal];
                
                [button setImage:[UIImage imageNamed:@"jilu-dagou1" ofSex:self.sex] forState:UIControlStateSelected];
                [button addTarget:self action:@selector(featureClick:) forControlEvents:UIControlEventTouchUpInside];
                button.titleLabel.font = [UIFont yaHeiFontOfSize:_sizeOfFont];
                
                button.titleLabel.numberOfLines = 0;
                CGSize size = [button.titleLabel sizeThatFits:CGSizeMake(width, 2000)];
                
                button.titleLabel.frame = CGRectMake(0, 0, size.width, size.height);
//                [button setImageEdgeInsets:UIEdgeInsetsMake(1, 0, size.height-25, 0)];
                [button setImageEdgeInsets:UIEdgeInsetsMake(0, -8, size.height-28, 0)];
//                [button setTitleEdgeInsets:UIEdgeInsetsMake(0, 3, 0, 0)];
                button.frame = CGRectMake(x, height, size.width +  25, size.height);
                button.titleLabel.textAlignment = NSTextAlignmentLeft;
                button.tag = 2000+i;
                height = height + size.height + 10 + 10;
                if ([featuredArr containsObject:featur.featureListIdentifier]) {
                    button.selected = YES;
                    
                }
                button.userInteractionEnabled = _readTag;
                if (featur.exampleimg.length > 0) {
                    UIImageView *mov = [[UIImageView alloc] initWithFrame:CGRectMake(36,  height, 360, 270)];
                    mov.userInteractionEnabled = YES;
                    mov.tag = 710+featureNumber;
                    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(movRun:)];
                    
                    [mov sd_setImageWithURL:[NSURL URLWithString:[NSString urlStringOfImage:featur.exampleimg]]];
                    [_netMovArr addObject:featur.examplemov];
                    
//                    mov.image = [UIImage imageNamed:@"celiangshengao1"];
                    UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(mov.frame.size.width/2-33, mov.frame.size.height/2-33, 66, 66)];
                    if (self.sex == 1) {
                        iv.image = [UIImage imageNamed:@"play-1"];
                    }else{
                        iv.image = [UIImage imageNamed:@"play-0"];
                    }
                    [mov addSubview:iv];
                    [mov addGestureRecognizer:tap];
                    [sc addSubview:mov];
                    height = height + 270 + 10 + 10;
                    featureNumber ++;
                }
                
                
                
                [sc addSubview:button];
                
                i++;
            }
        }
        
        sc.contentSize = CGSizeMake(sc.frame.size.width, height+30);
    }else{
        NSLog(@"数据不存在！");
    }
}
-(void)featureClick:(UIButton *)button{
    button.selected = !button.selected;
    UILabel *label = [self.view viewWithTag:411];
    
    if (_featureArr.count>0) {
        ServerConfigFeatureList *featur =  _featureArr[button.tag - 2000];
        if ([_featureTrueArr containsObject:featur.featureListIdentifier]) {
            [_featureTrueArr removeObject:featur.featureListIdentifier];
            label.text = [NSString stringWithFormat:@"%d",[label.text intValue]-1];
        }else{
            [_featureTrueArr addObject:featur.featureListIdentifier];
            label.text = [NSString stringWithFormat:@"%d",[label.text intValue]+1];

            
        }
    }
   
    
}
#pragma mark - 问卷

-(void)createRight9{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(70, 70, FRAMEOFRIGHTVIEW.size.width-70*2, 40)];
    label.font = [UIFont yaHeiFontOfSize:_sizeOfFont];
    label.textColor = wordColor;
    label.numberOfLines = 0;
    if (dataDicOfConfig.count) {
        ServerConfigBaseClass *serverCon = [[ServerConfigBaseClass alloc] initWithDictionary:dataDicOfConfig];
        NSArray *questionArr = serverCon.result.questionList;
        for (ServerConfigQuestionList *quest in questionArr) {
            int start = [quest.startmonth intValue];
            int end = [quest.endmonth intValue];
            if (_month>=start&&_month<=end) {
                label.text = [NSString stringWithFormat:@"%@(可以对选)",quest.title];
                CGSize size = [label sizeThatFits:CGSizeMake(label.frame.size.width, 2000)];
                label.frame = CGRectMake(label.frame.origin.x, label.frame.origin.y, size.width, size.height);
                [_right9 addSubview:label];
                NSArray *titleList0 = quest.titlelist;
                questionId0 = quest.questionListIdentifier;
                int num = 0;
                for (ServerConfigTitlelist *tit in titleList0) {
                    
                    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
                    button.frame = CGRectMake(label.frame.origin.x, label.frame.origin.y+ label.frame.size.height + 40*num+10, 100, 30);
                    [_questionArr addObject:tit];
                    [button setTitle:tit.title forState:UIControlStateNormal];
                    button.titleLabel.font = [UIFont yaHeiFontOfSize:_sizeOfFont];
                    [button setTitleColor:WORDDARKCOLOR forState:UIControlStateNormal];
                    [button setImage:[UIImage imageNamed:@"0-jilu-dagou0"] forState:UIControlStateNormal];
                    [button setImage:[UIImage imageNamed:@"jilu-dagou1" ofSex:self.sex] forState:UIControlStateSelected];
                    [button addTarget:self action:@selector(questionClick:) forControlEvents:UIControlEventTouchUpInside];
                    button.tag = 3000+num;

                    CGSize size = [button.titleLabel sizeThatFits:CGSizeMake(200, 2000)];
                    
                    button.titleLabel.frame = CGRectMake(0, 0, size.width, size.height);
                    
                    button.frame = CGRectMake(label.frame.origin.x, label.frame.origin.y+ label.frame.size.height + 40*num+10, size.width +  25, 30);

                    
                    [_right9 addSubview:button];
                    num++;
                    
                }
                
            }
        }
    }else{
        NSLog(@"数据不存在！");
    }

    
}
-(void)questionClick:(UIButton *)button{
    button.selected = !button.selected;
    if (_questionArr.count > 0) {
        ServerConfigTitlelist *title = (ServerConfigTitlelist *)_questionArr[button.tag-3000];
        if ([_questionTrueArr containsObject:title.titlelistIdentifier]) {
            [_questionTrueArr removeObject:title.titlelistIdentifier];
        }else{
            if (title.titlelistIdentifier) {
                [_questionTrueArr addObject:title.titlelistIdentifier];
            }
            
        }
    }
    
}

#pragma mark - 其他

-(void)createRight10{
    
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(200, 50, FRAMEOFRIGHTVIEW.size.width-400, 44)];
    title.text = @"其他";
    title.textAlignment = NSTextAlignmentCenter;
    title.font = [UIFont yaHeiFontOfSize:30];
    title.textColor = wordColor;
    [_right10 addSubview:title];
    UIImageView *bgImage = [[UIImageView alloc] initWithFrame:CGRectMake(FRAMEOFRIGHTVIEW.size.width/2-200, 110, 401, 292)];
    bgImage.image = [UIImage imageNamed:@"jilu-qita" ofSex:self.sex];
    bgImage.userInteractionEnabled = YES;
    textView0 = [[UITextView alloc] initWithFrame:CGRectMake(10, 10, bgImage.frame.size.width-20, bgImage.frame.size.height-20)];
    textView0.delegate = self;
    textView0.text = @"请输入专属私人医生要填写的内容";
    if (jilu) {
        if (jilu.result) {
            if (jilu.result.userRecord) {
                if (jilu.result.userRecord.other.length>0) {
                    textView0.text = jilu.result.userRecord.other;
                }
            }
        }
    }
    
    textView0.font = [UIFont yaHeiFontOfSize:_sizeOfFont];
    textView0.textColor = WORDDARKCOLOR;
    
    
    

    [bgImage addSubview:textView0];
    [_right10 addSubview:bgImage];
    UILabel *tiShi = [[UILabel alloc] initWithFrame:CGRectMake(bgImage.frame.origin.x, bgImage.frame.origin.y+bgImage.frame.size.height + 10, bgImage.frame.size.width, 100)];
    tiShi.text = @"* 若专属医生没有要求，可以不填写";
    tiShi.textColor = WORDDARKCOLOR;
    tiShi.font = [UIFont yaHeiFontOfSize:18];
    [_right10 addSubview:tiShi];
    
    
}

#pragma mark - textView相关

-(void)textViewDidBeginEditing:(UITextView *)textView{
    if ([textView.text isEqualToString:@"请输入专属私人医生要填写的内容"]) {
        textView.text = nil;
    }
    
    
}




-(void)createRight11{
    
    
    UILabel *wenHou = [[UILabel alloc] initWithFrame:CGRectMake(30, 100, FRAMEOFRIGHTVIEW.size.width-60, 30)];
    wenHou.textColor = wordColor;
    wenHou.text = @"爸爸妈妈，你们好：";
    wenHou.font = [UIFont yaHeiFontOfSize:24];
    [_right11 addSubview:wenHou];
    
    UILabel *graph = [[UILabel alloc] initWithFrame:CGRectMake(30, 140,  FRAMEOFRIGHTVIEW.size.width-60, 200)];
    graph.numberOfLines = 0;
    graph.text = @"小宝宝每个月的变化都很大哦，所以我们需要记录宝宝每个月的生长发育情况来判断宝宝的健康状况。按照宝宝的月龄，每满一个月填写一次，提交记录之后我们的专业儿保医生将会在一周后给您评估结果和养育指导。请记住，一定要准时提交哦。让我们一起见证宝宝的成长带给我们的惊喜与快乐。";
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:graph.text];;
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    [paragraphStyle setLineSpacing:10];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, graph.text.length)];
    
    graph.attributedText = attributedString;

    graph.textColor = WORDDARKCOLOR;
    graph.font = [UIFont yaHeiFontOfSize:_sizeOfFont];
    [_right11 addSubview:graph];
    
    
    
    UILabel *graph1 = [[UILabel alloc] initWithFrame:CGRectMake(30, 420,  FRAMEOFRIGHTVIEW.size.width-60, 200)];
    graph1.numberOfLines = 0;
    graph1.text = @"※ 如果提交后发现记录填写有误，请及时联系客服修改。但修改数据有可能影响医生给出的评估结果和养育指导的时间。";
    NSMutableAttributedString *attributedString1 = [[NSMutableAttributedString alloc]initWithString:graph1.text];;
    NSMutableParagraphStyle *paragraphStyle1 = [[NSMutableParagraphStyle alloc]init];
    [paragraphStyle1 setLineSpacing:10];
    [attributedString1 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, graph1.text.length)];
    
    graph1.attributedText = attributedString1;

    graph1.textColor = WORDDARKCOLOR;
    graph1.font = [UIFont yaHeiFontOfSize:_sizeOfFont];
    [_right11 addSubview:graph1];
    
    
    
}



#pragma mark - textfield相关

-(void)viewWillDisappear:(BOOL)animated{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];
    
}



-(void)infoAction:(NSNotification *)noti{
    
    UITextField *field;
    
    if (tagOfTextField == 555555) {
        field = [[[self.view.window viewWithTag:8888] viewWithTag:666666] viewWithTag:555555];

    }else{
        field = (UITextField *)[[[self.view viewWithTag:rightTag] viewWithTag:1234567]viewWithTag:tagOfTextField];

    }
//    if (tagOfTextField!=0 &&tagOfTextField!=555555) {
//        field = (UITextField *)[[[self.view viewWithTag:rightTag] viewWithTag:1234567]viewWithTag:tagOfTextField];
//    }else if(tagOfTextField == 555555){
//        field = [[[self.view.window viewWithTag:8888] viewWithTag:666666] viewWithTag:555555];
//    }
    
    NSLog(@"_isAccessoryViewTF = %d",_isAccessoryViewTF);
    
    if (_isAccessoryViewTF == NO) {
        if (tagOfTextField) {
            if ([[self.view viewWithTag:tagOfTextField-100] isKindOfClass:[UILabel class]]) {
                UILabel *lab = (UILabel *)[self.view viewWithTag:tagOfTextField-100];
                
                CGFloat float1 =[field.text floatValue];
                NSString *str = [NSString stringWithFormat:@"%.3f",float1];
                lab.text = [str substringToIndex:str.length-2];
                
                if ((lab.tag == 404) || (lab.tag == 403)||(lab.tag == 402)||(lab.tag == 407)||(lab.tag == 408)||(lab.tag == 411)) {
                    lab.text = [NSString stringWithFormat:@"%@",[str substringToIndex:str.length-4]];
                }
                if ((lab.tag == 405)||(lab.tag == 406)) {
                    lab.text = [NSString stringWithFormat:@"%@",[str substringToIndex:str.length-1]];

                }
               
//                if(lab.text.length == 0)
//                {
//                    lab.text = @"0.00";
//                }
                
            }
        }
        
        
        UITextField *texf = (UITextField *)[field.inputAccessoryView viewWithTag:8000];
        texf.text = field.text;
    }else{
        UITextField *texf = (UITextField *)[field.inputAccessoryView viewWithTag:8000];
        field.text = texf.text;
    }
    
   

    
}



-(void)textFieldDidBeginEditing:(UITextField *)textField{
    if (textField.tag != 8000) {
        tagOfTextField = textField.tag;
        
        
    }else{
       
    }
    
}




-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if (textField.tag == 8000) {
        _isAccessoryViewTF = YES;
    }else{
        _isAccessoryViewTF = NO;
    }
   
    return YES;
}
-(BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    [textField resignFirstResponder];
    
    return YES;
}

/*
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    UILabel *lab = (UILabel *)[self.view viewWithTag:textField.tag-100];
//    NSString *nub = [NSString stringWithFormat:@"%@%@",textField.text,string];
//    if (nub.length == 0) {
//        lab.text = [NSString stringWithFormat:@"%.2f",0.0];
//    }else{
//    lab.text= [NSString stringWithFormat:@"%.2f",[nub floatValue]];
//    }
//    lab.text = textField.text;
    return YES;
}
*/

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    for (int i=0; i<11; i++) {
        UIView *view = (UIView *)[self.view viewWithTag:450+i];
        for (id vi in view.subviews) {
            if ([vi isKindOfClass:[UIScrollView class]]) {
                for (id subV in [vi subviews]) {
                    if ([subV isKindOfClass:[UITextField class]]) {
                        UITextField *textField = (UITextField *)subV;
                        [textField resignFirstResponder];
                    }
                }
            }
            
        }
    }
    
    UITextField *fiel = [[[self.view.window viewWithTag:8888] viewWithTag:666666] viewWithTag:555555];
    [fiel resignFirstResponder];
    
    
    
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
