//
//  Fcgo_LoginVC.m
//  Fcgo
//
//  Created by huafanxiao on 2017/5/10.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_LoginVC.h"
#import "Fcgo_LoginTextField.h"
#import "Fcgo_AuthCodeView.h"
#import <CloudPushSDK/CloudPushSDK.h>
#import "Fcgo_AppDelegate.h"

#import "Fcgo_RegistVC.h"
#import "Fcgo_CompanyAgreementVC.h"
#import "Fcgo_ForgetVC.h"
#import "UMMobClick/MobClick.h"


@interface Fcgo_LoginVC ()

@property (nonatomic,strong) Fcgo_LoginTextField *telTF,*passwordTF,*textTF;
@property (nonatomic,strong) Fcgo_AuthCodeView   *codeView;
@property (nonatomic,strong) UIButton            *sericeBtn;
@property (nonatomic,strong)UILabel *sericeLabel;

@end

@implementation Fcgo_LoginVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    [self setupUI];
    [self requestTel];
}

- (void)requestTel
{
    [Fcgo_NetworkManager postRequest:NSFormatHeardMeThodUrl(ServiceLocalTypeOne,COMMONMETHOD,@"init") parametersContentCommon:nil successBlock:^(BOOL success, id responseObject, NSString *msg) {
        if (success) {
            NSNumber *errCode = responseObject[@"errorCode"];
            if (errCode.intValue == 0) {
            NSString *tel = responseObject[@"data"][@"tel_400"];
            [Fcgo_UserTools shared].tel = tel;
            //前边三个
            NSString *tel1  = [tel substringToIndex:3];
            NSString *tel2 =  [tel substringFromIndex:3];
            //中间三个
            NSString *tel3 = [tel2 substringToIndex:3];
            //后边四个
            NSString *tel4 =  [tel2 substringFromIndex:3];
            NSString *phone  = [NSString stringWithFormat:@"%@-%@-%@",tel1,tel3,tel4];
            [self.sericeBtn setTitle:phone forState:UIControlStateNormal];
                
                CGFloat width1 = [self.sericeLabel.text boundingRectWithSize:CGSizeMake(1000, 1000) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:UIFontSize(12)} context:nil].size.width;
                
                CGFloat width2 = [phone boundingRectWithSize:CGSizeMake(1000, 1000) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:UIFontSize(12)} context:nil].size.width;
                
                
                CGFloat left = (kScreenWidth - (width1 + width2+2))/2;
                
                [self.sericeLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.left.mas_offset(left);
                    make.bottom.mas_offset(-10);
                }];
                [self.sericeBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.centerY.mas_equalTo(self.sericeLabel.mas_centerY);
                    make.left.mas_equalTo(self.sericeLabel.mas_right).mas_offset(2);
                    make.height.mas_equalTo(self.sericeLabel.mas_height);
                }];
            }
        }
    } failureBlock:^(NSString *description) {
    }];
}

