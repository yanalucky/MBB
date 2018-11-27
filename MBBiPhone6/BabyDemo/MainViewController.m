//
//  MainViewController.m
//  BabyDemo
//
//  Created by 陈彦 on 16/2/26.
//  Copyright © 2016年 elsa. All rights reserved.
//
#define MainColor [UIColor colorWithRed:239/255.0 green:67/255.0 blue:153/255.0 alpha:1]
#import "MainViewController.h"
#import "LeftViewController.h"
#import "TopViewCalendarTableViewCell.h"
#import "ObserveViewController.h"
#import "UserHeaderViewController.h"
#import "CalendarViewController.h"
#import "NetRequestManage.h"
#import "SVProgressHUD.h"
#import "UIImageView+WebCache.h"
#import "LoginUser.h"
#import "CYAlertView.h"
#import "CYRecordAlertView.h"

#import "NewRecordViewController.h"
#import "CommentViewController.h"
#import "SalonViewController.h"
#import "OnlineAppraisalOnlineAppraisal.h"
#import "NoticeCommentViewController.h"
#import "SalonDetailViewController.h"

#import "NewsContextViewController.h"
#import "BannerViewController.h"

#import "YLZYViewController.h"

#import "OnlineAppraisalImgdata.h"

#import "BuyViewController.h"
#import "AppDelegate.h"
#import "UMMobClick/MobClick.h"

#import <CoreLocation/CoreLocation.h>



//typedef enum {
//    tijiao = 0,
//    zhuanzhen,
//    pinggu,
//    shalong,
//    tijian
//    
//} NoticeNum;

@interface MainViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,CLLocationManagerDelegate>{
    UIView *userView;
    UILabel *_selectedDate;
    UIView *contentView;//mainSC 的 contentView
    
    UITableView *calendarDataTableView;
    
//    NSMutableArray *_salonImageArr;
    NSMutableArray *_bannerArr;
    UIPageControl *_pageControll;
    NSMutableArray *_knowledgeArr;
     
    
    BOOL _isfirst;
    UIScrollView *salonSC;
    
    NSMutableArray *_noticeDateArr;//有哪些天有消息通知
    NSArray *_noticeTitleArr;
    NSArray *_noticeImgArr;
    
    
    NSMutableArray *_noticeDataArray;//消息通知的数量
    
    
    
    
    NSMutableArray *_salon;
    NSMutableArray *_bodycheckBooking;
    NSMutableArray *_treatBooking;
    NSString *mapStr;
    NSMutableArray *_imagDataArr;
//    NSArray *_newscontextArr;
    NSMutableArray *_mengClassArr;
    
    NSDictionary *_onlineNoticeDic;
    
    
    NSString *_theLastRecordStr;
    NSString *_showTimeStr;
    NSString *_recordStatusStr;
    int _timeStatus;
    
    
    UIImageView *sex;
    UILabel *birthDay;
    
    NSDictionary *_newRecordDic;
}

@property (nonatomic, strong) CLLocationManager *locationManager;

@end

@implementation MainViewController


#pragma mark - 定位
//开始定位
- (void)startLocation {
    
    NSLog(@"");
    
    if ([CLLocationManager locationServicesEnabled]) {
        //--------开始定位
        self.locationManager = [[CLLocationManager alloc]init];
        self.locationManager.delegate = self;
        //控制定位精度,越高耗电量越
        self.locationManager.desiredAccuracy = kCLLocationAccuracyKilometer;
        // 总是授权
        [self.locationManager requestWhenInUseAuthorization];

        self.locationManager.distanceFilter = 10.0f;
        [self.locationManager startUpdatingLocation];
    }
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    if ([error code] == kCLErrorDenied) {
        NSLog(@"访问被拒绝");
        
    }
    if ([error code] == kCLErrorLocationUnknown) {
        NSLog(@"无法获取位置信息");
    }
}
//定位代理经纬度回调

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    
    
    [manager stopUpdatingLocation];
    CLLocation *newLocation = locations[0];
    //    NSLog(@"打印经纬度 ：%@",newLocation);
    // 获取当前所在的城市名
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    //根据经纬度反向地理编译出地址信息
    [geocoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray *array, NSError *error){
        
        
        if (array.count > 0){
            CLPlacemark *placemark = [array objectAtIndex:0];
            
            //获取城市
            NSString *city = placemark.locality;
            if (!city) {
                //四大直辖市的城市信息无法通过locality获得，只能通过获取省份的方法来获得（如果city为空，则可知为直辖市）
                city = placemark.administrativeArea;
            }
            NSLog(@"city = %@", city);
            NSLog(@"document = %@",[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]);
            NSLog(@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"city"]);

            
            if ([[NSUserDefaults standardUserDefaults] objectForKey:@"city"]&&(![[[NSUserDefaults standardUserDefaults] objectForKey:@"city"] isKindOfClass:[NSNull class]])) {}
            else{
                [[NSUserDefaults standardUserDefaults] setObject:city forKey:@"city"];
                [MobClick event:@"customCity" label:city];
            }
            NSLog(@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"city"]);
//            NSLog(@"customecity = %@",[[NSUserDefaults standardUserDefaults] objectForKey:@"city"]);
//天气
//            [self httpGetWeather:city];
        }
        else if (error == nil && [array count] == 0)
        {
            NSLog(@"No results were returned.");
        }
        else if (error != nil)
        {
            NSLog(@"An error occurred = %@", error);
            
            //            UIAlertView *al = [[UIAlertView alloc] initWithTitle:@"错误" message:@"An error occurred " delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:nil, nil];
            //            [al show];
        }
    }];
    //系统会一直更新数据，直到选择停止更新，因为我们只需要获得一次经纬度即可，所以获取之后就停止更新
    
    
}





#pragma mark - 弹窗


-(void)showAlertView:(NSString *)str andCanCancel:(BOOL)isCancel{
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
    
    if (isCancel == NO) {
        UIButton *continueBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [continueBtn setTitleColor:MBColor(250, 109, 166, 1) forState:UIControlStateNormal];
        [continueBtn setTitle:@"马上去" forState:UIControlStateNormal];
        [continueBtn addTarget:self action:@selector(continueAction:) forControlEvents:UIControlEventTouchUpInside];
        continueBtn.titleLabel.font = [UIFont yaHeiFontOfSize:16*Ratio];
        [alert addSubview:continueBtn];
        [continueBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(200*Ratio, 38*Ratio));
            make.centerX.equalTo(ciew);
            make.top.equalTo(titlLabel.mas_bottom);
        }];
        
    }else{
        UIButton *continueBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [continueBtn setTitleColor:MBColor(250, 109, 166, 1) forState:UIControlStateNormal];
        [continueBtn setTitle:@"马上去" forState:UIControlStateNormal];
        [continueBtn addTarget:self action:@selector(continueAction1:) forControlEvents:UIControlEventTouchUpInside];
        continueBtn.titleLabel.font = [UIFont yaHeiFontOfSize:16*Ratio];
        [alert addSubview:continueBtn];
        [continueBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.size.mas_equalTo(CGSizeMake(121*Ratio, 38*Ratio));
            make.right.equalTo(alert);
            make.top.equalTo(titlLabel.mas_bottom);
            
        }];
        UILabel *lin1 = [[UILabel alloc] init];
        lin1.backgroundColor = MBColor(250, 109, 166, 1);
        [alert addSubview:lin1];
        [lin1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(1, 38*Ratio));
            make.centerX.equalTo(ciew);
            make.top.equalTo(continueBtn);
        }];
        UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [cancelBtn setTitleColor:MBColor(102, 103, 104, 1) forState:UIControlStateNormal];
        [cancelBtn setTitle:@"算了" forState:UIControlStateNormal];
        [cancelBtn addTarget:self action:@selector(cancelAction:) forControlEvents:UIControlEventTouchUpInside];
        cancelBtn.titleLabel.font = [UIFont yaHeiFontOfSize:16*Ratio];
        [alert addSubview:cancelBtn];
        [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.size.mas_equalTo(CGSizeMake(121*Ratio, 38*Ratio));
            make.left.equalTo(alert);
            make.top.equalTo(titlLabel.mas_bottom);
            
        }];
    }
    
    
    
    [self.view.window bringSubviewToFront:ciew];
    
    
}

-(void)cancelAction:(UIButton *)button{
    
    UIView *ciew = [self.view.window viewWithTag:6666];
    ciew.hidden = YES;
    [self.view.window sendSubviewToBack:ciew];
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"isNewBabyUser"]) {
        if (![[[NSUserDefaults standardUserDefaults] objectForKey:@"isNewBabyUser"] isKindOfClass:[NSNull class]]) {
            if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"isNewBabyUser"] intValue] == 1) {
                [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"isNewBabyUser"];
            }
        }
    }
}



