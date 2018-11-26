//
//  Fcgo_AfterSaleVC.m
//  Fcgo
//
//  Created by fcg on 2017/10/24.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_AfterSaleVC.h"
#import "Fcgo_AfterSalesServiceMoreVC.h"
#import "Fcgo_OrderListNavView.h"
#import "Fcgo_AfterSearchVC.h"

#import "Fcgo_MainScreeningVC.h"
#import "Fcgo_TopAnimationView.h"
#import "Fcgo_OrderShiftVC.h"
#import "Fcgo_afterSiftVC.h"


@interface Fcgo_AfterSaleVC ()<Fcgo_afterSiftDetailVCDelegate>

@property (nonatomic, strong) Fcgo_afterSiftVC *siftVC;

@end

@implementation Fcgo_AfterSaleVC

#pragma mark Fcgo_afterSiftDetailVCDelegate
- (void)determineButtonTouchEvent:(NSDictionary *)dictionary {
    //筛选完成
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:dictionary];
    [dic setObject:[NSString stringWithFormat:@"%d",self.type] forKey:@"type"];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"siftWithDic" object:nil userInfo:[dic copy]];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    WEAKSELF(weakSelf)
    _type = 0;
    Fcgo_OrderListNavView *navView = [[Fcgo_OrderListNavView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kNavigationHeight)];
    [navView setTitleString:@"售后服务"];
    [self.navigationView addSubview:navView];
    navView.searchBlock = ^{
        Fcgo_AfterSearchVC *vc = [[Fcgo_AfterSearchVC alloc] init];
        vc.type = self.type;
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
    navView.siftBlock = ^{
        _siftVC = [Fcgo_afterSiftVC new];
        self.definesPresentationContext = YES;
        _siftVC.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        _siftVC.view.backgroundColor = UIRGBColor(0, 0, 0, 0.4 );
        _siftVC.type = self.type;
        _siftVC.delegate = self;
        [weakSelf presentViewController:weakSelf.siftVC animated:NO completion:NULL];
    };
    //遮盖层消失。页面返回
    [self.navigationView setupBackBtnBlock:^{
        [[Fcgo_TopAnimationView sharedClient] dismissBlock:^{
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }];
    }];
    
//    [self.navigationView setupBackBtnBlock:^{
//        [weakSelf.navigationController popViewControllerAnimated:YES];
//    }];
    
    
    
    Fcgo_AfterSalesServiceMoreVC *moreVC = [[Fcgo_AfterSalesServiceMoreVC alloc] init];
    moreVC.haveNavBar = YES;
    moreVC.backVC = self;
    
    moreVC.typeBlock = ^(int type) {
        weakSelf.type = type;
    };
    [self.view addSubview:moreVC.view];
    [self addChildViewController:moreVC];
    [moreVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(kNavigationHeight);
        make.width.and.bottom.centerX.equalTo(self.view);
    }];
    // Do any additional setup after loading the view.
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
