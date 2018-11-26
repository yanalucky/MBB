//
//  Fcgo_ScreeningVC.m
//  Fcgo
//
//  Created by by_r on 2017/11/28.
//  Copyright © 2017年 Fcg. All rights reserved.
//

#import "Fcgo_ScreeningVC.h"
#import "Fcgo_BrandCell.h"
#import "Fcgo_SiftModel.h"

#define offset [UIScreen mainScreen].bounds.size.width - 120
#define bottomHeight 49

static NSString *siftIdentifier = @"cell";

@interface Fcgo_ScreeningVC ()<UITableViewDataSource, UITableViewDelegate, Fcgo_BrandCellDelegate>
@property (nonatomic, strong) UIButton  *resetButton; ///< 重置
@property (nonatomic, strong) UIButton  *determineButton; ///< 确定
@property (nonatomic, strong) UITableView   *myTableView;
@property (nonatomic, strong) NSArray    *dataArray;
@end

@implementation Fcgo_ScreeningVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupUI];
//    [self loadData];
}
#pragma mark - private method
- (void)loadData {
    for (NSDictionary *dict in self.dataArray) {
        Fcgo_SiftModel *obj = [Fcgo_SiftModel yy_modelWithDictionary:dict];
        [self.listArray addObject:obj];
    }
    [self.myTableView reloadData];
}

- (void)resetButtonAction {
    [self.listArray removeAllObjects];
    [self loadData];
}

- (void)determineButtonAction {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObjectWithNullValidate:@"" forKey:kTypeTexe];
    [dict setObjectWithNullValidate:@"" forKey:kTypeStart];
    
    for (Fcgo_SiftModel *model in self.listArray) {
        for (Fcgo_SiftSelectModel *obj in model.list) {
            if (obj.selected) {
                if (obj.year) {
                    [dict setObjectWithNullValidate:[self getTheDate:obj.year.integerValue month:obj.month.integerValue day:obj.day.integerValue] forKey:model.type];
                }
                else {
                    [dict setObjectWithNullValidate:obj.value forKey:model.type];
                }
            }
        }
    }
//    if (!dict[kTypeTexe]) {
//        [WSProgressHUD showImage:nil status:@"请选择贸易类型"];
//        return;
//    }
//    if (!dict[kTypeStart]) {
//        [WSProgressHUD showImage:nil status:@"请选择下单时间"];
//        return;
//    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(determineButtonTouchEvent:)]) {
        [self.delegate determineButtonTouchEvent:dict];
    }
}

- (NSString *)getTheDate:(NSInteger)year month:(NSInteger)month day:(NSInteger)day {
    NSDateComponents * components2 = [[NSDateComponents alloc] init];
    components2.year = year;
    components2.month = month;
    components2.day = day;
    NSCalendar *calendar3 = [NSCalendar currentCalendar];
    NSDate *currentDate = [NSDate date];
    NSDate *nextData = [calendar3 dateByAddingComponents:components2 toDate:currentDate options:NSCalendarMatchStrictly];
    NSDateFormatter * formatter1 = [[NSDateFormatter alloc] init];
    formatter1.dateFormat = @"yyyy-MM-dd 00:00:00";
    NSString * str1 = [formatter1 stringFromDate:nextData];
    return str1;
}
#pragma mark - delegate
#pragma mark UITableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.listArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    Fcgo_BrandCell *cell = [tableView dequeueReusableCellWithIdentifier:siftIdentifier];
    cell.delegate = self;
    Fcgo_SiftModel *obj = self.listArray[indexPath.row];
    [cell setModel:obj indexPath:indexPath width:self.width];
    return cell;
}

#pragma mark Fcgo_BrandCellDelegate
- (void)selected:(Fcgo_SiftSelectModel *)model indexPath:(NSIndexPath *)indexPath {
    model.selected = !model.selected;
    if (model.selected) {
        for (Fcgo_SiftSelectModel *obj in [self.listArray[indexPath.row] list]) {
            if (![obj isEqual:model]) {
                obj.selected = NO;
            }
        }
    }
    [self.myTableView reloadData];
}

