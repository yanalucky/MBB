//
//  BuyOrderViewController.m
//  BabyDemo
//
//  Created by 陈彦 on 16/7/12.
//  Copyright © 2016年 elsa. All rights reserved.
//

#import "BuyOrderViewController.h"
#import "OrderViewController.h"
#import "ServeListViewController.h"

#import "Order.h"
#import "DataSigner.h"
#import <AlipaySDK/AlipaySDK.h>

#import "ServerConfigDoctorList.h"
#import "ServerConfigHospitalList.h"


#import "BuyServeListViewController.h"

#import "AppDelegate.h"
#import "FillInfoViewController.h"

#import "BuyDoctorViewController.h"


#import "LeftViewController.h"
#import "FirPageViewController.h"
#import "RickyNavViewController.h"


//#import "NetRequestManage.h"

#import "AddOtherViewController.h"

#import "PaySuccessViewController.h"


@interface BuyOrderViewController (){
    
    int longTime;
    
    
    NSString *_userRoleStr;
    int howMuch;
}


@end

@implementation BuyOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    
    _userRoleStr = [[NSUserDefaults standardUserDefaults] objectForKey:@"userRole"];
    [self createInterface];
    
    // Do any additional setup after loading the view.
}


-(void)returnBtn:(UIButton *)button{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
-(void)createInterface{
    
    
//#pragma mark =  左边按钮
//    
//    
//    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//    //    [button setImage:[UIImage imageNamed:@"shouye_top_left"] forState:UIControlStateNormal];
//    [button setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
//    button.selected = NO;
//    [button addTarget:self action:@selector(returnBtn:) forControlEvents:UIControlEventTouchUpInside];
//    button.frame = CGRectMake(0, 0, 10*Ratio, 18*Ratio);
//    
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];

    
    
    NSString *timeLongStr = [[_infoStr componentsSeparatedByString:@","] lastObject];
    
    NSString *path0 = [[NSBundle mainBundle] pathForResource:@"Menu" ofType:@"plist"];
    NSDictionary *menuDic = [NSDictionary dictionaryWithContentsOfFile:path0];
    NSString *timeOfMenu = [menuDic objectForKey:timeLongStr];
    NSArray *timeAr = [timeOfMenu componentsSeparatedByString:@","];
    longTime = [[timeAr lastObject] intValue];
    
    self.title = @"确认订单";
    
#pragma mark = 小标题
    UILabel *detailTitle = [[UILabel alloc] init];
    NSString *serveTimeStr = nil;

    if (longTime == 6) {
        serveTimeStr = @"线上半年服务";
    }else if (longTime == 12){
        serveTimeStr = @"线上一年服务";
    }else if (longTime == 1){
        serveTimeStr = @"线上一个月服务";
    }else if (longTime == 2){
        serveTimeStr = @"线上两个月服务";
    }else if (longTime == 3){
        serveTimeStr = @"线上三个月服务";
    }else if (longTime == 4){
        serveTimeStr = @"线上四个月服务";
    }else if (longTime == 5){
        serveTimeStr = @"线上五个月服务";
    }else{
        serveTimeStr = @"线上服务";
    }
    [detailTitle makeLabelWithText:serveTimeStr andTextColor:MBColor(102, 103, 104, 1) andFont:[UIFont yaHeiFontOfSize:15*Ratio]];
    detailTitle.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:detailTitle];
    [detailTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).offset(5*Ratio);
        make.size.mas_equalTo(CGSizeMake(300*Ratio, 20*Ratio));
    }];
    
    
    UILabel *line0 = [[UILabel alloc] init];
    line0.backgroundColor = MBColor(225, 253, 255, 1);
    [self.view addSubview:line0];
    [line0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.view);
        make.centerX.equalTo(self.view);
        make.top.equalTo(detailTitle.mas_bottom).offset(8*Ratio);
        make.height.equalTo(@(5*Ratio));
    }];