-(void)continueAction1:(UIButton *)button{
    UIView *ciew = [self.view.window viewWithTag:6666];
    ciew.hidden = YES;
    [self.view.window sendSubviewToBack:ciew];
    
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"isNewBabyUser"]) {
        if (![[[NSUserDefaults standardUserDefaults] objectForKey:@"isNewBabyUser"] isKindOfClass:[NSNull class]]) {
            if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"isNewBabyUser"] intValue] == 1) {
                [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"isNewBabyUser"];
            }
        }
    }
    NewRecordViewController *newRecord = [[NewRecordViewController alloc] init];
    
    newRecord.month = [[[NSUserDefaults standardUserDefaults] objectForKey:@"month"] intValue];
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"firstRecordDic"]) {
        if (![[[NSUserDefaults standardUserDefaults] objectForKey:@"firstRecordDic"] isKindOfClass:[NSNull class]]) {
            
            RecordStarRecordStar *rStar = [[RecordStarRecordStar alloc] initWithDictionary:[[NSUserDefaults standardUserDefaults] objectForKey:@"firstRecordDic"]];
            
            newRecord.recordStar = rStar;
            newRecord.theLastRecordStr = rStar.recordid;
            
            
        }
    }
    newRecord.isHiddenSubmit = NO;
    newRecord.canChangeData = YES;
    newRecord.showTime = nil;
    newRecord.recordStatus = @"0";
    newRecord.timeStatus = 0;
    [self.navigationController pushViewController:newRecord animated:YES];
    
    
}

-(void)continueAction:(UIButton *)button{
    UIView *ciew = [self.view.window viewWithTag:6666];
    ciew.hidden = YES;
    [self.view.window sendSubviewToBack:ciew];
    
    NewRecordViewController *newRecord = [[NewRecordViewController alloc] init];
    
    newRecord.month = [[[NSUserDefaults standardUserDefaults] objectForKey:@"month"] intValue];
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"firstRecordDic"]) {
        if (![[[NSUserDefaults standardUserDefaults] objectForKey:@"firstRecordDic"] isKindOfClass:[NSNull class]]) {
            
            RecordStarRecordStar *rStar = [[RecordStarRecordStar alloc] initWithDictionary:[[NSUserDefaults standardUserDefaults] objectForKey:@"firstRecordDic"]];
            
            newRecord.recordStar = rStar;
            newRecord.theLastRecordStr = rStar.recordid;
            
            
        }
    }
    newRecord.isHiddenSubmit = NO;
    newRecord.canChangeData = YES;
    newRecord.showTime = nil;
    newRecord.recordStatus = @"0";
    newRecord.timeStatus = 0;
    [self.navigationController pushViewController:newRecord animated:YES];
    
    
}


-(void)viewDidDisappear:(BOOL)animated{
    
    UIView *ciew = [self.view.window viewWithTag:6666];
    ciew.hidden = YES;
    [self.view.window sendSubviewToBack:ciew];
    
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
    yindao.image = [UIImage imageNamed:@"shouye_yindao"];
    yindao.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeView)];
    [yindao addGestureRecognizer:tap];
    [ciew addSubview:yindao];
    [yindao mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(320*Ratio, 568*Ratio));
        make.edges.equalTo(ciew);
    }];
    [[NSUserDefaults standardUserDefaults] setObject:@"YES" forKey:@"manyOfMainView"];
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


    
    
