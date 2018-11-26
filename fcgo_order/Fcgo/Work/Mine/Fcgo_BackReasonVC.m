//
//  Fcgo_BackReasonVC.m
//  Fcgo
//
//  Created by fcg on 2017/10/25.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_BackReasonVC.h"
#import "Fcgo_BackReasonCell.h"
#import "Fcgo_BackDetailVC.h"


@interface Fcgo_BackReasonVC ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) UITableView *tableView;


@property(nonatomic,strong)NSArray *currentArray;
@property(nonatomic,strong)NSMutableArray *selArray;

@end

@implementation Fcgo_BackReasonVC
- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *file = [[NSBundle mainBundle] pathForResource:@"Fcgo_AfterSale" ofType:@"plist"];
    NSArray *tmpArray = [NSArray arrayWithContentsOfFile:file];
    NSDictionary *tempDic = (NSDictionary *)tmpArray[_index];
    _currentArray = [tempDic objectForKey:@"reason"];
    _selArray = [[NSMutableArray alloc] init];
    for (int i=0; i<_currentArray.count; i++) {
        [_selArray addObject:@"0"];
    }
    
    WEAKSELF(weakSelf)
    [self.navigationView setupBackBtnBlock:^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    }];
    NSArray *array = @[@"申请补偿",@"仅退款",@"退货退款"];

    [self.navigationView setupTitleLabelWithTitle:array[self.index]];
    self.navigationView.isShowLine = 1;

    if (@available(iOS 11.0, *)) {
        _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    self.automaticallyAdjustsScrollViewInsets = NO;
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kNavigationHeight, kScreenWidth, KScreenHeight - kNavigationHeight) style:UITableViewStylePlain];
    
    _tableView.backgroundColor = UIRGBColor(246, 244, 242, 1);
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tableView registerNib:[UINib nibWithNibName:@"Fcgo_BackReasonCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"Fcgo_BackReasonCell"];
    [self.view addSubview:_tableView];
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(kNavigationHeight);
        make.left.and.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
    
    // Do any additional setup after loading the view.
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _currentArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kAutoHeight6(45);
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    int temp;
    for (int i=0; i<_selArray.count; i++) {
        if ([_selArray[i] boolValue] == 1) {
            [_selArray replaceObjectAtIndex:i withObject:@"0"];
        }
    }
    [_selArray replaceObjectAtIndex:indexPath.row withObject:@"1"];
    [_tableView reloadData];
    
    Fcgo_BackDetailVC *vc = [[Fcgo_BackDetailVC alloc] init];
    vc.type = self.index;
    vc.model = self.model;
    NSMutableString *str = _currentArray[indexPath.row];
    
    vc.reason = [str stringByReplacingOccurrencesOfString:@" " withString:@""];
    vc.backVC = self.backVC;
    [self.navigationController pushViewController:vc animated:YES];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    Fcgo_BackReasonCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Fcgo_BackReasonCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell makeCellWithTitle:_currentArray[indexPath.row] isSel:[_selArray[indexPath.row] boolValue]];
    return cell;
    
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