#pragma mark = 专属医生
    
    UILabel *lin0 = [[UILabel alloc] init];
    lin0.backgroundColor = MBColor(153, 244, 237, 1);
    [self.view addSubview:lin0];
    [lin0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(2*Ratio, 14*Ratio));
        make.left.equalTo(self.view).offset(10*Ratio);
        make.top.equalTo(line0.mas_bottom).offset(10*Ratio);
    }];
    
    UILabel *unit0 = [[UILabel alloc] init];
    [unit0 makeLabelWithText:@"专属医生" andTextColor:MBColor(51, 52, 53, 1) andFont:[UIFont yaHeiFontOfSize:14*Ratio]];
    [self.view addSubview:unit0];
    [unit0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lin0).offset(8*Ratio);
        make.top.equalTo(line0.mas_bottom).offset(10*Ratio);
        make.size.mas_equalTo(CGSizeMake(60*Ratio, 15*Ratio));
    }];
    
    UILabel *doctorName = [[UILabel alloc] init];
    [doctorName makeLabelWithText:_doctor.doctorname andTextColor:MBColor(102, 103, 104, 1) andFont:[UIFont yaHeiFontOfSize:12*Ratio]];
    [self.view addSubview:doctorName];
    [doctorName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(unit0);
        make.top.equalTo(unit0.mas_bottom).offset(13*Ratio);
        make.size.mas_equalTo(CGSizeMake(60*Ratio, 15*Ratio));
    }];
    
    UILabel *hospitalLabel = [[UILabel alloc] init];
    ServerConfigHospitalList *hospital = [[ServerConfigHospitalList alloc] initWithDictionary:[[[NSUserDefaults standardUserDefaults] objectForKey:@"hospitalDic"] objectForKey:_doctor.hospitalid]];
    [hospitalLabel makeLabelWithText:hospital.hospitalname andTextColor:MBColor(102, 103, 104, 1) andFont:[UIFont yaHeiFontOfSize:12*Ratio]];
    hospitalLabel.numberOfLines = 0;
    [self.view addSubview:hospitalLabel];
    [hospitalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(doctorName);
        make.top.equalTo(doctorName.mas_bottom).offset(5*Ratio);
        make.size.mas_equalTo(CGSizeMake(285*Ratio, 38*Ratio));
    }];
    
    UILabel *line1 = [[UILabel alloc] init];
    line1.backgroundColor = MBColor(225, 253, 255, 1);
    [self.view addSubview:line1];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.view);
        make.centerX.equalTo(self.view);
        make.top.equalTo(hospitalLabel.mas_bottom).offset(5*Ratio);
        make.height.equalTo(@(5*Ratio));
    }];
    
#pragma mark = 服务清单
    UILabel *lin1 = [[UILabel alloc] init];
    lin1.backgroundColor = MBColor(153, 244, 237, 1);
    [self.view addSubview:lin1];
    [lin1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(2*Ratio, 14*Ratio));
        make.left.equalTo(self.view).offset(10*Ratio);
        make.top.equalTo(line1.mas_bottom).offset(10*Ratio);
    }];
    UILabel *unit1 = [[UILabel alloc] init];
    [unit1 makeLabelWithText:@"服务清单" andTextColor:MBColor(51, 52, 53, 1) andFont:[UIFont yaHeiFontOfSize:13*Ratio]];
    [self.view addSubview:unit1];
    [unit1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lin1).offset(8*Ratio);
        make.top.equalTo(line1.mas_bottom).offset(10*Ratio);
        make.size.mas_equalTo(CGSizeMake(60*Ratio, 15*Ratio));
    }];
    
    UILabel *list0 = [[UILabel alloc] init];
    [list0 makeLabelWithText:[NSString stringWithFormat:@"线上评估%d次",longTime] andTextColor:MBColor(102, 103, 104, 1) andFont:[UIFont yaHeiFontOfSize:13*Ratio]];
    [self.view addSubview:list0];
    [list0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(20*Ratio);
        make.top.equalTo(unit1.mas_bottom).offset(12*Ratio);
        make.size.mas_equalTo(CGSizeMake(100*Ratio, 20*Ratio));
    }];
    
    UILabel *list1 = [[UILabel alloc] init];
    
    NSDate *nowDate = [[NSDate date] dateByAddingTimeInterval:60*60*8];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    [dateComponents setMonth:longTime];
    NSDate *newDate = [calendar dateByAddingComponents:dateComponents toDate:nowDate options:0];
    
    NSString *nowDateStr = [[NSString stringWithFormat:@"%@",nowDate] substringToIndex:10];
    NSString *newDateStr = [[NSString stringWithFormat:@"%@",newDate] substringToIndex:10];
    
    [list1 makeLabelWithText:[NSString stringWithFormat:@"期限 %@~%@",nowDateStr,newDateStr] andTextColor:MBColor(102, 103, 104, 1) andFont:[UIFont yaHeiFontOfSize:13*Ratio]];

    [self.view addSubview:list1];
    [list1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(20*Ratio);
        make.top.equalTo(list0.mas_bottom).offset(5*Ratio);
        make.size.mas_equalTo(CGSizeMake(285*Ratio, 20*Ratio));
    }];
    
    UILabel *list2 = [[UILabel alloc] init];
    [list2 makeLabelWithText:@"预约绿色通道" andTextColor:MBColor(102, 103, 104, 1) andFont:[UIFont yaHeiFontOfSize:13*Ratio]];
    [self.view addSubview:list2];
    [list2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(20*Ratio);
        make.top.equalTo(list1.mas_bottom).offset(5*Ratio);
        make.size.mas_equalTo(CGSizeMake(285*Ratio, 20*Ratio));
    }];
    
    UILabel *list3 = [[UILabel alloc] init];
    [list3 makeLabelWithText:@"育儿沙龙" andTextColor:MBColor(102, 103, 104, 1) andFont:[UIFont yaHeiFontOfSize:13*Ratio]];
    [self.view addSubview:list3];
    [list3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(20*Ratio);
        make.top.equalTo(list2.mas_bottom).offset(5*Ratio);
        make.size.mas_equalTo(CGSizeMake(285*Ratio, 20*Ratio));
    }];
    
    
    UIButton *checkDetail = [UIButton buttonWithType:UIButtonTypeCustom];
    [checkDetail setBackgroundImage:[UIImage imageNamed:@"buy__btn_order_detail"] forState:UIControlStateNormal];
    [checkDetail addTarget:self action:@selector(detailAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:checkDetail];
    [checkDetail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).offset(-10*Ratio);
        make.centerY.equalTo(list0);
        make.size.mas_equalTo(CGSizeMake(62.5*Ratio, 20.5*Ratio));
    }];
    
    
    UILabel *line2 = [[UILabel alloc] init];
    line2.backgroundColor = MBColor(225, 253, 255, 1);
    [self.view addSubview:line2];
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.view);
        make.centerX.equalTo(self.view);
        make.top.equalTo(list3.mas_bottom).offset(5*Ratio);
        make.height.equalTo(@(5*Ratio));
    }];
