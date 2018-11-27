//
//  DoctorViewController.m
//  BabyDemo
//
//  Created by 陈彦 on 16/6/28.
//  Copyright © 2016年 elsa. All rights reserved.
//

#import "DoctorViewController.h"
#import "UIImageView+WebCache.h"

@interface DoctorViewController (){
    UIView *contentView;
    UIImageView *_leftView;
    UIButton *selMe;
}

@end

@implementation DoctorViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
#pragma mark = 左边按钮
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setImage:[UIImage imageNamed:@"back1"] forState:UIControlStateNormal];
    [leftBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -30, 0, 0)];
    [leftBtn addTarget:self action:@selector(returnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:leftBtn];
    [leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(Ratio);
        make.top.equalTo(self.view).offset(20*Ratio);
        make.size.mas_equalTo(CGSizeMake(50*Ratio, 35*Ratio));
    }];
    
    
#pragma mark = 题目
    UILabel *tit = [[UILabel alloc] init];
    [tit makeLabelWithText:@"医生简介" andTextColor:MBColor(250, 109, 166, 1) andFont:[UIFont yaHeiFontOfSize:20*Ratio]];
    tit.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:tit];
    [tit mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100*Ratio, 25*Ratio));
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).offset(22*Ratio);
    }];
    
    
    [self createInterface];
    // Do any additional setup after loading the view.
}
-(void)createInterface{
    UIScrollView *sc = [[UIScrollView alloc] init];
    [self.view addSubview:sc];
    [sc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(60*Ratio);
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
    _leftView.layer.borderColor = MBColor(245, 215, 216, 1).CGColor;
    [_leftView sd_setImageWithURL:[NSURL URLWithString:[NSString urlStringOfImage:_doctor.head]] placeholderImage:[UIImage imageNamed:@"chouti_01"]];
    [contentView addSubview:_leftView];
    [_leftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView).offset(10*Ratio);
        make.size.mas_equalTo(CGSizeMake(43*Ratio, 43*Ratio));
        make.top.equalTo(contentView);
    }];
    
    UILabel *doctorName = [[UILabel alloc] init];
    [doctorName makeLabelWithText:_doctor.doctorname andTextColor:MBColor(102, 103, 104, 1) andFont:[UIFont yaHeiFontOfSize:14*Ratio]];
    [contentView addSubview:doctorName];
    [doctorName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(80*Ratio, 21*Ratio));
        make.left.equalTo(_leftView.mas_right).offset(10*Ratio);
        make.top.equalTo(_leftView);
    }];
    
    UILabel *hospitalLab = [[UILabel alloc] init];
    [hospitalLab makeLabelWithText:_hospitalName andTextColor:MBColor(152, 153, 154, 1) andFont:[UIFont yaHeiFontOfSize:13*Ratio]];
    hospitalLab.numberOfLines = 0;
    [contentView addSubview:hospitalLab];
    CGSize size = [hospitalLab sizeThatFits:CGSizeMake(235*Ratio, 2000)];
    [hospitalLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(235*Ratio, size.height));
        make.left.equalTo(doctorName);
        make.right.equalTo(contentView).offset(-20*Ratio);
        make.top.equalTo(doctorName.mas_bottom);
    }];
    
    
    UILabel *zhicheng = [[UILabel alloc] init];
    [zhicheng makeLabelWithText:_doctor.positionaltitles andTextColor:MBColor(250, 109, 166, 1) andFont:[UIFont yaHeiFontOfSize:13*Ratio]];
    zhicheng.textAlignment = NSTextAlignmentRight;
    
    [contentView addSubview:zhicheng];
    [zhicheng mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(hospitalLab);
        make.size.mas_equalTo(CGSizeMake(80*Ratio, 21*Ratio));
        make.top.equalTo(doctorName);
    }];
    
    
    selMe = [UIButton buttonWithType:UIButtonTypeCustom];
    [selMe setBackgroundImage:[UIImage imageNamed:@"buy_selectdoctor"] forState:UIControlStateNormal];
    [selMe setBackgroundImage:[UIImage imageNamed:@"buy_selectdoctor_set"] forState:UIControlStateSelected];
    [selMe addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    selMe.selected = _isSel;
    [contentView addSubview:selMe];
    [selMe mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(60*Ratio, 27*Ratio));
        make.centerX.equalTo(contentView);
        make.top.equalTo(hospitalLab.mas_bottom).offset(10*Ratio);
    }];
    
    
    UILabel *line0 = [[UILabel alloc] init];
    line0.backgroundColor = MBColor(250, 109, 166, 1);
    [contentView addSubview:line0];
    [line0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(2*Ratio, 14*Ratio));
        make.left.equalTo(_leftView);
        make.top.equalTo(selMe.mas_bottom).offset(10*Ratio);
    }];
    
    
    UILabel *goodAt = [[UILabel alloc] init];
    [goodAt makeLabelWithText:@"擅长" andTextColor:MBColor(102, 103, 104, 1) andFont:[UIFont yaHeiFontOfSize:14*Ratio]];
    [contentView addSubview:goodAt];
    [goodAt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(40*Ratio, 17*Ratio));
        make.left.equalTo(line0.mas_right).offset(10*Ratio);
        make.centerY.equalTo(line0);
    }];
    
    UILabel *docGoodAt = [[UILabel alloc] init];
    [docGoodAt makeLabelWithText:_doctor.speciality andTextColor:MBColor(155, 153, 154, 1) andFont:[UIFont yaHeiFontOfSize:13*Ratio]];
    docGoodAt.numberOfLines = 0;
    [contentView addSubview:docGoodAt];
    CGSize size1 = [docGoodAt sizeThatFits:CGSizeMake(287*Ratio, 2000)];
    [docGoodAt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(287*Ratio, size1.height));
        make.top.equalTo(goodAt.mas_bottom).offset(10*Ratio);
        make.centerX.equalTo(contentView);
    }];
    
    
    
    UILabel *line1 = [[UILabel alloc] init];
    line1.backgroundColor = MBColor(250, 109, 166, 1);
    [contentView addSubview:line1];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(2*Ratio, 14*Ratio));
        make.left.equalTo(_leftView);
        make.top.equalTo(docGoodAt.mas_bottom).offset(10*Ratio);
    }];
    
    
    UILabel *introduce = [[UILabel alloc] init];
    [introduce makeLabelWithText:@"医生介绍" andTextColor:MBColor(102, 103, 104, 1) andFont:[UIFont yaHeiFontOfSize:14*Ratio]];
    [contentView addSubview:introduce];
    [introduce mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(80*Ratio, 17*Ratio));
        make.left.equalTo(line1.mas_right).offset(10*Ratio);
        make.centerY.equalTo(line1);
    }];
    
    
    UILabel *docIntroduction = [[UILabel alloc] init];
    [docIntroduction makeLabelWithText:_doctor.doctordesc andTextColor:MBColor(155, 153, 154, 1) andFont:[UIFont yaHeiFontOfSize:13*Ratio]];
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

-(void)buttonClick:(UIButton *)button{
    button.selected = !button.selected;
}
#pragma mark - 返回
-(void)returnAction:(UIButton *)buton{
    
    
    if (selMe.selected == YES) {
        self.selMeBlock();
    }
    [self dismissViewControllerAnimated:YES completion:nil];
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
