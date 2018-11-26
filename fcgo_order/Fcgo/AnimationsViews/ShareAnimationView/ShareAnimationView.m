//
//  ShareAnimationView.m
//  Fcg
//
//  Created by huafanxiao on 2017/4/24.
//  Copyright © 2017年 zgntech. All rights reserved.
//

#import "ShareAnimationView.h"

@interface ShareAnimationView ()

@property (nonatomic,strong) UIButton *dissBtn,*weixinBtn,*weixinTimeLineBtn,*qrBtn,*copyhrefBtn;

@property (nonatomic,strong) UILabel *weixinLab,*weixinTimeLineLab,*qrLab,*copyhrefLab;

@property (nonatomic,strong) UIControl *tapControl;

@end

@implementation ShareAnimationView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        self.backgroundColor = [UIColor  clearColor];
        //self.backgroundColor = [UIColor  hexStringToColor:@"#f7f4f2"];
        self.dissBtn.frame = CGRectMake((self.mj_w-30)/2, self.mj_h - 68, 32, 32);
        
        self.weixinBtn.frame = CGRectMake((kScreenWidth - 180)/5, 30, 45, 45);
        
        self.weixinLab.center = CGPointMake(self.weixinBtn.center.x, self.weixinBtn.center.y+40);
        self.weixinLab.bounds = CGRectMake(0, 0, 70, 20);
        
        self.weixinTimeLineBtn.frame = CGRectMake((kScreenWidth - 180)/5*2+45, 30, 45, 45);
        self.weixinTimeLineLab.center = CGPointMake(self.weixinTimeLineBtn.center.x, self.weixinTimeLineBtn.center.y+40);
        self.weixinTimeLineLab.bounds = CGRectMake(0, 0, 70, 20);
        
        self.qrBtn.frame = CGRectMake((kScreenWidth - 180)/5*3+90, 30, 45, 45);
        self.qrLab.center = CGPointMake(self.qrBtn.center.x, self.qrBtn.center.y+40);
        self.qrLab.bounds = CGRectMake(0, 0, 70, 20);
        
        self.copyhrefBtn.frame = CGRectMake((kScreenWidth - 180)/5*4+135, 30, 45, 45);
        self.copyhrefLab.center = CGPointMake(self.copyhrefBtn.center.x, self.copyhrefBtn.center.y+40);
        self.copyhrefLab.bounds = CGRectMake(0, 0, 70, 20);
        
        [self addSubview:self.weixinBtn];
        [self addSubview:self.weixinTimeLineBtn];
        
         [self addSubview:self.qrBtn];
         [self addSubview:self.copyhrefBtn];
        
        [self addSubview:self.weixinLab];
        [self addSubview:self.weixinTimeLineLab];
        
        [self addSubview:self.qrLab];
        [self addSubview:self.copyhrefLab];
        
        [self addSubview:self.dissBtn];
    }
    return self;
}

