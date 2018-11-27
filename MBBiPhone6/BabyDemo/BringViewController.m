  //
//  BringViewController.m
//  BabyDemo
//
//  Created by 陈彦 on 16/2/26.
//  Copyright © 2016年 elsa. All rights reserved.
//

#import "BringViewController.h"
#import "LeftViewController.h"
#import "YYZDTableViewCell.h"
#import "NetRequestManage.h"
#import "SVProgressHUD.h"
#import "NurtureGuideDataModels.h"
#import "CYRecordAlertView.h"
#import "AppDelegate.h"

//  0新用户，1未提交，2已提交，3已发送给医生，4医生已反馈，5医生已阅读，6已跳过医生


@interface BringViewController ()<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>{
//    NSMutableArray *_buttonArr;
    UIView *contentView;
    UIScrollView *buttonSC;
    UITableView *_tableView;
    NSArray *_nurtureArr;
    NSArray *_currentTableArr;
    
    NSString *_userRole;
    
    UIView *neverNum;
    UIView *freeUserView;
    UILabel *PGtishi;
    BOOL _isSubmit;
    
    BOOL _isfirst;
    
    BOOL _haveSC;
}

@end

@implementation BringViewController

#pragma mark =  左边按钮
-(void)leftBtn{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageNamed:@"shouye_top_left"] forState:UIControlStateNormal];
    button.selected = NO;
    [button addTarget:self action:@selector(leftBtnBlock:) forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(0, 0, 16*Ratio, 16*Ratio);
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
}

-(void)showAlertView:(NSString *)str{
    UIView *ciew = [self.view.window viewWithTag:6666];
    ciew.hidden = NO;
    for (int i=0; i<[ciew.subviews count]; i++) {
        UIView *ve = ciew.subviews[i];
        [ve removeFromSuperview];
    }
    ciew.backgroundColor = [UIColor colorWithRed:12/255.0 green:12/255.0 blue:12/255.0 alpha:0.5];

    UIImageView *alert = [[UIImageView alloc] init];
    alert.image = [UIImage imageNamed:@"tanchuang_pingjia"];
 
    alert.userInteractionEnabled = YES;
    [ciew addSubview:alert];
    [alert mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(223*Ratio, 247*Ratio));
        make.center.equalTo(ciew);
    }];
    
 
    UIButton *cancel = [UIButton buttonWithType:UIButtonTypeCustom];
    
    cancel.imageView.contentMode = UIViewContentModeCenter;
    [cancel setImage:[UIImage imageNamed:@"cancel"] forState:UIControlStateNormal];

    [cancel addTarget:self action:@selector(cancelAction:) forControlEvents:UIControlEventTouchUpInside];
    [alert addSubview:cancel];
    [cancel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(46*Ratio, 46*Ratio));
        make.right.equalTo(alert);
        make.top.equalTo(alert).offset(35*Ratio);
        
    }];
    
    UILabel *titlLabel = [[UILabel alloc] init];
    [titlLabel makeLabelWithText:str andTextColor:MBColor(101, 102, 103, 1) andFont:[UIFont yaHeiFontOfSize:14*Ratio]];
    titlLabel.textAlignment = NSTextAlignmentCenter;
    titlLabel.numberOfLines = 0;
    [alert addSubview:titlLabel];
    CGSize size = [titlLabel sizeThatFits:CGSizeMake(256*Ratio, 11111*Ratio)];
    [titlLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(alert).offset(127*Ratio);
        make.left.equalTo(alert).offset(21*Ratio);
        make.right.equalTo(alert).offset(-21*Ratio);
        make.height.equalTo(@(size.height));
    }];
    
    
    
    
   
    UIButton *continueBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    //    continueBtn.backgroundColor = MBColor(238, 66, 153, 1);
    
