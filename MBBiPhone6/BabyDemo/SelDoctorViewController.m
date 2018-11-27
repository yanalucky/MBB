//
//  SelDoctorViewController.m
//  BabyDemo
//
//  Created by 陈彦 on 16/5/6.
//  Copyright © 2016年 elsa. All rights reserved.
//

#import "SelDoctorViewController.h"
#import "DoctorTableViewCell.h"
#import "ServerConfigDoctorList.h"
#import "ServerConfigHospitalList.h"
#import "OrderViewController.h"
#import "DoctorViewController.h"
#import "CYRecordAlertView.h"



@interface SelDoctorViewController ()<UITableViewDelegate,UITableViewDataSource>{
    UITableView *_tableView;
    NSMutableArray *_dataArr;
    NSArray *_doctTableArr;
    
    NSIndexPath *_lastRow;
    NSString *_currentMenuStr;
    
    NSDictionary *_hospitalDic;
}

@end

@implementation SelDoctorViewController


-(void)viewWillAppear:(BOOL)animated{
    [_tableView reloadData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    _dataArr = [[NSMutableArray alloc] init];
    
    _doctTableArr = [[NSUserDefaults standardUserDefaults] objectForKey:@"DoctorListArr"];
    _hospitalDic = [[NSUserDefaults standardUserDefaults] objectForKey:@"hospitalDic"];
    for (int i=0; i<_doctTableArr.count; i++) {
        [_dataArr addObject:[NSNumber numberWithBool:NO]];
    }
    [self createInterface];
    // Do any additional setup after loading the view.
}
-(void)createInterface{
#pragma mark = 左边按钮
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
    
#pragma mark = 题目
    UILabel *tit = [[UILabel alloc] init];
    [tit makeLabelWithText:@"选择医生" andTextColor:MBColor(250, 109, 166, 1) andFont:[UIFont yaHeiFontOfSize:20*Ratio]];
    tit.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:tit];
    [tit mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100*Ratio, 25*Ratio));
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).offset(40*Ratio);
    }];
    
#pragma mark = 医生列表
    
    
    if ([self respondsToSelector:@selector(automaticallyAdjustsScrollViewInsets)]) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    _lastRow = nil;
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 53*Ratio, 320*Ratio, 390*Ratio) style:UITableViewStylePlain];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(66*Ratio);
        make.height.mas_equalTo(380*Ratio);
    }];
    
    
    
    
    
#pragma mark = 服务期限
    NSArray *buyTimeArr = @[@"半年服务",@"一年服务"];
    for (int i=0; i<2; i++) {
        UIButton *buyTime = [UIButton buttonWithType:UIButtonTypeCustom];
        buyTime.tag = 1200+i;
        [buyTime setBackgroundImage:[UIImage imageNamed:@"buy_time_01"] forState:UIControlStateNormal];
        [buyTime setBackgroundImage:[UIImage imageNamed:@"buy_time_02"] forState:UIControlStateSelected];
        buyTime.titleLabel.textAlignment = NSTextAlignmentCenter;
        [buyTime setTitle:buyTimeArr[i] forState:UIControlStateNormal];
        [buyTime setTitleColor:MBColor(51, 51, 51, 1) forState:UIControlStateNormal];
        [buyTime addTarget:self action:@selector(buyTimeAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:buyTime];
        [buyTime mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_tableView.mas_bottom).offset(20*Ratio);
            make.size.mas_equalTo(CGSizeMake(95*Ratio, 32*Ratio));
            make.left.equalTo(self.view).offset((33+160*i)*Ratio);
        }];
        UIImageView *dui = [[UIImageView alloc] init];
        dui.image = [UIImage imageNamed:@"buy_time_set"];
        [buyTime addSubview:dui];
        [dui mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(buyTime).offset(3*Ratio);
            make.bottom.equalTo(buyTime).offset(3*Ratio);
            make.size.mas_equalTo(CGSizeMake(13*Ratio, 13*Ratio));
        }];
        dui.hidden = YES;
    }
    
    
    
    
#pragma mark = 购买
    UIButton *buyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [buyBtn setBackgroundImage:[UIImage imageNamed:@"buy_btn"] forState:UIControlStateNormal];
    [buyBtn setTitle:@"立即购买" forState:UIControlStateNormal];
    [buyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [buyBtn addTarget:self action:@selector(nowPay:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buyBtn];
    [buyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_tableView.mas_bottom).offset(70*Ratio);
        make.centerX.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(100*Ratio, 28*Ratio));
    }];
    
    
}
#pragma mark - 立即购买
-(void)nowPay:(UIButton *)button{
    
    
    if (_lastRow && _currentMenuStr) {
        ServerConfigDoctorList *doctor = [[ServerConfigDoctorList alloc] initWithDictionary:[_doctTableArr objectAtIndex:_lastRow.row]];
        
        OrderViewController *ovc = [[OrderViewController alloc] init];
        ovc.doctorDic = [_doctTableArr objectAtIndex:_lastRow.row];
        ovc.infoStr = [NSString stringWithFormat:@"%@,%@,%@",doctor.doctorid,doctor.hospitalid,_currentMenuStr];
        [self presentViewController:ovc animated:YES completion:nil];

    }else{
        NSLog(@"信息不全！");
        
        CYRecordAlertView *alert = [self.view.window viewWithTag:9999];
        [alert alertViewWith:@"信息不全！" andDetailTitle:nil  andButtonTitle:@"0"];
        [alert layoutSubviews];
    }
    
}



