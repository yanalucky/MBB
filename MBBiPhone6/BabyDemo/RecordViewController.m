//
//  RecordViewController.m
//  BabyDemo
//
//  Created by 陈彦 on 16/2/26.
//  Copyright © 2016年 elsa. All rights reserved.
//



#import "RecordViewController.h"
#import "RecordMainViewTableViewCell.h"
#import "NewRecordViewController.h"
#import "AddOtherViewController.h"
#import "NetRequestManage.h"
#import "RecordStarDataModels.h"
#import "SVProgressHUD.h"
#import "UIImageView+WebCache.h"
#import "LoginUser.h"
#import "BuyViewController.h"

#import "AppDelegate.h"

#import "CYRecordAlertView.h"




@interface RecordViewController ()<UITableViewDelegate,UITableViewDataSource>{
    UITableView *_tableView;
    UIView *addView;
    RecordStarObject *_recordStar;
    NSMutableArray *_recordArr;
    LoginUser *user;
    
    NSString *_userRole;
    
    
    NSString *_firstAgeStr;
    NSArray *_babyBeforeRecordArr;
    
    NSString *_theRecordStr;
    
    UIImageView *header;
    
    
    NSString *_showTimeStr;
    NSString *_recordStatusStr;
    int _timeStatus;
    
    
    
    UIButton *addBtn1;
    
    NSDictionary *_newRecordDic;
}
@end

@implementation RecordViewController

-(void)viewWillAppear:(BOOL)animated{
    
    addView.hidden = YES;
    //是否能否补足记录
//    if ([[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%@_%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"userId"],@"canAdd"]]) {
//        if ([[[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%@_%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"userId"],@"canAdd"]] intValue] == 1) {
//            addBtn1.hidden = NO;
//        }
//    }
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
    

//    UIEdgeInsets inset = UIEdgeInsetsMake(-20, 0, 20, 0);
//    
//    yindao.image = [[UIImage imageNamed:@"jilu_0"] resizableImageWithCapInsets:inset resizingMode:UIImageResizingModeStretch];
    yindao.image = [UIImage imageNamed:([UIScreen mainScreen].bounds.size.width == 375)?@"jilu_0_i6":@"jilu_0"];
    yindao.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeView)];
    [yindao addGestureRecognizer:tap];
    
    [ciew addSubview:yindao];
    

    [yindao mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(ciew);
        make.top.equalTo(ciew);
        make.right.equalTo(ciew);
    }];
    [[NSUserDefaults standardUserDefaults] setObject:@"YES" forKey:@"manyOfRecordStar"];
    [self.view.window bringSubviewToFront:ciew];
    
    
}
-(void)removeView{
    
    UIView *ciew = [self.view.window viewWithTag:6666];
    ciew.hidden = YES;
    ciew.backgroundColor = [UIColor colorWithRed:120/255.0 green:120/255.0 blue:120/255.0 alpha:0.3];
    for (int i=0; i<[ciew.subviews count]; i++) {
        UIView *ve = ciew.subviews[i];
        [ve removeFromSuperview];
    }
    [self.view.window sendSubviewToBack:ciew];
    
}
-(void)viewDidAppear:(BOOL)animated{
   
    
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"manyOfRecordStar"]) {
    
        [self performSelector:@selector(showAlertView) withObject:nil afterDelay:0.1];
        
        
    }
    [NetRequestManage getRecordStarWithUserId:[[NSUserDefaults standardUserDefaults] objectForKey:@"userId"] successBlocks:^(NSData *data, NetRequestManage *recordStar) {
        NSString *str = [[NSString alloc] initWithData:recordStar.resultData encoding:NSUTF8StringEncoding];
        NSLog(@"getRecordStar = %@",str);
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        if ([[dic objectForKey:@"errorId"] intValue] == 0) {
            
            _recordStar = [[RecordStarObject alloc] initWithDictionary:dic];
            _recordArr = [[NSMutableArray alloc] initWithArray:_recordStar.result.recordStar];
            _newRecordDic = [[dic objectForKey:@"result"] objectForKey:@"UserRecord"];
            addBtn1.hidden = ![[[dic objectForKey:@"result"] objectForKey:@"hasWeight"] boolValue];
            _firstAgeStr = _recordStar.result.firstRecordAge.age;
            _theRecordStr = _recordStar.result.userRecord.recordid;
            _babyBeforeRecordArr = _recordStar.result.babyBeforeRecord;
            _showTimeStr = _recordStar.result.showTime;
            _recordStatusStr = _recordStar.result.userRecord.recordstatus;
            _timeStatus = _recordStar.result.timeStatus;
            [_tableView reloadData];
            
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

        
        
        
        
    } andFailedBlocks:^(NSError *error, NetRequestManage *recordStar) {
        NSLog(@"recordstarError = %@",error.localizedDescription);

    }];
    
//    [[SDImageCache sharedImageCache] clearDisk];
    NSString *path = NSHomeDirectory();
    NSString *jpgImagePath = [path stringByAppendingPathComponent:@"Documents/header.jpg"];
    header.image = [[UIImage alloc] initWithContentsOfFile:jpgImagePath];
//    [header sd_setImageWithURL:[NSURL URLWithString:[NSString urlStringOfImage:user.headimg]]];
    [self.view reloadInputViews];

}
- (void)viewDidLoad {
    [super viewDidLoad];
     self.view.backgroundColor = [UIColor whiteColor];
    _userRole = [[NSUserDefaults standardUserDefaults] objectForKey:@"userRole"];
    [self leftBtn];
    [self createInterface];
    // Do any additional setup after loading the view.
}


