//
//  Fcgo_HomeH5VC.m
//  Fcgo
//
//  Created by fcg on 2017/9/22.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_HomeH5VC.h"

#import "Fcgo_HomeWebView.h"

#import "Fcgo_HomeNavView.h"
#import "Fcgo_ScanVC.h"
#import "Fcgo_SearchVC.h"
#import "Fcgo_MsgVC.h"
#import "FLAnimatedImage.h"
#import "FLAnimatedImageView.h"
#import "UMMobClick/MobClick.h"
#import "Fcgo_AddressModel.h"
#import "Fcgo_HomeViewModel.h"
#import "Fcgo_HomeGoodsModel.h"
#import "Fcgo_GoodsDetailVC.h"
#import "HotCollectionCell.h"
#import "Fcgo_HomeCollectionTitleHeaderView.h"

#import "Home_WholePointDetailVC.h"

@interface Fcgo_HomeH5VC ()<UIScrollViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UIWebViewDelegate>
{
    NSTimer *_timer;
    NSTimer *_timer1;
    Fcgo_HomeCollectionTitleHeaderView *titleHeaderView;
    
}

@property (nonatomic,strong) Fcgo_HomeNavView *navView;

@property (nonatomic,strong) Fcgo_HomeWebView *webView;

@property (nonatomic,strong)FLAnimatedImageView *adImgView;
@property (nonatomic,strong) NSMutableArray *adviceListMutableArray;
@property (nonatomic,assign) int page;
@property (nonatomic,strong) UICollectionView *collectionview;
@property(nonatomic,strong)UICollectionViewFlowLayout *flowLayout;


@end

@implementation Fcgo_HomeH5VC

- (void)viewDidLoad {
    [super viewDidLoad];
    if (@available(iOS 11.0,*)) {
        _webView.webView.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    
//    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent];
    //先发送版本跟新
    [Fcgo_publicNetworkTools postRequestViesion];
    
    [self setNavView];
    [self setupCollectionView];
    [self setMainH5View];
    
    [self addObserverForWebViewContentSize];

    
    self.page = 1;
    [self loadAdviceListRequest];
#pragma mark - 地址选择
    [self getDefaultAddress];
    
    // Do any additional setup after loading the view.
}
-(void)getDefaultAddress
{
    
    NSMutableDictionary  *muatble = [NSMutableDictionary dictionary];
    
     [Fcgo_NetworkManager postRequest:NSFormatHeardMeThodUrl(ServiceLocalTypeOne,ADDRESSMETHOD, @"storeAddressList") parametersContentCommon:muatble successBlock:^(BOOL success, id responseObject, NSString *msg)  {
        if (success) {
            NSArray   *listArray = responseObject[@"data"];
            for (int i = 0; i < listArray.count; i ++) {
                NSDictionary *couponDict = listArray[i];
                Fcgo_AddressModel *model = [Fcgo_AddressModel yy_modelWithDictionary:couponDict];
                if (model.deFault.intValue == 1) {
                    NSData *myEncodedObject = [NSKeyedArchiver archivedDataWithRootObject:model];
                    [[NSUserDefaults standardUserDefaults] setObject:myEncodedObject forKey:@"defaultAddress"];
                }
            }
            if (![[NSUserDefaults standardUserDefaults] objectForKey:@"defaultAddress"]) {
                NSDictionary *addressDict = listArray[0];
                Fcgo_AddressModel *model = [Fcgo_AddressModel yy_modelWithDictionary:addressDict];
                NSData *myEncodedObject = [NSKeyedArchiver archivedDataWithRootObject:model];

                //没有默认地址，取第一位
                [[NSUserDefaults standardUserDefaults] setObject:myEncodedObject forKey:@"defaultAddress"];
            }
        }
    } failureBlock:^(NSString *description) {
        
    }];
}

- (void)addObserverForWebViewContentSize{
    
    [self.webView.webView.scrollView addObserver:self forKeyPath:@"contentSize" options:0 context:nil];

}

- (void)removeObserverForWebViewContentSize{
    
    [self.webView.webView.scrollView removeObserver:self forKeyPath:@"contentSize"];
    
}

//以下是监听结果回调事件：

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context

{
//    [self layoutCell];
//    UICollectionViewFlowLayout *flowLayout= [[UICollectionViewFlowLayout alloc]init];
//    flowLayout.minimumInteritemSpacing = 7;
//    flowLayout.minimumLineSpacing = 7;
    
    [self.collectionview reloadData];
    
//    self.flowLayout.headerReferenceSize = CGSizeMake(0, self.webView.webView.scrollView.contentSize.height);
    
//    [self collectionView:self.collectionview layout:flowLayout referenceSizeForHeaderInSection:0];
}

//设置footerView的合理位置
- (void)setupCollectionView
{
//    WEAKSELF(weakSelf)

//    CGSize contentSize = self.webView.webView.scrollView.contentSize;
    UICollectionViewFlowLayout *flowLayout= [[UICollectionViewFlowLayout alloc]init];
    flowLayout.minimumInteritemSpacing = 7;
    flowLayout.minimumLineSpacing = 7;
    CGFloat width = (kScreenWidth - 21)/2;
    CGFloat heig =  width + 75 + 7;
    _collectionview = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, KScreenHeight-kTabBarHeight-kTabBarBottomMargin) collectionViewLayout:flowLayout];
    _collectionview.backgroundColor = UIFontWhiteColor;
    _collectionview.delegate = self;
    _collectionview.dataSource = self;
    _collectionview.hidden = NO;
