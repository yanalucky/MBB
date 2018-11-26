//
//  Fcgo_ApplyHistoryVC.m
//  Fcgo
//
//  Created by fcg on 2017/10/28.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_ApplyHistoryVC.h"
#import "Fcgo_backDetailView.h"
#import "Fcgo_ApplyHistoryDetailModel.h"
#import "Fcgo_GoodsDetailVC.h"
@interface Fcgo_ApplyHistoryVC ()
@property(nonatomic,strong)Fcgo_backDetailView *backView;
@property (strong,nonatomic)Fcgo_ApplyHistoryDetailModel *model;

@end

@implementation Fcgo_ApplyHistoryVC

- (void)viewDidLoad {
    [super viewDidLoad];
    WEAKSELF(weakSelf)
    [self.navigationView setupBackBtnBlock:^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    }];
    [self.navigationView setupTitleLabelWithTitle:@"退款详情"];
    self.navigationView.isShowLine = 1;
    
    [self setInterface];
    [self reloadRequest];
    // Do any additional setup after loading the view.
}
- (void)showUIData:(BOOL)isShow
{
    [self showNoControl:!isShow titleString:@"网络错误,点击重新加载" imageString:@"ico_no-wifi"];
    self.backView.hidden = !isShow;
}
-(void)reloadRequest{
    if (![Fcgo_Tools isNetworkConnected]) {
        [WSProgressHUD showImage:nil status:@"亲,没联网啊"];
        [self showUIData:NO];
        return;
    }
    WEAKSELF(weakSelf)
    NSMutableDictionary *paremeters =[NSMutableDictionary  dictionary];
    [paremeters setObjectWithNullValidate:weakSelf.applyId forKey:@"afterSaleId"];
    [Fcgo_NetworkManager postRequest:NSFormatHeardMeThodUrl(ServiceLocalTypeOne, ORDERMETHOD, @"afterSaleDetail") parametersContentCommon:paremeters successBlock:^(BOOL success, id responseObject, NSString *msg) {
        if (success) {
            [self showUIData:YES];
            NSDictionary *dic = responseObject[@"data"];            
            _model = [Fcgo_ApplyHistoryDetailModel yy_modelWithDictionary:dic];
           
            _backView.orderAftersaleNo = responseObject[@"data"][@"afterSaleNo"];
            _backView.afterType = responseObject[@"data"][@"afterType"];
            _backView.goodImg = responseObject[@"data"][@"goodImg"];
            
            _backView.model = [Fcgo_ApplyHistoryDetailModel yy_modelWithDictionary:dic];
            _backView.status = _model.status;
        }else{
            [WSProgressHUD showWithStatus:responseObject[@"errorMsg"]];
        }
    } failureBlock:^(NSString *description) {
        
    }];
}
-(void)setInterface{
    _backView = [[[NSBundle mainBundle] loadNibNamed:@"Fcgo_backDetailView" owner:self options:nil] firstObject];
    _backView.frame = self.view.bounds;
    [self.view addSubview:_backView];
    [_backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.and.centerX.equalTo(self.view);
        make.bottom.equalTo(self.view);
        make.top.equalTo(self.view).offset(kNavigationHeight);
    }];
    [_backView.View3AgainBtn addTarget:self action:@selector(buyAgain) forControlEvents:UIControlEventTouchUpInside];
}
-(void)buyAgain{
    Fcgo_GoodsDetailVC *vc = [[Fcgo_GoodsDetailVC alloc]init];
    //        vc.hidesBottomBarWhenPushed = 1;
    if (![_model.goodsType isEqualToString:@"normal"]) {
        vc.goodsValue = [NSString stringWithFormat:@"%@",_model.gskuId];
    }else{
        vc.goodsValue = [NSString stringWithFormat:@"%@",_model.goodsId];
    }
    vc.goodsType = _model.goodsType;
    [self.navigationController pushViewController:vc animated:YES];
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
