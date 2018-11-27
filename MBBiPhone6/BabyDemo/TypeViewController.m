//
//  TypeViewController.m
//  BabyDemo
//
//  Created by 陈彦 on 16/5/5.
//  Copyright © 2016年 elsa. All rights reserved.
//

#import "TypeViewController.h"
#import "SelDoctorViewController.h"
#import "FillInfoViewController.h"

@interface TypeViewController (){
    NSArray *_currentDataArr;
    NSArray *freeArr;
    NSArray *vipArr;
    
    UILabel *title;
    UIButton *experience;
}

@end

@implementation TypeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _currentDataArr = [[NSArray alloc] init];
    self.view.backgroundColor = [UIColor whiteColor];
    
    freeArr = @[@"宝妈在线提交萌宝的体格生长参数（体重、身长、奶量、头围、胸围、睡眠、排泄）",@"获得萌宝的体格生长曲线图（身长曲线图、体重曲线图、身长体重比曲线图）和发育进程图"];
    vipArr = @[@"在线提交萌宝的体格生长参数（体重、身长、奶量、头围等）和发育行为（大运动、精细运动、神经和认知发展等）观察记录",@"获得萌宝体格生长曲线图（身长曲线图、体重曲线图、身长体重比曲线图）和发育进程图",@"获得专属医生根据萌宝体格生长指标和神经心理发育做出的评估报告",@"获得专属医生为您萌宝提供的个性化专业养育指导"];
    _currentDataArr = freeArr;

    [self createInterface];
    // Do any additional setup after loading the view.
}

-(void)createInterface{
    
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setImage:[UIImage imageNamed:@"cancel"] forState:UIControlStateNormal];
    [leftBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -30, 0, 0)];
    [leftBtn addTarget:self action:@selector(returnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:leftBtn];
    [leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(Ratio);
        make.top.equalTo(self.view).offset(20*Ratio);
        make.size.mas_equalTo(CGSizeMake(50*Ratio, 35*Ratio));
    }];
#pragma mark = logo
    UIImageView *logo = [[UIImageView alloc] init];
    logo.image = [UIImage imageNamed:@"login_logo"];
    [self.view addSubview:logo];
    [logo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(100*Ratio, 28*Ratio));
        make.top.equalTo(self.view).offset(29*Ratio);
    }];
    
#pragma mark = 标题
    title = [[UILabel alloc] init];
    [title makeLabelWithText:@"免费体验" andTextColor:MBColor(112, 112, 112, 1) andFont:[UIFont yaHeiFontOfSize:26*Ratio]];
    title.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(120*Ratio, 30*Ratio));
        make.top.equalTo(logo.mas_bottom).offset(15*Ratio);
        make.centerX.equalTo(self.view);
    }];
    NSArray *arr = @[freeArr,vipArr];
    for (int i=0; i<2; i++) {
        UIView *view0 = [[UIView alloc] init];
        view0.backgroundColor = [UIColor whiteColor];
        view0.tag = 1198+i;
        [self.view addSubview:view0];
        [view0 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.and.right.equalTo(self.view);
            make.top.equalTo(self.view).offset(116*Ratio);
            make.height.mas_equalTo(300*Ratio);
        }];
        if (i==1) {
            UILabel *littleTitle = [[UILabel alloc] init];
            [littleTitle makeLabelWithText:@"线上服务" andTextColor:MBColor(249, 116, 170, 1) andFont:[UIFont yaHeiFontOfSize:16*Ratio]];
            [view0 addSubview:littleTitle];
            [littleTitle mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(view0).offset(5*Ratio);
                make.left.equalTo(view0).offset(18*Ratio);
                make.size.mas_equalTo(CGSizeMake(100*Ratio, 19*Ratio));
            }];
        }
        UILabel *lastReferTo = nil;
        for (int j=0; j<[arr[i] count]; j++) {
            UILabel *referTo0 = [[UILabel alloc] init];
            referTo0.numberOfLines = 0;
            [referTo0 makeLabelWithText:arr[i][j] andTextColor:MBColor(128, 128, 128, 1) andFont:[UIFont yaHeiFontOfSize:12*Ratio]];
            
            NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:referTo0.text];;
            NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
            [paragraphStyle setLineSpacing:6];
            [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, referTo0.text.length)];
            referTo0.attributedText = attributedString;
            CGSize size = [referTo0 sizeThatFits:CGSizeMake(260*Ratio, 200000)];
            [view0 addSubview:referTo0];
            [referTo0 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.width.equalTo(@(260*Ratio));
                make.height.equalTo(@(size.height));
                make.left.equalTo(view0).offset(36*Ratio);
                if (lastReferTo) {
                    make.top.equalTo(lastReferTo.mas_bottom).offset(10*Ratio);
                }else{
                    make.top.equalTo(view0).offset((i==0)?15*Ratio:40*Ratio);
                }
            }];
            
            lastReferTo = referTo0;
            
            UIImageView *edge = [[UIImageView alloc] init];
            edge.image = [UIImage imageNamed:@"free_point"];
            [view0 addSubview:edge];
            [edge mas_makeConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(CGSizeMake(6*Ratio, 6*Ratio));
                make.right.equalTo(referTo0.mas_left).offset(-10*Ratio);
                make.top.equalTo(referTo0).offset(6*Ratio);
                
            }];
            
        }
        
    }
    
    
   
    
    
