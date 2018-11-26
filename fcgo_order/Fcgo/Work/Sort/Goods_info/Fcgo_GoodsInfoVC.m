//
//  Fcgo_GoodsInfoVC.m
//  Fcgo
//
//  Created by huafanxiao on 2017/12/25.
//  Copyright © 2017年 Fcg. All rights reserved.
//

#import "Fcgo_GoodsInfoVC.h"
#import "Fcgo_GoodsInfoNavigationView.h"
#import "Fcgo_GoodsInfoLazyViewModel.h"
#import "Fcgo_GoodsInfoBottomView.h"
#import "Fcgo_GoodsInfoRequestViewModel.h"
#import "Fcgo_AddressView.h"
#import "Fcgo_GoodsInfoSkuView.h"
#import "Fcgo_GoodsInfoHeaderTimeView.h"

#import "Fcgo_GoodsInfo_goodsmsgCell.h"
#import "Fcgo_GoodsInfo_selectedCell.h"
#import "Fcgo_GoodsInfo_activityCell.h"
#import "Fcgo_GoodsInfo_brandCell.h"

#import "Fcgo_CartOfAddVC.h"
#import "Fcgo_FromHomeWebVC.h"
#import "Fcgo_GoodsListVC.h"
#import "Fcgo_AddNewAdressVC.h"

#import "Fcgo_OrderBuyModel.h"
#import "Fcgo_OrderConfirmVC.h"
#import "Fcgo_MsgVC.h"
#import "Fcgo_CollectVC.h"
#import "Fcgo_GoodsListVC.h"
#import "Fcgo_ContactServiceVC.h"

@interface Fcgo_GoodsInfoVC ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,UIWebViewDelegate,SDCycleScrollViewDelegate,JMDropMenuDelegate>

@property (nonatomic,strong) Fcgo_GoodsInfoNavigationView *navigation_view;
@property (nonatomic,strong) UITableView *table;
@property (nonatomic,strong) FDDemoScrollView  *h_scrollView;//横向
@property (nonatomic,strong) UIScrollView      *v_scrollView; //竖向
@property (nonatomic,strong) UIWebView         *h_webView;
@property (nonatomic,strong) UIWebView         *v_webView;
@property (nonatomic,strong) SDCycleScrollView *bgCycleView;
@property (nonatomic,strong) SDCycleScrollView *tableCycleView;
@property (nonatomic,strong) Fcgo_GoodsInfoBottomView *bottomView;
@property (nonatomic,strong) Fcgo_AddressView  *addressView;

@property (nonatomic,strong) Fcgo_GoodsInfoMsgModel *infoModel;
@property (nonatomic,strong) Fcgo_GoodsSkuModel *skuModel;
@property (nonatomic,strong) NSMutableArray *selectedPropertyArray;//选中的属性

@property (nonatomic,strong) Fcgo_AddressModel *selectedAddressModel;
@property (nonatomic,strong) Fcgo_GoodsInfoSkuView *skuView;
@property (nonatomic,assign) NSInteger selectedCount;
//@property (nonatomic,strong)
@end

@implementation Fcgo_GoodsInfoVC

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self loadShopCarNumRequest];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //[[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(refreshLessTime) name:@"countdown" object:nil];
    [self setupUI];
    [self loadRequest];
}

#pragma mark loadRequest

- (void)loadRequest
{
    WEAKSELF(weakSelf)
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_async(group, dispatch_get_global_queue(0, 0), ^{
        dispatch_group_enter(group);
        [weakSelf loadAddressRequest:^{
            dispatch_group_leave(group);
            dispatch_group_enter(group);
            [weakSelf loadSkuRequest:^{
                dispatch_group_leave(group);
            }];
        }];
        dispatch_group_enter(group);
        [weakSelf loadGoodsBasicMsgRequest:^{
            dispatch_group_leave(group);
            dispatch_group_enter(group);
            [weakSelf loadIsCollectRequest:^{
                dispatch_group_leave(group);
            }];
        }];
    });
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        
        STRONGSELF(strongSelf)
        strongSelf.skuView.infoModel = strongSelf.infoModel;
        strongSelf.bottomView.infoModel = strongSelf.infoModel;
        strongSelf.skuView.skuModel = strongSelf.skuModel;
        strongSelf.bottomView.skuModel = strongSelf.skuModel;
        [self.table reloadData];
    });
}

