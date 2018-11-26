//
//  Fcgo_OrderListVC.m
//  Fcgo
//
//  Created by huafanxiao on 2017/5/22.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_OrderListVC.h"
#import "HXAlbumTitleButton.h"
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

#import "Fcgo_OrderListModel.h"

@interface Fcgo_OrderListVC ()<NinaPagerViewDelegate>

@property (nonatomic,strong) NSArray            *ninaVCsArray;
@property (nonatomic,strong) NinaPagerView      *ninaPagerView;
@property (nonatomic,strong) HXAlbumTitleButton *titleBtn;
@property (nonatomic,assign) NSInteger    currentIndexForOrderType;//记录选中的是那种订单类型
@end

@implementation Fcgo_OrderListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}
#pragma mark - private method
- (void)pushOrderTypeList:(UIButton *)button {
    NSArray *titleArray = @[@"全部订单",@"一般贸易",@"跨境保税",@"海外直邮"];
    WEAKSELF(weakSelf);
    button.selected = !button.selected;
    if (button.selected) {
        [Fcgo_TopAnimationView showWithVC:self  titleArray:titleArray currentSelected:self.currentIndexForOrderType DidSelectedBlock:^(NSInteger index) {
            button.selected = !button.selected;
            [UIView animateWithDuration:0.25 animations:^{
                button.imageView.transform = CGAffineTransformMakeRotation(M_PI * 2);
            } completion:^(BOOL finished) {
                
            }];
            [self.titleBtn setTitle:titleArray[index] forState:UIControlStateNormal];
            weakSelf.currentIndexForOrderType = index;
            //重新传入选择的订单类型
            for (int i = 0; i < weakSelf.ninaVCsArray.count; i ++) {
                Fcgo_OrderList_UIBaisc_VC *vc = weakSelf.ninaVCsArray[i];
                vc.type      = weakSelf.currentIndexForOrderType;
            }
            
            Fcgo_OrderList_UIBaisc_VC *vc = weakSelf.ninaVCsArray[self.index-1];
            NSInteger currentPage_int = self.index-1;
             NSString *status;
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
            //选中的订单类型。执行的操作
        }];
        [UIView animateWithDuration:0.25 animations:^{
            button.imageView.transform = CGAffineTransformMakeRotation(M_PI);
        }];
    }else {
        //弹出框消失
        [[Fcgo_TopAnimationView sharedClient]dismissBlock:nil];
        [UIView animateWithDuration:0.25 animations:^{
            button.imageView.transform = CGAffineTransformMakeRotation(M_PI * 2);
        } completion:^(BOOL finished) {
            
        }];
    }
}
#pragma mark - delegate
#pragma mark NinaPagerViewDelegate
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
#pragma mark - UI
- (void)setupUI {
    WEAKSELF(weakSelf)
    
    //遮盖层消失。页面返回
    [self.navigationView setupBackBtnBlock:^{
        [[Fcgo_TopAnimationView sharedClient]dismissBlock:^{
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }];
    }];
    
    HXAlbumTitleButton *titleBtn = [HXAlbumTitleButton buttonWithType:UIButtonTypeCustom];
    [titleBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [titleBtn setImage:[UIImage imageNamed:@"down_icon_arrow"] forState:UIControlStateNormal];
    titleBtn.frame = CGRectMake(kScreenWidth/2-75, kNavigationSubY(27), 150, 30);
    [titleBtn setTitle:@"全部订单" forState:UIControlStateNormal];
    [titleBtn addTarget:self action:@selector(pushOrderTypeList:) forControlEvents:UIControlEventTouchUpInside];
    titleBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    [self.navigationView addSubview:self.titleBtn = titleBtn];
    
    [self.view  insertSubview:self.ninaPagerView belowSubview:self.navigationView];
    self.ninaPagerView.ninaChosenPage = self.index;
    
    for (int i = 0; i < self.ninaVCsArray.count; i ++) {
        Fcgo_OrderList_UIBaisc_VC *vc = self.ninaVCsArray[i];
        vc.type = self.currentIndexForOrderType;
    }
}
#pragma mark - LazyLoad
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

@end
