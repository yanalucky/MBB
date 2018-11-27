
//
//  FeatureViewController.m
//  BabyDemo
//
//  Created by 陈彦 on 16/5/24.
//  Copyright © 2016年 elsa. All rights reserved.
//

#import "FeatureViewController.h"
#import "FeatureTableViewCell.h"
#import "ServerConfigFeatureListByAge.h"
#import "DetailViewController.h"
//#import "VideoPlayView.h"
#import "BuyViewController.h"

#import "MovieViewController.h"


@interface FeatureViewController ()<UITableViewDelegate,UITableViewDataSource>{
    UIButton *_rightBtn;
    
    UITableView *_tableView;
    NSMutableArray *_featureArr;//当月行为观察特征
    DetailViewController *dvc;
    NSIndexPath *selIndexPath;
    
    NSString *_userRoleStr;
    
    NSMutableArray *_selectFeatureArr;
    
    void(^_myBlock)(NSString *featureStr);
    
    
    NSMutableArray *_freeFeatureArr;//免费用户
    
    BOOL _isFinish;
    
}
//@property(nonatomic,strong) VideoPlayView * player;

@end


@implementation FeatureViewController
-(void)viewDidDisappear:(BOOL)animated{
    
    NSString *str = nil;
    if (_isFinish == YES) {
//        NSLog(@"_selectFeatureArr = %@",_selectFeatureArr);
        str = [_selectFeatureArr componentsJoinedByString:@","];
    }else{
//        NSLog(@"_oldFeatureDataArr = %@",_oldFeatureDataArr);

        str = [_oldFeatureDataArr componentsJoinedByString:@","];
    }
    _myBlock(str);
    
}

/*
-(VideoPlayView *)player{
    
    if(_player == nil){
        
        _player = [VideoPlayView videoPlayView];
        
        
    }
    
    return _player;
}
 */
-(void)selectFeatureBlock:(void (^)(NSString *))featureBlock{
    _myBlock = [featureBlock copy];
}
- (void)viewDidLoad {
    [super viewDidLoad];
//    NSLog(@"%@",_oldFeatureDataArr);
    _isFinish = NO;
    _featureArr = [[NSMutableArray alloc] init];
    _freeFeatureArr = [[NSMutableArray alloc] init];
    _userRoleStr = [[NSUserDefaults standardUserDefaults] objectForKey:@"userRole"];
    self.view.backgroundColor = MBColor(227, 252, 255, 1);
//    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    self.title = @"发育行为观察";
    _selectFeatureArr = [[NSMutableArray alloc] init];
    if ([_userRoleStr intValue] == 0) {//免费用户界面
        //http://192.168.31.121:8080/mbbPhoneServer/uploads/default/dyd3.mov
        NSArray *titleArr = @[@"大运动",@"俯卧时能抬头，做出爬行的样子，但时间依旧不能太长",@"default/dyd2.mov",@"default/dyd2.jpg",@"认知",@"懂得寻找遮盖的玩具，初步形成了客体永存的观念",@"default/rz6.mov",@"default/rz6.jpg",@"语言",@"理解姿态和对“bye-bye”作出反应",@"default/yy4.mp4",@"default/yy4.jpg"];
        for (int i=0; i<3; i++) {
            ServerConfigFeatureListByAge *featur = [[ServerConfigFeatureListByAge alloc] init];
            featur.featurename = titleArr[i*4];
            featur.detaildesc = titleArr[i*4+1];
            featur.examplemov = titleArr[i*4+2];
            featur.exampleimg = titleArr[i*4+3];
            featur.featureListByAgeIdentifier = @"";
            [_freeFeatureArr addObject:featur];
        }
        
        
        
        
    }else{//付费用户
        
        if (_oldFeatureDataArr&&(_canChangeData == NO)) {
            NSLog(@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"featureDic"]);
            for (NSString *featurId in _oldFeatureDataArr) {
                if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"featureDic"] objectForKey:featurId]) {
                    [_featureArr addObject:[[[NSUserDefaults standardUserDefaults] objectForKey:@"featureDic"] objectForKey:featurId]];
                }
                
            }

        }else{
            if (_canChangeData) {
                _featureArr = [[NSUserDefaults standardUserDefaults] objectForKey:@"featureByAgeArr"];

            }else{
                _featureArr = [[NSMutableArray alloc] init];
            }

        }
        
        
        _featureDataArr = [[NSMutableArray alloc] init];
        NSString *lastName = nil;
        NSMutableArray *lastTempArr = [[NSMutableArray alloc] init];
        for (int i=0; i<_featureArr.count; i++) {
            NSDictionary *featur = _featureArr[i];
            if ([[featur objectForKey:@"featurename"] isEqualToString:lastName]) {
                
                if (lastTempArr) {
                    [lastTempArr addObject:featur];
                }
                
                
                
            }else{
                if (lastTempArr.count >0) {
                    NSArray *temp = [NSArray arrayWithArray:lastTempArr];
                    [_featureDataArr addObject:temp];
                    
                    
                }
                lastName = [featur objectForKey:@"featurename"];
                [lastTempArr removeAllObjects];
                [lastTempArr addObject:featur];
                
                
            }
        }
        
        if (lastTempArr.count > 0) {
            [_featureDataArr addObject:lastTempArr];
        }
       
        
        
        [_selectFeatureArr addObjectsFromArray:_oldFeatureDataArr];
        
        
    }
    
    

    [self createInterface];
    
