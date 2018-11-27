//
//  MenuViewController.m
//  BabyDemo
//
//  Created by 陈彦 on 16/7/7.
//  Copyright © 2016年 elsa. All rights reserved.
//

#import "MenuViewController.h"

@interface MenuViewController ()

@end

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"服务套餐信息";
    self.view.backgroundColor = [UIColor whiteColor];
    [self createInterface];
    // Do any additional setup after loading the view.
}
-(void)createInterface{
    
    
    
    
    
    NSLog(@"menuArr = %@",_menuArr);
    NSArray *arr = @[@"服务期限",@"专属医生",@"专属医院"];
    UILabel *lastLab = nil;
    for (int i=0; i<3; i++) {
        UILabel *label = [[UILabel alloc] init];
        [label makeLabelWithText:[NSString stringWithFormat:@"%@   %@",arr[i],_menuArr[i]] andTextColor:MBColor(102, 103, 104, 1) andFont:[UIFont yaHeiFontOfSize:13*Ratio]];
        [self.view addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(277*Ratio, 25*Ratio));
            make.centerX.equalTo(self.view);
            if (lastLab) {
                make.top.equalTo(lastLab.mas_bottom);
            }else{
                make.top.equalTo(self.view).offset(5*Ratio);
            }
            
        }];
        lastLab = label;
    }
    
    
    
    UILabel *fuwu = [[UILabel alloc] init];
    fuwu.backgroundColor = MBColor(205, 250, 249, 1);
    [fuwu makeLabelWithText:[NSString stringWithFormat:@"线上服务（%@）",_menuArr[3]] andTextColor:MBColor(51, 52, 53, 1) andFont:[UIFont yaHeiFontOfSize:13*Ratio]];
    fuwu.layer.masksToBounds = YES;
    
    fuwu.layer.shadowColor = [UIColor blueColor].CGColor;
    fuwu.layer.shadowOffset = CGSizeMake(5, 0);
    fuwu.layer.shadowOpacity = 0.8;
    fuwu.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:fuwu];
    [fuwu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(277*Ratio, 25*Ratio));
        make.top.equalTo(lastLab.mas_bottom).offset(5*Ratio);
        make.centerX.equalTo(self.view);
    }];
    
    
    UIImageView *img = [[UIImageView alloc] init];
    img.image = [UIImage imageNamed:@"list"];
    
    img.layer.shadowColor = MBColor(205, 250, 249, 1).CGColor;
    img.layer.shadowOffset = CGSizeMake(3, 0);
    img.layer.shadowOpacity = 0.5;
    [self.view addSubview:img];
    [img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(245*Ratio, 378*Ratio));
        make.centerX.equalTo(self.view);
        make.top.equalTo(fuwu.mas_bottom).offset(10*Ratio);
    }];
    
    
    
    
    UILabel *number = [[UILabel alloc] init];
    number.backgroundColor = [UIColor whiteColor];
    [number makeLabelWithText:[NSString stringWithFormat:@"%@次",[_menuArr lastObject]] andTextColor:MBColor(49, 50, 51, 1) andFont:[UIFont yaHeiFontOfSize:17*Ratio]];
    number.textAlignment = NSTextAlignmentCenter;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:number.text];;
    [attributedString addAttribute:NSForegroundColorAttributeName value:MBColor(250, 109, 166, 1) range:NSMakeRange(0,number.text.length-1)];
    number.attributedText = attributedString;
    [img addSubview:number];
    [number mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(img).offset(14*Ratio);
        make.left.equalTo(img).offset(133*Ratio);
        make.size.mas_equalTo(CGSizeMake(32*Ratio, 19*Ratio));
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