#pragma mark = 支付方式
    UILabel *lin2 = [[UILabel alloc] init];
    lin2.backgroundColor = MBColor(153, 244, 237, 1);
    [self.view addSubview:lin2];
    [lin2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(2*Ratio, 14*Ratio));
        make.left.equalTo(self.view).offset(10*Ratio);
        make.top.equalTo(line2.mas_bottom).offset(10*Ratio);
    }];
    UILabel *unit2 = [[UILabel alloc] init];
    [unit2 makeLabelWithText:@"选择支付方式" andTextColor:MBColor(51, 52, 53, 1) andFont:[UIFont yaHeiFontOfSize:13*Ratio]];
    [self.view addSubview:unit2];
    [unit2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lin2).offset(8*Ratio);
        make.top.equalTo(line2.mas_bottom).offset(10*Ratio);
        make.size.mas_equalTo(CGSizeMake(100*Ratio, 15*Ratio));
    }];
    
    UIImageView *zhiFuBao = [[UIImageView alloc] init];
    zhiFuBao.image = [UIImage imageNamed:@"bao"];
    [self.view addSubview:zhiFuBao];
    [zhiFuBao mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(30*Ratio, 30*Ratio));
        make.left.equalTo(self.view).offset(13*Ratio);
        make.top.equalTo(unit2.mas_bottom).offset(10*Ratio);
    }];
    
    
    UILabel *labelZFB = [[UILabel alloc] init];
    [labelZFB makeLabelWithText:@"支付宝支付" andTextColor:MBColor(102, 103, 104, 1) andFont:[UIFont yaHeiFontOfSize:13*Ratio]];
    [self.view addSubview:labelZFB];
    [labelZFB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(zhiFuBao);
        make.left.equalTo(zhiFuBao.mas_right).offset(10*Ratio);
        make.size.mas_equalTo(CGSizeMake(80*Ratio, 20*Ratio));
    }];
    
    
    UIImageView *dui = [[UIImageView alloc] init];
    dui.image = [UIImage imageNamed:@"buy_gou"];
    [self.view addSubview:dui];
    [dui mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(13*Ratio, 13*Ratio));
        make.right.equalTo(self.view).offset(-17*Ratio);
        make.centerY.equalTo(labelZFB);
    }];
    
    
    UILabel *line = [[UILabel alloc] init];
    line.backgroundColor = MBColor(252, 236, 244, 1);
    [self.view addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(10*Ratio);
        make.right.equalTo(self.view).offset(-10*Ratio);
        make.top.equalTo(zhiFuBao.mas_bottom).offset(15*Ratio);
        make.height.mas_equalTo(Ratio);
    }];
    UILabel *line3 = [[UILabel alloc] init];
    line3.backgroundColor = MBColor(225, 253, 255, 1);
    [self.view addSubview:line3];
    [line3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.view);
        make.centerX.equalTo(self.view);
        make.top.equalTo(zhiFuBao.mas_bottom).offset(10*Ratio);
        make.height.equalTo(@(5*Ratio));
    }];
    
    
    
    UILabel *tishi = [[UILabel alloc] init];
    [tishi makeLabelWithText:@"您需支付" andTextColor:MBColor(102, 103, 104, 1) andFont:[UIFont yaHeiFontOfSize:12*Ratio]];
    [self.view addSubview:tishi];
    [tishi mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(13*Ratio);
        make.top.equalTo(line3.mas_bottom).offset(10*Ratio);
        make.size.mas_equalTo(CGSizeMake(80*Ratio, 20*Ratio));
    }];
    
    UILabel *yuan = [[UILabel alloc] init];
    [yuan makeLabelWithText:@"元" andTextColor:MBColor(102,103,104,1) andFont:[UIFont yaHeiFontOfSize:13*Ratio]];
    [self.view addSubview:yuan];
    [yuan mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(17*Ratio, 17*Ratio));
        make.centerY.equalTo(tishi);
        make.right.equalTo(self.view).offset(-17*Ratio);
    }];
    
    
    UILabel *money = [[UILabel alloc] init];
    howMuch = [_doctor.cost intValue]*longTime;
    [money makeLabelWithText:[NSString stringWithFormat:@"%d",howMuch] andTextColor:MBColor(250, 109, 166, 1) andFont:[UIFont yaHeiFontOfSize:13*Ratio]];
    money.textAlignment = NSTextAlignmentRight;
    [self.view addSubview:money];
    [money mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(80*Ratio, 20*Ratio));
        make.centerY.equalTo(tishi);
        make.right.equalTo(yuan.mas_left).offset(-10*Ratio);
    }];
    
    
    
    
    UIButton *pay = [UIButton buttonWithType:UIButtonTypeCustom];
    [pay setBackgroundImage:[UIImage imageNamed:@"buy_btn_pay"] forState:UIControlStateNormal];
    [pay addTarget:self action:@selector(payAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:pay];
    [pay mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(100*Ratio, 28*Ratio));
        make.top.equalTo(money.mas_bottom).offset(30*Ratio);
    }];
    
    
    

    
}


