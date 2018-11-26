//
//  Fcgo_NavigationView.m
//  Fcgo
//
//  Created by huafanxiao on 2017/5/11.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_NavigationView.h"

@interface Fcgo_NavigationView()

@property (nonatomic,strong) UILabel       *navTitleLabel;
@property (nonatomic,strong) UIButton      *navBackTitleBtn;
@property (nonatomic,strong) UIButton      *navBackBtn,*navMoreBtn,*navRightBtn;
@property (nonatomic,strong) UIView        *line;

@end

@implementation Fcgo_NavigationView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self setupUI];
    }
    return self;
}

- (void)setupUI
{
    [self addSubview:self.alphaImageView];
    [self addSubview:self.line];
    
    [self.alphaImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_offset(0);
    }];
    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_offset(0);
        make.height.mas_offset(0.5);
        make.bottom.mas_offset(0);
    }];
}

- (void)setupTitleLabelWithTitle:(NSString *)title
{
    self.navTitleLabel.text = title;
    [self addSubview:self.navTitleLabel];
    [self.navTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(kNavigationSubY(20));
        make.centerX.mas_equalTo(self);
        make.width.mas_offset(kAutoWidth6(250));
        make.height.mas_offset(44);
    }];
}

- (void)setupTitleBoldFontLabelWithTitle:(NSString *)title
{
    self.navTitleLabel.font = [UIFont boldSystemFontOfSize:17];
    [self setupTitleLabelWithTitle:title];
}

- (void)setupBackBtnBlock:(BackBlock)backBlock
{
    self.backBlock = backBlock;
    [self addSubview:self.navBackBtn];
    [self.navBackBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.navBackBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(kNavigationSubY(25));
        make.left.mas_offset(0);
        make.height.mas_offset(34);
        make.width.mas_offset(34);
    }];
}

- (void)setupRightBtnBlock:(void(^)(void))rightBlock
{
    self.rightBlock = rightBlock;
    [self addSubview:self.navRightBtn];
    [self.navRightBtn addTarget:self action:@selector(rightClick) forControlEvents:UIControlEventTouchUpInside];
    [self.navRightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(kNavigationSubY(27));
        make.right.mas_offset(-10);
        make.height.mas_offset(30);
        make.width.mas_offset(30);
    }];
}

- (void)setupMoreBtnBlock:(void(^)(void))moreBlock
{
    self.moreBlock = moreBlock;
    [self addSubview:self.navMoreBtn];
    [self.navMoreBtn addTarget:self action:@selector(more) forControlEvents:UIControlEventTouchUpInside];
    [self.navMoreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(kNavigationSubY(27));
        make.right.mas_offset(-10);
        make.height.mas_offset(30);
        make.width.mas_offset(30);
    }];
}

- (void)setupBackTitle:(NSString *)string
{   WEAKSELF(weakSelf);
    [self.navBackTitleBtn  setTitle:string  forState:UIControlStateNormal];
    [self.navBackTitleBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.navBackTitleBtn];
    [self.navBackTitleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakSelf.navBackBtn.mas_centerY);
        make.left.mas_equalTo(weakSelf.navBackBtn.mas_right).mas_offset(-5);
    }];
}

- (void)setupRightBtnTitle:(NSString *)rightTitle Block:(void(^)(void))rightBlock
{
    self.rightBlock = rightBlock;
    [self addSubview:self.navRightTitleBtn];
    [self.navRightTitleBtn  setTitle:rightTitle  forState:UIControlStateNormal];
    [self.navRightTitleBtn addTarget:self action:@selector(rightClick) forControlEvents:UIControlEventTouchUpInside];
    [self.navRightTitleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(kNavigationSubY(27));
        make.right.mas_offset(-10);
        make.height.mas_offset(30);
//        make.width.mas_offset(40);
    }];
}

- (void)back
{
    if (self.backBlock) {
        self.backBlock();
    }
}