#pragma mark - 拿记录
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"needFillInFeature"]) {
        if (![[[NSUserDefaults standardUserDefaults] objectForKey:@"needFillInFeature"] isKindOfClass:[NSNull class]]) {
            if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"needFillInFeature"] intValue] == 1) {
                [self showAlertView:@"宝宝日增夜长，您需要重新确认您的宝宝生长记录进行提交哦~" andCanCancel:NO];
            }
        }
    }
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"isNewBabyUser"]) {
        if (![[[NSUserDefaults standardUserDefaults] objectForKey:@"isNewBabyUser"] isKindOfClass:[NSNull class]]) {
            if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"isNewBabyUser"] intValue] == 1) {
                [self showAlertView:@"宝宝日增夜长，您需要重新确认您的宝宝生长记录进行提交哦~" andCanCancel:YES];
            }
        }
    }
    
        if (![[NSUserDefaults standardUserDefaults] objectForKey:@"manyOfMainView"]) {
    
            

            [self performSelector:@selector(showAlertView) withObject:nil afterDelay:0.1];
  
    
        }

    NSDictionary *userDic = [[NSUserDefaults standardUserDefaults] objectForKey:@"user"];
    //nslog(@"userDic = %@",userDic);
    LoginUser *user = [[LoginUser alloc] initWithDictionary:userDic];
    
  
    if (_isfirst == NO) {
        
        [self.calendar setCurrentDateSelected:[NSDate date]];

        [self.calendar setCurrentDate:[NSDate date]];
        
        
        [self.calendar reloadAppearance];
        
        [NetRequestManage loadHomeWithUserId:[[NSUserDefaults standardUserDefaults] objectForKey:@"userId"] successBlocks:^(NSData *data, NetRequestManage *loadHome) {
//            NSString *str = [[NSString alloc] initWithData:loadHome.resultData encoding:NSUTF8StringEncoding];
            //nslog(@"loadHome = %@",str);
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:loadHome.resultData options:NSJSONReadingMutableContainers error:nil];
            if ([[dic objectForKey:@"errorId"] intValue] == 0) {
                [_noticeDataArray removeAllObjects];
                if ([dic objectForKey:@"result"]) {
                    if (![[[dic objectForKey:@"result"] objectForKey:@"noticeByNow"] isKindOfClass:[NSNull class]]) {
                        if ([[[dic objectForKey:@"result"] objectForKey:@"noticeByNow"] count] > 0) {
                            if (![[[[dic objectForKey:@"result"] objectForKey:@"noticeByNow"] objectAtIndex:0] isKindOfClass:[NSNull class]]) {
                                NSArray *noticeArr = [[dic objectForKey:@"result"] objectForKey:@"noticeByNow"];
                                for (NSDictionary *typeOfNotice in noticeArr) {
                                    NoticeModel *model = [[NoticeModel alloc] init];
                                    model.title = [_noticeTitleArr objectAtIndex:[[typeOfNotice objectForKey:@"historytype"] intValue]-1];
                                    model.imgName = [NSString stringWithFormat:@"rili_icon_%@",[_noticeImgArr objectAtIndex:[[typeOfNotice objectForKey:@"historytype"] intValue]-1]];
                                    [_noticeDataArray addObject:model];
                                    
                                }
                            }
                        }
                    }
                    
                    /*
                    if (![[[dic objectForKey:@"result"] objectForKey:@"SalonByNow"] isKindOfClass:[NSNull class]]) {
                        [_salon removeAllObjects];
                        NSDictionary *salonDictionary = [[dic objectForKey:@"result"] objectForKey:@"SalonByNow"];
                        [_salon addObject:[salonDictionary objectForKey:@"salonupdatetime"]];
                        [_salon addObject:[salonDictionary objectForKey:@"salonaddress"]];
                        [_salon addObject:[salonDictionary objectForKey:@"salontopic"]];
                        [_salon addObject:[salonDictionary objectForKey:@"salonguest"]];
                        [_salon addObject:[NSString stringWithFormat:@"%@ 📞%@",[salonDictionary objectForKey:@"contactperson"],[salonDictionary objectForKey:@"contactmobile"]]];
                        
                        mapStr = [salonDictionary objectForKey:@"hospitalMapUrl"];
                        
                    }
                    */
                    if (![[[dic objectForKey:@"result"] objectForKey:@"BodycheckBookingByNow"] isKindOfClass:[NSNull class]]) {
                        
                        [_bodycheckBooking removeAllObjects];
                        
                        NSDictionary *bobycheckBooking = [[dic objectForKey:@"result"] objectForKey:@"BodycheckBookingByNow"];
                        [_bodycheckBooking addObject:[bobycheckBooking objectForKey:@"bookingtime"]];
                        [_bodycheckBooking addObject:[bobycheckBooking objectForKey:@"department"]];
                        NSString *hosptName = [[[[NSUserDefaults standardUserDefaults] objectForKey:@"hospitalDic"] objectForKey:[bobycheckBooking objectForKey:@"hospitalid"]] objectForKey:@"hospitalname"];
                        [_bodycheckBooking addObject:hosptName];
                        
                        NSString *doctorName = [[[[NSUserDefaults standardUserDefaults] objectForKey:@"doctorDic"] objectForKey:[bobycheckBooking objectForKey:@"doctorid"]] objectForKey:@"doctorname"];
                        [_bodycheckBooking addObject:doctorName];
                        [_bodycheckBooking addObject:[NSString stringWithFormat:@"%@ 📞%@",[bobycheckBooking objectForKey:@"contactperson"],[bobycheckBooking objectForKey:@"contactmobile"]]];
                        [_bodycheckBooking addObject:[bobycheckBooking objectForKey:@"hospitalAddress"]];
                        mapStr = [bobycheckBooking objectForKey:@"hospitalMapUrl"];
                        
                        
                    }
                    if (![[[dic objectForKey:@"result"] objectForKey:@"OnlineAppraisal"] isKindOfClass:[NSNull class]]) {
                        
                        NSArray *onlineAppaisalArr = [[dic objectForKey:@"result"] objectForKey:@"OnlineAppraisal"];
                        
                        
                        if (onlineAppaisalArr.count > 0) {
                            
                            _onlineNoticeDic = onlineAppaisalArr[0];
                            
                        }
                        
                    }
                    if (![[[dic objectForKey:@"result"] objectForKey:@"TreatBookingByNow"] isKindOfClass:[NSNull class]]) {
                        
                        [_treatBooking removeAllObjects];
                        
                        NSDictionary *treatBooking = [[dic objectForKey:@"result"] objectForKey:@"TreatBookingByNow"];
                        [_treatBooking addObject:[treatBooking objectForKey:@"bookingtime"]];
                        [_treatBooking addObject:[treatBooking objectForKey:@"department"]];
                        NSString *hosptName = [[[[NSUserDefaults standardUserDefaults] objectForKey:@"hospitalDic"] objectForKey:[treatBooking objectForKey:@"hospitalid"]] objectForKey:@"hospitalname"];
                        [_treatBooking addObject:hosptName];
                        
                        NSString *doctorName = [[[[NSUserDefaults standardUserDefaults] objectForKey:@"doctorDic"] objectForKey:[treatBooking objectForKey:@"doctorid"]] objectForKey:@"doctorname"];
                        [_treatBooking addObject:doctorName];
                        [_treatBooking addObject:[NSString stringWithFormat:@"%@ 📞%@",[treatBooking objectForKey:@"contactperson"],[treatBooking objectForKey:@"contactmobile"]]];
                        [_treatBooking addObject:[treatBooking objectForKey:@"hospitalAddress"]];
                        mapStr = [treatBooking objectForKey:@"hospitalMapUrl"];
                        
                        
                    }
                    if (![[[dic objectForKey:@"result"] objectForKey:@"UserRecord"] isKindOfClass:[NSNull class]]) {
                        
                        NSDictionary *userRecord = [[dic objectForKey:@"result"] objectForKey:@"UserRecord"];
                        _theLastRecordStr = [userRecord objectForKey:@"recordid"];
                        _timeStatus = (int)[[dic objectForKey:@"result"] objectForKey:@"TimeStatus"];
                        _recordStatusStr = [userRecord objectForKey:@"recordstatus"];
                        _showTimeStr = [[dic objectForKey:@"result"] objectForKey:@"ShowTime"];
                        _newRecordDic = userRecord;

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
                    if (![[[dic objectForKey:@"result"] objectForKey:@"bannerList"] isKindOfClass:[NSNull class]]) {
                        
                        if (_bannerArr) {
                            
                            [_bannerArr removeAllObjects];
                            [_bannerArr addObject:[[[dic objectForKey:@"result"] objectForKey:@"bannerList"] lastObject]];
                            [_bannerArr addObjectsFromArray:[[dic objectForKey:@"result"] objectForKey:@"bannerList"]];
                            [_bannerArr addObject:[[[dic objectForKey:@"result"] objectForKey:@"bannerList"] firstObject]];
                            
                        }
                        
                    }
//                    _newscontextArr = [[dic objectForKey:@"result"] objectForKey:@"childCareKnowledgeList"];
//                    //nslog(@"newscontext = %@",_newscontextArr);

                    if (![[[dic objectForKey:@"result"] objectForKey:@"mengClassList"] isKindOfClass:[NSNull class]]) {
                        
                        if (_mengClassArr) {
                            [_mengClassArr removeAllObjects];
                            
                            [_mengClassArr addObjectsFromArray:[[dic objectForKey:@"result"] objectForKey:@"mengClassList"]];
                        }
                        
                    }
                }
                
                [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                    
#pragma mark = 更新日历信息提示
                    


                    [UIView animateWithDuration:0.5 animations:^{
                        [calendarDataTableView mas_updateConstraints:^(MASConstraintMaker *make) {
                            make.height.equalTo(@(45*Ratio*[_noticeDataArray count]));
                        }];
                        [calendarDataTableView reloadData];
                        [contentView layoutIfNeeded];
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
           
           
        } andFailedBlocks:^(NSError *error, NetRequestManage *loadHome) {
            //nslog(@"loadHomeError = %@",error.localizedDescription);
            
        }];
        
        
        NSString *path = NSHomeDirectory();
        NSString *jpgImagePath = [path stringByAppendingPathComponent:@"Documents/header.jpg"];
        _header.image = [[UIImage alloc] initWithContentsOfFile:jpgImagePath];
        self.navigationItem.title = user.truename;
        sex.image = [[UIImage imageNamed:[NSString stringWithFormat:@"shouye_icon_%@",user.sex]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
         NSArray *timeArr = [[NSUserDefaults standardUserDefaults] objectForKey:@"monthTime"];
        birthDay.text = [NSString stringWithFormat:@"%d月%d天",[timeArr[0] intValue]*12+[timeArr[1] intValue],[timeArr[2] intValue]];
        
        [_noticeDateArr removeAllObjects];
        
        if ([[NSUserDefaults standardUserDefaults] objectForKey:@"noticeTimeArr"]) {
            NSArray *temArr = [[NSUserDefaults standardUserDefaults] objectForKey:@"noticeTimeArr"];
            for (NSDictionary *notice in temArr) {
                [_noticeDateArr addObject:[notice objectForKey:@"historytime"]];
            }
            
        }
        
        //nslog(@"_noticeDateArr = %@",_noticeDateArr);
        [self.calendar reloadData];
        [self.calendar reloadAppearance];
        [calendarDataTableView reloadData];
        //    [header sd_setImageWithURL:[NSURL URLWithString:[NSString urlStringOfImage:user.headimg]]];
        

        [self.view reloadInputViews];

    }

    _isfirst = NO;
  

   
}


-(void)leftBtn{
#pragma mark =  左边按钮
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//    [button setImage:[UIImage imageNamed:@"shouye_top_left"] forState:UIControlStateNormal];
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


- (void)viewDidLoad {
    [super viewDidLoad];
    [MobClick profileSignInWithPUID:[[NSUserDefaults standardUserDefaults] objectForKey:@"userId"]];

    

    [self startLocation];
    

    //第一次用户登录 用于标记重登
    [[NSUserDefaults standardUserDefaults] setObject:@"NO" forKey:@"FirstUser"];
    
    
    _noticeTitleArr = @[@"宝妈，萌宝的生长记录还未提交哦~~",@"宝妈，医生已为您约好了哦~~",@"宝妈，萌宝的评估报告粗来啦~~",@"宝妈，下午有育儿沙龙哦~~",@"宝妈，记得带萌宝去体检哦~~"];
    
    _noticeImgArr = @[@"tijiao",@"zhuanzhen",@"pinggu",@"shalong",@"tijian"];

    
    _noticeDataArray = [[NSMutableArray alloc] init];
    
    
    _isfirst = YES;
    [self leftBtn];
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    _imagDataArr = [[NSMutableArray alloc] init];
    /*
    _salonImageArr = [[NSMutableArray alloc] init];
    
    NSArray *salonThreeArr = [[[NSUserDefaults standardUserDefaults] objectForKey:@"salonDic"] allValues];
    
    for (int i=0; i<salonThreeArr.count; i++) {
        
        [_salonImageArr addObject:[salonThreeArr[i] objectForKey:@"salonimg"]];
    }
    */
    
    _noticeDateArr = [[NSMutableArray alloc] init];
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"noticeTimeArr"]) {
        NSArray *temArr = [[NSUserDefaults standardUserDefaults] objectForKey:@"noticeTimeArr"];
        for (NSDictionary *notice in temArr) {
            [_noticeDateArr addObject:[notice objectForKey:@"historytime"]];
        }
        
    }
    
    //nslog(@"_noticeDateArr = %@",_noticeDateArr);
    
    _knowledgeArr = [[NSMutableArray alloc] init];
    [_knowledgeArr addObject:@"宝妈，我这么胖真的好么？"];
    [_knowledgeArr addObject:@"宝妈，我这么胖真的好么？"];

    
    
    _salon = [[NSMutableArray alloc] init];
    _bodycheckBooking = [[NSMutableArray alloc] init];
    _treatBooking = [[NSMutableArray alloc] init];
    
    _mengClassArr = [[NSMutableArray alloc] init];
    _bannerArr = [[NSMutableArray alloc] init];

    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    [SVProgressHUD show];
    
    [NetRequestManage loadHomeWithUserId:[[NSUserDefaults standardUserDefaults] objectForKey:@"userId"] successBlocks:^(NSData *data, NetRequestManage *loadHome) {
//        NSString *str = [[NSString alloc] initWithData:loadHome.resultData encoding:NSUTF8StringEncoding];
        //nslog(@"loadHome = %@",str);
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:loadHome.resultData options:NSJSONReadingMutableContainers error:nil];
        //nslog(@"loadhomeDic = %@",dic);
        if ([[dic objectForKey:@"errorId"] intValue] == 0) {
            
            if ([dic objectForKey:@"result"]) {
                if ([[[dic objectForKey:@"result"] objectForKey:@"noticeByNow"] isKindOfClass:[NSArray class]]) {
                    if ([[[dic objectForKey:@"result"] objectForKey:@"noticeByNow"] count] > 0) {
                        if (![[[[dic objectForKey:@"result"] objectForKey:@"noticeByNow"] objectAtIndex:0] isKindOfClass:[NSNull class]]) {
                            NSArray *noticeArr = [[dic objectForKey:@"result"] objectForKey:@"noticeByNow"];
                            for (NSDictionary *typeOfNotice in noticeArr) {
                                NoticeModel *model = [[NoticeModel alloc] init];
                                model.title = [_noticeTitleArr objectAtIndex:[[typeOfNotice objectForKey:@"historytype"] intValue]-1];
                                model.imgName = [NSString stringWithFormat:@"rili_icon_%@",[_noticeImgArr objectAtIndex:[[typeOfNotice objectForKey:@"historytype"] intValue]-1]];
                                [_noticeDataArray addObject:model];
                            }
                        }
                       
                    }
                }
            /*
                if (![[[dic objectForKey:@"result"] objectForKey:@"SalonByNow"] isKindOfClass:[NSNull class]]) {
                    
                    NSDictionary *salonDictionary = [[dic objectForKey:@"result"] objectForKey:@"SalonByNow"];
                    [_salon addObject:[salonDictionary objectForKey:@"salonupdatetime"]];
                    [_salon addObject:[salonDictionary objectForKey:@"salonaddress"]];
                    [_salon addObject:[salonDictionary objectForKey:@"salontopic"]];
                    [_salon addObject:[salonDictionary objectForKey:@"salonguest"]];
                    [_salon addObject:[NSString stringWithFormat:@"%@ 📞%@",[salonDictionary objectForKey:@"contactperson"],[salonDictionary objectForKey:@"contactmobile"]]];
                    mapStr = [salonDictionary objectForKey:@"hospitalMapUrl"];
                    
                }
                */
                if (![[[dic objectForKey:@"result"] objectForKey:@"BodycheckBookingByNow"] isKindOfClass:[NSNull class]]) {
                    
                    
                    NSDictionary *bobycheckBooking = [[dic objectForKey:@"result"] objectForKey:@"BodycheckBookingByNow"];
                    [_bodycheckBooking addObject:[bobycheckBooking objectForKey:@"bookingtime"]];
                    [_bodycheckBooking addObject:[bobycheckBooking objectForKey:@"department"]];
                    NSString *hosptName = [[[[NSUserDefaults standardUserDefaults] objectForKey:@"hospitalDic"] objectForKey:[bobycheckBooking objectForKey:@"hospitalid"]] objectForKey:@"hospitalname"];
                    [_bodycheckBooking addObject:hosptName];
                    
                    NSString *doctorName = [[[[NSUserDefaults standardUserDefaults] objectForKey:@"doctorDic"] objectForKey:[bobycheckBooking objectForKey:@"doctorid"]] objectForKey:@"doctorname"];
                    [_bodycheckBooking addObject:doctorName];
                    [_bodycheckBooking addObject:[NSString stringWithFormat:@"%@ 📞%@",[bobycheckBooking objectForKey:@"contactperson"],[bobycheckBooking objectForKey:@"contactmobile"]]];
                    [_bodycheckBooking addObject:[bobycheckBooking objectForKey:@"hospitalAddress"]];
                    mapStr = [bobycheckBooking objectForKey:@"hospitalMapUrl"];
                    
                    
                }
                if (![[[dic objectForKey:@"result"] objectForKey:@"OnlineAppraisal"] isKindOfClass:[NSNull class]]) {
                    
                    
                    NSArray *onlineAppaisalArr = [[dic objectForKey:@"result"] objectForKey:@"OnlineAppraisal"];
                    
                    
                    if (onlineAppaisalArr.count > 0) {
                        
                        _onlineNoticeDic = onlineAppaisalArr[0];
                        
                    }
                    //                _onlineAppraisal = [[dic objectForKey:@"result"] objectForKey:@"OnlineAppraisalByNow"];
                }
                if (![[[dic objectForKey:@"result"] objectForKey:@"TreatBookingByNow"] isKindOfClass:[NSNull class]]) {
                    
                    
                    
                    NSDictionary *treatBooking = [[dic objectForKey:@"result"] objectForKey:@"TreatBookingByNow"];
                    [_treatBooking addObject:[treatBooking objectForKey:@"bookingtime"]];
                    [_treatBooking addObject:[treatBooking objectForKey:@"department"]];
                    NSString *hosptName = [[[[NSUserDefaults standardUserDefaults] objectForKey:@"hospitalDic"] objectForKey:[treatBooking objectForKey:@"hospitalid"]] objectForKey:@"hospitalname"];
                    [_treatBooking addObject:hosptName];
                    
                    NSString *doctorName = [[[[NSUserDefaults standardUserDefaults] objectForKey:@"doctorDic"] objectForKey:[treatBooking objectForKey:@"doctorid"]] objectForKey:@"doctorname"];
                    [_treatBooking addObject:doctorName];
                    [_treatBooking addObject:[NSString stringWithFormat:@"%@ 📞%@",[treatBooking objectForKey:@"contactperson"],[treatBooking objectForKey:@"contactmobile"]]];
                    [_treatBooking addObject:[treatBooking objectForKey:@"hospitalAddress"]];
                    mapStr = [treatBooking objectForKey:@"hospitalMapUrl"];
                    
                    
                }
                
//                if (![[[dic objectForKey:@"result"] objectForKey:@"theLatestRecord"] isKindOfClass:[NSNull class]]) {
//                    
//                    NSDictionary *theLatestRecord = [[dic objectForKey:@"result"] objectForKey:@"theLatestRecord"];
//                    _theLastRecordStr = [theLatestRecord objectForKey:@"recordid"];
//                    _timeStatus = [[dic objectForKey:@"result"] objectForKey:@"TimeStatus"];
//                    _recordStatusStr = [theLatestRecord objectForKey:@"recordstatus"];
//                    _showTimeStr = [[dic objectForKey:@"result"] objectForKey:@"ShowTime"];
//                    
//                }
                
                if (![[[dic objectForKey:@"result"] objectForKey:@"UserRecord"] isKindOfClass:[NSNull class]]) {
                    
                    NSDictionary *userRecord = [[dic objectForKey:@"result"] objectForKey:@"UserRecord"];
                    _theLastRecordStr = [userRecord objectForKey:@"recordid"];
                    _timeStatus = (int)[[dic objectForKey:@"result"] objectForKey:@"TimeStatus"];
                    _recordStatusStr = [userRecord objectForKey:@"recordstatus"];
                    _showTimeStr = [[dic objectForKey:@"result"] objectForKey:@"ShowTime"];
                    _newRecordDic = userRecord;
                    
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
                if (![[[dic objectForKey:@"result"] objectForKey:@"bannerList"] isKindOfClass:[NSNull class]]) {
                    
                    
                    [_bannerArr addObject:[[[dic objectForKey:@"result"] objectForKey:@"bannerList"] lastObject]];
                    [_bannerArr addObjectsFromArray:[[dic objectForKey:@"result"] objectForKey:@"bannerList"]];
                    [_bannerArr addObject:[[[dic objectForKey:@"result"] objectForKey:@"bannerList"] firstObject]];
                    
                }
//                _newscontextArr = [[dic objectForKey:@"result"] objectForKey:@"childCareKnowledgeList"];
//                //nslog(@"newscontext = %@",_newscontextArr);
                
                if (![[[dic objectForKey:@"result"] objectForKey:@"mengClassList"] isKindOfClass:[NSNull class]]) {
                    
                   
                    
                    [_mengClassArr addObjectsFromArray:[[dic objectForKey:@"result"] objectForKey:@"mengClassList"]];
                }
            }
            [SVProgressHUD dismiss];
            [self createInterface];
            
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
        
        
    } andFailedBlocks:^(NSError *error, NetRequestManage *loadHome) {
        //nslog(@"loadHomeError = %@",error.localizedDescription);
        [SVProgressHUD showErrorWithStatus:error.localizedDescription];
        
    }];
    
    
    
}
#pragma mark - 存储图片

/*
 
-(void)saveImage:(NSData *)data{
    
    
    
    NSString *path = NSHomeDirectory();
    
    
    NSString *jpgImagePath = [path stringByAppendingPathComponent:@"Documents/header.jpg"];
    //nslog(@"path = %@     jpgImagePath = %@",path,jpgImagePath);
    NSFileManager *manager = [NSFileManager defaultManager];
    NSString *contents = [[NSBundle mainBundle] pathForResource:jpgImagePath ofType:@"jpg"];
    
    
    if(contents){
        [manager removeItemAtPath:path error:nil];
    }
    [data writeToFile:jpgImagePath atomically:YES];
    
    
    
}
*/






-(void)createInterface{
    
    
    
    if ([self respondsToSelector:@selector(automaticallyAdjustsScrollViewInsets)]) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    NSDictionary *userDic = [[NSUserDefaults standardUserDefaults] objectForKey:@"user"];
    //nslog(@"userDic = %@",userDic);
    LoginUser *user = [[LoginUser alloc] initWithDictionary:userDic];
#pragma mark = 日历按钮
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button1 setBackgroundImage:[UIImage imageNamed:@"shouye_topCalendar"] forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(calendarDetail:) forControlEvents:UIControlEventTouchUpInside];
    button1.frame = CGRectMake(0, 0, 16*Ratio, 16*Ratio);
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button1];
    
    userView = [[UIView alloc] init];

    
    
    userView.backgroundColor = MBColor(239, 67, 153, 1);
    
    [self.view addSubview:userView];
    
    [userView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.top.equalTo(self.view);
        make.height.equalTo(@(80*Ratio));
    }];
    
    
    
    self.navigationItem.title = user.truename;
    
    


   
    
#pragma mark = 头像
   

    _header = [[UIImageView alloc] init];
    _header.backgroundColor = [UIColor yellowColor];
//    header.image = [UIImage imageNamed:@"chouti_07"];
    [[SDImageCache sharedImageCache] clearDisk];
//    [header sd_setImageWithURL:[NSURL URLWithString:[NSString urlStringOfImage:user.headimg]] placeholderImage:([user.sex intValue] == 0)?[UIImage imageNamed:@"shouye_girl"]:[UIImage imageNamed:@"shouye_boy"]];
//
//    if (user.headimg) {
//        if (user.headimg.length > 0) {
//            NSData *imgData = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:[NSString urlStringOfImage:user.headimg]]];
//            [self saveImage:imgData];
//        }else{
//            
//            
//        }
//    }else{
//        
//    }
    
    NSString *path = NSHomeDirectory();
    NSString *jpgImagePath = [path stringByAppendingPathComponent:@"Documents/header.jpg"];
    _header.image = [[UIImage alloc] initWithContentsOfFile:jpgImagePath];
    
    _header.layer.masksToBounds = YES;
    _header.layer.cornerRadius = 25*Ratio;
    _header.layer.borderWidth = 1*Ratio;
    _header.layer.borderColor = MBColor(252, 191, 222, 1).CGColor;
    _header.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
    [tap addTarget:self action:@selector(cameraAction:)];
    [_header addGestureRecognizer:tap];
    [userView addSubview:_header];
    
    [_header mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.and.height.equalTo(@(50*Ratio));
        make.top.equalTo(userView).offset(1*Ratio);
        make.centerX.equalTo(userView);
        
    }];
    __weak typeof(self) weakself = self;
    _imgBlock = ^(UIImage *image){
       weakself.header.image = image;
    };
    
    UIView *cameraBg = [[UIView alloc] init];
    cameraBg.backgroundColor = [UIColor whiteColor];
    cameraBg.layer.masksToBounds = YES;
    cameraBg.layer.cornerRadius = 4*Ratio;
    cameraBg.layer.borderWidth = 1*Ratio;
    cameraBg.layer.borderColor = MBColor(252, 191, 222, 1).CGColor;
    [userView addSubview:cameraBg];
    [cameraBg mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.and.height.equalTo(@(8*Ratio));
        make.left.and.top.equalTo(_header).offset(39*Ratio);
        
    }];
    UIImageView *camera = [[UIImageView alloc] init];
    camera.backgroundColor = [UIColor whiteColor];
    camera.image = [UIImage imageNamed:@"shouye_camera"];
//    camera.layer.masksToBounds = YES;
//    camera.layer.cornerRadius = 6*Ratio;
//    camera.layer.borderWidth = 1*Ratio;
//    camera.layer.borderColor = MBColor(252, 191, 222, 1).CGColor;
    [cameraBg addSubview:camera];
    [camera mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.and.height.equalTo(@(6*Ratio));
        make.center.equalTo(cameraBg);
        
    }];
    
    