- (void)reloadRequest
{
    WEAKSELF(weakSelf)
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_async(group, dispatch_get_global_queue(0, 0), ^{
        dispatch_group_enter(group);
        [weakSelf loadSkuRequest:^{
            dispatch_group_leave(group);
        }];
        dispatch_group_enter(group);
        [weakSelf loadGoodsBasicMsgRequest:^{
            dispatch_group_leave(group);
        }];
    });
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        STRONGSELF(strongSelf)
        strongSelf.skuView.infoModel = strongSelf.infoModel;
        strongSelf.bottomView.infoModel = strongSelf.infoModel;
        strongSelf.skuView.skuModel = strongSelf.skuModel;
        strongSelf.bottomView.skuModel = strongSelf.skuModel;
        [self.table reloadData];
    });
}
         
- (void)loadGoodsBasicMsgRequest:(void(^)(void))block
{
    WEAKSELF(weakSelf)
    [Fcgo_GoodsInfoRequestViewModel requestGoodsBasicMsgWithGoodsValue:[NSNumber numberWithInteger:self.goodsValue.integerValue] goodsType:self.goodsType success:^(Fcgo_GoodsInfoMsgModel *infoModel) {
        STRONGSELF(strongSelf)
        strongSelf.infoModel = infoModel;
        strongSelf.infoModel.goodsType = strongSelf.goodsType;
        //用于验证整点抢的商品的id,如整点抢商品进入，在收藏接口我们需要传入goodsid,故只能从goods_detail返回数据获得，故在此调用收藏接口
        [strongSelf reloadGoodsInfoUI];
        [strongSelf.table reloadData];
        !block?:block();
    } fail:^(NSString *error) {
        [WSProgressHUD showImage:nil status:error];
        !block?:block();
    }];
}

- (void)loadAddressRequest:(void(^)(void))block
{
    WEAKSELF(weakSelf)
    [Fcgo_GoodsInfoRequestViewModel requestStoreAddressListSuccess:^(NSMutableArray *addressListArray) {
        STRONGSELF(strongSelf)
        strongSelf.selectedAddressModel = nil;
        for (Fcgo_AddressModel *model in addressListArray) {
            if ([model.deFault integerValue] == 1) {
                strongSelf.selectedAddressModel = model;
            }
        }
        if (!strongSelf.selectedAddressModel) {
            strongSelf.selectedAddressModel = addressListArray[0];
        }
        strongSelf.addressView.dataArray = addressListArray;
        [strongSelf.table reloadData];
        !block?:block();
    } fail:^(NSString *error) {
        [WSProgressHUD showImage:nil status:error];
        !block?:block();
    }];
}

- (void)reloadGoodsInfoUI
{
    //        status.intValue == 2 活动结束
    //        status.intValue == 1 活动进行
    //        status.intValue == 0 活动未开始
    if([self.infoModel.activityModel.status integerValue] == 0)
    {
        
    }
    
    else if ([self.infoModel.activityModel.status integerValue] == 1)
    {
        
    }
    else if ([self.infoModel.activityModel.status integerValue] == 2)
    {
//        self.navigationView.alphaImageView.image = [UIImage imageNamed:@""];
//        self.navigationView.isShowWhiteTitle = 0;
//        self.navigation_view.subviewsColor = UIFontMainGrayColor;
//        self.navigationView.isShowLine = 1;
//        self.navigationView.bgAlpha = 1;
    }
    
    [self.h_webView loadHTMLString:self.infoModel.f_html_content baseURL:nil];
    [self.v_webView loadHTMLString:self.infoModel.f_html_content baseURL:nil];
    self.bgCycleView.imageURLStringsGroup = self.infoModel.picUrl;
    
    NSMutableArray *table_picurlsArray = [NSMutableArray arrayWithCapacity:self.infoModel.picUrl.count];
    for (int i = 0; i < self.infoModel.picUrl.count; i++) {
        [table_picurlsArray addObject:@""];
    }
    self.tableCycleView.imageURLStringsGroup = table_picurlsArray;
}

- (void)loadSkuRequest:(void(^)(void))block
{
    WEAKSELF(weakSelf)
    [Fcgo_GoodsInfoRequestViewModel requestGoodsSKUMsgWithGoodsValue:[NSNumber numberWithInteger:self.goodsValue.integerValue] goodsType:self.goodsType saveAttrsArray:self.selectedPropertyArray infoModel:self.infoModel addressModel:self.selectedAddressModel success:^(Fcgo_GoodsSkuModel *skuModel, NSMutableArray *selectedPropertyArray) {
        STRONGSELF(strongSelf)
        strongSelf.skuModel = skuModel;
        strongSelf.skuModel.goodsType = strongSelf.goodsType;
        strongSelf.selectedPropertyArray = selectedPropertyArray;
        [strongSelf.table reloadData];
        !block?:block();
    } fail:^(NSString *error) {
        [WSProgressHUD showImage:nil status:error];
        !block?:block();
    }];
}

