//
//  LoginViewController.m
//  MBB1
//
//  Created by 陈彦 on 15/9/6.
//  Copyright (c) 2015年 elsa. All rights reserved.
//

#import "LoginViewController.h"
#import "AppDelegate.h"
#import "MyTabBarViewController.h"
#import "NoDeclaredViewController.h"
#import "TAlertView.h"
#import "UIImage+Sex.h"
#import "Time.h"
#import "ErrorStatus.h"
#import "GDataXMLNode.h"
#import "NSString+Request.h"
//#import "UITextField+CYAccessoryViewTextField.h"

#import "NetRequestManage.h"
#import "DataModels.h"
#import "SDImageCache.h"
#import "HttpLoader.h"
#import "SGdownloader.h"
#import "SSZipArchive.h"
@interface LoginViewController ()<UIAlertViewDelegate,UITextFieldDelegate>{
    BOOL _sex;
    LoginUserUser *_user;
    int _rightTagOfTextField;//子键盘相关
    BOOL _isAccessoryView;//子键盘相关
    BOOL _mustUpgrade;
    NSMutableArray *_featuredArr;
    
    UIImageView *loadingView;
    
}
@end

@implementation LoginViewController


-(UIInterfaceOrientationMask)supportedInterfaceOrientations{
    
    return UIInterfaceOrientationMaskLandscape;
}

-(BOOL)shouldAutorotate{
    return YES;
}

-(void)viewWillAppear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(infoAction:) name:UITextFieldTextDidChangeNotification object:nil];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    
    NSString *loaduset = [NSString stringWithFormat:@"%@/Documents/%@", NSHomeDirectory(), @"loadUser.plist"];
    
    if ([fileManager fileExistsAtPath:loaduset]) {
        if ([fileManager removeItemAtPath:loaduset error:nil]) {
            NSLog(@"删除loaduser 成功！");
        }else{
            NSLog(@"删除loaduser 失败");
        }
    }else{
        NSLog(@"还没有存储loaduser");
    }
     [[SDImageCache sharedImageCache] clearDisk];
    [[SDImageCache sharedImageCache] clearMemory];
    
    _updateDownload.hidden = YES;
    
    NSString *path1 = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/header.jpg"];
    if ([fileManager fileExistsAtPath:path1]) {
        
        [fileManager removeItemAtPath:path1 error:nil];
        
        
        
    }
    
}



#pragma mark - 解压
-(BOOL)unArchive:(NSString *)zipPath to:(NSString *)destinationPath{
    
    
//    NSString *zipPath = @"被解压的文件路径";
//    NSString *destinationPath = @"解压到的目录";
    [SSZipArchive unzipFileAtPath:zipPath toDestination:destinationPath];
    
    return YES;
}


-(void)viewDidAppear:(BOOL)animated{
    
    [NetRequestManage vesionUpdateSuccessBlocks:^(NSData *data, NetRequestManage *load) {
        if (load.resultData) {
            //xml数据解析
            //把要解析的XML文档的二进制数据放到解析容器中
            
            NSString *str = [[NSString alloc] initWithData:load.resultData encoding:NSUTF8StringEncoding];
            NSLog(@"str = %@",str);

            GDataXMLDocument *doc = [[GDataXMLDocument alloc]initWithData:load.resultData options:0 error:nil];
            
            GDataXMLElement *version = [doc rootElement];
            NSString *content = version.stringValue;
            content = [content stringByReplacingOccurrencesOfString:@"\n" withString:@""];
            NSLog(@"content = %@",content);
            
            NSArray *versionArr = [content componentsSeparatedByString:@"."];
            NSLog(@"versionArr = %@",versionArr);
            NSArray *oldVersionArr = @[@"1",@"0",@"1"];
            for (int i=0; i<3; i++) {
                if (([versionArr[i] intValue] - [oldVersionArr[i] intValue])>0) {
                    NSString *titl = @"有新的版本,赶快去更新吧~";
                    [self alertViewWithVersion:i withTitle:titl];
                    NSLog(@"%d,%d",[versionArr[i] intValue] - [oldVersionArr[i] intValue],i);
                    break;
                
                }

            }
//            if ([content isEqualToString:@"1.0.0"]) {
//                NSLog(@"版本一致！");
//                
//            }else{
//                NSLog(@"版本不一致！");
//                 [self alertViewWithVersion];
//            }
            
            NSLog(@"访问版本号成功 version = %@",content);
            
        }
    } andfailedBlocks:^(NSError *error, NetRequestManage *load) {
        
        NSLog(@"error = %@",error.description);
        
    }];
    
   
    

}

