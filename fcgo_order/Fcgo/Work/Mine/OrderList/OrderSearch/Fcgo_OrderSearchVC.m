//
//  Fcgo_OrderSearchVC.m
//  Fcgo
//
//  Created by by_r on 2017/11/27.
//  Copyright © 2017年 Fcg. All rights reserved.
//

#import "Fcgo_OrderSearchVC.h"
#import "Fcgo_SearchNavView.h"

@interface Fcgo_OrderSearchVC ()<UITextFieldDelegate>
@property (nonatomic, strong) Fcgo_SearchNavView    *searchView;
@end

@implementation Fcgo_OrderSearchVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [self showMoreUIData:NO];
}

#pragma mark - private method
- (void)reloadRequest {
    [self search:self.searchView.searchTextField.text];
}

- (void)refresh:(BOOL)isTop {
    [self search:self.searchView.searchTextField.text];
}

- (void)searchCancel {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)search:(NSString *)string {
    while ([string containsString:@" "]) {
        string = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
    }
    if (!string.length) {
        return;
    }
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObjectWithNullValidate:@(self.page) forKey:@"page"];
    [dict setObjectWithNullValidate:@"10" forKey:@"rows"];
    if (string.length > 6 && [self isPureNumandCharacters:string]) {
        [dict setObjectWithNullValidate:string forKey:@"expNo"];
    }
    else if ([self isOrderNo:string]) {
        [dict setObjectWithNullValidate:string forKey:@"orderNo"];
    }
    else {
        [dict setObjectWithNullValidate:string forKey:@"goodsName"];
    }
    WEAKSELF(weakSelf);
    [WSProgressHUD showWithStatus:@"加载中..." maskType:(WSProgressHUDMaskTypeDefault)];
    [Fcgo_NetworkManager postRequest:NSFormatHeardMeThodUrl(ServiceLocalTypeOne, ORDERMETHOD, @"orderList") parametersContentCommon:dict successBlock:^(BOOL success, id responseObject, NSString *msg) {
        if (success) {
            NSMutableArray *tmpArray = @[].mutableCopy;
            NSArray *list = responseObject[@"data"][@"list"];
            for (NSDictionary *dic in list) {
                Fcgo_OrderListModel *model = [Fcgo_OrderListModel yy_modelWithDictionary:dic];
                [tmpArray addObject:model];
            }
            if (weakSelf.page == 1) {
                [weakSelf.allOrderView setOrderListWithArray:tmpArray];
            }
            else {
                [weakSelf.allOrderView addOrderListWithArray:tmpArray];
            }
            [weakSelf.allOrderView.table.mj_footer resetNoMoreData];
            if (list.count < 10) {
                [weakSelf.allOrderView.table.mj_footer endRefreshingWithNoMoreData];
            }
            else {
                weakSelf.page += 1;
                [weakSelf.allOrderView.table.mj_footer endRefreshing];
            }
            if (weakSelf.allOrderView.orderListArray.count <= 0) {
                [weakSelf showMoreUIData:NO];
            }
            else {
                [weakSelf showMoreUIData:YES];
            }
        }
        else {
            [weakSelf showUIData:NO];
        }
        [weakSelf.allOrderView.table.mj_header endRefreshing];
    } failureBlock:^(NSString *description) {
        [weakSelf showUIData:NO];
        [weakSelf.allOrderView.table.mj_header endRefreshing];
        if (weakSelf.allOrderView.table.mj_footer.isRefreshing) {
            weakSelf.page = weakSelf.page > 1 ? weakSelf.page -- : 1;
            [weakSelf.allOrderView.table.mj_footer endRefreshing];
        }
    }];
}

/// 判断订单号，订单号前六位为大写字母，后十八位为数字. 或是前三位为大写字母，后二十一为为数字
- (BOOL)isOrderNo:(NSString *)string {
    NSString *pattern = @"(^[A-Z]{6}\\d{18}$)|(^[A-Z]{3}\\d{21}$)";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",pattern];
    return [pred evaluateWithObject:string.uppercaseString];
}
/// 判断是否为纯数字，用于物流单号
- (BOOL)isPureNumandCharacters:(NSString *)string {
    string = [string stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]];
    if (string.length) {
        return NO;
    }
    return YES;
}

#pragma mark - delegate
#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    self.page = 1;
    [self search:textField.text];
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - UI
- (void)setupUI {
    WEAKSELF(weakSelf);
     Fcgo_SearchNavView *searchView = [[Fcgo_SearchNavView alloc] initWithFrame:CGRectMake(0, kNavigationSubY(20), kScreenWidth, 44) cancel:^{
        [weakSelf searchCancel];
    } start:^(BOOL containText, NSString *string) {
//        [weakSelf search:string];
    } search:^(NSString *string) {
        [weakSelf search:string];
    }];
    searchView.searchTextField.delegate = self;
    searchView.searchTextField.placeholder = @"请输入订单号/运单编号/商品名称";
    [searchView.searchTextField becomeFirstResponder];
    _searchView = searchView;
    
    [self.navigationView addSubview:searchView];
    
    [super setupUI];
}

//- (void)showUIData:(BOOL)isShow {
//    [self showNoControl:!isShow titleString:@"网络错误，点击重新加载" imageString:@"ico_no-wifi"];
//    [self updateNoControlFrame];
//    self.allOrderView.hidden = !isShow;
//}
//
//- (void)showMoreUIData:(BOOL)isShow {
//    [self showNoControl:!isShow titleString:@"搜索无结果" imageString:@"ico_no-order"];
//    [self updateNoControlFrame];
//    self.allOrderView.hidden = !isShow;
//}

@end