#pragma mark = 性别与月龄
    UIView * birthView = [[UIView alloc] init];
    birthView.backgroundColor = MBColor(212, 33, 129, 1);
    birthView.layer.masksToBounds = YES;
    birthView.layer.cornerRadius = 5*Ratio;
    [userView addSubview:birthView];
    [birthView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(85*Ratio, 18*Ratio));
        make.centerX.equalTo(_header);
        make.top.equalTo(_header.mas_bottom).offset(5*Ratio);
    }];
    
    sex = [[UIImageView alloc] init];
    sex.image = [[UIImage imageNamed:[NSString stringWithFormat:@"shouye_icon_%@",user.sex]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

    [birthView addSubview:sex];
    [sex mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(10*Ratio, 10*Ratio));
        make.left.equalTo(birthView).offset(10*Ratio);
        make.centerY.equalTo(birthView);
    }];
    
    
    birthDay = [[UILabel alloc] init];
    birthDay.adjustsFontSizeToFitWidth = YES;
    NSArray *timeArr = [[NSUserDefaults standardUserDefaults] objectForKey:@"monthTime"];
    birthDay.text = [NSString stringWithFormat:@"%d月%d天",[timeArr[0] intValue]*12+[timeArr[1] intValue],[timeArr[2] intValue]];
    birthDay.font = [UIFont yaHeiFontOfSize:10*Ratio];
    birthDay.textColor = [UIColor whiteColor];
    birthDay.textAlignment = NSTextAlignmentCenter;
    [birthView addSubview:birthDay];
    [birthDay mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.height.mas_equalTo(@(14*Ratio));
//        make.width.mas_equalTo(@(60*Ratio));
//        make.left.equalTo(sex.mas_right).offset(5*Ratio);
//         make.centerY.equalTo(birthView);
        make.size.equalTo(birthView);
        make.center.equalTo(birthView);
    }];
    
    
    
    
    [self createMainScroll];
   
}



