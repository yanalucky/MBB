//
//  Fcgo_ReviewLinePayVC.m
//  Fcgo
//
//  Created by huafanxiao on 2017/6/24.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_ReviewLinePayVC.h"

@interface Fcgo_ReviewLinePayVC ()

@end

@implementation Fcgo_ReviewLinePayVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupUI];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.fd_fullscreenPopGestureRecognizer.enabled = NO;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.fd_fullscreenPopGestureRecognizer.enabled = YES;
}

- (void)setupUI;
{
    WEAKSELF(weakSelf)
    [self.navigationView setupBackBtnBlock:^{
        Fcgo_BasicNavVC *nav = weakSelf.tabBarController.viewControllers[0];
        [nav popToRootViewControllerAnimated:YES];
        weakSelf.tabBarController.selectedIndex = 0;
        [weakSelf.navigationController popToRootViewControllerAnimated:YES];
    }];
    [self.navigationView setupTitleLabelWithTitle:@"等待审核"];
    
    [self.navigationView setupBackTitle:@"返回首页"];
    
    UIImageView *imageView = [[UIImageView alloc]init];
    //    imageView.center = CGPointMake(kScreenWidth/2, KScreenHeight/2-kAutoWidth6(120));
    //    imageView.bounds = CGRectMake(0, 0, kAutoWidth6(150), kAutoWidth6(150));
    imageView.userInteractionEnabled = 1;
    //publicImageView.backgroundColor = [UIColor redColor];
    imageView.image = [UIImage imageNamed:@"check"];
    [self.view addSubview:imageView];
    
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(100);
        make.height.width.mas_offset(kAutoWidth6(150));
        make.centerX.mas_equalTo(weakSelf.view);
        
    }];
    
    
    UILabel *bigLabel = [[UILabel alloc]init];
    bigLabel.font = [UIFont systemFontOfSize:16];
    bigLabel.text = @"支付凭证资料提交成功";
    bigLabel.textColor = UIFontMainGrayColor;
    bigLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:bigLabel];
    
    [bigLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(imageView.mas_bottom).mas_offset(25);
        make.left.mas_offset(15);
        make.right.mas_offset(-15);
    }];
    
    UILabel *midleLabel = [[UILabel alloc]init];
    midleLabel.font = [UIFont systemFontOfSize:15];
    midleLabel.text = @"工作人员会立即审核您的支付资料，\n请您耐心等待,感谢您的惠顾";
    midleLabel.textColor = UIFontSortGrayColor;
    midleLabel.numberOfLines = 2;
    midleLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:midleLabel];
    [midleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(bigLabel.mas_bottom).mas_offset(14);
        make.left.mas_offset(15);
        make.right.mas_offset(-15);
    }];
    
    UILabel *bottomLabel = [[UILabel alloc]init];
    bottomLabel.font = [UIFont systemFontOfSize:15];
    bottomLabel.text = @"感谢您的惠顾";
    bottomLabel.textColor = UIFontMainGrayColor;
    bottomLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:bottomLabel];
    
    [bottomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(midleLabel.mas_bottom).mas_offset(15);
        make.left.mas_offset(15);
        make.right.mas_offset(-15);
    }];
    bottomLabel.hidden = 1;
}

@end

