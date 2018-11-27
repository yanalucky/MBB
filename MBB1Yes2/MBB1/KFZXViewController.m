//
//  KFZXViewController.m
//  MBB
//
//  Created by 陈彦 on 15/9/1.
//  Copyright (c) 2015年 elsa. All rights reserved.
//

#import "KFZXViewController.h"
#import "AppDelegate.h"
#import "UIImageView+WebCache.h"
#import "RickyCell.h"
#import "NetRequestManage.h"
#import "DataModels.h"
#import "TAlertView.h"
#import "ErrorStatus.h"
#import "CYOverRunView.h"


@interface KFZXViewController ()<UIAlertViewDelegate,UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>{
    UIColor *wordColor;
    UIColor *bgColor;
    LoginUserNSObject *_user;
    NSArray *_hospicalDataArr;
    UIPageControl *page;
    BOOL _isAccessoryView;
    FeedbackNSObject *_feedback;
    UITableView *tab;
    UIAlertView *alert;
    UITextField *fied;
    int _tagOfTextField;
    
}

@end

@implementation KFZXViewController


#pragma mark - 自定义 alertview 相关
-(void)overRun{
    CYOverRunView *ciew = [self.view.window viewWithTag:999];
    ciew.hidden = NO;
    ciew.clickBlocks = ^(void){
        
        [self.tabBarController dismissViewControllerAnimated:NO completion:nil];
    };
    [self.view.window bringSubviewToFront:ciew];
}
-(void)viewWillAppear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(infoAction:) name:UITextFieldTextDidChangeNotification object:nil];
    _use.hidden = YES;
    [self.view bringSubviewToFront:_right4];
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _fanKuiDataArr = [[NSMutableArray alloc] init];
    _isAccessoryView = NO;
    _tagOfTextField = 1111;
    NSFileManager *manager = [NSFileManager defaultManager];
    NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"/Documents/loadUser.plist"];
    if ([manager fileExistsAtPath:path]) {
        NSData *data = [NSData dataWithContentsOfFile:path];
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        LoginUserNSObject *user = [[LoginUserNSObject alloc] initWithDictionary:dic];
        _user = user;
        
        
    }else{
        NSLog(@"路径不存在！");
    }
    NSString *path1 = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/severCon.plist"];
    if ([manager fileExistsAtPath:path1]) {
        NSData *data = [NSData dataWithContentsOfFile:path1];
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        ServerConfigBaseClass *base = [[ServerConfigBaseClass alloc] initWithDictionary:dic];
        _hospicalDataArr = base.result.hospitalList;
      
        
    }else{
        NSLog(@"路径不存在！");
    }
    _labelDataArr = [[NSMutableArray alloc] init];
    
    if (_user.result) {
        if (_user.result.bodycheckBooking) {
            if ([_user.result.bodycheckBooking isKindOfClass:[LoginUserBodycheckBooking class]]) {
                LoginUserBodycheckBooking *book = _user.result.bodycheckBooking;
                [_labelDataArr addObject:book];
            }
        }
    }
    
    if (_user.result) {
        if (_user.result.treatBooking) {
            if ([_user.result.treatBooking isKindOfClass:[LoginUserTreatBooking class]]) {
                LoginUserTreatBooking *book1 = _user.result.treatBooking;
                [_labelDataArr addObject:book1];
            }
        }
    }
    

    
    
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    self.sex = delegate.sex;
    if (self.sex == YES) {
        wordColor = BOY_WORDCOLOR;
        bgColor = BOY_RIGHTVIEWCOLOR;
    }else{
        wordColor = GIRL_WORDCOLOR;
        bgColor = GIRL_RIGHTVIEWCOLOR;
    }
    [self createUI];
    // Do any additional setup after loading the view.
}