- (void)loadIsCollectRequest:(void(^)(void))block
{
    WEAKSELF(weakSelf)
    [Fcgo_GoodsInfoRequestViewModel requestCollectWithGoodsID:self.infoModel.goods_id success:^(BOOL isCollect) {
        weakSelf.bottomView.collect = isCollect;
        !block?:block();
    } fail:^(NSString *error) {
        [WSProgressHUD showImage:nil status:error];
        !block?:block();
    }];
}

- (void)loadShopCarNumRequest
{
    WEAKSELF(weakSelf)
    [Fcgo_GoodsInfoRequestViewModel requestGoodsCarNumSuccess:^(NSNumber *cartNum) {
         weakSelf.bottomView.cartCount = cartNum.integerValue;
    } fail:^(NSString *error) {
        [WSProgressHUD showImage:nil status:error];
    }];
}

#pragma mark setupUI 基本UI设置

- (void)setupUI;
{
    [self setupNavigationView];
    [self setupMainSubviewsUI];
}
#pragma mark setupUI 导航条设置
- (void)setupNavigationView
{
    WEAKSELF(weakSelf)
    [self.navigationView setupBackBtnBlock:^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    }];
    [self.navigationView setupMoreBtnBlock:^{
        
        NSArray *titleArray = @[@"消息",@"首页",@"我的收藏",@"联系我们"];
        NSArray *imageArray = @[@"icon_white_msg",@"icon_home",@"icon_white_love",@"icon_kefu"];
        [JMDropMenu showDropMenuFrame:CGRectMake(self.view.frame.size.width - 128, 64, 120, 168) ArrowOffset:102.f TitleArr:titleArray ImageArr:imageArray Type:JMDropMenuTypeQQ LayoutType:JMDropMenuLayoutTypeNormal RowHeight:40.f Delegate:self];
    }];
    [self.navigationView addSubview:self.navigation_view = [Fcgo_GoodsInfoLazyViewModel navigation_view]];
    self.navigation_view.selectedGoodsTypeBlock = ^(GoodsInfoSelectedNavigationButtonType selectedType) {
        if (selectedType == SelectedGoodsMsgType)
        {
            [weakSelf.h_scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
        }
        else if (selectedType == SelectedGoodsDetailType)
        {
            [weakSelf.h_scrollView setContentOffset:CGPointMake(kScreenWidth, 0) animated:YES];
        }
    };
    [self setupNavigationStatus];
}

#pragma mark - JMDropMenu delegate
- (void)didSelectRowAtIndex:(NSInteger)index Title:(NSString *)title Image:(NSString *)image {
    Fcgo_BasicVC *vc;
    if (index == 0)
    {
        vc = [[Fcgo_MsgVC alloc]init];
    }
    else if (index == 1)
    {
        // 必须放在前面，先选择，再pop，否则因为执行顺序会发生BUG
        Fcgo_Delegate.tabVC.selectedIndex = 0;
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    else if (index == 2)
    {
        WEAKSELF(weakSelf)
        Fcgo_CollectVC *collectVC = [[Fcgo_CollectVC alloc]init];
        collectVC.cancelBlock = ^(NSString *goodsId,BOOL isAllCancel){
            STRONGSELF(strongSelf)
            if (isAllCancel) {
                strongSelf.bottomView.collect = false;
            }else{
                if ([[NSNumber numberWithInteger:goodsId.integerValue] isEqualToNumber:strongSelf.infoModel.goods_id]) {
                    strongSelf.bottomView.collect = false;
                }
            }
        };
        vc = collectVC;
    }
    else if (index == 3)
    {
        vc = [[Fcgo_ContactServiceVC alloc]init];
    }
    if (!vc) return;
    vc.hidesBottomBarWhenPushed =  YES;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - SDCycleScrollViewDelegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    if (self.infoModel && self.infoModel.picUrl) {
        //利用XLImageViewer显示本地图片
        [[XLImageViewer shareInstanse]  showNetImages:self.infoModel.picUrl index:index fromImageContainer:self.bgCycleView.mainView];
    }
}

#pragma mark scrollview delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.tag == 500) {
        CGFloat scroll_x = scrollView.contentOffset.x;
        self.navigation_view.scroll_x = scroll_x;
    }
    else if (scrollView.tag == 503) {
        CGFloat scroll_y = scrollView.contentOffset.y;
        self.bgCycleView.frame = CGRectMake(0, kNavigationHeight-((kNavigationHeight+scroll_y)*0.5), kScreenWidth, kScreenWidth);
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (scrollView.tag == 503) {
        CGFloat scroll_height = KScreenHeight;
        CGFloat offset_y = scrollView.contentOffset.y+kNavigationHeight;
        CGFloat size_height = scrollView.contentSize.height;
        if (offset_y+scroll_height-size_height>180) {
            [self.v_scrollView setContentOffset:CGPointMake(0, KScreenHeight) animated:YES];
            self.navigation_view.scrollPage = true;
        }
    }
}