//    _collectionview.bounces = NO;
//    [_collectionview setScrollEnabled:NO];
    _collectionview.userInteractionEnabled = YES;
    self.flowLayout = flowLayout;
    if (@available(iOS 11.0, *)) {
        _collectionview.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    [self.collectionview registerNib:[UINib nibWithNibName:NSStringFromClass([HotCollectionCell class]) bundle:nil] forCellWithReuseIdentifier:@"hotCollectionCell"];
    [self.collectionview registerClass:[Fcgo_HomeCollectionTitleHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"homeCollectionTitleHeaderView"];

    [self.view addSubview:_collectionview];

    [self.view insertSubview:_collectionview belowSubview:self.navigationView];
    
    self.collectionview.mj_footer = [MJRefreshBackStateFooter footerWithRefreshingBlock:^{
        [self loadAdviceListRequest];
    }];
    
    self.collectionview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
       
        [self reloadRequest];
    }];
//     self.webView.webView.scrollView.contentSize = CGSizeMake(contentSize.width, contentSize.height + _collectionview.bounds.size.height);
    
   

}
- (void)layoutCell{
   

    //取消监听，因为这里会调整contentSize，避免无限递归
    
    [self removeObserverForWebViewContentSize];

    if (_collectionview) {
        [_collectionview removeFromSuperview];
    }
  
    [self setupCollectionView];
    
   
    
    //重新监听
    
    [self addObserverForWebViewContentSize];
    
}



- (NSString *)homeUrl {
    
    //NSLog(@"======%@",[NSString stringWithFormat:@"%@?merId=%@",NSFormatHeardUrl(@"bis/show/index/first-page"),MerId]);
    return [NSString stringWithFormat:@"%@?merId=%@",NSFormatHeardUrl(@"bis/show/index/first-page"),MerId];
}

-(void)reloadRequest{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.webView setUrlString:self.homeUrl];
        [_webView.webView reload];
        [self.collectionview.mj_header endRefreshing];
    });
    
    
}

-(void)loadGoodsListRequest{
    [_webView setUrlString:self.homeUrl];
    [_webView.webView reload];
}


- (void)loadAdviceListRequest
{
    WEAKSELF(weakSelf)
    [Fcgo_HomeViewModel postRequestAdviceListWithPage:self.page success:^(NSMutableArray *mutableArray) {
        STRONGSELF(strongSelf);
        [self showUIData:YES];
        //判断请求回来是否有数据
        if (mutableArray &&mutableArray.count>0) {
            
            [weakSelf.collectionview.mj_footer endRefreshing];
            NSInteger count = strongSelf.adviceListMutableArray.count;
            [mutableArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [strongSelf.adviceListMutableArray addObject:obj];
            }];
            
            
            [strongSelf.collectionview reloadData];
//            [strongSelf.webView layoutIfNeeded];

            weakSelf.page += 1;
//            [_webView.webView.scrollView.mj_header endRefreshing];
//            [_webView.webView.scrollView.mj_footer endRefreshing];
            
            
           
//             self.webView.webView.scrollView.contentOffset = CGPointMake(0, self.webView.webView.scrollView.contentSize.height - 2000);
            

            
        }
        else
        {
            [weakSelf.collectionview.mj_footer endRefreshingWithNoMoreData];
        }
        [weakSelf.collectionview.mj_header endRefreshing];
    } ofFail:^{
        [self showUIData:NO];
        [weakSelf.collectionview.mj_header endRefreshing];
        [weakSelf.collectionview.mj_footer endRefreshing];
//        [_webView.webView.scrollView.mj_header endRefreshing];
//        [_webView.webView.scrollView.mj_footer endRefreshing];
    }];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.tabBarController.tabBar.hidden = NO;
}