-(void)createUI{
    UIImageView *im = [[UIImageView alloc] initWithFrame:CGRectMake(200, 117, 49, 48)];
    im.image = [UIImage imageNamed:@"kefu-tel" ofSex:self.sex];
    [self.view addSubview:im];
    
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(289, 117, 220, 40)];
    lab.text = @"客服电话";
    lab.font = [UIFont yaHeiFontOfSize:30];
    lab.textColor = wordColor;
    [self.view addSubview:lab];
    
    UILabel *labe = [[UILabel alloc] initWithFrame:CGRectMake(254, 155, 300, 28)];
    labe.text = @"400-876-6060";
    labe.textColor = wordColor;
    labe.font = [UIFont yaHeiFontOfSize:30];
    [self.view addSubview:labe];
    
    
    for (int i=0; i<2; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(178, 219+i*157, 310, 126);
        [button setImage:[UIImage imageNamed:@"kefu-dakuang" ofSex:self.sex] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"kefu-dakuang2" ofSex:self.sex] forState:UIControlStateHighlighted];

        [button setImage:[UIImage imageNamed:@"kefu-dakuang2" ofSex:self.sex] forState:UIControlStateSelected];
        
        
        
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 12, button.frame.size.width, 25)];
        label.textColor = WORDDARKCOLOR;
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont yaHeiFontOfSize:24];
        
        UILabel *time = [[UILabel alloc] initWithFrame:CGRectMake(89, 50, button.frame.size.width-178, 17)];
//        time.text = _labelDataArr[0];
            time.font = [UIFont yaHeiFontOfSize:14];
            time.textColor = WORDDARKCOLOR;
        
            
            
            UILabel *place = [[UILabel alloc] initWithFrame:CGRectMake(20, 70, button.frame.size.width-40, 50)];
//            place.text = _labelDataArr[0];
            place.font = [UIFont yaHeiFontOfSize:16];
            place.textColor = WORDDARKCOLOR;
        place.numberOfLines = 2 ;
        
      
            if (_labelDataArr.count == 1) {
                if (i==0) {
                    LoginUserBodycheckBooking *book = _labelDataArr[i];
                    label.text = @"体检预约";
                    NSString *timeStr =[book.bookingtime substringToIndex:10];
                    time.text = [NSString stringWithFormat:@"时间：%@",timeStr];
                    for (ServerConfigHospitalList *hospital in _hospicalDataArr) {
                        if ([hospital.hospitalid isEqualToString:book.hospitalid]) {
                            place.text = [NSString stringWithFormat:@"地点：%@",hospital.hospitalname];
                        }
                    }
                }else{
                    label.text = @"尚未预约";
                }
                
            }else if(_labelDataArr.count == 2){
                if (i==0) {
                    LoginUserBodycheckBooking *book = _labelDataArr[i];
                    label.text = @"体检预约";
                    NSString *timeStr =[book.bookingtime substringToIndex:10];
                    time.text = [NSString stringWithFormat:@"时间：%@",timeStr];
                    for (ServerConfigHospitalList *hospital in _hospicalDataArr) {
                        if ([hospital.hospitalid isEqualToString:book.hospitalid]) {
                            place.text = [NSString stringWithFormat:@"地点：%@",hospital.hospitalname];
                        }
                    }
                }else{
                    LoginUserTreatBooking *book1 = _labelDataArr[i];
                    label.text = @"专家转诊/绿色通道";
                    NSString *timeStr =[book1.bookingtime substringToIndex:10];
                    time.text = [NSString stringWithFormat:@"时间：%@",timeStr];
                    for (ServerConfigHospitalList *hospital in _hospicalDataArr) {
                        if ([hospital.hospitalid isEqualToString:book1.hospitalid]) {
                            place.text = [NSString stringWithFormat:@"地点：%@",hospital.hospitalname];
                        }
                    }
                }
                
            }else{
                label.text = @"尚未预约";
            }
        
        
        button.tag = 600+i;
        
        [button addSubview:label];
        [button addSubview:time];
        [button addSubview:place];
        
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];

        [self.view addSubview:button];
    }
    
    
    NSArray *arr = @[@"使用说明",@"您的反馈"];
    for (int i=0; i<2; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(216, 550+i*95, 234, 57);
//        
//        [btn setTitle:arr[i] forState:UIControlStateNormal];
//        [btn setTitle:arr[i] forState:UIControlStateHighlighted];
//        [btn setTitle:arr[i] forState:UIControlStateSelected];
//        btn.titleLabel.font = [UIFont yaHeiFontOfSize:14];
        [btn setTitleColor:WORDDARKCOLOR forState:UIControlStateNormal];
        btn.tag = 602+i;
        [btn setImage:[UIImage imageNamed:@"kefu-dakuang" ofSex:self.sex] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"kefu-dakuang2" ofSex:self.sex] forState:UIControlStateSelected];
        [btn setImage:[UIImage imageNamed:@"kefu-dakuang2" ofSex:self.sex] forState:UIControlStateHighlighted];
        
        [btn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        UILabel *btnTitle = [[UILabel alloc] initWithFrame:btn.bounds];
        btnTitle.text = arr[i];
        btnTitle.font = [UIFont yaHeiFontOfSize:16];
        btnTitle.textColor = WORDDARKCOLOR;
        btnTitle.textAlignment = NSTextAlignmentCenter;
        [btn addSubview:btnTitle];
        [self.view addSubview:btn];
    }
    
    
    
    [self createRight];
    [self createUse];
    
}