#pragma mark - 日历详情

-(void)calendarDetail:(UIButton *)button{
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"userRole"] intValue] == 0) {
#pragma mark - 弹出框
        
        
        
        CYRecordAlertView *alert = [self.view.window viewWithTag:9999];
        [alert alertViewWith:@"提示！" andDetailTitle:@"您需要购买会员服务才能查看日历哦~"  andButtonTitle:@"2"];
        [alert layoutSubviews];
        alert.payBlocks = ^{
            
            BuyViewController *buyVC = [[BuyViewController alloc] init];
            
            [self.navigationController pushViewController:buyVC animated:YES];
        };
        
        //nslog(@"您需要续费才能查看历史消息记录哦 ~");
    }else{
        CalendarViewController *calen = [[CalendarViewController alloc] init];
        [self.navigationController pushViewController:calen animated:YES];
    }
   
}


#pragma mark - camera与相册选择

-(void)cameraAction:(UITapGestureRecognizer *)tap{
    
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"userRole"] intValue] != 0) {
        UserHeaderViewController *userHeader = [[UserHeaderViewController alloc] init];
        
        [userHeader changeHeaderBlock:_imgBlock];
        self.navigationController.navigationBarHidden = NO;
        [self.navigationController pushViewController:userHeader animated:YES];
    }

}




-(void)createMainScroll{
    UIScrollView *sc = [[UIScrollView alloc] init];
    [self.view addSubview:sc];
    [sc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(userView.mas_bottom);
        make.left.and.right.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-49);
    
        
    }];
    sc.bounces = YES;
    sc.backgroundColor = MBColor(226, 253, 255, 1);

    contentView = [[UIView alloc] init];
    contentView.backgroundColor = MBColor(226, 253, 255, 1);
    [sc addSubview:contentView];
    
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.equalTo(sc);
        make.width.equalTo(sc);
    }];
    
    _selectedDate = [[UILabel alloc] init];
    _selectedDate.font = [UIFont yaHeiFontOfSize:8*Ratio];
    _selectedDate.text = [[NSString stringWithFormat:@"%@",[[NSDate date] dateByAddingTimeInterval:60*60*8]] substringToIndex:10];
    _selectedDate.textColor = MBColor(153, 153, 153, 1);
    
    _selectedDate.textAlignment = NSTextAlignmentCenter;
    [contentView addSubview:_selectedDate];
    
    
    [_selectedDate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(contentView);
        make.top.equalTo(contentView).offset(8*Ratio);
        make.size.mas_equalTo(CGSizeMake(65*Ratio, 16*Ratio));
        
    }];
    
    UIImageView *calendarBg = [[UIImageView alloc] init];
    calendarBg.image = [UIImage imageNamed:@"shouye_rili"];
    [contentView addSubview:calendarBg];
    [calendarBg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.top.equalTo(contentView);
        make.height.equalTo(@(83*Ratio));
    }];
    [contentView sendSubviewToBack:calendarBg];
    
    
    self.calendar = [JTCalendar new];
    self.calendar.calendarAppearance.isWeekMode = YES;
    [self.calendar setCurrentDateSelected:[NSDate date]];

    [self.calendar setCurrentDate:[NSDate date]];
    
    //这句不能注销  原因是masonry
    self.calendarContentView = [[JTCalendarContentView alloc] initWithFrame:CGRectMake(24*Ratio, _selectedDate.frame.origin.y + _selectedDate.frame.size.height+(20*Ratio), (320*Ratio)- (48*Ratio), 50*Ratio)];
   
    [contentView addSubview:self.calendarContentView];
    

    {
        self.calendar.calendarAppearance.calendar.firstWeekday = 2; // Sunday == 1, Saturday == 7
        self.calendar.calendarAppearance.dayCircleRatio = 7. / 10.;
        self.calendar.calendarAppearance.ratioContentMenu = 1.;
        self.calendar.calendarAppearance.isWeekMode = YES;
    }