-(void)createInterface{
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
//    [header sd_setImageWithURL:[NSURL URLWithString:[NSString urlStringOfImage:user.headimg]] placeholderImage:([user.sex intValue] == 0)?[UIImage imageNamed:@"shouye_girl"]:[UIImage imageNamed:@"shouye_boy"]];
    [headerView addSubview:header];
    [header mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(headerView);
        make.size.equalTo(headerView);
    }];
    NSLog(@"headimg = %@",[NSString urlStringOfImage:user.headimg]);
    self.navigationItem.titleView = headerView;
    
#pragma mark = 添加成长记录
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 16*Ratio, 16*Ratio);
    [rightBtn setBackgroundImage:[[UIImage imageNamed:@"jilu_add"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(showAddView:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    
    addView = [[UIView alloc] init];
    addView.backgroundColor = MBColor(152, 152, 152, 0.5);
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancelAddView)];
    addView.userInteractionEnabled = YES;
    [addView addGestureRecognizer:tapGesture];
    [self.view addSubview:addView];
    [addView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(self.view);
        make.center.equalTo(self.view);
    }];

    addView.hidden = YES;
    
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    addBtn.backgroundColor = [UIColor whiteColor];

    [addBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [addBtn addTarget:self action:@selector(addRecord:) forControlEvents:UIControlEventTouchUpInside];
    [addView addSubview:addBtn];
    [addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(addView);
        make.top.mas_equalTo(0);
        make.height.mas_equalTo(45*Ratio);
    }];
    
    UIImageView *addImg = [[UIImageView alloc] init];
    addImg.image = [UIImage imageNamed:@"jilu_xinzen"];
    [addBtn addSubview:addImg];
    [addImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(16*Ratio, 16*Ratio));
        make.centerY.equalTo(addBtn);
        make.left.equalTo(addBtn).offset(10*Ratio);
    }];
    UILabel *addTitle = [[UILabel alloc] init];
    [addTitle makeLabelWithText:@"添加新记录" andTextColor:MBColor(151, 152, 153, 1) andFont:[UIFont yaHeiFontOfSize:14*Ratio]];
    [addBtn addSubview:addTitle];
    [addTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(addImg);
        make.left.equalTo(addImg.mas_right).offset(5*Ratio);
        make.size.mas_equalTo(CGSizeMake(200*Ratio, 30*Ratio));
    }];
    
    
   
    
    addBtn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    addBtn1.backgroundColor = [UIColor whiteColor];
    [addBtn1 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [addBtn1 addTarget:self action:@selector(addOtherRecord:) forControlEvents:UIControlEventTouchUpInside];
    [addView addSubview:addBtn1];
    [addBtn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(addView);
        make.top.equalTo(addBtn.mas_bottom).offset(1*Ratio);
        make.height.mas_equalTo(45*Ratio);
    }];
    addBtn1.hidden = YES;
    if ([[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%@_%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"userId"],@"canAdd"]]) {
        if ([[[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%@_%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"userId"],@"canAdd"]] intValue] == 1) {
            addBtn1.hidden = NO;
        }
    }
    
    UIImageView *addImg1 = [[UIImageView alloc] init];
    addImg1.image = [UIImage imageNamed:@"jilu_buchong"];
    [addBtn1 addSubview:addImg1];
    [addImg1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(16*Ratio, 16*Ratio));
        make.centerY.equalTo(addBtn1);
        make.left.equalTo(addBtn1).offset(10*Ratio);
    }];
    UILabel *addTitle1 = [[UILabel alloc] init];
    [addTitle1 makeLabelWithText:@"补充体格生长记录" andTextColor:MBColor(151, 152, 153, 1) andFont:[UIFont yaHeiFontOfSize:14*Ratio]];
    [addBtn1 addSubview:addTitle1];
    [addTitle1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(addImg1);
        make.left.equalTo(addImg1.mas_right).offset(5*Ratio);
        make.size.mas_equalTo(CGSizeMake(200*Ratio, 30*Ratio));
    }];
    
    
    
    