#pragma mark = 按钮
    UIButton *button0 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button0 setImage:[[UIImage imageNamed:@"register_circle"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    [button0 setImage:[[UIImage imageNamed:@"register_circle_set"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateHighlighted];
    [button0 setImage:[[UIImage imageNamed:@"register_circle_set"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateSelected];

    button0.selected = YES;
    button0.tag = 1196;
    [button0 addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button0];
    [button0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(36*Ratio, 70*Ratio));
        make.left.equalTo(self.view).offset(50*Ratio);
        make.bottom.equalTo(self.view).offset(-104*Ratio);
    }];
    UILabel *tit0 = [[UILabel alloc] init];
    tit0.textAlignment = NSTextAlignmentCenter;
    [tit0 makeLabelWithText:@"免费体验" andTextColor:MBColor(249, 116, 170, 1) andFont:[UIFont yaHeiFontOfSize:11*Ratio]];
    [button0 addSubview:tit0];
    [tit0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(button0);
        make.bottom.equalTo(button0);
        make.size.mas_equalTo(CGSizeMake(46*Ratio, 20*Ratio));
    }];
    
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button1 setImage:[[UIImage imageNamed:@"register_circle"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    [button1 setImage:[[UIImage imageNamed:@"register_circle_set"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateHighlighted];
    [button1 setImage:[[UIImage imageNamed:@"register_circle_set"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateSelected];
    button1.tag = 1197;
    [button1 addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button1];
    [button1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(36*Ratio, 70*Ratio));
        make.right.equalTo(self.view).offset(-50*Ratio);
        make.bottom.equalTo(self.view).offset(-104*Ratio);
    }];
    UILabel *tit1 = [[UILabel alloc] init];
    tit1.textAlignment = NSTextAlignmentCenter;
    [tit1 makeLabelWithText:@"会员" andTextColor:MBColor(249, 116, 170, 1) andFont:[UIFont yaHeiFontOfSize:11*Ratio]];
    [button1 addSubview:tit1];
    [tit1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(button1);
        make.bottom.equalTo(button1);
        make.size.mas_equalTo(CGSizeMake(36*Ratio, 20*Ratio));
    }];
    UIImageView *lineView = [[UIImageView alloc] init];
    lineView.image = [UIImage imageNamed:@"yonghu_xian"];
    [self.view addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.centerY.equalTo(button1); 
        make.height.mas_equalTo(0.5*Ratio);
        make.width.mas_equalTo(135*Ratio);
    }];
    experience = [UIButton buttonWithType:UIButtonTypeCustom];
    [experience addTarget:self action:@selector(experience:) forControlEvents:UIControlEventTouchUpInside];
    experience.layer.masksToBounds = YES;
    experience.layer.cornerRadius = 10;
    [experience setTitle:@"开始体验" forState:UIControlStateNormal];
    [experience setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [experience setBackgroundColor:MBColor(252, 109, 166, 1)];
    [self.view addSubview:experience];
    [experience mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(10*Ratio);
        make.right.equalTo(self.view).offset(-10*Ratio);
        make.top.equalTo(button1.mas_bottom).offset(40*Ratio);
        make.height.mas_equalTo(40*Ratio);
    }];
    
    
    
    
    [self.view bringSubviewToFront:[self.view viewWithTag:1198]];



}

#pragma mark - 返回
-(void)returnAction:(UIButton *)buton{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - 体验类型
-(void)buttonClick:(UIButton *)button{
    
    for (int i=0; i<2; i++) {
        UIButton *btn = (UIButton *)[self.view viewWithTag:1196+i];
        btn.selected = NO;
    }
    button.selected = YES;
    
    if (button.tag == 1196) {
        _currentDataArr = freeArr;
    }else if (button.tag == 1197){
        _currentDataArr = vipArr;
    }
    if (button.tag == 1196) {
        title.text = @"免费体验";
        [experience setTitle:@"开始体验" forState:UIControlStateNormal];

    }else if (button.tag == 1197){
        title.text = @"会员";
        [experience setTitle:@"线上服务" forState:UIControlStateNormal];

    }
    [self.view bringSubviewToFront:[self.view viewWithTag:1198+(button.tag - 1196)]];

}

#pragma mark - 跳转
-(void)experience:(UIButton *)button{
    if ([button.titleLabel.text isEqualToString:@"线上服务"]) {
        SelDoctorViewController *sec = [[SelDoctorViewController alloc] init];
        [self presentViewController:sec animated:NO completion:nil];
    }else{
        FillInfoViewController *fvc = [[FillInfoViewController alloc] init];
        fvc.isLong = NO;
        [self presentViewController:fvc animated:YES completion:nil];
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
