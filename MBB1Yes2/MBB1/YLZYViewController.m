//
//  YLZYViewController.m
//  MBB
//
//  Created by 陈彦 on 15/9/1.
//  Copyright (c) 2015年 elsa. All rights reserved.
//

#import "YLZYViewController.h"
#import "AppDelegate.h"
#import "YLZYTableViewCell.h"
#import "RightView.h"
#import "DataModels.h"
#import "UIImageView+WebCache.h"
@interface YLZYViewController ()<UITableViewDataSource,UITableViewDelegate>{
    BOOL _isDoctor;
    UIView *_right1;
    UIImageView *_bigHeader;
    UILabel *_doctorName;
    UILabel *_hospitalName;
    UILabel *_doctotGrade;
    UILabel *_doctorBegood;
    UILabel *_doctorDetail;
    UIScrollView *sc;
}
@end

@implementation YLZYViewController
-(void)viewWillAppear:(BOOL)animated{
    
    
    
    for (int i=0; i<2; i++) {
        UIButton *butt = (UIButton *)[self.view viewWithTag:60+i];
        butt.selected = NO;
        UIImageView *ivm = (UIImageView *)[self.view viewWithTag:50+i];
        ivm.hidden = YES;
    }
    UIButton *button = (UIButton *)[self.view viewWithTag:60];
    button.selected = YES;
    UIImageView *iv = (UIImageView *)[self.view viewWithTag:button.tag-10];
    iv.hidden = NO;
    [self.view bringSubviewToFront:_right1];
        
    _isDoctor = YES;
    
    
    [_tableView reloadData];
    [self updateRight1:0];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _doctorDataArr = [[NSMutableArray alloc] init];
    _hospicalDataArr = [[NSMutableArray alloc] init];
    NSFileManager *manager = [NSFileManager defaultManager];
    NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/severCon.plist"];
    if ([manager fileExistsAtPath:path]) {
        NSData *data = [NSData dataWithContentsOfFile:path];
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSArray *arr0 =[[dic objectForKey:@"result"] objectForKey:@"DoctorList"];
        for (id obj in arr0) {
            if ([obj isKindOfClass:[NSDictionary class]]) {
                NSDictionary *doctList = (NSDictionary *)obj;
                ServerConfigDoctorList *doctor = [[ServerConfigDoctorList alloc] initWithDictionary:doctList];
                [_doctorDataArr addObject:doctor];
            }
        }
        NSArray *arr1 = [[dic objectForKey:@"result"] objectForKey:@"HospitalList"];
        for (id obj in arr1) {
            if ([obj isKindOfClass:[NSDictionary class]]) {
                NSDictionary *hospitalList = (NSDictionary *)obj;
                ServerConfigHospitalList *hospital = [[ServerConfigHospitalList alloc] initWithDictionary:hospitalList];
                [_hospicalDataArr addObject:hospital];
            }
        }
        
    }else{
        NSLog(@"路径不存在！");
    }
    
    if (self.sex == YES) {
        wordColor = BOY_WORDCOLOR;
        
        bgColor = BOY_RIGHTVIEWCOLOR;
    }else{
        wordColor = GIRL_WORDCOLOR;
        bgColor = GIRL_RIGHTVIEWCOLOR;
    }
    
    /**
     假数据
     
     
     */
    
    
    if ([self respondsToSelector:@selector(automaticallyAdjustsScrollViewInsets)]) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    NSArray *arr = @[@"医生介绍",@"医院介绍"];
    for (int i=0; i<2; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(220+116*i, 90, 120, 40);
        [button setTitle:arr[i] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont yaHeiFontOfSize:18];
        button.tag = 60+i;
        [button setTitleColor:WORDDARKCOLOR forState:UIControlStateNormal];
        [button setTitleColor:wordColor forState:UIControlStateSelected];
        button.titleLabel.font = [UIFont yaHeiFontOfSize:18];
        button.titleLabel.textColor = WORDDARKCOLOR;
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:button];
        
        
        UIImageView   *lable = [[UIImageView alloc] initWithFrame:CGRectMake(button.frame.origin.x, button.frame.origin.y+button.frame.size.height, button.frame.size.width, 4)];
        lable.image = [UIImage imageNamed:@"yiliao-xian" ofSex:self.sex];
        lable.tag = 50+i;
        lable.hidden = YES;
        [self.view addSubview:lable];
        if (i==0) {
            lable.hidden = NO;
            button.selected = YES;
        }
    }
    UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(167, 133, 330, 1)];
    line.backgroundColor = wordColor;
    [self.view addSubview:line];
    

    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(175, 155, 318, self.view.frame.size.height-155) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.showsVerticalScrollIndicator = YES;
    
    [self createRightView];

    [self.view addSubview:_tableView];
    [_right0 updateConstraints];
    [_right1 updateConstraints];
    // Do any additional setup after loading the view.
}
-(void)buttonClick:(UIButton *)button{
    for (int i=0; i<2; i++) {
        UIButton *butt = (UIButton *)[self.view viewWithTag:60+i];
        butt.selected = NO;
        UIImageView *ivm = (UIImageView *)[self.view viewWithTag:50+i];
        ivm.hidden = YES;
    }
    button.selected = YES;
    UIImageView *iv = (UIImageView *)[self.view viewWithTag:button.tag-10];
    iv.hidden = NO;
    if (button.tag == 60) {
        [self.view bringSubviewToFront:_right1];
        
        _isDoctor = YES;
    }else{
        [self.view bringSubviewToFront:_right0];
        _isDoctor = NO;
        
    }
    
    [_tableView reloadData];
    
    
}
#pragma mark - tableView相关
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *str = @"str";
    YLZYTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YLZYTableViewCell" owner:self options:nil] firstObject];
    }
        if (_isDoctor) {
        ServerConfigDoctorList *doct = (ServerConfigDoctorList *)_doctorDataArr[indexPath.row];
        NSString *str = [NSString stringWithFormat:@"%@%@",PREFIXOFIMAGE,doct.head];
        NSURL *url = [NSURL URLWithString:str];
        [cell.headerIV sd_setImageWithURL:url];
        cell.title.text = doct.doctorname;
        cell.doctor.text = doct.positionaltitles;
        for (ServerConfigHospitalList *hosp in _hospicalDataArr) {
            if ([hosp.hospitalid isEqualToString:doct.hospitalid]) {
                cell.hospital.text = hosp.hospitalname;
            }
        }
       }else{
        ServerConfigHospitalList *hospital = (ServerConfigHospitalList *)_hospicalDataArr[indexPath.row];
        

        
        [cell.headerIV setImage:[UIImage imageNamed:@"tubiao.jpg"]];
        
        cell.title.text = hospital.hospitalname;
        cell.hospital.text = hospital.hospitaladdress;
        cell.hospital.numberOfLines = 2;
        cell.doctor.text = @"";
       }
    [cell.bgHeadIV setImage:[UIImage imageNamed:@"yiliao-datouxiang" ofSex:self.sex]];

    cell.headerIV.layer.masksToBounds = YES;
    cell.headerIV.layer.cornerRadius = 41;
    cell.title.font = [UIFont yaHeiFontOfSize:17];
    cell.title.textColor = wordColor;
    cell.hospital.font = [UIFont yaHeiFontOfSize:14];
    cell.hospital.textColor = WORDDARKCOLOR;
    cell.doctor.textColor = WORDDARKCOLOR;
    cell.doctor.font = [UIFont yaHeiFontOfSize:14];
    
    UIImageView *view = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, cell.bounds.size.width, cell.bounds.size.height)];
    view.image = [UIImage imageNamed:@"kefu-dakuang" ofSex:self.sex];
    cell.selectedBackgroundView = view;
    return cell;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_isDoctor) {
        return [_doctorDataArr count];
    }else{
        return [_hospicalDataArr count];
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 107;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_isDoctor) {
        
        [self updateRight1:indexPath.row];
    }else{
        ServerConfigHospitalList *hospital = (ServerConfigHospitalList *)_hospicalDataArr[indexPath.row];
        _right0.title.text = hospital.hospitalname;
        _right0.title.textColor = self.wordColor;
        _right0.title.textAlignment = NSTextAlignmentCenter;
        _right0.title.font = [UIFont yaHeiFontOfSize:24];
        
        _right0.name.text = [NSString stringWithFormat:@"类型：%@",hospital.hospitaltype];
        _right0.phone.text = [NSString stringWithFormat:@"电话：%@",hospital.hospitalphone];
        _right0.address.text = [NSString stringWithFormat:@"地址：%@",hospital.hospitaladdress];
        NSString *str = [NSString stringWithFormat:@"http://www.mengbaobao.com:8088/goldbabyManageTest/%@",hospital.map];
        NSURL *url = [NSURL URLWithString:str];
        [_right0.mapView sd_setImageWithURL:url];
        _right0.mapView.layer.masksToBounds = YES;
        _right0.mapView.layer.cornerRadius = 10;
        
        [_right1 updateConstraints];
    }
    
   
   
}



