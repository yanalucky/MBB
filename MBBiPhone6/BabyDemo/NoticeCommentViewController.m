//
//  NoticeCommentViewController.m
//  BabyDemo
//
//  Created by 陈彦 on 16/6/30.
//  Copyright © 2016年 elsa. All rights reserved.
//

#import "NoticeCommentViewController.h"
#import "LoginUser.h"
#import "ServerConfigDoctorList.h"
#import "ServerConfigHospitalList.h"

#import "UIImageView+WebCache.h"
#import "PictureViewController.h"


@interface NoticeCommentViewController (){
   
    LoginUser *user;
    NSString *_userRole;

    UIButton *month;
    int _month;
    
    UIView *starView;
    UILabel *feedStyle;
    UILabel *commentDetail;
    UILabel *commentDetail1;
    
    UIView *neverNum;
    UILabel *PGtishi;
    

}

@end

@implementation NoticeCommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"评估报告";
    NSDictionary *userDic = [[NSUserDefaults standardUserDefaults] objectForKey:@"user"];
    user = [[LoginUser alloc] initWithDictionary:userDic];
    _userRole = [[NSUserDefaults standardUserDefaults] objectForKey:@"userRole"];
    _month = [[[NSUserDefaults standardUserDefaults] objectForKey:@"month"] intValue];

    [self createInterface];
    // Do any additional setup after loading the view.
}

-(void)createInterface{
    if ([self respondsToSelector:@selector(automaticallyAdjustsScrollViewInsets)]) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    UIScrollView *sc = [[UIScrollView alloc] init];
    [self.view addSubview:sc];
    [sc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self.view);
        make.top.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-137*Ratio);
    }];
    UIView *contentView = [[UIView alloc] init];
    [sc addSubview:contentView];
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(sc);
        make.width.equalTo(sc);
    }];
#pragma mark = 编号
    UILabel *fileNum = [[UILabel alloc] init];
    [fileNum makeLabelWithText:[NSString stringWithFormat:@"档案编号：%@",(!user.filecode)?@"无":user.filecode] andTextColor:MBColor(102, 102, 102, 1) andFont:[UIFont yaHeiFontOfSize:10*Ratio]];
    [contentView addSubview:fileNum];
    [fileNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contentView).offset(14*Ratio);
        make.left.equalTo(contentView).offset(10*Ratio);
        make.size.mas_equalTo(CGSizeMake(160*Ratio, 12*Ratio));
    }];
    
#pragma mark = 生日
    UILabel *birth = [[UILabel alloc] init];
    [birth makeLabelWithText:[NSString stringWithFormat:@"生日：%@",user.birthday] andTextColor:MBColor(102, 102, 102, 1) andFont:[UIFont yaHeiFontOfSize:10*Ratio]];
    birth.textAlignment = NSTextAlignmentRight;
    [contentView addSubview:birth];
    [birth mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(contentView).offset(-10*Ratio);
        make.centerY.equalTo(fileNum);
        make.size.mas_equalTo(CGSizeMake(100*Ratio, 12*Ratio));
    }];
#pragma mark = 月龄
    month = [UIButton buttonWithType:UIButtonTypeCustom];
    [month setBackgroundImage:[UIImage imageNamed:@"pinggu_xian"] forState:UIControlStateNormal];
    [month setTitle:[NSString stringWithFormat:@"%@个月",_currentOnline.appraisalage] forState:UIControlStateNormal];
    [month setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [contentView addSubview:month];
    [month mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(contentView);
        make.top.equalTo(birth.mas_bottom).offset(10*Ratio);
        make.size.mas_equalTo(CGSizeMake(150*Ratio, 14*Ratio));
    }];
