//
//  Fcgo_MineHeadViewNew.m
//  Fcgo
//
//  Created by by_r on 2017/10/18.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_MineHeadViewNew.h"

@interface Fcgo_MineHeadViewNew()
@property (nonatomic, strong) UILabel       *nameLabel;
@property (nonatomic, strong) UILabel       *phoneLabel;
@property (nonatomic, strong) UILabel       *addressLabel;
@property (nonatomic, strong) UIImageView   *nameIcon;
@property (nonatomic, strong) UIImageView   *phoneIcon;
@property (nonatomic, strong) UIImageView   *addressIcon;

@property (nonatomic, strong) UIImageView   *orderBottomImageView;
@end

@implementation Fcgo_MineHeadViewNew
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = UIFontClearColor;
        
        [self setupUI];
    }
    return self;
}

- (void)btnAction:(UIButton *)sender {
    if (self.touchType) {
        self.touchType(sender.tag);
    }
}

- (void)setUserDict:(NSDictionary *)userDict {
    _userDict = userDict;
    //NSLog(@">>>>>>%@",userDict);
    _nameLabel.text = userDict[@"storeName"];//[Fcgo_UserTools shared].userDict[@"storeName"];//userDict[@"storeName"];
    NSString *phone = userDict[@"storeMobile"];//[Fcgo_UserTools shared].userDict[@"storeMobile"];//userDict[@"storeMobile"];
    _phoneLabel.text = [NSString stringWithFormat:@"%@****%@",[phone substringWithRange:NSMakeRange(0, 3)],[phone substringWithRange:NSMakeRange(phone.length-4, 4)]];
    _addressLabel.text =  userDict[@"storeAddressDetail"];// [NSString stringWithFormat:@"%@%@%@%@",userDict[@"provinceName"],userDict[@"cityName"],userDict[@"areaName"],userDict[@"address"]];
    
    NSString *string = [Fcgo_UserTools shared].userHeaderImageUrl;//userDict[@"picUrl"];//
    [self.headImageBtn sd_setBackgroundImageWithURL:[NSURL URLWithString:string] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"icon_head-portrait"]];
}

#pragma mark - UI
- (void)setupUI {
    // 头像
    UIButton *headImageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    headImageBtn.layer.cornerRadius = kAutoWidth6(35);
    headImageBtn.layer.borderColor = UIFontWhiteColor.CGColor;
    headImageBtn.layer.borderWidth = 1;
    headImageBtn.layer.masksToBounds = YES;
    headImageBtn.tag = kHeadTouchType_headImage;
    [headImageBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:headImageBtn];
    _headImageBtn = headImageBtn;
    [self.headImageBtn sd_setBackgroundImageWithURL:[NSURL URLWithString:@""] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"icon_head-portrait"]];
    // 昵称
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.font = UIBoldFontSize(18);
    nameLabel.textColor = UIFontWhiteColor;
    [self addSubview:nameLabel];
    _nameLabel = nameLabel;
    // 皇冠
    UIImageView *nameIcon = [UIImageView new];
    nameIcon.image = [UIImage imageNamed:@"icon_member"];
    [self addSubview:nameIcon];
    _nameIcon = nameIcon;
    // 手机
    UIImageView *phoneIcon = [UIImageView new];
    phoneIcon.image = [UIImage imageNamed:@"icon_phone"];
    [self addSubview:phoneIcon];
    _phoneIcon = phoneIcon;
    
    UILabel *phoneLabel = [UILabel new];
    phoneLabel.font = UIFontSize(15);
    phoneLabel.textColor = UIFontWhiteColor;
    [self addSubview:phoneLabel];
    _phoneLabel = phoneLabel;
    // 地址
    UIImageView *addressIcon = [UIImageView new];
    addressIcon.image = [UIImage imageNamed:@"icon_shop"];
    [self addSubview:addressIcon];
    _addressIcon = addressIcon;
    
    UILabel *addressLabel = [UILabel new];
    addressLabel.font = UIFontSize(15);
    addressLabel.textColor = UIFontWhiteColor;
    [self addSubview:addressLabel];
    _addressLabel = addressLabel;
    
    UIImageView *shadowImageView = [UIImageView new];
    UIImage *image = [UIImage imageNamed:@"shadow"];
    shadowImageView.image = image;
    shadowImageView.contentMode = UIViewContentModeScaleAspectFit;
//    shadowImageView.backgroundColor = [UIColor yellowColor];
    [self addSubview:shadowImageView];
    
    // 按钮底部背景
    UIImageView *orderBottomImageView = [UIImageView new];
