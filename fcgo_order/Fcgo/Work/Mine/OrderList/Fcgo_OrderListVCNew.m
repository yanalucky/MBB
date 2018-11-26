//
//  Fcgo_OrderListVCNew.m
//  Fcgo
//
//  Created by by_r on 2017/10/24.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_OrderListVCNew.h"
#import "Fcgo_OrderListNavView.h"
#import "Fcgo_TopAnimationView.h"

#import "UIParameter.h"
#import "NinaPagerView.h"

#import "Fcgo_OrderList_UIBaisc_VC.h"

#import "Fcgo_OrderListTotalOrderVC.h"
#import "Fcgo_OrderListWaitPayVC.h"
#import "Fcgo_OrderListDealVC.h"
#import "Fcgo_OrderListWaitRecivedVC.h"
#import "Fcgo_OrderListRecivedVC.h"
#import "Fcgo_OrderListCancelVC.h"
#import "Fcgo_OrderSearchVC.h"
#import "Fcgo_OrderShiftVC.h"
#import "Fcgo_MainScreeningVC.h"

#import "Fcgo_OrderListModel.h"
#import "Fcgo_OrderListSiftView.h"

@interface Fcgo_OrderListVCNew ()<NinaPagerViewDelegate, Fcgo_ScreeningVCDelegate>
@property (nonatomic, strong) Fcgo_OrderListNavView *navView;
@property (nonatomic,strong) NSArray            *ninaVCsArray;
@property (nonatomic,strong) NinaPagerView      *ninaPagerView;
@property (nonatomic,assign) NSInteger    currentIndexForOrderType;//记录选中的是那种订单类型
//@property (nonatomic, strong) Fcgo_OrderListSiftView *siftView;
@property (nonatomic, strong) Fcgo_MainScreeningVC *siftVC;
@end