#pragma mark - buttonClick 点击事件
-(void)buttonClick:(UIButton *)button{
    for (int i=0; i<4; i++) {
        UIButton *button = (UIButton *)[self.view viewWithTag:600+i];
        button.selected = NO;
    }
    button.selected = YES;
    if (button.tag == 600) {
        [self.view bringSubviewToFront:_right0];
    }else if (button.tag == 601){
        [self.view bringSubviewToFront:_right1];
    
    }else if (button.tag == 602){
        
        _use.hidden = NO;
        [self.view bringSubviewToFront:_use];
    }else if (button.tag == 603){
        [NetRequestManage getFeedbackSuccessBlocks:^(NSData *data, NetRequestManage *loadUser) {
            NSString *str = [[NSString alloc] initWithData:loadUser.resultData encoding:NSUTF8StringEncoding];
            NSLog(@"FanhuiStr  = %@",str);
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:loadUser.resultData options:NSJSONReadingMutableContainers error:nil];
            
            if ([[dic objectForKey:@"errorId"] intValue] == -900) {
                [self overRun];
            }
            FeedbackNSObject *feedB = [[FeedbackNSObject alloc] initWithDictionary:dic];
            _feedback = feedB;
            if (_fanKuiDataArr.count > 0) {
                [_fanKuiDataArr removeAllObjects];   
            }
            [_fanKuiDataArr addObjectsFromArray:_feedback.result.feedbackList];
            [tab reloadData];
            
        } andFailedBlocks:^(NSError *error, NetRequestManage *loadUser) {
            NSLog(@"FanKuiError = %@",error.description);
        }];
        
        [self.view bringSubviewToFront:_right3];
    }
}


