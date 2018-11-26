//
//  Fcgo_AfterSalesService_ReviewVC.m
//  Fcgo
//
//  Created by huafanxiao on 2017/6/14.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_AfterSalesService_ReviewVC.h"

@interface Fcgo_AfterSalesService_ReviewVC ()

@end

@implementation Fcgo_AfterSalesService_ReviewVC

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
        Fcgo_BasicVC *vc = weakSelf.navigationController.viewControllers[2];
        [weakSelf.navigationController popToViewController:vc animated:YES];
    }];
    [self.navigationView setupTitleLabelWithTitle:@"等待审核"];
    
    UIImageView *imageView = [[UIImageView alloc]init];
    imageView.userInteractionEnabled = 1;
    imageView.image = [UIImage imageNamed:@"pay_success"];
    [self.view addSubview:imageView];
    
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(100);
        make.height.width.mas_offset(kAutoWidth6(150));
        make.centerX.mas_equalTo(weakSelf.view);
    }];
    
    UILabel *bigLabel = [[UILabel alloc]init];
    bigLabel.font = [UIFont boldSystemFontOfSize:16];
    bigLabel.text = @"申请售后已提交";
    bigLabel.textColor = UIFontMainGrayColor;
    bigLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:bigLabel];
    
    [bigLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(imageView.mas_bottom).mas_offset(25);
        make.left.mas_offset(15);
        make.right.mas_offset(15);
    }];
    
    UILabel *midleLabel = [[UILabel alloc]init];
    midleLabel.font = [UIFont boldSystemFontOfSize:15];
    midleLabel.text = @"工作人员收到申请后会主动联系您确认事项，\n请您耐心等待";
    midleLabel.textColor = UIFontRedColor;
    midleLabel.numberOfLines = 2;
    midleLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:midleLabel];
    [midleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(bigLabel.mas_bottom).mas_offset(15);
        make.left.mas_offset(15);
        make.right.mas_offset(15);
    }];
    
    UILabel *bottomLabel = [[UILabel alloc]init];
    bottomLabel.font = [UIFont systemFontOfSize:15];
    bottomLabel.text = @"感谢您的支持";
    bottomLabel.textColor = UIFontMainGrayColor;
    bottomLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:bottomLabel];
    
    [bottomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(midleLabel.mas_bottom).mas_offset(15);
        make.left.mas_offset(15);
        make.right.mas_offset(15);
    }];
}

@end


