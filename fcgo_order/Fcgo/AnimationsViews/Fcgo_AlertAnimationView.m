//
//  Fcgo_AlertAnimationView.m
//  Fcgo
//
//  Created by huafanxiao on 2017/6/9.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_AlertAnimationView.h"

#define alert_width 260
#define alert_text_width (260-kAutoWidth6(60))


@interface Fcgo_AlertAnimationView ()

@property (nonatomic,strong) UIView   *alertView;
@property (nonatomic,strong) UILabel  *titleLabel;
@property (nonatomic,strong) UILabel  *textLabel;
@property (nonatomic,strong) UIButton *cancelBtn;
@property (nonatomic,strong) UIButton *confirmBtn;
@property (nonatomic,strong) UIView   *hLine;
@property (nonatomic,strong) UIView   *vLine;

@end

@implementation Fcgo_AlertAnimationView


+ (instancetype)showWithTitle:(NSString *)title text:(NSString *)text cancelTitle:(NSString *)cancel confirmTitle:(NSString *)confirm block:(void(^)(void))confirmBlick
{
    
    CGFloat height = [text boundingRectWithSize:CGSizeMake(alert_text_width, CGFLOAT_MAX) options: NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size.height;
    
    Fcgo_AlertAnimationView *alert = [[Fcgo_AlertAnimationView alloc]init];
    alert.frame = CGRectMake(0, 0, kScreenWidth, KScreenHeight);
    alert.confirmBlick = confirmBlick;
    
    alert.alertView.center = CGPointMake(kScreenWidth/2, KScreenHeight/2);
    alert.alertView.bounds = CGRectMake(0, 0, alert_width, 20+30+height+10+20+0.5+45);
    alert.titleLabel.frame = CGRectMake(0, 17, alert.alertView.mj_w, 30);
    alert.textLabel.frame = CGRectMake(kAutoWidth6(30), 47, alert_text_width, height+10);
    alert.hLine.frame = CGRectMake(0, alert.textLabel.mj_y+alert.textLabel.mj_h+18, alert.alertView.mj_w, 0.5);
    alert.vLine.frame = CGRectMake(alert.alertView.mj_w/2-0.25, alert.textLabel.mj_y+alert.textLabel.mj_h+20, 0.5, 50);
    alert.cancelBtn.frame = CGRectMake(0, alert.hLine.mj_y+0.5, alert.alertView.mj_w/2, 50);
    alert.confirmBtn.frame = CGRectMake(alert.alertView.mj_w/2, alert.hLine.mj_y+0.5, alert.alertView.mj_w/2, 50);
    
    alert.titleLabel.text = title;
    alert.textLabel.text = text;
    [alert.cancelBtn setTitle:cancel forState:UIControlStateNormal];
    [alert.confirmBtn setTitle:confirm forState:UIControlStateNormal];
    
    
    [alert show];
    return alert;
}


+ (instancetype)showWithTitle:(NSString *)title text:(NSString *)text cancelTitle:(NSString *)cancel confirmTitle:(NSString *)confirm cancelBlock:(void(^)(void))cancelBlick block:(void(^)(void))confirmBlick
{
    CGFloat height = [text boundingRectWithSize:CGSizeMake( alert_text_width, CGFLOAT_MAX) options: NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size.height;
    
    Fcgo_AlertAnimationView *alert = [[Fcgo_AlertAnimationView alloc]init];
    alert.frame = CGRectMake(0, 0, kScreenWidth, KScreenHeight);
    alert.confirmBlick = confirmBlick;
    alert.cancelBlick = cancelBlick;
    
    alert.alertView.center = CGPointMake(kScreenWidth/2, KScreenHeight/2);
    alert.alertView.bounds = CGRectMake(0, 0, alert_width, 20+30+height+10+20+0.5+45);
    alert.titleLabel.frame = CGRectMake(0, 17, alert.alertView.mj_w, 30);
    alert.textLabel.frame = CGRectMake(kAutoWidth6(30), 47, alert_text_width, height+10);
    alert.hLine.frame = CGRectMake(0, alert.textLabel.mj_y+alert.textLabel.mj_h+18, alert.alertView.mj_w, 0.5);
    alert.vLine.frame = CGRectMake(alert.alertView.mj_w/2-0.25, alert.textLabel.mj_y+alert.textLabel.mj_h+20, 0.5, 50);
    alert.cancelBtn.frame = CGRectMake(0, alert.hLine.mj_y+0.5, alert.alertView.mj_w/2, 50);
    alert.confirmBtn.frame = CGRectMake(alert.alertView.mj_w/2, alert.hLine.mj_y+0.5, alert.alertView.mj_w/2, 50);
    
    alert.titleLabel.text = title;
    alert.textLabel.text = text;
    [alert.cancelBtn setTitle:cancel forState:UIControlStateNormal];
    [alert.confirmBtn setTitle:confirm forState:UIControlStateNormal];
    [alert show];
    return alert;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = UIRGBColor(0, 0, 0, 0.2);
        [self addSubview:self.alertView];
        [self.alertView addSubview:self.titleLabel];
        [self.alertView addSubview:self.textLabel];
        [self.alertView addSubview:self.hLine];
        [self.alertView addSubview:self.vLine];
        [self.alertView addSubview:self.cancelBtn];
        [self.alertView addSubview:self.confirmBtn];
    }
    return self;
}


- (UIView *)alertView
{
   
    if (!_alertView) {
        _alertView = [[UIView alloc]init];
        _alertView.center = CGPointMake(kScreenWidth/2, KScreenHeight/2);
        _alertView.backgroundColor = UIFontWhiteColor;
        _alertView.layer.cornerRadius = 10;
        _alertView.layer.masksToBounds = true;
    }
    return _alertView;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        UILabel *label = [[UILabel alloc]init];
        label.textColor = UIFontMainGrayColor;
        label.font = [UIFont boldSystemFontOfSize:17];
        label.textAlignment = NSTextAlignmentCenter;
        _titleLabel = label;
    }
    return _titleLabel;
}

