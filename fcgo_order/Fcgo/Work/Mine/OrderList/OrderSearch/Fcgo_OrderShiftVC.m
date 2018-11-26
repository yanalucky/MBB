//
//  Fcgo_OrderShiftVC.m
//  Fcgo
//
//  Created by by_r on 2017/11/28.
//  Copyright © 2017年 Fcg. All rights reserved.
//

#import "Fcgo_OrderShiftVC.h"
#import "Fcgo_MainScreeningVC.h"

@interface Fcgo_OrderShiftVC ()

@end

@implementation Fcgo_OrderShiftVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [self showMoreUIData:NO];
    [self search];
}

#pragma mark - private method
- (void)reloadRequest {
    [self search];
}

- (void)refresh:(BOOL)isTop {
    [self search];
}

- (void)search {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObjectWithNullValidate:@(self.page) forKey:@"page"];
    [dict setObjectWithNullValidate:@"10" forKey:@"rows"];
    [dict setValuesForKeysWithDictionary:self.dictionary];
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

#pragma mark - UI
- (void)setupUI {
    WEAKSELF(weakSelf);
    [self.navigationView setupTitleLabelWithTitle:@"订单筛选"];
    [self.navigationView setupBackBtnBlock:^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    }];
//    [self.navigationView setupRightBtnTitle:@"" Block:^{
////        [weakSelf.siftView show:OrderStatusType_sift];
//        Fcgo_MainScreeningVC *vc = [Fcgo_MainScreeningVC new];
//        weakSelf.definesPresentationContext = YES;
//        vc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
//        vc.view.backgroundColor = UIRGBColor(0, 0, 0, 0.4);
//        [weakSelf presentViewController:vc animated:NO completion:nil];
//    }];
//    [self.navigationView.navRightTitleBtn setImage:[UIImage imageNamed:@"icon_order_screening"] forState:UIControlStateNormal];
    
    [super setupUI];
    

}

@end