#pragma mark - 自定义 alertview 相关

-(void)alertViewWithVersion:(int)number withTitle:(NSString *)title{
    
    UIView *ciew = [self.view.window viewWithTag:8888];
    ciew.hidden = NO;
     UIImageView *_alert = [[UIImageView alloc] initWithFrame:CGRectMake((self.view.frame.size.width - 300)/2, (self.view.frame.size.height - 150)/2, 300, 150)];
      _alert.backgroundColor = [UIColor whiteColor];
        _alert.tag = 6666;
        _alert.layer.masksToBounds = YES;
        _alert.layer.cornerRadius = 10;
        _alert.userInteractionEnabled = YES;
        _alert.alpha = 1;
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake((_alert.frame.size.width - 150)/2, (_alert.frame.size.height-60)/2-30, 150, 60)];
        
        label.font = [UIFont yaHeiFontOfSize:19];
        label.adjustsFontSizeToFitWidth = YES;
        label.text = title;
        label.textColor = BOY_WORDCOLOR;
        label.numberOfLines = 0;
        label.textAlignment = NSTextAlignmentCenter;
        [_alert addSubview:label];

    if (number<2) {
               
        _mustUpgrade = YES;
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake((_alert.frame.size.width - 161)/2, (_alert.frame.size.height-46)/2+42, 161, 46);
        [button setBackgroundImage:[UIImage imageNamed:@"1-jilu-tijiao"] forState:UIControlStateNormal];
        
        [button setBackgroundImage:[UIImage imageNamed:@"1-jilu-tijiao"] forState:UIControlStateSelected];
        [button setBackgroundImage:[UIImage imageNamed:@"1-jilu-tijiao"] forState:UIControlStateHighlighted];
        
        button.titleLabel.font = [UIFont yaHeiFontOfSize:14];
        [button setTitleColor:BOY_WORDCOLOR forState:UIControlStateNormal];
        [button setTitle:@"更新" forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont yaHeiFontOfSize:19];
        
        [button addTarget:self action:@selector(versionAction:) forControlEvents:UIControlEventTouchUpInside];
        
        
        [_alert addSubview:button];
        
        
        
    }else{
        for (int i=0; i<2; i++) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(20+(120+20)*i, (_alert.frame.size.height-46)/2+42, 120, 46);
            [button setBackgroundImage:[UIImage imageNamed:@"1-jilu-tijiao"] forState:UIControlStateNormal];
            
            [button setBackgroundImage:[UIImage imageNamed:@"1-jilu-tijiao"] forState:UIControlStateSelected];
            [button setBackgroundImage:[UIImage imageNamed:@"1-jilu-tijiao"] forState:UIControlStateHighlighted];
            
            button.titleLabel.font = [UIFont yaHeiFontOfSize:14];
            [button setTitleColor:BOY_WORDCOLOR forState:UIControlStateNormal];
            if (i==0) {
                [button setTitle:@"取消" forState:UIControlStateNormal];
                [button addTarget:self action:@selector(cancelAction:) forControlEvents:UIControlEventTouchUpInside];
            }else{
                [button setTitle:@"更新" forState:UIControlStateNormal];
                [button addTarget:self action:@selector(versionAction:) forControlEvents:UIControlEventTouchUpInside];

            }
            button.titleLabel.font = [UIFont yaHeiFontOfSize:19];
            
            
            
            [_alert addSubview:button];
        }
    }
    UIColor *color = [UIColor colorWithRed:25/255.0 green:190/255.0 blue:217/255.0 alpha:0.5];
    ciew.backgroundColor = color;
    [ciew addSubview:_alert];
    [self.view.window bringSubviewToFront:ciew];
}
-(void)cancelAction:(UIButton *)button{
    
    UIView *ciew = [self.view.window viewWithTag:8888];
    ciew.hidden = YES;
}
-(void)versionAction:(UIButton *)button{
    NSString *updateUrlString = [NSString stringWithFormat:@"https://itunes.apple.com/cn/app/meng-bao-bao-bao-bao-sheng/id1019423470?mt=8"];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:updateUrlString]];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    _mustUpgrade = NO;
    _fileManage =[NSFileManager defaultManager];
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"seenResponse"]) {
        self.mianze.selected = YES;
        
        [self.mianze setTitle:@"" forState:UIControlStateSelected];

    }else{
        self.mianze.selected = NO;
        [self.mianze setTitle:@"免责声明" forState:UIControlStateNormal];
        self.mianze.titleLabel.font = [UIFont yaHeiFontOfSize:19];
        [self.mianze setTitleColor:WORDDARKCOLOR forState:UIControlStateNormal];
        [self.mianze setBackgroundImage:nil forState:UIControlStateNormal];
    }
    
    _updateDownload.hidden = YES;
    _rightTagOfTextField = 4000;
    _isAccessoryView = NO;
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    _sex = delegate.sex;
    UIView *leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 50, 24)];
    UIImageView *iv = [[UIImageView alloc]initWithFrame:CGRectMake(15, 0, 23, 24)];
    iv.image = [[UIImage imageNamed:@"denglu-admin"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [leftView addSubview:iv];
    self.userName.leftView = leftView;
    self.userName.leftViewMode = UITextFieldViewModeAlways;
    UIView *leftView1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 50, 24)];
    UIImageView *iv1 = [[UIImageView alloc]initWithFrame:CGRectMake(15, 0, 23, 24)];
    iv1.image = [[UIImage imageNamed:@"denglu-password"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [leftView1 addSubview:iv1];
    self.password.leftView = leftView1;
    self.password.leftViewMode = UITextFieldViewModeAlways;
    self.remberMe.selected = NO;
    UIView *view0 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 30)];
    view0.backgroundColor = [UIColor greenColor];
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"username"]) {
        self.userName.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"username"];
        
    }
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"password"]) {
        self.password.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"password"];
    }
    
    self.userName.tag = 4000;

    self.password.tag = 4001;
    self.userName.delegate = self;
    self.password.delegate = self;
    [self setInputAccessoryViewByElsa:self.userName];
    [self setInputAccessoryViewByElsa:self.password];
    UIColor *coll = [UIColor colorWithRed:130/255.0 green:130/255.0 blue:130/255.0 alpha:1];
    [self.userName setValue:coll forKeyPath:@"_placeholderLabel.textColor"];
    [self.userName setValue:[UIFont yaHeiFontOfSize:19] forKeyPath:@"_placeholderLabel.font"];
    [self.password setValue:coll forKeyPath:@"_placeholderLabel.textColor"];
    [self.password setValue:[UIFont yaHeiFontOfSize:19] forKeyPath:@"_placeholderLabel.font"];
    self.userName.font = [UIFont yaHeiFontOfSize:19];
    self.password.font = [UIFont yaHeiFontOfSize:19];
    
    _updateDownload.textColor = WORDDARKCOLOR;
    _updateDownload.font = [UIFont yaHeiFontOfSize:19];
    //416  162
    loadingView = [[UIImageView alloc] initWithFrame:CGRectMake(190, 0, 34, 34)];
    NSMutableArray *imageArr = [[NSMutableArray alloc] init];
    for (int i=0; i<5; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"loading_%d",i]];
        [imageArr addObject:image];
    }
    [loadingView setImage:[imageArr objectAtIndex:imageArr.count-1]];
    [loadingView setAnimationImages:imageArr];
    [loadingView setAnimationDuration:0.6];
    [loadingView setAnimationRepeatCount:0];
    [_updateDownload addSubview:loadingView];
    
    
    // Do any additional setup after loading the view.
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

