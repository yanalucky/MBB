//
//  CalendarViewController.m
//  BabyDemo
//
//  Created by 陈彦 on 16/4/28.
//  Copyright © 2016年 elsa. All rights reserved.
//

#import "CalendarViewController.h"
#import "TopViewCalendarTableViewCell.h"
#import "NoticeModel.h"
#import "NetRequestManage.h"

#import "CYAlertView.h"
#import "CYRecordAlertView.h"

#import "SVProgressHUD.h"

#import "NewRecordViewController.h"
#import "NoticeCommentViewController.h"
#import "OnlineAppraisalOnlineAppraisal.h"
#import "OnlineAppraisalImgdata.h"
#import "AppDelegate.h"


@interface CalendarViewController ()<UITableViewDelegate,UITableViewDataSource>{
     UITableView *calendarDataTableView;
    
//    UIButton *_selectedDateBtn;
    
    UIView *pickerBgView;//选择器
    UIDatePicker *picker;
    NSDateFormatter *format;
    NSMutableArray *pickerDataArr;
    
    UILabel *noThingLab;
    
    
    
    NSMutableArray *_hostoryDateArr;//哪些天有消息记录
    NSArray *_noticeTitleArr;
    NSArray *_noticeImgArr;
    
    
    NSMutableArray *_noticeDataArray;//有几个消息通知
    
    
    
    NSMutableArray *_salon;
    NSMutableArray *_bodycheckBooking;
    NSMutableArray *_onlineAppraisal;
    NSMutableArray *_treatBooking;
    NSString *mapStr;
    
    
    NSDictionary *_recordStarDic;
    NSDictionary *_onlineDic;
    
    NSMutableArray *_imagDataArr;
}

@end

@implementation CalendarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"日历";
    self.view.backgroundColor = [UIColor whiteColor];