- (UILabel *)textLabel
{
    if (!_textLabel) {
        UILabel *label = [[UILabel alloc]init];
        
        label.textColor = UIFontMainGrayColor;
        label.numberOfLines = 0;
        label.font = [UIFont systemFontOfSize:15];
        label.textAlignment = NSTextAlignmentCenter;
        _textLabel = label;
    }
    return _textLabel;
}


- (UIView *)hLine
{
    if (!_hLine) {
        _hLine = [[UIView alloc] init];
        _hLine.backgroundColor = UISepratorLineColor;
    }
    return _hLine;
}

- (UIView *)vLine
{
    if (!_vLine) {
        _vLine = [[UIView alloc] init];
        _vLine.backgroundColor = UISepratorLineColor;
    }
    return _vLine;
}

- (UIButton *)cancelBtn
{
    if (!_cancelBtn) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        
        btn.backgroundColor = UIFontWhiteColor;
        [btn setTitleColor:UIFontRedColor forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:16];
        [btn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
        [btn setBackgroundColor:UIFontClearColor];
        _cancelBtn = btn;
    }
    return _cancelBtn;
}

- (UIButton *)confirmBtn
{
    if (!_confirmBtn) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        
        btn.backgroundColor = UIFontWhiteColor;
        [btn setTitleColor:UIFontRedColor forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:16];
        [btn addTarget:self action:@selector(confirm) forControlEvents:UIControlEventTouchUpInside];
        [btn setBackgroundColor:UIFontClearColor];
        _confirmBtn = btn;
    }
    return _confirmBtn;
}

- (void)confirm
{
    [self removeFromSuperview];
    if (self.confirmBlick) {
        self.confirmBlick();
    }
}

- (void)show
{
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [UIApplication sharedApplication].keyWindow.userInteractionEnabled = YES;
    self.alertView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.001f, 0.001f);
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.15 animations:^{
        __strong typeof(weakSelf)strongSelf = weakSelf;
        strongSelf.alertView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.1f, 1.1f);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.1 animations:^{
            __strong typeof(weakSelf)strongSelf = weakSelf;
            strongSelf.alertView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.f, 1.f);
        } completion:^(BOOL finished) {
            
        }];
    }];
}

- (void)dismiss
{
    if (self.cancelBlick) {
        self.cancelBlick();
    }
    
    [self removeFromSuperview];
}

@end


