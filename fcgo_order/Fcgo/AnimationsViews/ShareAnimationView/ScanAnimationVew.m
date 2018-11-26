//
//  ScanAnimationVew.m
//  Fcg
//
//  Created by huafanxiao on 2017/4/25.
//  Copyright © 2017年 zgntech. All rights reserved.
//

#import "ScanAnimationVew.h"

@interface ScanAnimationVew ()

@property (nonatomic,strong) UIButton *dissBtn;

@property (nonatomic,strong) UIImageView *scanImageView;


@property (nonatomic,strong) UIView *whiteView;

@property (nonatomic,strong) UILabel *textLab;

@property (nonatomic,strong) UIControl *tapControl;

@end

@implementation ScanAnimationVew


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        self.backgroundColor = [UIColor  clearColor];
        
        self.dissBtn.frame = CGRectMake((self.mj_w-30)/2, self.mj_h - 118 - kAutoWidth6px(50), 32, 32);
        
        self.whiteView.frame = CGRectMake((kScreenWidth - kAutoWidth6(230))/2, 0, kAutoWidth6(230), kAutoWidth6(230)+ 30);
        
        self.scanImageView.frame = CGRectMake(17, 17, kAutoWidth6(230)-34, kAutoWidth6(230)-34);
        
        self.textLab.frame = CGRectMake(0, kAutoWidth6(230)-17, kAutoWidth6(230), 47);
        
        [self.whiteView addSubview:self.scanImageView];
        [self.whiteView addSubview:self.textLab];
        
        [self addSubview:self.whiteView];
        
        [self addSubview:self.dissBtn];
    }
    return self;
}

- (UIImageView *)scanImageView
{
    if (!_scanImageView) {
        _scanImageView = [[UIImageView alloc]init];
        _scanImageView.backgroundColor = [UIColor redColor];
        //_scanImageView.image = [UIImage imageNamed:@"scanImage"];
    }
    return _scanImageView;
}


- (void)setImage:(UIImage *)image
{
    _image = image;
    self.scanImageView.image = image;
}

- (UIView *)whiteView
{
    if (!_whiteView) {
        _whiteView = [[UIView alloc]init];
        _whiteView.backgroundColor = [UIColor whiteColor];
        _whiteView.layer.cornerRadius = 6;
        _whiteView.layer.masksToBounds = YES;
    }
    return _whiteView;
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


- (UILabel *)textLab
{
    if (!_textLab) {
        _textLab = [[UILabel alloc]init];
        _textLab.font = UIFontSize(14);
        _textLab.textColor = UIStringColor(@"#777777");
        _textLab.text = @"微信扫一扫识别此二维码";
        _textLab.textAlignment = NSTextAlignmentCenter;
    }
    return _textLab;
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


- (UIControl *)tapControl
{
    if (!_tapControl) {
        UIControl *tapControl = [[UIControl alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, KScreenHeight)];
        [tapControl addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
        tapControl.backgroundColor = [UIColor colorWithRed:34/255 green:34/255 blue:34/255 alpha:0.2];
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
@end