- (IBAction)loginBtnClick:(UIButton *)sender {
//    [[NSUserDefaults standardUserDefaults] setObject:self.password.text forKey:@"password"];
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"seenResponse"]) {
        
        if (_mustUpgrade == NO) {
         
        [NetRequestManage LoginRequestAccountName:self.userName.text andAccountPassword:self.password.text successBlocks:^(NSData *data, NetRequestManage *load) {
            NSString *str = [[NSString alloc] initWithData:load.resultData encoding:NSUTF8StringEncoding];
            NSLog(@"str = %@",str);
            
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:load.resultData options:NSJSONReadingMutableContainers error:nil];
            
            LoginNSObject *login = [[LoginNSObject alloc] initWithDictionary:dict];
            
            [[NSUserDefaults standardUserDefaults] setObject:login.result.user.userid forKey:@"userId"];
            [[NSUserDefaults standardUserDefaults] setObject:login.result.sessionId forKey:@"sessionId"];
            
            if (login.errorId == 0) {
//                [[NSUserDefaults standardUserDefaults] setObject:login.result.sessionId forKey:@"SessionId"];
                AppDelegate *delegate = [UIApplication sharedApplication].delegate;
                delegate.sex = [login.result.user.sex boolValue];
                UIView *ciew = [self.view.window viewWithTag:8888];
                UIColor *color;
                if (delegate.sex == YES) {
                    color = [UIColor colorWithRed:25/255.0 green:190/255.0 blue:217/255.0 alpha:0.5];
                }else{
                    color = [UIColor colorWithRed:231/255.0 green:36/255.0 blue:135/255.0 alpha:0.5];
                }
                ciew.backgroundColor = color;
                
                NSString *now = [[NSString stringWithFormat:@"%@",[NSDate date]] substringToIndex:10];
                NSArray *tim = [Time timewithBirth:login.result.user.birthday andNow:now];
                
                NSString *nowMonth = [NSString stringWithFormat:@"%d",[tim[0] intValue]*12+[tim[1] intValue]];
                NSLog(@"time = %@",nowMonth);
                [self serverCon:nowMonth];
                
            }else{
                
                NSLog(@"errorId = %@",[dict objectForKey:@"errorId"]);
                 [self alertViewWith:[ErrorStatus errorStatus:[dict objectForKey:@"errorId"] parmStr:nil]];
                
                
            }
            
            

//                TAlertView *alert = [[TAlertView alloc]initWithTitle:@"请补全账号及密码！" andMessage:nil];
//                alert.style = TAlertViewStyleNeutral;
//                alert.center = self.view.center;
//                alert.imageName = @"jilu-error";
//                alert.sex = _sex;
//                [alert show];
            
            
        } andfailedBlocks:^(NSError *error, NetRequestManage *load) {
            
            NSLog(@"loginError = %@",error.description);
            NSLog(@"加载出错！");
            
            
        }];
    }
    else{
       
       [self alertViewWithVersion:1 withTitle:@"服务器无法登陆，请更新版本哦~"];
        
    }
    }else{
        self.mianze.selected = YES;
        [self.mianze setTitle:@"" forState:UIControlStateSelected];
        NoDeclaredViewController *noDeclare = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"NoDeclaredViewController"];
        [self presentViewController:noDeclare animated:YES completion:nil];
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
    
    
    UIImageView *header = [[UIImageView alloc] initWithFrame:CGRectMake((_alert.frame.size.width - 50)/2, (_alert.frame.size.height-49)/2-30, 50, 49)];
    header.image = [UIImage imageNamed:@"jilu-error" ofSex:_sex];
    [_alert addSubview:header];
    
    
    UILabel *labe = [[UILabel alloc] initWithFrame:CGRectMake(10, header.frame.size.height+header.frame.origin.y + 15, _alert.frame.size.width-20, 30)];
    
    labe.text = errorSts;
    labe.textColor = [UIColor colorWithRed:25/255.0 green:190/255.0 blue:217/255.0 alpha:1];
    labe.textAlignment = NSTextAlignmentCenter;
    labe.font = [UIFont yaHeiFontOfSize:17];
    labe.numberOfLines = 0;
    
    [_alert addSubview:labe];
    
    
    
    [ciew addSubview:_alert];
    
    
    
    //                [self.view.window updateConstraints];
    [self.view.window bringSubviewToFront:ciew];
}