#pragma mark = 成长记录
    
    if ([self respondsToSelector:@selector(automaticallyAdjustsScrollViewInsets)]) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320*Ratio, (768-49)*Ratio) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    UIImageView *recordBg = [[UIImageView alloc] init];
    recordBg.image = [UIImage imageNamed:@"jilu_background"];
    
    _tableView.backgroundView = recordBg;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tableView registerClass:[RecordMainViewTableViewCell class] forCellReuseIdentifier:@"ReuseIdentifier"];
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self.view);
        make.top.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-49);
    }];
    
#pragma mark = tableView 的  footView
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320*Ratio, 60*Ratio)];
    UIImageView *star = [[UIImageView alloc] init];
    star.image = [UIImage imageNamed:@"star"];
    [view addSubview:star];
    [star mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(15*Ratio, 15*Ratio));
        make.center.equalTo(view);
    }];
    UILabel *title = [[UILabel alloc] init];
    [title makeLabelWithText:@"萌宝生长发育全记录" andTextColor:MBColor(121,122,123,1) andFont:[UIFont yaHeiFontOfSize:14]];
    title.textAlignment = NSTextAlignmentCenter;
    [view addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(150*Ratio, 20*Ratio));
        make.top.mas_equalTo(star.mas_bottom).offset(5*Ratio);
        make.centerX.equalTo(view);
    }];
    _tableView.tableFooterView = view;
    
    
    
    
    
    
    [self.view bringSubviewToFront:addView];
    

}
#pragma mark - 添加记录

-(void)showAddView:(UIButton *)button{
    
    addView.hidden = !addView.hidden;
}
-(void)cancelAddView{
    addView.hidden = YES;
}


