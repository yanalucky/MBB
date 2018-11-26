//
//  Fcgo_OrderUseAdressVC.m
//  Fcgo
//
//  Created by huafanxiao on 2017/6/24.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_OrderUseAdressVC.h"
#import "Fcgo_AddNewAdressVC.h"
#import "Fcgo_AddressSelectedCell.h"
#import "Fcgo_OrderUseAdressCell.h"
#import "Fcgo_AddressModel.h"
#import "Fcgo_AddressManagerVC.h"

@interface Fcgo_OrderUseAdressVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UIView        *segmentView;
@property (nonatomic, strong) UIButton      *leftButton;
@property (nonatomic, strong) UIButton      *rightButton;
@property (nonatomic, strong) UIView        *moveLineView;

@property (nonatomic,strong) UITableView    *table;
@property (nonatomic,strong) NSMutableArray *listArray;
//@property (nonatomic,strong) UIButton       *addNewAdressBtn;

@property (nonatomic, strong) UITableView   *rightTableView;
@property (nonatomic, strong) NSMutableArray *rightArray;

@property (nonatomic, strong) UIView   *leftBgImageView;
@property (nonatomic, strong) UIView   *rightBgImageView;

@end

@implementation Fcgo_OrderUseAdressVC

#pragma mark - life cycle
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self requestUseAdress];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

#pragma mark - private method
- (void)requestUseAdress {
    [WSProgressHUD showWithStatus:@"数据加载中..." maskType:WSProgressHUDMaskTypeClear];
    WEAKSELF(weakSelf)
    NSMutableDictionary   *paremtes = [NSMutableDictionary dictionary];
    NSMutableArray *goodsArray = [NSMutableArray array];
    for (int i = 0; i < self.model.listArray.count; i ++) {
        Fcgo_OrderGoodsModel *model = self.model.listArray[i];
        NSDictionary *dict = @{@"goodsNumber":[NSString stringWithFormat:@"%@",model.goodsTypeBo.goodsNumber],
                               @"goodsType":model.goodsTypeBo.goodsType,
                               @"goodsValue":[NSString stringWithFormat:@"%@",model.goodsTypeBo.goodsValue],
                               };
        [goodsArray addObject:dict];
    }
    NSString *jsonStr=[Fcgo_publicNetworkTools arrayToJson:goodsArray];
    [paremtes  setObjectWithNullValidate:jsonStr forKey:@"goods"];
    
    [Fcgo_NetworkManager postRequest:NSFormatHeardMeThodUrl(ServiceLocalTypeOne, ADDRESSMETHOD, @"getCanUseAddress")  parametersContentCommon:paremtes successBlock:^(BOOL success, id responseObject, NSString *msg) {
        [WSProgressHUD dismiss];
        if (success) {
            NSNumber *errCode = responseObject[@"errorCode"];
            if (errCode.intValue == 0)
            {
                [weakSelf.listArray removeAllObjects];
                [weakSelf.rightArray removeAllObjects];
                NSArray *addressArray = responseObject[@"data"][@"can"];
                for (int i = 0;  i < addressArray.count; i ++) {
                    NSDictionary *addressDict = addressArray[i];
                    Fcgo_AddressModel *model = [Fcgo_AddressModel yy_modelWithDictionary:addressDict];
                    if (weakSelf.model) {
                        if (model.f_address_id.integerValue == weakSelf.addressModel.f_address_id.integerValue) {
                            model.selected = YES;
                        }
                    }
                    else {
                        model.selected = model.deFault.integerValue == 1;
                    }
                    [weakSelf.listArray addObject:model];
                }
                NSArray *nocanArray = responseObject[@"data"][@"nocan"];
                for (NSDictionary *addressDict in nocanArray) {
                    Fcgo_AddressModel *obj = [Fcgo_AddressModel yy_modelWithDictionary:addressDict];
//                    obj.haveData = YES;
                    [weakSelf.rightArray addObject:obj];
                }
            }
            [weakSelf.table reloadData];
            [weakSelf.rightTableView reloadData];
            
            [weakSelf showUIData:YES];
        }
    } failureBlock:^(NSString *description) {
        weakSelf.table.hidden = 0;
        [weakSelf showUIData:NO];
    }];
}


- (void)showUIData:(BOOL)isShow
{
    [self showNoControl:!isShow titleString:@"网络错误,点击重新加载" imageString:@"ico_no-wifi"];
    self.table.hidden = !isShow;
    self.rightTableView.hidden = isShow;
    
    if(self.table.hidden == 0)
    {
        CGPoint point = self.moveLineView.center;
        point.x = _leftButton.center.x;
        self.moveLineView.center = point;
    }
}