#pragma mark setupUI 导航条界面状态设置
- (void)setupNavigationStatus
{
//    if (![self.goodsType isEqualToString:@"normal"]) {
//        self.navigationView.alphaImageView.image = [UIImage imageWithName:@"integral_goodsdetail" ofType:@"png"];
//        self.navigationView.isShowWhiteTitle = 1;
//        self.navigation_view.subviewsColor = UIFontWhiteColor;
//        self.navigationView.isShowLine = 0;
//    }else{
//        self.navigationView.bgAlpha = 1;
//    }
    self.navigationView.bgAlpha = 1;
}

- (void)setupMainSubviewsUI
{
    WEAKSELF(weakSelf)
    self.h_scrollView = [Fcgo_GoodsInfoLazyViewModel h_scrollViewWithDeledateVC:self];
    self.h_scrollView.tag = 500;
    self.v_scrollView = [Fcgo_GoodsInfoLazyViewModel v_scrollViewWithDeledateVC:self];
    self.v_scrollView.tag = 501;
    self.h_webView    = [Fcgo_GoodsInfoLazyViewModel h_webView];
    self.v_webView    = [Fcgo_GoodsInfoLazyViewModel v_webView];
    self.table        = [Fcgo_GoodsInfoLazyViewModel tableWithDeledateVC:self];
    self.table.tag = 503;
    [self registTableCell];
    self.tableCycleView = [Fcgo_GoodsInfoLazyViewModel cycleViewWithDeledateVC:self];
    self.tableCycleView.mainView.tag = 504;
    self.tableCycleView.observeBlock = ^(CGFloat offsetX){
        [weakSelf.bgCycleView.mainView setContentOffset:CGPointMake(offsetX, 0)];
    };
    self.table.tableHeaderView = self.tableCycleView;
    self.bgCycleView.mainView.tag = 505;
    
    MJRefreshNormalHeader * header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        STRONGSELF(strongSelf)
        [strongSelf.v_webView.scrollView.mj_header  endRefreshing];
        strongSelf.navigation_view.scrollPage = false;
        [strongSelf.v_scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    }];
    header.arrowView.alpha = 0;
    header.lastUpdatedTimeLabel.hidden = YES;
    [header setTitle:@"下拉回到商品详情" forState:1];
    [header setTitle:@"释放回到商品详情" forState:2];
    [header setTitle:@"" forState:3];
    self.v_webView.scrollView.mj_header = header;
    
    [self.view insertSubview:self.v_scrollView belowSubview:self.navigationView];
    [self.v_scrollView addSubview:self.h_scrollView];
    [self.v_scrollView addSubview:self.v_webView];
    
    [self.h_scrollView addSubview:self.bgCycleView];
    [self.h_scrollView addSubview:self.table];
    [self.h_scrollView addSubview:self.h_webView];
    
    [self.view addSubview:self.bottomView];
    [self dealBottomViewSelectedMeth];
    [self.view addSubview:self.addressView];
    [[UIApplication sharedApplication].keyWindow addSubview:self.skuView];
    [self dealSkuViewSelectedMeth];
}

- (void)registTableCell
{
    [self.table registerNib:[UINib nibWithNibName:NSStringFromClass([Fcgo_GoodsInfo_goodsmsgCell class]) bundle:nil] forCellReuseIdentifier:@"goodsInfo_goodsmsgCell"];
    [self.table registerNib:[UINib nibWithNibName:NSStringFromClass([Fcgo_GoodsInfo_selectedCell class]) bundle:nil] forCellReuseIdentifier:@"goodsInfo_selectedCell"];
    [self.table registerNib:[UINib nibWithNibName:NSStringFromClass([Fcgo_GoodsInfo_activityCell class]) bundle:nil] forCellReuseIdentifier:@"goodsInfo_activityCell"];
    [self.table registerNib:[UINib nibWithNibName:NSStringFromClass([Fcgo_GoodsInfo_brandCell class]) bundle:nil] forCellReuseIdentifier:@"goodsInfo_brandCell"];
    [self.table registerClass:[Fcgo_GoodsInfoHeaderTimeView class] forHeaderFooterViewReuseIdentifier:@"goodsInfoHeaderTimeView"];
}