#pragma mark - 服务期限按钮
-(void)buyTimeAction:(UIButton *)button{
    if (button.selected == NO) {
        for (int i=0; i<3; i++) {
            UIButton *butt = (UIButton *)[self.view viewWithTag:1200+i];
            butt.selected = NO;
            UIImageView *duigou = (UIImageView *)[butt.subviews objectAtIndex:2];
            duigou.hidden = YES;
        }
    }
    button.selected = !button.selected;
    UIImageView *duigou = (UIImageView *)[button.subviews objectAtIndex:2];
    duigou.hidden = !button.selected;
    
    if (button.selected == YES) {
        if (button.tag == 1200) {
            _currentMenuStr = @"2";
        }else if (button.tag == 1201){
            _currentMenuStr = @"3";
        }

    }else{
        _currentMenuStr = nil;
    }
}


#pragma mark - tableView 代理相关

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *str = @"identifier";
    DoctorTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (cell == nil) {
        cell = [[DoctorTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:str];
    }
    
    ServerConfigDoctorList *doctor = [[ServerConfigDoctorList alloc] initWithDictionary:[_doctTableArr objectAtIndex:indexPath.row]];
    ServerConfigHospitalList *hospital = [[ServerConfigHospitalList alloc] initWithDictionary:[_hospitalDic objectForKey:doctor.hospitalid]];
    [cell.rightBtn addTarget:self action:@selector(selMe:) forControlEvents:UIControlEventTouchUpInside];
    cell.indexpath = indexPath;
    [cell makeCellByLeftImageName:doctor.head withTitle:doctor.doctorname withDetailTitle:hospital.hospitalname withColorTitle:doctor.positionaltitles withIsSel:[_dataArr[indexPath.row] boolValue]];
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArr.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 75*Ratio;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ServerConfigDoctorList *doctor = [[ServerConfigDoctorList alloc] initWithDictionary:[_doctTableArr objectAtIndex:indexPath.row]];
    ServerConfigHospitalList *hospital = [[ServerConfigHospitalList alloc] initWithDictionary:[_hospitalDic objectForKey:doctor.hospitalid]];
    
    DoctorViewController *dvc = [[DoctorViewController alloc] init];
    dvc.doctor = doctor;
    dvc.hospitalName = hospital.hospitalname;
    dvc.isSel = (indexPath == _lastRow)?YES:NO;
    dvc.selMeBlock = ^(){
        if (!_lastRow) {
            [_dataArr replaceObjectAtIndex:indexPath.row withObject:[NSNumber numberWithBool:YES]];
            [_tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];

            _lastRow = indexPath;
            
        }else{
             [_dataArr replaceObjectAtIndex:_lastRow.row withObject:[NSNumber numberWithBool:NO]];
            [_dataArr replaceObjectAtIndex:indexPath.row withObject:[NSNumber numberWithBool:YES]];
            [_tableView reloadRowsAtIndexPaths:@[_lastRow,indexPath] withRowAnimation:UITableViewRowAnimationNone];
            
            _lastRow = indexPath;
           
        }
        
        
        
    };
    [self presentViewController:dvc animated:YES completion:nil];
    
    
}

#pragma mark - 选我
-(void)selMe:(UIButton *)button{
    DoctorTableViewCell *cell = (DoctorTableViewCell *)[button superview];
    
    if (!_lastRow) {
        [_dataArr replaceObjectAtIndex:cell.indexpath.row withObject:[NSNumber numberWithBool:YES]];
        
        [_tableView reloadRowsAtIndexPaths:@[cell.indexpath] withRowAnimation:UITableViewRowAnimationNone];
        
        _lastRow = cell.indexpath;

        
    }else{
        if (button.selected == YES) {
            [_dataArr replaceObjectAtIndex:_lastRow.row withObject:[NSNumber numberWithBool:NO]];

            [_tableView reloadRowsAtIndexPaths:@[cell.indexpath] withRowAnimation:UITableViewRowAnimationNone];
            if (_lastRow) {
                [_tableView reloadRowsAtIndexPaths:@[_lastRow] withRowAnimation:UITableViewRowAnimationNone];
                
            }
            _lastRow = nil;
        }else{
            [_dataArr replaceObjectAtIndex:_lastRow.row withObject:[NSNumber numberWithBool:NO]];
            [_dataArr replaceObjectAtIndex:cell.indexpath.row withObject:[NSNumber numberWithBool:YES]];
            [_tableView reloadRowsAtIndexPaths:@[cell.indexpath] withRowAnimation:UITableViewRowAnimationNone];
            if (_lastRow) {
                [_tableView reloadRowsAtIndexPaths:@[_lastRow] withRowAnimation:UITableViewRowAnimationNone];
                
            }
            _lastRow = cell.indexpath;

        }
    }
    
    
    
    button.selected = !button.selected;
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