//    continueBtn.layer.shadowColor = MBColor(238, 66, 153, 1).CGColor;
//    continueBtn.layer.shadowOffset = CGSizeMake(0, 5);
//    continueBtn.layer.shadowOpacity = 0.3;
   
    [continueBtn setBackgroundImage:[UIImage imageNamed:@"qupinjia"] forState:UIControlStateNormal];
    [continueBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [continueBtn setTitle:@"去评价" forState:UIControlStateNormal];
    
    [continueBtn addTarget:self action:@selector(versionAction:) forControlEvents:UIControlEventTouchUpInside];
    continueBtn.titleLabel.font = [UIFont yaHeiFontOfSize:12*Ratio];
    [alert addSubview:continueBtn];
    [continueBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(80*Ratio, 25*Ratio));
        make.right.equalTo(alert).offset(-22*Ratio);
        make.bottom.equalTo(alert).offset(-15*Ratio);
        
    }];
    
    
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [cancelBtn setBackgroundImage:[UIImage imageNamed:@"qutucao"] forState:UIControlStateNormal];
    [cancelBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [cancelBtn setTitle:@"稍后提醒" forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(cancelAction:) forControlEvents:UIControlEventTouchUpInside];
    cancelBtn.titleLabel.font = [UIFont yaHeiFontOfSize:12*Ratio];
    [alert addSubview:cancelBtn];
    [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(80*Ratio, 25*Ratio));
        make.left.equalTo(alert).offset(22*Ratio);
        make.bottom.equalTo(alert).offset(-15*Ratio);
        
    }];
    
    
    
    [self.view.window bringSubviewToFront:ciew];
    
    
}
-(void)cancelAction:(UIButton *)button{
    
    UIView *ciew = [self.view.window viewWithTag:6666];
    ciew.hidden = YES;
    ciew.backgroundColor = [UIColor colorWithRed:120/255.0 green:120/255.0 blue:120/255.0 alpha:0.3];
    
    for (int i=0; i<[ciew.subviews count]; i++) {
        UIView *ve = ciew.subviews[i];
        [ve removeFromSuperview];
    }
    
    [self.view.window sendSubviewToBack:ciew];
    
    
}
-(void)versionAction:(UIButton *)button{
    
    
    
     UIView *ciew = [self.view.window viewWithTag:6666];
     ciew.hidden = NO;
     ciew.backgroundColor = [UIColor colorWithRed:120/255.0 green:120/255.0 blue:120/255.0 alpha:0.3];
     
     for (int i=0; i<[ciew.subviews count]; i++) {
     UIView *ve = ciew.subviews[i];
     [ve removeFromSuperview];
     }
     [self.view.window sendSubviewToBack:ciew];
     
    
    [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"commentted"];
    
    //    https://itunes.apple.com/us/app/meng-bao-bao-bao-bao-sheng/id1141279090?l=zh&ls=1&mt=8
    //  评论入口
    //  itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=%d
    NSString *updateUrlString = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=1141279090"];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:updateUrlString]];
    
}


#pragma mark - 侧边栏