- (void)dealBottomViewSelectedMeth
{
    WEAKSELF(weakSelf)
    self.bottomView.selectedTypeBlock = ^(GoodsInfoBottomViewSelectedType selectedType, BOOL isSelect) {
        STRONGSELF(strongSelf)
        switch (selectedType) {
            case GoodsInfoBottomViewSelectedCollectType:
                {
                    if (!strongSelf.infoModel) {
                        [WSProgressHUD showImage:nil status:@"暂无商品信息,请稍后再试"];
                    }else{
                        //选择收藏
                        if(isSelect)
                        {
                            [Fcgo_GoodsInfoRequestViewModel requestAddCollectInfoModel:strongSelf.infoModel success:^{
                                [WSProgressHUD showImage:nil status:@"收藏成功"];
                                [strongSelf.bottomView collectAnimation];
                            } fail:^(NSString *error) {
                                [WSProgressHUD showImage:nil status:error];
                            }];
                        }
                        //取消收藏
                        else
                        {
                            [Fcgo_GoodsInfoRequestViewModel requestCancelCollectinfoModel:strongSelf.infoModel success:^{
                                [WSProgressHUD showImage:nil status:@"取消成功"];
                                [strongSelf.bottomView collectAnimation];
                            } fail:^(NSString *error) {
                                [WSProgressHUD showImage:nil status:error];
                            }];
                        }
                    }
                }
                break;
            case GoodsInfoBottomViewSelectedPushCartType:
                {
                    Fcgo_CartOfAddVC *cartVC = [[Fcgo_CartOfAddVC alloc] init];
                    cartVC.isNotTabbar = YES;
                    cartVC.hidesBottomBarWhenPushed = 1;
                    [weakSelf.navigationController pushViewController:cartVC animated:YES];
                }
                break;
            case GoodsInfoBottomViewSelectedAddCartType:
                {
                    [strongSelf.skuView showWithType:SkuViewAddCartType];
                }
                break;
            case GoodsInfoBottomViewSelectedBuyType:
                {
                    [strongSelf.skuView showWithType:SkuViewBuyType];
                }
                break;
            case GoodsInfoBottomViewSelectedAddressType:
                {
                    [strongSelf.addressView show];
                }
                break;
            default:
                break;
        }
    };
}

- (void)dealSkuViewSelectedMeth
{
    WEAKSELF(weakSelf)
    self.skuView.selectedCountBlock = ^(NSInteger count) {
        weakSelf.selectedCount = count;
    };
    self.skuView.buyBlock = ^{
        [weakSelf addCartOrBuyWithWay:1];
    };
    self.skuView.addCartBlock = ^{
        [weakSelf addCartOrBuyWithWay:0];
    };
    self.skuView.lowerBlock = ^{
        weakSelf.infoModel.isLowerPrice = @1;
        [WSProgressHUD showWithStatus:@"加载中..." maskType:WSProgressHUDMaskTypeDefault];
        [weakSelf loadSkuRequest:^{
            weakSelf.skuView.skuModel = weakSelf.skuModel;
            weakSelf.bottomView.skuModel = weakSelf.skuModel;
        }];
    };
    self.skuView.selectedPropertyBlock = ^(NSString *attr, NSString *property, BOOL isSelected, NSInteger count) {
        STRONGSELF(strongSelf)
        strongSelf.infoModel.isLowerPrice = @0;
        strongSelf.selectedCount = count;
        BOOL isSame = NO;
        for (int i = 0; i < strongSelf.selectedPropertyArray.count; i ++) {
            NSDictionary *dict = strongSelf.selectedPropertyArray[i];
            NSString *attr_name_t = dict[@"properties_name"];
            NSString *property_name = dict[@"attr_name"];
            if ([attr_name_t isEqualToString:attr]) {
                isSame = YES;
                if (isSelected) {
                    if (![property isEqualToString:property_name]) {
                        [strongSelf.selectedPropertyArray removeObject:dict];
                        NSDictionary *addDict = @{@"properties_name":attr,@"attr_name":property};
                        [strongSelf.selectedPropertyArray addObject:addDict];
                    }
                }
                else
                {
                    if ([property_name isEqualToString:property]) {
                        [strongSelf.selectedPropertyArray removeObject:dict];
                    }
                }
            }
        }
        if (isSame == NO) {
            NSDictionary *addDict = @{@"properties_name":attr,@"attr_name":property};
            [strongSelf.selectedPropertyArray addObject:addDict];
        }
        [WSProgressHUD showWithStatus:@"加载中..." maskType:WSProgressHUDMaskTypeDefault];
        [strongSelf loadSkuRequest:^{
            strongSelf.skuView.skuModel = strongSelf.skuModel;
            strongSelf.bottomView.skuModel = strongSelf.skuModel;
        }];
    };
    self.skuView.reloadBlock = ^{
        [weakSelf reloadRequest];
    };
}

