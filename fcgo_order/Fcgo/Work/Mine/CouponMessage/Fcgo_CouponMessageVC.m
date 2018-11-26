//
//  Fcgo_CouponMessageVC.m
//  Fcgo
//
//  Created by huafanxiao on 2017/5/23.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_CouponMessageVC.h"
#import "UIParameter.h"
#import "NinaPagerView.h"

#import "Fcgo_CouponCanGetVC.h"
#import "Fcgo_CouponUnusedVC.h"
#import "Fcgo_CouponUsedVC.h"
#import "Fcgo_CouponPassedUsedVC.h"

@interface Fcgo_CouponMessageVC ()<NinaPagerViewDelegate>

@property (nonatomic,strong) NSArray            *ninaVCsArray;
@property (nonatomic,strong) NinaPagerView      *ninaPagerView;

@end

@implementation Fcgo_CouponMessageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    WEAKSELF(weakSelf)
    [self.navigationView setupBackBtnBlock:^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    }];
    [self.navigationView setupTitleLabelWithTitle:@"优惠券"];
    [self.view  insertSubview:self.ninaPagerView belowSubview:self.navigationView];
    self.ninaPagerView.ninaChosenPage = self.index;
}

- (void)ninaCurrentPageIndex:(NSString *)currentPage currentObject:(id)currentObject
{
    Fcgo_Coupon_UIBaisc_VC *vc = (Fcgo_Coupon_UIBaisc_VC *)currentObject;
    [vc requestCouponListWithType:currentPage.intValue];
}

#pragma mark - LazyLoad

- (NSArray *)ninaTitleArray {
    return @[
             @"可领取",
             @"未使用",
             @"已使用",
             @"已过期",
             ];
}

- (NSArray *)ninaVCsArray {
    if (!_ninaVCsArray) {
        _ninaVCsArray = @[
                          [[Fcgo_CouponCanGetVC      alloc]init],
                          [[Fcgo_CouponUsedVC       alloc]init],
                          [[Fcgo_CouponUnusedVC     alloc]init],
                          [[Fcgo_CouponPassedUsedVC alloc]init],
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
        _ninaPagerView.delegate = self;
        _ninaPagerView.underlineColor     = UIFontRedColor;
        _ninaPagerView.selectTitleColor   = UIFontRedColor;
        _ninaPagerView.unSelectTitleColor = UIFontMainGrayColor;
        _ninaPagerView.selectBottomLinePer = 0.5;
    }
    return _ninaPagerView;
}
@end
