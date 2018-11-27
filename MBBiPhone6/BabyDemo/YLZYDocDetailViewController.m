//
//  YLZYDocDetailViewController.m
//  BabyDemo
//
//  Created by 曹露 on 16/9/8.
//  Copyright © 2016年 elsa. All rights reserved.
//

#import "YLZYDocDetailViewController.h"
#import "UIImageView+WebCache.h"
#import "ServerConfigDoctorList.h"
#import "ServerConfigHospitalList.h"

@interface YLZYDocDetailViewController (){
    UIView *contentView;
    UIImageView *_leftView;
}


@end

@implementation YLZYDocDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    
    self.title = @"医生简介";
    
    
    [self createInterface];
    
    
    // Do any additional setup after loading the view.
}
-(void)createInterface{
    UIScrollView *sc = [[UIScrollView alloc] init];
    [self.view addSubview:sc];
    [sc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.left.and.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
        
        
    }];
    
    
    sc.bounces = NO;
    
    contentView = [[UIView alloc] init];
    contentView.backgroundColor = [UIColor whiteColor];
    
    [sc addSubview:contentView];
    
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.equalTo(sc);
        make.width.equalTo(sc);
    }];
    
    _leftView = [[UIImageView alloc] init];
    _leftView.layer.masksToBounds = YES;
    _leftView.layer.cornerRadius = 22*Ratio;
    _leftView.layer.borderWidth = 1;
    _leftView.layer.borderColor = MBColor(149, 243, 235, 1).CGColor;
    [_leftView sd_setImageWithURL:[NSURL URLWithString:[NSString urlStringOfImage:_doctor.head]] placeholderImage:[UIImage imageNamed:@"chouti_01"]];
    [contentView addSubview:_leftView];
    [_leftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView).offset(13*Ratio);
        make.size.mas_equalTo(CGSizeMake(44*Ratio, 44*Ratio));
        make.top.equalTo(contentView).offset(16*Ratio);
    }];
    
    UILabel *doctorName = [[UILabel alloc] init];
    [doctorName makeLabelWithText:_doctor.doctorname andTextColor:MBColor(51, 52, 53, 1) andFont:[UIFont yaHeiFontOfSize:14*Ratio]];
    [contentView addSubview:doctorName];
    [doctorName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(60*Ratio, 21*Ratio));
        make.left.equalTo(_leftView.mas_right).offset(10*Ratio);
        make.top.equalTo(contentView).offset(15*Ratio);
    }];
    
    
    
    UILabel *hospitalLab = [[UILabel alloc] init];
    NSDictionary *hospitalDic = [[NSUserDefaults standardUserDefaults] objectForKey:@"hospitalDic"];

    ServerConfigHospitalList *hospital = [[ServerConfigHospitalList alloc] initWithDictionary:[hospitalDic objectForKey:_doctor.hospitalid]];

    [hospitalLab makeLabelWithText:hospital.hospitalname andTextColor:MBColor(102, 102, 102, 1) andFont:[UIFont yaHeiFontOfSize:13*Ratio]];
    hospitalLab.numberOfLines = 0;
    [contentView addSubview:hospitalLab];
    CGSize size = [hospitalLab sizeThatFits:CGSizeMake(240*Ratio, 2000)];
    [hospitalLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(240*Ratio, size.height));
        make.left.equalTo(doctorName);
        make.right.equalTo(contentView).offset(-12*Ratio);
        make.top.equalTo(doctorName.mas_bottom).offset(5*Ratio);
        
    }];
    
    
    UILabel *zhicheng = [[UILabel alloc] init];
    [zhicheng makeLabelWithText:_doctor.positionaltitles andTextColor:MBColor(250, 109, 166, 1) andFont:[UIFont yaHeiFontOfSize:13*Ratio]];
    zhicheng.textAlignment = NSTextAlignmentLeft;
    
    [contentView addSubview:zhicheng];
    [zhicheng mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(hospitalLab);
        make.size.mas_equalTo(CGSizeMake(80*Ratio, 21*Ratio));
        make.top.equalTo(hospitalLab.mas_bottom).offset(5*Ratio);
    }];
    

    
    
    
    
    
    
    UILabel *lin1 = [[UILabel alloc] init];
    lin1.backgroundColor = MBColor(225, 253, 255, 1);
    [contentView addSubview:lin1];
    [lin1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(320*Ratio, 5*Ratio));
        make.centerX.equalTo(contentView);
        make.top.equalTo(zhicheng.mas_bottom).offset(8*Ratio);
    }];
    
    
    
    UILabel *line0 = [[UILabel alloc] init];
    line0.backgroundColor = MBColor(153, 244, 237, 1);
    [contentView addSubview:line0];
    [line0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(2*Ratio, 14*Ratio));
        make.left.equalTo(_leftView);
        make.top.equalTo(lin1.mas_bottom).offset(10*Ratio);
    }];
    
    
    UILabel *goodAt = [[UILabel alloc] init];
    [goodAt makeLabelWithText:@"擅长" andTextColor:MBColor(51, 52, 53, 1) andFont:[UIFont yaHeiFontOfSize:14*Ratio]];
    [contentView addSubview:goodAt];
    [goodAt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(40*Ratio, 17*Ratio));
        make.left.equalTo(line0.mas_right).offset(10*Ratio);
        make.centerY.equalTo(line0);
    }];
    
    UILabel *docGoodAt = [[UILabel alloc] init];
    [docGoodAt makeLabelWithText:_doctor.speciality andTextColor:MBColor(102, 103, 104, 1) andFont:[UIFont yaHeiFontOfSize:13*Ratio]];
    docGoodAt.numberOfLines = 0;
    [contentView addSubview:docGoodAt];
    CGSize size1 = [docGoodAt sizeThatFits:CGSizeMake(287*Ratio, 2000)];
    [docGoodAt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(287*Ratio, size1.height));
        make.top.equalTo(goodAt.mas_bottom).offset(10*Ratio);
        make.centerX.equalTo(contentView);
    }];
    
    
    UILabel *lin2 = [[UILabel alloc] init];
    lin2.backgroundColor = MBColor(225, 253, 255, 1);
    [contentView addSubview:lin2];
    [lin2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(320*Ratio, 5*Ratio));
        make.centerX.equalTo(contentView);
        make.top.equalTo(docGoodAt.mas_bottom).offset(8*Ratio);
    }];
    
    
    UILabel *line1 = [[UILabel alloc] init];
    line1.backgroundColor = MBColor(153, 244, 237, 1);
    [contentView addSubview:line1];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(2*Ratio, 14*Ratio));
        make.left.equalTo(_leftView);
        make.top.equalTo(lin2.mas_bottom).offset(10*Ratio);
    }];
    
    
    UILabel *introduce = [[UILabel alloc] init];
    [introduce makeLabelWithText:@"医生介绍" andTextColor:MBColor(51, 52, 53, 1) andFont:[UIFont yaHeiFontOfSize:14*Ratio]];
    [contentView addSubview:introduce];
    [introduce mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(80*Ratio, 17*Ratio));
        make.left.equalTo(line1.mas_right).offset(10*Ratio);
        make.centerY.equalTo(line1);
    }];
    
    
    UILabel *docIntroduction = [[UILabel alloc] init];
    [docIntroduction makeLabelWithText:_doctor.doctordesc andTextColor:MBColor(102, 103, 104, 1) andFont:[UIFont yaHeiFontOfSize:13*Ratio]];
    docIntroduction.numberOfLines = 0;
    [contentView addSubview:docIntroduction];
    CGSize size2 = [docIntroduction sizeThatFits:CGSizeMake(287*Ratio, 2000)];
    [docIntroduction mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(287*Ratio, size2.height));
        make.top.equalTo(introduce.mas_bottom).offset(10*Ratio);
        make.centerX.equalTo(contentView);
    }];
    
    
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.equalTo(docIntroduction).offset(5*Ratio);
    }];
    
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