-(void)createRight{
    _right0 = [[UIView alloc] initWithFrame:FRAMEOFRIGHTVIEW];
    _right1 = [[UIView alloc] initWithFrame:FRAMEOFRIGHTVIEW];
    _right2 = [[UIView alloc] initWithFrame:FRAMEOFRIGHTVIEW];
    _right3 = [[UIView alloc] initWithFrame:FRAMEOFRIGHTVIEW];
    _right4 = [[UIView alloc] initWithFrame:FRAMEOFRIGHTVIEW];
    _right0.backgroundColor = bgColor;
    _right1.backgroundColor = bgColor;
    _right2.backgroundColor = bgColor;
    _right3.backgroundColor = bgColor;
    _right4.backgroundColor = bgColor;
    [self createRight0];
    [self createRight1];
    [self createRight3];
    [self createRight4];
    [self.view addSubview:_right4];
    [self.view addSubview:_right0];
    [self.view addSubview:_right1];
    [self.view addSubview:_right2];
    [self.view addSubview:_right3];
}
-(void)createRight4{
    
    UIImageView *background = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, FRAMEOFRIGHTVIEW.size.width, FRAMEOFRIGHTVIEW.size.height)];
    background.image = [[UIImage imageNamed:@"shouye-right" ofSex:self.sex] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [_right4 addSubview:background];
    [self.view bringSubviewToFront:_right4];
}
-(void)createRight0{
    UILabel *time = [[UILabel alloc] initWithFrame:CGRectMake(30, 40, FRAMEOFRIGHTVIEW.size.width-60, 30)];
    time.textColor = wordColor;
    time.textAlignment = NSTextAlignmentCenter;
    time.font = [UIFont yaHeiFontOfSize:24];
    
    
    UILabel *place = [[UILabel alloc] initWithFrame:CGRectMake(30, 85, FRAMEOFRIGHTVIEW.size.width-60, 65)];
    place.textColor = wordColor;
    place.font = [UIFont yaHeiFontOfSize:24];
    place.textAlignment = NSTextAlignmentCenter;
    place.numberOfLines = 2;
    
    UILabel *receive = [[UILabel alloc] initWithFrame:CGRectMake(30, 165, FRAMEOFRIGHTVIEW.size.width-60, 20)];
    receive.textColor = WORDDARKCOLOR;
    receive.textAlignment = NSTextAlignmentLeft;
    receive.font = [UIFont yaHeiFontOfSize:16];
    
    
    
    UILabel *address = [[UILabel alloc] initWithFrame:CGRectMake(30, 200, FRAMEOFRIGHTVIEW.size.width-60, 20)];
    address.textColor = WORDDARKCOLOR;
    address.textAlignment = NSTextAlignmentLeft;
    address.font = [UIFont yaHeiFontOfSize:16];
    
    
    UIImageView *mapBg = [[UIImageView alloc] initWithFrame:CGRectMake(30, 235, 434, 288)];
    mapBg.image = [UIImage imageNamed:@"kefuditu" ofSex:self.sex];
    UIImageView *map = [[UIImageView alloc] initWithFrame:CGRectMake(2, 2, 430, 284)];
    map.layer.masksToBounds = YES;
    map.layer.cornerRadius = 2;
    if (_labelDataArr.count>0) {
        LoginUserBodycheckBooking *book = _labelDataArr[0];
        
            NSString *timeStr =[book.bookingtime substringToIndex:10];
            time.text = [NSString stringWithFormat:@"时间：%@",timeStr];
        receive.text = [NSString stringWithFormat:@"接待电话：%@(%@)",book.contactmobile,book.contactperson];
            for (ServerConfigHospitalList *hospital in _hospicalDataArr) {
                if ([hospital.hospitalid isEqualToString:book.hospitalid]) {
                    place.text = [NSString stringWithFormat:@"地点：%@",hospital.hospitalname];
                    address.text = [NSString stringWithFormat:@"地址：%@",hospital.hospitaladdress];
                    [map sd_setImageWithURL:[NSURL URLWithString:[NSString urlStringOfImage:hospital.map]]];
                    
                }
            }
            
            
            
    
        
    }else{
        time.text = @"尚未预约";
    }
    
    [_right0 addSubview:time];
    [_right0 addSubview:place];
    [_right0 addSubview:receive];
    [_right0 addSubview:address];
    [mapBg addSubview:map];
    [_right0 addSubview:mapBg];
 }
-(void)createRight1{
    UILabel *time = [[UILabel alloc] initWithFrame:CGRectMake(30, 40, FRAMEOFRIGHTVIEW.size.width-60, 30)];
    time.textColor = wordColor;
    time.textAlignment = NSTextAlignmentCenter;
    time.font = [UIFont yaHeiFontOfSize:24];
    
    
    UILabel *place = [[UILabel alloc] initWithFrame:CGRectMake(30, 85, FRAMEOFRIGHTVIEW.size.width-60, 65)];
    place.textColor = wordColor;
    place.font = [UIFont yaHeiFontOfSize:24];
    place.textAlignment = NSTextAlignmentCenter;
    place.numberOfLines = 2;
    
    UILabel *receive = [[UILabel alloc] initWithFrame:CGRectMake(30, 165, FRAMEOFRIGHTVIEW.size.width-60, 20)];
    receive.textColor = WORDDARKCOLOR;
    receive.textAlignment = NSTextAlignmentLeft;
    receive.font = [UIFont yaHeiFontOfSize:16];
    
    
    
    UILabel *address = [[UILabel alloc] initWithFrame:CGRectMake(30, 200, FRAMEOFRIGHTVIEW.size.width-60, 20)];
    address.textColor = WORDDARKCOLOR;
    address.textAlignment = NSTextAlignmentLeft;
    address.font = [UIFont yaHeiFontOfSize:16];
    
    
    UIImageView *mapBg = [[UIImageView alloc] initWithFrame:CGRectMake(30, 235, 434, 288)];
    mapBg.image = [UIImage imageNamed:@"kefuditu" ofSex:self.sex];
    UIImageView *map = [[UIImageView alloc] initWithFrame:CGRectMake(2, 2, 430, 284)];
    map.layer.masksToBounds = YES;
    map.layer.cornerRadius = 2;
    if (_labelDataArr.count>1) {
        
        LoginUserTreatBooking *book = _labelDataArr[1];
        
        NSString *timeStr =[book.bookingtime substringToIndex:10];
        time.text = [NSString stringWithFormat:@"时间：%@",timeStr];
        receive.text = [NSString stringWithFormat:@"接待电话：%@(%@)",book.contactmobile,book.contactperson];
        for (ServerConfigHospitalList *hospital in _hospicalDataArr) {
            if ([hospital.hospitalid isEqualToString:book.hospitalid]) {
                place.text = [NSString stringWithFormat:@"地点：%@",hospital.hospitalname];
                address.text = [NSString stringWithFormat:@"地址：%@",hospital.hospitaladdress];
                [map sd_setImageWithURL:[NSURL URLWithString:[NSString urlStringOfImage:hospital.map]]];
                
            }
        }
        
        
        
        
        
    }else{
        time.text = @"尚未预约";
    }
    
    [_right1 addSubview:time];
    [_right1 addSubview:place];
    [_right1 addSubview:receive];
    [_right1 addSubview:address];
    [mapBg addSubview:map];
    [_right1 addSubview:mapBg];
}