//    orderBottomImageView.image = [UIImage imageNamed:@"order_bg"];
    orderBottomImageView.userInteractionEnabled = YES;
    orderBottomImageView.layer.cornerRadius = 6;
    orderBottomImageView.layer.masksToBounds = YES;
    orderBottomImageView.backgroundColor = UIFontWhiteColor;
    [self addSubview:orderBottomImageView];
    _orderBottomImageView = orderBottomImageView;
    
    Fcgo_MineImageTextButton *waitPayButton = [self getButtonWithTitle:@"待付款" imageNamed:@"icon_order_non-payment"];
    waitPayButton.tag = kHeadTouchType_waitPay;
    [orderBottomImageView addSubview:waitPayButton];
    _waitPayButton = waitPayButton;
    
    Fcgo_MineImageTextButton *dealButton = [self getButtonWithTitle:@"处理中" imageNamed:@"icon_order_processing"];
    dealButton.tag = kHeadTouchType_deal;
    [orderBottomImageView addSubview:dealButton];
    _dealButton = dealButton;
    
    Fcgo_MineImageTextButton *recivedButton = [self getButtonWithTitle:@"待收货" imageNamed:@"icon_order_delivery"];
    recivedButton.tag = kHeadTouchType_recive;
    [orderBottomImageView addSubview:recivedButton];
    _recivedButton = recivedButton;
    
    Fcgo_MineImageTextButton *afterSaleButton = [self getButtonWithTitle:@"售后服务" imageNamed:@"icon_order_after_sales service"];
    afterSaleButton.tag = kHeadTouchType_afterSale;
    [orderBottomImageView addSubview:afterSaleButton];
    _afterSaleButton = afterSaleButton;
    
    Fcgo_MineImageTextButton *myOrderButton = [self getButtonWithTitle:@"我的订单" imageNamed:@"icon_order_orders"];
    myOrderButton.tag = kHeadTouchType_myOrder;
    [orderBottomImageView addSubview:myOrderButton];
    _myOrderButton = myOrderButton;
    
    UIImageView *lineImageView = [UIImageView new];
    lineImageView.image = [UIImage imageNamed:@"line_arrow"];
    lineImageView.contentMode = UIViewContentModeScaleAspectFit;
    lineImageView.layer.masksToBounds = YES;
    [orderBottomImageView addSubview:lineImageView];

    // layout UI
    {
        MASAttachKeys(orderBottomImageView, waitPayButton, dealButton, recivedButton, afterSaleButton, myOrderButton, lineImageView);
        [headImageBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_offset(12);
            make.left.mas_equalTo(12);
            make.width.height.mas_offset(kAutoWidth6(70));
        }];
        
        [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(headImageBtn.mas_right).offset(6);
            make.top.mas_equalTo(headImageBtn);
            make.width.mas_lessThanOrEqualTo(kAutoWidth6(180));
        }];
        [nameIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(nameLabel);
            make.left.mas_equalTo(nameLabel.mas_right).offset(5);
            make.size.mas_equalTo(nameIcon.image.size);
        }];
        
        [phoneIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(nameLabel);
            make.centerY.mas_equalTo(headImageBtn.mas_centerY).with.mas_offset(2);
            make.size.mas_equalTo(phoneIcon.image.size);
        }];
        [phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(phoneIcon.mas_right).offset(5);
            make.centerY.equalTo(phoneIcon);
        }];
        
        [addressIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(phoneIcon);
            make.bottom.mas_equalTo(headImageBtn);
            make.size.mas_equalTo(addressIcon.image.size);
        }];
        [addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(addressIcon.mas_right).offset(5);
            make.centerY.mas_equalTo(addressIcon);
            make.right.mas_equalTo(-10).priorityLow();
        }];
        [shadowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(kAutoWidth6(15));
            make.bottom.mas_equalTo(kAutoWidth6(10)).priorityLow();
            make.left.mas_equalTo(-kAutoWidth6(15));
            make.top.mas_equalTo(headImageBtn.mas_bottom).offset(0);
        }];
        [orderBottomImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(-12);
            make.left.mas_equalTo(12);
            make.right.mas_equalTo(-12);
            make.top.mas_equalTo(headImageBtn.mas_bottom).offset(kAutoWidth6(16));
        }];
        
        NSArray *masonryArray = @[waitPayButton, dealButton, recivedButton, afterSaleButton, myOrderButton];
        [masonryArray mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:0 leadSpacing:0 tailSpacing:0];
        [masonryArray mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(kAutoWidth6(6));
            make.bottom.mas_equalTo(-kAutoWidth6(6));
        }];

        [lineImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(afterSaleButton.mas_right).offset(-4);
            make.centerY.mas_equalTo(orderBottomImageView);
            make.height.mas_lessThanOrEqualTo(53);
        }];
    }
}

- (Fcgo_MineImageTextButton *)getButtonWithTitle:(NSString *)title imageNamed:(NSString *)imageNamed {
    Fcgo_MineImageTextButton *btn = [Fcgo_MineImageTextButton buttonWithType:UIButtonTypeCustom];
//    btn.backgroundColor = [UIColor blueColor];
    btn.btnLabel.text = title;
    btn.btnLabel.textColor = UIFontBlack282828;
    btn.btnImageView.image = [UIImage imageNamed:imageNamed];
    btn.iconCountLabel.backgroundColor = UIFontWhiteColor;
    btn.iconCountLabel.textColor = UIFontRedColor;
    btn.iconCountLabel.layer.borderColor = UIFontRedColor.CGColor;
    btn.iconCountLabel.layer.borderWidth = 1;
    [btn setupUI];
    [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    return btn;
}

@end