-(void)leftBtnBlock:(UIButton *)button{
    
    
    RickyNavViewController *nav = (RickyNavViewController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    
    LeftViewController *left = (LeftViewController *)[nav.viewControllers objectAtIndex:0];

    [left ChangeSlideStatus];
}

-(void)viewWillAppear:(BOOL)animated{
    if (_isfirst == NO) {
        _userRole = [[NSUserDefaults standardUserDefaults] objectForKey:@"userRole"];

        if ([_userRole intValue] != 0) {
            [NetRequestManage getNurtureGuideWithUserId:[[NSUserDefaults standardUserDefaults] objectForKey:@"userId"] successBlocks:^(NSData *data, NetRequestManage *nurtureGuide) {
                
                
                
                NSString *str = [[NSString alloc] initWithData:nurtureGuide.resultData encoding:NSUTF8StringEncoding];
                NSLog(@"getnurtureGuide = %@",str);
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:nurtureGuide.resultData options:NSJSONReadingMutableContainers error:nil];
                NurtureGuideObject *nurture = [[NurtureGuideObject alloc] initWithDictionary:dic];
                if (nurture.errorId == 0) {
                    _nurtureArr = nurture.result.nurtureGuideList;
                    if (_nurtureArr) {
                        if (_nurtureArr.count > 0) {
                            NurtureGuideNurtureGuideList *list = _nurtureArr[0];
                            _currentTableArr = list.detaillist;
                            
                        }
                    }
                    
                    
                    
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
                if ([_userRole intValue] != 0) {//付费用户
                    if (_nurtureArr.count != 0) {//付费用户有养育指导
                        neverNum.hidden = YES;
                        if (_haveSC == NO) {
                            [self createInterface];
                            [_tableView reloadData];
                        }
                        
                        
                    }else{
                        _isSubmit = YES;
                        if ([nurture.result.firstRecordStatus intValue] < 2) {
                            _isSubmit = NO;
                            
                        }else if (([nurture.result.firstRecordStatus intValue] > 1)&&([nurture.result.firstRecordStatus intValue] < 4)){
                            _isSubmit = YES;
                            
                        }
                        PGtishi.text = (_isSubmit == YES)?@"医生将在一周后提供养育指导，请耐心等待":@"您需要先提交记录，医生才能为萌宝提供个性化专业养育指导";
                        
                        neverNum.hidden = NO;
                        //                    [self.view layoutSubviews];
                        //                    [self.view reloadInputViews];
                    }
                    
                }else{
                    [self.view bringSubviewToFront:freeUserView];
                    freeUserView.hidden = NO;
                }
                
                
                
            } andFailedBlocks:^(NSError *error, NetRequestManage *nurtureGuide) {
                
                NSLog(@"nurtureGuideError = %@",error.localizedDescription);
                
            }];
            

        }else{
            
            
        }
    }
    
    _isfirst = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self leftBtn];
    self.view.backgroundColor = [UIColor whiteColor];
    _nurtureArr = [[NSArray alloc] init];
    _currentTableArr = [[NSArray alloc] init];
    _isfirst = YES;
    _userRole = [[NSUserDefaults standardUserDefaults] objectForKey:@"userRole"];
    _haveSC = NO;
    [self createFreeUserView];
    
    if ([_userRole intValue] != 0) {
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
        [SVProgressHUD show];
        [NetRequestManage getNurtureGuideWithUserId:[[NSUserDefaults standardUserDefaults] objectForKey:@"userId"] successBlocks:^(NSData *data, NetRequestManage *nurtureGuide) {
            NSString *str = [[NSString alloc] initWithData:nurtureGuide.resultData encoding:NSUTF8StringEncoding];
            NSLog(@"getnurtureGuide = %@",str);
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:nurtureGuide.resultData options:NSJSONReadingMutableContainers error:nil];
            NurtureGuideObject *nurture = [[NurtureGuideObject alloc] initWithDictionary:dic];
            if (nurture.errorId == 0) {
                _nurtureArr = nurture.result.nurtureGuideList;
                if (_nurtureArr) {
                    if (_nurtureArr.count > 0 ) {
                        
                        NurtureGuideNurtureGuideList *list = _nurtureArr[0];
                        _currentTableArr = list.detaillist;
                        
                    }
                }
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
            if ([_userRole intValue] != 0) {//付费用户
                if (_nurtureArr.count != 0) {//付费用户有养育指导
                    
                    
                    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"commentted"]&&([[[NSUserDefaults standardUserDefaults] objectForKey:@"commentted"] intValue] == 1)) {
                        NSLog(@"已评论");
                    }else{
                        if ([[dic objectForKey:@"result"] objectForKey:@"OnlineAppraisalTime"]&&(![[[dic objectForKey:@"result"] objectForKey:@"OnlineAppraisalTime"] isKindOfClass:[NSNull class]])) {
                            NSString *madan  = [[dic objectForKey:@"result"] objectForKey:@"OnlineAppraisalTime"];
                            NSDateFormatter *format = [[NSDateFormatter alloc] init];
                            [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
                            NSDate *appraisalDate = [format dateFromString:madan];
                            NSDate *nowDate = [NSDate date];
                            
                            NSCalendar *calendar = [NSCalendar currentCalendar];
                            NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
                            [dateComponents setDay:15];
                            NSDate *appraisalLimitDate = [calendar dateByAddingComponents:dateComponents toDate:appraisalDate options:0];
                            
                            if ([nowDate earlierDate:appraisalLimitDate] == nowDate&&[nowDate laterDate:appraisalDate] == nowDate) {//需要记录的时间范围
                                NSLog(@"日期内");
                                
                                if ([[NSUserDefaults standardUserDefaults] objectForKey:@"numOfseeNurture"]) {
                                    
                                    NSArray *ar = [[NSUserDefaults standardUserDefaults] objectForKey:@"numOfseeNurture"];
                                    NSMutableArray *seeNurtureMuArr = [ar mutableCopy];
                                    if (seeNurtureMuArr.count >= 2) {//第三次
                                        NSLog(@"第三次了哦哦");
                                        [self showAlertView:@"程序MM日夜苦干~\r\n  新版又来了~\r\n  求鼓励~求支持!"];

                                        [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"numOfseeNurture"];
                                        
                                    }else{
                                        NSDate *lastSeeNurtureDate = [seeNurtureMuArr lastObject];
                                        if ([lastSeeNurtureDate earlierDate:appraisalDate] == lastSeeNurtureDate) {//过期数据清空重建
                                            [seeNurtureMuArr removeAllObjects];
                                            [seeNurtureMuArr addObject:nowDate];
                                            NSArray *arr = [seeNurtureMuArr copy];
                                            [[NSUserDefaults standardUserDefaults] setObject:arr forKey:@"numOfseeNurture"];
                                        }else{//符合条件添加时间
                                            [seeNurtureMuArr addObject:nowDate];
                                            NSArray *arr = [seeNurtureMuArr copy];
                                            [[NSUserDefaults standardUserDefaults] setObject:arr forKey:@"numOfseeNurture"];
                                            
                                        }
                                    }
                                    
                                }else{//如果没有就新加一个
                                    
                                    NSMutableArray *seeNurtureMuArr = [[NSMutableArray alloc] init];
                                    [seeNurtureMuArr addObject:nowDate];
                                    NSArray *ar = [seeNurtureMuArr copy];
                                    [[NSUserDefaults standardUserDefaults] setObject:ar forKey:@"numOfseeNurture"];
                                    
                                }
                                
                            }
                            
                        }

                    }
                    
                    
                    [self createInterface];
                    
                }else{
                    
                    _isSubmit = YES;
                    
                    if ([nurture.result.firstRecordStatus intValue] < 2) {
                        _isSubmit = NO;
                        
                    }else if (([nurture.result.firstRecordStatus intValue] > 1)&&([nurture.result.firstRecordStatus intValue] < 4)){
                        
                        _isSubmit = YES;
                        
                    }
                    
                    [self createfirst];
                }
                
            }else{
                [self.view bringSubviewToFront:freeUserView];
                freeUserView.hidden = NO;
            }
            
            
            [SVProgressHUD dismiss];
            
        } andFailedBlocks:^(NSError *error, NetRequestManage *nurtureGuide) {
            
            [SVProgressHUD showErrorWithStatus:error.localizedDescription];
            
        }];

    }else{
        [self.view bringSubviewToFront:freeUserView];
        freeUserView.hidden = NO;
    }
    
    
    
    
    
    
    

    // Do any additional setup after loading the view.
}