#pragma mark = 视频
    /*
    [self.player setHidden:YES];
    
    
    
    [_tableView addSubview:self.player];

    */
//    [self.player mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.equalTo(_tableView).offset(-13*Ratio);
//        make.size.mas_equalTo(CGSizeMake( 92*Ratio, 69*Ratio));
//        make.top.equalTo(_tableView);
//    }];
//     Do any additional setup after loading the view.
}

-(void)createInterface{
    
    
#pragma mark - 右侧按钮
    
    _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _rightBtn.frame = CGRectMake(0, 0, 50*Ratio, 40*Ratio);
    [_rightBtn setTitle:@"完成" forState:UIControlStateNormal];
    
    [_rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_rightBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
    [_rightBtn addTarget:self action:@selector(commit:) forControlEvents:UIControlEventTouchUpInside];
    _rightBtn.titleLabel.font = [UIFont yaHeiFontOfSize:16*Ratio];

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_rightBtn];
    _rightBtn.hidden = _isHiddenSubmit;
    
    if ([self respondsToSelector:@selector(automaticallyAdjustsScrollViewInsets)]) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320*Ratio, 320*Ratio) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.backgroundColor = [UIColor whiteColor];
    

    [_tableView registerClass:[FeatureTableViewCell class] forCellReuseIdentifier:@"featureIdentifier"];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(([_userRoleStr intValue] == 0)?55*Ratio:0);
        make.bottom.equalTo(self.view).offset(([_userRoleStr intValue] == 0)?(-80*Ratio):0);
    }];
    
    
    
    //免费用户提示语
    UILabel *caution = [[UILabel alloc] init];
    [caution makeLabelWithText:@"发育行为观察为会员专属功能。" andTextColor:MBColor(151, 152, 153, 1) andFont:[UIFont yaHeiFontOfSize:9*Ratio]];
    caution.backgroundColor = [UIColor whiteColor];
    caution.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:caution];
    [caution mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.left.and.right.equalTo(self.view);
        make.height.mas_equalTo(28*Ratio);
    }];
    [self.view sendSubviewToBack:caution];
    
    UILabel *caution1 = [[UILabel alloc] init];
    [caution1 makeLabelWithText:@"发育行为观察示例" andTextColor:MBColor(151, 152, 153, 1) andFont:[UIFont yaHeiFontOfSize:9*Ratio]];
    caution1.backgroundColor = [UIColor whiteColor];
    caution1.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:caution1];
    [caution1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(caution.mas_bottom).offset(5*Ratio);
        make.left.and.right.equalTo(self.view).offset(5*Ratio);
        
        make.height.mas_equalTo(28*Ratio);
    }];
    [self.view sendSubviewToBack:caution1];
    
    
    UIButton *payBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [payBtn setBackgroundImage:[UIImage imageNamed:@"buy_btn"] forState:UIControlStateNormal];
    [payBtn setTitle:@"购买" forState:UIControlStateNormal];
    [payBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [payBtn addTarget:self action:@selector(payAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:payBtn];
    payBtn.hidden =(([_userRoleStr intValue] == 0)?NO:YES);
    [payBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100*Ratio, 28*Ratio));
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-40*Ratio);
    }];
    
}

#pragma mark - payAction支付购买

-(void)payAction:(UIButton *)button{
    
    BuyViewController *buyVC = [[BuyViewController alloc] init];
    
    [self.navigationController pushViewController:buyVC animated:YES];
}