-(void)logUser{
    
    
    [NetRequestManage loadUserWithUserId:[[NSUserDefaults standardUserDefaults] objectForKey:@"userId"] successBlocks:^(NSData *data, NetRequestManage *loadUser) {
        NSString *str = [[NSString alloc] initWithData:loadUser.resultData encoding:NSUTF8StringEncoding];
        NSLog(@"logUser = %@",str);
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:loadUser.resultData options:NSJSONReadingMutableContainers error:nil];
        LoginUserNSObject *user = [[LoginUserNSObject alloc] initWithDictionary:dic];
        _user = user.result.user;
        AppDelegate *delegate = [UIApplication sharedApplication].delegate;
        
        if ([user.result.userRecord.recordstatus intValue] == 0) {
            delegate.report = 0;
        }else if(user.result.onlineAppraisal.recordid == NULL){
            
            delegate.report = 1;
            
            
        }else{
            delegate.report = 2;
        }
        NSLog(@"%@",[NSString stringWithFormat:@"%@",[NSDate date]]);
        NSString *now = [[NSString stringWithFormat:@"%@",[NSDate date]] substringToIndex:10];
        NSArray *tim = [Time timewithBirth:_user.birthday andNow:now];
        NSLog(@"tim = %@",tim);
        int nowMonth = [tim[0] intValue]*12+[tim[1] intValue];
        [[NSUserDefaults standardUserDefaults] setObject:tim forKey:@"time"];
        
        NSString *path = NSHomeDirectory();
        path = [path stringByAppendingPathComponent:@"/Documents/loadUser.plist"];
        NSLog(@"path = %@",path);
        
        if([[NSFileManager defaultManager] fileExistsAtPath:path])//如果存在临时文件的配置文件
            
        {
            
            [[NSFileManager defaultManager]  removeItemAtPath:path error:nil];
            
        }
        
        BOOL bo = [loadUser.resultData writeToFile:path atomically:NO];
        if (bo) {
            NSLog(@"loadUser写入成功！");
            
            MyTabBarViewController *myTabBar = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"MyTabBarViewController"];
            myTabBar.selectedIndex = 1;
            [self presentViewController:myTabBar animated:NO completion:nil];
        }else{
              NSLog(@"loadUser写入失败");
        }
        
    } andFailedBlocks:^(NSError *error, NetRequestManage *loadUser) {
        NSLog(@"ERROR = %@",error.description);
    }];
}

