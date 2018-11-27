//
//  CommentViewController.m
//  BabyDemo
//
//  Created by 陈彦 on 16/2/26.
//  Copyright © 2016年 elsa. All rights reserved.
//


//firstRecordStatus

//  0新用户，1未提交，2已提交，3已发送给医生，4医生已反馈，5医生已阅读，6已跳过医生

#import "CommentViewController.h"
#import "PictureViewController.h"
#import "NetRequestManage.h"
#import "SVProgressHUD.h"
#import "OnlineAppraisalDataModels.h"
#import "LoginUser.h"
#import "ServerConfigDoctorList.h"
#import "ServerConfigHospitalList.h"

#import "UIImageView+WebCache.h"
#import "CYRecordAlertView.h"

#import "BuyViewController.h"
#import "AppDelegate.h"



@interface CommentViewController ()<UIPickerViewDelegate,UIPickerViewDataSource>{
    UIView *pickerBgView;//选择器
    UIPickerView *picker;
    UIView *contentView;
    NSMutableArray *pickerDataArr;
    
    //数据部分
    NSMutableArray *_onlineAppraisalArr;
    OnlineAppraisalOnlineAppraisal *_currentOnline;
    int _currentRow;
    OnlineAppraisalObject *online;
    LoginUser *user;
    NSDictionary *_localDoctorDic;
    
    int _month;
    UIButton *month;
    UIView *starView;
    UILabel *feedStyle;
    UILabel *commentDetail;
    UILabel *commentDetail1;
    
    NSString *_userRole;
    BOOL _isSubmit;
    
    UIView *neverNum;
    UILabel *PGtishi;
    
    BOOL _isfirst;
    
    
    UILabel *doctorName;
    UILabel *doctorPositionaltitles;
    UILabel *hospitalName;
    
    UILabel *fileNum;
    UILabel *birth;
    UILabel *name;
    UIImageView *sexImg;
    UIImageView *doctorHeader;
    
    NSString *_recordStatus;
}

@end

@implementation CommentViewController


