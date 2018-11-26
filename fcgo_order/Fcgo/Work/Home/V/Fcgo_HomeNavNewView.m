//
//  Fcgo_HomeNavNewView.m
//  Fcgo
//
//  Created by fcg on 2017/11/2.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_HomeNavNewView.h"

#import "Fcgo_HomeNavSearchControl.h"
#import "Fcgo_ContainImageViewLabelButton.h"
@interface Fcgo_HomeNavNewView()

@property (nonatomic,strong) Fcgo_ContainImageViewLabelButton *scanBtn;
@property (nonatomic,strong) UIButton                         *choosAddress;
@property (nonatomic,strong) Fcgo_HomeNavSearchControl        *navSearchControl;

@end

@implementation Fcgo_HomeNavNewView

- (instancetype)initWithFrame:(CGRect)frame
                       ofScan:(void(^)(void))scanBlock
                     ofSearch:(void(^)(void))searchBlock
                  ofChooseAdd:(void(^)(NSString *address))ChooseAddressBlock
{
    self = [super initWithFrame:frame];
    if (self) {
        self.scanBlock = scanBlock;
        self.searchBlock = searchBlock;
        self.chooseAddressBlock = ChooseAddressBlock;
//        [self setupUI];
    }
    return self;
    
}

//- (void)setupUI
//{
//    WEAKSELF(weakSelf)
//    [self addSubview:self.scanBtn];
//    [self.scanBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_offset(10);
//        make.top.mas_offset(kNavigationSubY(27));
//        make.width.mas_offset(28);
//        make.height.mas_offset(32);
//
//    }];
//    [self.scanBtn setupUI];
//
//    [self addSubview:self.choosAddress];
//
//    [self.msgBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.mas_offset(-10);
//        make.top.mas_offset(kNavigationSubY(27));
//        make.width.mas_offset(28);
//        make.height.mas_offset(32);
//
//    }];
//    [self.msgBtn setupUI];
//
//    [self.msgBtn.btnImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_offset(4);
//        make.right.mas_offset(-4);
//        make.top.mas_offset(0);
//        make.height.mas_equalTo(weakSelf.msgBtn.btnImageView.mas_width);
//    }];
//
//    [self addSubview:self.navSearchControl];
//
//    self.navSearchControl.searchBlock = ^{
//        if (weakSelf.searchBlock) {
//            weakSelf.searchBlock();
//        }
//    };
//    [self.navSearchControl mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_offset(kNavigationSubY(27));
//        make.left.mas_equalTo(weakSelf.scanBtn.mas_right).mas_offset(5);
//        make.height.mas_offset(30);
//        make.right.mas_equalTo(weakSelf.msgBtn.mas_left).mas_offset(-5);
//        //make.right.mas_offset(-15);
//    }];
//    [self.navSearchControl setupUI];
//}
//
//- (void)setBgAlpha:(float)bgAlpha
//{
//
//    _bgAlpha= bgAlpha;
//    if (bgAlpha>0.7) {
//        self.scanBtn.btnImageView.image = [UIImage imageNamed:@"b_scan"];
//        self.msgBtn.btnImageView.image  = [UIImage imageNamed:@"icon_black_msg_mine"];
//        self.scanBtn.btnLabel.textColor = UIFontBlackColor;
//        self.msgBtn.btnLabel.textColor  = UIFontBlackColor;
//
//    }else{
//        self.scanBtn.btnImageView.image = [UIImage imageNamed:@"w_scan"];
//        self.msgBtn.btnImageView.image  = [UIImage imageNamed:@"icon_white_msg_home"];
//        self.scanBtn.btnLabel.textColor = UIFontWhiteColor;
//        self.msgBtn.btnLabel.textColor  = UIFontWhiteColor;
//    }
//    //    self.navSearchControl.bgAlpha = bgAlpha;
//}
//
//#pragma mark Lazy method
//
//- (Fcgo_ContainImageViewLabelButton *)scanBtn
//{
//    if (!_scanBtn) {
//        _scanBtn = [Fcgo_ContainImageViewLabelButton buttonWithType:UIButtonTypeSystem];
//        _scanBtn.btnImageView.image = [UIImage imageNamed:@"w_scan"];
//        _scanBtn.btnLabel.textColor = UIFontWhiteColor;
//        _scanBtn.btnLabel.text = @"扫一扫";
//        [_scanBtn addTarget:self action:@selector(scan) forControlEvents:UIControlEventTouchUpInside];
//    }
//    return _scanBtn;
//}
//
//- (void)scan
//{
//    if (self.scanBlock) {
//        self.scanBlock();
//    }
//}
//
//- (Fcgo_ContainImageViewLabelButton *)msgBtn
//{
//    if (!_msgBtn) {
//        _msgBtn = [Fcgo_ContainImageViewLabelButton buttonWithType:UIButtonTypeSystem];
//        _msgBtn.btnImageView.image = [UIImage imageNamed:@"icon_white_msg_home"];
//
//        _msgBtn.btnLabel.textColor = UIFontWhiteColor;
//        _msgBtn.btnLabel.text = @"消息";
//        [_msgBtn addTarget:self action:@selector(msg) forControlEvents:UIControlEventTouchUpInside];
//    }
//    return _msgBtn;
//}
//
//- (void)msg
//{
//    if (self.msgBlock) {
//        self.msgBlock();
//    }
//}
//
//- (Fcgo_HomeNavSearchControl *)navSearchControl
//{
//    if (!_navSearchControl) {
//        _navSearchControl = [[Fcgo_HomeNavSearchControl alloc]initWithFrame:CGRectZero];
//    }
//    return _navSearchControl;
//}




@end
