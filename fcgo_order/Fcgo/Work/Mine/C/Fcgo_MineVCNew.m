//
//  Fcgo_MineVCNew.m
//  Fcgo
//
//  Created by by_r on 2017/10/19.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_MineVCNew.h"
#import "Fcgo_MineHeadViewNew.h"
#import "Fcgo_MineNavViewNew.h"
#import "Fcgo_MineCellNew.h"
#import "Fcgo_SetupVC.h"
#import "Fcgo_MsgVC.h"
#import "Fcgo_OrderListVC.h"
#import "Fcgo_AfterSalesServiceVC.h"
#import "Fcgo_CouponMessageVC.h"
#import "Fcgo_AddressManagerVC.h"
#import "Fcgo_RealNameVC.h"
#import "Fcgo_CollectVC.h"
#import "Fcgo_ContactServiceVC.h"
#import "Fcgo_PublicNumberVC.h"
#import "Fcgo_FeedbackVC.h"
#import "Fcgo_footPrintVC.h"
#import "Fcgo_AfterSaleVC.h"
#import "Fcgo_OrderListVCNew.h"
#import "Fcgo_SafeVC.h"
#import "Fcgo_EmployeeManagerVC.h"

#import "Fcgo_StoreManagerVC.h"
#import "Fcgo_MembersPointsVC.h"
#import "Fcgo_ShopInformationVC.h"

#define bgImgHeight kAutoWidth6(180)
static NSString  *identifier = @"customCell";

@interface Fcgo_MineVCNew ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) Fcgo_MineNavViewNew   *navView;
@property (nonatomic, strong) Fcgo_MineHeadViewNew *headView;
@property (nonatomic, strong) UIImageView   *bgImageView;
@property (nonatomic, strong) UITableView   *myTableView;

@property (nonatomic, strong) NSMutableArray *cellArray;

@property (nonatomic, copy) NSString *headerImageString;
@end

@implementation Fcgo_MineVCNew
#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupUI];
    [WSProgressHUD showWithStatus:@"数据加载中..." maskType:(WSProgressHUDMaskTypeDefault)];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    CGFloat y = self.myTableView.contentOffset.y;
   CGFloat alpha = y/kAutoWidth6(120);
    if (alpha>0.7) {
        [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleDefault];
    }
    else{
        [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent];
    }
    [self loadRequest];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleDefault];
}

#pragma mark - private method
- (void)loadRequest
{
    WEAKSELF(weakSelf);
    [Fcgo_NetworkManager postRequest:NSFormatHeardMeThodUrl(ServiceLocalTypeOne,ORDERMETHOD,@"orderCountAll") parametersContentCommon:nil successBlock:^(BOOL success, id responseObject, NSString *msg) {
        [WSProgressHUD dismiss];
        [weakSelf.myTableView.mj_header endRefreshing];
        if (success) {
           // NSLog(@">>>>>>%@",responseObject);
            NSNumber *errCode = responseObject[@"errorCode"];
            if (errCode.intValue == 0) {
                [weakSelf setOrderValueWithDictionary:responseObject[@"data"]];
            }
        }
    } failureBlock:^(NSString *description) {}];
    
    [Fcgo_NetworkManager postRequest:NSFormatHeardMeThodUrl(ServiceLocalTypeOne,@"mch/user/",@"myPage") parametersContentCommon:nil successBlock:^(BOOL success, id responseObject, NSString *msg) {
        [WSProgressHUD dismiss];
        [weakSelf.myTableView.mj_header endRefreshing];
        if (success) {
            //NSLog(@">>>>>>%@",responseObject);
            NSNumber *errCode = responseObject[@"errorCode"];
            if (errCode.intValue == 0) {
                [weakSelf setUserValueWithDictionary:responseObject[@"data"]];
            }
        }
    } failureBlock:^(NSString *description) {
        [weakSelf.myTableView.mj_header endRefreshing];
    }];
    
}

- (void)setOrderValueWithDictionary:(NSDictionary *)dictionary {
    NSNumber *perparePay = dictionary[@"waitPay"];
    NSNumber *inHand = dictionary[@"inProgress"];
    NSNumber *consign = dictionary[@"waitSign"];
    //NSNumber *refund = dictionary[@"refund"];
    
    [self.headView.waitPayButton setCountValue:perparePay.integerValue];
    [self.headView.dealButton setCountValue:inHand.integerValue];
    [self.headView.recivedButton setCountValue:consign.integerValue];
    //[self.headView.afterSaleButton setCountValue:refund.integerValue];
}