- (void)addCartOrBuyWithWay:(NSInteger)type
{
    //type 0 是加入购物车，1是结算
    if (!self.infoModel || !self.skuModel) {
        [WSProgressHUD showImage:nil status:@"数据错误"];
        return;
    }
    NSString *goodsType = self.infoModel.goodsType;
    if ([goodsType isEqualToString:@"integral"]) {
        //整点抢的商品过时
        if (self.infoModel.activityModel.status.integerValue == 2) {
            goodsType = @"normal";
        }
    }
    
    NSString *goodsValue;
    if(![goodsType isEqualToString:@"normal"])
    {
        goodsValue = self.goodsValue;
    }
    else{
        goodsValue = self.skuModel.skuid;
    }
    
    NSInteger goodsNumber;
    if(self.infoModel.texes.intValue == 2|| self.infoModel.texes.intValue == 3)
    {
        goodsNumber = 1;
    }
    else{
        goodsNumber = !self.selectedCount?1:self.selectedCount;
    }
    
    NSMutableDictionary   *paremtes = [NSMutableDictionary dictionary];
    NSString              *urlString;
    if (type == 0) {
        [paremtes setObjectWithNullValidate:goodsValue forKey:@"goodsValue"];
        [paremtes setObjectWithNullValidate:goodsType forKey:@"goodsType"];
        [paremtes setObjectWithNullValidate:[NSNumber numberWithInteger:goodsNumber] forKey:@"goodsNumber"];
        [paremtes setObjectWithNullValidate:self.infoModel.goods_id forKey:@"goodsId"];
        [paremtes setObjectWithNullValidate:self.skuModel.skuid forKey:@"goodsGskuId"];
        urlString = NSFormatHeardMeThodUrl(ServiceLocalTypeOne, SHOPCARMETHOD, @"addShopCar");
        [self prepareWithUrl:urlString parameters:paremtes];
    }
    else if (type == 1)
    {
        NSArray *array = @[@{@"goodsNumber":[NSNumber numberWithInteger:goodsNumber],
                             @"goodsType":goodsType,
                             @"goodsValue":goodsValue,
                             }
                           ];
        NSString *jsonStr=[Fcgo_publicNetworkTools arrayToJson:array];
        [paremtes  setObjectWithNullValidate:jsonStr forKey:@"goods"];
        [paremtes setObjectWithNullValidate:self.selectedAddressModel.addressArea forKey:@"area"];
        urlString = NSFormatHeardMeThodUrl(ServiceLocalTypeOne, ORDERMETHOD, @"prepare");
        if (self.infoModel.texes.intValue == 2|| self.infoModel.texes.intValue == 3) {
            [WSProgressHUD showImage:nil status:@"根据规定:跨境和海外商品单次下单商品数量限制为1"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self prepareWithUrl:urlString parameters:paremtes];
            });
        }else{
            [self prepareWithUrl:urlString parameters:paremtes];
        }
    }
}