#pragma mark - use说明
-(void)createUse{
    _use = [[UIView alloc] initWithFrame:self.view.bounds];
    _use.backgroundColor = [UIColor whiteColor];
    _use.alpha = 1;
    
    [self.view addSubview:_use];
    _use.hidden = YES;
    [self.view sendSubviewToBack:_use];
    
    UIButton *buttonReturn = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonReturn.frame = CGRectMake(180, 100, 38, 50);
    UIImageView *fanhuiImg = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 18, 30)];
    fanhuiImg.image = [UIImage imageNamed:@"yangyu-left" ofSex:self.sex];
    [buttonReturn addSubview:fanhuiImg];

    [buttonReturn addTarget:self action:@selector(returnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_use addSubview:buttonReturn];
    
    
    
    
    UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake((self.view.frame.size.width-169-720)/2+169, 160, 720, 2)];
    line.backgroundColor = wordColor;
    [_use addSubview:line];
    
    UIScrollView *sc = [[UIScrollView alloc] initWithFrame:CGRectMake(line.frame.origin.x, line.frame.origin.y+10, 717, 537)];
    sc.delegate = self;
    sc.tag = 2000000;
    for (int i=1; i<7; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(717*(i-1), 0, 717, 537)];
        NSString *imgName = [NSString stringWithFormat:@"%.2d.jpg",i];
        imageView.image = [UIImage imageNamed:imgName];
        [sc addSubview:imageView];
    }
    sc.contentSize = CGSizeMake(717*6, 537);
    sc.pagingEnabled = YES;
    sc.showsHorizontalScrollIndicator = NO;
    [_use addSubview:sc];
    
    page = [[UIPageControl alloc] initWithFrame:CGRectMake(sc.frame.origin.x + (sc.frame.size.width/2)-75, sc.frame.size.height+10+sc.frame.origin.y, 150, 20)];
    page.numberOfPages = 6;
    page.currentPage = 0;
    page.currentPageIndicatorTintColor = wordColor;
    page.userInteractionEnabled = YES;
    page.pageIndicatorTintColor = WORDDARKCOLOR;
    [page addTarget:self action:@selector(changePage:)forControlEvents:UIControlEventValueChanged];
    [_use addSubview:page];
    
    
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(line.frame.origin.x,80, line.frame.size.width, 60)];
    label.text = @"使用说明";
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont yaHeiFontOfSize:35];
    label.textColor = wordColor;
    [_use addSubview:label];
    
    
    
    
    
    
}



-(void)returnClick:(UIButton *)button{
    _use.hidden = YES;
}


-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
   page.currentPage = scrollView.contentOffset.x/717;
}
-(void)changePage:(UIPageControl *)page{
    UIScrollView *sc = (UIScrollView *)[_use viewWithTag:2000000];
    sc.contentOffset = CGPointMake(page.currentPage*717, 0);
}



#pragma mark - 您的反馈