-(void)createFreeUserView{
    
    freeUserView = [[UIView alloc] init];
    freeUserView.backgroundColor = [UIColor whiteColor];
    freeUserView.hidden = YES;
    [self.view addSubview:freeUserView];
    [freeUserView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self.view);
        make.top.equalTo(self.view);
        make.height.mas_equalTo(568*Ratio);
    }];
    UIImageView *tempDoctor = [[UIImageView alloc] init];
    tempDoctor.image = [UIImage imageNamed:@"pinggu_kong"];
    [freeUserView addSubview:tempDoctor];
    [tempDoctor mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100*Ratio, 100*Ratio));
        make.centerX.equalTo(freeUserView);
        make.top.equalTo(freeUserView).offset(150*Ratio);
    }];
    PGtishi = [[UILabel alloc] init];
    //    PGtishi.backgroundColor = [UIColor redColor];
    [PGtishi makeLabelWithText:@"儿保专家会根据萌宝的发育状况给予 “喂养、睡眠、发育行为、游戏、社交与情绪、语言”六个方面的养育指导，本项服务只有会员能享用。" andTextColor:MBColor(102, 103, 104, 1) andFont:[UIFont yaHeiFontOfSize:14*Ratio]];
    PGtishi.numberOfLines = 0;
    PGtishi.textAlignment = NSTextAlignmentCenter;
    [freeUserView addSubview:PGtishi];
    [PGtishi mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(freeUserView);
        make.top.equalTo(tempDoctor.mas_bottom).offset(14*Ratio);
        make.size.mas_equalTo(CGSizeMake(240*Ratio, 100*Ratio));
    }];

    
}
-(void)createfirst{
    neverNum = [[UIView alloc] init];
    neverNum.backgroundColor = [UIColor whiteColor];
    neverNum.hidden = NO;
    [self.view addSubview:neverNum];
    [neverNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.left.equalTo(self.view);
        make.width.mas_equalTo(320*Ratio);
        make.bottom.equalTo(self.view);
    }];
    
    UIImageView *tempDoctor = [[UIImageView alloc] init];
    tempDoctor.image = [UIImage imageNamed:@"pinggu_kong"];
    [neverNum addSubview:tempDoctor];
    [tempDoctor mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100*Ratio, 100*Ratio));
        make.centerX.equalTo(neverNum);
        make.top.equalTo(neverNum).offset(150*Ratio);
    }];
    PGtishi = [[UILabel alloc] init];
