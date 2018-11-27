//
//  SYViewController.m
//  MBB
//
//  Created by 陈彦 on 15/9/1.
//  Copyright (c) 2015年 elsa. All rights reserved.
//

#import "SYViewController.h"
#import "UIImage+Sex.h"
#import "AppDelegate.h"
#import "MenuView.h"
#import "DataModels.h"
#import "UIImageView+WebCache.h"
#import "Time.h"
@interface SYViewController (){
    UIColor *wordColor;
    UIColor *bgColor;
    LoginUserUser *_user;
    NSArray * _growthArr;
}

@end

@implementation SYViewController

-(void)viewWillAppear:(BOOL)animated{
    [self.view bringSubviewToFront:_right0];
    NSFileManager *manager = [NSFileManager defaultManager];

    NSString *path1 = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/header.jpg"];
    if ([manager fileExistsAtPath:path1]) {
        self.headerV.image = [[UIImage alloc] initWithData:[NSData dataWithContentsOfFile:path1]];
        
        
        
    }

}
- (void)viewDidLoad {
    [super viewDidLoad];
    _monthDataArr = [[NSMutableArray alloc] init];
    NSFileManager *manager = [NSFileManager defaultManager];
    NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"/Documents/loadUser.plist"];
    if ([manager fileExistsAtPath:path]) {
        NSData *data = [NSData dataWithContentsOfFile:path];
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        LoginUserNSObject *user = [[LoginUserNSObject alloc] initWithDictionary:dic];
        _user = user.result.user;
        
        
    }else{
        NSLog(@"路径不存在！");
    }
    NSString *path1 = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/severCon.plist"];
    if ([manager fileExistsAtPath:path1]) {
        NSData *data = [NSData dataWithContentsOfFile:path1];
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        ServerConfigBaseClass *base = [[ServerConfigBaseClass alloc] initWithDictionary:dic];
        _growthArr = base.result.growthList;
        
        
    }else{
        NSLog(@"路径不存在！");
    }
    
   
    [_monthDataArr addObjectsFromArray:[[NSUserDefaults standardUserDefaults] objectForKey:@"time"]];
    NSLog(@"day = %@",_monthDataArr);
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
    [self createRightView];
    [self createLeftView];
    
}
-(void)createLeftView{
    UILabel *time = [[UILabel alloc]initWithFrame:CGRectMake(193, 114, 273, 28)];
//    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    NSDate *birth = [formatter dateFromString:_user.birthday];
//    NSLog(@"birth = %@",birth);
    time.text = _user.birthday;
    time.font = [UIFont yaHeiFontOfSize:18];
    time.textAlignment = NSTextAlignmentCenter;
    time.textColor = WORDDARKCOLOR;
    [self.view addSubview:time];
    
    
    UIImageView *headerBg = [[UIImageView alloc] initWithFrame:CGRectMake(193, 235, 273, 273)];
    headerBg.image = [UIImage imageNamed:@"shouye-touxiang" ofSex:self.sex];
    [self.view addSubview:headerBg];
    
    
    _headerV = [[UIImageView alloc]initWithFrame:CGRectMake(202, 244, 255, 255)];
    _headerV.layer.masksToBounds = YES;
    _headerV.layer.cornerRadius = 127.5;
    NSString *headImg = [NSString urlStringOfPrefix:_user.headimg];
    NSURL *url = [NSURL URLWithString:headImg];
    
    if (headImg.length > 0) {
//        [_headerV sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"shouye-touxiang" ofSex:self.sex]];
        [_headerV sd_setImageWithURL:url];
    }else{
        _headerV.backgroundColor = [UIColor clearColor];
    }
   
   
    _headerV.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headerClick:)];
    [_headerV addGestureRecognizer:tap];
    [self.view addSubview:_headerV];
    
    
    UIImageView *niCheng = [[UIImageView alloc] initWithFrame:CGRectMake(250, 165, 166, 70)];
    niCheng.image = [UIImage imageNamed:@"shouye-mingzi" ofSex:self.sex];
    [self.view addSubview:niCheng];
    UILabel *niChengLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, niCheng.frame.size.width, 54)];
    niChengLab.text = [NSString stringWithFormat:@"Hi，%@",_user.truename];
    niChengLab.textColor = wordColor;
    niChengLab.textAlignment = NSTextAlignmentCenter;
    niChengLab.font = [UIFont yaHeiFontOfSize:20];
    [niCheng addSubview:niChengLab];
    NSArray *ar = @[@"个月",@"天"];
    for (int i=0; i<2; i++) {
        UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(230+136*i, 528, 57, 54)];
        imageV.image = [UIImage imageNamed:@"shouye-rili" ofSex:self.sex];
        [self.view addSubview:imageV];
        
        UILabel *month = [[UILabel alloc] initWithFrame:CGRectMake(298+136*i, 528, 57, 54)];
        month.text = ar[i];
        month.textColor = wordColor;
        month.font = [UIFont yaHeiFontOfSize:24];
        [self.view addSubview:month];
  
    }
    
    
    UILabel *month = [[UILabel alloc] initWithFrame:CGRectMake(230, 528, 57, 54)];
    month.text = [NSString stringWithFormat:@"%.2d",[_monthDataArr[0] intValue]*12+[_monthDataArr[1] intValue]];
    month.textColor = wordColor;
    month.textAlignment = NSTextAlignmentCenter;
    month.font = [UIFont yaHeiFontOfSize:26];
    [self.view addSubview:month];
    UILabel *day = [[UILabel alloc] initWithFrame:CGRectMake(230+136, 528, 57, 54)];
    day.text = [NSString stringWithFormat:@"%.2d",[_monthDataArr[2] intValue]];
    day.textColor = wordColor;
    day.textAlignment = NSTextAlignmentCenter;
    day.font = [UIFont yaHeiFontOfSize:26];
    [self.view addSubview:day];
    
    UIButton *needObserved = [UIButton buttonWithType:UIButtonTypeCustom];
    needObserved.frame = CGRectMake(216, 619, 235, 57);
    [needObserved setBackgroundImage:[UIImage imageNamed:@"shouye-guancha-1" ofSex:self.sex] forState:UIControlStateNormal];
    [needObserved setBackgroundImage:[UIImage imageNamed:@"shouye-guancha-1" ofSex:self.sex] forState:UIControlStateHighlighted];
    [needObserved setBackgroundImage:[UIImage imageNamed:@"shouye-guancha-1" ofSex:self.sex] forState:UIControlStateSelected];
    [needObserved addTarget:self action:@selector(needObservedBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:needObserved];
    
}
-(void)createRightView{
    _right0 = [[UIView alloc] initWithFrame:FRAMEOFRIGHTVIEW];
    _right0.backgroundColor = bgColor;
    UIImageView *background = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, FRAMEOFRIGHTVIEW.size.width, FRAMEOFRIGHTVIEW.size.height)];
    background.image = [[UIImage imageNamed:@"shouye-right" ofSex:self.sex] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [_right0 addSubview:background];
    [self.view addSubview:_right0];
    
    
    
    
    
    
    
    _right1 = [[UIView alloc] initWithFrame:FRAMEOFRIGHTVIEW];
    _right1.backgroundColor = bgColor;
    [self.view addSubview:_right1];
    
    
    
    UILabel *titl = [[UILabel alloc] initWithFrame:CGRectMake(20, 70, FRAMEOFRIGHTVIEW.size.width-40, 60)];
    titl.text = @"观察提示";
    titl.font = [UIFont yaHeiFontOfSize:35];
    titl.textColor = wordColor;
    [_right1 addSubview:titl];
    
    
    
    
    UILabel *line= [[UILabel alloc] initWithFrame:CGRectMake(20, 140, FRAMEOFRIGHTVIEW.size.width-40, 2)];
    
    line.backgroundColor = wordColor;
    
    [_right1 addSubview:line];
    
    
    
    
    UIScrollView *sc = [[UIScrollView alloc]initWithFrame:CGRectMake(20, 150, line.frame.size.width, self.view.frame.size.height-280)];
    sc.delegate = self;
    sc.indicatorStyle = UIScrollViewIndicatorStyleBlack;
    
    
    [_right1 addSubview:sc];
    
    
    NSMutableArray *guanChaTiShi = [[NSMutableArray alloc] init];
    
    int heigt1 = 30;
    for (ServerConfigGrowthList *growth in _growthArr) {
       
        if ([growth.age intValue] == [_monthDataArr[0] intValue]*12+[_monthDataArr[1] intValue]) {
            [guanChaTiShi addObject:growth];
        }
    }
    if ([_monthDataArr[0] intValue]*12+[_monthDataArr[1] intValue] == 0) {
        [guanChaTiShi addObject:_growthArr[0]];
    }
    for (int i=0; i<[guanChaTiShi count]; i++) {
        
        
        ServerConfigGrowthList *guancha = guanChaTiShi[i];
        //        CGRect rect = [beiz[i] boundingRectWithSize:CGSizeMake(sc.frame.size.width-referTo.frame.origin.x, 2000) options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil];
        UILabel *mesa = [[UILabel alloc] initWithFrame:CGRectMake(50, 0,  sc.frame.size.width-90, 400)];
    
        mesa.text = guancha.observecontent;
        mesa.textColor = WORDDARKCOLOR;
        mesa.numberOfLines = 0;
        mesa.font = [UIFont yaHeiFontOfSize:16];
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:mesa.text];;
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
        [paragraphStyle setLineSpacing:10];
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, mesa.text.length)];
        
        mesa.attributedText = attributedString;
        CGSize size = [mesa sizeThatFits:CGSizeMake(sc.frame.size.width-90, 40000)];
        mesa.frame = CGRectMake(60, heigt1-30,  size.width, size.height);
        
        [sc addSubview:mesa];
        UILabel *spot = [[UILabel alloc] initWithFrame:CGRectMake(30+5, mesa.frame.origin.y+5, 8, 8)];
        spot.backgroundColor = WORDDARKCOLOR;
        spot.layer.masksToBounds = YES;
        spot.layer.cornerRadius = 4;
        [sc addSubview:spot];
//        UIImageView *spot0 = [[UIImageView alloc] initWithFrame:CGRectMake(30, mesa.frame.origin.y+5, 11, 11)];
//        spot0.image = [UIImage imageNamed:@"jilu-dian" ofSex:self.sex];
//        [sc addSubview:spot0];
        heigt1 = heigt1 + size.height+10;
        sc.contentSize = CGSizeMake(sc.frame.size.width,heigt1);
    

    }
        
    [self.view bringSubviewToFront:_right0];

    
    
    
}


-(void)headerClick:(UITapGestureRecognizer *)tap{
    NSLog(@"头像被点击！");
    self.tabBarController.selectedIndex = 0;
}
-(void)needObservedBtnClick:(UIButton *)button{
    button.selected = !button.selected;
    [self.view bringSubviewToFront:_right1];
    
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