-(void)createRight3{
    UILabel *tit = [[UILabel alloc] initWithFrame:CGRectMake(FRAMEOFRIGHTVIEW.size.width/2-50, 30, 100, 50)];
    tit.text = @"您的反馈";
    tit.textColor =wordColor;
    tit.textAlignment = NSTextAlignmentCenter;
    tit.font = [UIFont yaHeiFontOfSize:24];
    
    [_right3 addSubview:tit];
    UIImageView *bg = [[UIImageView alloc] initWithFrame:CGRectMake(30, 100, FRAMEOFRIGHTVIEW.size.width-60, 550)];
    bg.image = [UIImage imageNamed:@"kefu-fankui" ofSex:self.sex];
    bg.userInteractionEnabled = YES;
    [_right3 addSubview:bg];
    tab = [[UITableView alloc] initWithFrame:CGRectMake(5, 15, bg.frame.size.width-10, bg.frame.size.height-80) style:UITableViewStylePlain];
    tab.delegate = self;
    tab.dataSource = self;
    tab.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [bg addSubview:tab];
    
    
    fied = [[UITextField alloc] initWithFrame:CGRectMake(35, 590, 355, 53)];
    fied.placeholder = @"在此输入问题";
    fied.tag = 1111;
    fied.delegate = self;
    [fied setLeftViewOfBlankforWidth:8];

    [self setInputAccessoryViewByElsa:fied];
    fied.background = [UIImage imageNamed:@"1-kefu-shuru"];
//    fied.borderStyle = UITextBorderStyleRoundedRect;
    
    [_right3 addSubview:fied];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(395, 590, 84, 55);
    [button setBackgroundImage:[UIImage imageNamed:@"kefu-tijiao" ofSex:self.sex] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(submitAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [_right3 addSubview:button];
    
}


#pragma mark - 自定义 alertview 相关

-(void)alertViewWithTextfieldAboutHandJilu{
    UIView *ciew = [self.view.window viewWithTag:8888];
    ciew.hidden = NO;
    for (int i=0; i<[ciew.subviews count]; i++) {
        UIView *ve = ciew.subviews[i];
        [ve removeFromSuperview];
    }
    
    UIImageView *_alert = [[UIImageView alloc] initWithFrame:CGRectMake((self.view.frame.size.width - 300)/2, (self.view.frame.size.height - 150)/2, 300, 150)];
    _alert.backgroundColor = [UIColor whiteColor];
    _alert.tag = 6666;
    _alert.layer.masksToBounds = YES;
    _alert.layer.cornerRadius = 10;
    _alert.userInteractionEnabled = YES;
    _alert.alpha = 1;
    
    
    UITextField *fiele = [[UITextField alloc] initWithFrame:CGRectMake((_alert.frame.size.width - 234)/2, (_alert.frame.size.height-57)/2-30, 234, 57)];
    
    fiele.keyboardType = UIKeyboardTypeNumberPad;
    fiele.placeholder = @"请输入密码";
    fiele.delegate = self;
    fiele.userInteractionEnabled = YES;
    fiele.tag = 5555;
    fiele.background = [UIImage imageNamed:@"jilu-tijiaokuang" ofSex:self.sex];
    [fiele setLeftViewOfBlankforWidth:8];
    [self setInputAccessoryViewByElsa:fiele];
    [fiele setValue:[UIColor colorWithRed:130/255.0 green:130/255.0 blue:130/255.0 alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
    [fiele setValue:[UIFont yaHeiFontOfSize:15] forKeyPath:@"_placeholderLabel.font"];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake((_alert.frame.size.width - 161)/2, (_alert.frame.size.height-46)/2+42, 161, 46);
    [button setBackgroundImage:[UIImage imageNamed:@"kefu-anniu2" ofSex:self.sex] forState:UIControlStateNormal];
    [button setTitle:@"确认提交" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont yaHeiFontOfSize:14];
    [button setTitleColor:wordColor forState:UIControlStateNormal];
    [button addTarget:self action:@selector(tijiaoAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [_alert addSubview:button];
    
    [_alert addSubview:fiele];
    
    [ciew addSubview:_alert];
    
    [self.view.window bringSubviewToFront:ciew];
}

-(void)tijiaoAction:(UIButton *)button{
    UITextField *tex = [[[self.view.window viewWithTag:8888] viewWithTag:6666] viewWithTag:5555];
    [NetRequestManage submitFeedbackWithTextfield:fied.text andPwd:tex.text successBlocks:^(NSData *data, NetRequestManage *loadUser) {
        
        NSString *str = [[NSString alloc] initWithData:loadUser.resultData encoding:NSUTF8StringEncoding];
        NSLog(@"tijiafanhui = %@",str);
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:loadUser.resultData options:NSJSONReadingMutableContainers error:nil];
        if ([[dic objectForKey:@"errorId"] intValue] == -900) {
            [self overRun];
        }
        if ([[dic objectForKey:@"errorId"] intValue] == 0) {
            FeedbackFeedbackList *fee = [[FeedbackFeedbackList alloc] init];
            fee.backcontent = fied.text;
            fee.backtype = @"1";
            [_fanKuiDataArr addObject:fee];
            [tab reloadData];
            fied.text = nil;
        }else{
            
                        //                TAlertView *alert0 = [[TAlertView alloc]initWithTitle:[ErrorStatus errorStatus:[dic objectForKey:@"errorId"] parmStr:nil] andMessage:nil];
            //                alert0.style = TAlertViewStyleNeutral;
            //                alert0.center = self.view.center;
            //                alert0.imageName = @"jilu-error";
            //                alert0.sex = self.sex;
            //                [alert0 show];
        }
        
        [[[self.view.window viewWithTag:8888] viewWithTag:6666] removeFromSuperview];
        if ([[dic objectForKey:@"errorId"] intValue] == 0) {
            [self alertViewWith:@"反馈成功！"];
        }else{
            [self alertViewWith:[ErrorStatus errorStatus:[dic objectForKey:@"errorId"] parmStr:nil]];
            

        }
        
    } andFailedBlocks:^(NSError *error, NetRequestManage *loadUser) {
        NSLog(@"tijiaofankui error = %@",error.description);
        
    }];

}


#pragma mark - 提交反馈
-(void)submitAction:(UIButton *)button{
    if (fied.text.length>4) {
        
        
        [self alertViewWithTextfieldAboutHandJilu];
//        alert = [[UIAlertView alloc] initWithTitle:@"" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"提交", nil];
//        alert.delegate = self;
//        //    UIImageView *imV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
//        //    imV.image = [UIImage imageNamed:@"0-jilu-error"];
//        //    [alert addSubview:imV];
//        alert.alertViewStyle = UIAlertViewStyleSecureTextInput;
//        UITextField *textf = [alert textFieldAtIndex:0];
//        textf.tag = 4321;
//        textf.delegate = self;
//        [self setInputAccessoryViewByElsa:textf];
//        [alert show];
    }else{
        [self alertViewWith:@"请仔细描述您的问题"];
//        TAlertView *alert0 = [[TAlertView alloc]initWithTitle:@"请仔细描述您的问题" andMessage:nil];
//        alert0.style = TAlertViewStyleNeutral;
//        alert0.center = self.view.center;
//        alert0.imageName = @"jilu-error";
//        alert0.sex = self.sex;
//        [alert0 show];
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
    
    
    UIImageView *header00 = [[UIImageView alloc] initWithFrame:CGRectMake((_alert.frame.size.width - 50)/2, (_alert.frame.size.height-49)/2-30, 50, 49)];
    
    if ([errorSts intValue] == 0) {
        header00.image = [UIImage imageNamed:@"caidan-morentouxiang-small" ofSex:self.sex];
    }else{
        header00.image = [UIImage imageNamed:@"jilu-error" ofSex:self.sex];
    }
    [_alert addSubview:header00];
    
    
    UILabel *labe = [[UILabel alloc] initWithFrame:CGRectMake(10, header00.frame.size.height+header00.frame.origin.y + 15, _alert.frame.size.width-20, 30)];
    labe.text = errorSts;
    
    labe.textColor = wordColor;
    labe.textAlignment = NSTextAlignmentCenter;
    labe.font = [UIFont yaHeiFontOfSize:17];
    labe.numberOfLines = 0;
    
    [_alert addSubview:labe];
    
    
    
    [ciew addSubview:_alert];
    
    
    
    //                [self.view.window updateConstraints];
    [self.view.window bringSubviewToFront:ciew];
}


/*
-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        UITextField *tex = [alert textFieldAtIndex:0];
        [NetRequestManage submitFeedbackWithTextfield:fied.text andPwd:tex.text successBlocks:^(NSData *data, NetRequestManage *loadUser) {
            
            NSString *str = [[NSString alloc] initWithData:loadUser.resultData encoding:NSUTF8StringEncoding];
            NSLog(@"tijiafanhui = %@",str);
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:loadUser.resultData options:NSJSONReadingMutableContainers error:nil];
            
            if ([[dic objectForKey:@"errorId"] intValue] == 0) {
                FeedbackFeedbackList *fee = [[FeedbackFeedbackList alloc] init];
                fee.backcontent = fied.text;
                fee.backtype = @"1";
                [_fanKuiDataArr addObject:fee];
                [tab reloadData];
                fied.text = nil;
            }else{
                
                
                [self alertViewWith:[ErrorStatus errorStatus:[dic objectForKey:@"errorId"] parmStr:nil]];
//                TAlertView *alert0 = [[TAlertView alloc]initWithTitle:[ErrorStatus errorStatus:[dic objectForKey:@"errorId"] parmStr:nil] andMessage:nil];
//                alert0.style = TAlertViewStyleNeutral;
//                alert0.center = self.view.center;
//                alert0.imageName = @"jilu-error";
//                alert0.sex = self.sex;
//                [alert0 show];
            }
            
        } andFailedBlocks:^(NSError *error, NetRequestManage *loadUser) {
            NSLog(@"tijiaofankui error = %@",error.description);
            
        }];

        
        
    }
}
*/


#pragma mark - tableViewdelegate相关

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    UIFont *font = [UIFont yaHeiFontOfSize:16];
    NSDictionary *dict = [NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName];
    FeedbackFeedbackList *feed = [_fanKuiDataArr objectAtIndex:indexPath.row];
    CGRect rect = [feed.backcontent boundingRectWithSize:CGSizeMake(330, 2000) options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil];
    return rect.size.height + 20;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *str = @"tableViewCellIdentifier";
    
    RickyCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (cell == nil) {
        cell = [[RickyCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
    }
    
    FeedbackFeedbackList *fedback =_fanKuiDataArr[indexPath.row];
    
    [cell makeCellWithStr:(([fedback.backtype isEqualToString:@"1"])?fedback.backcontent:[NSString stringWithFormat:@"客服：%@",fedback.backcontent]) andISCustome:(([fedback.backtype isEqualToString:@"1"])?YES:NO) andISGirl:self.sex];
    
//    [cell.layer addSublayer:button.titleLabel.layer];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_fanKuiDataArr count];
}


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
    
//    UITextField *text0 = [alert textFieldAtIndex:0];
//    [text0 resignFirstResponder];
    UITextField *text = [[[self.view.window viewWithTag:8888] viewWithTag:6666] viewWithTag:5555];
    [text resignFirstResponder];
    
    UITextField *text1 = (UITextField *)[_right3 viewWithTag:1111];
    [text1 resignFirstResponder];
    
    
    
}


-(void)removeText:(UIButton *)button{
    UITextField *textAccess = (UITextField *)[button.superview viewWithTag:8000];
    
    textAccess.text = nil;
    [textAccess resignFirstResponder];
//    UITextField *text0 = [alert textFieldAtIndex:0];
//    text0.text = nil;
//    [text0 resignFirstResponder];
    UITextField *text1 = [[[self.view.window viewWithTag:8888] viewWithTag:6666] viewWithTag:5555];
    text1.text = nil;
    [text1 resignFirstResponder];
    
    UITextField *text2 = (UITextField *)[_right3 viewWithTag:1111];
    text2.text = nil;
    
    [text2 resignFirstResponder];
}
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    
    
        
    
}
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    _tagOfTextField = textField.tag;

//    [textField becomeFirstResponder];
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
    UITextField *text = (UITextField *)[_right3 viewWithTag:1111];
    
    UITextField *text1 = [[[self.view.window viewWithTag:8888] viewWithTag:6666] viewWithTag:5555];
    UITextField *textAccess = (UITextField *)[text.inputAccessoryView viewWithTag:8000];
    
    UITextField *textAccess1 = (UITextField *)[text1.inputAccessoryView viewWithTag:8000];
    if (_isAccessoryView) {
        if (_tagOfTextField == 1111) {
            text.text = textAccess.text;
        }else{
            text1.text = textAccess1.text;
        }
        
        
        
    }else{
        if (_tagOfTextField == 1111) {
            textAccess.text = text.text;
        }else{
            textAccess1.text = text1.text;
        }
        
        
    }
}
-(void)viewWillDisappear:(BOOL)animated{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];
    
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