- (void)rightClick
{
    if (self.rightBlock) {
        self.rightBlock();
    }
}

- (void)more
{
    if (self.moreBlock) {
        self.moreBlock();
    }
}

- (void)setBgAlpha:(CGFloat)bgAlpha
{
    _bgAlpha = bgAlpha;
    self.alphaImageView.alpha = bgAlpha;
    if(bgAlpha>0.7)
    {
        self.isShowLine = 1;
    }else{
        self.isShowLine = 0;
    }
}

- (void)setIsShowLine:(BOOL)isShowLine
{
    self.line.alpha = isShowLine;
}

- (void)setLineColor:(UIColor *)lineColor
{
    self.line.backgroundColor = lineColor;
}

- (void)setIsShowWhiteTitle:(BOOL)isShowWhiteTitle
{
    _isShowWhiteTitle = isShowWhiteTitle;
    
    if (isShowWhiteTitle) {
        self.navTitleLabel.textColor = UIFontWhiteColor;
        [self.navBackBtn setBackgroundImage:[UIImage imageNamed:@"ico_white_back"]forState:UIControlStateNormal];
        [self.navMoreBtn setBackgroundImage:[UIImage imageWithName:@"w_more" ofType:@"png"]forState:UIControlStateNormal];
    }else{
        self.navTitleLabel.textColor = UIFontMainGrayColor;
        [self.navBackBtn setBackgroundImage:[UIImage imageNamed:@"ico_back"]forState:UIControlStateNormal];
        [self.navMoreBtn setBackgroundImage:[UIImage imageWithName:@"b_more" ofType:@"png"]forState:UIControlStateNormal];
    }
    
    
}

#pragma mark Lazy method

- (UIView *)alphaImageView
{
    if (!_alphaImageView) {
        _alphaImageView = [[UIImageView alloc]init];
        _alphaImageView.alpha = 1;
        _alphaImageView.backgroundColor = [UIColor whiteColor];
    }
    return _alphaImageView;
}

- (UILabel *)navTitleLabel
{
    if (!_navTitleLabel) {
        _navTitleLabel = [[UILabel alloc]init];
        _navTitleLabel.font = UIFontSize(17);//[UIFont boldSystemFontOfSize:17];
        _navTitleLabel.textColor = UIFontMainGrayColor;
        _navTitleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _navTitleLabel;
}

- (UIButton *)navBackTitleBtn
{
    if (!_navBackTitleBtn) {
        _navBackTitleBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        _navBackTitleBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_navBackTitleBtn setTitleColor:UIFontSortGrayColor forState:UIControlStateNormal];
    }
    return _navBackTitleBtn;
}

- (UIButton *)navRightTitleBtn
{
    if (!_navRightTitleBtn) {
        _navRightTitleBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        _navRightTitleBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_navRightTitleBtn setTitleColor:UIFontSortGrayColor forState:UIControlStateNormal];
    }
    return _navRightTitleBtn;
}

- (UIButton *)navBackBtn
{
    if (!_navBackBtn) {
        _navBackBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [_navBackBtn setBackgroundImage:[UIImage imageNamed:@"ico_back"]forState:UIControlStateNormal];
        
    }
    return _navBackBtn;
}

- (UIButton *)navRightBtn
{
    if (!_navRightBtn) {
        _navRightBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [_navRightBtn setBackgroundImage:[UIImage imageNamed:@"delete_collect"]forState:UIControlStateNormal];
    }
    return _navRightBtn;
}

- (UIButton *)navMoreBtn
{
    if (!_navMoreBtn) {
        _navMoreBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [_navMoreBtn setBackgroundImage:[UIImage imageWithName:@"b_more" ofType:@"png"]forState:UIControlStateNormal];
    }
    return _navMoreBtn;
}

- (UIView *)line
{
    if (!_line) {
        _line = [[UIView alloc]init];
        _line.backgroundColor = UINavSepratorLineColor;
    }
    return _line;
}

@end
