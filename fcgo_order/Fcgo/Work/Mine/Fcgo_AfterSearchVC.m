//
//  Fcgo_AfterSearchVC.m
//  Fcgo
//
//  Created by fcg on 2017/12/7.
//  Copyright © 2017年 Fcg. All rights reserved.
//

#import "Fcgo_AfterSearchVC.h"
#import "Fcgo_SearchNavView.h"
#import "Fcgo_AfterSalesApplyVC.h"
#import "Fcgo_AfterSalesServiceVC.h"

@interface Fcgo_AfterSearchVC ()<UITextFieldDelegate>
@property (nonatomic, strong) Fcgo_SearchNavView    *searchView;
@property (nonatomic,strong)Fcgo_AfterSalesApplyVC *vc1;
@property (nonatomic,strong)Fcgo_AfterSalesServiceVC *vc2;
@property (nonatomic,strong)Fcgo_BasicVC *currentVC;
@end

@implementation Fcgo_AfterSearchVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    // Do any additional setup after loading the view.
}
#pragma mark - UI
- (void)setupUI {
    WEAKSELF(weakSelf);
    self.view.backgroundColor = UIBackGroundColor;
    Fcgo_SearchNavView *searchView = [[Fcgo_SearchNavView alloc] initWithFrame:CGRectMake(0, kNavigationSubY(20), kScreenWidth, 44) cancel:^{
        [weakSelf searchCancel];
    } start:^(BOOL containText, NSString *string) {
//                [weakSelf search:string];
    } search:^(NSString *string) {
        [weakSelf search:string];
    }];
    searchView.searchTextField.delegate = self;
    searchView.searchTextField.placeholder = @"请输入订单号/运单编号/商品名称";
    [searchView.searchTextField becomeFirstResponder];
    _searchView = searchView;
    [self.navigationView addSubview:searchView];
    
    
    
    self.vc1 = [[Fcgo_AfterSalesApplyVC alloc] init];
    self.vc1.backVC = self;
    self.vc1.isSearch = YES;
    [self.view addSubview:self.vc1.view];
    [_vc1.view mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.view);
        make.top.equalTo(self.view).offset(kNavigationSubY(64));
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
    [self addChildViewController:self.vc1];
    self.vc1.view.hidden = YES;
    
    self.vc2 = [[Fcgo_AfterSalesServiceVC alloc] init];
    self.vc2.isSearch = YES;
    [self.view addSubview:self.vc2.view];
    [_vc2.view mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.view);
        make.top.equalTo(self.view).offset(kNavigationSubY(64));
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
    [self addChildViewController:self.vc2];
    self.vc2.view.hidden = YES;
    if (_type == 0) {
        _currentVC = self.vc1;
    }else{
        _currentVC = self.vc2;
    }
}


- (void)searchCancel {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)search:(NSString *)string {
    while ([string containsString:@" "]) {
        string = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
    }
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:string forKey:@"searchInfo"];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"Search" object:nil userInfo:dic];
    _currentVC.view.hidden = NO;
    [self.searchView.searchTextField resignFirstResponder];
}
#pragma mark - delegate
#pragma mark - UITextFieldDelegate

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    [self search:textField.text];
    return YES;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self searchCancel];
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
