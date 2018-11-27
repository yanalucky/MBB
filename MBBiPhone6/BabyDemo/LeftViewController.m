//
//  LeftViewController.m
//  BabyDemo
//
//  Created by 陈彦 on 16/3/14.
//  Copyright © 2016年 elsa. All rights reserved.
//

#import "LeftViewController.h"
#import "FirstViewController.h"
#import "LeftViewTableViewCell.h"
#import "ObserveViewController.h"
#import "UserViewController.h"
#import "AboutUsViewController.h"
#import "PhonerViewController.h"
#import "BuyViewController.h"

#import "SetViewController.h"
#import "UIImageView+WebCache.h"
#import "LoginUser.h"
#import "AppDelegate.h"


@interface LeftViewController ()<UITableViewDataSource,UITableViewDelegate>{

    UIView *_mainView;
    UITableView *_tableView;
    NSMutableArray *_leftImageArr;
    NSArray *_leftTitleArr;
    
    UIImageView *headerBg;
    
    
    
    FirstViewController *_first;
}

@end


@implementation LeftViewController



#pragma mark - 单例


#pragma mark - 单例侧滑
-(void)ChangeSlideStatus{
    
    
    
    if(self.isRight == YES){
        
        [UIView animateWithDuration:0.5 animations:^{
            //            self.view.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
            [_mainView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.view);
            }];

            _mainView.userInteractionEnabled = YES;

            [self.view layoutIfNeeded];
        }];
    
        
        self.isRight = NO;

        return;
    }
    
    [UIView animateWithDuration:0.5 animations:^{
        
        
        //            self.view.frame = CGRectMake(270, 0, self.view.bounds.size.width, self.view.bounds.size.height);
        [_mainView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view).offset(285*Ratio);
        }];

        _mainView.userInteractionEnabled = NO;

        
        [self.view layoutIfNeeded];
        
    }];

    self.isRight = YES;
    [_tableView reloadData];
}



-(void)viewWillAppear:(BOOL)animated{
    self.isRight = NO;
    if (_mainView) {
        _mainView.userInteractionEnabled = YES;
        self.navigationController.navigationBarHidden = YES;
        
        [self.view bringSubviewToFront:_mainView];
        [_mainView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view);
        }];
        [self.view layoutIfNeeded];
        
    }
    
    
}


/*
-(void)viewWillAppear:(BOOL)animated{
    self.isRight = NO;
    self.navigationController.navigationBarHidden = YES;
    if (_mainView) {
        
        if (_isReflash == YES) {
            _mainView = nil;
            [_mainView removeFromSuperview];
            _first = [[FirstViewController alloc] init];
            [self addChildViewController:_first];
            _mainView = _first.view;
            [self.view addSubview:_mainView];
//            [self.view bringSubviewToFront:_mainView];
            _mainView.userInteractionEnabled = YES;
            [_mainView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.size.equalTo(self.view);
                make.top.and.bottom.and.left.equalTo(self.view);
            }];
        [self.view bringSubviewToFront:_mainView];
        [_mainView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view);
        }];
        [self.view layoutIfNeeded];
        
        }
 
    }
    
}

*/


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _first = [[FirstViewController alloc] init];
    [self addChildViewController:_first];
    _mainView = _first.view;
    [self.view addSubview:_mainView];
    [self.view bringSubviewToFront:_mainView];
    [_mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(self.view);
        make.top.and.bottom.and.left.equalTo(self.view);
    }];
    
    //左边栏数据
    _leftImageArr = [[NSMutableArray alloc] init];
    for (int i=0; i<8; i++) {
        if (i==0||i==5||i==7||i==1||i==4) {
            NSString *image = [NSString stringWithFormat:@"chouti_%.2d",i+1];
            [_leftImageArr addObject:image];
        }
        
    }
    
    _leftTitleArr = @[@"个人中心",@"购买服务",@"客服中心",@"关于我们",@"设置"];
    
    
    
//    ,@"购买服务",@"育儿沙龙",@"医疗资源",@"客服中心",@"帮助"
    [self createLeftView];
    [self createSwipeGesture];
    
    // Do any additional setup after loading the view.
}