-(void)viewWillAppear:(BOOL)animated{
    
    
    for (int i=0; i<4; i++) {
        UIButton *butt = (UIButton *)[self.view viewWithTag:1180+i];
        butt.selected = NO;
    }
    
    
    
    if (_isfirst == NO) {
        
        _userRole = [[NSUserDefaults standardUserDefaults] objectForKey:@"userRole"];

        [NetRequestManage getOnlineAppraisalWithUserId:[[NSUserDefaults standardUserDefaults] objectForKey:@"userId"] successBlocks:^(NSData *data, NetRequestManage *onlineAppraisal) {
            NSString *str = [[NSString alloc] initWithData:onlineAppraisal.resultData encoding:NSUTF8StringEncoding];
            NSLog(@"getOnlineApprasial = %@",str);
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:onlineAppraisal.resultData options:NSJSONReadingMutableContainers error:nil];
            online = nil;
            [_onlineAppraisalArr removeAllObjects];
            _currentOnline = nil;
            pickerDataArr = nil;
            online = [[OnlineAppraisalObject alloc] initWithDictionary:dic];
            if (online.errorId == 0) {
                
                if (online.result.onlineAppraisal.count > 0 ) {
                    
                    [_onlineAppraisalArr addObjectsFromArray:online.result.onlineAppraisal];
                    _recordStatus = [[[dic objectForKey:@"result"] objectForKey:@"recordByAge"] objectForKey:@"recordstatus"];
                    _currentOnline = _onlineAppraisalArr[0];

                    if ((([_recordStatus intValue] < 2)||([_recordStatus intValue] == 4))&&(_currentOnline.appraisalage)) {
                        
                    }else{
                        OnlineAppraisalOnlineAppraisal *newOnline = [[OnlineAppraisalOnlineAppraisal alloc] initWithDictionary:@{}];
                        newOnline.appraisalage = [NSString stringWithFormat:@"%d",_month];
                        newOnline.star = @"0";
                        newOnline.feedingType = 0;
                        newOnline.doctorid = user.doctorid;
                        newOnline.growthappraisal = @"线上评估将在一周后反馈，请您耐心等待";
                        newOnline.mindappraisal = @"线上评估将在一周后反馈，请您耐心等待";
                        [_onlineAppraisalArr insertObject:newOnline atIndex:0];
                    }
                    pickerDataArr = [[NSMutableArray alloc] init];
                    for (int i=0; i<_onlineAppraisalArr.count;i++) {
                        
                        OnlineAppraisalOnlineAppraisal *appraisal = _onlineAppraisalArr[i];
                        [pickerDataArr addObject:[NSString stringWithFormat:@"%@个月",appraisal.appraisalage]];
                        
                    }
                    

                    
                }
                
                if ([online.result.firstRecordStatus intValue] < 2) {
                    _isSubmit = NO;
                    
                }else if (([online.result.firstRecordStatus intValue] > 1)&&([online.result.firstRecordStatus intValue] < 4)){
                    _isSubmit = YES;
                }
                neverNum.hidden =((([_userRole intValue] != 0)&&(_onlineAppraisalArr.count == 0))?NO:YES);
                PGtishi.text = (_isSubmit == YES)?@"线上评估将在一周后反馈，请您耐心等待":@"您需要先提交记录，医生才能对您的宝宝进行评估" ;
                [self.view layoutSubviews];
                [picker reloadAllComponents];
                
                
                
//                16.10.12
                if (_currentOnline) {
                    [self reloadSelfView:0];
                    NSString *monthString = nil;
                    if ((([_recordStatus intValue] < 2)||([_recordStatus intValue] == 4))&&(_currentOnline.appraisalage)) {
                        monthString = _currentOnline.appraisalage;
                    }else{
                        monthString = [NSString stringWithFormat:@"%d",_month];
                    }
                    
                    [month setTitle:[NSString stringWithFormat:@"%@个月",monthString] forState:UIControlStateNormal];
                    UIButton *rightBtn = (UIButton *)[contentView viewWithTag:1291];
                    rightBtn.hidden = YES;
                    if ([_userRole intValue] != 0) {
                        if (_onlineAppraisalArr.count > 1) {
                            UIButton *leftBtn = (UIButton *)[contentView viewWithTag:1290];
                            leftBtn.hidden = NO;
                        }
                    }
                    ServerConfigDoctorList *doctor = [[ServerConfigDoctorList alloc] initWithDictionary:[_localDoctorDic objectForKey:_currentOnline.doctorid]];
                    ServerConfigHospitalList *hospital = [[ServerConfigHospitalList alloc] initWithDictionary:[[[NSUserDefaults standardUserDefaults] objectForKey:@"hospitalDic"] objectForKey:doctor.hospitalid]];
                    
                    [doctorHeader sd_setImageWithURL:[NSURL URLWithString:[NSString urlStringOfImage:doctor.head]] placeholderImage:[UIImage imageNamed:@"chouti_01"]];
                    doctorName.text = doctor.doctorname;
                    doctorPositionaltitles.text = doctor.positionaltitles;
                    hospitalName.text = hospital.hospitalname;
                    CGSize hospitalSize = [hospitalName sizeThatFits:CGSizeMake(200*Ratio, 20000*Ratio)];
                    [hospitalName mas_updateConstraints:^(MASConstraintMaker *make) {
                        make.height.mas_equalTo(hospitalSize.height);
                    }];
                    
                    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
                    [paragraphStyle setLineSpacing:6];
                    NSString *commmentDetail_161012 = nil;
                    if ([_recordStatus intValue] == 2) {
                        commmentDetail_161012 = @"等待短信通知,查看最新评估报告。";
                    }else if (([_recordStatus intValue] > 2)&&([_recordStatus intValue] != 4)){
                        commmentDetail_161012 = @"线上评估将在一周后反馈，请您耐心等待";
                    }else{
                        commmentDetail_161012 = [_currentOnline.growthappraisal stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
                    }
                    commentDetail.text = commmentDetail_161012;
                    
                    
                    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:commentDetail.text];;
                    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, commentDetail.text.length)];
                    commentDetail.attributedText = attributedString;
                    CGSize size = [commentDetail sizeThatFits:CGSizeMake(234*Ratio, 200000)];
                    [commentDetail mas_updateConstraints:^(MASConstraintMaker *make) {
                        make.height.mas_equalTo(size.height+ 15);
                    }];
                    
                    
                    NSString *commmentDetail1_161012 = nil;
                    if ([_recordStatus intValue] == 2) {
                        commmentDetail1_161012 = @"等待短信通知,查看最新评估报告。";
                    }else if (([_recordStatus intValue] > 2)&&([_recordStatus intValue] != 4)){
                        commmentDetail1_161012 = @"线上评估将在一周后反馈，请您耐心等待";
                    }else{
                        commmentDetail1_161012 = [_currentOnline.mindappraisal stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
                    }
                    commentDetail1.text = commmentDetail1_161012;
                    
                    NSMutableAttributedString *attributedString1 = [[NSMutableAttributedString alloc]initWithString:commentDetail1.text];;
                    [attributedString1 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, commentDetail1.text.length)];
                    commentDetail1.attributedText = attributedString1;
                    CGSize size1 = [commentDetail1 sizeThatFits:CGSizeMake(234*Ratio, 200000)];
                    [commentDetail1 mas_updateConstraints:^(MASConstraintMaker *make) {
                        make.height.mas_equalTo(size1.height+ 15);
                    }];
                    

                }
                
//                if (_currentOnline) {
//                    [self cyReloadSelfView];
//
//                }
                
                
                

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
            
            
            
            
        } andFailedBlocks:^(NSError *error, NetRequestManage *onlineAppraisal) {
            
            NSLog(@"onlineAppraisal Error = %@",error.localizedDescription);
        }];
        
        
        

    }
    
    
    _isfirst = NO;
    
}
-(void)showAlertView{
    UIView *ciew = [self.view.window viewWithTag:6666];
    ciew.hidden = NO;
    for (int i=0; i<[ciew.subviews count]; i++) {
        UIView *ve = ciew.subviews[i];
        [ve removeFromSuperview];
    }
    ciew.backgroundColor = [UIColor colorWithRed:120/255.0 green:120/255.0 blue:120/255.0 alpha:0.1];
    UIImageView *yindao = [[UIImageView alloc] init];
    yindao.image = [UIImage imageNamed:@"pinggu_yindaoye"];
    yindao.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeView)];
    [yindao addGestureRecognizer:tap];
    [ciew addSubview:yindao];
    [yindao mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(320*Ratio, 568*Ratio));
        make.edges.equalTo(ciew);
    }];
    [[NSUserDefaults standardUserDefaults] setObject:@"YES" forKey:@"manyOfPG"];
    [self.view.window bringSubviewToFront:ciew];
    
    
}
-(void)removeView{
    
    UIView *ciew = [self.view.window viewWithTag:6666];
    ciew.hidden = YES;
    ciew.backgroundColor = [UIColor colorWithRed:120/255.0 green:120/255.0 blue:120/255.0 alpha:0.3];
    
    [self.view.window sendSubviewToBack:ciew];
    
}
-(void)viewDidAppear:(BOOL)animated{
    
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"manyOfPG"]) {
    
        [self performSelector:@selector(showAlertView) withObject:nil afterDelay:0.1];
  
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _isfirst = YES;
    _onlineAppraisalArr = [[NSMutableArray alloc] init];
    NSDictionary *userDic = [[NSUserDefaults standardUserDefaults] objectForKey:@"user"];
//    NSLog(@"userDic = %@",userDic);
    user = [[LoginUser alloc] initWithDictionary:userDic];
    _month = [[[NSUserDefaults standardUserDefaults] objectForKey:@"month"] intValue];
    _isSubmit = NO;
    self.view.backgroundColor = [UIColor whiteColor];

    _userRole = [[NSUserDefaults standardUserDefaults] objectForKey:@"userRole"];
#pragma mark = pickerDataArr 假数据
    
    [self leftBtn];


    //医生
    _localDoctorDic = [[NSUserDefaults standardUserDefaults] objectForKey:@"doctorDic"];
    
    _recordStatus = nil;
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    [SVProgressHUD show];
    [NetRequestManage getOnlineAppraisalWithUserId:[[NSUserDefaults standardUserDefaults] objectForKey:@"userId"] successBlocks:^(NSData *data, NetRequestManage *onlineAppraisal) {
        NSString *str = [[NSString alloc] initWithData:onlineAppraisal.resultData encoding:NSUTF8StringEncoding];
        NSLog(@"getOnlineApprasial = %@",str);
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:onlineAppraisal.resultData options:NSJSONReadingMutableContainers error:nil];
        online = [[OnlineAppraisalObject alloc] initWithDictionary:dic];
        if (online.errorId == 0) {
            
            if (online.result.onlineAppraisal.count > 0 ) {
                
                [_onlineAppraisalArr addObjectsFromArray:online.result.onlineAppraisal];
                _recordStatus = [[[dic objectForKey:@"result"] objectForKey:@"recordByAge"] objectForKey:@"recordstatus"];
                _currentOnline = _onlineAppraisalArr[0];

                if ((([_recordStatus intValue] < 2)||([_recordStatus intValue] == 4))&&(_currentOnline.appraisalage)) {
                    
                }else{
                    OnlineAppraisalOnlineAppraisal *newOnline = [[OnlineAppraisalOnlineAppraisal alloc] initWithDictionary:@{}];
                    newOnline.appraisalage = [NSString stringWithFormat:@"%d",_month];
                    newOnline.star = @"0";
                    newOnline.feedingType = 0;
                    newOnline.doctorid = user.doctorid;
                    newOnline.growthappraisal = @"线上评估将在一周后反馈，请您耐心等待";
                    newOnline.mindappraisal = @"线上评估将在一周后反馈，请您耐心等待";
                    [_onlineAppraisalArr insertObject:newOnline atIndex:0];
                }
                pickerDataArr = [[NSMutableArray alloc] init];
                for (int i=0; i<_onlineAppraisalArr.count;i++) {
                    
                    OnlineAppraisalOnlineAppraisal *appraisal = _onlineAppraisalArr[i];
                    [pickerDataArr addObject:[NSString stringWithFormat:@"%@个月",appraisal.appraisalage]];
                    
                }
    
               

            }
            [SVProgressHUD dismiss];

            if ([online.result.firstRecordStatus intValue] < 2) {
                _isSubmit = NO;
                
            }else if (([online.result.firstRecordStatus intValue] > 1)&&([online.result.firstRecordStatus intValue] < 4)){
                _isSubmit = YES;
            }
            [self createInterface];
            [self createPickerView];

        }else{
            
            
            [SVProgressHUD dismiss];
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
        
        
        
        
    } andFailedBlocks:^(NSError *error, NetRequestManage *onlineAppraisal) {
        [SVProgressHUD showErrorWithStatus:error.localizedDescription];
        
    }];
    // Do any additional setup after loading the view.
}

