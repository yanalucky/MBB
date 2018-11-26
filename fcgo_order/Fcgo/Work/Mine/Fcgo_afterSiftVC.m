//
//  Fcgo_afterSiftVC.m
//  Fcgo
//
//  Created by fcg on 2017/12/7.
//  Copyright © 2017年 Fcg. All rights reserved.
//

#import "Fcgo_afterSiftVC.h"


#define offset ([UIScreen mainScreen].bounds.size.width - kAutoWidth6(80))

@interface Fcgo_afterSiftVC ()<Fcgo_afterSiftDetailVCDelegate>
{
    UIWindow    *window;
    Fcgo_afterSiftDetailVC *screeningVC;
}
@end

@implementation Fcgo_afterSiftVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // 点击关闭视图
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
    [self.view addGestureRecognizer:tap];
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(dismissPan:)];
    [self.view addGestureRecognizer:pan];
    
    // 加载window
    window = [[UIWindow alloc] initWithFrame:CGRectMake(kScreenWidth, 0, offset, KScreenHeight)];
    window.hidden = YES;
    
    
    Fcgo_afterSiftDetailVC *rvc = [[Fcgo_afterSiftDetailVC alloc] init];
    rvc.width = offset;
    rvc.delegate = self;
    rvc.type = self.type;
    window.rootViewController = rvc;
    screeningVC = rvc;
    
    //    [self show];
}
-(void)setType:(int)type{
    _type = type;
    screeningVC.type = type;
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self show];
}

- (void)show {
    if (_isShow) {
        return;
    }
    if (screeningVC) {
        [screeningVC resetButtonAction];
    }
    window.hidden = NO;
    _isShow = YES;
    // 设置视图偏移
    [UIView animateWithDuration:.3 animations:^{
        CGRect rect = window.frame;
        rect.origin.x -= (offset);
        window.frame = rect;
    }];
}

- (void)dismiss {
    [self dismissWindow:NULL];
}

- (void)dismissPan:(UIGestureRecognizer *)gest {
    if (gest.state == UIGestureRecognizerStateBegan) {
        [self dismiss];
    }
}

- (void)dismissWindow:(void(^)(void))block {
    if (!_isShow) {
        return;
    }
    
    _isShow = NO;
    // 设置试图偏移
    [UIView animateWithDuration:.3 animations:^{
        CGRect rect = window.frame;
        rect.origin.x += (offset);
        window.frame = rect;
    } completion:^(BOOL finished) {
        window.hidden = YES;
        //        window = nil;
        if (finished) {
            _isShow = NO;
            if (block) {
                block();
            }
            [self dismissViewControllerAnimated:NO completion:nil];
        }
    }];
}

- (void)determineButtonTouchEvent:(NSDictionary *)dictionary {
    WEAKSELF(weakSelf);
    [self dismissWindow:^{
        if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(determineButtonTouchEvent:)]) {
            [weakSelf.delegate determineButtonTouchEvent:dictionary];
        }
    }];
}


@end
