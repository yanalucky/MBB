//
//  Fcgo_TextAnimationView.m
//  Fcgo
//
//  Created by huafanxiao on 2017/5/12.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_TextAnimationView.h"

@interface Fcgo_TextAnimationView()

@property (nonatomic,strong) UIView     *showTextView;
@property (nonatomic,strong) UITextView *textView;
@property (nonatomic,strong) UILabel    *titleLabel;
@property (nonatomic,strong) UIButton   *dismissBtn;

@end

@implementation Fcgo_TextAnimationView

+ (instancetype)sharedClient
{
    static Fcgo_TextAnimationView *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[Fcgo_TextAnimationView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, KScreenHeight)];
    });
    return _sharedClient;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIRGBColor(0, 0, 0, 0.2);
        [self addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews
{
    WEAKSELF(weakSelf)
    [self addSubview:self.showTextView];
    
    [self.showTextView addSubview:self.titleLabel];
    [self.showTextView addSubview:self.textView];
    [self.showTextView addSubview:self.dismissBtn];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_offset(5);
        make.height.mas_offset(kAutoWidth6(30));
    }];
    [self.dismissBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.mas_offset(0);
        make.height.mas_offset(kAutoWidth6(40));
    }];
    
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(15);
        make.right.mas_offset(-15);
        make.top.mas_equalTo(weakSelf.titleLabel.mas_bottom).mas_offset(0);
        make.bottom.mas_equalTo(weakSelf.dismissBtn.mas_top).mas_offset(0);
    }];
}

+ (void)showWithTitle:(NSString *)title  textString:(NSString *)string
{
    Fcgo_TextAnimationView *textAnimationView = [Fcgo_TextAnimationView sharedClient];
    textAnimationView.titleLabel.text = title;
    textAnimationView.textView.text = string;
    
    [[UIApplication sharedApplication].keyWindow addSubview:textAnimationView];
    [UIApplication sharedApplication].keyWindow.userInteractionEnabled = YES;
    CGRect rect = textAnimationView.showTextView.frame;
    textAnimationView.showTextView.frame = CGRectMake((kScreenWidth-260)/2, KScreenHeight, rect.size.width, rect.size.height);

    [UIView animateWithDuration:0.45
                          delay:0.0
         usingSpringWithDamping:0.75
          initialSpringVelocity:0.4
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         textAnimationView.showTextView.center = CGPointMake(kScreenWidth/2, KScreenHeight/2);
                     } completion:^(BOOL finished) {
                     }];
}

- (void)dismiss;
{
    Fcgo_TextAnimationView *textAnimationView = [Fcgo_TextAnimationView sharedClient];
    CGRect rect = textAnimationView.showTextView.frame;
    
    [UIView transitionWithView:textAnimationView.showTextView duration:0.3 options:UIViewAnimationOptionCurveEaseInOut animations:^{
         textAnimationView.showTextView.frame = CGRectMake((kScreenWidth-260)/2, KScreenHeight, rect.size.width, rect.size.height);
    } completion:^(BOOL finished) {
        [textAnimationView removeFromSuperview];
    }];
}


- (UIView *)showTextView
{
    if (!_showTextView) {
        _showTextView = [[UIView alloc]initWithFrame:CGRectMake((kScreenWidth-260)/2, KScreenHeight, 260, 260)];
        _showTextView.backgroundColor = UIFontWhiteColor;
        _showTextView.layer.cornerRadius = 10;
        _showTextView.layer.masksToBounds = YES;
    }
    return _showTextView;
}

- (UITextView *)textView
{
    if (!_textView) {
        _textView = [[UITextView alloc]init];
        _textView.textColor = UIFontMainGrayColor;
        _textView.font = [UIFont systemFontOfSize:15];
        _textView.editable = NO;
        _textView.textAlignment = NSTextAlignmentLeft;
    }
    return _textView;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font = [UIFont systemFontOfSize:17];
        _titleLabel.textColor = UIFontRedColor;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

- (UIButton  *)dismissBtn
{
    if (!_dismissBtn) {
        _dismissBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [_dismissBtn setBackgroundColor:UIFontRedColor];
        [_dismissBtn setTitle:@"知道啦" forState:UIControlStateNormal];
        _dismissBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [_dismissBtn setTitleColor:UIFontWhiteColor forState:UIControlStateNormal];
        [_dismissBtn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    }
    return _dismissBtn;
}

@end