-(void)createRightView{
    /**
     *  医院详情
     */
      _right0 = [[[NSBundle mainBundle] loadNibNamed:@"RightView" owner:self options:nil] firstObject];
    _right0.frame = FRAMEOFRIGHTVIEW;
    _right0.backgroundColor = bgColor;
    ServerConfigHospitalList *hospital = (ServerConfigHospitalList *)_hospicalDataArr[0];
    _right0.title.text = hospital.hospitalname;
    _right0.title.textColor = self.wordColor;
    _right0.title.textAlignment = NSTextAlignmentCenter;
    _right0.title.font = [UIFont yaHeiFontOfSize:24];
    
    _right0.name.text = [NSString stringWithFormat:@"类型：%@",hospital.hospitaltype];
    _right0.phone.text = [NSString stringWithFormat:@"电话：%@",hospital.hospitalphone];
    _right0.address.text = [NSString stringWithFormat:@"地址：%@",hospital.hospitaladdress];
    NSString *str = [NSString stringWithFormat:@"http://www.mengbaobao.com:8088/goldbabyManageTest/%@",hospital.map];
    NSURL *url = [NSURL URLWithString:str];
    [_right0.mapView sd_setImageWithURL:url];
    _right0.mapView.layer.masksToBounds = YES;
    _right0.mapView.layer.cornerRadius = 10;

    [self.view addSubview:_right0];
    [_right0 updateConstraints];
    
    
    
    /**
     *  医生详情
     */
    _right1 = [[UIView alloc] initWithFrame:FRAMEOFRIGHTVIEW];
    _right1.backgroundColor = bgColor;
    sc = [[UIScrollView alloc] initWithFrame:_right1.bounds];
    [_right1 addSubview:sc];
    UIImageView *headerViewBg = [[UIImageView alloc] initWithFrame:CGRectMake(30, 30, 170, 170)];
    headerViewBg.image = [UIImage imageNamed:@"yiliao-xiaotouxiang" ofSex:self.sex];
    [sc addSubview:headerViewBg];
    _bigHeader = [[UIImageView alloc] initWithFrame:CGRectMake(32, 32, 166, 166)];
    _bigHeader.layer.masksToBounds = YES;
    _bigHeader.layer.cornerRadius = 84;
    [sc addSubview:_bigHeader];
    _doctorName = [[UILabel alloc] initWithFrame:CGRectMake(230, 30, 200, 30)];
    _doctorName.font = [UIFont yaHeiFontOfSize:24];
    _doctorName.textColor = self.wordColor;
    [sc addSubview:_doctorName];
    
    _hospitalName = [[UILabel alloc] initWithFrame:CGRectMake(230, 60, 260, 30)];
    [sc addSubview:_hospitalName];
    
    _doctotGrade = [[UILabel alloc] initWithFrame:CGRectMake(230, 90, 200, 20)];
    [sc addSubview:_doctotGrade];
     _doctorBegood = [[UILabel alloc] initWithFrame:CGRectMake(_doctotGrade.frame.origin.x, _doctotGrade.frame.origin.y + _doctotGrade.frame.size.height + 10, FRAMEOFRIGHTVIEW.size.width-_doctotGrade.frame.origin.x-30, 100)];
    [sc addSubview:_doctorBegood];
    _doctorDetail = [[UILabel alloc] initWithFrame:CGRectMake(_bigHeader.frame.origin.x, sc.contentSize.height+20, sc.frame.size.width-_bigHeader.frame.origin.x*2, 1000)];
    [sc addSubview:_doctorDetail];

    [self updateRight1:0];
    [self.view addSubview:_right1];
    [self.view sendSubviewToBack:_right0];
}
-(void)updateRight1:(int)tagOfCell{
    ServerConfigDoctorList *doctor = (ServerConfigDoctorList *)_doctorDataArr[tagOfCell];
    NSString *str1 = [NSString stringWithFormat:@"http://www.mengbaobao.com:8088/goldbabyManageTest/%@",doctor.head];
    NSURL *url1 = [NSURL URLWithString:str1];
   
    [_bigHeader sd_setImageWithURL:url1];
    
    _doctorName.text = doctor.doctorname;
    
    for (ServerConfigHospitalList *hosp in _hospicalDataArr) {
        if ([hosp.hospitalid isEqualToString:doctor.hospitalid]) {
            _hospitalName.text = hosp.hospitalname;
        }
    }
    
    _doctotGrade.text = doctor.positionaltitles;
    _doctotGrade.textColor = WORDDARKCOLOR;
    _doctotGrade.font = [UIFont yaHeiFontOfSize:16];
    
    
    _hospitalName.textColor = WORDDARKCOLOR;
    _hospitalName.font = [UIFont yaHeiFontOfSize:16];
    _hospitalName.numberOfLines = 0;
    NSMutableAttributedString *attributedString0 = [[NSMutableAttributedString alloc]initWithString:_hospitalName.text];;
    NSMutableParagraphStyle *paragraphStyle0 = [[NSMutableParagraphStyle alloc]init];
    [paragraphStyle0 setLineSpacing:10];
    [attributedString0 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle0 range:NSMakeRange(0, _hospitalName.text.length)];
    _hospitalName.attributedText = attributedString0;
    
    CGSize size0 = [_hospitalName sizeThatFits:CGSizeMake(260, 30000)];
    
    _hospitalName.frame = CGRectMake(_hospitalName.frame.origin.x,_hospitalName.frame.origin.y, size0.width, size0.height);
    
    _doctotGrade.frame = CGRectMake(230, _hospitalName.frame.origin.y+ _hospitalName.frame.size.height +5 ,200, 20);
    
    
    
    _doctorBegood.text = [NSString stringWithFormat:@"擅长：%@",doctor.speciality];
    _doctorBegood.font = [UIFont yaHeiFontOfSize:16];
    _doctorBegood.numberOfLines = 0;
    _doctorBegood.textColor = WORDDARKCOLOR;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:_doctorBegood.text];;
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    [paragraphStyle setLineSpacing:10];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, _doctorBegood.text.length)];
    [attributedString addAttribute:NSForegroundColorAttributeName value:wordColor range:NSMakeRange(0,3)];
    _doctorBegood.attributedText = attributedString;
    
    CGSize size = [_doctorBegood sizeThatFits:CGSizeMake( FRAMEOFRIGHTVIEW.size.width-_doctotGrade.frame.origin.x-30, 2000)];
    
    _doctorBegood.frame = CGRectMake(_doctorBegood.frame.origin.x,_hospitalName.frame.origin.y+ _hospitalName.frame.size.height +5 +20, size.width, (size.height>80)?size.height:80);
    
    
    sc.contentSize = CGSizeMake(sc.frame.size.width, _doctorBegood.frame.origin.y+ _doctorBegood.frame.size.height);
    _doctorDetail.text = doctor.doctordesc;
    _doctorDetail.numberOfLines = 0;
    _doctorDetail.font = [UIFont yaHeiFontOfSize:16];
    _doctorDetail.textColor = WORDDARKCOLOR;
    [self setAttributedTextOfLabel:_doctorDetail];
    CGSize size1 = [_doctorDetail sizeThatFits:CGSizeMake( sc.frame.size.width-_bigHeader.frame.origin.x*2, 20000)];
    _doctorDetail.frame = CGRectMake(_bigHeader.frame.origin.x, sc.contentSize.height+20, size1.width, size1.height);
    sc.contentSize = CGSizeMake(sc.frame.size.width, _doctorDetail.frame.origin.y + _doctorDetail.frame.size.height + 10);
    
    [_right1 updateConstraints];

}

-(void)setAttributedTextOfLabel:(UILabel *)label{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:label.text];;
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    [paragraphStyle setLineSpacing:10];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, label.text.length)];
    
    label.attributedText = attributedString;

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