#pragma mark =  左边按钮
-(void)leftBtn{
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageNamed:@"shouye_top_left"] forState:UIControlStateNormal];
    button.selected = NO;
    [button addTarget:self action:@selector(leftBtnBlock:) forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(0, 0, 16*Ratio, 16*Ratio);
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    
}
#pragma mark - 侧边栏

-(void)leftBtnBlock:(UIButton *)button{
    
    
    RickyNavViewController *nav = (RickyNavViewController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    
    LeftViewController *left = (LeftViewController *)[nav.viewControllers objectAtIndex:0];
    
    [left ChangeSlideStatus];
}

#pragma mark - 选择器
-(void)createPickerView{
    
#pragma mark = 选择器
    
    pickerBgView = [[UIView alloc] init];
    pickerBgView.backgroundColor = MBColor(190, 191, 192, 0.5);
    pickerBgView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pickerViewClick:)];
    [pickerBgView addGestureRecognizer:tap];
    
    [self.view addSubview:pickerBgView];
    [pickerBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(self.view);
        make.center.equalTo(self.view);
    }];
    
    
    picker = [[UIPickerView alloc] init];
    picker.dataSource = self;
    picker.delegate = self;
    picker.backgroundColor = [UIColor whiteColor];
    picker.showsSelectionIndicator = NO;

    [pickerBgView addSubview:picker];
    [picker mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(pickerBgView);
        
        make.size.mas_equalTo(CGSizeMake(320*Ratio, 215*Ratio));
        make.centerX.equalTo(pickerBgView);
    }];
    [self.view bringSubviewToFront:pickerBgView];
    
    pickerBgView.hidden = YES;
    
}
#pragma mark - 主页面
-(void)createInterface{
    if ([self respondsToSelector:@selector(automaticallyAdjustsScrollViewInsets)]) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    UIScrollView *sc = [[UIScrollView alloc] init];
    [self.view addSubview:sc];
    [sc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self.view);
        make.top.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-137*Ratio);
    }];
    contentView = [[UIView alloc] init];
    [sc addSubview:contentView];
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(sc);
        make.width.equalTo(sc);
    }];
