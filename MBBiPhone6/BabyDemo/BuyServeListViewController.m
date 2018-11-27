//
//  BuyServeListViewController.m
//  BabyDemo
//
//  Created by 陈彦 on 16/7/12.
//  Copyright © 2016年 elsa. All rights reserved.
//

#import "BuyServeListViewController.h"

@interface BuyServeListViewController ()

@end

@implementation BuyServeListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:MBColor(225, 253, 255, 1)];
    
    [self createInterface];
    // Do any additional setup after loading the view.
}

#pragma mark - 返回
-(void)returnAction:(UIButton *)buton{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)createInterface{
//#pragma mark = 左边按钮
//    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [leftBtn setImage:[UIImage imageNamed:@"back1"] forState:UIControlStateNormal];
//    [leftBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -30, 0, 0)];
//    [leftBtn addTarget:self action:@selector(returnAction:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:leftBtn];
//    [leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.view).offset(Ratio);
//        make.top.equalTo(self.view).offset(20*Ratio);
//        make.size.mas_equalTo(CGSizeMake(50*Ratio, 35*Ratio));
//    }];
//    
//    
//    UILabel *title = [[UILabel alloc] init];
//    [title makeLabelWithText:@"服务清单" andTextColor:MBColor(250, 109, 166, 1) andFont:[UIFont yaHeiFontOfSize:22*Ratio]];
//    title.textAlignment = NSTextAlignmentCenter;
//    [self.view addSubview:title];
//    [title mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.equalTo(self.view);
//        make.top.equalTo(self.view).offset(40*Ratio);
//        make.size.mas_equalTo(CGSizeMake(100*Ratio, 24*Ratio));
//    }];
    
    self.title = @"服务清单";
    
    UIImageView *listImg = [[UIImageView alloc] init];
    listImg.layer.masksToBounds = YES;
    listImg.layer.borderColor = MBColor(190, 191, 192, 1).CGColor;
    listImg.layer.borderWidth = 1;
    listImg.image = [UIImage imageNamed:@"list"];
    [self.view addSubview:listImg];
    [listImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).offset(10*Ratio);
        make.size.mas_equalTo(CGSizeMake(300*Ratio, 466.5*Ratio));
    }];
    
    
    UILabel *number = [[UILabel alloc] init];
    number.backgroundColor = [UIColor whiteColor];
    [number makeLabelWithText:[NSString stringWithFormat:@"%@次",_num] andTextColor:MBColor(49, 50, 51, 1) andFont:[UIFont yaHeiFontOfSize:17*Ratio]];
    number.textAlignment = NSTextAlignmentCenter;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:number.text];;
    [attributedString addAttribute:NSForegroundColorAttributeName value:MBColor(250, 109, 166, 1) range:NSMakeRange(0,number.text.length-1)];
    number.attributedText = attributedString;
    [listImg addSubview:number];
    [number mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(listImg).offset(21*Ratio);
        make.left.equalTo(listImg).offset(162*Ratio);
        make.size.mas_equalTo(CGSizeMake(42*Ratio, 19*Ratio));
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