//    PGtishi.backgroundColor = [UIColor redColor];
    [PGtishi makeLabelWithText:(_isSubmit == YES)?@"医生将在一周后提供养育指导，请耐心等待":@"您需要先提交记录，医生才能为萌宝提供个性化专业养育指导" andTextColor:MBColor(102, 103, 104, 1) andFont:[UIFont yaHeiFontOfSize:14*Ratio]];
    PGtishi.numberOfLines = 0;
    PGtishi.textAlignment = NSTextAlignmentCenter;
    [neverNum addSubview:PGtishi];
    [PGtishi mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(neverNum);
        make.top.equalTo(tempDoctor.mas_bottom).offset(14*Ratio);
        make.size.mas_equalTo(CGSizeMake(200*Ratio, 40*Ratio));
    }];

}
-(void)createInterface{
    
    if (_nurtureArr.count > 0) {
        _haveSC = YES;
        if ([self respondsToSelector:@selector(automaticallyAdjustsScrollViewInsets)]) {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        buttonSC = [[UIScrollView alloc] init];
        buttonSC.backgroundColor = MBColor(239, 240, 241, 1);
        buttonSC.bounces = NO;
        buttonSC.delegate = self;
        buttonSC.showsHorizontalScrollIndicator = NO;
        [self.view addSubview:buttonSC];
        
        [buttonSC mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.and.right.equalTo(self.view);
            make.top.equalTo(self.view);
            make.height.mas_equalTo(@(29*Ratio));
        }];
        
        
        contentView = [[UIView alloc] init];
        contentView.backgroundColor = MBColor(239, 240, 241, 1);
        
        [buttonSC addSubview:contentView];
        
        [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(buttonSC);
            make.height.equalTo(buttonSC);
        }];
        
        
      
        
        
        UIButton *lastBtn;
        CGFloat firstWidth = 0.0;
        
        for (int i=0; i<[_nurtureArr count]; i++) {
            NurtureGuideNurtureGuideList *nurtureList = (NurtureGuideNurtureGuideList *)[_nurtureArr objectAtIndex:i];
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.titleLabel.font = [UIFont yaHeiFontOfSize:15*Ratio];
            [button setTitle:nurtureList.nurturename forState:UIControlStateNormal];
            button.tag = 1003+i;
            [button setTitleColor:MBColor(102,102, 102, 1) forState:UIControlStateNormal];
            [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
            button.selected = NO;
            CGSize size = [button.titleLabel sizeThatFits:CGSizeMake(300, 29)];
            button.titleLabel.font = [UIFont yaHeiFontOfSize:13*Ratio];
            [contentView addSubview:button];
            
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.and.bottom.equalTo(contentView);
                make.width.equalTo(@(size.width));
                if (lastBtn == nil) {
                    
                    make.left.equalTo(contentView).offset(20*Ratio);
                    button.selected = YES;
                    button.titleLabel.font = [UIFont yaHeiFontOfSize:15*Ratio];
                    
                }else{
                    make.left.equalTo(lastBtn.mas_right).offset(20*Ratio);
                }
            }];
            if (i==0) {
                
                firstWidth = size.width;
            }
            
            
            lastBtn = button;
            
        }
        
        UILabel *label = [[UILabel alloc] init];
        label.backgroundColor = [UIColor colorWithRed:239/255.0 green:67/255.0 blue:153/255.0 alpha:1];
        label.tag = 1100;
        [contentView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@(2*Ratio));
            make.width.equalTo(@(firstWidth));
            make.left.equalTo(contentView).offset(20*Ratio);
            make.bottom.equalTo(contentView);
        }];
        
        
        [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(lastBtn).offset(20*Ratio);
        }];
        
        /*
        //  创建需要的毛玻璃特效类型
        
        UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
        
        //  毛玻璃view 视图
        
        UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
        effectView.backgroundColor = [UIColor whiteColor];
        //添加到要有毛玻璃特效的控件中
        
        
        [self.view addSubview:effectView];
        
        //设置模糊透明度
        
        effectView.alpha = .5f;
        [effectView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.view);
            make.top.equalTo(buttonSC);
            make.bottom.equalTo(buttonSC);
            make.width.equalTo(@(15*Ratio));
        }];
        
        */
        
        
        
        
        
        UIView *eeffectView = [[UIView alloc] init];
        eeffectView.backgroundColor = MBColor(239, 240, 241, 1);
        eeffectView.userInteractionEnabled = YES;
        eeffectView.layer.shadowColor = MBColor(239, 240, 241, 1).CGColor;
        eeffectView.layer.shadowOffset = CGSizeMake(12, 0);
        eeffectView.layer.shadowOpacity = 0.8;
        [self.view addSubview:eeffectView];
        [eeffectView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@(20));
            make.left.equalTo(self.view).offset(-15);
            make.top.equalTo(self.view);
            make.height.equalTo(buttonSC);
        }];
        UIView *eeffectView1 = [[UIView alloc] init];
        eeffectView1.backgroundColor = MBColor(239, 240, 241, 1);
        eeffectView1.userInteractionEnabled = YES;
        eeffectView1.layer.shadowColor = MBColor(239, 240, 241, 1).CGColor;
        eeffectView1.layer.shadowOffset = CGSizeMake(-15, 0);
        eeffectView1.layer.shadowOpacity = 0.8;
        [self.view addSubview:eeffectView1];
        [eeffectView1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@(20));
            make.right.equalTo(self.view).offset(15);
            make.top.equalTo(self.view);
            make.height.equalTo(buttonSC);
        }];
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, 320) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[YYZDTableViewCell class] forCellReuseIdentifier:@"identifer"];
        [self.view addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.equalTo(buttonSC.mas_bottom);
            make.width.equalTo(self.view);
            make.bottom.equalTo(self.view).offset(-49);
            
        }];
        

        
    }
    
}


