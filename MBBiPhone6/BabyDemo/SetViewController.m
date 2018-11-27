//
//  SetViewController.m
//  BabyDemo
//
//  Created by 陈彦 on 16/5/16.
//  Copyright © 2016年 elsa. All rights reserved.
//

#import "SetViewController.h"
#import "AgreementOfSetViewController.h"
#import "ChangePwdViewController.h"
@interface SetViewController ()

@end

@implementation SetViewController

-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = NO;

}

-(void)returnBtn:(UIButton *)button{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = MBColor(227, 252, 255, 1);
    self.navigationItem.title = @"设置";

#pragma mark =  左边按钮
    
    
//    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//    //    [button setImage:[UIImage imageNamed:@"shouye_top_left"] forState:UIControlStateNormal];
//    [button setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
//    button.selected = NO;
//    [button addTarget:self action:@selector(returnBtn:) forControlEvents:UIControlEventTouchUpInside];
//    button.frame = CGRectMake(0, 0, 10*Ratio, 18*Ratio);
//    
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    [self createInterface];
    // Do any additional setup after loading the view.
}
-(void)createInterface{
    
    UIImageView *iconimg = [[UIImageView alloc] init];
    iconimg.image = [UIImage imageNamed:@"icon144"];
    iconimg.layer.masksToBounds = YES;
    iconimg.layer.cornerRadius = 20*Ratio;
    [self.view addSubview:iconimg];
    [iconimg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(73*Ratio, 73*Ratio));
         make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).offset(44*Ratio);
    }];
    
    UILabel *edition = [[UILabel alloc]init];
    [edition makeLabelWithText:@"版本号" andTextColor:MBColor(102, 103, 104, 1) andFont:[UIFont yaHeiFontOfSize:13*Ratio]];
    [self.view addSubview:edition];
    [edition mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(iconimg);
        make.top.equalTo(iconimg.mas_bottom).offset(20*Ratio);
        make.size.mas_equalTo(CGSizeMake(40*Ratio, 16*Ratio));
    }];
    
    UILabel *editionNum = [[UILabel alloc]init];
    [editionNum makeLabelWithText:CURRENTVERSION andTextColor:MBColor(124, 207, 243, 1) andFont:[UIFont yaHeiFontOfSize:13*Ratio]];
    [self.view addSubview:editionNum];
    [editionNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(edition.mas_right).offset(1*Ratio);
        make.top.equalTo(iconimg.mas_bottom).offset(20*Ratio);
        make.size.mas_equalTo(CGSizeMake(40*Ratio, 16*Ratio));
    }];
    
    
    
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = [UIColor whiteColor];
    [button setTitle:@"修改密码" forState:UIControlStateNormal];
    [button setTitleColor:MBColor(102, 102, 102, 1) forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"chouti_ARROW_RIGHT2"] forState:UIControlStateNormal];
    button.imageEdgeInsets = UIEdgeInsetsMake(0, 300*Ratio, 0, 0);
    button.titleEdgeInsets = UIEdgeInsetsMake(0, -240*Ratio, 0, 0);
    button.titleLabel.textAlignment = NSTextAlignmentLeft;
    button.titleLabel.font = [UIFont yaHeiFontOfSize:12*Ratio];
    [button addTarget:self action:@selector(agreement:) forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.view);
        make.height.mas_equalTo(43*Ratio);
        make.centerX.equalTo(self.view);
        make.top.equalTo(editionNum.mas_bottom).offset(10*Ratio);
    }];
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.backgroundColor = [UIColor whiteColor];
    [button1 setTitle:@"使用协议" forState:UIControlStateNormal];
    [button1 setTitleColor:MBColor(102, 102, 102, 1) forState:UIControlStateNormal];
    [button1 setImage:[UIImage imageNamed:@"chouti_ARROW_RIGHT2"] forState:UIControlStateNormal];
    button1.imageEdgeInsets = UIEdgeInsetsMake(0, 300*Ratio, 0, 0);
    button1.titleEdgeInsets = UIEdgeInsetsMake(0, -240*Ratio, 0, 0);
    button1.titleLabel.textAlignment = NSTextAlignmentLeft;
    button1.titleLabel.font = [UIFont yaHeiFontOfSize:12*Ratio];
    [button1 addTarget:self action:@selector(agreement:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button1];
    [button1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.view);
        make.height.mas_equalTo(43*Ratio);
        make.centerX.equalTo(self.view);
        make.top.equalTo(button.mas_bottom).offset(1*Ratio);
    }];
    
}


-(void)agreement:(UIButton *)button{
    if ([button.titleLabel.text isEqualToString:@"使用协议"]) {
        AgreementOfSetViewController *agree = [[AgreementOfSetViewController alloc] init];
        [self.navigationController pushViewController:agree animated:YES];
    }else{
        ChangePwdViewController *change = [[ChangePwdViewController alloc] init];
        [self.navigationController pushViewController:change animated:YES];
    }
   
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