- (UIButton *)dissBtn
{
    if (!_dissBtn) {
        _dissBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        //_dissBtn.backgroundColor = [UIColor redColor];
        [_dissBtn addTarget:self action:@selector(dismissAnimation) forControlEvents:UIControlEventTouchUpInside];
        [_dissBtn setBackgroundImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
    }
    return _dissBtn;
}

- (UIButton *)weixinBtn
{
    if (!_weixinBtn) {
        _weixinBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        //_dissBtn.backgroundColor = [UIColor redColor];
        [_weixinBtn addTarget:self action:@selector(weixinBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [_weixinBtn setBackgroundImage:[UIImage imageNamed:@"wechat"] forState:UIControlStateNormal];
    }
    return _weixinBtn;
}

- (UIButton *)weixinTimeLineBtn
{
    if (!_weixinTimeLineBtn) {
        _weixinTimeLineBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        //_dissBtn.backgroundColor = [UIColor redColor];
        [_weixinTimeLineBtn addTarget:self action:@selector(weixinTimeLineBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [_weixinTimeLineBtn setBackgroundImage:[UIImage imageNamed:@"moments"] forState:UIControlStateNormal];
    }
    return _weixinTimeLineBtn;
}

- (UIButton *)qrBtn
{
    if (!_qrBtn) {
        _qrBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        //_dissBtn.backgroundColor = [UIColor redColor];
        [_qrBtn addTarget:self action:@selector(qrBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [_qrBtn setBackgroundImage:[UIImage imageNamed:@"QR-1"] forState:UIControlStateNormal];
    }
    return _qrBtn;
}

- (UIButton *)copyhrefBtn
{
    if (!_copyhrefBtn) {
        _copyhrefBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        //_dissBtn.backgroundColor = [UIColor redColor];
        [_copyhrefBtn addTarget:self action:@selector(copyhrefBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [_copyhrefBtn setBackgroundImage:[UIImage imageNamed:@"copy"] forState:UIControlStateNormal];
    }
    return _copyhrefBtn;
}

- (UILabel *)weixinLab
{
    if (!_weixinLab) {
        _weixinLab = [[UILabel alloc]init];
        _weixinLab.font = [UIFont systemFontOfSize:14];
        _weixinLab.textColor = UIFontWhiteColor;
        _weixinLab.text = @"微信";
        _weixinLab.textAlignment = NSTextAlignmentCenter;
        
    }
    return _weixinLab;
}

- (UILabel *)weixinTimeLineLab
{
    if (!_weixinTimeLineLab) {
        _weixinTimeLineLab = [[UILabel alloc]init];
        _weixinTimeLineLab.font = [UIFont systemFontOfSize:14];
        _weixinTimeLineLab.textColor = UIFontWhiteColor;
        _weixinTimeLineLab.text = @"朋友圈";
        _weixinTimeLineLab.textAlignment = NSTextAlignmentCenter;
        
    }
    return _weixinTimeLineLab;
}

- (UILabel *)qrLab
{
    if (!_qrLab) {
        _qrLab = [[UILabel alloc]init];
        _qrLab.font = [UIFont systemFontOfSize:14];
        _qrLab.textColor = UIFontWhiteColor;
        _qrLab.text = @"二维码";
        _qrLab.textAlignment = NSTextAlignmentCenter;
        
    }
    return _qrLab;
}

- (UILabel *)copyhrefLab
{
    if (!_copyhrefLab) {
        _copyhrefLab = [[UILabel alloc]init];
        _copyhrefLab.font = [UIFont systemFontOfSize:14];
        _copyhrefLab.textColor = UIFontWhiteColor;
        _copyhrefLab.text = @"复制链接";
        _copyhrefLab.textAlignment = NSTextAlignmentCenter;
        
    }
    return _copyhrefLab;
}


- (void)weixinBtnClick
{
    [self dismiss];
    self.shareBlock(ShareWeiXinType);
    
}

- (void)dismissAnimation
{
    WEAKSELF(weakSelf);
    [UIView animateWithDuration:0.3 animations:^{
        weakSelf.dissBtn.transform = CGAffineTransformMakeRotation(M_PI);
    }completion:^(BOOL finished) {
       [weakSelf dismiss];
    }];
}


- (void)weixinTimeLineBtnClick
{
    [self dismiss];
    self.shareBlock(ShareWeiXinTimeLineType);
}

- (void)qrBtnClick
{
    self.shareBlock(ShareScanType);
}

- (void)copyhrefBtnClick
{
    [self dismiss];
    self.shareBlock(ShareCopyLinkType);
}

- (UIControl *)tapControl
{
    if (!_tapControl) {
        UIControl *tapControl = [[UIControl alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, KScreenHeight)];
        [tapControl addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
        tapControl.backgroundColor = [UIColor colorWithRed:34/255 green:34/255 blue:34/255 alpha:0.7];
        _tapControl = tapControl;
    }
    return _tapControl;
}

- (void)show
{
    [self.tapControl addSubview:self];
    [[UIApplication sharedApplication].keyWindow addSubview:self.tapControl];
    [UIApplication sharedApplication].keyWindow.userInteractionEnabled = YES;
    CGRect rect = self.frame;
    self.frame = CGRectMake(0, KScreenHeight, rect.size.width, rect.size.height);
    [UIView animateWithDuration:0.3 animations:^{
        self.frame = CGRectMake(0, KScreenHeight - rect.size.height, rect.size.width, rect.size.height);
    }];
}

- (void)dismiss
{
    __weak typeof(self) weakSelf = self;
    CGRect rect = self.frame;
    [UIView animateWithDuration:0.4 animations:^{
        weakSelf.frame = CGRectMake(0, KScreenHeight, rect.size.width, rect.size.height);
    } completion:^(BOOL finished) {
        [weakSelf.tapControl removeFromSuperview];
    }];
}

- (void)dismissWithComplation:(void(^)(void))block
{
    __weak typeof(self) weakSelf = self;
    CGRect rect = self.frame;
    [UIView animateWithDuration:0.3 animations:^{
        weakSelf.frame = CGRectMake(0, KScreenHeight, rect.size.width, rect.size.height);
    } completion:^(BOOL finished) {
        [weakSelf.tapControl removeFromSuperview];
        block();
    }];
}

@end

