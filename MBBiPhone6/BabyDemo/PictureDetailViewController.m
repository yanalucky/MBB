//
//  PictureDetailViewController.m
//  BabyDemo
//
//  Created by 陈彦 on 16/5/20.
//  Copyright © 2016年 elsa. All rights reserved.
//

#import "PictureDetailViewController.h"
#import "PictureDetailTableViewCell.h"
#import "OnlineAppraisalImgdata.h"
#import "ServerConfigFeatureList.h"

@interface PictureDetailViewController ()<UITableViewDelegate,UITableViewDataSource>{
    
    UITableView *_tableView;
    NSArray *_titleArr;
    NSDictionary *_featureDic;
}

@end

@implementation PictureDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"_currentMonthFeatureArr  %@",_currentMonthFeatureArr);
    NSLog(@"%lu",(unsigned long)_currentMonthFeatureArr.count);
    
    if (_number == 1) {
        _titleArr = @[@"日期",@"宝宝月龄",@"身长"];
        self.title = @"身长记录";
        
    }else if (_number == 2){
        _titleArr = @[@"日期",@"宝宝月龄",@"体重"];
        self.title = @"体重记录";

    }else if (_number == 3){
        _titleArr = @[@"日期",@"身长",@"体重"];
        self.title = @"身长体重比";

    }else{
        _titleArr = @[@"宝宝这个月的发育行为"];
        self.title = @"发育行为";

    }
    
    
    _featureDic = [[NSUserDefaults standardUserDefaults] objectForKey:@"featureDic"];
    NSLog(@"_featureDic  = %@",_featureDic);
//    self.navigationController.interactivePopGestureRecognizer.delegate = nil;
    self.view.backgroundColor = [UIColor whiteColor];
    [self createInterface];
    // Do any additional setup after loading the view.
}



-(void)createInterface{
    
    if ([self respondsToSelector:@selector(automaticallyAdjustsScrollViewInsets)]) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320*Ratio, 320*Ratio) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerClass:[PictureDetailTableViewCell class] forCellReuseIdentifier:@"identi"];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self.view);
        make.top.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
    
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identi = @"identi";
    PictureDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identi forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[PictureDetailTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identi];
    }
    cell.isForth = NO;
    
    OnlineAppraisalImgdata *imgda = nil;
    if (_number == 1) {
        imgda = _pictureArr[indexPath.row+1];

        [cell makeCellWithDate:[imgda.submitTime substringToIndex:10] andBabyAge:[NSString stringWithFormat:@"%d个月%d天",(int)imgda.age,(int)imgda.monthDay] andData:[NSString stringWithFormat:@"%@ cm",imgda.height]];
    }else if (_number == 2){
        imgda = _pictureArr[indexPath.row+1];

        [cell makeCellWithDate:[imgda.submitTime substringToIndex:10] andBabyAge:[NSString stringWithFormat:@"%d个月%d天",(int)imgda.age,(int)imgda.monthDay] andData:[NSString stringWithFormat:@"%@ kg",imgda.weight]];
    }else if (_number == 3){
        imgda = _pictureArr[indexPath.row+1];

        [cell makeCellWithDate:[imgda.submitTime substringToIndex:10] andBabyAge:[NSString stringWithFormat:@"%@ cm",imgda.height] andData:[NSString stringWithFormat:@"%@ kg",imgda.weight]];
    }else{
//        imgda = _pictureArr[indexPath.row];

        cell.isForth = YES;
        ServerConfigFeatureList *featured = [[ServerConfigFeatureList alloc] initWithDictionary:[_featureDic objectForKey:_currentMonthFeatureArr[indexPath.row]]];
        [cell makeCellWithDate:featured.featurename andBabyAge:featured.detaildesc andData:@""];

    }
    return cell;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_number == 4) {
        return _currentMonthFeatureArr.count;
    }else{
        return _pictureArr.count - 1;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_number == 4) {
        return 60*Ratio;
    }else{
        return 30*Ratio;
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 29*Ratio;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320*Ratio, 29*Ratio)];
    view.backgroundColor = MBColor(239, 240, 241, 1);
    if (_number == 4) {
        UILabel *tit = [[UILabel alloc] init];
        [tit makeLabelWithText:_titleArr[0] andTextColor:MBColor(102, 102, 102, 1) andFont:[UIFont yaHeiFontOfSize:14*Ratio]];
        tit.textAlignment = NSTextAlignmentCenter;
        [view addSubview:tit];
        [tit mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(view);
            make.centerY.equalTo(view);
            make.size.mas_equalTo(CGSizeMake(200*Ratio, 18*Ratio));
        }];
    }else{
        UILabel *date = [[UILabel alloc] init];
        [date makeLabelWithText:_titleArr[0] andTextColor:MBColor(102, 102, 102, 1) andFont:[UIFont yaHeiFontOfSize:14*Ratio]];
        [view addSubview:date];
        [date mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(view).offset(35*Ratio);
            make.centerY.equalTo(view);
            make.size.mas_equalTo(CGSizeMake(30*Ratio, 18*Ratio));
        }];
        
        
        UILabel *babyAge = [[UILabel alloc] init];
        [babyAge makeLabelWithText:_titleArr[1] andTextColor:MBColor(102, 102, 102, 1) andFont:[UIFont yaHeiFontOfSize:14*Ratio]];
        babyAge.textAlignment = NSTextAlignmentCenter;
        [view addSubview:babyAge];
        [babyAge mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(date.mas_right).offset(70*Ratio);
            make.centerY.equalTo(view);
            make.size.mas_equalTo(CGSizeMake(60*Ratio, 18*Ratio));
        }];
        UILabel *data = [[UILabel alloc] init];
        [data makeLabelWithText:_titleArr[2] andTextColor:MBColor(102, 102, 102, 1) andFont:[UIFont yaHeiFontOfSize:14*Ratio]];
        [view addSubview:data];
        
        [data mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.right.equalTo(view).offset(-35*Ratio);
            make.centerY.equalTo(view);
            make.size.mas_equalTo(CGSizeMake(30*Ratio, 18*Ratio));
            
        }];

    }
    return view;
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
