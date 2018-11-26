//
//  Fcgo_CartVC.m
//  Fcgo
//
//  Created by huafanxiao on 2017/5/10.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_CartVC.h"
#import "Fcgo_Cart_YB_VC.h"
#import "Fcgo_Cart_KJ_VC.h"
#import "Fcgo_Cart_HW_VC.h"


@interface Fcgo_CartVC ()

@property (nonatomic,strong)Fcgo_Cart_YB_VC *vc1;
@property (nonatomic,strong)Fcgo_Cart_KJ_VC *vc2;
@property (nonatomic,strong)Fcgo_Cart_HW_VC *vc3;

@end

@implementation Fcgo_CartVC

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [WSProgressHUD showWithStatus:@"数据加载..." maskType:WSProgressHUDMaskTypeClear];

    WEAKSELF(weakSelf);
    self.segmentHighlightColor = UIFontRedColor;
    self.segmentTitleColor     = UIFontMainGrayColor;
    self.scrollView.bounces    = 0;
    self.isNav = 0;
    self.vc1       = [[Fcgo_Cart_YB_VC alloc] init];
    self.vc1.haveNavBar = self.haveNavBar;
    self.vc1.isNotTabbar = self.isNotTabbar;
    self.vc1.title = @"一般贸易";
    self.vc1.refreshBlock = ^{
        //[weakSelf postRequestCartList];
        if (weakSelf.selectedAddressModel) {
            [weakSelf postRequestCartList];
        }
        else{
            if (weakSelf.refreshBlock) {
                weakSelf.refreshBlock();
            }
        }
        
        
        
    };
    
    self.vc2       = [[Fcgo_Cart_KJ_VC alloc] init];
    self.vc2.title = @"跨境保税";
    self.vc2.haveNavBar = self.haveNavBar;
    self.vc2.isNotTabbar = self.isNotTabbar;
    self.vc2.refreshBlock = ^{
        if (weakSelf.selectedAddressModel) {
            [weakSelf postRequestCartList];
        }
        else{
            if (weakSelf.refreshBlock) {
                weakSelf.refreshBlock();
            }
        }
    };
    
    self.vc3       = [[Fcgo_Cart_HW_VC alloc] init];
    self.vc3.title = @"海外直邮";
    self.vc3.haveNavBar = self.haveNavBar;
    self.vc3.isNotTabbar = self.isNotTabbar;
    self.vc3.refreshBlock = ^{
        if (weakSelf.selectedAddressModel) {
            [weakSelf postRequestCartList];
        }
        else{
            if (weakSelf.refreshBlock) {
                weakSelf.refreshBlock();
            }
        }
    };
    
    self.viewControllers = @[self.vc1, self.vc2, self.vc3];
    
    //[self postRequestCartList];
}

- (void)setSelectedAddressModel:(Fcgo_AddressModel *)selectedAddressModel
{
    _selectedAddressModel = selectedAddressModel;
    self.vc1.selectedAddressModel = selectedAddressModel;
    self.vc2.selectedAddressModel = selectedAddressModel;
    self.vc3.selectedAddressModel = selectedAddressModel;
}


- (void)postRequestCartList
{
    if (![Fcgo_Tools isNetworkConnected]) {
        [WSProgressHUD showImage:nil status:@"亲,没联网啊"];
        [self noNetwork:YES];
        return;
    }
    
    [WSProgressHUD showWithStatus:@"加载中" maskType:WSProgressHUDMaskTypeDefault];
    WEAKSELF(weakSelf);
    NSMutableDictionary  *muatble = [NSMutableDictionary dictionary];
    if (self.selectedAddressModel) {
        [muatble  setObjectWithNullValidate:self.selectedAddressModel.addressArea forKey:@"area"];
    }
    [Fcgo_NetworkManager postRequest:NSFormatHeardMeThodUrl(ServiceLocalTypeOne,SHOPCARMETHOD, @"shopCarList") parametersContentCommon:muatble successBlock:^(BOOL success, id responseObject, NSString *msg) {
        [WSProgressHUD dismiss];
        if (success) {
            [weakSelf noNetwork:NO];
            [weakSelf noNetwork:NO];
            static int a = 0;
            NSDictionary *bondedDict = responseObject[@"data"][@"bonded"];
            NSDictionary *directDict = responseObject[@"data"][@"direct"];
            NSDictionary *normalDict = responseObject[@"data"][@"normal"];
            
            NSArray *bondedNormalGoods = bondedDict[@"normal"];
            NSArray *bondedIntetalGoods = bondedDict[@"integral"];
            
            NSArray *directNormalGoods = directDict[@"normal"];
            NSArray *directIntetalGoods = directDict[@"integral"];
            
            NSArray *normalNormalGoods = normalDict[@"normal"];
            NSArray *normalIntetalGoods = normalDict[@"integral"];
            if ( a == 0) {
                if (normalNormalGoods.count <= 0 && normalIntetalGoods.count <= 0) {
                    if (bondedNormalGoods.count <= 0 && bondedIntetalGoods.count <= 0) {
                        if (directNormalGoods.count <= 0 && directIntetalGoods.count <= 0) {
                            weakSelf.segmentControl.currentSelectIndex = 0;
                        }else{
                            weakSelf.segmentControl.currentSelectIndex = 2;
                        }
                    }else{
                        weakSelf.segmentControl.currentSelectIndex = 1;
                    }
                }else{
                    weakSelf.segmentControl.currentSelectIndex = 0;
                }
                a = 1;
            }
            weakSelf.vc1.normalDict = normalDict;
            weakSelf.vc2.bondedDict = bondedDict;
            weakSelf.vc3.directDict = directDict;
        }
        else
        {
            [weakSelf noNetwork:YES];
        }
       
    } failureBlock:^(NSString *description) {
        [weakSelf noNetwork:YES];
    }];
}

- (void)noNetwork:(BOOL)isShow
{
    [self.vc1 noNetwork:isShow];
    [self.vc2 noNetwork:isShow];
    [self.vc3 noNetwork:isShow];
}

@end
