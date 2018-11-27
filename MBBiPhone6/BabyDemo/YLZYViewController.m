//
//  YLZYViewController.m
//  BabyDemo
//
//  Created by 陈彦 on 16/9/7.
//  Copyright © 2016年 elsa. All rights reserved.
//

#import "YLZYViewController.h"
#import "YLZYTableViewCell.h"
#import "YLZYHosTableViewCell.h"

#import "ServerConfigDoctorList.h"
#import "ServerConfigHospitalList.h"
#import "YLZYDocDetailViewController.h"
#import "YLZYHosViewController.h"
@interface YLZYViewController ()<UITableViewDataSource,UITableViewDelegate>{
    BOOL _isDoctor;

    NSDictionary *_hospitalDic;
}

@end

@implementation YLZYViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UISegmentedControl *segment = [[UISegmentedControl alloc] initWithItems:@[@"医生",@"医院"]];
    segment.selectedSegmentIndex = 0;
    segment.tintColor = [UIColor whiteColor];
    segment.frame = CGRectMake(0, 0, 100*Ratio, 26*Ratio);
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont yaHeiFontOfSize:16*Ratio],NSFontAttributeName ,nil];

    [segment setTitleTextAttributes:dic forState:UIControlStateNormal];
    [segment addTarget:self action:@selector(segmentChange:) forControlEvents:UIControlEventValueChanged];
    self.navigationItem.titleView = segment;
    
    _isDoctor = YES;
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(175, 155, 318, 155) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.showsVerticalScrollIndicator = YES;
    _tableView.backgroundColor = MBColor(225, 253, 255, 1);
    [self.view addSubview:_tableView];

    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
        make.size.equalTo(self.view);
    }];
    
    
    
    _doctorDataArr = [[NSUserDefaults standardUserDefaults] objectForKey:@"DoctorListArr"];
    _hospitalDic = [[NSUserDefaults standardUserDefaults] objectForKey:@"hospitalDic"];

    _hospicalDataArr = [[NSUserDefaults standardUserDefaults] objectForKey:@"HospitalListArr"];
    // Do any additional setup after loading the view.
}
#pragma mark - tableView相关
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (_isDoctor) {
        
        static NSString *str = @"str";
        
        
        YLZYTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
        if (cell == nil) {
            cell = [[YLZYTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:str];
        }
        
        ServerConfigDoctorList *doctor = [[ServerConfigDoctorList alloc] initWithDictionary:[_doctorDataArr objectAtIndex:indexPath.row]];
        ServerConfigHospitalList *hospital = [[ServerConfigHospitalList alloc] initWithDictionary:[_hospitalDic objectForKey:doctor.hospitalid]];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell makeCellByLeftImageName:doctor.head withTitle:doctor.doctorname withDetailTitle:hospital.hospitalname withColorTitle:doctor.positionaltitles withGoodAtTitle:doctor.speciality];
        
        
        
        return cell;
    }else{
        
        
        
        static NSString *str = @"str1";
        
        
        YLZYHosTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
        if (cell == nil) {
            cell = [[YLZYHosTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:str];
        }
        
        ServerConfigHospitalList *hospital = [[ServerConfigHospitalList alloc] initWithDictionary:[_hospicalDataArr objectAtIndex:indexPath.row]];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell makeCellByLeftImageName:hospital.icon withTitle:hospital.hospitalname withDetailTitle:hospital.hospitaladdress];
        
        return cell;
        
        
       
    }
    
     return 0;
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
    if (_isDoctor) {
        return 77*Ratio;

    }else{
        return 70*Ratio;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_isDoctor) {
        
        ServerConfigDoctorList *doctor = [[ServerConfigDoctorList alloc] initWithDictionary:[_doctorDataArr objectAtIndex:indexPath.row]];
        YLZYDocDetailViewController *yvc = [[YLZYDocDetailViewController alloc] init];
        yvc.doctor = doctor;
        
        [self.navigationController pushViewController:yvc animated:YES];
        
//        NSLog(@"查看医生");
    }else{
        ServerConfigHospitalList *hospital = [[ServerConfigHospitalList alloc] initWithDictionary:[_hospicalDataArr objectAtIndex:indexPath.row]];

        
        YLZYHosViewController *yvc = [[YLZYHosViewController alloc] init];
        yvc.hospital = hospital;
        [self.navigationController pushViewController:yvc animated:YES];
        
//        NSLog(@"查看医院");

    }
    
    
    
}





-(void)segmentChange:(UISegmentedControl *)segment{
    
    
    NSLog(@"%ld",(long)[segment selectedSegmentIndex]);
    int num = (int)[segment selectedSegmentIndex];
    NSLog(@"num = %d",num);
    if (num == 0) {
        _isDoctor = YES;
    }else{
        _isDoctor = NO;
//        NSLog(@"哈哈哈， 医院还没有写呢");
    }
    [_tableView reloadData];
    
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