#pragma mark = 名字与性别
    UIImageView *sexImg = [[UIImageView alloc] init];
    sexImg.image = [UIImage imageNamed:[NSString stringWithFormat:@"shouye_icon_red_%@",user.sex]];

    [contentView addSubview:sexImg];
    [sexImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView).offset(32.5*Ratio);
        make.top.equalTo(month.mas_bottom).offset(10*Ratio);
        make.size.mas_equalTo(CGSizeMake(10*Ratio, 10*Ratio));
    }];
    
    
    UILabel *name = [[UILabel alloc] init];
    [name makeLabelWithText:user.truename andTextColor:MBColor(102, 102, 102, 1) andFont:[UIFont yaHeiFontOfSize:11*Ratio]];
    [contentView addSubview:name];
    [name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(sexImg);
        make.left.equalTo(sexImg.mas_right).offset(5*Ratio);
        make.size.mas_equalTo(CGSizeMake(50*Ratio, 14*Ratio));
    }];
    
#pragma mark = 星星
    int starNum = [_currentOnline.star intValue];
    starView = [[UIView alloc] init];
    [contentView addSubview:starView];
    [starView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(name);
        make.centerX.mas_equalTo(contentView);
        make.height.mas_equalTo(15*Ratio);
        
    }];
    [starView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(15*starNum*Ratio);
        
    }];
    UIImageView *lastStar = nil;
    
    for (int i=0; i<starNum; i++) {
        UIImageView *star = [[UIImageView alloc] init];
        star.image = [UIImage imageNamed:@"star"];
        [starView addSubview:star];
        [star mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(15*Ratio, 15*Ratio));
            make.centerY.equalTo(starView);
            if (lastStar) {
                make.left.equalTo(lastStar.mas_right);
            }else{
                make.left.equalTo(starView);
            }
        }];
        lastStar = star;
    }
    
    
    
    
#pragma mark = 宝宝是否足月及喂养方式
    
    UILabel *fullMonth = [[UILabel alloc] init];
    int enter = [user.borntype intValue];
    NSString *bordTypeStr = nil;
    if (enter == 1) {
        bordTypeStr = @"足月儿";
    }else if (enter == 2){
        bordTypeStr = @"早产儿";
    }else if (enter == 3){
        bordTypeStr = @"低出生体重";
    }else{
        bordTypeStr = @"";
    }
    [fullMonth makeLabelWithText:bordTypeStr andTextColor:MBColor(102, 102, 102, 1) andFont:[UIFont yaHeiFontOfSize:11*Ratio]];
    fullMonth.textAlignment = NSTextAlignmentCenter;
    [contentView addSubview:fullMonth];
    [fullMonth mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(starView.mas_centerY);
        make.right.equalTo(contentView).offset(-24*Ratio);
        make.size.mas_equalTo(CGSizeMake(70*Ratio, 14*Ratio));
    }];
    
    
    feedStyle = [[UILabel alloc] init];
    int temp = _currentOnline.feedingType;
    NSString *feedingTypeStr = nil;
    if (temp == 1) {
        feedingTypeStr = @"母乳喂养";
    }else if (temp == 2){
        feedingTypeStr = @"配方奶喂养";
    }else if (temp == 3){
        feedingTypeStr = @"混合喂养";
    }else{
        feedingTypeStr = @"";
    }
    [feedStyle makeLabelWithText:feedingTypeStr andTextColor:MBColor(102, 102, 102, 1) andFont:[UIFont yaHeiFontOfSize:11*Ratio]];
    feedStyle.textAlignment = NSTextAlignmentCenter;
    [contentView addSubview:feedStyle];
    [feedStyle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(starView.mas_centerY);
        make.right.equalTo(contentView).offset(-24*Ratio);
        make.size.mas_equalTo(CGSizeMake(70*Ratio, 14*Ratio));
    }];
#pragma mark = 划线
    [contentView addLineWithY:87];
    
    
    
