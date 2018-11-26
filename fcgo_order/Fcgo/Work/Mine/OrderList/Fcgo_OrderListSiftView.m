//
//  Fcgo_OrderListSiftView.m
//  Fcgo
//
//  Created by by_r on 2017/10/24.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_OrderListSiftView.h"
//#import "Fcgo_SearchNavView.h"
#import "Fcgo_SiftMainView.h"

@interface Fcgo_OrderListSiftView()
@property (nonatomic, assign) OrderListShowType type;
//@property (nonatomic, strong) Fcgo_SearchNavView *searchView;
@property (nonatomic, strong) Fcgo_SiftMainView *siftView;
@property (nonatomic,strong) UIControl         *touchControl;
@end

@implementation Fcgo_OrderListSiftView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _type = OrderStatusType_none;
        
        [self addSubview:self.touchControl];
//        [self addSubview:self.searchView];
        [self addSubview:self.siftView];
        self.hidden = YES;
        
        [self events];
    }
    return self;
}

- (void)show:(OrderListShowType)type {
    if (type == _type) return;
    _type = type;
    self.hidden = NO;
    if (type == OrderStatusType_search) {
//        self.searchView.hidden = NO;
        self.siftView.hidden = YES;
//        self.searchView.searchTextField.text = nil;
    } else if (type == OrderStatusType_sift) {
//        self.searchView.hidden = YES;
        self.siftView.hidden = NO;
//        [self.searchView.searchTextField resignFirstResponder];
    }
}

- (void)setSiftArray:(NSMutableArray *)siftArray {
    _siftArray = siftArray;
    self.siftView.siftArray = siftArray;
}

- (void)confirm {
    self.hidden = YES;
//    [self.searchView.searchTextField resignFirstResponder];
    _type = OrderStatusType_none;
}

- (void)events {
    WEAKSELF(weakSelf);
    
    self.siftView.selectAttrItemBlock = ^(NSString *attr, NSString *type, BOOL isSelected) {
        !weakSelf.selectAttrItemBlock?:weakSelf.selectAttrItemBlock(attr, type, isSelected);
    };
    self.siftView.selectCateItemBlock = ^(NSString *cateId, NSString *type) {
        !weakSelf.selectCateItemBlock?:weakSelf.selectCateItemBlock(cateId, type);
    };
    self.siftView.selectBrandItemBlock = ^(NSString *brandId, NSString *type) {
        !weakSelf.selectBrandItemBlock?:weakSelf.selectBrandItemBlock(brandId, type);
    };
    self.siftView.selectTradeItemBlock = ^(NSString *tradeId, NSString *type) {
        !weakSelf.selectTradeItemBlock?:weakSelf.selectTradeItemBlock(tradeId, type);
    };
    self.siftView.selectCatemItemBlock = ^(NSString *catemId, NSString *type) {
        !weakSelf.selectCatemItemBlock?:weakSelf.selectCatemItemBlock(catemId, type);
    };
    self.siftView.resetBlock = ^{
        !weakSelf.resetBlock?:weakSelf.resetBlock();
    };
}

#pragma mark -
//- (Fcgo_SearchNavView *)searchView {
//    if (!_searchView) {
//        WEAKSELF(weakSelf);
//        _searchView = [[Fcgo_SearchNavView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 44) cancel:^{
//            [weakSelf confirm];
//        } start:^(BOOL containText, NSString *string) {
//
//        } search:^(NSString *string) {
//
//        }];
//        _searchView.searchTextField.placeholder = @"请输入订单号、商品名称、商品编号";
//        _searchView.backgroundColor = UIFontWhiteColor;
//    }
//    return _searchView;
//}

- (Fcgo_SiftMainView *)siftView {
    if (!_siftView) {
        _siftView = [[Fcgo_SiftMainView alloc]initWithFrame:CGRectMake(kAutoWidth6(80), 0, kScreenWidth - kAutoWidth6(80), KScreenHeight)];
    }
    return _siftView;
}

- (UIControl *)touchControl {
    if (!_touchControl) {
        UIControl *control = [[UIControl alloc]initWithFrame:self.bounds];
        control.backgroundColor = UIRGBColor(0, 0, 0, 0.5);
        [control addTarget:self action:@selector(confirm) forControlEvents:UIControlEventTouchUpInside];
        _touchControl = control;
    }
    return _touchControl;
}

@end