-(void)buttonClick:(UIButton *)button{
    if (button.selected == NO) {

        for (int i=0; i<_nurtureArr.count; i++) {
            UIButton *button = (UIButton *)[contentView viewWithTag:1003+i];
            button.selected = NO;
            button.titleLabel.font = [UIFont yaHeiFontOfSize:13*Ratio];

        }
        
        button.selected = YES;
        button.titleLabel.font = [UIFont yaHeiFontOfSize:15*Ratio];
        float xOf = button.frame.origin.x-buttonSC.contentOffset.x ;
        if (xOf >= 0&&xOf <= 320) {
            
        }else if (xOf < 0){
            
            [UIView animateWithDuration:0.2 animations:^{
                buttonSC.contentOffset = CGPointMake(buttonSC.contentOffset.x - button.frame.size.width, 0);
            }];
        }else if (xOf > 320) {
            
            [UIView animateWithDuration:0.2 animations:^{
                buttonSC.contentOffset = CGPointMake(buttonSC.contentOffset.x + button.frame.size.width, 0);
            }];
            
        }
        
        CGFloat left = button.frame.origin.x;
        CGFloat width = button.frame.size.width;
        //改变label的frame
        [UIView animateWithDuration:0.2 animations:^{
            //        tmpLabel.center = CGPointMake(btn.center.x, btn.center.y + 20);
            
            UILabel *tmpLabel = (UILabel *)[contentView viewWithTag:1100];
            [tmpLabel mas_updateConstraints:^(MASConstraintMaker *make) {
                
                make.height.equalTo(@(2*Ratio));
                make.width.equalTo(@(width));

                make.left.equalTo(contentView).offset(left);
                make.bottom.equalTo(contentView);
            }];
            [contentView layoutIfNeeded];
        }];
        NurtureGuideNurtureGuideList *list = _nurtureArr[button.tag - 1003];
        _currentTableArr = list.detaillist;
        [_tableView reloadData];
        [self.view layoutIfNeeded];
    }
    
    
}