- (void)setUserValueWithDictionary:(NSDictionary *)dictionary {
    
    NSString *token = [Fcgo_UserTools shared].userDict[@"token"];
    if (!token) {
        return;
    }
    NSMutableDictionary *userDict = [NSMutableDictionary  dictionaryWithDictionary:dictionary];;
    [userDict setObject:token forKey:@"token"];
    [Fcgo_UserTools shared].userDict = userDict;
    
    //传输用户信息
//    NSMutableDictionary *userDict = [[Fcgo_UserTools  shared] userDict];
//    if (userDict) {
//        self.headView.userDict = userDict;
//    }
    self.headView.userDict = dictionary;
    [self.navView setTitleString:dictionary[@"opName"]];
    _headerImageString = dictionary[@"picUrl"];
//    if (_headerImageString.length) {
//        [self.headView.headImageBtn sd_setBackgroundImageWithURL:[NSURL URLWithString:self.headerImageString] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"icon_head-portrait"]];
//    }
}

- (void)touchType:(kHeadTouchType)type {
    UIViewController *viewController = nil;
    switch (type) {
        case kHeadTouchType_setting: //TODO:设置
        {
            Fcgo_SetupVC *setupVC = [[Fcgo_SetupVC alloc]init];
            setupVC.headImageString = self.headerImageString;
            viewController = setupVC;
            break;
        }
        case kHeadTouchType_message: //TODO:消息
        {
            viewController = [[Fcgo_MsgVC alloc]init];
            break;
        }
        case kHeadTouchType_headImage: //TODO:头像
        {
            if ([Fcgo_Tools isNullString:self.headerImageString]) {
                return;
            }
            [[XLImageViewer shareInstanse] showNetImages:@[self.headerImageString] index:0 fromImageContainer:self.headView.headImageBtn];
            break;
        }
        case kHeadTouchType_myOrder: //TODO:我的订单
        case kHeadTouchType_waitPay: //TODO:待付款
        case kHeadTouchType_deal: //TODO:处理中
        case kHeadTouchType_recive: //TODO:待收货
        {
            Fcgo_OrderListVCNew *vc = [[Fcgo_OrderListVCNew alloc]init];
            vc.index = type;
             viewController = vc;
            break;
        }
        case kHeadTouchType_afterSale: //TODO:售后
        {
//            viewController = [[Fcgo_AfterSalesServiceVC alloc]init];
            viewController = [[Fcgo_AfterSaleVC alloc] init];
            break;
        }
        case kHeadTouchType_coupon: //TODO:优惠券
        {
            Fcgo_CouponMessageVC *vc = [[Fcgo_CouponMessageVC alloc]init];
            vc.index = 1;
            viewController = vc;
            break;
        }
        case kHeadTouchType_address: //TODO:地址管理
        {
            viewController = [[Fcgo_AddressManagerVC alloc]init];
            break;
        }
        case kHeadTouchType_common: //TODO:实名认证
        {
            viewController = [[Fcgo_RealNameVC alloc]init];
            break;
        }
        case kHeadTouchType_account: //TODO:账户信息
        {
            Fcgo_ShopInformationVC *vc = [[Fcgo_ShopInformationVC alloc]init];
            vc.hidesBottomBarWhenPushed = 1;
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case kHeadTouchType_security: //TODO:安全中心
        {
            viewController = [[Fcgo_SafeVC alloc] init];
            break;
        }
        case kHeadTouchType_favorite: //TODO:我的收藏
        {
            viewController = [[Fcgo_CollectVC alloc]init];
            break;
        }
        case kHeadTouchType_shop: //TODO:门店管理
        {
            viewController = [[Fcgo_StoreManagerVC alloc]init];
            break;
        }
        case kHeadTouchType_staff: //TODO:员工管理
        {
            viewController = [[Fcgo_EmployeeManagerVC alloc] init];
            break;
        }
        case kHeadTouchType_history: //TODO:我的足迹
        {
            viewController =  [[Fcgo_footPrintVC alloc] init];
            break;
        }
        case kHeadTouchType_pay: //TODO:菲支付
        {
            break;
        }
        case kHeadTouchType_intergral: //TODO:积分
        {
            viewController = [[Fcgo_MembersPointsVC alloc] init];
            break;
        }
        case kHeadTouchType_service: //TODO:联系客服
        {
            viewController = [[Fcgo_ContactServiceVC alloc] init];
            break;
        }
        case kHeadTouchType_subscribe: //TODO:公众号
        {
            viewController = [[Fcgo_PublicNumberVC alloc] init];
            break;
        }
        case kHeadTouchType_feedback: //TODO:意见反馈
        {
            viewController = [[Fcgo_FeedbackVC alloc] init];
            break;
        }
        default:
            break;
    }
    if (viewController) {
        viewController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:viewController animated:YES];
    }
}