-(NSString *)GetLocalDocPath{
    
    //document的路径
    NSString *path =[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
    
    path =[path stringByAppendingPathComponent:@"download"];
    //创建文件夹
    if(![_fileManage fileExistsAtPath:path])
    {
        [_fileManage createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    return path;
}

-(void)downLoadeMoviceWith:(NSString *)moviceUrl{
    
    
    _download = [[SGdownloader alloc]initWithURL:[NSURL URLWithString:moviceUrl] timeout:20];
    
    [_download startWithDownloading:^(float progressValue, NSInteger percentage,float needLoadFileSize) {
        
    //这里面写那个进度的代码
//        NSLog(@"%ld,%.2f,%.2f",(long)percentage,progressValue,needLoadFileSize);
//        int proV =needLoadFileSize/(13.7*1024*1024);
        
        
        _updateDownload.text =[NSString stringWithFormat:@"资源更新中，进度：%ld%%",percentage];
        [loadingView startAnimating];
        _updateDownload.hidden = NO;
        
        
    } onFinished:^(NSData *fileData) {
        
        NSArray *arr1 =[moviceUrl componentsSeparatedByString:@"/"];
        
        NSString *filepath =[[self GetLocalDocPath] stringByAppendingPathComponent:[arr1 lastObject]];
        
        NSLog(@"%@",filepath);
        _handle = [NSFileHandle fileHandleForWritingAtPath:filepath];
        
        if([_fileManage fileExistsAtPath:filepath])
        {
            
        }
        else
        {
            
            [_fileManage createFileAtPath:filepath contents:fileData attributes:nil];
            
            //使用路径初始化句柄
        }
        
        
        [self unArchive:filepath to:[self GetLocalDocPath]];
        [loadingView stopAnimating];
         [self logUser];
        [_handle closeFile];
        
        
    } onFail:^(NSError *error) {
        
        [_handle closeFile];
        
    }];

    
}



-(void)serverCon:(NSString *)month{
    [NetRequestManage serverConfigRequestWithMonth:month SuccessBlocks:^(NSData *data, NetRequestManage *serverConfig) {
        NSString *str = [[NSString alloc] initWithData:serverConfig.resultData encoding:NSUTF8StringEncoding];
        NSLog(@"serverConfigSuccess!");
        NSLog(@"server = %@",str);
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:serverConfig.resultData options:NSJSONReadingMutableContainers error:nil];
        
        NSString *path = NSHomeDirectory();
        path = [path stringByAppendingPathComponent:@"/Documents/severCon.plist"];
        NSLog(@"path = %@",path);
        ServerConfigBaseClass *server = [[ServerConfigBaseClass alloc] initWithDictionary:dic];
        
        NSMutableArray *featuredArr = [[NSMutableArray alloc] init];
        if (server) {
            if (server.result) {
                if (server.result.featureList) {
                    if (server.result.featureList.count > 0) {
                        _featuredArr = [[NSMutableArray alloc] initWithArray:server.result.featureList];
                        
                        //                        for(ServerConfigFeatureList *feature in server.result.featureList) {
                        //
                        //                            [featuredArr addObject:feature.examplemov];
                        //                        }
                        
                    }
                    
                }
            }
        }
        
        NSString *filepath = [NSString urlStringOfImage:[NSString stringWithFormat:@"uploads/feature/%@.zip",month]];
        
        NSArray *arr =[filepath componentsSeparatedByString:@"/"];
        
        NSString *localFile =[NSString stringWithFormat:@"%@/%@",[self GetLocalDocPath],[arr lastObject]];
        
        
        if([[NSFileManager defaultManager] fileExistsAtPath:path])//如果存在临时文件的配置文件
            
        {
            
            [[NSFileManager defaultManager]  removeItemAtPath:path error:nil];
            
        }
        BOOL bo = [serverConfig.resultData writeToFile:path atomically:NO];
        
        if(![_fileManage fileExistsAtPath:localFile])
        {
            [_fileManage removeItemAtPath:[self GetLocalDocPath] error:nil];
            [self downLoadeMoviceWith:filepath];
        }
        else
        {
            if (bo) {
                NSLog(@"serverConfig写入成功！");
                
                [self logUser];
                
            }else{
                NSLog(@"serverConfig写入失败");
            }
        }
 
        
        
    } andFailedBlocks:^(NSError *error, NetRequestManage *serverConfig) {
         NSLog(@"serverConfigError = %@",error.description);
    }];
    
}


- (IBAction)rememberMe:(id)sender {
    UIButton *button = (UIButton *)sender;
    button.selected = !button.selected;
    [[NSUserDefaults standardUserDefaults] setObject:self.userName.text forKey:@"username"];
    [[NSUserDefaults standardUserDefaults] setObject:self.password.text forKey:@"password"];
        
   
   
    
}

- (IBAction)forgetPassword:(id)sender {
}

- (IBAction)noDeclared:(id)sender {
}




#pragma mark - textAccessoryView相关

-(void)setInputAccessoryViewByElsa:(UITextField *)textF{
    UIView *view0 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 1024, 44)];
    
    UITextField *text = [[UITextField alloc] initWithFrame:CGRectMake(5, 5, view0.frame.size.width-150, view0.frame.size.height-10)];
    text.delegate = self;
    text.tag = 8000;
    //    [text addObserver:self forKeyPath:@"text" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    [text setLeftViewOfBlankforWidth:8];
    text.backgroundColor = [UIColor whiteColor];
    text.borderStyle = UITextBorderStyleRoundedRect;
    text.placeholder = textF.placeholder;
    text.text = textF.text;
    [view0 addSubview:text];
    
    
    UIButton *finish = [UIButton buttonWithType:UIButtonTypeCustom];
    finish.frame = CGRectMake(view0.frame.size.width-140, 5, 60, view0.frame.size.height-10);
    [finish setTitle:@"完成" forState:UIControlStateNormal];
    [finish setTitleColor:BOY_WORDCOLOR forState:UIControlStateNormal];
    [finish addTarget:self action:@selector(finishAction:) forControlEvents:UIControlEventTouchUpInside];
    [view0 addSubview:finish];
    
    UIButton *remov = [UIButton buttonWithType:UIButtonTypeCustom];
    remov.frame = CGRectMake(view0.frame.size.width-70, 5, 60, view0.frame.size.height-10);
    [remov setTitle:@"取消" forState:UIControlStateNormal];
    [remov setTitleColor:BOY_WORDCOLOR forState:UIControlStateNormal];
    [remov addTarget:self action:@selector(removeText:) forControlEvents:UIControlEventTouchUpInside];
    [view0 addSubview:remov];
    
    view0.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1];
    [textF setInputAccessoryView:view0];
}
-(void)finishAction:(UIButton *)button{
    
    UITextField *textAccess = (UITextField *)[button.superview viewWithTag:8000];
    [textAccess resignFirstResponder];
    
  
    
    UITextField *text1 = (UITextField *)[self.view viewWithTag:_rightTagOfTextField];
    [text1 resignFirstResponder];
    
    
    
}


-(void)removeText:(UIButton *)button{
    UITextField *textAccess = (UITextField *)[button.superview viewWithTag:8000];
    
    textAccess.text = nil;
    [textAccess resignFirstResponder];


    UITextField *text2 = (UITextField *)[self.view viewWithTag:_rightTagOfTextField];
    text2.text = nil;
    
    [text2 resignFirstResponder];
}
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    if (textField.tag == 4000 || textField.tag == 4001) {
        _rightTagOfTextField = textField.tag;
    }else{
    }
    
}
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
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
    UITextField *text = (UITextField *)[self.view viewWithTag:_rightTagOfTextField];
    UITextField *textAccess = (UITextField *)[text.inputAccessoryView viewWithTag:8000];
    if (_isAccessoryView) {
        text.text = textAccess.text;
        
        
    }else{
        
        textAccess.text = text.text;

    }
}
-(void)viewWillDisappear:(BOOL)animated{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];
    
}


@end
