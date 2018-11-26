//
//  Fcgo_MineDynamicHeadView.m
//  Fcgo
//
//  Created by huafanxiao on 2017/5/16.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_MineDynamicHeadView.h"

@interface Fcgo_MineDynamicHeadView()

@property (nonatomic,strong) UILabel     *userNameLabel;
@property (nonatomic,strong) UILabel     *userTelLabel;

@end

@implementation Fcgo_MineDynamicHeadView

- (instancetype)initWithFrame:(CGRect)frame
                  ofHeadImage:(void(^)(UIButton *headImageBtn))headImageBlock
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIFontClearColor;
        self.headImageBlock = headImageBlock;
        [self setupUI];
    }
    return self;
}

- (void)setupUI
{
    WEAKSELF(weakSelf)
    [self addSubview:self.headImageBtn];
    [self addSubview:self.userNameLabel];
    [self addSubview:self.userTelLabel];


     [self.headImageBtn addTarget:self action:@selector(headImage) forControlEvents:UIControlEventTouchUpInside];
    [self.headImageBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(kAutoWidth6(15));
        make.left.mas_offset(weakSelf.mj_w/2 - kAutoWidth6(30));
        make.width.mas_offset(kAutoWidth6(60));
        make.height.mas_offset(kAutoWidth6(60));
        
    }];
    
    self.headImageBtn.layer.cornerRadius  = kAutoWidth6(30);
    self.headImageBtn.layer.borderColor   = UIFontWhiteColor.CGColor;
    self.headImageBtn.layer.borderWidth   = 1;
    self.headImageBtn.layer.masksToBounds = YES;
    
    
    [self.userNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.headImageBtn.mas_bottom).mas_offset(kAutoWidth6(10));
        make.left.mas_offset(70);
        make.right.mas_offset(-70);
    }];
    
    [self.userTelLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.userNameLabel.mas_bottom).mas_offset(5);
        make.left.mas_offset(70);
        make.right.mas_offset(-70);
    }];
}

- (void)headImage
{
    if (self.headImageBlock)
        self.headImageBlock(self.headImageBtn);
}

- (void)setUserDict:(NSDictionary *)userDict
{
    _userDict = userDict;
    
    self.userNameLabel.text = userDict[@"merchantFullname"];
    
    NSString *string = userDict[@"userMobile"];
    self.userTelLabel.text = [NSString stringWithFormat:@"%@****%@",[string substringWithRange:NSMakeRange(0, 3)],[string substringWithRange:NSMakeRange(string.length-4, 4)]];
}

#pragma mark Lazy method

- (UIButton *)headImageBtn
{
    if (!_headImageBtn) {
        _headImageBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        //[_headImageBtn sd_setBackgroundImageWithURL:[NSURL URLWithString:@"http://www.popoho.com/uploads/allimg/130111/1409132426-1.jpg"] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"headImage_mine"]];
    }
    return _headImageBtn;
}

- (UILabel *)userNameLabel
{
    if (!_userNameLabel) {
        _userNameLabel = [[UILabel alloc]init];
        _userNameLabel.font = [UIFont systemFontOfSize:15];
        _userNameLabel.textColor = UIFontWhiteColor;
        _userNameLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _userNameLabel;
}

- (UILabel *)userTelLabel
{
    if (!_userTelLabel) {
        _userTelLabel = [[UILabel alloc]init];
        _userTelLabel.font = [UIFont systemFontOfSize:14];
        _userTelLabel.textColor = UIFontWhiteColor;
        _userTelLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _userTelLabel;
}
@end