- (void)setupUI
{
    self.navigationView.alpha = 0;
    UIImageView *bgImg = [[UIImageView alloc]init];
    NSString *bgImgString = @"";
    if (IPHONE4)
    {
        bgImgString = @"640X960.png";
    }
    else if (IPHONE5)
    {
            bgImgString = @"640X1136.png";
    }
    else if (IPHONE6)
    {
        bgImgString = @"750.png";
        
    }
    else 
    {
        bgImgString = @"10801.png";
    }
    bgImg.image = [UIImage imageNamed:bgImgString];
    [self.view addSubview:bgImg];
    
    [bgImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.right.mas_offset(0);
    }];
    
    UIImageView *logoImg = [[UIImageView alloc]init];
    logoImg.image = [UIImage imageNamed:@"title_logo"];
    [self.view addSubview:logoImg];
    
    [logoImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(kAutoWidth6px_h(300));
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.width.mas_offset(kAutoWidth6px((1240-666)));
        make.height.mas_offset(kAutoWidth6px((((1240-666)*192/385))));
    }];
    
    UIImageView *telImg = [[UIImageView alloc]init];
    telImg.image = [UIImage imageNamed:@"name-"];
    [self.view addSubview:telImg];
    
    [telImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(logoImg.mas_bottom).mas_offset(kAutoWidth6px_h(182));
        make.left.mas_offset(kAutoWidth6px(140));
        make.width.mas_offset(20);
        make.height.mas_offset(20);
    }];
    
    Fcgo_LoginTextField *telTF = [[Fcgo_LoginTextField alloc]init];
    telTF.placeholder = @"请输入手机号码";
    telTF.keyboardType = UIKeyboardTypeNumberPad;
    telTF.font = [UIFont systemFontOfSize:17];
    telTF.textColor = [UIColor whiteColor];
    telTF.tintColor = [UIColor whiteColor];
    telTF.borderStyle = UITextBorderStyleNone;
    
    UIButton *telTF_button = [telTF valueForKey:@"_clearButton"];
    [telTF_button setImage:[UIImage imageNamed:@"delete@2x"] forState:UIControlStateNormal];
    
    
    telTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view addSubview:self.telTF = telTF];
    
    [self.telTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(telImg.mas_right).mas_offset(7);
        make.right.mas_offset(kAutoWidth6px(-140));
        make.centerY.mas_equalTo(telImg).mas_offset(-2);
        make.height.mas_offset(30);
    }];
    
    UIView *telLine = [[UIView alloc]init];
    telLine.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:telLine];
    
    [telLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(telTF);
        make.width.mas_equalTo(telTF);
        make.bottom.mas_equalTo(telImg.mas_bottom).mas_offset(2);
        make.height.mas_offset (0.5);
    }];
    
    UIImageView *passwordImg = [[UIImageView alloc]init];
    passwordImg.image = [UIImage imageNamed:@"code-"];
    [self.view addSubview:passwordImg];
    
    [passwordImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(telImg.mas_bottom).mas_offset(kAutoWidth6px_h(155));
        make.left.mas_offset(kAutoWidth6px(140));
        make.width.mas_offset(20);
        make.height.mas_offset(20);
    }];
    
    Fcgo_LoginTextField *passwordTF = [[Fcgo_LoginTextField alloc]init];
    passwordTF.placeholder = @"请输入密码";
    passwordTF.font = [UIFont systemFontOfSize:17];
    passwordTF.textColor = [UIColor whiteColor];
    passwordTF.tintColor = [UIColor whiteColor];
    passwordTF.borderStyle = UITextBorderStyleNone;
    passwordTF.secureTextEntry = YES;
    UIButton *passwordTF_button = [passwordTF valueForKey:@"_clearButton"];
    [passwordTF_button setImage:[UIImage imageNamed:@"delete@2x"] forState:UIControlStateNormal];
    passwordTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view addSubview:self.passwordTF = passwordTF];
    
    [self.passwordTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(passwordImg.mas_right).mas_offset(7);
        make.right.mas_offset(kAutoWidth6px(-140)-70);
        make.centerY.mas_equalTo(passwordImg).mas_offset(-2);
        make.height.mas_offset(30);
    }];
    
    
    UIButton *forgetBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [forgetBtn setTitle:@"忘记密码" forState:UIControlStateNormal];
    [forgetBtn setTitleColor:UIFontWhiteColor forState:UIControlStateNormal];
    forgetBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [forgetBtn addTarget:self action:@selector(forgetClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:forgetBtn];
    [forgetBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_offset(70);
        make.right.mas_offset(kAutoWidth6px(-140));
        make.centerY.mas_equalTo(passwordImg).mas_offset(-1);
        make.height.mas_offset(30);
    }];
    
    
    UIView *passwordLine = [[UIView alloc]init];
    passwordLine.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:passwordLine];
    
    [passwordLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(passwordTF);
        make.width.mas_equalTo(telTF);
        make.bottom.mas_equalTo(passwordImg.mas_bottom).mas_offset(2);
        make.height.mas_offset (0.5);
    }];
    
    UIImageView *textImg = [[UIImageView alloc]init];
    textImg.image = [UIImage imageNamed:@"phone-"];
    [self.view addSubview:textImg];
    
    [textImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(passwordImg.mas_bottom).mas_offset(kAutoWidth6px_h(155));
        make.left.mas_offset(kAutoWidth6px(140));
        make.width.mas_offset(20);
        make.height.mas_offset(20);
    }];
    
    Fcgo_LoginTextField *textTF = [[Fcgo_LoginTextField alloc]init];
    textTF.placeholder = @"请输入验证码";
    textTF.keyboardType = UIKeyboardTypeNumberPad;
    textTF.font = [UIFont systemFontOfSize:17];
    textTF.textColor = [UIColor whiteColor];
    textTF.tintColor = [UIColor whiteColor];
    textTF.borderStyle = UITextBorderStyleNone;
    [self.view addSubview:self.textTF = textTF];
    
    [self.textTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(textImg.mas_right).mas_offset(7);
        make.right.mas_offset(kAutoWidth6px(-140));
        make.centerY.mas_equalTo(textImg).mas_offset(-2);
        make.height.mas_offset(30);
    }];
    
    UIView *textLine = [[UIView alloc]init];
    textLine.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:textLine];
    
    [textLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(textTF);
        make.width.mas_equalTo(textTF);
        make.bottom.mas_equalTo(textImg.mas_bottom).mas_offset(2);
        make.height.mas_offset (0.5);
    }];
    
    
    Fcgo_AuthCodeView *codeView = [[Fcgo_AuthCodeView alloc]initWithFrame:CGRectZero];
    [self.view addSubview:self.codeView = codeView];
    [self.codeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.textTF.mas_centerY).mas_offset(-6);
        make.right.mas_equalTo(self.textTF.mas_right);
        make.width.mas_offset(70);
        make.height.mas_offset(30);
    }];
    
    UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    loginBtn.backgroundColor = UIRGBColor(246, 51, 120, 1);
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [loginBtn setTitleColor:UIFontWhiteColor forState:UIControlStateNormal];
    loginBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [loginBtn addTarget:self action:@selector(loginClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginBtn];
    
    [loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(textLine.mas_bottom).mas_offset(kAutoWidth6px_h(180));
        make.left.mas_equalTo(textImg.mas_left);
        make.right.mas_equalTo(textTF.mas_right);
        make.height.mas_offset(42);
    }];
    
    
    UILabel *delegateLabel = [[UILabel alloc]init];
    delegateLabel.text = @"登录即表示您同意";
    delegateLabel.textColor = UIFontWhiteColor;
    delegateLabel.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:delegateLabel];
    
    [delegateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(loginBtn.mas_left);
        make.top.mas_equalTo(loginBtn.mas_bottom).mas_offset(8);
    }];
    UIButton *delegateBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    delegateBtn.backgroundColor = UIFontClearColor;
    [delegateBtn setTitle:@"《DDH用户协议》" forState:UIControlStateNormal];
    [delegateBtn setTitleColor:UIFontRedColor forState:UIControlStateNormal];
    
    //    NSMutableAttributedString *delegateString = [[NSMutableAttributedString alloc] initWithString:@"《DDH用户协议》"];
    //    NSRange strRange = {0,[delegateString length]};
    //    [delegateString addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:strRange];
    //    [delegateString addAttribute:NSForegroundColorAttributeName value:kWhiteColor range:strRange];
    //    [delegateBtn setAttributedTitle:delegateString forState:UIControlStateNormal];
    delegateBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [delegateBtn addTarget:self action:@selector(delegateClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:delegateBtn];
    
    [delegateBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(delegateLabel.mas_centerY);
        make.left.mas_equalTo(delegateLabel.mas_right).mas_offset(2);
        make.height.mas_equalTo(delegateLabel.mas_height);
    }];
    
    
    UIView *delegateLine = [[UIView alloc]init];
    delegateLine.backgroundColor = UIFontRedColor;
    [self.view addSubview:delegateLine];
    
    [delegateLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(delegateBtn);
        make.width.mas_equalTo(delegateBtn);
        make.bottom.mas_equalTo(delegateBtn.mas_bottom).mas_offset(-7);
        make.height.mas_offset (0.5);
    }];
    
    UILabel *sericeLabel = [[UILabel alloc]init];
    sericeLabel.text = @"如忘记密码，请联系客服，客服电话";
    sericeLabel.textColor = UIFontWhiteColor;
    sericeLabel.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:self.sericeLabel = sericeLabel];
    
    [sericeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX).mas_offset(kAutoWidth6(-37));
        make.bottom.mas_offset(-10);
    }];
    
    UIButton *sericeBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    sericeBtn.backgroundColor = UIFontClearColor;
    [sericeBtn setTitleColor:UIFontRedColor forState:UIControlStateNormal];
    sericeBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [sericeBtn addTarget:self action:@selector(sericeClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.sericeBtn = sericeBtn];
    
    [sericeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(sericeLabel.mas_centerY);
        make.left.mas_equalTo(sericeLabel.mas_right).mas_offset(2);
        make.height.mas_equalTo(sericeLabel.mas_height);
    }];
    
    UIView *sericeLine = [[UIView alloc]init];
    sericeLine.backgroundColor = UIFontRedColor;
    [self.view addSubview:sericeLine];
    
    [sericeLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(sericeBtn);
        make.width.mas_equalTo(sericeBtn);
        make.bottom.mas_equalTo(sericeBtn.mas_bottom).mas_offset(-7);
        make.height.mas_offset (0.5);
    }];
    
    
    UIButton *applyBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    applyBtn.backgroundColor = UIFontClearColor;
    [applyBtn setTitle:@"DDH合作店申请" forState:UIControlStateNormal];
    [applyBtn setTitleColor:UIFontWhiteColor forState:UIControlStateNormal];
    applyBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [applyBtn addTarget:self action:@selector(registClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:applyBtn];
    applyBtn.titleEdgeInsets = UIEdgeInsetsMake(0, kAutoWidth6(-25), 0, 0);
    [applyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        //make.bottom.mas_equalTo(sericeLabel.mas_top).mas_offset(AutoWidth6px_h(-270));
        make.top.mas_equalTo(delegateLabel.mas_bottom).mas_offset(kAutoWidth6px_h(110));
        make.left.right.mas_offset(0);
        make.height.mas_offset(30);
    }];
    
    UIImageView *applyImg = [[UIImageView alloc]init];
    applyImg.image = [UIImage imageNamed:@"enter"];
    [self.view addSubview:applyImg];
    [applyImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(applyBtn.mas_centerY);
        make.left.mas_equalTo(applyBtn.titleLabel.mas_right).mas_offset(2);
        make.width.mas_offset(18);
        make.height.mas_offset(18);
    }];
}