#pragma mark = 医生头像及指导
    /*
    UIImageView *doctorHeader = [[UIImageView alloc] init];
    NSDictionary *_localDoctorDic = [[NSUserDefaults standardUserDefaults] objectForKey:@"doctorDic"];

    ServerConfigDoctorList *doctor = [[ServerConfigDoctorList alloc] initWithDictionary:[_localDoctorDic objectForKey:_currentOnline.doctorid]];
    
    [doctorHeader sd_setImageWithURL:[NSURL URLWithString:[NSString urlStringOfImage:doctor.head]] placeholderImage:[UIImage imageNamed:@"chouti_01"]];
    doctorHeader.layer.masksToBounds = YES;
    doctorHeader.layer.cornerRadius = 25*(Ratio/2);
    [contentView addSubview:doctorHeader];
    [doctorHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(starView.mas_bottom).offset(20*Ratio);
        make.size.mas_equalTo(CGSizeMake(25*Ratio, 25*Ratio));
        make.left.equalTo(contentView).offset(15*Ratio);
        
    }];
    
    UILabel *commentTitle = [[UILabel alloc] init];
    [commentTitle makeLabelWithText:@"体格生长评估" andTextColor:MBColor(239, 67, 153, 1) andFont:[UIFont yaHeiFontOfSize:14*Ratio]];
    [contentView addSubview:commentTitle];
    [commentTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(doctorHeader.mas_right).offset(5*Ratio);
        make.centerY.equalTo(doctorHeader);
        make.size.mas_equalTo(CGSizeMake(150*Ratio, 15*Ratio));
        
    }];
    
    commentDetail = [[UILabel alloc] init];
    
    [commentDetail makeLabelWithText:([[_currentOnline.growthappraisal stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length] == 0)?@"敬请期待":([_currentOnline.growthappraisal stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]) andTextColor:MBColor(83, 83, 83, 1) andFont:[UIFont yaHeiFontOfSize:13*Ratio]];
    commentDetail.numberOfLines = 0;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:commentDetail.text];;
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:6];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, commentDetail.text.length)];
    commentDetail.attributedText = attributedString;
    CGSize size = [commentDetail sizeThatFits:CGSizeMake(234*Ratio, 200000)];
    [contentView addSubview:commentDetail];
    [commentDetail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(commentTitle.mas_bottom).offset(5*Ratio);
        make.width.mas_equalTo(234*Ratio);
        make.height.mas_equalTo(size.height);
        make.centerX.equalTo(contentView);
    }];
    UILabel *commentTitle1 = [[UILabel alloc] init];
    [commentTitle1 makeLabelWithText:@"神经心理、发育行为评估" andTextColor:MBColor(239, 67, 153, 1) andFont:[UIFont yaHeiFontOfSize:14*Ratio]];
    [contentView addSubview:commentTitle1];
    [commentTitle1 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(commentTitle);
        make.top.equalTo(commentDetail.mas_bottom).offset(5*Ratio);
        make.size.mas_equalTo(CGSizeMake(200*Ratio, 15*Ratio));
        
    }];
    
    commentDetail1 = [[UILabel alloc] init];
    [commentDetail1 makeLabelWithText:([[_currentOnline.mindappraisal stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length] == 0)?@"敬请期待":([_currentOnline.mindappraisal stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]) andTextColor:MBColor(83, 83, 83, 1) andFont:[UIFont yaHeiFontOfSize:13*Ratio]];
    commentDetail1.numberOfLines = 0;
    
    NSMutableAttributedString *attributedString1 = [[NSMutableAttributedString alloc]initWithString:commentDetail1.text];;
    [attributedString1 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, commentDetail1.text.length)];
    commentDetail1.attributedText = attributedString1;
    CGSize size1 = [commentDetail1 sizeThatFits:CGSizeMake(234*Ratio, 200000)];
    [contentView addSubview:commentDetail1];
    [commentDetail1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(commentTitle1.mas_bottom).offset(5*Ratio);
        make.width.mas_equalTo(234*Ratio);
        make.height.mas_equalTo(size1.height);
        make.centerX.equalTo(contentView);
    }];
    */
    
    UIImageView *doctorHeader = [[UIImageView alloc] init];
    NSDictionary *_localDoctorDic = [[NSUserDefaults standardUserDefaults] objectForKey:@"doctorDic"];

    ServerConfigDoctorList *doctor = [[ServerConfigDoctorList alloc] initWithDictionary:[_localDoctorDic objectForKey:_currentOnline.doctorid]];
    ServerConfigHospitalList *hospital = [[ServerConfigHospitalList alloc] initWithDictionary:[[[NSUserDefaults standardUserDefaults] objectForKey:@"hospitalDic"] objectForKey:doctor.hospitalid]];
    
    [doctorHeader sd_setImageWithURL:[NSURL URLWithString:[NSString urlStringOfImage:doctor.head]] placeholderImage:[UIImage imageNamed:@"chouti_01"]];
    doctorHeader.layer.masksToBounds = YES;
    doctorHeader.layer.cornerRadius = 30*Ratio;
    [contentView addSubview:doctorHeader];
    [doctorHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(starView.mas_bottom).offset(25*Ratio);
        make.size.mas_equalTo(CGSizeMake(60*Ratio, ([_userRole intValue] == 0)?0:60*Ratio));
        make.left.equalTo(contentView).offset(25*Ratio);
        
    }];
    
    UILabel *doctorName = [[UILabel alloc] init];
    [doctorName makeLabelWithText:doctor.doctorname andTextColor:MBColor(51, 51, 51, 1) andFont:[UIFont yaHeiFontOfSize:14*Ratio]];
    [contentView addSubview:doctorName];
    [doctorName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(doctorHeader.mas_right).offset(10*Ratio);
        make.top.equalTo(doctorHeader);
        make.size.mas_equalTo(CGSizeMake(120*Ratio, 18*Ratio));
    }];
    
    UILabel *doctorPositionaltitles = [[UILabel alloc] init];
    [doctorPositionaltitles makeLabelWithText:doctor.positionaltitles andTextColor:MBColor(128, 128, 128, 1) andFont:[UIFont yaHeiFontOfSize:12*Ratio]];
    [contentView addSubview:doctorPositionaltitles];
    [doctorPositionaltitles mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(doctorHeader.mas_right).offset(10*Ratio);
        make.top.equalTo(doctorName.mas_bottom).offset(10*Ratio);
        make.size.mas_equalTo(CGSizeMake(120*Ratio, 13*Ratio));
    }];
    
    UILabel *hospitalName = [[UILabel alloc] init];
    [hospitalName makeLabelWithText:hospital.hospitalname andTextColor:MBColor(128, 128, 128, 1) andFont:[UIFont yaHeiFontOfSize:12*Ratio]];
    hospitalName.numberOfLines = 0;
    [contentView addSubview:hospitalName];
    [hospitalName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(200*Ratio, 13*Ratio));
        make.left.equalTo(doctorPositionaltitles);
        make.top.equalTo(doctorPositionaltitles.mas_bottom).offset(10*Ratio);
    }];
    
    
    
    
    
    
    UILabel *commentTitle = [[UILabel alloc] init];
    
    [commentTitle makeLabelWithText:([_userRole intValue] == 0)?@"体格生长评估，神经心理、发育行为评估":@"体格生长评估" andTextColor:MBColor(239, 67, 153, 1) andFont:[UIFont yaHeiFontOfSize:14*Ratio]];
    [contentView addSubview:commentTitle];
    [commentTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(contentView);
        make.top.equalTo(doctorHeader.mas_bottom).offset(30*Ratio);
        make.size.mas_equalTo(CGSizeMake(320*Ratio, 15*Ratio));
        
    }];
    commentTitle.textAlignment = NSTextAlignmentCenter;
    
    commentDetail = [[UILabel alloc] init];
    NSString *commmentDetail_161012 = [_currentOnline.growthappraisal stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    [commentDetail makeLabelWithText:([[_currentOnline.growthappraisal stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length] == 0)?@"宝宝生长发育好不好可以请儿保专家来评估一下哦！":commmentDetail_161012 andTextColor:MBColor(83, 83, 83, 1) andFont:[UIFont yaHeiFontOfSize:13*Ratio]];
    commentDetail.numberOfLines = 0;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:commentDetail.text];;
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:6];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, commentDetail.text.length)];
    commentDetail.attributedText = attributedString;
    CGSize size = [commentDetail sizeThatFits:CGSizeMake(234*Ratio, 200000)];
    [contentView addSubview:commentDetail];
    [commentDetail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(commentTitle.mas_bottom).offset(5*Ratio);
        make.width.mas_equalTo(237*Ratio);
        make.height.mas_equalTo(size.height + 15);
        make.centerX.equalTo(contentView);
    }];
    UILabel *commentTitle1 = [[UILabel alloc] init];
    [commentTitle1 makeLabelWithText:([_userRole intValue] == 0)?@"":@"神经心理、发育行为评估" andTextColor:MBColor(239, 67, 153, 1) andFont:[UIFont yaHeiFontOfSize:14*Ratio]];
    [contentView addSubview:commentTitle1];
    commentTitle1.textAlignment = NSTextAlignmentCenter;
    
    [commentTitle1 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(contentView);
        make.top.equalTo(commentDetail.mas_bottom).offset(5*Ratio);
        make.size.mas_equalTo(CGSizeMake(320*Ratio, 15*Ratio));
        
    }];
    
    commentDetail1 = [[UILabel alloc] init];
    NSString *commmentDetail1_161012 = [_currentOnline.mindappraisal stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    [commentDetail1 makeLabelWithText:([[_currentOnline.mindappraisal stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length] == 0)?@"":commmentDetail1_161012 andTextColor:MBColor(83, 83, 83, 1) andFont:[UIFont yaHeiFontOfSize:13*Ratio]];
    commentDetail1.numberOfLines = 0;
    
    NSMutableAttributedString *attributedString1 = [[NSMutableAttributedString alloc]initWithString:commentDetail1.text];;
    [attributedString1 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, commentDetail1.text.length)];
    commentDetail1.attributedText = attributedString1;
    CGSize size1 = [commentDetail1 sizeThatFits:CGSizeMake(234*Ratio, 200000)];
    [contentView addSubview:commentDetail1];
    [commentDetail1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(commentTitle1.mas_bottom).offset(5*Ratio);
        make.width.mas_equalTo(237*Ratio);
        make.height.mas_equalTo(size1.height);
        make.centerX.equalTo(contentView);
    }];
    

    
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(commentDetail1);
    }];
    
    
    [self.view addLineWithY:367 + 20];