- (void)addNewAdress {
    Fcgo_AddNewAdressVC *vc = [[Fcgo_AddNewAdressVC alloc]init];
    vc.hidesBottomBarWhenPushed = 1;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)segmentAction:(UIButton *)sender {
    CGPoint point = self.moveLineView.center;
    point.x = sender.center.x;
    self.moveLineView.center = point;

    self.table.hidden = sender.tag != 1;
    self.rightTableView.hidden = sender.tag != 2;
}

#pragma mark - delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (tableView == self.table) {
        if (self.listArray.count) {
            tableView.tableFooterView = [UIView new];
        }
        else {
            tableView.tableFooterView = _leftBgImageView;
        }
        return self.listArray.count;
    } else {
        if (self.rightArray.count) {
            tableView.tableFooterView = [UIView new];
        }
        else {
            tableView.tableFooterView = _rightBgImageView;
        }
        return self.rightArray.count;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;//self.listArray.count;//1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    Fcgo_AddressSelectedCell *cell = nil;
    if (tableView == self.table) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"cellLeft"];
        Fcgo_AddressModel *model = self.listArray[indexPath.section];
        cell.model = model;
    } else {
        cell = [tableView dequeueReusableCellWithIdentifier:@"cellRight"];
        Fcgo_AddressModel *obj = self.rightArray[indexPath.section];
        cell.model = obj;
        WEAKSELF(weakSelf);
        cell.open = ^(Fcgo_AddressModel *model) {
            model.isOpen = !model.isOpen;
            [weakSelf.rightTableView reloadData];
        };
    }
    return cell;
//    Fcgo_OrderUseAdressCell *cell = [tableView dequeueReusableCellWithIdentifier:@"orderUseAdressCell"];
//    if (self.listArray.count > 0) {
//        Fcgo_AddressModel *model = self.listArray[indexPath.row];
//        cell.model = model;
//    }
//    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.table) {
        Fcgo_AddressModel *model = self.listArray[indexPath.section];
        model.selected = !model.selected;
        for (Fcgo_AddressModel *obj in self.listArray) {
            if (obj != model) {
                obj.selected = NO;
            }
        }
        [self.table reloadData];
        if (self.selectedBlock) {
            self.selectedBlock(model);
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
//    return 91;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.5f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *v = [[UIView alloc] init];
    v.backgroundColor = UISepratorLineColor;
    return v;
}

#pragma mark - UI
- (void)setupUI {
    WEAKSELF(weakSelf)
    [self.navigationView setupBackBtnBlock:^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    }];
    [self.navigationView setupTitleLabelWithTitle:@"地址选择"];
    [self.navigationView setupRightBtnTitle:@"添加地址" Block:^{
        [weakSelf addNewAdress];
//        Fcgo_AddressManagerVC *vc = [[Fcgo_AddressManagerVC alloc]init];
//        vc.hidesBottomBarWhenPushed = 1;
//        [weakSelf.navigationController pushViewController:vc animated:1];
    }];
