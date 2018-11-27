//
//  SalonViewController.m
//  BabyDemo
//
//  Created by 陈彦 on 16/6/23.
//  Copyright © 2016年 elsa. All rights reserved.
//

#import "SalonViewController.h"
#import "UIImageView+WebCache.m"

@interface SalonViewController ()

@end

@implementation SalonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = _titleStr;
    [self createInterface];
    // Do any additional setup after loading the view.
}

-(void)createInterface{
    
    

    UILabel *detailLabel = [[UILabel alloc] init];
    [detailLabel makeLabelWithText:@"详细信息" andTextColor:MBColor(250, 109, 166, 1) andFont:[UIFont yaHeiFontOfSize:14*Ratio]];
    detailLabel.textAlignment= NSTextAlignmentCenter;
    [self.view addSubview:detailLabel];
    [detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(88*Ratio, 21*Ratio));
        make.top.equalTo(self.view).offset(20*Ratio);
    }];
    UILabel *lastLab = nil;
    for (int i=0; i<_titleArr.count; i++) {
        UILabel *label = [[UILabel alloc] init];
        [label makeLabelWithText:_arrr[i] andTextColor:MBColor(102, 103, 104, 1) andFont:[UIFont yaHeiFontOfSize:12*Ratio]];
        label.numberOfLines = 0;
        CGSize size = [label sizeThatFits:CGSizeMake(222*Ratio, 4000*Ratio)];
        [self.view addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(222*Ratio, size.height));
            make.right.equalTo(self.view).offset(-12*Ratio);
            if (lastLab) {
                make.top.equalTo(lastLab.mas_bottom).offset(15*Ratio);
            }else{
                make.top.equalTo(detailLabel.mas_bottom).offset(15*Ratio);
            }
            
        }];
        
        lastLab = label;
        
        
        
        
        UILabel *titLabel = [[UILabel alloc] init];
        [titLabel makeLabelWithText:_titleArr[i] andTextColor:MBColor(250, 109, 166, 1) andFont:[UIFont yaHeiFontOfSize:12*Ratio]];
        [self.view addSubview:titLabel];
        [titLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(75*Ratio, 20*Ratio));
            make.centerY.equalTo(label);
            make.left.equalTo(self.view).offset(12*Ratio);
        }];
        
        
    }
    
    
    UIImageView *imageView = [[UIImageView alloc] init];
    [imageView sd_setImageWithURL:[NSURL URLWithString:[NSString urlStringOfImage:_imgStr]] placeholderImage:[UIImage imageNamed:@"buy_time_02"]];
    [self.view addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(300*Ratio, 186*Ratio));
        make.left.equalTo(self.view).offset(12*Ratio);
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