//    self.calendarContentView.backgroundColor = [UIColor redColor];
    
    [self.calendar setContentView:self.calendarContentView];
    
    [self.calendar setDataSource:self];
    
    
    [_calendarContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(69*Ratio));
        make.left.equalTo(contentView).offset(24*Ratio);
        make.right.equalTo(contentView).offset(-24*Ratio);
        make.top.equalTo(_selectedDate.mas_bottom).offset(-6*Ratio);
    }];

    [self.view layoutIfNeeded];
    
    [self.calendar setCurrentDate:[NSDate date]];
#pragma mark = 日历的消息信息提示 createCalendarDataTableView

    calendarDataTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, _calendarContentView.frame.origin.y + _calendarContentView.frame.size.height, contentView.frame.size.width, 100) style:UITableViewStylePlain];
    calendarDataTableView.tag = 1000;
    calendarDataTableView.dataSource = self;
    calendarDataTableView.delegate = self;
    calendarDataTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    calendarDataTableView.showsVerticalScrollIndicator = NO;
    [calendarDataTableView registerClass:[TopViewCalendarTableViewCell class] forCellReuseIdentifier:@"identi"];

    [contentView addSubview:calendarDataTableView];
    calendarDataTableView.bounces = NO;
    
    
    
    [calendarDataTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(contentView);
        make.top.equalTo(_calendarContentView.mas_bottom).offset(5);
        
    }];
    
    [calendarDataTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(45*Ratio*[_noticeDataArray count]));
    }];
#pragma mark = 沙龙
    
    salonSC = [[UIScrollView alloc] init];
//    salonSC.backgroundColor = [UIColor redColor];
    salonSC.delegate = self;
    
    [contentView addSubview:salonSC];
    [salonSC mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(calendarDataTableView.mas_bottom).offset(5*Ratio);
        make.left.and.right.equalTo(contentView);
        make.height.equalTo(@(115*Ratio));
    }];
    salonSC.pagingEnabled = YES;
//    salonSC.bounces = NO;
    salonSC.showsHorizontalScrollIndicator = NO;
    UIView *salonContentView = [[UIView alloc] init];
    [salonSC addSubview:salonContentView];
    [salonContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(salonSC);
        make.height.equalTo(salonSC);
    }];
    
    
    UIImageView *lastImage = nil;
    for (int i=0; i<[_bannerArr count]; i++) {
        UIImageView *imageV = [[UIImageView alloc] init];
        imageV.tag = 1255+i;
        imageV.backgroundColor = MBColor(arc4random()%256/255.0, arc4random()%256/255.0, arc4random()%256/255.0, 1);

//        imageV.image = [UIImage imageNamed:[NSString stringWithFormat:@"doctor_%d",i]];
        [imageV sd_setImageWithURL:[NSURL URLWithString:[NSString urlStringOfImage:[_bannerArr[i] objectForKey:@"bannerimg"]]] placeholderImage:[UIImage imageNamed:@"shouye_morentu"]];

        imageV.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(salonAction:)];
        [imageV addGestureRecognizer:tap];
        [salonContentView addSubview:imageV];
        [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.and.bottom.equalTo(salonContentView);
            make.width.equalTo(salonSC);
            if (lastImage == nil) {
                
                make.left.equalTo(salonContentView);

            }else{
                
                make.left.equalTo(lastImage.mas_right);

            }


        }];
        
        
//         [self.view layoutIfNeeded];

                
        lastImage = imageV;
    }
    
//    UIImageView *img = [[UIImageView alloc] init];
//    img.backgroundColor = MBColor(arc4random()%256/255.0, arc4random()%256/255.0, arc4random()%256/255.0, 1);
//    [img sd_setImageWithURL:[NSURL URLWithString:[NSString urlStringOfImage:[_bannerArr[_bannerArr.count - 1] objectForKey:@"bannerimg"]]] placeholderImage:[UIImage imageNamed:@"cover_01"]];
//    [salonContentView addSubview:img];
//    [img mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.and.bottom.equalTo(salonContentView);
//        make.width.equalTo(salonSC);
//        make.right.equalTo(salonContentView.mas_left);
//
//    }];
//    UIImageView *img1 = [[UIImageView alloc] init];
//    img1.backgroundColor = MBColor(arc4random()%256/255.0, arc4random()%256/255.0, arc4random()%256/255.0, 1);
//    [img1 sd_setImageWithURL:[NSURL URLWithString:[NSString urlStringOfImage:[_bannerArr[0] objectForKey:@"bannerimg"]]] placeholderImage:[UIImage imageNamed:@"cover_01"]];
//    [salonContentView addSubview:img1];
//    [img1 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.and.bottom.equalTo(salonContentView);
//        make.width.equalTo(salonSC);
//        make.left.equalTo(salonContentView.mas_right);
//        
//    }];
    
    [salonContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(lastImage);
    }];
    [self.view layoutIfNeeded];
    [salonSC setContentOffset:CGPointMake(320*Ratio, 0) animated:NO];

#pragma mark = 沙龙页码
    
    
    _pageControll = [[UIPageControl alloc] init];
    _pageControll.currentPageIndicatorTintColor = MainColor;
//    _pageControll.backgroundColor = [UIColor blueColor];
    _pageControll.pageIndicatorTintColor = MBColor(102, 102, 102, 1);
    if (_bannerArr.count > 2) {
        _pageControll.numberOfPages = _bannerArr.count-2;
    }
    [contentView addSubview:_pageControll];
    [_pageControll mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(50, 3));
        make.bottom.equalTo(salonSC).offset(-15);
        make.right.equalTo(contentView).offset(-15);
    }];
    [salonSC bringSubviewToFront:_pageControll];
    
#pragma mark = 观察要点
    UIView *lastObserve = nil;
    for (int i=0; i<(_mengClassArr.count + 2); i++) {
        
        UIView *observe = [[UIView alloc] init];
        observe.backgroundColor = MBColor(255, 255, 255, 1);
        observe.userInteractionEnabled = YES;
        observe.tag = 1250+i;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(observeAction:)];
        [observe addGestureRecognizer:tap];
        [contentView addSubview:observe];
        [observe mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.and.right.equalTo(contentView);
            make.height.equalTo(@(56*Ratio));
            
            if (i==0) {
                
                make.top.equalTo(salonSC.mas_bottom).offset(5);

            }else{
                
                make.top.equalTo(lastObserve.mas_bottom).offset(5);

            }
        }];
        lastObserve = observe;
        UIImageView *observeIV = [[UIImageView alloc] init];
        observeIV.image = [UIImage imageNamed:@"shouye_icon"];
        [observe addSubview:observeIV];
        [observeIV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(observe).offset(10*Ratio);
            make.top.equalTo(observe).offset(10*Ratio);
            make.size.mas_equalTo(CGSizeMake(14.5*Ratio, 16*Ratio));
            
        }];
        UILabel *observeTitle = [[UILabel alloc] init];
//        ((i==1)?@"育儿小课堂":@"涨知识")
//        ((i==1)?@"萌课堂":@"萌宝宝医生")
        observeTitle.text = (i == 0)?@"观察要点":(i == (_mengClassArr.count + 1)?@"萌宝宝医生":@"萌课堂");
        observeTitle.textColor = MainColor;
        observeTitle.font = [UIFont yaHeiFontOfSize:9*Ratio];
        [observe addSubview:observeTitle];
        [observeTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(100*Ratio, 10*Ratio));
            make.left.equalTo(observeIV.mas_right).offset(5*Ratio);
            make.top.equalTo(observe).offset(14*Ratio);
            
        }];
        UILabel *observeMessage = [[UILabel alloc] init];
//        ((i==1)?([[_newscontextArr objectAtIndex:0] objectForKey:@"newstitle"]):@"萌妈，你可以为萌宝选择专属医生")
        observeMessage.text = (i == 0)?@"宝妈，有注意到萌宝的这些变化吗？":(i == (_mengClassArr.count + 1)?@"萌妈，你可以为萌宝选择专属医生":([[_mengClassArr objectAtIndex:i-1] objectForKey:@"classtitle"]));
       
        observeMessage.textColor = MBColor(51, 51, 51, 1);
        observeMessage.font = [UIFont yaHeiFontOfSize:13*Ratio];
        [observe addSubview:observeMessage];
        [observeMessage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(observe).offset(28*Ratio);
            make.left.equalTo(observe).offset(10*Ratio);
            make.size.mas_equalTo(CGSizeMake(300*Ratio, 14*Ratio));
        }];

    }
    
    
