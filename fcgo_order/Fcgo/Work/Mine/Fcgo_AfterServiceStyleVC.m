//
//  Fcgo_AfterServiceStyleVC.m
//  Fcgo
//
//  Created by fcg on 2017/10/25.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_AfterServiceStyleVC.h"
#import "Fcgo_AfterServiceStyleCell.h"
#import "Fcgo_BackReasonVC.h"

@interface Fcgo_AfterServiceStyleVC ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) UITableView *tableView;

@property(nonatomic,strong)NSMutableArray *dataArray;

@end

@implementation Fcgo_AfterServiceStyleVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataArray = [[NSMutableArray alloc] init];
    NSDictionary *dic0 = @{@"img":@"icon_pending_after-sales",@"title":@"申请补偿"};
    NSDictionary *dic1 = @{@"img":@"icon_drawback_after-sales",@"title":@"仅退款"};
    NSDictionary *dic2 = @{@"img":@"icon_succeeded_after-sales",@"title":@"退货退款"};
    [_dataArray addObject:dic0];
    [_dataArray addObject:dic1];
    [_dataArray addObject:dic2];
    
    WEAKSELF(weakSelf)
    [self.navigationView setupBackBtnBlock:^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    }];
    [self.navigationView setupTitleLabelWithTitle:@"选择服务类型"];
    
    if (@available(iOS 11.0, *)) {
        _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kNavigationHeight, kScreenWidth, KScreenHeight - kNavigationHeight) style:UITableViewStyleGrouped];

    _tableView.backgroundColor = UIRGBColor(246, 244, 242, 1);
    [_tableView registerNib:[UINib nibWithNibName:@"Fcgo_AfterServiceStyleCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"Fcgo_AfterServiceStyleCell"];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
    
    // Do any additional setup after loading the view.
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kAutoHeight6(44);
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return kAutoHeight6(108);
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    
    UIView *headerView = [[UIView alloc] init];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, kAutoHeight6(104))];
    view.backgroundColor = UIFontWhiteColor;
    UIImageView *goodImg = [[UIImageView alloc] initWithFrame:CGRectMake(kAutoWidth6(12), kAutoHeight6(12), kAutoWidth6(80), kAutoWidth6(80))];
    [goodImg sd_setImageWithURL:[NSURL URLWithString:self.model.goodsSkuPicurl] placeholderImage:[UIImage imageNamed:@"580X580"]];
    [view addSubview:goodImg];
    [goodImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.and.height.mas_equalTo(kAutoWidth6(66));
        make.centerY.equalTo(view);
        make.left.equalTo(view).offset(kAutoWidth6(10));
    }];
    UILabel *goodNameLab = [[UILabel alloc] init];
    goodNameLab.text = self.model.goodsName;
    goodNameLab.numberOfLines = 2;
    goodNameLab.font = UIFontSize(16);
    goodNameLab.textColor = UIFontBlack282828;
    [view addSubview:goodNameLab];
    [goodNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(goodImg.mas_right).offset(kAutoWidth6(5));
        make.right.equalTo(view).offset(-kAutoWidth6(12));
        make.top.equalTo(goodImg);
    }];
    
    UILabel *goodSttr = [[UILabel alloc] init];
    goodSttr.text = self.model.properties;
    goodSttr.numberOfLines = 2;
    goodSttr.font = UIFontSize(12);
    goodSttr.textColor = UIStringColor(@"#7b7b7b");
    [view addSubview:goodSttr];
    [goodSttr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(goodImg.mas_right).offset(kAutoWidth6(5));
        make.right.equalTo(view).offset(-kAutoWidth6(12));
        make.top.equalTo(goodNameLab.mas_bottom).offset(12);
    }];
    
    
    [headerView addSubview:view];
    
//    UILabel *lineLab = [[UILabel alloc] initWithFrame:CGRectMake(0, kAutoHeight6(90), tableView.bounds.size.width, kAutoHeight6(4))];
//    lineLab.backgroundColor = UIRGBColor(246, 244, 242, 1);
//    [headerView addSubview:lineLab];
    
    return headerView;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    Fcgo_AfterServiceStyleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Fcgo_AfterServiceStyleCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell makeCellWithTitle:_dataArray[indexPath.row][@"title"] image:_dataArray[indexPath.row][@"img"]];
    return cell;
    
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    Fcgo_BackReasonVC *vc = [[Fcgo_BackReasonVC alloc] init];
    vc.index = indexPath.row;
    vc.model = self.model;
    vc.backVC = self.backVC;
    [self.navigationController pushViewController:vc animated:YES];
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
