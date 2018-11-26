//
//  Fcgo_MineNavView.m
//  Fcgo
//
//  Created by huafanxiao on 2017/5/16.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_MineNavView.h"

@interface Fcgo_MineNavView()

@property (nonatomic,strong) UILabel  *mineLabel;
@property (nonatomic,strong) UIButton *setBtn;
@property (nonatomic,strong) UIButton *msgBtn;
@property (nonatomic,strong) UIImageView *bgImageView;

@end

@implementation Fcgo_MineNavView
- (instancetype)initWithFrame:(CGRect)frame
                  ofHeadImage:(void(^)(UIButton *headImageBtn))headImageBlock
                        ofSet:(void(^)(void))setBlock
                        ofMsg:(void(^)(void))msgBlock
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIFontClearColor;
        self.headImageBlock = headImageBlock;
        self.setBlock = setBlock;
        self.msgBlock = msgBlock;
        [self setupUI];
    }
    return self;
}


- (void)setupUI
{
    WEAKSELF(weakSelf)
    
    [self addSubview:self.bgImageView];
    [self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.mas_offset(0);
    }];
    self.headImageBtn.alpha = 0;
    self.mineLabel.alpha    = 0;
    [self addSubview:self.headImageBtn];
    [self addSubview:self.mineLabel];
    [self addSubview:self.setBtn];
    [self addSubview:self.msgBtn];
    [self.headImageBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.top.mas_offset(kNavigationSubY(27));
        make.width.mas_offset(30);
        make.height.mas_offset(30);
        
    }];
    self.headImageBtn.layer.cornerRadius  = 15;
    self.headImageBtn.layer.borderColor   = UIFontWhiteColor.CGColor;
    self.headImageBtn.layer.borderWidth   = 1;
    self.headImageBtn.layer.masksToBounds = YES;
    
    
    [self.mineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(kNavigationSubY(20));
        make.centerX.mas_equalTo(self);
        make.width.mas_offset(kAutoWidth6(250));
        make.height.mas_offset(44);
    }];
    
    [self.msgBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-10);
        make.top.mas_offset(kNavigationSubY(27));
        make.width.mas_offset(30);
        make.height.mas_offset(30);
        
    }];
    [self.setBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(weakSelf.msgBtn.mas_left).mas_offset(-10);
        make.top.mas_offset(kNavigationSubY(27));
        make.width.mas_offset(30);
        make.height.mas_offset(30);
    }];
    
    [self.headImageBtn addTarget:self action:@selector(headImage) forControlEvents:UIControlEventTouchUpInside];
    [self.setBtn addTarget:self action:@selector(set) forControlEvents:UIControlEventTouchUpInside];
    [self.msgBtn addTarget:self action:@selector(msg) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setBgAlpha:(float)bgAlpha
{
    self.bgImageView.alpha  = bgAlpha;
    self.headImageBtn.alpha = bgAlpha;
    self.mineLabel.alpha    = bgAlpha;
}

#pragma mark Lazy method

- (UILabel *)mineLabel
{
    if (!_mineLabel) {
        _mineLabel = [[UILabel alloc]init];
        _mineLabel.font = [UIFont boldSystemFontOfSize:17];
        _mineLabel.textColor = UIFontWhiteColor;
        _mineLabel.textAlignment = NSTextAlignmentCenter;
        _mineLabel.text = @"我的";
    }
    return _mineLabel;
}

- (UIButton *)headImageBtn
{
    if (!_headImageBtn) {
        _headImageBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [_headImageBtn sd_setBackgroundImageWithURL:[NSURL URLWithString:@"http://www.popoho.com/uploads/allimg/130111/1409132426-1.jpg"] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"icon_head-portrait"]];
    }
    return _headImageBtn;
}

- (UIButton *)setBtn
{
    if (!_setBtn) {
        _setBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [_setBtn setBackgroundImage:[UIImage imageNamed:@"ico_white_setting" ] forState:UIControlStateNormal];
    }
    return _setBtn;
}

- (UIButton *)msgBtn
{
    if (!_msgBtn) {
        _msgBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [_msgBtn setBackgroundImage:[UIImage imageNamed:@"icon_white_msg_home"] forState:UIControlStateNormal];
    }
    return _msgBtn;
}

- (UIImageView *)bgImageView
{
    if (!_bgImageView) {
        _bgImageView = [[UIImageView alloc]init];
        //_bgImageView.image = [UIImage imageWithName:@"red_bgHead" ofType:@"png"];
       // _bgImageView.contentMode = UIViewContentModeScaleAspectFill;
        _bgImageView.backgroundColor = UIRGBColor(253,156,179 ,1);
        _bgImageView.alpha = 0;
    }
    return _bgImageView;
}

- (void)headImage
{
    if (self.headImageBlock)
        self.headImageBlock(self.headImageBtn);
    
}

- (void)set
{
    if (self.setBlock)
        self.setBlock();
   
}

- (void)msg
{
    if (self.msgBlock)
        self.msgBlock();
}

@end