//    self.navigationController.interactivePopGestureRecognizer.delegate = nil;
    [self createInterface];
    // Do any additional setup after loading the view.
}
-(void)createInterface{
    
    
    if ([self respondsToSelector:@selector(automaticallyAdjustsScrollViewInsets)]) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    _hostoryDateArr = [[NSMutableArray alloc] init];
    _imagDataArr = [[NSMutableArray alloc] init];
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"historyTimeArr"]) {
        NSArray *temArr = [[NSUserDefaults standardUserDefaults] objectForKey:@"historyTimeArr"];
        for (NSDictionary *notice in temArr) {
            [_hostoryDateArr addObject:[notice objectForKey:@"historytime"]];
        }
    }
    
    _noticeTitleArr = @[@"宝妈，萌宝的生长记录已提交成功了哦~~",@"宝妈，医生已为萌宝看过病了哦~~",@"宝妈，您已阅读了萌宝的评估报告啦~~",@"宝妈，育儿沙龙参加过了哦~~",@"宝妈，萌宝的体验完成了哦~~"];
    
    _noticeImgArr = @[@"tijiao",@"zhuanzhen",@"pinggu",@"shalong",@"tijian"];

    
    _noticeDataArray = [[NSMutableArray alloc] init];
    
    NSArray *temArr = [[NSMutableArray alloc] initWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:@"historyRecordArr"]];
    
    
    for (NSDictionary *typeOfNotice in temArr) {
        NoticeModel *model = [[NoticeModel alloc] init];
        model.title = [_noticeTitleArr objectAtIndex:[[typeOfNotice objectForKey:@"historytype"] intValue]-1];
        model.imgName = [NSString stringWithFormat:@"rili_icon_%@",[_noticeImgArr objectAtIndex:[[typeOfNotice objectForKey:@"historytype"] intValue]-1]];
        [_noticeDataArray addObject:model];
    }
    _selectedDateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    _selectedDateBtn.backgroundColor = [UIColor yellowColor];
    _selectedDateBtn.titleLabel.font = [UIFont yaHeiFontOfSize:15*Ratio];
    NSString *date = [[NSString stringWithFormat:@"%@",[[NSDate date] dateByAddingTimeInterval:60*60*8]] substringToIndex:10];
    NSArray *dateSub = [date componentsSeparatedByString:@"-"];
    [_selectedDateBtn setTitle:[NSString stringWithFormat:@"%@月    %@",dateSub[1],dateSub[0]] forState:UIControlStateNormal];
    [_selectedDateBtn setTitleColor:MBColor(250, 109, 166, 1) forState:UIControlStateNormal];
    [_selectedDateBtn setBackgroundImage:[UIImage imageNamed:@"rili_xian"] forState:UIControlStateNormal];
    _selectedDateBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_selectedDateBtn];
    [_selectedDateBtn addTarget:self action:@selector(titleDayClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [_selectedDateBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).offset(20*Ratio);
        make.size.mas_equalTo(CGSizeMake(140*Ratio, 16*Ratio));
        
    }];
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.tag = 1276;
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"rili_left"] forState:UIControlStateNormal];
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"rili_left"] forState:UIControlStateSelected];


    
    [leftBtn addTarget:self action:@selector(leftCalendar:) forControlEvents:UIControlEventTouchUpInside];
    [leftBtn addTarget:self action:@selector(leftCalendar:) forControlEvents:UIControlEventTouchUpOutside];
    [self.view addSubview:leftBtn];
    [leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_selectedDateBtn.mas_left);
        make.centerY.equalTo(_selectedDateBtn);
        make.size.mas_equalTo(CGSizeMake(20*Ratio, 20*Ratio));
    }];
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.tag = 1277;
    [rightBtn setBackgroundImage:[UIImage imageNamed:@"rili_right"] forState:UIControlStateNormal];
    [rightBtn setBackgroundImage:[UIImage imageNamed:@"rili_right"] forState:UIControlStateSelected];


    [rightBtn addTarget:self action:@selector(leftCalendar:) forControlEvents:UIControlEventTouchUpInside];
    [rightBtn addTarget:self action:@selector(leftCalendar:) forControlEvents:UIControlEventTouchUpOutside];
    [self.view addSubview:rightBtn];
    [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_selectedDateBtn.mas_right);
        make.centerY.equalTo(_selectedDateBtn);
        make.size.mas_equalTo(CGSizeMake(20*Ratio, 20*Ratio));
    }];
    
    
    UIImageView *calendarBg = [[UIImageView alloc] init];
    calendarBg.image = [UIImage imageNamed:@"rili_week_bg"];
    [self.view addSubview:calendarBg];
    [calendarBg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(302*Ratio, 23*Ratio));
        make.top.equalTo(_selectedDateBtn.mas_bottom).offset(10*Ratio);
        
    }];
    [self.view sendSubviewToBack:calendarBg];
    
    
    UIImageView *calendarBg1 = [[UIImageView alloc] init];
    calendarBg1.image = [UIImage imageNamed:@"rili_geshan"];
    [self.view addSubview:calendarBg1];
    [calendarBg1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(320*Ratio, 194.5*Ratio));
        make.top.equalTo(calendarBg.mas_bottom).offset(15*Ratio);
        
    }];
    [self.view sendSubviewToBack:calendarBg];
    
    
    self.calendar = [JTCalendar new];
    self.calendar.calendarAppearance.isWeekMode = NO;
    [self.calendar setCurrentDate:[NSDate date]];
    __weak typeof(self) weakself = self;
    self.calendar.changeDateBlocks = ^(NSString *currentDateString){
        
        NSArray *dateSub = [currentDateString componentsSeparatedByString:@"-"];
        typeof(weakself) strongSelf = weakself;
        [strongSelf.selectedDateBtn setTitle:[NSString stringWithFormat:@"%@月    %@",dateSub[1],dateSub[0]] forState:UIControlStateNormal];
        
    };
    //这句不能注销  原因是masonry
    self.calendarContentView = [[JTCalendarContentView alloc] initWithFrame:CGRectMake(24*Ratio, 20*Ratio, (320*Ratio)- (48*Ratio), (320*Ratio)- (48*Ratio))];
    
    
    [self.view addSubview:self.calendarContentView];
    
    
    {
        self.calendar.calendarAppearance.calendar.firstWeekday = 2; // Sunday == 1, Saturday == 7
        self.calendar.calendarAppearance.dayCircleRatio = 7. / 11.;
        self.calendar.calendarAppearance.dayDotRatio = 2. / 13.;
        self.calendar.calendarAppearance.isHiddenCYView = NO;
        self.calendar.calendarAppearance.dayTextColor = MBColor(236, 68 , 153, 1);
        self.calendar.calendarAppearance.dayTextColorOtherMonth = [UIColor whiteColor];
        self.calendar.calendarAppearance.dayTextFont = [UIFont yaHeiFontOfSize:13*Ratio];
        self.calendar.calendarAppearance.ratioContentMenu = 1.;
        self.calendar.calendarAppearance.isWeekMode = NO;
        
    }
    //    self.calendarContentView.backgroundColor = [UIColor redColor];
    
    [self.calendar setContentView:self.calendarContentView];
    
    [self.calendar setDataSource:self];
    
    
    [_calendarContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(260*Ratio));
        make.left.equalTo(self.view).offset(15*Ratio);
        make.right.equalTo(self.view).offset(-15*Ratio);
        make.top.equalTo(_selectedDateBtn.mas_bottom).offset(5*Ratio);
    }];
    
    [self.view layoutIfNeeded];
    
    [self.calendar setCurrentDate:[NSDate date]];
    
    
    

