//
//  Fcgo_RegistWaitVC.m
//  Fcgo
//
//  Created by huafanxiao on 2017/6/13.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_RegistWaitVC.h"

@interface Fcgo_RegistWaitVC ()

@end

@implementation Fcgo_RegistWaitVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupUI];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.fd_fullscreenPopGestureRecognizer.enabled = NO;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.fd_fullscreenPopGestureRecognizer.enabled = YES;
}

- (void)setupUI;
{
    WEAKSELF(weakSelf)
    [self.navigationView setupBackBtnBlock:^{
        [weakSelf.navigationController popToRootViewControllerAnimated:YES];
    }];
    [self.navigationView setupTitleLabelWithTitle:@"等待审核"];
    
    [self.navigationView setupBackTitle:@"返回登录"];
    
    UIImageView *imageView = [[UIImageView alloc]init];
//    imageView.center = CGPointMake(kScreenWidth/2, KScreenHeight/2-kAutoWidth6(120));
//    imageView.bounds = CGRectMake(0, 0, kAutoWidth6(150), kAutoWidth6(150));
    imageView.userInteractionEnabled = 1;
    //publicImageView.backgroundColor = [UIColor redColor];
    imageView.image = [UIImage imageNamed:@"check"];
    [self.view addSubview:imageView];
    
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(164);
        make.height.width.mas_offset(kAutoWidth6(120));
        make.centerX.mas_equalTo(weakSelf.view);
        
    }];
    
    UILabel *bigLabel = [[UILabel alloc]init];
    bigLabel.font = [UIFont boldSystemFontOfSize:16];
    bigLabel.text = @"注册资料提交成功";
    bigLabel.textColor = UIFontMainGrayColor;
    bigLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:bigLabel];
    
    
    [bigLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(imageView.mas_bottom).mas_offset(25);
        make.left.mas_offset(15);
        make.right.mas_offset(-15);
    }];
    
    UILabel *midleLabel = [[UILabel alloc]init];
    midleLabel.font = [UIFont boldSystemFontOfSize:15];
    midleLabel.text = @"工作人员会在七个工作日内主动联系您确认事项，\n请您耐心等待";
    midleLabel.textColor = UIFontRedColor;
    midleLabel.numberOfLines = 2;
    midleLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:midleLabel];
    [midleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(bigLabel.mas_bottom).mas_offset(15);
        make.left.mas_offset(15);
        make.right.mas_offset(-15);
    }];
    
    
    UILabel *bottomLabel = [[UILabel alloc]init];
    bottomLabel.font = [UIFont systemFontOfSize:15];
    bottomLabel.text = @"感谢您的加盟";
    bottomLabel.textColor = UIFontMainGrayColor;
    bottomLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:bottomLabel];
    
    [bottomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(midleLabel.mas_bottom).mas_offset(15);
        make.left.mas_offset(15);
        make.right.mas_offset(-15);
    }];
    
    
    
    UILabel *phoneLab = [[UILabel alloc] initWithFrame:CGRectMake(100, 200, 200, 40 )];
    phoneLab.text = @"如有疑问,请联系客服:400-888-8761";
    phoneLab.textColor = UIFontBlack282828;
    phoneLab.font = [UIFont systemFontOfSize:12];
    phoneLab.textAlignment = NSTextAlignmentCenter;
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:phoneLab.text];
    NSRange range1 = NSMakeRange(11, phoneLab.text.length - 11);
    [attrStr addAttribute:NSForegroundColorAttributeName value:UIFontRedColor range:range1];
    phoneLab.attributedText = attrStr;
    phoneLab.userInteractionEnabled = YES;
    [phoneLab addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(call)]];
    [self.view addSubview:phoneLab];
    [phoneLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(-kTabBarBottomMargin- kAutoHeight6(30));
        make.centerX.equalTo(self.view);
    }];
}

-(void)call{
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",@"400-888-8761"];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
}

@end