#pragma mark = 编号
    fileNum = [[UILabel alloc] init];
    [fileNum makeLabelWithText:[NSString stringWithFormat:@"档案编号：%@",(!user.filecode)?@"无":user.filecode] andTextColor:MBColor(102, 102, 102, 1) andFont:[UIFont yaHeiFontOfSize:10*Ratio]];
    [contentView addSubview:fileNum];
    [fileNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contentView).offset(14*Ratio);
        make.left.equalTo(contentView).offset(10*Ratio);
        make.size.mas_equalTo(CGSizeMake(160*Ratio, 12*Ratio));
    }];
    
#pragma mark = 生日
    birth = [[UILabel alloc] init];
    [birth makeLabelWithText:[NSString stringWithFormat:@"生日：%@",user.birthday] andTextColor:MBColor(102, 102, 102, 1) andFont:[UIFont yaHeiFontOfSize:10*Ratio]];
    birth.textAlignment = NSTextAlignmentRight;
    [contentView addSubview:birth];
    [birth mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(contentView).offset(-10*Ratio);
        make.centerY.equalTo(fileNum);
        make.size.mas_equalTo(CGSizeMake(100*Ratio, 12*Ratio));
    }];
#pragma mark = 月龄
    
    
    month = [UIButton buttonWithType:UIButtonTypeCustom];
//    [month setBackgroundImage:[UIImage imageNamed:@"aaaa"] forState:UIControlStateNormal];
    NSString *monthString = nil;
    if ((([_recordStatus intValue] < 2)||([_recordStatus intValue] == 4))&&(_currentOnline.appraisalage)) {
        monthString = _currentOnline.appraisalage;
    }else{
        monthString = [NSString stringWithFormat:@"%d",_month];
    }
    
    [month setTitle:[NSString stringWithFormat:@"%@个月",monthString] forState:UIControlStateNormal];
    
//    if ((_onlineAppraisalArr.count > 1)||((_onlineAppraisalArr.count == 1)&&([_recordStatus intValue] > 1)&&([_recordStatus intValue] != 4))) {
//        [month setBackgroundImage:[UIImage imageNamed:@"aaaa"] forState:UIControlStateNormal];
//    }else{
//        [month setBackgroundImage:nil forState:UIControlStateNormal];
//    }
    
    
    [month setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [month addTarget:self action:@selector(monthSelected:) forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview:month];
    [month mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(contentView);
        make.top.equalTo(birth.mas_bottom).offset(10*Ratio);
        make.size.mas_equalTo(CGSizeMake(80*Ratio, 20*Ratio));
    }];
    
    //tag = 1292
    for (int i=0; i<2; i++) {
        
        UIButton *jinatou = [UIButton buttonWithType:UIButtonTypeCustom];
//        jinatou.backgroundColor = [UIColor yellowColor];
        [jinatou setImage:[UIImage imageNamed:[NSString stringWithFormat:@"jiantou%d",i+1]] forState:UIControlStateNormal];
        jinatou.contentMode = UIViewContentModeCenter;
        [jinatou addTarget:self action:@selector(jumpMonth:) forControlEvents:UIControlEventTouchUpInside];
//        [jinatou addTarget:self action:@selector(jumpMonth:) forControlEvents:UIControlEventTouchUpInside];
        jinatou.tag = 1290+i;
        [contentView addSubview:jinatou];
        [jinatou mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(50*Ratio, 50*Ratio));
            make.centerY.equalTo(month);
            if (i==0) {
                make.right.equalTo(month.mas_left);
            }else{
                make.left.equalTo(month.mas_right);
            }
        }];
        
        jinatou.hidden = YES;
    }
    if ([_userRole intValue] != 0) {
        if (_onlineAppraisalArr.count > 1) {
            UIButton *leftBtn = (UIButton *)[contentView viewWithTag:1290];
            leftBtn.hidden = NO;
        }
    }
    
    
#pragma mark = 名字与性别
    sexImg = [[UIImageView alloc] init];
    sexImg.image = [UIImage imageNamed:[NSString stringWithFormat:@"shouye_icon_red_%@",user.sex]];
    [contentView addSubview:sexImg];
    [sexImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView).offset(32.5*Ratio);
        make.top.equalTo(month.mas_bottom).offset(10*Ratio);
        make.size.mas_equalTo(CGSizeMake(10*Ratio, 10*Ratio));
    }];
    
    
    name = [[UILabel alloc] init];
    [name makeLabelWithText:user.truename andTextColor:MBColor(102, 102, 102, 1) andFont:[UIFont yaHeiFontOfSize:11*Ratio]];
    [contentView addSubview:name];
    [name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(sexImg);
        make.left.equalTo(sexImg.mas_right).offset(5*Ratio);
        make.size.mas_equalTo(CGSizeMake(100*Ratio, 14*Ratio));
    }];
    
    
#pragma mark = 星星
    int starNum = [_currentOnline.star intValue];
    starView = [[UIView alloc] init];
    [contentView addSubview:starView];
    [starView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(name);
        make.centerX.mas_equalTo(contentView);
        make.height.mas_equalTo(15*Ratio);

    }];
    [starView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(15*starNum*Ratio);

    }];
    UIImageView *lastStar = nil;
    
    for (int i=0; i<starNum; i++) {
        UIImageView *star = [[UIImageView alloc] init];
        star.image = [UIImage imageNamed:@"star"];
        [starView addSubview:star];
        [star mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(15*Ratio, 15*Ratio));
            make.centerY.equalTo(starView);
            if (lastStar) {
                make.left.equalTo(lastStar.mas_right);
            }else{
                make.left.equalTo(starView);
            }
        }];
        lastStar = star;
    }

    
    
    