#pragma mark - 左边栏
-(void)createLeftView{
    
    if ([self respondsToSelector:@selector(automaticallyAdjustsScrollViewInsets)]) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 60, 285, 420) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerClass:[LeftViewTableViewCell class] forCellReuseIdentifier:@"identifier"];
    _tableView.bounces = NO;

    [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    

    //毛玻璃效果
    /*
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    UIVibrancyEffect *vibrancyEffect = [UIVibrancyEffect effectForBlurEffect:blurEffect];
    _tableView.separatorEffect = vibrancyEffect;
    */
    
    [self.view addSubview:_tableView];
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.top.equalTo(self.view).offset(0*Ratio);
        make.size.mas_equalTo(CGSizeMake(285*Ratio, (_leftTitleArr.count + 2)*44*Ratio));
    }];
    

    
    
}
#pragma mark - tableView代理方法

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifierStr = @"identifier";
    LeftViewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifierStr forIndexPath:indexPath];
//    if (cell == nil) {
//        cell = [[LeftViewTableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:identifierStr];
//       
//    }
   
    [cell makeCellByLeftImageName:_leftImageArr[indexPath.row] withTitle:_leftTitleArr[indexPath.row]];
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_leftTitleArr count];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 44*Ratio;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 64*Ratio;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        UserViewController *user = [[UserViewController alloc] init];
//        self.navigationController.navigationBarHidden = NO;
        [self.navigationController pushViewController:user animated:YES];
    }else if (indexPath.row == 1){
        
        BuyViewController *buyVC = [[BuyViewController alloc] init];
        
        [self.navigationController pushViewController:buyVC animated:YES];

    }else if (indexPath.row == 2){
        
        PhonerViewController *phone = [[PhonerViewController alloc] init];
        [self.navigationController pushViewController:phone animated:YES];

        
    }else if (indexPath.row == 3){
        AboutUsViewController *aboutUs = [[AboutUsViewController alloc] init];
//        self.navigationController.navigationBarHidden = NO;
        [self.navigationController pushViewController:aboutUs animated:YES];
    }else if (indexPath.row == 4){
        SetViewController *svc = [[SetViewController alloc] init];
//        self.navigationController.navigationBarHidden = NO;
        [self.navigationController pushViewController:svc animated:YES];
    }
    
    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    NSDictionary *userDic = [[NSUserDefaults standardUserDefaults] objectForKey:@"user"];
//    NSLog(@"userDic = %@",userDic);
    LoginUser *user = [[LoginUser alloc] initWithDictionary:userDic];
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = MBColor(250,250, 250, 1);
   
    view.frame = CGRectMake(0, 20, 285*Ratio, 64*Ratio);
    
    
    UIImageView *bg = [[UIImageView alloc] init];
    bg.image = [UIImage imageNamed:@"chouti_touxiang"];
    [view addSubview:bg];
    [bg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(view);
        make.left.equalTo(view).offset(10*Ratio);
        make.width.and.height.mas_equalTo(32*Ratio);
        
    }];
    headerBg = [[UIImageView alloc] init];
    headerBg.layer.masksToBounds = YES;
    headerBg.layer.cornerRadius = 15*Ratio;
    [view addSubview:headerBg];
//    [headerBg sd_setImageWithURL:[NSURL URLWithString:[NSString urlStringOfImage:user.headimg]]];
    
//    if (user.headimg) {
//        if (user.headimg.length > 0) {
//            NSData *imgData = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:[NSString urlStringOfImage:user.headimg]]];
//            if (imgData) {
//                
//                [self saveImage:imgData];
//                
//            }
//            
//        }
//    }
    NSString *path = NSHomeDirectory();
    NSString *jpgImagePath = [path stringByAppendingPathComponent:@"Documents/header.jpg"];
    headerBg.image = [[UIImage alloc] initWithContentsOfFile:jpgImagePath];
    
    [headerBg mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(view);
        make.left.equalTo(view).offset(11*Ratio);
        make.width.and.height.mas_equalTo(30*Ratio);
    
    }];
    
    UILabel *name = [[UILabel alloc] init];
    name.font = [UIFont yaHeiFontOfSize:14*Ratio];
    name.text = user.truename;
    name.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
    [view addSubview:name];
    [name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headerBg.mas_right).offset(22*Ratio);
        make.top.equalTo(@(15*Ratio));
        make.size.mas_equalTo(CGSizeMake(100*Ratio, 20*Ratio));
    }];
    
    
