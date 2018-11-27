//
//  PhonerViewController.m
//  BabyDemo
//
//  Created by 陈彦 on 16/7/8.
//  Copyright © 2016年 elsa. All rights reserved.
//

#import "PhonerViewController.h"

@interface PhonerViewController ()

@end

@implementation PhonerViewController

-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = NO;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"客服中心";
    self.view.backgroundColor = [UIColor whiteColor];
    [self createInterface];
    // Do any additional setup after loading the view.
}

-(void)createInterface{
    
    UIImageView *imag = [[UIImageView alloc] init];
    imag.image = [UIImage imageNamed:@"kefu_pic"];
    
    [self.view addSubview:imag];
    [imag mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(110*Ratio, 110*Ratio));
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).offset(100*Ratio);
    }];
    
    UILabel *tit = [[UILabel alloc] init];
    [tit makeLabelWithText:@"客服热线" andTextColor:MBColor(101, 102, 103, 1) andFont:[UIFont yaHeiFontOfSize:15*Ratio]];
    tit.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:tit];
    [tit mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(imag);
        make.top.equalTo(imag.mas_bottom).offset(10*Ratio);
        make.size.mas_equalTo(CGSizeMake(70*Ratio, 18*Ratio));
    }];
    UIButton *phoneNum = [UIButton buttonWithType:UIButtonTypeCustom];
    [phoneNum setTitle:@" 021-6433 5531" forState:UIControlStateNormal];
    [phoneNum setTitleColor:MBColor(250, 109, 166, 1) forState:UIControlStateNormal];
    phoneNum.titleLabel.font = [UIFont yaHeiFontOfSize:21*Ratio];
    [phoneNum setImage:[UIImage imageNamed:@"kefu_tel"] forState:UIControlStateNormal];
    [phoneNum addTarget:self action:@selector(phoneAction:) forControlEvents:UIControlEventTouchUpInside];
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:phoneNum.titleLabel.text];
    NSRange strRange = {0,[str length]};
    [str addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:strRange];
    [phoneNum setAttributedTitle:str forState:UIControlStateNormal];
    [self.view addSubview:phoneNum];
    [phoneNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(imag).offset(-5*Ratio);
        make.top.equalTo(tit.mas_bottom).offset(10*Ratio);
        make.size.mas_equalTo(CGSizeMake(200*Ratio, 20*Ratio));
    }];
    
    UILabel *tit1 = [[UILabel alloc] init];
    [tit1 makeLabelWithText:@"周一至周五9:00~17:00" andTextColor:MBColor(151, 152, 153, 1) andFont:[UIFont yaHeiFontOfSize:13*Ratio]];
    [self.view addSubview:tit1];
    [tit1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(imag);
        make.top.equalTo(phoneNum.mas_bottom).offset(10*Ratio);
        make.size.mas_equalTo(CGSizeMake(135*Ratio, 16*Ratio));
    }];
    
}
-(void)phoneAction:(UIButton *)button{
    
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",@"021-64335531"];
    //            NSLog(@"str======%@",str);
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
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
