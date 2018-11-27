//
//  BuyDoctorViewController.m
//  BabyDemo
//
//  Created by 陈彦 on 16/7/12.
//  Copyright © 2016年 elsa. All rights reserved.
//

#import "BuyDoctorViewController.h"
#import "BuyDoctorDetailViewController.h"

#import "ServerConfigDoctorList.h"
#import "ServerConfigHospitalList.h"

#import "BuyDoctorTableViewCell.h"

#import "BuyOrderViewController.h"

@interface BuyDoctorViewController ()<UITableViewDelegate,UITableViewDataSource>{
    
    UITableView *_tableView;
    NSMutableArray *_dataArr;
    
    
    NSIndexPath *_lastRow;
    
    
    NSArray *_doctTableArr;
    NSDictionary *_hospitalDic;
}

@end

@implementation BuyDoctorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"选择医生";
    self.view.backgroundColor = MBColor(225, 253, 255, 1);
    
    _dataArr = [[NSMutableArray alloc] init];
//    NSLog(@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"doctorDic"]);
    _doctTableArr = [[NSUserDefaults standardUserDefaults] objectForKey:@"DoctorListArr"];
    _hospitalDic = [[NSUserDefaults standardUserDefaults] objectForKey:@"hospitalDic"];
    for (int i=0; i<_doctTableArr.count; i++) {
        [_dataArr addObject:[NSNumber numberWithBool:NO]];
    }
    [self createInterface];
    
    
    // Do any additional setup after loading the view.
}


-(void)createInterface{
    
    if ([self respondsToSelector:@selector(automaticallyAdjustsScrollViewInsets)]) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    
    _lastRow = nil;
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 53*Ratio, 320*Ratio, 390*Ratio) style:UITableViewStylePlain];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = MBColor(225, 253, 255, 1);
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self.view);
        make.top.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
    
    
    
    
}




#pragma mark - tableView 代理相关

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *str = @"identifier";
    BuyDoctorTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (cell == nil) {
        cell = [[BuyDoctorTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:str];
    }
    
    ServerConfigDoctorList *doctor = [[ServerConfigDoctorList alloc] initWithDictionary:[_doctTableArr objectAtIndex:indexPath.row]];
    ServerConfigHospitalList *hospital = [[ServerConfigHospitalList alloc] initWithDictionary:[_hospitalDic objectForKey:doctor.hospitalid]];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell.rightBtn addTarget:self action:@selector(selMe:) forControlEvents:UIControlEventTouchUpInside];
    cell.indexpath = indexPath;
    [cell makeCellByLeftImageName:doctor.head withTitle:doctor.doctorname withDetailTitle:hospital.hospitalname withColorTitle:doctor.positionaltitles withGoodAtTitle:doctor.speciality withIsSel:[_dataArr[indexPath.row] boolValue]];
    return cell;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArr.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 95*Ratio;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ServerConfigDoctorList *doctor = [[ServerConfigDoctorList alloc] initWithDictionary:[_doctTableArr objectAtIndex:indexPath.row]];
    ServerConfigHospitalList *hospital = [[ServerConfigHospitalList alloc] initWithDictionary:[_hospitalDic objectForKey:doctor.hospitalid]];
    
    BuyDoctorDetailViewController *dvc = [[BuyDoctorDetailViewController alloc] init];
    dvc.doctor = doctor;
    dvc.hospitalName = hospital.hospitalname;
    dvc.isSel = (indexPath == _lastRow)?YES:NO;
    dvc.currentMenu = _menuStr;
    [self.navigationController pushViewController:dvc animated:YES];
    
    
}

#pragma mark - 选我


-(void)selMe:(UIButton *)button{
    BuyDoctorTableViewCell *cell = (BuyDoctorTableViewCell *)[button superview];
    
    if (!_lastRow) {
        [_dataArr replaceObjectAtIndex:cell.indexpath.row withObject:[NSNumber numberWithBool:YES]];
        
        [_tableView reloadRowsAtIndexPaths:@[cell.indexpath] withRowAnimation:UITableViewRowAnimationNone];
        
        _lastRow = cell.indexpath;
        
         button.selected = !button.selected;
        
        BuyOrderViewController *ovc = [[BuyOrderViewController alloc] init];
        ServerConfigDoctorList *doctor = [[ServerConfigDoctorList alloc] initWithDictionary:[_doctTableArr objectAtIndex:_lastRow.row]];
        
        ovc.doctor = doctor;

        ovc.infoStr = [NSString stringWithFormat:@"%@,%@,%@",doctor.doctorid,doctor.hospitalid,_menuStr];
//        ovc.infoStr = [NSString stringWithFormat:@"%@,%@",doctor.doctorid,_menuStr];
        
        [self.navigationController pushViewController:ovc animated:YES];
        
        
    }else{
        if (button.selected == YES) {
            [_dataArr replaceObjectAtIndex:_lastRow.row withObject:[NSNumber numberWithBool:NO]];
            
            [_tableView reloadRowsAtIndexPaths:@[cell.indexpath] withRowAnimation:UITableViewRowAnimationNone];
            if (_lastRow) {
                [_tableView reloadRowsAtIndexPaths:@[_lastRow] withRowAnimation:UITableViewRowAnimationNone];
                
            }
            _lastRow = nil;
            
             button.selected = !button.selected;
        }else{
            
             button.selected = !button.selected;
            
            
            [_dataArr replaceObjectAtIndex:_lastRow.row withObject:[NSNumber numberWithBool:NO]];
            [_dataArr replaceObjectAtIndex:cell.indexpath.row withObject:[NSNumber numberWithBool:YES]];
            [_tableView reloadRowsAtIndexPaths:@[cell.indexpath] withRowAnimation:UITableViewRowAnimationNone];
            if (_lastRow) {
                [_tableView reloadRowsAtIndexPaths:@[_lastRow] withRowAnimation:UITableViewRowAnimationNone];
                
            }
            _lastRow = cell.indexpath;
            BuyOrderViewController *ovc = [[BuyOrderViewController alloc] init];
            ServerConfigDoctorList *doctor = [[ServerConfigDoctorList alloc] initWithDictionary:[_doctTableArr objectAtIndex:_lastRow.row]];

            ovc.doctor = doctor;
            ovc.infoStr = [NSString stringWithFormat:@"%@,%@,%@",doctor.doctorid,doctor.hospitalid,_menuStr];

//            ovc.infoStr = [NSString stringWithFormat:@"%@,%@",doctor.doctorid,_menuStr];
            
            [self.navigationController pushViewController:ovc animated:YES];
        

        }
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