-(void)addOtherRecord:(UIButton *)button{
    AddOtherViewController *avc = [[AddOtherViewController alloc] init];
    avc.firstAge = _firstAgeStr;
    avc.babyBeforeRecord = _babyBeforeRecordArr;
    [self.navigationController pushViewController:avc animated:YES];
    
}
-(void)addRecord:(UIButton *)button{
    
    NSLog(@"%d",[[[NSUserDefaults standardUserDefaults] objectForKey:@"month"] intValue]);
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"month"] intValue] > 36) {
        
        
        CYRecordAlertView *alert = [self.view.window viewWithTag:9999];
        
        [alert alertViewWith:@"提示！" andDetailTitle:[NSString stringWithFormat:@"您的宝宝已超过我们的服务范围，感谢您的惠顾，如有疑问请联系客服"] andButtonTitle:@"0"];
        [alert layoutSubviews];
        
        alert.clickBlocks = ^(void){
            
        };
        return;
    }
    if ([_userRole intValue] == 0) {//免费用户
        if ([_recordStar.result.isSubmitRecord intValue] == 0) {
            NewRecordViewController *newRecord = [[NewRecordViewController alloc] init];
            newRecord.month = [[[NSUserDefaults standardUserDefaults] objectForKey:@"month"] intValue];
            newRecord.isHiddenSubmit = NO;
//            newRecord.theLastRecordStr =_theRecordStr;
            newRecord.canChangeData = YES;
            [self.navigationController pushViewController:newRecord animated:YES];
        }else{
            
#pragma mark - 弹出框
            
            addView.hidden = YES;
            
            CYRecordAlertView *alert = [self.view.window viewWithTag:9999];
            [alert alertViewWith:@"服务结束！" andDetailTitle:@"您的服务已结束，如需再次使用萌宝宝服务，请去购买！"  andButtonTitle:@"2"];
            [alert layoutSubviews];
            alert.payBlocks = ^{
                
                BuyViewController *buyVC = [[BuyViewController alloc] init];
                
                [self.navigationController pushViewController:buyVC animated:YES];
            };
            
            NSLog(@"免费用户已提交过");
            
            
        }
    }else{//付费用户
        
        if (_newRecordDic &&(![_newRecordDic isKindOfClass:[NSNull class]])) {
            NewRecordViewController *newRecord = [[NewRecordViewController alloc] init];
            newRecord.month = [[[NSUserDefaults standardUserDefaults] objectForKey:@"month"] intValue];
            if (![_newRecordDic isKindOfClass:[NSNull class]]) {
                newRecord.recordStar = [[RecordStarRecordStar alloc] initWithDictionary:_newRecordDic];
            }
            
            
            newRecord.isHiddenSubmit = NO;
            newRecord.canChangeData = YES;
            newRecord.theLastRecordStr =_theRecordStr;
            newRecord.showTime = _showTimeStr;
            newRecord.recordStatus = _recordStatusStr;
            newRecord.timeStatus = _timeStatus;
            [self.navigationController pushViewController:newRecord animated:YES];

        }else{
            
            
            addView.hidden = YES;
            
            CYRecordAlertView *alert = [self.view.window viewWithTag:9999];
            [alert alertViewWith:@"服务结束！" andDetailTitle:@"您的服务已结束，如需再次使用萌宝宝服务，请去续费！"  andButtonTitle:@"2"];
            [alert layoutSubviews];
            alert.payBlocks = ^{
                
                BuyViewController *buyVC = [[BuyViewController alloc] init];
                
                [self.navigationController pushViewController:buyVC animated:YES];
            };
            
            NSLog(@"没有userecorrd");
        }
        
    }
    
    
    
    
}




#pragma mark - tableview 代理相关

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *str = @"ReuseIdentifier";
    RecordMainViewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (cell == nil) {
        cell = [[RecordMainViewTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    RecordStarRecordStar *rStar = _recordArr[indexPath.row];
    [cell makeCellWithMonth:rStar.age andNumberOfStar:rStar.star andIsLeft:indexPath.row%2];
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _recordArr.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 110*Ratio;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NewRecordViewController *newRecord = [[NewRecordViewController alloc] init];
    RecordStarRecordStar *rStar = _recordArr[indexPath.row];
    newRecord.month = [rStar.age intValue];
    newRecord.recordStar = rStar;
    NSLog(@"recordStar = %@",rStar);
    newRecord.isHiddenSubmit = YES;
    newRecord.canChangeData = NO;
    [self.navigationController pushViewController:newRecord animated:YES];
    
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