#pragma mark = 日历的消息信息提示 createCalendarDataTableView
    
    calendarDataTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, 100) style:UITableViewStylePlain];
    calendarDataTableView.dataSource = self;
    calendarDataTableView.delegate = self;
    calendarDataTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [calendarDataTableView registerClass:[TopViewCalendarTableViewCell class] forCellReuseIdentifier:@"identi"];
    
    [self.view addSubview:calendarDataTableView];
    calendarDataTableView.bounces = NO;
    
    calendarDataTableView.showsVerticalScrollIndicator = YES;
    
    [calendarDataTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.equalTo(self.view);
        make.top.equalTo(self.view).offset(295*Ratio);
        make.bottom.equalTo(self.view);
        
    }];
    
    
    
    
    
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
    
    
    picker = [[UIDatePicker alloc] init];
    picker.datePickerMode = UIDatePickerModeDate;
    picker.backgroundColor = [UIColor whiteColor];
    format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy-MM-dd"];
    [picker setDate:[format dateFromString:[[NSString stringWithFormat:@"%@",[[NSDate date] dateByAddingTimeInterval:60*60*8]] substringToIndex:10]] animated:NO];
    [picker addTarget:self action:@selector(selDate:) forControlEvents:UIControlEventValueChanged];
    [pickerBgView addSubview:picker];
    [picker mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(pickerBgView);
        
        make.size.mas_equalTo(CGSizeMake(320*Ratio, 215*Ratio));
        make.centerX.equalTo(pickerBgView);
    }];
    [self.view bringSubviewToFront:pickerBgView];
    
    pickerBgView.hidden = YES;
    
    
#pragma mark = 无重要事件
    noThingLab = [[UILabel alloc] init];
    [noThingLab makeLabelWithText:@"无重要事件" andTextColor:MBColor(179, 180, 181, 1) andFont:[UIFont yaHeiFontOfSize:23*Ratio]];
    noThingLab.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:noThingLab];
    
    [noThingLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(180*Ratio, 40*Ratio));
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-120*Ratio);
        
    }];
    noThingLab.hidden = YES;

}

-(void)leftCalendar:(UIButton *)button{
    for (int i=0; i<2; i++) {
        UIButton *but = [self.view viewWithTag:(1276 + i)];
        but.selected = NO;

    }
    button.selected = YES;
    NSString *selectDateStr = _selectedDateBtn.titleLabel.text;
    NSArray *arr = [selectDateStr componentsSeparatedByString:@"月    "];
    NSString *currentDateStr = [NSString stringWithFormat:@"%@-%@-%@",arr[1],arr[0],@"2"];
    NSDate *curentDate = [format dateFromString:currentDateStr];
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    [dateComponents setMonth:(button.tag == 1276)?-1:1];
    NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:curentDate options:0];
    
    [self.calendar setCurrentDate:newDate];
    
    NSArray *dateSub = [[[NSString stringWithFormat:@"%@",newDate] substringToIndex:10] componentsSeparatedByString:@"-"];
    [_selectedDateBtn setTitle:[NSString stringWithFormat:@"%@月    %@",dateSub[1],dateSub[0]] forState:UIControlStateNormal];

}



-(void)pickerViewClick:(UITapGestureRecognizer *)tap{
    if (tap.view.hidden == NO) {
        tap.view.hidden = YES;
        
        [self.calendar setCurrentDate:[format dateFromString:[[NSString stringWithFormat:@"%@",[picker.date dateByAddingTimeInterval:60*60*8]] substringToIndex:10]]];

    }
}
-(void)titleDayClick:(UIButton *)button{
//    NSLog(@"点击 ！");
    pickerBgView.hidden = NO;
    
    [self.view bringSubviewToFront:pickerBgView];
}


#pragma mark - UIDatePicker代理相关