- (void)forgetClick
{
    [self.view endEditing:YES];
    Fcgo_ForgetVC *vc = [[Fcgo_ForgetVC alloc]init];
    vc.hidesBottomBarWhenPushed = 1;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)loginClick
{
    
    WEAKSELF(weakSelf);
    if ([Fcgo_Tools isNullString:self.telTF.text]) {
        [WSProgressHUD showImage:nil status:@"请输入手机号"];
        return;
    }
    if ([Fcgo_Tools isNullString:self.passwordTF.text]) {
        [WSProgressHUD showImage:nil status:@"请输入密码"];
        return;
    }
    if ([Fcgo_Tools isNullString:self.textTF.text]) {
       [WSProgressHUD showImage:nil status:@"请输入验证码"];
        return;
    }
    if (![[self.codeView.authCodeStr uppercaseString] isEqualToString:[self.textTF.text uppercaseString]]) {
        [self.codeView getAuthCode];
        [self.codeView setNeedsDisplay];
        [WSProgressHUD showImage:nil status:@"验证码错误"];
        return;
    }
    
    [WSProgressHUD showWithStatus:@"登录中..." maskType:WSProgressHUDMaskTypeClear];
    NSMutableDictionary  *muatble =[[NSMutableDictionary  alloc] init];
    [muatble  setObjectWithNullValidate:self.passwordTF.text forKey:@"password"];
    [muatble  setObjectWithNullValidate:self.telTF.text forKey:@"loginName"];
    [muatble  setObjectWithNullValidate:Dev_logSource forKey:@"loginSource"];
    [Fcgo_NetworkManager postRequest:NSFormatHeardMeThodUrl(ServiceLocalTypeOne,INFOMETHOD,@"login") parametersContentCommon:muatble successBlock:^(BOOL success, id responseObject, NSString *msg) {
        if (success) {
            [WSProgressHUD showImage:nil status:@"登录成功"];
            NSString *busTel = responseObject[@"data"][@"loginVo"][@"storeMobile"];
            if (busTel) {
                //登录成功之后，绑定账号，达到阿里推送的个推
                [CloudPushSDK bindAccount:busTel withCallback:^(CloudPushCallbackResult *res) {
                    if (res.success) {} else {}
                }];
            }
            //存储用户相关信息
            NSMutableDictionary *mutDic = [NSMutableDictionary  dictionaryWithDictionary:[[responseObject  objectForKey:@"data"] objectForKey:@"loginVo"]];
            [mutDic setObject:[[responseObject  objectForKey:@"data"] objectForKey:@"token"] forKey:@"token"];
            [Fcgo_UserTools shared].userDict = [NSMutableDictionary  dictionaryWithDictionary:mutDic];
            [MobClick profileSignInWithPUID:[NSString stringWithFormat:@"%@",[Fcgo_UserTools shared].userDict[@"mchId"]]];
            [Fcgo_UserTools shared].isLogin  = 1;
            //登录成功也得访问所有地区列表以对应商户的地址 来存储本地，如果只在delegate请求，初次登录，地址列表先请求，登录在后，那么商户登录之后，本地就没有商户的地址存储
            [Fcgo_publicNetworkTools postRequestAreaLocalListSuccessBlock:nil failureBlock:nil];
            //登录成功也得请求电话，防止刚进登录页网络断，开启之后登录成功，无电话出现
            [self requestTel];
            
            [Fcgo_Delegate setTabarVCToRootVC];
        }
        else
        {
            [WSProgressHUD showImage:nil status:msg];
            [weakSelf.codeView getAuthCode];
            [weakSelf.codeView setNeedsDisplay];
        }
    } failureBlock:^(NSString *description) {
    }];
}

- (void)delegateClick
{
    Fcgo_CompanyAgreementVC *protocolVC = [[Fcgo_CompanyAgreementVC alloc]init];
    protocolVC.urlString =  NSFormatHeardMeThodUrl(ServiceLocalTypeOne,COMMONMETHOD,@"agreement");
    protocolVC.isShowNavBar = YES;
    [self.navigationController pushViewController:protocolVC animated:YES];
}

- (void)registClick
{
    Fcgo_RegistVC *registerVC = [[Fcgo_RegistVC alloc]init];
    [self.navigationController pushViewController:registerVC animated:YES];
}

- (void)sericeClick
{
    NSString *tel = [Fcgo_UserTools shared].tel;
    if ([[[UIDevice currentDevice] systemVersion] floatValue]>=10.0) {
        NSMutableString *str=[[NSMutableString alloc] initWithFormat:@"tel:%@",tel];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    }else{
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"telprompt://%@",tel]]];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

@end
