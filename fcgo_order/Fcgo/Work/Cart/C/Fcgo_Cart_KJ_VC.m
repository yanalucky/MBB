//
//  Fcgo_Cart_KJ_VC.m
//  Fcgo
//
//  Created by huafanxiao on 2017/5/22.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_Cart_KJ_VC.h"
#import "ShopCartNoneView.h"
#import "ShopCartKJAndHWView.h"
#import "Fcgo_HomeGoodsModel.h"
#import "Fcgo_CartModel.h"

#import "Fcgo_GoodsDetailVC.h"
#import "Fcgo_OrderConfirmVC.h"

@interface Fcgo_Cart_KJ_VC ()

@property (nonatomic,strong) ShopCartNoneView    *noneview;
@property (nonatomic,strong) ShopCartKJAndHWView *kjAndHWView;

@property (nonatomic,strong) NSMutableArray   *intetalCartArray;
@property (nonatomic,strong) NSMutableArray   *normalCartArray;


@end

@implementation Fcgo_Cart_KJ_VC

- (void)noNetwork:(BOOL)isShow
{
    self.kjAndHWView.hidden = isShow;
    [self showNoControl:isShow titleString:@"网络错误,点击重新加载" imageString:@"ico_no-wifi"];
    self.noneview.hidden = 1;
    [self.kjAndHWView.tableview.mj_header endRefreshing];
    [self.noneview.collectionview.mj_header endRefreshing];
}

- (void)reloadRequest
{
    if (self.refreshBlock) {
        self.refreshBlock();
    }
}


-(void)setBondedDict:(NSDictionary *)bondedDict
{
    _bondedDict = bondedDict;
    //结束刷新
    [self.kjAndHWView.tableview.mj_header endRefreshing];
    [self.noneview.collectionview.mj_header endRefreshing];
    if (!bondedDict) {
        return;
    }
    [self.intetalCartArray removeAllObjects];
    [self.normalCartArray removeAllObjects];
    
    
    NSArray *normalArray = bondedDict[@"normal"];
    NSArray *intetalArray = bondedDict[@"intetal"];
    
    for (int i = 0; i < normalArray.count; i ++) {
        NSDictionary *normalModelDict = normalArray[i];
        Fcgo_CartModel *model = [Fcgo_CartModel yy_modelWithDictionary:normalModelDict];
        model.select = YES;
        model.number = model.num.intValue;
        [self.normalCartArray addObject:model];
    }
    
    for (int i = 0; i < intetalArray.count; i ++) {
        NSDictionary *intetalModelDict = intetalArray[i];
        Fcgo_CartModel *model = [Fcgo_CartModel yy_modelWithDictionary:intetalModelDict];
        model.select = YES;
        model.number = model.num.intValue;
        [self.intetalCartArray addObject:model];
    }
    
    //购物车没商品
    if (self.normalCartArray.count <= 0 && self.intetalCartArray.count <= 0)  {
        [self.noneview.collectionview scrollsToTop];
        self.noneview.hidden = 0;
        self.kjAndHWView.hidden = 1;
        [self requestNewGoods];
        
    }
    else
    {
        self.noneview.hidden = 1;
        self.kjAndHWView.hidden = 0;
        self.kjAndHWView.cartArray = [NSMutableArray arrayWithObjects:self.intetalCartArray,self.normalCartArray, nil];
    }
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationView.isShowLine = 0;
    [self addViewForNoneView];
    [self addViewForKJAndHWView];
    
    /* 之所以再重走一遍set方法，是因为分页视图这个第三方，默认展示前两个界面，即界面的viewDidLoad先走，数据的set方法后走，可从第三个即以后界面，是数据先赋值，在走viewdidload,这样就没有视图展示了，所以重走一次set方法*/
    if (self.bondedDict) {
        [self setBondedDict:self.bondedDict];
    }
}

- (void)addViewForNoneView
{
    WEAKSELF(weakSelf);
    ShopCartNoneView *noneview;
    if (self.isNotTabbar) {
        noneview = [[ShopCartNoneView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, KScreenHeight - 64-44)];
    }
    else{
        noneview = [[ShopCartNoneView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, KScreenHeight - 64-49-44)];
    }
    
    noneview.goToVisit = ^{
        weakSelf.tabBarController.selectedIndex = 0;
        UINavigationController *nav = [weakSelf.tabBarController selectedViewController];
        [nav popToRootViewControllerAnimated:YES];
    };
    noneview.selectItemBlock = ^(Fcgo_HomeGoodsModel *model)
    {
        Fcgo_GoodsDetailVC *vc = [[Fcgo_GoodsDetailVC alloc]init];
        vc.hidesBottomBarWhenPushed = 1;
        vc.goodsType = @"normal";
        vc.goodsValue = [NSString stringWithFormat:@"%@",model.f_goods_id];
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
    //上拉刷新v
    noneview.refreshBlock = ^{
        if (weakSelf.refreshBlock) {
            weakSelf.refreshBlock();
        }
    };
    noneview.hidden = 1;
    [self.view addSubview:self.noneview = noneview];
}

- (void)addViewForKJAndHWView
{
    WEAKSELF(weakSelf);
    
    ShopCartKJAndHWView *kjAndHWView;
    if (self.isNotTabbar) {
        kjAndHWView = [[ShopCartKJAndHWView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, KScreenHeight - 64-44)];
    }
    else{
        kjAndHWView = [[ShopCartKJAndHWView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, KScreenHeight - 64-49-44)];
    }
    
    //上拉刷新
    kjAndHWView.refreshBlock = ^{
        if (weakSelf.refreshBlock) {
            weakSelf.refreshBlock();
        }
    };
    kjAndHWView.selectItemBlock = ^(Fcgo_CartModel *model){
        Fcgo_GoodsDetailVC *vc = [[Fcgo_GoodsDetailVC alloc]init];
        vc.hidesBottomBarWhenPushed = 1;
        if (![model.goodsType isEqualToString:@"normal"]) {
            vc.goodsValue = [NSString stringWithFormat:@"%@",model.goodsValue];
        }else{
            vc.goodsValue = [NSString stringWithFormat:@"%@",model.goodsId];
        }
        vc.goodsType = model.goodsType;
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
    
    kjAndHWView.buyBlock = ^(Fcgo_CartModel *model){
        //下单
        [weakSelf buyWithModel:model];
    };
    kjAndHWView.alpha = 1;
    [self.view addSubview:self.kjAndHWView = kjAndHWView];
}
- (void)buyWithModel:(Fcgo_CartModel *)model
{
    [WSProgressHUD showImage:nil status:@"根据规定:跨境和海外商品单次下单商品数量限制为1"];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self prepareWithModel:model];
    });
}