-(void)selDate:(UIDatePicker *)picke{
    
    NSString *date = [[NSString stringWithFormat:@"%@",[[picke date] dateByAddingTimeInterval:60*60*8]] substringToIndex:10];
    NSArray *dateSub = [date componentsSeparatedByString:@"-"];
    [_selectedDateBtn setTitle:[NSString stringWithFormat:@"%@月    %@",dateSub[1],dateSub[0]] forState:UIControlStateNormal];
    
    
    
//    [_selectedDateBtn setTitle:[[NSString stringWithFormat:@"%@",[[picke date] dateByAddingTimeInterval:60*60*8]] substringToIndex:10] forState:UIControlStateNormal];
}

#pragma mark - tableView代理相关

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *str = @"identi";
    
    TopViewCalendarTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str forIndexPath:indexPath];
    NoticeModel *model = _noticeDataArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell makeCellByLeftImageName:model.imgName withTitle:model.title withDetailTitle:nil withIsRight:(([model.imgName isEqualToString:[NSString stringWithFormat:@"rili_icon_%@",_noticeImgArr[0]]]||[model.imgName isEqualToString:[NSString stringWithFormat:@"rili_icon_%@",_noticeImgArr[2]]])== YES)?YES:NO];
    return cell;
    //    if (cell == nil) {
    //        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:str];
    //
    //    }
    
    //    cell.backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320*Ratio, 44*Ratio)];
    //    cell.backgroundView.backgroundColor = MBColor(255, 255, 255, 1);
    //    cell.selectedBackgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320*Ratio, 44*Ratio)];
    //    cell.selectedBackgroundView.backgroundColor = MBColor(245, 245, 245, 1);
    
    
    //    cell.textLabel.text = _calendarDataArr[indexPath.row];
    //    cell.textLabel.font = [UIFont yaHeiFontOfSize:12];
    //    cell.textLabel.textColor = MBColor(51, 51, 51, 1);
    //    cell.textLabel.backgroundColor = [UIColor redColor];
    //
    //    cell.detailTextLabel.text = _calendarDataArr[indexPath.row];
    //    cell.imageView.image = [UIImage imageNamed:@"shouye_blue"];
    //    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    //    [cell layoutSubviews];
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //    @[@"tijiao",@"zhuanzhen",@"pinggu",@"shalong",@"tijian"];
    
    NoticeModel *model = _noticeDataArray[indexPath.row];
    
    if ([model.imgName isEqualToString:[NSString stringWithFormat:@"rili_icon_%@",_noticeImgArr[0]]]) {
        NewRecordViewController *newRecord = [[NewRecordViewController alloc] init];
        RecordStarRecordStar *rStar = [[RecordStarRecordStar alloc] initWithDictionary:_recordStarDic];
        newRecord.month = [rStar.age intValue];
        newRecord.recordStar = rStar;
        newRecord.isHiddenSubmit = YES;
        newRecord.canChangeData = NO;
        [self.navigationController pushViewController:newRecord animated:YES];
    }else if ([model.imgName isEqualToString:[NSString stringWithFormat:@"rili_icon_%@",_noticeImgArr[2]]]){
        
        
        if (_onlineDic) {
            
            OnlineAppraisalOnlineAppraisal *onlineAppra = [[OnlineAppraisalOnlineAppraisal alloc] initWithDictionary:_onlineDic];
            NoticeCommentViewController *nvc = [[NoticeCommentViewController alloc] init];
            nvc.currentOnline = onlineAppra;
            nvc.imgData = _imagDataArr;
            [self.navigationController pushViewController:nvc animated:YES];
            
        }
        
        
    }
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_noticeDataArray count];//用户有几个消息通知
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45*Ratio;//用户有几个消息通知
}


#pragma mark - JTCalendarDataSource

- (BOOL)calendarHaveEvent:(JTCalendar *)calendar date:(NSDate *)date
{
    //        return (rand() % 2) == 1;
    NSString *dateStr = [[NSString stringWithFormat:@"%@",[date dateByAddingTimeInterval:60*60*8]] substringToIndex:10];
    if ([_hostoryDateArr containsObject:dateStr]) {
        return 1;
    }else{
        return 0;
    }
    
}