#pragma mark = 宝宝是否足月及喂养方式
    
    UILabel *fullMonth = [[UILabel alloc] init];
    int enter = [user.borntype intValue];
    NSString *bordTypeStr = nil;
    if (enter == 1) {
        bordTypeStr = @"足月儿";
    }else if (enter == 2){
        bordTypeStr = @"早产儿";
    }else if (enter == 3){
        bordTypeStr = @"低出生体重";
    }else{
        bordTypeStr = @"";
    }
    [fullMonth makeLabelWithText:bordTypeStr andTextColor:MBColor(102, 102, 102, 1) andFont:[UIFont yaHeiFontOfSize:11*Ratio]];
    fullMonth.textAlignment = NSTextAlignmentCenter;
    [contentView addSubview:fullMonth];
    [fullMonth mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(starView.mas_centerY);
        make.right.equalTo(contentView).offset(-24*Ratio);
        make.size.mas_equalTo(CGSizeMake(70*Ratio, 14*Ratio));
    }];
    
    
    feedStyle = [[UILabel alloc] init];
    int temp = _currentOnline.feedingType;
    NSString *feedingTypeStr = nil;
    if (temp == 1) {
        feedingTypeStr = @"母乳喂养";
    }else if (temp == 2){
        feedingTypeStr = @"配方奶喂养";
    }else if (temp == 3){
        feedingTypeStr = @"混合喂养";
    }else{
        feedingTypeStr = @"";
    }
    [feedStyle makeLabelWithText:feedingTypeStr andTextColor:MBColor(102, 102, 102, 1) andFont:[UIFont yaHeiFontOfSize:11*Ratio]];
    feedStyle.textAlignment = NSTextAlignmentCenter;
    [contentView addSubview:feedStyle];
    [feedStyle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(starView.mas_centerY);
        make.right.equalTo(contentView).offset(-24*Ratio);
        make.size.mas_equalTo(CGSizeMake(70*Ratio, 14*Ratio));
    }];
#pragma mark = 划线
    [contentView addLineWithY:87];
    
    
    
