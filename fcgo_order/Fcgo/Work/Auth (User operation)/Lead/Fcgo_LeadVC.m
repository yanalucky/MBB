//
//  Fcgo_LeadVC.m
//  Fcgo
//
//  Created by huafanxiao on 2017/6/15.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_LeadVC.h"

@interface Fcgo_LeadVC ()<UIScrollViewDelegate>

@property (strong, nonatomic) UIScrollView *scrollView;

@end

@implementation Fcgo_LeadVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupUI];
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];
}

- (void)setupUI
{
    [self.view addSubview:self.scrollView];
    NSArray *iPhone4Array = @[@"i4_lead1",@"i4_lead2",@"i4_lead3"];
    NSArray *iPhone5Array = @[@"i5_lead1",@"i5_lead2",@"i5_lead3"];
    NSArray *iPhone6Array = @[@"i6_lead1",@"i6_lead2",@"i6_lead3"];
    NSArray *iPhone6pArray = @[@"i6p_lead1",@"i6p_lead2",@"i6p_lead3"];
//    NSArray *iPhoneXArray = @[@"iX_lead1",@"iX_lead2",@"iX_lead3"];
    
    NSArray *guiderArray;
    if (IPHONE4) {
        guiderArray = iPhone4Array;
    }else if (IPHONE5){
        guiderArray = iPhone5Array;
    }else if (IPHONE6){
        guiderArray = iPhone6Array;
    }else if (IPHONE6P) {
        guiderArray = iPhone6pArray;
    }
//    else if (IPHONEX) { 
//        guiderArray = iPhoneXArray;
//    }
    else {
        guiderArray = iPhone6pArray;
    }
    self.scrollView.contentSize = CGSizeMake(kScreenWidth*guiderArray.count, KScreenHeight);
    for (int i = 0; i < guiderArray.count; i ++) {
        UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth*i,0, kScreenWidth, KScreenHeight)];
        img.image = [UIImage imageNamed:guiderArray[i]];
        if (i == 2) {
            img.userInteractionEnabled = YES;
            UITapGestureRecognizer *touch = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(leadClick)];
            [img addGestureRecognizer:touch];
        }
        [_scrollView addSubview:img];
    }
}

- (void)leadClick
{
    [Fcgo_UserTools shared].isFirstLaunch  = 1;
    [Fcgo_Delegate setupRootVC];
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
}

- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, KScreenHeight)];
        scrollView.bounces = 0;
        scrollView.pagingEnabled = 1;
        scrollView.showsHorizontalScrollIndicator = 0;
        if (@available(iOS 11.0, *)) {
            scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        _scrollView = scrollView;
    }
    return _scrollView;
}

@end