#pragma mark - 购买
-(void)payAction:(UIButton *)button{
    
    
    
    
#pragma mark - 支付宝回调 block
    AppDelegate *delegate = [AppDelegate sharedInstance];
    [delegate zhifubaoBackBlock:^(BOOL isSuccess) {
        if (isSuccess) {
            NSLog(@"请您完善信息 ");
            PaySuccessViewController *psvc = [[PaySuccessViewController alloc] init];
            psvc.isRegist = NO;
            
            
            NSArray *infoArr = [_infoStr componentsSeparatedByString:@","];
            psvc.doctorId = infoArr[0];
            psvc.hospitalId = infoArr[1];
            psvc.menuId = infoArr[2];
            psvc.isLong = YES;
//            psvc.isRegist = YES;
//            [self presentViewController:psvc animated:YES completion:nil];
            [self.navigationController pushViewController:psvc animated:nil];
            
        }
    }];
    
    
    /*
     *点击获取prodcut实例并初始化订单信息
     */
    //    Product *product = [[Product alloc] init];
    //    product.subject = @"1";
    //    product.body = @"测试";
    //
    //    product.price = 0.01f;
    /*
     *商户的唯一的parnter和seller。
     *签约后，支付宝会为每个商户分配一个唯一的 parnter 和 seller。
     */
    
    /*============================================================================*/
    /*=======================需要填写商户app申请的===================================*/
    /*============================================================================*/
    NSString *partner = @"2088911770215003";
    NSString *seller = @"doumengmeng2015@sina.com";
    NSString *privateKey = @"MIICdwIBADANBgkqhkiG9w0BAQEFAASCAmEwggJdAgEAAoGBALKGzO+PsKCOCinvJx296jLfV0BejpytiU7QIX64CCsItNKrODJ649uYvg3OZXjwUITAe7ZTe1lJchKsQ0X/TdcrgD2EXz7Fbpd5plz9tGZHr1Z2dE4tTsGoMA9YZ5OAczTxZOp/gxj5kVqJUB0hOsGexFB1WSQSx9/xnuxivvyZAgMBAAECgYAJSUvFtlK4t0q+DauaN3PEO6vdNE30xm4bBGaJoecC3gwR3UgqEAxkMtjH/RF4Lf/yN9T3kfYbmd9uKznAnVweG+ZeuMBU6rDVzPJ2zsqSXtp/cK42820VQzDfUIG9wstH+SkWH5iWB/gMrwyBhrQ2HMowLLQ5IMh/C5/mbiTiEQJBAOGNIJ8muaXSZ739SPuUoEfWx66JECfI7ngEx6DKQ1p6meVvdIAYBVjfAW/krXVM7A1/92hFDrAFE/OLulYDhlUCQQDKoIlS7lnKsicJ0JjB9tWWWMxruk7LeLTnd3bGB1Pc5nM2iI0mo804wjggA4lDaoGcW8e/7Piy6nXGIg9tbnk1AkEA2bxFe54EpaFiaLQ0Wjl2KSOcDE9geyernczvcbcQIi4slqJrkqSdtNdDKeNV1+D0F2wrSEsyDJY6VmfS7+njKQJBAKy95bSErJoH/Q35/nDFfNsawtNIVqpSMm9uQhya3Jzi/e/MxADf/jHYKb7pJNkLcImbGRR+8pqdFWCfYuWZG80CQBXOSQEPlGFnAuM1YtOUTJ2jebJ9QfpVIXfuZVPs07DhuzGRMk0QSfU/XVEvu2YM1AzjfB5ZblkaUZ4b/jEgkq4=";
    /*===========================================================================*/
    /*============================================================================*/
    /*============================================================================*/
    
    //partner和seller获取失败,提示
    if ([partner length] == 0 ||
        [seller length] == 0 ||
        [privateKey length] == 0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"缺少partner或者seller或者私钥。"
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    /*
     *生成订单信息及签名
     */
    //将商品信息赋予AlixPayOrder的成员变量
    Order *order = [[Order alloc] init];
    order.partner = partner;
    order.sellerID = seller;
    order.outTradeNO = [self generateTradeNO]; //订单ID（由商家自行制定）
    //[NSString stringWithFormat:@"萌宝宝线上服务%@",([_userRoleStr intValue] == 0)?@"购买":@"续费"]
    order.subject = [NSString stringWithFormat:@"萌宝宝线上服务%@",([_userRoleStr intValue] == 0)?@"购买":@"续费"]; //商品标题
    
    if (_infoStr.length > 0) { //商品描述
        NSArray *infoArr = [_infoStr componentsSeparatedByString:@","];

        order.body = [NSString stringWithFormat:@"%@,%@,%@%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"userId"],infoArr[0],infoArr[2],([_userRoleStr intValue] == 0)?[NSString stringWithFormat:@",%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"sessionId"]]:@""];
    }else{
        order.body = @"abcd";
    }
    
    
    
    
    order.totalFee = [NSString stringWithFormat:@"%d",howMuch]; //商品价格

    order.notifyURL =  [NSString stringWithFormat:@"%@system/%@.do",CURRENTSERVER,([_userRoleStr intValue] == 0)?@"PayNewBabyUser":@"PayOldBabyUser1"]; //回调URL
    
    order.service = @"mobile.securitypay.pay";
    order.paymentType = @"1";
    order.inputCharset = @"utf-8";
    order.itBPay = @"30m";
    order.showURL = @"m.alipay.com";
    
    //应用注册scheme,在AlixPayDemo-Info.plist定义URL types
    NSString *appScheme = @"BabyDemo";
    
    //将商品信息拼接成字符串
    NSString *orderSpec = [order description];
