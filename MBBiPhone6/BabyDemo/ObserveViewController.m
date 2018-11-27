//
//  ObserveViewController.m
//  BabyDemo
//
//  Created by 陈彦 on 16/3/29.
//  Copyright © 2016年 elsa. All rights reserved.
//

#import "ObserveViewController.h"
#import "VideoPlayView.h"
#import "ObserveTableViewCell.h"



@interface ObserveViewController ()<UITableViewDelegate,UITableViewDataSource>{
    UITableView *_tabView;
}

@end

@implementation ObserveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"观察要点";
    self.view.backgroundColor = [UIColor whiteColor];
    [self createInterface];
    
       // Do any additional setup after loading the view.
}
-(void)createInterface{
    
    
    _observeArr = [[[NSUserDefaults standardUserDefaults] objectForKey:@"growthDic"] allValues];
    if ([self respondsToSelector:@selector(automaticallyAdjustsScrollViewInsets)]) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    if(_observeArr.count > 0){
        _tabView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320*Ratio, 568*Ratio) style:UITableViewStylePlain];
        _tabView.dataSource = self;
        _tabView.delegate = self;
        _tabView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tabView registerClass:[ObserveTableViewCell class] forCellReuseIdentifier:@"observeIdentifier"];
        [self.view addSubview:_tabView];
        [_tabView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.and.right.equalTo(self.view);
            make.top.equalTo(self.view).offset(10*Ratio);
            make.bottom.equalTo(self.view).offset(-10*Ratio);
        }];
    }else{
        UILabel *label = [[UILabel alloc] init];
        label.numberOfLines = 0;
        [label makeLabelWithText:@"每个宝宝都有自己的发育进程，宝妈要按“观察要点”提示的内容注意宝宝的生长变化。" andTextColor:MBColor(102, 103, 104, 1) andFont:[UIFont yaHeiFontOfSize:13*Ratio]];
        [self.view addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view).offset(7.5*Ratio);
            make.right.equalTo(self.view).offset(-7.5*Ratio);
            make.top.equalTo(self.view);
            make.height.equalTo(@(40*Ratio));
        }];
        
        UILabel *label1 = [[UILabel alloc] init];
        label1.numberOfLines = 0;
        [label1 makeLabelWithText:@"宝宝如生长发育方面的问题能“早发现、早干预、早治疗”，从而实现对宝宝全面的健康管理。" andTextColor:MBColor(102, 103, 104, 1) andFont:[UIFont yaHeiFontOfSize:13*Ratio]];
        [self.view addSubview:label1];
        [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view).offset(7.5*Ratio);
            make.right.equalTo(self.view).offset(-7.5*Ratio);
            make.top.equalTo(label.mas_bottom);
            make.height.equalTo(@(40*Ratio));
        }];
    }
   
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _observeArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *str = @"observeIdentifier";
    ObserveTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    
    [cell makeCellByTitle:[[_observeArr objectAtIndex:indexPath.row] objectForKey:@"observecontent"]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSMutableDictionary *attri = [[NSMutableDictionary alloc] init];
    attri[NSFontAttributeName] = [UIFont yaHeiFontOfSize:13*Ratio];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    [paragraphStyle setLineSpacing:6];
    attri[NSParagraphStyleAttributeName] = paragraphStyle;
    CGSize size = [[[_observeArr objectAtIndex:indexPath.row] objectForKey:@"observecontent"] boundingRectWithSize:CGSizeMake(285*Ratio, 200000) options:NSStringDrawingUsesLineFragmentOrigin attributes:attri context:nil].size;
    
   
    return 10*Ratio + size.height ;

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