#pragma mark = 性别与月龄
    
    
    UIImageView *sex = [[UIImageView alloc] init];
    sex.image = [[UIImage imageNamed:[NSString stringWithFormat:@"shouye_icon_red_%@",user.sex]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    [view addSubview:sex];
    [sex mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(10*Ratio, 10*Ratio));
        make.left.equalTo(name).offset(-10*Ratio);
        make.top.equalTo(name.mas_bottom).offset(5*Ratio);
        
    }];
    
    
    UILabel *birthDay = [[UILabel alloc] init];
    birthDay.adjustsFontSizeToFitWidth = YES;
    NSArray *timeArr = [[NSUserDefaults standardUserDefaults] objectForKey:@"monthTime"];
    birthDay.text = [NSString stringWithFormat:@"%d月%d天",[timeArr[0] intValue]*12+[timeArr[1] intValue],[timeArr[2] intValue]];
    birthDay.font = [UIFont yaHeiFontOfSize:13*Ratio];
    birthDay.textColor = MBColor(151, 152, 153, 1);
    birthDay.textAlignment = NSTextAlignmentCenter;
    [view addSubview:birthDay];
    [birthDay mas_makeConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(@(14*Ratio));
                make.width.mas_equalTo(@(60*Ratio));
                make.left.equalTo(sex.mas_right).offset(5*Ratio);
                make.centerY.equalTo(sex);
       
    }];
    
    
    return view;
}

#pragma mark - 存储图片
/*
-(void)saveImage:(NSData *)data{
    
    
    
    NSString *path = NSHomeDirectory();
    
    
    NSString *jpgImagePath = [path stringByAppendingPathComponent:@"Documents/header.jpg"];
    NSLog(@"path = %@     jpgImagePath = %@",path,jpgImagePath);
    NSFileManager *manager = [NSFileManager defaultManager];
    NSString *contents = [[NSBundle mainBundle] pathForResource:jpgImagePath ofType:@"jpg"];
    
    
    if(contents){
        
        [manager removeItemAtPath:path error:nil];
        
    }
    
    [data writeToFile:jpgImagePath atomically:YES];
   
}
 */
#pragma mark - 添加滑动手势

-(void)createSwipeGesture{
//    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeAction:)];
//    [swipe setDirection:UISwipeGestureRecognizerDirectionRight];
//    [_mainView addGestureRecognizer:swipe];
    
    
    
    UISwipeGestureRecognizer *swipe1 = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeAction:)];
    [swipe1 setDirection:UISwipeGestureRecognizerDirectionLeft];
    [_mainView addGestureRecognizer:swipe1];
    
    
}
-(void)swipeAction:(UISwipeGestureRecognizer *)gesture{
    
//    if (gesture.direction == UISwipeGestureRecognizerDirectionRight) {
//         CGPoint pt = [gesture locationInView:self.view];
//        _isRight = YES;
//        if (pt.x < (50*Ratio)) {
//            [UIView animateWithDuration:0.5 animations:^{
//                //            self.view.frame = CGRectMake(270, 0, self.view.bounds.size.width, self.view.bounds.size.height);
//                [_mainView mas_updateConstraints:^(MASConstraintMaker *make) {
//                    make.left.equalTo(self.view).offset(285*Ratio);
//                }];
//                
//                [self.view layoutIfNeeded];
//                
//            }];
//        }
//        
//    }
//    
//    if (gesture.direction == UISwipeGestureRecognizerDirectionLeft) {
    
        _isRight = NO;
        [UIView animateWithDuration:0.5 animations:^{
//            self.view.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
            [_mainView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.view);
            }];
            _mainView.userInteractionEnabled = YES;

            [self.view layoutIfNeeded];
        }];
        
        
   // }
}



-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (_isRight == YES) {
        [self ChangeSlideStatus];

    }
    
}





-(void)btn1Click:(UIButton *)button{
    NSLog(@"点击btn");
}




-(UIStatusBarStyle)preferredStatusBarStyle{
    
    return  UIStatusBarStyleLightContent;
}

@end