//    NSLog(@"orderSpec = %@",orderSpec);
    
    //获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode
    id<DataSigner> signer = CreateRSADataSigner(privateKey);
    NSString *signedString = [signer signString:orderSpec];
    
    //将签名成功字符串格式化为订单字符串,请严格按照该格式
    NSString *orderString = nil;
    if (signedString != nil) {
        orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
                       orderSpec, signedString, @"RSA"];
//        NSLog(@"orderString = %@",orderString);
        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            NSLog(@"AlipayReslut = %@",resultDic);
        }];
    }
    
    
    
}


#pragma mark  -  ==============产生随机订单号==============

- (NSString *)generateTradeNO
{
    static int kNumber = 15;
    
    NSString *sourceStr = @"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    NSMutableString *resultStr = [[NSMutableString alloc] init];
    srand((unsigned)time(0));
    for (int i = 0; i < kNumber; i++)
    {
        unsigned index = rand() % [sourceStr length];
        NSString *oneStr = [sourceStr substringWithRange:NSMakeRange(index, 1)];
        [resultStr appendString:oneStr];
    }
    return resultStr;
}

#pragma mark - 服务清单详情

-(void)detailAction:(UIButton *)button{
    BuyServeListViewController *buyVC = [[BuyServeListViewController alloc] init];
    buyVC.num = [NSString stringWithFormat:@"%d",longTime];
    [self.navigationController pushViewController:buyVC animated:YES];
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
