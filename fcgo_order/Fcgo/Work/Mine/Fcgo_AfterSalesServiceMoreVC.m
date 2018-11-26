//
//  Fcgo_AfterSalesServiceMoreVC.m
//  Fcgo
//
//  Created by fcg on 2017/10/24.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_AfterSalesServiceMoreVC.h"
#import "Fcgo_AfterSalesServiceVC.h"
#import "Fcgo_AfterSalesApplyVC.h"
@interface Fcgo_AfterSalesServiceMoreVC () <XHSegmentControlDelegate>

@property (nonatomic,strong)Fcgo_AfterSalesApplyVC *vc1;
@property (nonatomic,strong)Fcgo_AfterSalesServiceVC *vc2;
@end

@implementation Fcgo_AfterSalesServiceMoreVC

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.segmentHighlightColor = UIFontRedColor;
    self.segmentTitleColor     = UIFontMainGrayColor;
    self.scrollView.bounces    = 0;
    self.isNav = 0;
    self.vc1 = [[Fcgo_AfterSalesApplyVC alloc] init];
    self.vc1.isSearch = NO;
    self.vc1.title = @"售后申请";
    self.vc1.backVC = self.backVC;
    self.vc2       = [[Fcgo_AfterSalesServiceVC alloc] init];
    self.vc2.title = @"申请记录";

    
    self.viewControllers = @[self.vc1, self.vc2];
    
    // Do any additional setup after loading the view.
}

#pragma mark - XHSegmentControlDelegate
- (void)xhSegmentSelectAtIndex:(NSInteger)index animation:(BOOL)animation
{
    
    if (self.typeBlock) {
        self.typeBlock(index);
    }
    
    [self.viewControllers enumerateObjectsUsingBlock:^(UIViewController *  _Nonnull controller, NSUInteger idx, BOOL * _Nonnull stop)
     {
         [controller removeFromParentViewController];
     }];
    [self.scrollView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
    
    //  add controller
    UIViewController *controller = self.viewControllers[index];
    
    //  add view
    UIView *view = controller.view;
    [view removeFromSuperview];
    view.frame = CGRectMake(index * CGRectGetWidth(self.scrollView.frame), 0, CGRectGetWidth(self.scrollView.frame), CGRectGetHeight(self.scrollView.frame));
    
    [controller willMoveToParentViewController:self];
    [self addChildViewController:controller];
    [controller didMoveToParentViewController:self];
    [self.scrollView addSubview:view];
    
    //  add next view
    if (index + 1 < self.viewControllers.count) {
        UIViewController *nextController = self.viewControllers[index + 1];
        UIView *nextView = nextController.view;
        [nextView removeFromSuperview];
        nextView.frame = CGRectMake((index + 1) * CGRectGetWidth(self.scrollView.frame), 0, CGRectGetWidth(self.scrollView.frame), CGRectGetHeight(self.scrollView.frame));
        [self.scrollView addSubview:nextView];
    }
    
    //  add previous view
    if (index - 1 >= 0) {
        UIViewController *previousController = self.viewControllers[index - 1];
        UIView *previousView = previousController.view;
        [previousView removeFromSuperview];
        [self.scrollView addSubview:previousView];
        previousView.frame = CGRectMake((index - 1) * CGRectGetWidth(self.scrollView.frame), 0, CGRectGetWidth(self.scrollView.frame), CGRectGetHeight(self.scrollView.frame));
    }
    [self.scrollView scrollRectToVisible:view.frame animated:animation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