#pragma mark = 四个图
    NSArray *butonArr = @[@"pinggu_icon_long",@"pinggu_icon_height",@"pinggu_icon_bmi",@"pinggu_icon_fayu",@"pinggu_icon_long_set",@"pinggu_icon_height_set",@"pinggu_icon_bmi_set",@"pinggu_icon_fayu_set"];
    UIButton *lastBtn = nil;
    for (int i=0; i<4; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setBackgroundImage:[UIImage imageNamed:butonArr[i]] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:butonArr[4+i]] forState:UIControlStateSelected];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = 1180+i;
        [self.view addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(sc.mas_bottom).offset(18*Ratio);
            make.size.mas_equalTo(CGSizeMake(75*Ratio, 57*Ratio));
            if (lastBtn) {
                make.left.equalTo(lastBtn.mas_right).offset(5*Ratio);
            }else{
                make.left.equalTo(self.view).offset(5*Ratio);
            }
        }];
        
        lastBtn = button;
    }

}
#pragma mark - 成长发育图

-(void)buttonClick:(UIButton *)button{
    int numb = button.tag - 1180;
    NSLog(@"第%d个btn 被点击",numb);
    for (int i=0; i<4; i++) {
        UIButton *butt = (UIButton *)[self.view viewWithTag:1180+i];
        butt.selected = NO;
    }
    button.selected = YES;
    
    PictureViewController *pvc = [[PictureViewController alloc] initWithMonth:_month andSex:[user.sex boolValue]];
    pvc.number = numb + 1;
    pvc.imgDataArr = _imgData;
    
    
    NSArray *currentArr =[_currentOnline.feature componentsSeparatedByString:@","];
    NSMutableArray *currentMutableArr = [NSMutableArray arrayWithArray:currentArr];
    [currentMutableArr removeObject:@""];
    pvc.currentMonthFeatureArr = currentMutableArr;
//    pvc.currentMonthFeatureArr = [_currentOnline.feature componentsSeparatedByString:@","];
    [self.navigationController pushViewController:pvc animated:YES];
    
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
