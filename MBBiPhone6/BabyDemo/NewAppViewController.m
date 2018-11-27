//
//  NewAppViewController.m
//  BabyDemo
//
//  Created by 陈彦 on 16/8/5.
//  Copyright © 2016年 elsa. All rights reserved.
//

#import "NewAppViewController.h"

@interface NewAppViewController ()

@end

@implementation NewAppViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self createSC];
    
    // Do any additional setup after loading the view.
}
-(void)createSC{
    if ([self respondsToSelector:@selector(automaticallyAdjustsScrollViewInsets)]) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    UIScrollView *sc = [[UIScrollView alloc] init];
    sc.pagingEnabled = YES;
    sc.showsHorizontalScrollIndicator = NO;
    sc.bounces = NO;
    [self.view addSubview:sc];
    [sc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self.view);
        make.top.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
    
    UIView *contentView = [[UIView alloc] init];
    [sc addSubview:contentView];
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(sc);
        make.height.equalTo(sc);
    }];
    
    UIImageView *img0 = [[UIImageView alloc] init];
    img0.image = [UIImage imageNamed:@"yindao_01"];
    [contentView addSubview:img0];
    [img0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(sc);
        make.centerY.equalTo(contentView);
        make.left.equalTo(contentView);
    }];
    
    UIImageView *img1 = [[UIImageView alloc] init];
    img1.image = [UIImage imageNamed:@"yindao_02"];
    [contentView addSubview:img1];
    [img1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(sc);
        make.centerY.equalTo(contentView);
        make.left.equalTo(img0.mas_right);
        
    }];
    
    
    UIImageView *img2 = [[UIImageView alloc] init];
    img2.image = [UIImage imageNamed:@"yindao_03"];
    [contentView addSubview:img2];
    [img2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(sc);
        make.centerY.equalTo(contentView);
        make.left.equalTo(img1.mas_right);
    }];
    img2.userInteractionEnabled = YES;
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = [UIColor whiteColor];
    [button setTitle:@"准备好了" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont yaHeiFontOfSize:17*Ratio];
    [button addTarget:self action:@selector(finishAction:) forControlEvents:UIControlEventTouchUpInside];
    [button setTitleColor:MBColor(250, 109, 166, 1) forState:UIControlStateNormal];
    button.layer.masksToBounds = YES;
    button.layer.cornerRadius = 10*Ratio;
    button.layer.borderColor = MBColor(250, 109, 166, 1).CGColor;
    button.layer.borderWidth = 2;
    [img2 addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(img2);
        make.bottom.equalTo(@(-55*Ratio));
        make.size.mas_equalTo(CGSizeMake(101.5*Ratio, 37.5*Ratio));
    }];
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(img2);
    }];

}
-(void)finishAction:(UIButton *)button{
    
    [[NSUserDefaults standardUserDefaults] setObject:@"ISNONEW" forKey:CURRENTVERSION];
    NSLog(@"看完了！");
    FirPageViewController *rvc = [[FirPageViewController alloc] init];
    rvc.isAutoLogin = YES;
    rvc.isOverTime = YES;
    [UIApplication sharedApplication].keyWindow.rootViewController = rvc;


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
