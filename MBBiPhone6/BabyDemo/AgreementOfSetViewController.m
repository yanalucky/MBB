//
//  AgreementOfSetViewController.m
//  BabyDemo
//
//  Created by 陈彦 on 16/5/31.
//  Copyright © 2016年 elsa. All rights reserved.
//

#import "AgreementOfSetViewController.h"

@interface AgreementOfSetViewController ()

@end

@implementation AgreementOfSetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"使用协议";
//    self.navigationController.interactivePopGestureRecognizer.delegate = nil;
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
