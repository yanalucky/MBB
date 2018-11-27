//
//  AgreementViewController.m
//  BabyDemo
//
//  Created by 陈彦 on 16/5/5.
//  Copyright © 2016年 elsa. All rights reserved.
//

#import "AgreementViewController.h"

@interface AgreementViewController ()

@end

@implementation AgreementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self createInterface];
    // Do any additional setup after loading the view.

}
-(void)createInterface{
#pragma mark = 左侧返回按钮
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
#pragma mark = 标题
    UILabel *title = [[UILabel alloc] init];
    [title makeLabelWithText:@"使用协议" andTextColor:MBColor(250, 109, 166, 1) andFont:[UIFont yaHeiFontOfSize:22*Ratio]];
    title.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).offset(30*Ratio);
        make.size.mas_equalTo(CGSizeMake(100*Ratio, 23*Ratio));
    }];
    
    UIScrollView *sc = [[UIScrollView alloc] init];
    [self.view addSubview:sc];
    [sc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(title.mas_bottom).offset(10*Ratio);
        make.left.and.right.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-65*Ratio);
        
    }];
    sc.bounces = NO;
    
    UIView *contentView = [[UIView alloc] init];
    contentView.backgroundColor = [UIColor whiteColor];
    [sc addSubview:contentView];
    
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.equalTo(sc);
        make.width.equalTo(sc);
    }];
    
#pragma mark = 读txt文件
    
    NSData *data = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"agreement" ofType:@"txt"]];
    NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding (kCFStringEncodingGB_18030_2000);
    NSString *str = [[NSString alloc] initWithData:data encoding:enc];
//    NSLog(@"%@",str);
    
    UILabel *agreementDetail = [[UILabel alloc] init];
    agreementDetail.numberOfLines = 0;
    [agreementDetail makeLabelWithText:str andTextColor:MBColor(101, 102, 103, 1) andFont:[UIFont yaHeiFontOfSize:11*Ratio]];

    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:agreementDetail.text];;
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:6];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, agreementDetail.text.length)];
    agreementDetail.attributedText = attributedString;
    CGSize size = [agreementDetail sizeThatFits:CGSizeMake(310*Ratio, 200000)];
    [contentView addSubview:agreementDetail];
    [agreementDetail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(310*Ratio));
        make.height.equalTo(@(size.height+(20*Ratio)));
        make.left.equalTo(sc).offset(5*Ratio);
        make.top.equalTo(sc).offset(10*Ratio);

    }];

    
    
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.equalTo(agreementDetail).offset(5*Ratio);
    }];
    
    
#pragma mark = 同意
    
    UIButton *finish = [UIButton buttonWithType:UIButtonTypeCustom];
    [finish addTarget:self action:@selector(returnAction:) forControlEvents:UIControlEventTouchUpInside];
    finish.layer.masksToBounds = YES;
    finish.layer.cornerRadius = 10;
    [finish setTitle:@"同意" forState:UIControlStateNormal];
    [finish setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [finish setBackgroundColor:MBColor(252, 109, 166, 1)];
    [self.view addSubview:finish];
    [finish mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(10*Ratio);
        make.right.equalTo(self.view).offset(-10*Ratio);
        make.top.equalTo(sc.mas_bottom).offset(12*Ratio);
        make.height.mas_equalTo(40*Ratio);
    }];
    
}

#pragma mark - 返回
-(void)returnAction:(UIButton *)buton{
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