#pragma mark - tableView代理相关
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NurtureGuideDetaillist *detail = _currentTableArr[indexPath.row];

//  方法一
//    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:detail.appraisalcontent];
//
//    UILabel *test = [UILabel new];
//    test.text = detail.appraisalcontent;
//    test.font = [UIFont yaHeiFontOfSize:13*Ratio];
//    test.numberOfLines = 0;
//    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, detail.appraisalcontent.length)];
//    test.attributedText = attributedString;
//    
//    CGSize size = [test sizeThatFits:CGSizeMake(290, 200000)];
//  方法二
    NSMutableDictionary *attri = [[NSMutableDictionary alloc] init];
    attri[NSFontAttributeName] = [UIFont yaHeiFontOfSize:13*Ratio];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    [paragraphStyle setLineSpacing:6];
    attri[NSParagraphStyleAttributeName] = paragraphStyle;
    CGSize size = [detail.appraisalcontent boundingRectWithSize:CGSizeMake(290, 200000) options:NSStringDrawingUsesLineFragmentOrigin attributes:attri context:nil].size;
    
    CGFloat imgHeight = 0.0;
    if (detail.imgurl.length>0) {
        imgHeight = 141;
    }
    return 50*Ratio + size.height + imgHeight ;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _currentTableArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *str = @"identifer";
    YYZDTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[YYZDTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:str];
    }
    NurtureGuideDetaillist *detail = _currentTableArr[indexPath.row];
    [cell makeCellWithTitle:detail.appraisaltitle andDetailTitle:detail.appraisalcontent andImageURL:(detail.imgurl.length>0)?[NSURL URLWithString:[NSString urlStringOfImage:detail.imgurl]]:nil];
    return cell;
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