- (void)prepareWithUrl:(NSString *)urlString parameters:(NSMutableDictionary *)paremtes
{
    WEAKSELF(weakSelf);
    [WSProgressHUD showWithStatus:@"加载中..." maskType:WSProgressHUDMaskTypeClear];
    [Fcgo_NetworkManager postRequest:urlString parametersContentCommon:paremtes successBlock:^(BOOL success, id responseObject, NSString *msg) {
        if (success) {
            //[weakSelf.skuView dismiss];
            if ([urlString containsString:@"mch/shopcar/addShopCar"]) {
                    [WSProgressHUD showSuccessWithStatus:@"加入购物车成功"];
                    weakSelf.bottomView.cartCount += 1;
                    [weakSelf.bottomView addCartAnimation];
                }
                else if ([urlString containsString:@"order/prepare"]) {
                    
                    NSDictionary *data = responseObject[@"data"];
                    if (!data) {
                        [WSProgressHUD showImage:nil status:@"没有数据"];
                        return;
                    }
                    weakSelf.skuView.hidden = 1;
                    [weakSelf.skuView dismiss];
                    Fcgo_OrderBuyModel *model = [Fcgo_OrderBuyModel yy_modelWithDictionary:data];
                    Fcgo_OrderConfirmVC *vc = [[Fcgo_OrderConfirmVC alloc]init];
                    vc.model = model;
                    vc.selectedAdressModel = weakSelf.selectedAddressModel;
                    vc.paremtes = paremtes;
                    vc.hidesBottomBarWhenPushed = 1;
                    [weakSelf.navigationController pushViewController:vc animated:1];
                }
            else {
                [WSProgressHUD showWithStatus:responseObject[@"errorMsg"]];
            }
        }
    } failureBlock:^(NSString *description) {}];
}

#pragma mark lazy meth
- (SDCycleScrollView *)bgCycleView
{
    if (!_bgCycleView)
    {
        SDCycleScrollView *cycleView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, kNavigationHeight, kScreenWidth,kScreenWidth) delegate:self placeholderImage:nil];
        cycleView.autoScroll = 0;
        cycleView.pageControlStyle = SDCycleScrollViewPageContolStyleNone;
        cycleView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
        _bgCycleView = cycleView;
    }
    return _bgCycleView;
}

- (Fcgo_GoodsInfoBottomView *)bottomView
{
    if (!_bottomView) {
        Fcgo_GoodsInfoBottomView *bottomView = [[Fcgo_GoodsInfoBottomView alloc]initWithFrame:CGRectMake(0, KScreenHeight - 50, kScreenWidth, 50)];
        //_bottomView.hidden = 1;
        _bottomView = bottomView;
    }
    return _bottomView;
}

- (Fcgo_AddressView *)addressView{
    WEAKSELF(weakSelf)
    if (!_addressView) {
        Fcgo_AddressView *addressView =[[Fcgo_AddressView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, KScreenHeight) title:@"配送至" isCanAddAddress:YES successBlock:^(Fcgo_AddressModel *model) {
            STRONGSELF(strongSelf)
            [WSProgressHUD showWithStatus:@"加载中..." maskType:WSProgressHUDMaskTypeDefault];
            strongSelf.selectedAddressModel = model;
            strongSelf.infoModel.isLowerPrice = @0;
            [strongSelf.table reloadData];
            [strongSelf loadSkuRequest:^{
                strongSelf.skuView.skuModel = strongSelf.skuModel;
                strongSelf.bottomView.skuModel = strongSelf.skuModel;
            }];
        } cancelBlock:^{}];
        addressView.hidden = YES;
        addressView.addNewAddressBlock = ^{
            Fcgo_AddNewAdressVC *vc = [[Fcgo_AddNewAdressVC alloc]init];
            vc.hidesBottomBarWhenPushed = 1;
            vc.reloadBlock = ^{
                [weakSelf loadAddressRequest:nil];
            };
            [weakSelf.navigationController pushViewController:vc animated:YES];
        };
        _addressView = addressView;
    }
    return _addressView;
}

- (NSMutableArray *)selectedPropertyArray
{
    if (!_selectedPropertyArray)
    {
        _selectedPropertyArray = [[NSMutableArray alloc]init];
    }
    return _selectedPropertyArray;
}

- (Fcgo_GoodsInfoSkuView *)skuView
{
    if (!_skuView) {
        _skuView = [[Fcgo_GoodsInfoSkuView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, KScreenHeight)];
    }
    return _skuView;
}

