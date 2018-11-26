//
//  Fcgo_MembersPointsVC.m
//  Fcgo
//
//  Created by huafanxiao on 2017/11/29.
//  Copyright © 2017年 Fcg. All rights reserved.
//

#import "Fcgo_MembersPointsVC.h"

@interface Fcgo_MembersPointsVC ()

@end

@implementation Fcgo_MembersPointsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    WEAKSELF(weakSelf)
    [self.navigationView setupBackBtnBlock:^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    }];
    [self.navigationView setupTitleLabelWithTitle:@"会员积分"];
    
    [self setupUI];
}


- (void)setupUI
{
    WEAKSELF(weakSelf)
    UIImageView *imageView = [[UIImageView alloc]init];
    imageView.userInteractionEnabled = 1;
    imageView.image = [UIImage imageNamed:@"ico_chuizi@2x"];
    [self.view addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(100);
        make.height.width.mas_offset(kAutoWidth6(120));
        make.centerX.mas_equalTo(weakSelf.view);
    }];
    
    UILabel *midleLabel = [[UILabel alloc]init];
    midleLabel.font = UIFontSize(14);
    midleLabel.text = @"功能开发中,敬请等待";
    midleLabel.textColor = UIFontSortGrayColor;
    midleLabel.numberOfLines = 1;
    midleLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:midleLabel];
    [midleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(imageView.mas_bottom).mas_offset(35);
        make.left.mas_offset(15);
        make.right.mas_offset(-15);
    }];
}

@end