#pragma mark = 长知识
    
    
    
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.bottom.equalTo(lastObserve).offset(5*Ratio);
    }];


    
}
#pragma mark - 沙龙

-(void)salonAction:(UITapGestureRecognizer *)tap{
    
//    SalonDetailViewController *salonVC = [[SalonDetailViewController alloc] init];
//    salonVC.num = (int)tap.view.tag - 1255;
//    [self.navigationController pushViewController:salonVC animated:YES];
    if ([_bannerArr objectAtIndex:tap.view.tag-1255]) {
        BannerViewController *bavc = [[BannerViewController alloc] init];
        bavc.bannerUrl = [[_bannerArr objectAtIndex:tap.view.tag-1255] objectForKey:@"bannerurl"];
        bavc.titleStr = [[_bannerArr objectAtIndex:tap.view.tag-1255] objectForKey:@"bannertitle"];
        bavc.contentHtmlStr = [[_bannerArr objectAtIndex:tap.view.tag-1255] objectForKey:@"bannercontext"];
        
        self.navigationController.navigationBarHidden = NO;
        [self.navigationController pushViewController:bavc animated:YES];
        
    }
    
}
#pragma mark - 观察要点

-(void)observeAction:(UITapGestureRecognizer *)tap{
    UIView *view = tap.view;
    if (view.tag == 1250) {
        //nslog(@"点击观察要点");
        ObserveViewController *obser = [[ObserveViewController alloc] init];
        self.navigationController.navigationBarHidden = NO;
        [self.navigationController pushViewController:obser animated:YES];
    }else if(view.tag == 1250+ (_mengClassArr.count + 1)){
        
        
        YLZYViewController *obser = [[YLZYViewController alloc] init];
        self.navigationController.navigationBarHidden = NO;
        [self.navigationController pushViewController:obser animated:YES];
        
        
        
        
       
    }else{
        
        NewsContextViewController *newContent = [[NewsContextViewController alloc] init];
        if (_mengClassArr) {
            if (_mengClassArr.count > 0) {
                
                newContent.contentHtmlStr = [[_mengClassArr objectAtIndex:view.tag - 1251] objectForKey:@"classcontext"];
                
            }
        }
        newContent.isFirstUnit = (view.tag == 1251)?YES:NO;
        self.navigationController.navigationBarHidden = NO;
        [self.navigationController pushViewController:newContent animated:YES];
        
        
    }
   
    
}

#pragma mark - scrollview代理相关

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    if (scrollView == salonSC) {
        
        if (scrollView.contentOffset.x == 0) {
            
            [salonSC setContentOffset:CGPointMake((_bannerArr.count-2)*320*Ratio, 0) animated:NO];
            _pageControll.currentPage = _bannerArr.count - 1-1-1;

            
        }else if (scrollView.contentOffset.x == (_bannerArr.count-1)*320*Ratio){
            [salonSC setContentOffset:CGPointMake(320*Ratio, 0) animated:NO];
            _pageControll.currentPage = 0;


        }else{
            
            _pageControll.currentPage = (scrollView.contentOffset.x-320*Ratio)/scrollView.frame.size.width;

        }
        
        
    }
    
    
}

//-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
//    if (scrollView == salonSC) {
//        
//        if (scrollView.contentOffset.x < -50) {
//            
//            //nslog(@"scrollview.contentoffset.x = %f",scrollView.contentOffset.x);
//            [salonSC setContentOffset:CGPointMake(320*Ratio, 0) animated:NO];
//            
//        }
//    }
//}



-(void)scrollViewDidScroll:(UIScrollView *)scrollView{

    
    
    if (scrollView == salonSC) {
        
//        //nslog(@"%@",NSStringFromCGPoint(salonSC.contentOffset));
        if (scrollView.contentOffset.x == 0) {
            
            [salonSC setContentOffset:CGPointMake((_bannerArr.count-2)*320*Ratio, 0) animated:NO];
            
            salonSC.contentOffset = CGPointMake((_bannerArr.count-2)*320*Ratio, 0);
            _pageControll.currentPage = _bannerArr.count - 1-1-1;
            
            
        }else if (scrollView.contentOffset.x == (_bannerArr.count-1)*320*Ratio){
            
            [salonSC setContentOffset:CGPointMake(320*Ratio, 0) animated:NO];
            _pageControll.currentPage = 0;
            
        }else{
            
            _pageControll.currentPage = (scrollView.contentOffset.x-320*Ratio)/scrollView.frame.size.width;
            
        }
        
    }
}


#pragma mark - tableView代理相关

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *str = @"identi";
    
    TopViewCalendarTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str forIndexPath:indexPath];
    NoticeModel *model = _noticeDataArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell makeCellByLeftImageName:model.imgName withTitle:model.title withDetailTitle:nil withIsRight:YES];
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

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _noticeDataArray.count;//用户有几个消息通知
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45*Ratio;//用户有几个消息通知
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    @[@"tijiao",@"zhuanzhen",@"pinggu",@"shalong",@"tijian"];
    
    NoticeModel *model = _noticeDataArray[indexPath.row];
    
    if ([model.imgName isEqualToString:[NSString stringWithFormat:@"rili_icon_%@",_noticeImgArr[0]]]) {
        
        
        NewRecordViewController *newRecord = [[NewRecordViewController alloc] init];
        newRecord.month = [[[NSUserDefaults standardUserDefaults] objectForKey:@"month"] intValue];
        if (![_newRecordDic isKindOfClass:[NSNull class]]) {
            newRecord.recordStar = [[RecordStarRecordStar alloc] initWithDictionary:_newRecordDic];
        }
        newRecord.month = [[[NSUserDefaults standardUserDefaults] objectForKey:@"month"] intValue];
        newRecord.isHiddenSubmit = NO;
        newRecord.canChangeData = YES;
        newRecord.theLastRecordStr =_theLastRecordStr;
        newRecord.showTime = _showTimeStr;
        newRecord.recordStatus = _recordStatusStr;
        newRecord.timeStatus = _timeStatus;
        [self.navigationController pushViewController:newRecord animated:YES];
    }else if ([model.imgName isEqualToString:[NSString stringWithFormat:@"rili_icon_%@",_noticeImgArr[1]]]){
       
        SalonViewController *salonVC = [[SalonViewController alloc] init];
        
        salonVC.titleStr = @"绿色通道";
        salonVC.arrr = _treatBooking;
        salonVC.titleArr = @[@"预约时间：",@"预约科室：",@"预约医院：",@"预约医生：",@"接待人员：",@"医院地址："];
        salonVC.imgStr = mapStr;
        [self.navigationController pushViewController:salonVC animated:YES];
        
        
       
        
    }else if ([model.imgName isEqualToString:[NSString stringWithFormat:@"rili_icon_%@",_noticeImgArr[2]]]){
        
        
        if (_onlineNoticeDic) {
            
            OnlineAppraisalOnlineAppraisal *online = [[OnlineAppraisalOnlineAppraisal alloc] initWithDictionary:_onlineNoticeDic];
            NoticeCommentViewController *nvc = [[NoticeCommentViewController alloc] init];
            nvc.currentOnline = online;
            nvc.imgData = _imagDataArr;
            [self.navigationController pushViewController:nvc animated:YES];
            
        }
        
        
    }else if ([model.imgName isEqualToString:[NSString stringWithFormat:@"rili_icon_%@",_noticeImgArr[3]]]){
        
        SalonViewController *salonVC = [[SalonViewController alloc] init];
        salonVC.titleStr = @"育儿沙龙";
        salonVC.arrr = _salon;
        salonVC.titleArr = @[@"时间：",@"地址：",@"主题：",@"主讲人：",@"接待人员："];
        salonVC.imgStr = mapStr;
        [self.navigationController pushViewController:salonVC animated:YES];
        
    }else if ([model.imgName isEqualToString:[NSString stringWithFormat:@"rili_icon_%@",_noticeImgArr[4]]]){
        
        SalonViewController *salonVC = [[SalonViewController alloc] init];
        
        salonVC.titleStr = @"体检";
        salonVC.arrr = _bodycheckBooking;
        salonVC.titleArr = @[@"预约时间：",@"预约科室：",@"预约医院：",@"预约医生：",@"接待人员：",@"医院地址："];
        salonVC.imgStr = mapStr;
        [self.navigationController pushViewController:salonVC animated:YES];
        
    }

}
#pragma mark - JTCalendarDataSource

- (BOOL)calendarHaveEvent:(JTCalendar *)calendar date:(NSDate *)date
{
//        return (rand() % 2) == 1;
//    //nslog(@"date = %@",date);
    NSString *dateStr = [[NSString stringWithFormat:@"%@",[date dateByAddingTimeInterval:60*60*8]] substringToIndex:10];
    
    if ([_noticeDateArr containsObject:dateStr]) {
        return 1;
    }else{
        return 0;
    }
    
}

