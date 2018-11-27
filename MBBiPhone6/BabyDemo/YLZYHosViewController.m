//
//  YLZYHosViewController.m
//  BabyDemo
//
//  Created by 曹露 on 16/9/9.
//  Copyright © 2016年 elsa. All rights reserved.
//

#import "YLZYHosViewController.h"
#import "ServerConfigHospitalList.h"
#import "UIImageView+WebCache.h"

@interface YLZYHosViewController ()

@end

@implementation YLZYHosViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"医院简介";
    [self createInterface];
    
    // Do any additional setup after loading the view.
}
-(void)createInterface{
    
    UILabel *titleLab = [[UILabel alloc] init];
    [titleLab makeLabelWithText:_hospital.hospitalname andTextColor:MBColor(250, 109, 166, 1) andFont:[UIFont yaHeiFontOfSize:14*Ratio]];
    titleLab.textAlignment = NSTextAlignmentCenter;
    titleLab.numberOfLines = 0;
//    titleLab.adjustsFontSizeToFitWidth = YES;
    [self.view addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).offset(20*Ratio);
        make.size.mas_equalTo(CGSizeMake(300*Ratio, 40*Ratio));
    }];
    
    NSArray *titArr = @[@"类型：",@"电话：",@"地址："];
    NSArray *messArr = @[_hospital.hospitaltype,_hospital.hospitalphone,_hospital.hospitaladdress];
    UILabel *lastLab = nil;
    for (int i=0; i<3; i++) {
        
       
        
        UILabel *lab1 = [[UILabel alloc] init];
        [lab1 makeLabelWithText:messArr[i] andTextColor:MBColor(101, 102, 103, 1) andFont:[UIFont yaHeiFontOfSize:12*Ratio]];
        lab1.numberOfLines = 0;
        [self.view addSubview:lab1];
        CGSize size = [lab1 sizeThatFits:CGSizeMake(235*Ratio, 500*Ratio)];
        [lab1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view).offset(65*Ratio);
            make.size.mas_equalTo(CGSizeMake(235*Ratio, size.height));
            if (lastLab) {
                make.top.equalTo(lastLab.mas_bottom).offset(17*Ratio);
            }else{
                make.top.equalTo(titleLab.mas_bottom).offset(10*Ratio);
            }
        }];
        
        UILabel *lab0 = [[UILabel alloc] init];
        [lab0 makeLabelWithText:titArr[i] andTextColor:MBColor(250, 109, 166, 1) andFont:[UIFont yaHeiFontOfSize:12*Ratio]];
        [self.view addSubview:lab0];
        [lab0 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view).offset(15*Ratio);
            make.size.mas_equalTo(CGSizeMake(40*Ratio, 20*Ratio));
            make.top.equalTo(lab1).offset(-2*Ratio);
            
            
        }];
        lastLab = lab1;
        
        
        
        if (i>0) {
            
            UIImageView *imag0 = [[UIImageView alloc] init];
            imag0.image = [UIImage imageNamed:(i==1)?@"yiliao_phone":@"yiliao_address"];
            [self.view addSubview:imag0];
            [imag0 mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.size.mas_equalTo(CGSizeMake(10*Ratio, 10*Ratio));
                make.top.equalTo(lab1).offset(3*Ratio);
                make.right.equalTo(lab1.mas_left).offset(-3*Ratio);
                
            }];
            
        }
        
    }
    
    
    
    
    UIImageView *imageView = [[UIImageView alloc] init];
//     placeholderImage:[UIImage imageNamed:@"buy_time_02"]
    [imageView sd_setImageWithURL:[NSURL URLWithString:[NSString urlStringOfImage:_hospital.map]]];
    [self.view addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(300*Ratio, 186*Ratio));
        make.centerX.equalTo(self.view);
        make.top.equalTo(lastLab.mas_bottom).offset(18*Ratio);
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
