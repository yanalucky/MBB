//
//  Fcgo_HomeNavView.m
//  Fcgo
//
//  Created by huafanxiao on 2017/5/11.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_HomeNavView.h"
#import "Fcgo_HomeNavSearchControl.h"
//#import "Fcgo_ContainImageViewLabelButton.h"
@interface Fcgo_HomeNavView()

//@property (nonatomic,strong) Fcgo_ContainImageViewLabelButton *scanBtn;
//@property (nonatomic,strong) Fcgo_ContainImageViewLabelButton *msgBtn;


@property (nonatomic,strong) UIButton *scanBtn;
@property (nonatomic,strong) UIButton *msgBtn;
@property (nonatomic,strong) Fcgo_HomeNavSearchControl *navSearchControl;

@end

@implementation Fcgo_HomeNavView

- (instancetype)initWithFrame:(CGRect)frame
                       ofScan:(void(^)(void))scanBlock
                     ofSearch:(void(^)(void))searchBlock
                        ofMsg:(void(^)(void))msgBlock
{
    self = [super initWithFrame:frame];
    if (self) {
        self.scanBlock = scanBlock;
        self.searchBlock = searchBlock;
        self.msgBlock = msgBlock;
        [self setupUI];
    }
    return self;
    
}

- (void)setupUI
{
    WEAKSELF(weakSelf)
    [self addSubview:self.scanBtn];
    [self.scanBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.top.mas_offset(kNavigationSubY(27));
        make.width.mas_offset(28);
        make.height.mas_offset(32);
        
    }];
    
    //self.scanBtn..imageEdgeInsets = UIEdgeInsetsMake(5, 5, -5, -5);
    
   [self addSubview:self.msgBtn];
    [self.msgBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-10);
        make.top.mas_offset(kNavigationSubY(27));
        make.width.mas_offset(28);
        make.height.mas_offset(32);
        
    }];
    
    [self addSubview:self.navSearchControl];
    
    self.navSearchControl.searchBlock = ^{
        if (weakSelf.searchBlock) {
            weakSelf.searchBlock();
        }
    };
    [self.navSearchControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(kNavigationSubY(27));
        make.left.mas_equalTo(weakSelf.scanBtn.mas_right).mas_offset(5);
        make.height.mas_offset(30);
        make.right.mas_equalTo(weakSelf.msgBtn.mas_left).mas_offset(-5);
        //make.right.mas_offset(-15);
    }];
    [self.navSearchControl setupUI];
}

- (void)setBgAlpha:(float)bgAlpha
{
   _bgAlpha= bgAlpha;
    if (bgAlpha>0.7) {
        [_msgBtn setImage:[[UIImage imageNamed:@"icon_black_msg_home"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
        [_scanBtn setImage:[[UIImage imageNamed:@"b_scan"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    }else{
        [_msgBtn setImage:[[UIImage imageNamed:@"icon_white_msg_home"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
        [_scanBtn setImage:[[UIImage imageNamed:@"w_scan"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    }
}

#pragma mark Lazy method


- (UIButton *)scanBtn
{
    if (!_scanBtn) {
        _scanBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [_scanBtn setImage:[[UIImage imageNamed:@"w_scan"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
        [_scanBtn addTarget:self action:@selector(scan) forControlEvents:UIControlEventTouchUpInside];
    }
    return _scanBtn;
}

- (void)scan
{
    if (self.scanBlock) {
        self.scanBlock();
    }
}

- (UIButton *)msgBtn
{
    if (!_msgBtn) {
        _msgBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [_msgBtn setImage:[[UIImage imageNamed:@"icon_white_msg_home"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
        [_msgBtn addTarget:self action:@selector(msg) forControlEvents:UIControlEventTouchUpInside];
    }
    return _msgBtn;
}

- (void)msg
{
    if (self.msgBlock) {
        self.msgBlock();
    }
}

- (Fcgo_HomeNavSearchControl *)navSearchControl
{
    if (!_navSearchControl) {
        _navSearchControl = [[Fcgo_HomeNavSearchControl alloc]initWithFrame:CGRectZero];
    }
    return _navSearchControl;
}

@end