- (void)calendarDidDateSelected:(JTCalendar *)calendar date:(NSDate *)date
{
    
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"userRole"] intValue] == 0) {
        
    }else{
        date = [date dateByAddingTimeInterval:60*60*8];
        //nslog(@"Date: %@", date);
        NSString *dateStr = [NSString stringWithFormat:@"%@",date];
        dateStr = [dateStr substringToIndex:10];
        NSArray *arr = [dateStr componentsSeparatedByString:@"-"];
        _selectedDate.text = [NSString stringWithFormat:@"%@年%@月%@日",arr[0],arr[1],arr[2]];
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
        [SVProgressHUD show];
        [NetRequestManage clickDateTimeWithChooseTime:dateStr andUserId:[[NSUserDefaults standardUserDefaults] objectForKey:@"userId"] successBlocks:^(NSData *data, NetRequestManage *clickDateTime) {
//            NSString *str = [[NSString alloc] initWithData:clickDateTime.resultData encoding:NSUTF8StringEncoding];
            //nslog(@"clickDateTime = %@",str);
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:clickDateTime.resultData options:NSJSONReadingMutableContainers error:nil];
            
            if ([[dic objectForKey:@"errorId"] intValue] == 0) {
                [SVProgressHUD dismiss];
                
                if ([[dic objectForKey:@"result"] objectForKey:@"notice"]) {
                    if ([[[dic objectForKey:@"result"] objectForKey:@"notice"] count] > 0) {
                        if (![[[[dic objectForKey:@"result"] objectForKey:@"notice"] objectAtIndex:0] isKindOfClass:[NSNull class]]) {
                            [_noticeDataArray removeAllObjects];
                            NSArray *noticeArr = [[dic objectForKey:@"result"] objectForKey:@"notice"];
                            for (NSDictionary *typeOfNotice in noticeArr) {
                                NoticeModel *model = [[NoticeModel alloc] init];
                                model.title = [_noticeTitleArr objectAtIndex:[[typeOfNotice objectForKey:@"historytype"] intValue]-1];
                                model.imgName = [NSString stringWithFormat:@"rili_icon_%@",[_noticeImgArr objectAtIndex:[[typeOfNotice objectForKey:@"historytype"] intValue]-1]];
                                [_noticeDataArray addObject:model];
                            }
                        }

                        
                        
                        
                        if (![[[dic objectForKey:@"result"] objectForKey:@"SalonNotice"] isKindOfClass:[NSNull class]]) {
                            [_salon removeAllObjects];
                            NSDictionary *salonDictionary = [[dic objectForKey:@"result"] objectForKey:@"SalonNotice"];
                            [_salon addObject:[salonDictionary objectForKey:@"salonupdatetime"]];
                            [_salon addObject:[salonDictionary objectForKey:@"salonaddress"]];
                            [_salon addObject:[salonDictionary objectForKey:@"salontopic"]];
                            [_salon addObject:[salonDictionary objectForKey:@"salonguest"]];
                            [_salon addObject:[NSString stringWithFormat:@"%@ 📞%@",[salonDictionary objectForKey:@"contactperson"],[salonDictionary objectForKey:@"contactmobile"]]];
                            
                            mapStr = [salonDictionary objectForKey:@"hospitalMapUrl"];
                            
                        }
                        
                        if (![[[dic objectForKey:@"result"] objectForKey:@"BodycheckBookingNotice"] isKindOfClass:[NSNull class]]) {
                            
                            
                            NSDictionary *bobycheckBooking = [[dic objectForKey:@"result"] objectForKey:@"BodycheckBookingNotice"];
                            [_bodycheckBooking removeAllObjects];

                            [_bodycheckBooking addObject:[bobycheckBooking objectForKey:@"bookingtime"]];
                            [_bodycheckBooking addObject:[bobycheckBooking objectForKey:@"department"]];
                            NSString *hosptName = [[[[NSUserDefaults standardUserDefaults] objectForKey:@"hospitalDic"] objectForKey:[bobycheckBooking objectForKey:@"hospitalid"]] objectForKey:@"hospitalname"];
                            [_bodycheckBooking addObject:(hosptName)?hosptName:@""];
                            
                            NSString *doctorName = [[[[NSUserDefaults standardUserDefaults] objectForKey:@"doctorDic"] objectForKey:[bobycheckBooking objectForKey:@"doctorid"]] objectForKey:@"doctorname"];
                            [_bodycheckBooking addObject:doctorName];
                            [_bodycheckBooking addObject:[NSString stringWithFormat:@"%@ 📞%@",[bobycheckBooking objectForKey:@"contactperson"],[bobycheckBooking objectForKey:@"contactmobile"]]];
                            [_bodycheckBooking addObject:[bobycheckBooking objectForKey:@"hospitalAddress"]];
                            mapStr = [bobycheckBooking objectForKey:@"hospitalMapUrl"];
                            
                            
                        }
                        if (![[[dic objectForKey:@"result"] objectForKey:@"OnlineAppraisal"] isKindOfClass:[NSNull class]]) {
                            
                            
                            NSArray *onlineAppaisalArr = [[dic objectForKey:@"result"] objectForKey:@"OnlineAppraisal"];
                            
                            
                            if (onlineAppaisalArr.count > 0) {
                                
                                _onlineNoticeDic = onlineAppaisalArr[0];
                                
                            }
                            //                _onlineAppraisal = [[dic objectForKey:@"result"] objectForKey:@"OnlineAppraisalByNow"];
                        }
                        if (![[[dic objectForKey:@"result"] objectForKey:@"TreatNotice"] isKindOfClass:[NSNull class]]) {
                            
                            
                            [_treatBooking removeAllObjects];
                            NSDictionary *treatBooking = [[dic objectForKey:@"result"] objectForKey:@"TreatNotice"];
                            [_treatBooking addObject:[treatBooking objectForKey:@"bookingtime"]];
                            [_treatBooking addObject:[treatBooking objectForKey:@"department"]];
                            NSString *hosptName = [[[[NSUserDefaults standardUserDefaults] objectForKey:@"hospitalDic"] objectForKey:[treatBooking objectForKey:@"hospitalid"]] objectForKey:@"hospitalname"];
                            [_treatBooking addObject:hosptName];
                            
                            NSString *doctorName = [[[[NSUserDefaults standardUserDefaults] objectForKey:@"doctorDic"] objectForKey:[treatBooking objectForKey:@"doctorid"]] objectForKey:@"doctorname"];
                            [_treatBooking addObject:doctorName];
                            [_treatBooking addObject:[NSString stringWithFormat:@"%@ 📞%@",[treatBooking objectForKey:@"contactperson"],[treatBooking objectForKey:@"contactmobile"]]];
                            [_treatBooking addObject:[treatBooking objectForKey:@"hospitalAddress"]];
                            mapStr = [treatBooking objectForKey:@"hospitalMapUrl"];
                            
                            
                        }
                        if (![[[dic objectForKey:@"result"] objectForKey:@"UserRecord"] isKindOfClass:[NSNull class]]) {
                            
                            NSDictionary *userRecord = [[dic objectForKey:@"result"] objectForKey:@"UserRecord"];
                            _theLastRecordStr = [userRecord objectForKey:@"recordid"];
                            _timeStatus = (int)[[dic objectForKey:@"result"] objectForKey:@"TimeStatus"];
                            _recordStatusStr = [userRecord objectForKey:@"recordstatus"];
                            _showTimeStr = [[dic objectForKey:@"result"] objectForKey:@"ShowTime"];
                            _newRecordDic = userRecord;
                            
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
                        
                        
                    }else{
                        //nslog(@"您这一天没有通知哦！");
                        [_noticeDataArray removeAllObjects];
                        
                        
                        CYRecordAlertView *alert = [self.view.window viewWithTag:9999];
                        [alert alertViewWith:nil andDetailTitle:@"没有任务安排哦！"  andButtonTitle:@"0"];
                        [alert layoutSubviews];
                        
                        
                        
                        
                        
                    }
                }else{
                    //nslog(@"您这一天没有通知哦！");
                    [_noticeDataArray removeAllObjects];
                    
                    CYRecordAlertView *alert = [self.view.window viewWithTag:9999];
                    [alert alertViewWith:nil andDetailTitle:@"没有任务安排哦！"  andButtonTitle:@"0"];
                    [alert layoutSubviews];
                    
                    
                    
                    
                }
                
                
                
                
                [[NSOperationQueue mainQueue] addOperationWithBlock:^{
#pragma mark = 更新日历信息提示
                    [UIView animateWithDuration:0.5 animations:^{
                        [calendarDataTableView mas_updateConstraints:^(MASConstraintMaker *make) {
                            make.height.equalTo(@(45*Ratio*[_noticeDataArray count]));
                        }];
                        [calendarDataTableView reloadData];
                        [contentView layoutIfNeeded];
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
            
        } andFailedBlocks:^(NSError *error, NetRequestManage *clickDateTime) {
            //nslog(@"error = %@",error.localizedDescription);
            [SVProgressHUD showErrorWithStatus:error.localizedDescription];
        }];
        
        
        

    }
    
    
    
    
}





@end
