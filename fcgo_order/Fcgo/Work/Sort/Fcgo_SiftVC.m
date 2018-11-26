//
//  Fcgo_SiftVC.m
//  Fcgo
//
//  Created by huafanxiao on 2017/6/9.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_SiftVC.h"
#import "Fcgo_SiftMainView.h"


@interface Fcgo_SiftVC ()

@property (nonatomic,strong) UIControl         *touchControl;
@property (nonatomic,strong) Fcgo_SiftMainView *siftMainView;

@end

@implementation Fcgo_SiftVC


- (void)setSiftArray:(NSMutableArray *)siftArray
{
    _siftArray = siftArray;
    
    
    self.siftMainView.siftArray = siftArray;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view addSubview:self.touchControl];
    [self.view addSubview:self.siftMainView];

    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handlePan:)];
    [self.siftMainView addGestureRecognizer:panGestureRecognizer];
    WEAKSELF(weakSelf);
    self.siftMainView.selectTradeItemBlock = ^(NSString *tradeId,NSString *type)
    {
        weakSelf.selectTradeItemBlock(tradeId,type);
    };
    
    self.siftMainView.selectCateItemBlock = ^(NSString *cateId,NSString *type)
    {
        weakSelf.selectCateItemBlock(cateId,type);
    };
    
    self.siftMainView.selectBrandItemBlock = ^(NSString *brandId,NSString *type)
    {
        weakSelf.selectBrandItemBlock(brandId,type);
    };
    
    self.siftMainView.selectCatemItemBlock = ^(NSString *catemId,NSString *type)
    {
        weakSelf.selectCatemItemBlock(catemId,type);
    };
    self.siftMainView.selectAttrItemBlock = ^(NSString *attr,NSString *type,BOOL isSelected)
    {
        weakSelf.selectAttrItemBlock(attr,type,isSelected);
    };
    
    self.siftMainView.resetBlock = ^{
        weakSelf.resetBlock();
    };
    self.siftMainView.confirmBlock = ^{
        [weakSelf confirm];
    };
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    WEAKSELF(weakSelf)
    [UIView animateWithDuration:0.2 animations:^{
         weakSelf.siftMainView.frame = CGRectMake(kAutoWidth6(80), 0, kScreenWidth - kAutoWidth6(80), KScreenHeight);
    }completion:^(BOOL finished) {
        weakSelf.touchControl.hidden = 0;
    }];
}

- (void)handlePan:(UIPanGestureRecognizer*)recognizer
{
    CGPoint translation = [recognizer translationInView:self.view];
    //向左
    if (translation.x<0 && recognizer.view.frame.origin.x < kAutoWidth6(80)) {
        return;
    }
    recognizer.view.center = CGPointMake(recognizer.view.center.x + translation.x,recognizer.view.center.y);
    if (recognizer.state == UIGestureRecognizerStateEnded) {
        if (recognizer.view.frame.origin.x>kAutoWidth6(160)) {
            [self confirm];
        }
        else
        {
            [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                self.siftMainView.frame = CGRectMake(kAutoWidth6(80), 0, kScreenWidth - kAutoWidth6(80), KScreenHeight);
            } completion:nil];
        }
    }
    [recognizer setTranslation:CGPointZero inView:self.view];
}

- (void)confirm
{
    WEAKSELF(weakSelf)
    [UIView animateWithDuration:0.2 animations:^{
        weakSelf.siftMainView.frame =  CGRectMake(kScreenWidth, 0, kScreenWidth - kAutoWidth6(80), KScreenHeight);
    }completion:^(BOOL finished) {
         weakSelf.touchControl.hidden = 1;
        [weakSelf.view removeFromSuperview];
        [weakSelf removeFromParentViewController];
    }];
}

- (UIControl *)touchControl
{
    if (!_touchControl) {
        UIControl *control = [[UIControl alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, KScreenHeight)];
        control.backgroundColor = UIRGBColor(0, 0, 0, 0.5);
        [control addTarget:self action:@selector(confirm) forControlEvents:UIControlEventTouchUpInside];
        control.hidden = 1;
        _touchControl = control;
    }
    return _touchControl;
}

- (Fcgo_SiftMainView *)siftMainView
{
    if (!_siftMainView) {
        _siftMainView = [[Fcgo_SiftMainView alloc]initWithFrame:CGRectMake(kScreenWidth, 0, kScreenWidth - kAutoWidth6(80), KScreenHeight)];
    }
    return _siftMainView;
}
@end