#pragma mark = 完成
-(void)commit:(UIButton *)button{
    
    _isFinish = YES;
//    NSString *str = [_selectFeatureArr componentsJoinedByString:@","];
//    
//    _myBlock(str);
    
    [self.navigationController popViewControllerAnimated:YES];

    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *str = @"featureIdentifier";
    FeatureTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    ServerConfigFeatureListByAge *featu = nil;
    if ([_userRoleStr intValue] == 0) {
        featu = (ServerConfigFeatureListByAge *)_freeFeatureArr[indexPath.section];
    }else{
        featu = [[ServerConfigFeatureListByAge alloc] initWithDictionary:_featureDataArr[indexPath.section][indexPath.row]];

    }
    
    if (cell == nil) {
        cell = [[FeatureTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
    
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.featurePath = indexPath;
    [cell.cellButton addTarget:self action:@selector(selMe:) forControlEvents:UIControlEventTouchUpInside];
    [cell.cellButton setSelected:!_canChangeData];

    cell.cellButton.hidden = ([_userRoleStr intValue] == 0);
    [cell makeCellWithTitle:featu.detaildesc andHaveImg:(featu.examplemov.length > 0) andImg:featu.exampleimg  withIsSel:([_selectFeatureArr containsObject:featu.featureListByAgeIdentifier]||(!_canChangeData))];
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([_userRoleStr intValue] == 0) {
        return 1;
    }else{
        return [_featureDataArr[section] count];
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return  95*Ratio;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    if ([_userRoleStr intValue] == 0) {
        return 3;
    }else{
        return _featureDataArr.count;
    }
    
}
//section头部间距
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 28*Ratio;//section头部高度
}
//section头部视图
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320*Ratio, 28*Ratio)];
    view.backgroundColor = [UIColor whiteColor];
    
    
    
    
    UILabel *label = [[UILabel alloc] init];
    if ([_userRoleStr intValue] == 0) {
        ServerConfigFeatureListByAge *featu = (ServerConfigFeatureListByAge *)_freeFeatureArr[section];

        label.text = featu.featurename;
    }else{
        label.text = [_featureDataArr[section][0] objectForKey:@"featurename"];
    }
    
    label.textColor = MBColor(102, 103, 104, 1);
    label.font = [UIFont yaHeiFontOfSize:15*Ratio];
    [view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view).offset(16*Ratio);
        make.top.equalTo(view).offset(6*Ratio);
        make.size.mas_equalTo(CGSizeMake(120*Ratio, 16*Ratio));
    }];
    
    
    return view;
}


//section底部间距

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 5*Ratio;
}

//section底部视图

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320*Ratio, 5*Ratio)];
    view.backgroundColor = MBColor(225, 253, 255, 1);;
    return view;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ServerConfigFeatureListByAge *featu = nil;
    if ([_userRoleStr intValue] == 0) {
        featu = (ServerConfigFeatureListByAge *)_freeFeatureArr[indexPath.section];
    }else{
        featu = [[ServerConfigFeatureListByAge alloc] initWithDictionary:_featureDataArr[indexPath.section][indexPath.row]];
        
    }
    

//    [self.player setHidden:NO];
    selIndexPath = indexPath;

//    FeatureTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    
    MovieViewController *movie = [[MovieViewController alloc] initWithContentURL:[NSURL URLWithString:[NSString urlStringOfImage:featu.examplemov]]];
    
    movie.moviePlayer.scalingMode = MPMovieScalingModeAspectFit;
    movie.moviePlayer.shouldAutoplay = YES;
    [movie.moviePlayer prepareToPlay];
    [self presentViewController:movie animated:NO completion:nil];
    //        [self presentMoviePlayerViewControllerAnimated:dvc];
    movie.moviePlayer.controlStyle = MPMovieControlStyleFullscreen;
    
    [movie.moviePlayer.view setBackgroundColor:[UIColor clearColor]];
    //        dvc.moviewControlMode = MPMovieControlModeHidden;
    
    
    
/*
    AVPlayerItem *item = [AVPlayerItem playerItemWithURL:[NSURL URLWithString:[NSString urlStringOfImage:featu.examplemov]]];
    [self.player setPlayerItem:item];
    self.player.frame = CGRectMake((320 - 13 - 92)*Ratio, cell.frame.origin.y + 16*Ratio, 92*Ratio, 69*Ratio);
  */
    
    
}


-(void)selMe:(UIButton *)button{
    if (_canChangeData) {
        button.selected = !button.selected;
        
        FeatureTableViewCell *cell = (FeatureTableViewCell *)[button superview];
//        NSLog(@"cell.featurepath = %d",cell.featurePath.section);
//        NSLog(@"cell.featurepath = %d",cell.featurePath.row);
        ServerConfigFeatureListByAge *featu = [[ServerConfigFeatureListByAge alloc] initWithDictionary:_featureDataArr[cell.featurePath.section][cell.featurePath.row]];
        
        if ([_selectFeatureArr containsObject:featu.featureListByAgeIdentifier]) {
            [_selectFeatureArr removeObject:featu.featureListByAgeIdentifier];
        }else{
            [_selectFeatureArr addObject:featu.featureListByAgeIdentifier];
        }
        
        [_tableView reloadRowsAtIndexPaths:@[cell.featurePath] withRowAnimation:UITableViewRowAnimationNone];
    }

    
}





- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    
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
