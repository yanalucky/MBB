//
//  FatherViewController.m
//  MBB1
//
//  Created by 陈彦 on 15/9/21.
//  Copyright (c) 2015年 elsa. All rights reserved.
//

#import "FatherViewController.h"
#import "AppDelegate.h"
@interface FatherViewController ()

@end

@implementation FatherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    self.sex = delegate.sex;
    UIImageView *titleV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 170, 35)];
    titleV.image = [UIImage imageNamed:@"logo"];
    titleV.contentMode = UIViewContentModeScaleAspectFit;
    UIImage *navImage = [[UIImage imageNamed:@"shouye-shang" ofSex:self.sex] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [self.navigationController.navigationBar setBackgroundImage:navImage forBarMetrics:UIBarMetricsDefault];
    
    
    self.navigationItem.titleView = titleV;
    
    if (self.sex == YES) {
        _wordColor = BOY_WORDCOLOR;
        _bgColor = BOY_RIGHTVIEWCOLOR;
    }else{
        _wordColor = GIRL_WORDCOLOR;
        _bgColor = GIRL_RIGHTVIEWCOLOR;
    }
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(UIInterfaceOrientationMask)supportedInterfaceOrientations{
    
    return UIInterfaceOrientationMaskLandscape;
}

-(BOOL)shouldAutorotate{
    return YES;
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