#pragma mark table meth
#pragma mark table delegate datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger row = 0;
    if (section == 0) {
        row = 1;
    }
    else if (section == 1) {
        row = 1;
    }
    else if (section == 2) {
        if (self.infoModel) {
            row = self.infoModel.activityArray.count;
        }
    }
    else if (section == 3) {
        row = 1;
    }
    return row;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        Fcgo_GoodsInfo_goodsmsgCell *goodsmsgCell = [tableView dequeueReusableCellWithIdentifier:@"goodsInfo_goodsmsgCell"];
        if (self.infoModel) {
            goodsmsgCell.infoModel = self.infoModel;
        }
        if (self.skuModel) {
            goodsmsgCell.skuModel = self.skuModel;
        }
        return goodsmsgCell;
    }
    else if (indexPath.section == 1) {
         Fcgo_GoodsInfo_selectedCell *selectedCell = [tableView dequeueReusableCellWithIdentifier:@"goodsInfo_selectedCell"];
        selectedCell.selectedArray = [self dealSelectedAddressString];
        return selectedCell;
    }
    else if (indexPath.section == 2) {
        Fcgo_GoodsInfo_activityCell *activityCell = [tableView dequeueReusableCellWithIdentifier:@"goodsInfo_activityCell"];
        if (self.infoModel && self.infoModel.activityArray.count>0) {
            Fcgo_ActivityModel *activityModel = self.infoModel.activityArray[indexPath.row];
            activityCell.activityModel = activityModel;
        }
        return activityCell;
    }
    Fcgo_GoodsInfo_brandCell *brandCell = [tableView dequeueReusableCellWithIdentifier:@"goodsInfo_brandCell"];
    if (self.infoModel && self.infoModel.brandModel) {
        brandCell.brandModel = self.infoModel.brandModel;
    }
    return brandCell;
}

- (NSArray *)dealSelectedAddressString
{
    NSString *selectedAddressString  = @"";
    if (self.selectedAddressModel) {
        selectedAddressString = self.selectedAddressModel.addressDetail;
    }
    else{
        selectedAddressString = @"请选择收货地区";
    }
    NSArray *selectedArray = @[@"送至:",selectedAddressString];
    return selectedArray;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (self.infoModel) {
            NSString *str = @"";
            switch (self.infoModel.texes.integerValue) {
                case 1:
                    str = @"[一般贸易] ";
                    break;
                case 2:
                    str = @"[跨境保税] ";
                    break;
                case 3:
                    str = @"[海外直邮] ";
                    break;
                    
                default:
                    break;
            }
            str = [str stringByAppendingString:self.infoModel.goodsName];
            CGFloat height = [str boundingRectWithSize:CGSizeMake(kScreenWidth - 30, 1000) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:UIFontSize(17)} context:nil].size.height;
            if (height>= 30) {
                 return 105 + 22;
            }
        }
        return 105;
    }
    else if (indexPath.section == 1) {
//        if (indexPath.row == 0) {
//            return 50;
//        }
        return 55;
    }
    else if (indexPath.section == 2) {
        return 50;
    }
    return 65;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //WEAKSELF(weakSelf)
    NSInteger section = indexPath.section;
    if (section == 1 ) {
        [self.addressView show];
    }
    else if(section == 2){
        //活动
        if(self.infoModel && self.infoModel.activityArray.count>0)
        {
            Fcgo_ActivityModel *model = self.infoModel.activityArray[indexPath.row];
            if ([model.href containsString:@"app_across"])
            {
                [Fcgo_App_acrossTools app_acrossWithJsonString:model.href webView:nil parentVC:self];
            }
            else if ([model.href containsString:@"html"])
            {
                Fcgo_FromHomeWebVC *fromHomeWebVC = [[Fcgo_FromHomeWebVC alloc]init];
                fromHomeWebVC.hidesBottomBarWhenPushed = 1;
                fromHomeWebVC.urlString = [NSString stringWithFormat:@"%@%@?merId=%@&token=%@",NSServiceShortUrl,model.href,MerId,Token];
                [self.navigationController pushViewController:fromHomeWebVC animated:YES];
            }
        }
    }
    else if(section == 3){
        //品牌
        Fcgo_GoodsListVC *vc = [[Fcgo_GoodsListVC alloc]init];
        vc.hidesBottomBarWhenPushed = 1;
        if (self.infoModel && self.infoModel.brandModel) {
            vc.brandIds = [NSString stringWithFormat:@"%@",self.infoModel.brandModel.brand_id];
            vc.key = @"brand";
        }
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if(!self.infoModel.activityModel.end)
    {
        return nil;
    }
    if(self.infoModel.activityModel.status.integerValue == 2)
    {
        return nil;
    }
    Fcgo_GoodsInfoHeaderTimeView *headerView = [Fcgo_GoodsInfoHeaderTimeView headViewWithTableView:tableView headIdentifier:@"goodsInfoHeaderTimeView"];
    if ( self.infoModel.activityModel.status.integerValue != 2) {
        headerView.infoModel = self.infoModel;
    }
    WEAKSELF(weakSelf)
    headerView.reloadBlock = ^{
        [weakSelf reloadRequest];
    };
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if ((section == 0) && self.infoModel.activityModel.status &&  ( self.infoModel.activityModel.status.integerValue != 2)) {
        return kScreenWidth*148/1242;
    }
    return 0;
}


@end