- (void)calendarDidDateSelected:(JTCalendar *)calendar date:(NSDate *)date
{
    
    date = [date dateByAddingTimeInterval:60*60*8];
//    NSLog(@"Date: %@", date);
    NSString *dateStr = [NSString stringWithFormat:@"%@",date];
    dateStr = [dateStr substringToIndex:10];
//    NSArray *arr = [dateStr componentsSeparatedByString:@"-"];
   
    
    [NetRequestManage clickHistoryRecordWithChooseTime:dateStr andUserId:[[NSUserDefaults standardUserDefaults] objectForKey:@"userId"] successBlocks:^(NSData *data, NetRequestManage *clickHistoryRecord) {
        
            NSString *str = [[NSString alloc] initWithData:clickHistoryRecord.resultData encoding:NSUTF8StringEncoding];
            NSLog(@"clickHistoryRecord = %@",str);
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:clickHistoryRecord.resultData options:NSJSONReadingMutableContainers error:nil];
            
            if ([[dic objectForKey:@"errorId"] intValue] == 0) {
                
                            if (![[[dic objectForKey:@"result"] objectForKey:@"onclickHistoryList"] isKindOfClass:[NSNull class]]) {
                                if ([[[dic objectForKey:@"result"] objectForKey:@"onclickHistoryList"] count] > 0) {
                                    [_noticeDataArray removeAllObjects];
                                    NSArray *noticeArr = [[dic objectForKey:@"result"] objectForKey:@"onclickHistoryList"];
                                    for (NSDictionary *typeOfNotice in noticeArr) {
                                        NoticeModel *model = [[NoticeModel alloc] init];
                                        
                                        model.title = [_noticeTitleArr objectAtIndex:[[typeOfNotice objectForKey:@"historytype"] intValue]-1];
                                        model.imgName = [NSString stringWithFormat:@"rili_icon_%@",[_noticeImgArr objectAtIndex:[[typeOfNotice objectForKey:@"historytype"] intValue]-1]];
                                        [_noticeDataArray addObject:model];
                                    }
                
                                    

                                    if (![[[dic objectForKey:@"result"] objectForKey:@"recordStar"] isKindOfClass:[NSNull class]]) {
                                        if ([[[dic objectForKey:@"result"] objectForKey:@"recordStar"] count] > 0) {
                                            _recordStarDic = nil;
                                            _recordStarDic = [[[dic objectForKey:@"result"] objectForKey:@"recordStar"] objectAtIndex:0];
                                        }
                                    }
                                    
                                    
                                    if (![[[dic objectForKey:@"result"] objectForKey:@"OnlineAppraisal"] isKindOfClass:[NSNull class]]) {
                                        if ([[[dic objectForKey:@"result"] objectForKey:@"OnlineAppraisal"] count] > 0) {
                                            _onlineDic = nil;
                                            _onlineDic = [[[dic objectForKey:@"result"] objectForKey:@"OnlineAppraisal"] objectAtIndex:0];
                                        }
                                    }
                                    
                                    if (![[[dic objectForKey:@"result"] objectForKey:@"imgdata"] isKindOfClass:[NSNull class]]) {
                                        
                                        
                                        NSArray *imgArr = [[dic objectForKey:@"result"] objectForKey:@"imgdata"];
                                        if (imgArr.count > 0) {
                                            
                                            [_imagDataArr removeAllObjects];
                                            for (NSDictionary *imgData in imgArr) {
                                                OnlineAppraisalImgdata *imag = [[OnlineAppraisalImgdata alloc] initWithDictionary:imgData];
                                                [_imagDataArr addObject:imag];
                                            }
                                        }
                                        
                                        
                                        
                                    }
                
                                    noThingLab.hidden = YES;
                               
                                    
                
                                }else{
                                    
                                    NSLog(@"您这一天没有消息记录哦！");
                                    [_noticeDataArray removeAllObjects];
                                    
                                    noThingLab.hidden = NO;
//                                    
//                                    CYRecordAlertView *alert = [self.view.window viewWithTag:9999];
//                                    [alert alertViewWith:nil andDetailTitle:@"您这一天没有消息记录哦！"  andButtonTitle:@"0"];
//                                    [alert layoutSubviews];
                                    

                                }
                            }else{
                                NSLog(@"您这一天没有消息记录哦！");
                                [_noticeDataArray removeAllObjects];
                                
                                noThingLab.hidden = NO;

//                                CYRecordAlertView *alert = [self.view.window viewWithTag:9999];
//                                [alert alertViewWith:nil andDetailTitle:@"您这一天没有消息记录哦！"  andButtonTitle:@"0"];
//                                [alert layoutSubviews];
//                                
                              
                            }
                
               
                [[NSOperationQueue mainQueue] addOperationWithBlock:^{
#pragma mark = 更新日历信息提示
                    [UIView animateWithDuration:0.5 animations:^{
                        
                        [calendarDataTableView reloadData];
                        [self.view layoutIfNeeded];
                    }];
                    
                    
                }];
                
                
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
            
            
        
    } andFailedBlocks:^(NSError *error, NetRequestManage *clickHistoryRecord) {
        NSLog(@"error = %@",error.localizedDescription);
    }];
    
    
    
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