#pragma mark = 医生头像及指导
    doctorHeader = [[UIImageView alloc] init];
    ServerConfigDoctorList *doctor = [[ServerConfigDoctorList alloc] initWithDictionary:[_localDoctorDic objectForKey:_currentOnline.doctorid]];
    ServerConfigHospitalList *hospital = [[ServerConfigHospitalList alloc] initWithDictionary:[[[NSUserDefaults standardUserDefaults] objectForKey:@"hospitalDic"] objectForKey:doctor.hospitalid]];

    [doctorHeader sd_setImageWithURL:[NSURL URLWithString:[NSString urlStringOfImage:doctor.head]] placeholderImage:[UIImage imageNamed:@"chouti_01"]];
    doctorHeader.layer.masksToBounds = YES;
    doctorHeader.layer.cornerRadius = 30*Ratio;
    [contentView addSubview:doctorHeader];
    [doctorHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(starView.mas_bottom).offset(25*Ratio);
        make.size.mas_equalTo(CGSizeMake(60*Ratio, ([_userRole intValue] == 0)?0:60*Ratio));
        make.left.equalTo(contentView).offset(25*Ratio);
        
    }];
    
    doctorName = [[UILabel alloc] init];
    [doctorName makeLabelWithText:doctor.doctorname andTextColor:MBColor(51, 51, 51, 1) andFont:[UIFont yaHeiFontOfSize:14*Ratio]];
    [contentView addSubview:doctorName];
    [doctorName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(doctorHeader.mas_right).offset(10*Ratio);
        make.top.equalTo(doctorHeader);
        make.size.mas_equalTo(CGSizeMake(120*Ratio, 18*Ratio));
    }];
    
    
    doctorPositionaltitles = [[UILabel alloc] init];
    [doctorPositionaltitles makeLabelWithText:doctor.positionaltitles andTextColor:MBColor(128, 128, 128, 1) andFont:[UIFont yaHeiFontOfSize:12*Ratio]];
    [contentView addSubview:doctorPositionaltitles];
    [doctorPositionaltitles mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(doctorHeader.mas_right).offset(10*Ratio);
        make.top.equalTo(doctorName.mas_bottom).offset(10*Ratio);
        make.size.mas_equalTo(CGSizeMake(120*Ratio, 13*Ratio));
    }];
    
    hospitalName = [[UILabel alloc] init];
    [hospitalName makeLabelWithText:hospital.hospitalname andTextColor:MBColor(128, 128, 128, 1) andFont:[UIFont yaHeiFontOfSize:12*Ratio]];
    hospitalName.numberOfLines = 0;
    [contentView addSubview:hospitalName];
    CGSize hospitalSize = [hospitalName sizeThatFits:CGSizeMake(200*Ratio, 20000*Ratio)];
    [hospitalName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(200*Ratio, hospitalSize.height));
        make.left.equalTo(doctorPositionaltitles);
        make.top.equalTo(doctorPositionaltitles.mas_bottom).offset(10*Ratio);
    }];
    
    
    
    
    
    
    UILabel *commentTitle = [[UILabel alloc] init];
    
    [commentTitle makeLabelWithText:([_userRole intValue] == 0)?@"体格生长评估，神经心理、发育行为评估":@"体格生长评估" andTextColor:MBColor(239, 67, 153, 1) andFont:[UIFont yaHeiFontOfSize:14*Ratio]];
    [contentView addSubview:commentTitle];
    [commentTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(contentView);
        make.top.equalTo(hospitalName.mas_bottom).offset(15*Ratio);
        make.size.mas_equalTo(CGSizeMake(320*Ratio, 15*Ratio));
        
    }];
    commentTitle.textAlignment = NSTextAlignmentCenter;

    commentDetail = [[UILabel alloc] init];
    NSString *commmentDetail_161012 = nil;
    if ([_recordStatus intValue] == 2) {
        commmentDetail_161012 = @"等待短信通知,查看最新评估报告。";
    }else if (([_recordStatus intValue] > 2)&&([_recordStatus intValue] != 4)){
        commmentDetail_161012 = @"线上评估将在一周后反馈，请您耐心等待";
    }else{
        commmentDetail_161012 = [_currentOnline.growthappraisal stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    }
    
    [commentDetail makeLabelWithText:([[_currentOnline.growthappraisal stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length] == 0)?@"宝宝生长发育好不好可以请儿保专家来评估一下哦！":commmentDetail_161012 andTextColor:MBColor(83, 83, 83, 1) andFont:[UIFont yaHeiFontOfSize:13*Ratio]];
    commentDetail.numberOfLines = 0;
    if ([commentDetail.text isEqualToString:@"等待短信通知,查看最新评估报告。"]||[commentDetail.text isEqualToString:@"线上评估将在一周后反馈，请您耐心等待"]) {
        commentDetail.textAlignment = NSTextAlignmentCenter;
    }else{
        commentDetail.textAlignment = NSTextAlignmentLeft;

    }
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:commentDetail.text];;
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:6];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, commentDetail.text.length)];
    commentDetail.attributedText = attributedString;
    
    CGSize size = [commentDetail sizeThatFits:CGSizeMake(234*Ratio, 200000)];
    [contentView addSubview:commentDetail];
    [commentDetail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(commentTitle.mas_bottom).offset(5*Ratio);
        make.width.mas_equalTo(237*Ratio);
        make.height.mas_equalTo(size.height + 15);
        make.centerX.equalTo(contentView);
    }];
    UILabel *commentTitle1 = [[UILabel alloc] init];
    [commentTitle1 makeLabelWithText:([_userRole intValue] == 0)?@"":@"神经心理、发育行为评估" andTextColor:MBColor(239, 67, 153, 1) andFont:[UIFont yaHeiFontOfSize:14*Ratio]];
    [contentView addSubview:commentTitle1];
    commentTitle1.textAlignment = NSTextAlignmentCenter;

    [commentTitle1 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(contentView);
        make.top.equalTo(commentDetail.mas_bottom).offset(20*Ratio);
        make.size.mas_equalTo(CGSizeMake(320*Ratio, 15*Ratio));
        
    }];
    
    commentDetail1 = [[UILabel alloc] init];
    NSString *commmentDetail1_161012 = nil;
    if ([_recordStatus intValue] == 2) {
        commmentDetail1_161012 = @"等待短信通知,查看最新评估报告。";
    }else if (([_recordStatus intValue] > 2)&&([_recordStatus intValue] != 4)){
        commmentDetail1_161012 = @"线上评估将在一周后反馈，请您耐心等待";
    }else{
        commmentDetail1_161012 = [_currentOnline.mindappraisal stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    }
    [commentDetail1 makeLabelWithText:([[_currentOnline.mindappraisal stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length] == 0)?@"":commmentDetail1_161012 andTextColor:MBColor(83, 83, 83, 1) andFont:[UIFont yaHeiFontOfSize:13*Ratio]];
    commentDetail1.numberOfLines = 0;
    if ([commentDetail1.text isEqualToString:@"等待短信通知,查看最新评估报告。"]||[commentDetail.text isEqualToString:@"线上评估将在一周后反馈，请您耐心等待"]) {
        commentDetail1.textAlignment = NSTextAlignmentCenter;
    }else{
        commentDetail1.textAlignment = NSTextAlignmentLeft;
        
    }
    NSMutableAttributedString *attributedString1 = [[NSMutableAttributedString alloc]initWithString:commentDetail1.text];;
    [attributedString1 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, commentDetail1.text.length)];
    commentDetail1.attributedText = attributedString1;
    CGSize size1 = [commentDetail1 sizeThatFits:CGSizeMake(234*Ratio, 200000)];
    [contentView addSubview:commentDetail1];
    [commentDetail1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(commentTitle1.mas_bottom).offset(5*Ratio);
        make.width.mas_equalTo(237*Ratio);
        make.height.mas_equalTo(size1.height+ 15);
        make.centerX.equalTo(contentView);
    }];
    
    UIButton *buyButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [buyButton setBackgroundImage:[UIImage imageNamed:@"btn_chouti_info_goumai"] forState:UIControlStateNormal];
    [buyButton setTitle:@"购买" forState:UIControlStateNormal];
    [buyButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    buyButton.hidden = ([_userRole intValue] == 0)?NO:YES;
    [buyButton addTarget:self action:@selector(buyAction:) forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview:buyButton];
    [buyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(50*Ratio, 20*Ratio));
        make.centerX.equalTo(contentView);
        make.top.equalTo(commentDetail.mas_bottom).offset(10*Ratio);
    }];
    
    
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(commentDetail1);
    }];
    
#pragma mark = 付费用户没有提交记录时的评估提示语
    
    neverNum = [[UIView alloc] init];
    neverNum.backgroundColor = [UIColor whiteColor];
    neverNum.hidden =((([_userRole intValue] != 0)&&(_onlineAppraisalArr.count == 0))?NO:YES);
    [self.view addSubview:neverNum];
    [neverNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self.view);
        make.top.equalTo(self.view);
        make.height.mas_equalTo(370*Ratio);
    }];
    
    UIImageView *tempDoctor = [[UIImageView alloc] init];
    tempDoctor.image = [UIImage imageNamed:@"pinggu_kong"];
    [neverNum addSubview:tempDoctor];
    [tempDoctor mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100*Ratio, 100*Ratio));
        make.center.equalTo(neverNum);
    }];
    PGtishi = [[UILabel alloc] init];
    [PGtishi makeLabelWithText:(_isSubmit == YES)?@"线上评估将在一周后反馈，请您耐心等待":@"您需要先提交记录，医生才能对您的宝宝进行评估" andTextColor:MBColor(102, 103, 104, 1) andFont:[UIFont yaHeiFontOfSize:14*Ratio]];
    PGtishi.numberOfLines = 0;
    PGtishi.textAlignment = NSTextAlignmentCenter;
    [neverNum addSubview:PGtishi];
    [PGtishi mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(neverNum);
        make.top.equalTo(tempDoctor.mas_bottom).offset(14*Ratio);
        make.size.mas_equalTo(CGSizeMake(160*Ratio, 40*Ratio));
    }];
    
    [self.view addLineWithY:383];