#pragma mark - UI
- (void)setupUI {
    UITableView *table = [[UITableView alloc] initWithFrame:CGRectMake(0, kNavigationSubY(0), self.width, KScreenHeight - kNavigationSubY(0) - bottomHeight)];
    table.dataSource = self;
    table.delegate = self;
    table.tableFooterView = [UIView new];
    table.separatorStyle = UITableViewCellSeparatorStyleNone;
    table.estimatedRowHeight = 100.f;
    [table registerClass:[Fcgo_BrandCell class] forCellReuseIdentifier:siftIdentifier];
    [self.view addSubview:table];
    _myTableView = table;
    
    [self.resetButton addTarget:self action:@selector(resetButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.determineButton addTarget:self action:@selector(determineButtonAction) forControlEvents:UIControlEventTouchUpInside];
}
#pragma mark - lazy load
- (UIButton *)resetButton//重置
{
    if (!_resetButton) {
        _resetButton = [[UIButton alloc]initWithFrame:CGRectMake(0, KScreenHeight - bottomHeight, self.width/2, bottomHeight)];
        [_resetButton setBackgroundColor:UISepratorLineColor];
        [_resetButton setTitle:@"重置" forState:UIControlStateNormal];
        [_resetButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_resetButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        _resetButton.titleLabel.font = UIFontSize(16);
        [self.view addSubview:_resetButton];
    }
    return _resetButton;
}

- (UIButton *)determineButton//确定
{
    if (!_determineButton) {
        _determineButton = [[UIButton alloc]initWithFrame:CGRectMake(self.width/2, KScreenHeight - bottomHeight, self.width/2, bottomHeight)];
        [_determineButton setBackgroundColor:UIFontRedColor];
        [_determineButton setTitle:@"确定" forState:UIControlStateNormal];
        [_determineButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_determineButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        _determineButton.titleLabel.font = UIFontSize(16);
        [self.view addSubview:_determineButton];
    }
    return _determineButton;
}

- (NSMutableArray *)listArray {
    if (!_listArray) {
        _listArray = @[].mutableCopy;
    }
    return _listArray;
}

- (NSArray *)dataArray {
    if (!_dataArray) {
        _dataArray = @[
                       @{
                           kTitle : @"贸易类型",
                           kType : kTypeTexe,
                           kList : @[
                                   @{
                                       kTitle : @"全部",
                                       kValue : @"",
                                       },
                                   @{
                                       kTitle : @"一般贸易",
                                       kValue : @"1",
                                       },
                                   @{
                                       kTitle : @"跨境保税",
                                       kValue : @"2",
                                       },
                                   @{
                                       kTitle : @"海外直邮",
                                       kValue : @"3",
                                       },
                                   ]
                           },
                       @{
                           kTitle : @"下单时间",
                           kType : kTypeStart,
                           kList : @[
                                   @{
                                       kTitle : @"全部",
                                       kValue : @"",
                                       },
                                   @{
                                       kTitle : @"今天",
                                       kValue : @"",
                                       kYear : @0,
                                       kMonth : @0,
                                       kDay : @0,
                                       },
                                   @{
                                       kTitle : @"最近7天",
                                       kValue : @"",
                                       kYear : @0,
                                       kMonth : @0,
                                       kDay : @-7,
                                       },
                                   @{
                                       kTitle : @"最近30天",
                                       kValue : @"",
                                       kYear : @0,
                                       kMonth : @-1,
                                       kDay : @0,
                                       },
                                   @{
                                       kTitle : @"最近3个月",
                                       kValue : @"",
                                       kYear : @0,
                                       kMonth : @-3,
                                       kDay : @0,
                                       },
                                   @{
                                       kTitle : @"最近6个月",
                                       kValue : @"",
                                       kYear : @0,
                                       kMonth : @-6,
                                       kDay : @0,
                                       },
                                   @{
                                       kTitle : @"最近1年",
                                       kValue : @"",
                                       kYear : @-1,
                                       kMonth : @0,
                                       kDay : @0,
                                       },
                                   ]
                           },
                       ];
    }
    return _dataArray;
}

@end
