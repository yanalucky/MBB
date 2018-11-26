//
//  Fcgo_BasicWebViewProgressView.m
//  Fcgo
//
//  Created by huafanxiao on 2017/5/12.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_BasicWebViewProgressView.h"

@implementation Fcgo_BasicWebViewProgressView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.hidden = YES;
        //默认背景色
        self.backgroundColor = UIStringColor(@"#00aaef");
    }
    return self;
}

-(void)setLineColor:(UIColor *)lineColor{
    _lineColor = lineColor;
    self.backgroundColor = lineColor;
}

-(void)startLoadingAnimation
{
    self.hidden = NO;
    self.mj_w = 0.0;
    __weak UIView *weakSelf = self;

    [UIView transitionWithView:self duration:0.8 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        weakSelf.mj_w = kScreenWidth * 0.8;
    } completion:^(BOOL finished) {
        if (finished) {
            [UIView animateWithDuration:20 animations:^{
                weakSelf.mj_w = kScreenWidth * 0.9;
            }completion:^(BOOL finished) {
            }];
        }
    }];

}

-(void)endLoadingAnimation
{
    [self.layer removeAllAnimations];
    __weak UIView *weakSelf = self;
    [UIView animateWithDuration:0.2 animations:^{
        weakSelf.mj_w = kScreenWidth;
    } completion:^(BOOL finished) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            weakSelf.hidden = YES;
            weakSelf.mj_w = 0;
        });
       
    }];
}

@end