#pragma mark = 四个图
     NSArray *butonArr = @[@"pinggu_icon_long",@"pinggu_icon_height",@"pinggu_icon_bmi",@"pinggu_icon_fayu",@"pinggu_icon_long_set",@"pinggu_icon_height_set",@"pinggu_icon_bmi_set",@"pinggu_icon_fayu_set"];
    UIButton *lastBtn = nil;
    for (int i=0; i<4; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setBackgroundImage:[UIImage imageNamed:butonArr[i]] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:butonArr[4+i]] forState:UIControlStateSelected];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = 1180+i;
        [self.view addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.view).offset(-70*Ratio);
            make.size.mas_equalTo(CGSizeMake(75*Ratio, 57*Ratio));
            if (lastBtn) {
                make.left.equalTo(lastBtn.mas_right).offset(5*Ratio);
            }else{
                make.left.equalTo(self.view).offset(3*Ratio);
            }
        }];
        
        lastBtn = button;
    }
}

#pragma mark -- 跳月

-(void)jumpMonth:(UIButton *)button{
    if (_currentOnline) {
        
        if (button.tag == 1290) {
            
            _currentRow++;
            [self reloadSelfView:_currentRow];
            
        }else{
            
            _currentRow--;
            [self reloadSelfView:_currentRow];
        }
        UIButton *butn = (UIButton *)[contentView viewWithTag:1290];
        UIButton *butn1 = (UIButton *)[contentView viewWithTag:1291];
        if (_currentRow == _onlineAppraisalArr.count-1) {
            butn.hidden = YES;
        }else{
            butn.hidden = NO;
        }
        if (_currentRow == 0) {
            butn1.hidden = YES;
        }else{
            butn1.hidden = NO;
        }
        
    }
    
    
//    _currentOnline = _onlineAppraisalArr[row];
//    if (_currentOnline) {
    
}


#pragma mark - 购买

-(void)buyAction:(UIButton *)button{
    
    BuyViewController *buyVC = [[BuyViewController alloc] init];
    
    [self.navigationController pushViewController:buyVC animated:YES];
    
}

#pragma mark - 月龄选择

-(void)monthSelected:(UIButton *)button{
    if ([_userRole intValue] == 0) {
        
    }else{
        if (_onlineAppraisalArr) {
            if (_onlineAppraisalArr.count > 0) {
                pickerBgView.hidden = NO;
                
                [self.view bringSubviewToFront:pickerBgView];
                
            }
        }
    }
    
}
#pragma mark - 成长发育图

-(void)buttonClick:(UIButton *)button{
    int numb = (int)button.tag - 1180;
//    NSLog(@"第%d个btn 被点击",numb);
    for (int i=0; i<4; i++) {
        UIButton *butt = (UIButton *)[self.view viewWithTag:1180+i];
        butt.selected = NO;
    }
    button.selected = YES;
    
    PictureViewController *pvc = [[PictureViewController alloc] initWithMonth:_month andSex:[user.sex boolValue]];
    pvc.number = numb + 1;
    pvc.imgDataArr = online.result.imgdata;
    NSArray *currentArr =[_currentOnline.feature componentsSeparatedByString:@","];
    NSMutableArray *currentMutableArr = [NSMutableArray arrayWithArray:currentArr];
    [currentMutableArr removeObject:@""];
    pvc.currentMonthFeatureArr = currentMutableArr;
    
    [self.navigationController pushViewController:pvc animated:YES];
    
}
#pragma mark - 选择器相关

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return pickerDataArr.count;
}
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 40;
}
-(CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    return 320*Ratio;
    
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    NSLog(@"%@",pickerDataArr[row]);
    
    
}


- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    return  pickerDataArr[row];
    
}