//    [self.addNewAdressBtn addTarget:self action:@selector(addNewAdress) forControlEvents:UIControlEventTouchUpInside];
//
//    [self.view addSubview:self.addNewAdressBtn];
//    [self.addNewAdressBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.bottom.mas_offset(0);
//        make.height.mas_offset(kAutoWidth6(50));
//    }];
    CGFloat segHeight = 45.f;
    // 切换按钮
    UIView *segment = [[UIView alloc] initWithFrame:CGRectMake(0, kNavigationHeight, kScreenWidth, segHeight)];
    segment.backgroundColor = [UIColor whiteColor];
    _segmentView = segment;

    UIButton *left = [UIButton buttonWithType:UIButtonTypeCustom];
    left.frame = CGRectMake(0, 0, CGRectGetWidth(self.segmentView.frame)/2.0, CGRectGetHeight(self.segmentView.frame));
    left.tag = 1;
    [left setTitle:@"可选择地址" forState:UIControlStateNormal];
    [left setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    left.titleLabel.font = [UIFont systemFontOfSize:15];
    [left addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventTouchUpInside];
    _leftButton = left;

    UIButton *right = [UIButton buttonWithType:UIButtonTypeCustom];
    right.frame = CGRectMake(CGRectGetMaxX(self.leftButton.frame), 0, CGRectGetWidth(self.leftButton.frame), CGRectGetHeight(self.leftButton.frame));
    right.tag = 2;
    [right setTitle:@"不可选择地址" forState:UIControlStateNormal];
    [right setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    right.titleLabel.font = [UIFont systemFontOfSize:15];
    [right addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventTouchUpInside];
    _rightButton = right;

    UIView *line = [[UIView alloc] init];
    line.center = CGPointMake(self.leftButton.center.x, CGRectGetHeight(self.segmentView.frame)-2);
    line.bounds = CGRectMake(0, 0, 40, 2);
    line.backgroundColor = UIRGBColor(246, 51, 120, 1);
    _moveLineView = line;

    [self.view insertSubview:_segmentView belowSubview:self.navigationView];
    [self.segmentView addSubview:self.leftButton];
    [self.segmentView addSubview:self.rightButton];
    [self.segmentView addSubview:self.moveLineView];
    
    // 左侧table
    UITableView *table    = [[UITableView alloc]initWithFrame:CGRectMake(0, kNavigationHeight + segHeight, kScreenWidth, KScreenHeight-kNavigationHeight - segHeight) style:UITableViewStylePlain];
    table.backgroundColor = UIBackGroundColor;
    table.separatorStyle  = 0;
    table.delegate        = self;
    table.dataSource      = self;
    if (@available(iOS 11.0, *)) {
        table.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    table.estimatedRowHeight = 100.f;
    
    UIView *footerView   = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 5)];
    footerView.backgroundColor = UIBackGroundColor;
    table.tableFooterView = footerView;
    [table registerClass:[Fcgo_AddressSelectedCell class] forCellReuseIdentifier:@"cellLeft"];
    [self.view insertSubview:table belowSubview:self.navigationView];
    table.hidden = 1;
    _table                = table;
    [self.table registerNib:[UINib nibWithNibName:NSStringFromClass([Fcgo_OrderUseAdressCell class]) bundle:nil] forCellReuseIdentifier:@"orderUseAdressCell"];
    
    // 右侧table
    UITableView *tableR = [[UITableView alloc] initWithFrame:self.table.frame];
    tableR.backgroundColor = UIBackGroundColor;
    tableR.separatorStyle  = 0;
    tableR.delegate        = self;
    tableR.dataSource      = self;
    tableR.hidden          = YES;
    tableR.tableFooterView = [UIView new];
    tableR.estimatedRowHeight = 100.f;
    [tableR registerClass:[Fcgo_AddressSelectedCell class] forCellReuseIdentifier:@"cellRight"];
    [self.view insertSubview:tableR belowSubview:self.segmentView];
    _rightTableView = tableR;
    if (@available(iOS 11.0, *)) {
        tableR.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    
    _leftBgImageView = [self getBgImageView:table.bounds];
    
    _rightBgImageView = [self getBgImageView:tableR.bounds];
}

- (UIView *)getBgImageView:(CGRect)frame {
    UIView *bgView = [[UIView alloc] initWithFrame:frame];
    UIImage *image = [UIImage imageNamed:@"icon-ad"];
    UIImageView *bg = [[UIImageView alloc] initWithImage:image];
    bg.contentMode = UIViewContentModeScaleAspectFit;
    bg.center = CGPointMake(frame.size.width / 2, frame.size.height / 2 - 50);
    bg.bounds = CGRectMake(0, 0, kAutoWidth6(120), kAutoWidth6(120));
    [bgView addSubview:bg];
    
    UILabel *descLabel = [[UILabel alloc]init];
    descLabel.font = [UIFont systemFontOfSize:14];
    descLabel.textColor = UIFontSortGrayColor;
    descLabel.textAlignment = NSTextAlignmentCenter;
    descLabel.numberOfLines = 2;
    descLabel.text = @"暂无不可用地址";
    descLabel.frame = CGRectMake(0, bg.mj_y+bg.mj_h +kAutoWidth6(40), frame.size.width, 20);
    
    [bgView addSubview:descLabel];
    
    
    return bgView;
}

#pragma mark - Lazy method

- (NSMutableArray *)listArray {
    if (!_listArray) {
        _listArray = [[NSMutableArray alloc]init];
    }
    return _listArray;
}

- (NSMutableArray *)rightArray {
    if (!_rightArray) {
        _rightArray = [NSMutableArray array];
    }
    return _rightArray;
}

//- (UIButton *)addNewAdressBtn
//{
//    if (!_addNewAdressBtn) {
//        _addNewAdressBtn = [UIButton buttonWithType:UIButtonTypeSystem];
//        _addNewAdressBtn.titleLabel.font = UIFontSize(16);
//        [_addNewAdressBtn setTitle:@"添加新地址" forState:UIControlStateNormal];
//        [_addNewAdressBtn setTitleColor:UIFontWhiteColor forState:UIControlStateNormal];
//        [_addNewAdressBtn setBackgroundColor:UIFontRedColor];
//    }
//    return _addNewAdressBtn;
//}

@end