#pragma mark - delegate
#pragma mark UITableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.cellArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    Fcgo_MineCellNew *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    Fcgo_MineCellModel *model = self.cellArray[indexPath.row];
    cell.model = model;
    WEAKSELF(weakSelf);
    cell.touchType = ^(kHeadTouchType type) {
        [weakSelf touchType:type];
    };
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

#pragma mark UIScrollView
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat y = scrollView.contentOffset.y;
    CGFloat alpha = y/kAutoWidth6(120);
    self.navView.bgAlpha = alpha;
    self.navigationView.bgAlpha = alpha;
    
    if (alpha>0.7) {
        [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleDefault];
    }
    else{
        [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent];
    }
    if (y<=0) {
        self.bgImageView.frame = CGRectMake(0, 0, kScreenWidth, bgImgHeight-y);
    }
    else {
        if (y > kAutoWidth6(100)) {
            y = kAutoWidth6(100);
        }
        self.bgImageView.frame = CGRectMake(0, -y, kScreenWidth, bgImgHeight);
    }
}

#pragma mark - UI
- (void)setupUI {
    WEAKSELF(weakSelf);
    self.view.backgroundColor = UIBackGroundColor;
    
    Fcgo_MineNavViewNew *navView = [[Fcgo_MineNavViewNew alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kNavigationHeight)];
    [self.navigationView addSubview:self.navView = navView];
    self.navigationView.bgAlpha = 0;
    
    [self.view insertSubview:self.bgImageView belowSubview:self.navigationView];
    [self.view insertSubview:self.myTableView belowSubview:self.navigationView];
    
    Fcgo_MineHeadViewNew *headView = [[Fcgo_MineHeadViewNew alloc] initWithFrame:CGRectZero];
    _headView = headView;
    //[navView setTitleString:userDict[@"merchantFullname"]];
    
    self.myTableView.tableHeaderView = headView;
    [headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(kScreenWidth);
    }];
    [self.myTableView.tableHeaderView layoutIfNeeded];
    self.myTableView.tableHeaderView = headView;
    
    // 刷新
    Fcgo_RefreshNormalHeader *header = [Fcgo_RefreshNormalHeader headerRefreshBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1*NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf loadRequest];
        });
    }];
    [header setTitle:@"" forState:1];
    [header setTitle:@"" forState:2];
    header.stateLabel.hidden = YES;
    self.myTableView.mj_header = header;
    
    // 设置、消息
    navView.touchType = ^(kHeadTouchType type) {
        [weakSelf touchType:type];
    };
    // 订单状态、售后、头像
    headView.touchType = ^(kHeadTouchType type) {
        [weakSelf touchType:type];
    };
}

#pragma mark - lazy load
- (UITableView *)myTableView {
    if (!_myTableView) {
        _myTableView = ({
            UITableView *tab = [[UITableView alloc] initWithFrame:CGRectMake(0, kNavigationHeight, kScreenWidth, KScreenHeight - kTabBarHeight - kNavigationHeight)];
            tab.dataSource = self;
            tab.delegate = self;
            tab.tableFooterView = [UIView new];
            tab.separatorStyle = UITableViewCellSeparatorStyleNone;
            tab.showsVerticalScrollIndicator = NO;
            tab.estimatedRowHeight = 100.f;
            tab.backgroundColor = UIFontClearColor;
            [tab registerClass:[Fcgo_MineCellNew class] forCellReuseIdentifier:identifier];
            if (@available(iOS 11.0, *)) {
                tab.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            }
            tab;
        });
    }
    return _myTableView;
}

- (UIImageView *)bgImageView {
    if (!_bgImageView) {
        _bgImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, bgImgHeight)];
        _bgImageView.image = [UIImage imageNamed:@"BG"];
        _bgImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _bgImageView;
}

- (NSMutableArray *)cellArray {
    if (!_cellArray) {
        _cellArray = ({
            NSMutableArray *mutArray = [NSMutableArray array];
            NSString *file = [[NSBundle mainBundle] pathForResource:@"Fcgo_MineCellData" ofType:@"plist"];
            NSArray *tmpArray = [NSArray arrayWithContentsOfFile:file];
            for (NSDictionary *dict in tmpArray) {
                Fcgo_MineCellModel *obj = [Fcgo_MineCellModel yy_modelWithDictionary:dict];
                [mutArray addObject:obj];
            }
            mutArray;
        });
    }
    return _cellArray;
}

@end