-(void)pickerViewClick:(UITapGestureRecognizer *)tap{
    
    if ([_userRole intValue] == 0) {
        
    }else{
        if (tap.view.hidden == NO) {
            
            tap.view.hidden = YES;
            
            [self reloadSelfView:[picker selectedRowInComponent:0]];
        }
    }
    
}
-(void)cyReloadSelfView{
    
    NSDictionary *userDic = [[NSUserDefaults standardUserDefaults] objectForKey:@"user"];
//    NSLog(@"userDic = %@",userDic);
    user = [[LoginUser alloc] initWithDictionary:userDic];
    
    fileNum.text = [NSString stringWithFormat:@"档案编号：%@",(!user.filecode)?@"无":user.filecode];
    birth.text = [NSString stringWithFormat:@"生日：%@",user.birthday];
    [month setTitle:[NSString stringWithFormat:@"%@个月",(_currentOnline.appraisalage)?(_currentOnline.appraisalage):[NSString stringWithFormat:@"%d",_month]] forState:UIControlStateNormal];

    name.text = user.truename;
    sexImg.image = [UIImage imageNamed:[NSString stringWithFormat:@"shouye_icon_red_%@",user.sex]];
    int temp = _currentOnline.feedingType;
    NSString *feedingTypeStr = nil;
    if (temp == 1) {
        feedingTypeStr = @"母乳喂养";
    }else if (temp == 2){
        feedingTypeStr = @"配方奶喂养";
    }else if (temp == 3){
        feedingTypeStr = @"混合喂养";
    }else{
        feedingTypeStr = @"";
    }
    feedStyle.text = feedingTypeStr;
    for (id view in starView.subviews) {
        if ([view isKindOfClass:[UIImageView class]]) {
            [view removeFromSuperview];
        }
    }
    [starView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(15*[_currentOnline.star intValue]*Ratio);
        
    }];
    UIImageView *lastStar = nil;
    for (int i=0; i<[_currentOnline.star intValue]; i++) {
        UIImageView *star = [[UIImageView alloc] init];
        star.image = [UIImage imageNamed:@"star"];
        [starView addSubview:star];
        [star mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(15*Ratio, 15*Ratio));
            make.centerY.equalTo(starView);
            if (lastStar) {
                make.left.equalTo(lastStar.mas_right);
            }else{
                make.left.equalTo(starView);
            }
        }];
        lastStar = star;
    }

    
    
    
    ServerConfigDoctorList *doctor = [[ServerConfigDoctorList alloc] initWithDictionary:[_localDoctorDic objectForKey:_currentOnline.doctorid]];
    
    [doctorHeader sd_setImageWithURL:[NSURL URLWithString:[NSString urlStringOfImage:doctor.head]] placeholderImage:[UIImage imageNamed:@"chouti_01"]];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:6];

    commentDetail.text = ([[_currentOnline.growthappraisal stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length] == 0)?@"敬请期待":([_currentOnline.growthappraisal stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]);
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:commentDetail.text];;
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, commentDetail.text.length)];
    commentDetail.attributedText = attributedString;
    CGSize size = [commentDetail sizeThatFits:CGSizeMake(234*Ratio, 200000)];
    [commentDetail mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(size.height);
    }];
    
    commentDetail1.text = ([[_currentOnline.mindappraisal stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length] == 0)?@"敬请期待":([_currentOnline.mindappraisal stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]);
    
    NSMutableAttributedString *attributedString1 = [[NSMutableAttributedString alloc]initWithString:commentDetail1.text];;
    [attributedString1 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, commentDetail1.text.length)];
    commentDetail1.attributedText = attributedString1;
    CGSize size1 = [commentDetail1 sizeThatFits:CGSizeMake(234*Ratio, 200000)];
    [commentDetail1 mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(size1.height);
    }];

    
}
-(void)reloadSelfView:(NSInteger)row{
     _currentOnline = _onlineAppraisalArr[row];
    if (_currentOnline) {
        [month setTitle:[NSString stringWithFormat:@"%@个月",_currentOnline.appraisalage] forState:UIControlStateNormal];
        _currentRow = row;
        
        UIButton *butn = (UIButton *)[contentView viewWithTag:1290];
        UIButton *butn1 = (UIButton *)[contentView viewWithTag:1291];
        if (row == _onlineAppraisalArr.count-1) {
            butn.hidden = YES;
        }else{
            butn.hidden = NO;
        }
        if (row == 0) {
            butn1.hidden = YES;
        }else{
            butn1.hidden = NO;
        }
        for (id view in starView.subviews) {
            if ([view isKindOfClass:[UIImageView class]]) {
                [view removeFromSuperview];
            }
        }
        [starView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(15*[_currentOnline.star intValue]*Ratio);
            
        }];
        UIImageView *lastStar = nil;
        for (int i=0; i<[_currentOnline.star intValue]; i++) {
            UIImageView *star = [[UIImageView alloc] init];
            star.image = [UIImage imageNamed:@"star"];
            [starView addSubview:star];
            [star mas_makeConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(CGSizeMake(15*Ratio, 15*Ratio));
                make.centerY.equalTo(starView);
                if (lastStar) {
                    make.left.equalTo(lastStar.mas_right);
                }else{
                    make.left.equalTo(starView);
                }
            }];
            lastStar = star;
        }
        
        
        
        int temp = _currentOnline.feedingType;
        NSString *feedingTypeStr = nil;
        if (temp == 1) {
            feedingTypeStr = @"母乳喂养";
        }else if (temp == 2){
            feedingTypeStr = @"配方奶喂养";
        }else if (temp == 3){
            feedingTypeStr = @"混合喂养";
        }else{
            feedingTypeStr = @"";
        }
        feedStyle.text = feedingTypeStr;
        
        
        ServerConfigDoctorList *doctor = [[ServerConfigDoctorList alloc] initWithDictionary:[_localDoctorDic objectForKey:_currentOnline.doctorid]];
        ServerConfigHospitalList *hospital = [[ServerConfigHospitalList alloc] initWithDictionary:[[[NSUserDefaults standardUserDefaults] objectForKey:@"hospitalDic"] objectForKey:doctor.hospitalid]];
        
        [doctorHeader sd_setImageWithURL:[NSURL URLWithString:[NSString urlStringOfImage:doctor.head]] placeholderImage:[UIImage imageNamed:@"chouti_01"]];
        doctorName.text = doctor.doctorname;
        doctorPositionaltitles.text = doctor.positionaltitles;
        hospitalName.text = hospital.hospitalname;

        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setLineSpacing:6];
       
        commentDetail.text = [_currentOnline.growthappraisal stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
        
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:commentDetail.text];;
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, commentDetail.text.length)];
        commentDetail.attributedText = attributedString;
        CGSize size = [commentDetail sizeThatFits:CGSizeMake(234*Ratio, 200000)];
        [commentDetail mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(size.height + 15);
        }]; 
        
        
       
        commentDetail1.text = [_currentOnline.mindappraisal stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
        NSMutableAttributedString *attributedString1 = [[NSMutableAttributedString alloc]initWithString:commentDetail1.text];;
        [attributedString1 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, commentDetail1.text.length)];
        commentDetail1.attributedText = attributedString1;
        CGSize size1 = [commentDetail1 sizeThatFits:CGSizeMake(234*Ratio, 200000)];
        [commentDetail1 mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(size1.height + 15);
        }];
        
        

    }
    
    
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