- (void)prepareWithModel:(Fcgo_CartModel *)model
{
    NSMutableDictionary   *paremtes = [NSMutableDictionary dictionary];
    NSMutableArray *goodsArray = [NSMutableArray array];
    
    NSInteger count = 1;
    if (model.texe.intValue == 2|| model.texe.intValue == 3)
    {
        count = 1;
    }
    else{
        count = model.number;
    }
    NSDictionary *dict = @{@"goodsNumber":[NSString stringWithFormat:@"%ld",(long)count],
                           @"goodsType":model.goodsType,
                           @"goodsValue":[NSString stringWithFormat:@"%@",model.goodsValue],
                           };
    [goodsArray addObject:dict];
    
    NSString *jsonStr=[Fcgo_publicNetworkTools arrayToJson:goodsArray];
    [paremtes  setObjectWithNullValidate:jsonStr forKey:@"goods"];
    [paremtes setObjectWithNullValidate:self.selectedAddressModel.addressArea forKey:@"area"];
    WEAKSELF(weakSelf);
    [WSProgressHUD showWithStatus:@"订单确认中" maskType:WSProgressHUDMaskTypeClear];
    [Fcgo_NetworkManager postRequest:NSFormatHeardMeThodUrl(ServiceLocalTypeOne, ORDERMETHOD, @"prepare") parametersContentCommon:paremtes successBlock:^(BOOL success, id responseObject, NSString *msg) {
        //NSLog(@">>>>>>>%@",responseObject);
        if (success) {
            
            NSDictionary *data = responseObject[@"data"];
            Fcgo_OrderBuyModel *model = [Fcgo_OrderBuyModel yy_modelWithDictionary:data];
            Fcgo_OrderConfirmVC *vc = [[Fcgo_OrderConfirmVC alloc]init];
            vc.model = model;
            vc.paremtes = paremtes;
            vc.selectedAdressModel = weakSelf.selectedAddressModel;
            vc.hidesBottomBarWhenPushed = 1;
            [weakSelf.navigationController pushViewController:vc animated:1];
            
        }
        
    } failureBlock:^(NSString *description) {
        [weakSelf.kjAndHWView.tableview.mj_header endRefreshing];
        [weakSelf.noneview.collectionview.mj_header endRefreshing];
    }];
}

//- (void)hasMakeOrderReturnRefresh
//{
//    [self.kjAndHWView.tableview.mj_header beginRefreshing];
//}

-(void)requestNewGoods
{
    WEAKSELF(weakSelf);
    NSMutableDictionary *mutaDict=[[NSMutableDictionary alloc]init];
    [mutaDict setObjectWithNullValidate:@1 forKey:@"page"];
    [mutaDict setObjectWithNullValidate:@12 forKey:@"rows"];
    
    [Fcgo_NetworkManager postRequest:NSFormatHeardMeThodUrl(ServiceLocalTypeOne, GOODMETHOD, @"goodsScanlist")
                          parametersContentCommon:mutaDict successBlock:^(BOOL success, id responseObject, NSString *msg)
     {
         
         
         if (success) {
             NSNumber *errCode = responseObject[@"errCode"];
             if (errCode.intValue == 0) {
                 NSArray *dataArray = responseObject[@"data"];
                 NSMutableArray *newsArray = [NSMutableArray array];
                 
                 for (int i=0; i<dataArray.count; i++) {
                     NSDictionary *goodsDict = dataArray[i];
                     Fcgo_HomeGoodsModel *model = [Fcgo_HomeGoodsModel yy_modelWithDictionary:goodsDict];
                     [newsArray addObject:model];
                 }
                 weakSelf.noneview.goodsNewArray = newsArray;
             }
         }
     } failureBlock:^(NSString *description) {
         
         
     }];
}

- (NSMutableArray *)intetalCartArray
{
    if (!_intetalCartArray) {
        _intetalCartArray = [[NSMutableArray alloc]init];
    }
    return _intetalCartArray;
}

- (NSMutableArray *)normalCartArray
{
    if (!_normalCartArray) {
        _normalCartArray = [[NSMutableArray alloc]init];
    }
    return _normalCartArray;
}
@end