@implementation Fcgo_OrderListVCNew

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}
#pragma mark - delegate
- (void)ninaCurrentPageIndex:(NSString *)currentPage currentObject:(id)currentObject {
    Fcgo_OrderList_UIBaisc_VC *vc = (Fcgo_OrderList_UIBaisc_VC *)currentObject;
    NSString *status = [NSString string];
    int currentPage_int = currentPage.intValue;
    self.index = currentPage_int + 1;
    
    if (currentPage_int == 0) {
        status = @"";
    }
    else if (currentPage_int == 1) {
        status = @"1";
    }
    else if (currentPage_int == 2) {
        status = @"2,3,10";
    }
    else if (currentPage_int == 3) {
        status = @"20,25";
    }
    else if (currentPage_int == 4) {
        status = @"100,40";
    }
    else if (currentPage_int == 5) {
        status = @"30,50";
    }
    [vc requestOrderListWithStatus:status];
}
#pragma mark Fcgo_ScreeningVCDelegate
- (void)determineButtonTouchEvent:(NSDictionary *)dictionary {
    Fcgo_OrderShiftVC *vc = [[Fcgo_OrderShiftVC alloc] init];
    vc.dictionary = dictionary;
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark - UI
- (void)setupUI {
    WEAKSELF(weakSelf)
    Fcgo_OrderListNavView *navView = [[Fcgo_OrderListNavView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kNavigationHeight)];
    [self.navigationView addSubview:self.navView = navView];
    navView.searchBlock = ^{
        Fcgo_OrderSearchVC *vc = [[Fcgo_OrderSearchVC alloc] init];
        [weakSelf.navigationController pushViewController:vc animated:YES];

    };
    navView.siftBlock = ^{
//        [weakSelf.siftView show:OrderStatusType_sift];
        [weakSelf presentViewController:weakSelf.siftVC animated:NO completion:NULL];
    };
    //遮盖层消失。页面返回
    [self.navigationView setupBackBtnBlock:^{
        [[Fcgo_TopAnimationView sharedClient] dismissBlock:^{
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }];
    }];
    [self.view  insertSubview:self.ninaPagerView belowSubview:self.navigationView];
    self.ninaPagerView.ninaChosenPage = self.index;
    for (int i = 0; i < self.ninaVCsArray.count; i ++) {
        Fcgo_OrderList_UIBaisc_VC *vc = self.ninaVCsArray[i];
        vc.type = self.currentIndexForOrderType;
    }
//    [self.view addSubview:self.siftView];
    
    _siftVC = [Fcgo_MainScreeningVC new];
    self.definesPresentationContext = YES;
    _siftVC.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    _siftVC.view.backgroundColor = UIRGBColor(0, 0, 0, 0.4 );
    _siftVC.delegate = self;
}
#pragma mark - LazyLoad
- (NinaPagerView *)ninaPagerView {
    if (!_ninaPagerView) {
        NSArray *titleArray = [self ninaTitleArray];
        CGRect pagerRect = CGRectMake(0, kNavigationHeight, FUll_VIEW_WIDTH, FUll_CONTENT_HEIGHT);
        _ninaPagerView = [[NinaPagerView alloc] initWithFrame:pagerRect WithTitles:titleArray WithVCs:self.ninaVCsArray];
        _ninaPagerView.ninaPagerStyles    = NinaPagerStyleBottomLine;
        _ninaPagerView.underlineColor     = UIFontRedColor;
        _ninaPagerView.selectTitleColor   = UIFontRedColor;
        _ninaPagerView.unSelectTitleColor = UIFontMainGrayColor;
        _ninaPagerView.delegate = self;
        _ninaPagerView.selectBottomLinePer = 0.5;
    }
    return _ninaPagerView;
}

- (NSArray *)ninaTitleArray {
    return @[
             @"全部",
             @"待付款",
             @"处理中",
             @"待收货",
             @"已完成",
             @"已取消"
             ];
}

- (NSArray *)ninaVCsArray {
    if (!_ninaVCsArray) {
        _ninaVCsArray = @[
                          [[Fcgo_OrderListTotalOrderVC  alloc]init],
                          [[Fcgo_OrderListWaitPayVC     alloc]init],
                          [[Fcgo_OrderListDealVC        alloc]init],
                          [[Fcgo_OrderListWaitRecivedVC alloc]init],
                          [[Fcgo_OrderListRecivedVC     alloc]init],
                          [[Fcgo_OrderListCancelVC   alloc]init],
                          ];
    }
    return _ninaVCsArray;
}

//- (Fcgo_OrderListSiftView *)siftView {
//    if (!_siftView) {
//        WEAKSELF(weakSelf);
//        _siftView = [[Fcgo_OrderListSiftView alloc] initWithFrame:CGRectMake(0, kNavigationHeight, kScreenWidth, KScreenHeight-kNavigationHeight)];
//        _siftView.selectTradeItemBlock = ^(NSString *tradeId,NSString *type) {
////            weakSelf.f_texe = tradeId;
////            weakSelf.f_key = type;
////            [weakSelf reloadRequest];
//        };
//
//        _siftView.selectCateItemBlock = ^(NSString *cateId,NSString *type) {
////            weakSelf.f_cateIds = cateId;
////            weakSelf.f_key = type;
////
////            [weakSelf reloadRequest];
//        };
//
//        _siftView.selectBrandItemBlock = ^(NSString *brandId,NSString *type) {
////            weakSelf.f_brandIds = brandId;
////            weakSelf.f_key = type;
////
////            [weakSelf reloadRequest];
//        };
//
//        _siftView.selectCatemItemBlock = ^(NSString *catemId,NSString *type) {
////            weakSelf.f_catemIds = catemId;
////            weakSelf.f_key = type;
////
////            [weakSelf reloadRequest];
//        };
//        _siftView.selectAttrItemBlock = ^(NSString *attr,NSString *type,BOOL isSelected) {
////            weakSelf.f_key = type;
////
////            if (isSelected) {
////                [weakSelf.attrArray addObject:attr];
////            }
////            else{
////                [weakSelf.attrArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
////                    if ([obj isEqualToString:attr]) {
////                        [weakSelf.attrArray removeObject:attr];
////                    }
////
////                }];
////            }
////            [weakSelf reloadRequest];
//        };
//        _siftView.resetBlock = ^{
//
////            [weakSelf resetbasicDataAnalysis];
////            [weakSelf basicDataAnalysis];
////            [weakSelf reloadRequest];
//        };
//        _siftView.searchBlock = ^{
//
//        };
//    }
//    return _siftView;
//}

@end
