//
//  MyTabBarViewController.m
//  3UITabBarController(custom)
//
//  Created by Cecilia on 14-11-11.
//  Copyright (c) 2014年 Cecilia. All rights reserved.
//

#import "MyTabBarViewController.h"
#import "MenuView.h"
#import "AppDelegate.h"
#import "HeadViewController.h"
#import "SYViewController.h"
#import "JLViewController.h"
#import "PGViewController.h"
#import "YYZDViewController.h"
#import "YLZYViewController.h"
#import "KFZXViewController.h"
#import "YESLViewController.h"
#import "SetViewController.h"
#import "UIImage+Sex.h"
#import "UIButton+BackgroundImage.h"
#import "UIImageView+WebCache.h"
#import "UIButton+WebCache.h"

#import "NetRequestManage.h"
#import "DataModels.h"
#import <ImageIO/ImageIO.h>
@interface MyTabBarViewController (){
    BOOL isgirl;
    ServerConfigBaseClass *_serverMessage;
    
    CGFloat _animateTime;
}
@end

@implementation MyTabBarViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

#pragma mark - 创建一组视图控制器的对象
-(void)createViewControllers{
    //1.读plist文件
    NSString *path = [[NSBundle mainBundle] pathForResource:@"viewControllers" ofType:@"plist"];
    NSArray *plistArr = [NSArray arrayWithContentsOfFile:path];
    NSMutableArray *vcArr = [[NSMutableArray alloc] init];
   
    for (int i = 0; i < [plistArr count]; i++) {
        
        //2.创建视图控制器的对象
        Class cl = NSClassFromString(plistArr[i]);
        FatherViewController *vc = [(FatherViewController *)[cl alloc] init];
        vc.view.backgroundColor = [UIColor whiteColor];
        
        UINavigationController *nvc = [[UINavigationController alloc]initWithRootViewController:vc];
        UIImage *navImage = [[UIImage imageNamed:@"shouye-shang" ofSex:isgirl] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [vc.navigationController.navigationBar setBackgroundImage:navImage forBarMetrics:UIBarMetricsDefault];
         UIImageView *titleV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 170, 44)];
    titleV.image = [UIImage imageNamed:@"logo"];
    titleV.contentMode = UIViewContentModeScaleAspectFit;
        
        vc.navigationItem.titleView = titleV;
        [vcArr addObject:nvc];
        
        
    }
    self.viewControllers = vcArr;
    //4.隐藏系统的tabBar
    UIImageView *titleV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 170, 35)];
    titleV.image = [UIImage imageNamed:@"logo"];
    titleV.contentMode = UIViewContentModeScaleAspectFit;
    [self.moreNavigationController.navigationBar setBackgroundImage:[[UIImage imageNamed:@"shouye-shang" ofSex:isgirl] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forBarMetrics:UIBarMetricsDefault];
    self.moreNavigationController.navigationItem.titleView = titleV;
    self.tabBar.hidden = YES;
    [self customTabBar];
    
}
-(NSMutableArray *)createImageArr:(int)numberStar{
    NSMutableArray *imageArr = [[NSMutableArray alloc] init];
    NSURL *fileUrl = [[NSBundle mainBundle] URLForResource:[NSString stringWithFormat:@"%d-star(1)",numberStar] withExtension:@"gif"];
    NSData *gifData = [NSData dataWithContentsOfURL:fileUrl];
    
    CGImageSourceRef src = CGImageSourceCreateWithData((CFDataRef)gifData, NULL);
    _animateTime = 0.f;
    if (src) {
        size_t l = CGImageSourceGetCount(src);
        for (size_t i = 0; i < l; i++) {
            CGImageRef img = CGImageSourceCreateImageAtIndex(src, i, NULL);
            NSDictionary *properties = (NSDictionary *)CFBridgingRelease(CGImageSourceCopyPropertiesAtIndex(src, i, NULL));
            NSDictionary *frameProperties = [properties objectForKey:(NSString *)kCGImagePropertyGIFDictionary];
            NSNumber *delayTime = [frameProperties objectForKey:(NSString *)kCGImagePropertyGIFUnclampedDelayTime];
            _animateTime += [delayTime floatValue];
            if (img) {
                [imageArr addObject:[UIImage imageWithCGImage:img]];
                CGImageRelease(img);
            }
        }
        CFRelease(src);
    }
    
    return imageArr;
}
#pragma mark - customTabBar
-(void)customTabBar{
    //tabBar:默认高度是49
    MenuView *menu = [[[NSBundle mainBundle] loadNibNamed:@"MenuView" owner:self options:nil]lastObject];
    
    menu.frame = CGRectMake(0, 0, 169, self.view.frame.size.height);
    menu.tag = 1000;
    NSArray *btnArr = menu.subviews;
    //手动打开用户交互
    for (int i=0; i<[btnArr count]; i++) {
        id view = btnArr[i];
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton *btn = (UIButton *)view;
            [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    [self.view addSubview:menu];
    menu.SYButton.selected = YES;
    NSFileManager *manager = [NSFileManager defaultManager];
    NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"/Documents/loadUser.plist"];
    if ([manager fileExistsAtPath:path]) {
        NSData *data = [NSData dataWithContentsOfFile:path];
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        LoginUserNSObject *user = [[LoginUserNSObject alloc] initWithDictionary:dic];
       
        if (user.result.user.headimg.length>0) {
            
            [[SDImageCache sharedImageCache] clearDisk];
            NSString *strUrl = [NSString urlStringOfPrefix:user.result.user.headimg];
            NSURL *url = [NSURL URLWithString:strUrl];
            
            [menu.headButton sd_setBackgroundImageWithURL:url forState:UIControlStateNormal];
            
            [menu.headButton sd_setBackgroundImageWithURL:url forState:UIControlStateHighlighted];
            [menu.headButton sd_setBackgroundImageWithURL:url forState:UIControlStateSelected];
            

        }else{
            [menu.headButton setBackgroundImage:[UIImage imageNamed:@"caidan-xiaotou" ofSex:isgirl] forState:UIControlStateNormal];
            [menu.headButton setBackgroundImage:[UIImage imageNamed:@"caidan-xiaotou" ofSex:isgirl] forState:UIControlStateHighlighted];
            [menu.headButton setBackgroundImage:[UIImage imageNamed:@"caidan-xiaotou" ofSex:isgirl] forState:UIControlStateSelected];
        }
        NSLog(@"设置头像");
    }else{
        NSLog(@"路径不存在！");
    }
    menu.headBackground.image = [UIImage imageNamed:@"caidan-touxiang" ofSex:isgirl];
//    [menu.headButton setBackgroundImage:[UIImage imageNamed:@"caidan-touxiangmoren" ofSex:isgirl] forState:UIControlStateNormal];
    menu.headButton.layer.masksToBounds = YES;
    menu.headButton.layer.cornerRadius = 50.5;
    [menu.SYButton setBackgroundImage:[UIImage imageNamed:@"caidan-shouye0" ofSex:isgirl] forState:UIControlStateNormal backgroundImage:[UIImage imageNamed:@"caidan-shouye1" ofSex:isgirl] forState:UIControlStateSelected];
    [menu.SYButton setSelected:YES];
    [menu.JLButton setBackgroundImage:[UIImage imageNamed:@"caidan-jilu0" ofSex:isgirl] forState:UIControlStateNormal backgroundImage:[UIImage imageNamed:@"caidan-jilu1" ofSex:isgirl] forState:UIControlStateSelected];
    [menu.PGButton setBackgroundImage:[UIImage imageNamed:@"caidan-pinggu0" ofSex:isgirl] forState:UIControlStateNormal backgroundImage:[UIImage imageNamed:@"caidan-pinggu1" ofSex:isgirl] forState:UIControlStateSelected];
    [menu.YYZDButton setBackgroundImage:[UIImage imageNamed:@"caidan-zhidao0" ofSex:isgirl] forState:UIControlStateNormal backgroundImage:[UIImage imageNamed:@"caidan-zhidao1" ofSex:isgirl] forState:UIControlStateSelected];
    [menu.YLZYButton setBackgroundImage:[UIImage imageNamed:@"caidan-ziyuan0" ofSex:isgirl] forState:UIControlStateNormal backgroundImage:[UIImage imageNamed:@"caidan-ziyuan1" ofSex:isgirl] forState:UIControlStateSelected];
    [menu.KFZXButton setBackgroundImage:[UIImage imageNamed:@"caidan-kefu0" ofSex:isgirl] forState:UIControlStateNormal backgroundImage:[UIImage imageNamed:@"caidan-kefu1" ofSex:isgirl] forState:UIControlStateSelected];
    [menu.YESLButton setBackgroundImage:[UIImage imageNamed:@"caidan-shalong0" ofSex:isgirl] forState:UIControlStateNormal backgroundImage:[UIImage imageNamed:@"caidan-shalong1" ofSex:isgirl] forState:UIControlStateSelected];
    [menu.setButton setBackgroundImage:[UIImage imageNamed:@"caidan-shezhi0" ofSex:isgirl] forState:UIControlStateNormal backgroundImage:[UIImage imageNamed:@"caidan-shezhi1" ofSex:isgirl] forState:UIControlStateSelected];
    
    [menu.bgIV setImage:[UIImage imageNamed:@"shouye-zuo" ofSex:isgirl]];
    

    
}
#pragma mark - btn 调取viewController

-(void)btnClick:(UIButton *)btn{
    //先获取到btn所在的视图
    MenuView *menu = (MenuView *)[self.view viewWithTag:1000];
   
    NSArray *subArr = menu.subviews;
    for (int i = 0; i < [subArr count]; i++) {
        id obj = [subArr objectAtIndex:i];
        if ([obj isKindOfClass:[UIButton class]]) {
            UIButton *button = (UIButton *)obj;
            button.selected = NO;
        }
    }
    
    //把选中的按钮的selected置为YES
    btn.selected = YES;
    //设置tabBarController的选中index
    self.selectedIndex = btn.tag - 1001;
    
       
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    AppDelegate *delete = [UIApplication sharedApplication].delegate;
    isgirl = delete.sex;
    [self.moreNavigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"shouye-shang" ofSex:isgirl] forBarMetrics:UIBarMetricsDefault];
    UIImageView *titleV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 187, 43)];
    titleV.image = [UIImage imageNamed:@"logo"];
    titleV.contentMode = UIViewContentModeScaleAspectFit;
    self.moreNavigationController.navigationItem.titleView = titleV;
    
    [self createViewControllers];
    self.selectedIndex = 1;
//    [self requestFromUrl];
}









-(void)viewWillAppear:(BOOL)animated{
    
    
}

-(void)viewDidDisappear:(BOOL)animated{

}





- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





-(NSUInteger)supportedInterfaceOrientations{
    //设置只支持左横屏或右横屏
    return UIInterfaceOrientationMaskLandscapeLeft | UIInterfaceOrientationMaskLandscapeRight;
}






/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