- (void)showUIData:(BOOL)isShow
{
    [self showNoControl:!isShow titleString:@"网络错误,点击重新加载" imageString:@"ico_no-wifi"];
}

-(void)setMainH5View{
    
    [self startTimer];
   
    WEAKSELF(weakSelf)
    
    
    _webView = [[Fcgo_HomeWebView alloc] init];
    _webView.frame = CGRectMake(0, 0, kScreenWidth, 20);
    _webView.webView.scrollView.scrollEnabled = NO;
//    _webView.webView.delegate = self;

    [_webView setUrlString:self.homeUrl];
   _webView.webView.scrollView.delegate = self;
    _webView.detailBlock = ^(NSString *urlStr) {
        [weakSelf.webView.webView.scrollView.mj_header endRefreshing];
        [weakSelf.webView.webView.scrollView.mj_footer endRefreshing];
        if (![urlStr containsString:weakSelf.homeUrl]) {
//            Fcgo_HomeH5VC *dvc = [[Fcgo_HomeH5VC alloc] init];
            Fcgo_BasicShowWebViewVC *dvc = [[Fcgo_BasicShowWebViewVC alloc] init];
            dvc.urlString = urlStr;
            BOOL isContent = [urlStr containsString:@"ddhshop.com/"];
            dvc.isShowNavBar = !NO;
            dvc.hidesBottomBarWhenPushed = YES;
            [weakSelf.navigationController pushViewController:dvc animated:YES];   
        }
    };
    _webView.failBlock = ^{
        [weakSelf.webView.webView.scrollView.mj_header endRefreshing];
        [weakSelf.webView.webView.scrollView.mj_footer endRefreshing];
    };

//    [self.view addSubview:_webView];
//    [self.view insertSubview:self.webView belowSubview:self.navigationView];
   
    
//    _webView.webView.scrollView.mj_header = [Fcgo_RefreshNormalHeader headerRefreshBlock:^{
//        [weakSelf reloadRequest];
//    }];
//    _webView.webView.scrollView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
//        [weakSelf loadAdviceListRequest];
//    }];
    
    
    
    //断网防崩溃
    if (![Fcgo_Tools isNetworkConnected]) {
        [WSProgressHUD showImage:nil status:@"亲,没联网啊"];
        [self showUIData:NO];
        return;
    }
}

-(void)setNavView{
    WEAKSELF(weakSelf)
    Fcgo_HomeNavView *navView = [[Fcgo_HomeNavView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kNavigationHeight) ofScan:^{
        Fcgo_ScanVC *scanVC = [[Fcgo_ScanVC alloc]init];
        scanVC.hidesBottomBarWhenPushed = YES;
        [weakSelf.navigationController pushViewController:scanVC animated:YES];
    } ofSearch:^{
        Fcgo_SearchVC *vc = [[Fcgo_SearchVC alloc]init];
        vc.hidesBottomBarWhenPushed = YES;
        [weakSelf.navigationController pushViewController:vc animated:YES];
    } ofMsg:^{
        Fcgo_MsgVC *msgVC = [[Fcgo_MsgVC alloc]init];
        msgVC.hidesBottomBarWhenPushed =  YES;
        [weakSelf.navigationController pushViewController:msgVC animated:YES];
        
    }];
    self.navView = navView;
    [self.navigationView addSubview:navView];
    [self.navigationView bringSubviewToFront:navView];
    self.navigationView.alphaImageView.backgroundColor = UIFontWhiteColor;
    self.navigationView.bgAlpha = 0;
    
    
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat y = scrollView.contentOffset.y;
    CGFloat alpha = y/170;
    if (y<0) {
        self.navView.alpha = 0;
        self.navigationView.isShowLine = 0;
    }else{
        self.navView.alpha = 1;
        
        //self.navigationView.isShowLine = 1;
    }

    if (alpha>0.7) {
        [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleDefault];
    }
    else{
        [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleDefault];
    }

    self.navView.bgAlpha = alpha;
    self.navigationView.bgAlpha = alpha;
}


