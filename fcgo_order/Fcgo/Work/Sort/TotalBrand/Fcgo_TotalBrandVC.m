//
//  Fcgo_TotalBrandVC.m
//  Fcgo
//
//  Created by huafanxiao on 2017/5/23.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_TotalBrandVC.h"
#import "Fcgo_BrandListTableViewCell.h"
#import "Fcgo_BrandModel.h"
#import "Fcgo_BrandListModel.h"
#import "Fcgo_GoodsListVC.h"

@interface Fcgo_TotalBrandVC ()<UITableViewDelegate,UITableViewDataSource,SCIndexViewDelegate>

@property(nonatomic,strong)NSMutableArray *listArray;
@property(nonatomic,strong)NSMutableArray *keysArray;
@property(nonatomic,strong)UITableView    *table;
@property (nonatomic, strong) SCIndexView *indexView;

@end

@implementation Fcgo_TotalBrandVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupUI];
    [self reloadRequest];
}

- (void)setupUI;
{
    WEAKSELF(weakSelf)
    [self.navigationView setupBackBtnBlock:^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    }];
    [self.navigationView setupTitleLabelWithTitle:@"品牌"];
    [self.view addSubview:self.table];
    [self.view addSubview:self.indexView];
}

- (void)reloadRequest
{
    if (![Fcgo_Tools isNetworkConnected]) {
        [WSProgressHUD showImage:nil status:@"亲,没联网啊"];
        [self showUIData:NO];
        return;
    }
    [WSProgressHUD showWithStatus:@"加载中..." maskType:WSProgressHUDMaskTypeClear];
    
    WEAKSELF(weakSelf)
    [Fcgo_NetworkManager postRequest:NSFormatHeardMeThodUrl(ServiceLocalTypeOne, GOODMETHOD, @"brand/brandListByLetter") parametersContentCommon:nil successBlock:^(BOOL success, id responseObject, NSString *msg) {
        if (success) {
            [weakSelf showUIData:1];
            NSArray *dataArray = (NSArray *)responseObject[@"data"];
            
            for (int i = 0; i < dataArray.count; i++) {
                NSDictionary *letterDict = dataArray[i];
                NSMutableArray *letterMutableArray = [NSMutableArray array];
                NSArray *letterArray = letterDict[@"brandList"];
              for (int i = 0; i < letterArray.count; i++) {
                  NSDictionary *listDict = letterArray[i];
                  Fcgo_BrandListModel *model = [Fcgo_BrandListModel yy_modelWithDictionary:listDict];
                  [letterMutableArray addObject:model];
               }
                [weakSelf.keysArray addObject:letterDict[@"letter"]];
                [weakSelf.listArray addObject:letterMutableArray];
                //@[@"a",@"A",@"B",@"C",@"D",@"E"].copy;//
            }
            weakSelf.indexView.dataSource = weakSelf.keysArray;
            [weakSelf.table reloadData];
            [WSProgressHUD dismiss];
        }else{
           [weakSelf showUIData:0];
        }
    } failureBlock:^(NSString *description) {
        [weakSelf showUIData:0];
    }];
}

- (void)showUIData:(BOOL)isShow
{
    [self showNoControl:!isShow titleString:@"网络错误,点击重新加载" imageString:@"ico_no-wifi"];
    self.table.hidden = !isShow;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.listArray.count) {
        return self.listArray.count;
    }
   return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   if (self.listArray.count > 0)
   {
        NSMutableArray *letterArray = self.listArray[section];
        return letterArray.count;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kAutoWidth6(50);
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
   return 24;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 24)];
    headView.backgroundColor = UIBackGroundColor;
    UILabel *titleLabel      = [[UILabel alloc]init];
    titleLabel.font          = UIFontSize(15);
    titleLabel.textColor     = UIFontRedColor;
    titleLabel.textAlignment = NSTextAlignmentLeft;
    if (self.keysArray.count>0) {
        titleLabel.text          = self.keysArray[section];
    }
    [headView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(headView);
        make.left.equalTo(headView).offset(15);
        make.height.mas_offset(24);
    }];
    return headView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Fcgo_BrandListTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"brandListTableViewCell"];
    if (self.listArray.count > 0) {
        NSMutableArray *letterArray = self.listArray[indexPath.section];
        Fcgo_BrandListModel *model = letterArray[indexPath.row];
        cell.titleLabel.text = model.name;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.listArray.count > 0) {
        NSMutableArray *letterArray = self.listArray[indexPath.section];
        Fcgo_BrandListModel *model = letterArray[indexPath.row];
        Fcgo_GoodsListVC *vc = [[Fcgo_GoodsListVC alloc]init];
        vc.hidesBottomBarWhenPushed = 1;
        vc.brandIds = [NSString stringWithFormat:@"%@",model.ID];
        vc.key = @"brand";
        [self.navigationController pushViewController:vc animated:YES];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

//- (nullable NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView
//{
//    if (self.keysArray) {
//        return  [self.keysArray sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2){
//            return [obj1 localizedCompare:obj2];
//        }];
//    }
//    return @[];
//}

#pragma mark - SCIndexViewDelegate

- (void)indexView:(SCIndexView *)indexView didSelectAtIndex:(NSUInteger)index
{
    
}

- (NSMutableArray *)listArray
{
    if (!_listArray) {
        _listArray = [[NSMutableArray alloc]init];
    }
    return _listArray;
}
- (NSMutableArray *)keysArray
{
    if (!_keysArray) {
        _keysArray = [[NSMutableArray alloc]init];
    }
    return _keysArray;
}

- (UITableView *)table
{
    if (!_table) {
        UITableView *table = [[UITableView alloc]initWithFrame:CGRectMake(0, kNavigationHeight, kScreenWidth, KScreenHeight - kNavigationHeight) style:UITableViewStylePlain];
        table.delegate = self;
        table.dataSource = self;
        table.backgroundColor = UIBackGroundColor;
        table.sectionIndexBackgroundColor = UIFontClearColor;
        table.sectionIndexColor = UIFontMiddleGrayColor;
        table.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
        [table registerNib:[UINib nibWithNibName:NSStringFromClass([Fcgo_BrandListTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"brandListTableViewCell"];
        _table = table;
        if (@available(iOS 11.0, *)) {
            table.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return _table;
}

- (SCIndexView *)indexView
{
    if (!_indexView) {
        _indexView = [[SCIndexView alloc] initWithTableView:self.table configuration:[SCIndexViewConfiguration configurationWithIndexViewStyle:SCIndexViewStyleCenterToast]];
        _indexView.translucentForTableViewInNavigationBar = NO;
        _indexView.delegate = self;
    }
    return _indexView;
}

@end
