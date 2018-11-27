//
//  SalonDetailViewController.m
//  BabyDemo
//
//  Created by 陈彦 on 16/7/4.
//  Copyright © 2016年 elsa. All rights reserved.
//

#import "SalonDetailViewController.h"
#import "ServerConfigTheLatestThreeSalonList.h"
#import "ServerConfigDoctorList.h"
#import "UIImageView+WebCache.h"




@interface SalonDetailViewController (){
    NSDictionary *_salonCurrentDic;
}

@end

@implementation SalonDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"育儿沙龙";
    NSArray *salonThreeArr = [[[NSUserDefaults standardUserDefaults] objectForKey:@"salonDic"] allValues];

    if (salonThreeArr) {
        if (salonThreeArr.count == 3) {
            _salonCurrentDic = [salonThreeArr objectAtIndex:_num];

            [self creatInterface];
            
            
        }
    }
    
    // Do any additional setup after loading the view.
}


-(void)creatInterface{
    
    ServerConfigTheLatestThreeSalonList *salonModel = [[ServerConfigTheLatestThreeSalonList alloc] initWithDictionary:_salonCurrentDic];
    
    
    
    UIScrollView *sc = [[UIScrollView alloc] init];
    sc.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:sc];
    [sc mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.equalTo(self.view);
        make.height.equalTo(self.view);
        make.center.equalTo(self.view);
        
    }];
    
    UIView *contentView = [[UIView alloc] init];
    contentView.backgroundColor = [UIColor whiteColor];
    [sc addSubview:contentView];
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(sc);
        make.edges.equalTo(sc);
    }];
    
    
    UILabel *titleLab = [[UILabel alloc] init];
    [titleLab makeLabelWithText:salonModel.salontopic andTextColor:MBColor(250, 109, 166, 1) andFont:[UIFont yaHeiFontOfSize:16*Ratio]];
    
    titleLab.adjustsFontSizeToFitWidth = YES;
    titleLab.textAlignment = NSTextAlignmentCenter;
    [contentView addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(contentView);
        make.size.mas_equalTo(CGSizeMake(285*Ratio, 40*Ratio));
        make.top.equalTo(contentView).offset(15*Ratio);
    }];
    
    
    
    UILabel *detailLab = [[UILabel alloc] init];
    detailLab.numberOfLines = 0;
    [detailLab makeLabelWithText:salonModel.salongdesc andTextColor:MBColor(102, 103, 104, 1) andFont:[UIFont yaHeiFontOfSize:13*Ratio]];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:detailLab.text];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.alignment = NSTextAlignmentLeft;
    paragraphStyle.maximumLineHeight = 60;  //最大的行高
    paragraphStyle.lineSpacing = 5*Ratio;  //行自定义行高度
    [paragraphStyle setFirstLineHeadIndent:23*Ratio];//首行缩进 
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, detailLab.text.length)];
    detailLab.attributedText = attributedString;
    CGSize size = [detailLab sizeThatFits:CGSizeMake(285*Ratio, 20000)];
    
    [contentView addSubview:detailLab];
    [detailLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(contentView);
        make.size.mas_equalTo(CGSizeMake(285*Ratio, size.height));
        make.top.equalTo(titleLab.mas_bottom).offset(5*Ratio);
    }];
    
    UILabel *doctorLabe = [[UILabel alloc] init];
    
    ServerConfigDoctorList *doctorModel = [[ServerConfigDoctorList alloc] initWithDictionary:[[[NSUserDefaults standardUserDefaults] objectForKey:@"doctorDic"] objectForKey:salonModel.guestid]];
    [doctorLabe makeLabelWithText:[NSString stringWithFormat:@"%@：%@",salonModel.salonguest,doctorModel.doctordesc] andTextColor:MBColor(102, 103, 104, 1) andFont:[UIFont yaHeiFontOfSize:13*Ratio]];
    doctorLabe.numberOfLines = 0;
    
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:doctorLabe.text];
    NSMutableParagraphStyle *paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle1.lineSpacing = 5*Ratio;
    [string addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, doctorLabe.text.length)];
    [string addAttribute:NSForegroundColorAttributeName value:MBColor(250, 109, 166, 1) range:NSMakeRange(0, salonModel.salonguest.length + 1)];
    
    doctorLabe.attributedText = string;
    CGSize size1 = [doctorLabe sizeThatFits:CGSizeMake(285*Ratio, 2000000)];
    [contentView addSubview:doctorLabe];
    [doctorLabe mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(285*Ratio, size1.height));
        make.top.equalTo(detailLab.mas_bottom).offset(10*Ratio);
        make.left.equalTo(detailLab);
    }];
    
    
    UILabel *doctorGoodAt = [[UILabel alloc] init];
    [doctorGoodAt makeLabelWithText:[NSString stringWithFormat:@"主要医疗专长：%@",doctorModel.speciality] andTextColor:MBColor(102, 103, 104, 1) andFont:[UIFont yaHeiFontOfSize:13*Ratio]];
    doctorGoodAt.numberOfLines = 0;
    NSMutableAttributedString *string1 = [[NSMutableAttributedString alloc] initWithString:doctorGoodAt.text];
    [string1 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, doctorGoodAt.text.length)];
    [string1 addAttribute:NSForegroundColorAttributeName value:MBColor(250, 109, 166, 1) range:NSMakeRange(0, 7)];
    doctorGoodAt.attributedText = string1;
    CGSize size2 = [doctorGoodAt sizeThatFits:CGSizeMake(285*Ratio, 2000000)];
    [contentView addSubview:doctorGoodAt];
    [doctorGoodAt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(285*Ratio, size2.height));
        make.top.equalTo(doctorLabe.mas_bottom).offset(5*Ratio);
        make.left.equalTo(doctorLabe);
    }];
    
    UILabel *timeLab = [[UILabel alloc] init];
    [timeLab makeLabelWithText:[NSString stringWithFormat:@"时间：    %@",salonModel.salontime] andTextColor:MBColor(102, 103, 104, 1) andFont:[UIFont yaHeiFontOfSize:13*Ratio]];
    NSMutableAttributedString *string2 = [[NSMutableAttributedString alloc] initWithString:timeLab.text];
    [string2 addAttribute:NSForegroundColorAttributeName value:MBColor(250, 109, 166, 1) range:NSMakeRange(0, 3)];
    timeLab.attributedText = string2;
    [contentView addSubview:timeLab];
    [timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(285*Ratio, 15*Ratio));
        make.left.equalTo(doctorGoodAt);
        make.top.equalTo(doctorGoodAt.mas_bottom).offset(5*Ratio);
    }];
    
    UILabel *address = [[UILabel alloc] init];
    [address makeLabelWithText:[NSString stringWithFormat:@"地址：    %@",salonModel.salonaddress] andTextColor:MBColor(102, 103, 104, 1) andFont:[UIFont yaHeiFontOfSize:13*Ratio]];
    NSMutableAttributedString *string3 = [[NSMutableAttributedString alloc] initWithString:address.text];
    [string3 addAttribute:NSForegroundColorAttributeName value:MBColor(250, 109, 166, 1) range:NSMakeRange(0, 3)];
    address.attributedText = string3;
    address.adjustsFontSizeToFitWidth = YES;
    [contentView addSubview:address];
    [address mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(285*Ratio, 15*Ratio));
        make.left.equalTo(doctorGoodAt);
        make.top.equalTo(timeLab.mas_bottom).offset(5*Ratio);
    }];
    if (salonModel.contactperson&&salonModel.contactperson.length > 0){
        UILabel *contentPerson = [[UILabel alloc] init];
        //📞%@ ,
        [contentPerson makeLabelWithText:[NSString stringWithFormat:@"接待人员：%@",salonModel.contactperson] andTextColor:MBColor(102, 103, 104, 1) andFont:[UIFont yaHeiFontOfSize:13*Ratio]];
        NSMutableAttributedString *string4 = [[NSMutableAttributedString alloc] initWithString:contentPerson.text];
        [string4 addAttribute:NSForegroundColorAttributeName value:MBColor(250, 109, 166, 1) range:NSMakeRange(0, 5)];
        contentPerson.attributedText = string4;
        //    contentPerson.adjustsFontSizeToFitWidth = YES;
        [contentView addSubview:contentPerson];
        [contentPerson mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(110*Ratio, 15*Ratio));
            make.left.equalTo(doctorGoodAt);
            make.top.equalTo(address.mas_bottom).offset(5*Ratio);
        }];
        if (salonModel.contactmobile&&salonModel.contactmobile.length > 0) {
            UIButton *phone = [UIButton buttonWithType:UIButtonTypeCustom];
            [phone setImage:[UIImage imageNamed:@"shalong_tel"] forState:UIControlStateNormal];
            [phone setTitle:salonModel.contactmobile forState:UIControlStateNormal];
            [phone setTitleColor:MBColor(102, 103, 104, 1) forState:UIControlStateNormal];
            [phone addTarget:self action:@selector(phoneAction:) forControlEvents:UIControlEventTouchUpInside];
            //下划线
            [phone setTitleColor:MBColor(250, 109, 166, 1) forState:UIControlStateNormal];
            
            NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:phone.titleLabel.text];
            NSRange strRange = {0,[str length]};
            [str addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:strRange];
            [phone setAttributedTitle:str forState:UIControlStateNormal];
            [contentView addSubview:phone];
            [phone mas_makeConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(CGSizeMake(100*Ratio, 15*Ratio));
                make.centerY.equalTo(contentPerson);
                make.left.equalTo(contentPerson.mas_right);
            }];
        }
        

    }
    
    
    
    
    UIImageView *imag = [[UIImageView alloc] init];
    [imag sd_setImageWithURL:[NSURL URLWithString:[NSString urlStringOfImage:salonModel.salonimg]] placeholderImage:[UIImage imageNamed:@"cover_01"]];
    
    [contentView addSubview:imag];
    [imag mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(300*Ratio, 188*Ratio));
        make.top.equalTo(address.mas_bottom).offset(25*Ratio);
        make.centerX.equalTo(contentView);
    }];
    
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.equalTo(imag).offset(5*Ratio);
    }];
    
    
}
-(void)phoneAction:(UIButton *)button{
    ServerConfigTheLatestThreeSalonList *salonModel = [[ServerConfigTheLatestThreeSalonList alloc] initWithDictionary:_salonCurrentDic];

    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",salonModel.contactmobile];
    //            NSLog(@"str======%@",str);
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
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