#pragma mark - 用于处理抢购相关倒计时功能的刷新
- (void)startTimer {
    //全局的秒倒计时
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.f target:self selector:@selector(refreshLessTime) userInfo:@"" repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:UITrackingRunLoopMode];
    
    //全局的毫秒秒倒计时
    _timer1 = [NSTimer scheduledTimerWithTimeInterval:0.1f target:self selector:@selector(refreshLessTime1) userInfo:@"" repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_timer1 forMode:UITrackingRunLoopMode];
}

- (void)refreshLessTime {
    //倒计时发送通知
    [[NSNotificationCenter defaultCenter]postNotificationName:@"countdown" object:nil];
}

- (void)refreshLessTime1 {
    //倒计时发送通知
    [[NSNotificationCenter defaultCenter]postNotificationName:@"countdown1" object:nil];
}

#pragma mark - collectionview delegate datasource



- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    WEAKSELF(weakSelf);
    HotCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"hotCollectionCell" forIndexPath:indexPath];
    if (self.adviceListMutableArray.count>0) {
        cell.goodsModel = self.adviceListMutableArray[indexPath.item];
    }
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.adviceListMutableArray.count;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    if (self.adviceListMutableArray.count>0) {
        Fcgo_HomeGoodsModel *model = self.adviceListMutableArray[indexPath.item];
        Fcgo_GoodsDetailVC *vc = [[Fcgo_GoodsDetailVC alloc]init];
        vc.hidesBottomBarWhenPushed = 1;
        vc.goodsType = @"normal";
        vc.goodsValue = [NSString stringWithFormat:@"%@",model.f_goods_id];
        [self.navigationController pushViewController:vc animated:YES];
    }
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if (kind == UICollectionElementKindSectionHeader) {
        NSArray *titleArray  = @[@"热门推荐",@"diamond_home"];
        titleHeaderView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"homeCollectionTitleHeaderView" forIndexPath:indexPath];
        titleHeaderView.backgroundColor = UIFontWhiteColor;
        [titleHeaderView addSubview:titleHeaderView.topLineView];
        [titleHeaderView addSubview:titleHeaderView.titleImageView];
        [titleHeaderView addSubview:titleHeaderView.titleLabel];
        
        [titleHeaderView addSubview:_webView];
        
        [_webView mas_makeConstraints:^(MASConstraintMaker *make) {
//
            make.top.equalTo(titleHeaderView.mas_top).offset(0);
            make.centerX.equalTo(titleHeaderView);
            make.width.equalTo(titleHeaderView);
            make.bottom.equalTo(titleHeaderView).offset(-65);
        }];
        [titleHeaderView.topLineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_offset(0);
            make.bottom.equalTo(titleHeaderView.mas_bottom).offset(-35);
            make.height.mas_offset(5);
        }];
        [titleHeaderView.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(titleHeaderView.mas_centerX).mas_offset(13);
            make.top.mas_equalTo(titleHeaderView.topLineView.mas_bottom).offset(10);
            make.height.mas_offset(22);
        }];
        [titleHeaderView.titleImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(titleHeaderView.titleLabel.mas_left).mas_offset(-5);
            make.width.mas_offset(18);
            make.height.mas_offset(18);
            make.centerY.equalTo(titleHeaderView.titleLabel);
        }];
        
        titleHeaderView.titleLabel.text = titleArray[0];
        titleHeaderView.titleImageView.image = [UIImage imageNamed:titleArray[1]];
        
        return titleHeaderView;
    }
    return nil;
}
#pragma mark - UICollectionViewFlowLayout delegate

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
   
    CGFloat width = (kScreenWidth - 21)/2;
    return CGSizeMake(width, width + 75);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    CGFloat height;
    if(self.webView.webView.scrollView.contentSize.height < KScreenHeight){
        height = KScreenHeight;
    }else{
        height = self.webView.webView.scrollView.contentSize.height;
    }
    
    return CGSizeMake(kScreenWidth,height+45);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 7, 12, 7);
}


- (NSMutableArray *)adviceListMutableArray
{
    if (!_adviceListMutableArray) {
        _adviceListMutableArray = [[NSMutableArray alloc]init];
    }
    return _adviceListMutableArray;
}

- (void)dealloc {
    [_timer invalidate];
    _timer = nil;
    
    [_timer1 invalidate];
    _timer1 = nil;
    
    [self removeObserverForWebViewContentSize];
}

@end
