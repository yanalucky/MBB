//
//  AboutUsViewController.m
//  BabyDemo
//
//  Created by 陈彦 on 16/5/16.
//  Copyright © 2016年 elsa. All rights reserved.
//

#import "AboutUsViewController.h"

@interface AboutUsViewController ()

@end

@implementation AboutUsViewController


-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = NO;

}
-(void)returnBtn:(UIButton *)button{
    [self.navigationController popViewControllerAnimated:YES];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = MBColor(227, 252, 255, 1);
    
    self.navigationItem.title = @"关于我们";
    
    
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
    UIView *bgView = [[UIView alloc] init];
    bgView.backgroundColor = [UIColor whiteColor];
    bgView.layer.masksToBounds = YES;
    bgView.layer.cornerRadius = 10;
    [self.view addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(300*Ratio, 300*Ratio));
        make.left.equalTo(self.view).offset(10*Ratio);
        make.top.equalTo(self.view).offset(50*Ratio);
    }];
    
    
    UIImageView *logo = [[UIImageView alloc] init];
    logo.image = [UIImage imageNamed:@"login_logo"];
    [bgView addSubview:logo];
    [logo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(152*Ratio, 40*Ratio));
        make.left.equalTo(bgView).offset(70*Ratio);
        make.top.equalTo(bgView).offset(30*Ratio);
        
    }];
    
    
    UILabel *company = [[UILabel alloc] init];
    [company makeLabelWithText:@"上海豆蒙萌健康管理咨询有限公司" andTextColor:MBColor(102, 103, 104, 1) andFont:[UIFont yaHeiFontOfSize:13*Ratio]];
    [bgView addSubview:company];
    [company mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(bgView);
        make.top.equalTo(logo.mas_bottom).offset(5*Ratio);
        make.size.mas_equalTo(CGSizeMake(200*Ratio, 15*Ratio));
    }];
    
    
    UILabel *companyAddress = [[UILabel alloc] init];
    [companyAddress makeLabelWithText:@"上海市漕溪北路737弄1号楼3202室" andTextColor:MBColor(102, 103, 104, 1) andFont:[UIFont yaHeiFontOfSize:13*Ratio]];
    [bgView addSubview:companyAddress];
    [companyAddress mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(company);
        make.top.equalTo(company.mas_bottom).offset(27*Ratio);
        make.size.mas_equalTo(CGSizeMake(210*Ratio, 20*Ratio));
    }];
    
    
    
    UIButton *phoneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [phoneBtn setTitle:@"021-6433 5531" forState:UIControlStateNormal];
    [phoneBtn setTitleColor:MBColor(250, 109, 166, 1) forState:UIControlStateNormal];
    phoneBtn.titleLabel.font = [UIFont yaHeiFontOfSize:13*Ratio];
    phoneBtn.titleLabel.textAlignment = NSTextAlignmentLeft;
    NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc]initWithString:phoneBtn.titleLabel.text];
    NSRange contentRange = {0,[attributeStr length]};
    [attributeStr addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:contentRange];
    phoneBtn.titleLabel.attributedText = attributeStr;
    [phoneBtn addTarget:self action:@selector(phoneAction:) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:phoneBtn];
    [phoneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(company);
        make.top.equalTo(companyAddress.mas_bottom).offset(27*Ratio);
        make.size.mas_equalTo(CGSizeMake(100*Ratio, 20*Ratio));
    }];
    
//    UILabel *companyPhone = [[UILabel alloc] init];
//    [companyPhone makeLabelWithText:@"400-876-6060" andTextColor:MBColor(102, 103, 104, 1) andFont:[UIFont yaHeiFontOfSize:13*Ratio]];
//    [bgView addSubview:companyPhone];
//    [companyPhone mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(company);
//        make.top.equalTo(companyAddress.mas_bottom).offset(27*Ratio);
//        make.size.mas_equalTo(CGSizeMake(210*Ratio, 20*Ratio));
//    }];
//    
    UILabel *companyEmail = [[UILabel alloc] init];
    [companyEmail makeLabelWithText:@"customerservice@mengbaobao.com" andTextColor:MBColor(102, 103, 104, 1) andFont:[UIFont yaHeiFontOfSize:13*Ratio]];
    [bgView addSubview:companyEmail];
    [companyEmail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(company);
        make.top.equalTo(phoneBtn.mas_bottom).offset(27*Ratio);
        make.size.mas_equalTo(CGSizeMake(230*Ratio, 20*Ratio));
    }];
    
    
    UILabel *companyWeb = [[UILabel alloc] init];
    [companyWeb makeLabelWithText:@"www.mengbaobao.com" andTextColor:MBColor(102, 103, 104, 1) andFont:[UIFont yaHeiFontOfSize:13*Ratio]];
    [bgView addSubview:companyWeb];
    [companyWeb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(company);
        make.top.equalTo(companyEmail.mas_bottom).offset(27*Ratio);
        make.size.mas_equalTo(CGSizeMake(210*Ratio, 20*Ratio));
    }];
    
    for (int i=0; i<4; i++) {
        UIImageView *imag0 = [[UIImageView alloc] init];
        imag0.image = [UIImage imageNamed:[NSString stringWithFormat:@"icon_chouti_our_%d",i+1]];
        [bgView addSubview:imag0];
        [imag0 mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.size.mas_equalTo(CGSizeMake(16*Ratio, 16*Ratio));
            make.top.equalTo(company.mas_bottom).offset((30+ (47*i))*Ratio);
            make.right.equalTo(companyWeb.mas_left).offset(-15*Ratio);
            
        }];
    }
    
    
    
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
