//
//  Fcgo_HomeVC.m
//  Fcgo
//
//  Created by huafanxiao on 2017/5/10.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_HomeVC.h"
#import "Fcgo_HomeNavView.h"
#import "Fcgo_MsgVC.h"
#import "Fcgo_ScanVC.h"
#import "Fcgo_HomeViewModel.h"
#import "Fcgo_HomeSortIconModel.h"
#import "Fcgo_HomeCycleModel.h"
#import "Fcgo_FromHomeWebVC.h"
#import "Fcgo_GoodsListVC.h"
#import "Fcgo_GoodsDetailVC.h"

#import "Fcgo_Home_H5_CollectionViewCell.h"

#import "Fcgo_HomeCollectionCycleHearderView.h"//轮播和分类图标
#import "Fcgo_HomeCollectionSortCell.h"

#import "Fcgo_HomeCollectionTitleHeaderView.h"//精选专题
#import "Fcgo_HomeCollectionChoseSpecilCell.h"

#import "Fcgo_HomeCollectionWholePointCell.h"//整点抢

#import "Fcgo_HomeCollectionActivityCell.h"//促销特惠

#import "HotCollectionCell.h"//新品推荐

#import "Home_WholePointDetailVC.h"
#import "Fcgo_SearchVC.h"

#define ItemWidth   ((kScreenWidth - 2*kAutoWidth6(15))/5)
#define ItemHeight  ((ItemWidth - kAutoWidth6(30)) + 23)

@interface Fcgo_HomeVC ()<HYImageScrollView,UICollectionViewDelegate,UICollectionViewDataSource>//,SDCycleScrollViewDelegate>
{
    NSTimer *_timer;
    NSTimer *_timer1;
}
@property (nonatomic,strong) Fcgo_HomeNavView *navView;
@property (nonatomic,strong) HYImageScrollView *cycleView;

@property (nonatomic,strong) NSMutableArray *cycleMutableArray;
@property (nonatomic,strong) NSMutableArray *sortIconMutableArray;
@property (nonatomic,strong) NSMutableArray *wholePointMutableArray;
@property (nonatomic,strong) NSMutableArray *promoteMutableArray;
@property (nonatomic,strong) NSMutableArray *choseSpecilMutableArray;
@property (nonatomic,strong) NSMutableArray *adviceListMutableArray;
@property (nonatomic,strong) UICollectionView *collectionview;

@property (nonatomic,strong) NSDictionary *h5Dict;



@property (nonatomic,assign) int page;
@property (nonatomic,assign) CGFloat h5Height;

@end

@implementation Fcgo_HomeVC

- (void)reloadRequest
{
    if (![Fcgo_Tools isNetworkConnected]) {
        [WSProgressHUD showImage:nil status:@"亲,没联网啊"];
        [self showUIData:NO];
        return;
    }
    self.page = 1;
    WEAKSELF(weakSelf)
    [WSProgressHUD showWithStatus:@"加载中..." maskType:WSProgressHUDMaskTypeClear];
    [Fcgo_HomeViewModel postRequestCycleListSuccess:^(NSMutableArray *mutableArray) {
        [WSProgressHUD dismiss];
        STRONGSELF(strongSelf);
        [self showUIData:YES];
         [weakSelf.collectionview.mj_header endRefreshing];
        //判断请求回来是否有数据
        if (mutableArray &&mutableArray.count>0) {
            [strongSelf.cycleMutableArray removeAllObjects];
            NSMutableArray *cycleImagesArray = [NSMutableArray array];
            [mutableArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [strongSelf.cycleMutableArray addObject:obj];
                Fcgo_HomeCycleModel *cycleModel = (Fcgo_HomeCycleModel *)obj;
                if (cycleModel.picurlIos) {
                     [cycleImagesArray addObject:cycleModel.picurlIos];
                }
            }];
            self.cycleView.marrImageList = cycleImagesArray;
        }
       
    } ofFail:^{
        [self showUIData:NO];
        [weakSelf.collectionview.mj_header endRefreshing];
    }];
    
    
    [Fcgo_HomeViewModel postRequestH5Success:^(NSDictionary *dict){
               STRONGSELF(strongSelf);
        [weakSelf.collectionview.mj_header endRefreshing];
        [self showUIData:YES];
        self.h5Dict = dict;
        [strongSelf.collectionview reloadItemsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]]];
    } ofFail:^{
        
        [self showUIData:NO];
        [weakSelf.collectionview.mj_header endRefreshing];
        
    }];
//    [Fcgo_HomeViewModel postRequestSortIconListSuccess:^(NSMutableArray *mutableArray) {
//        STRONGSELF(strongSelf);
//         [weakSelf.collectionview.mj_header endRefreshing];
//        [self showUIData:YES];
//        //判断请求回来是否有数据
//        if (mutableArray &&mutableArray.count>0) {
//            [strongSelf.sortIconMutableArray removeAllObjects];
//            [mutableArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//                [strongSelf.sortIconMutableArray addObject:obj];
//            }];
//            [strongSelf.collectionview reloadItemsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]]];
//        }
//    } ofFail:^{
//        [self showUIData:NO];
//        [weakSelf.collectionview.mj_header endRefreshing];
//        
//    }];
//    [self requestWholePoint];
//    
//    
//    [Fcgo_HomeViewModel postRequestPromoteListSuccess:^(NSMutableArray *mutableArray) {
//        STRONGSELF(strongSelf);
//        [self showUIData:YES];
//        [weakSelf.collectionview.mj_header endRefreshing];
//        //判断请求回来是否有数据
//        if (mutableArray &&mutableArray.count>0) {
//            [strongSelf.promoteMutableArray removeAllObjects];
//            [mutableArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//                [strongSelf.promoteMutableArray addObject:obj];
//            }];
//            [strongSelf.collectionview reloadSections:[NSIndexSet indexSetWithIndex:2]];
//        }
//    } ofFail:^{
//         [self showUIData:NO];
//        [weakSelf.collectionview.mj_header endRefreshing];
//    }];

    [Fcgo_HomeViewModel postRequestChoseSpecilSuccess:^(NSMutableArray *mutableArray) {
        STRONGSELF(strongSelf);
         [self showUIData:YES];
         [weakSelf.collectionview.mj_header endRefreshing];
        //判断请求回来是否有数据
        if (mutableArray &&mutableArray.count>0) {
            [strongSelf.choseSpecilMutableArray removeAllObjects];
            [mutableArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [strongSelf.choseSpecilMutableArray addObject:obj];
            }];
            [strongSelf.collectionview reloadSections:[NSIndexSet indexSetWithIndex:3]];
        }
    } ofFail:^{
        [self showUIData:NO];
        [weakSelf.collectionview.mj_header endRefreshing];
    }];
    
    [Fcgo_HomeViewModel postRequestAdviceListWithPage:self.page success:^(NSMutableArray *mutableArray) {
       STRONGSELF(strongSelf);
         [self showUIData:YES];
         [weakSelf.collectionview.mj_header endRefreshing];
        //判断请求回来是否有数据
        if (mutableArray &&mutableArray.count>0) {
            [strongSelf.adviceListMutableArray removeAllObjects];
            [mutableArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [strongSelf.adviceListMutableArray addObject:obj];
            }];
            [strongSelf.collectionview reloadSections:[NSIndexSet indexSetWithIndex:4]];
        }
        weakSelf.page += 1;
    } ofFail:^{
        [self showUIData:NO];
        [weakSelf.collectionview.mj_header endRefreshing];
    }];
}

- (void)requestWholePoint
{
    WEAKSELF(weakSelf)
    [Fcgo_HomeViewModel postRequestGrabTheWholePointListSuccess:^(NSMutableArray *mutableArray) {
        STRONGSELF(strongSelf);
         [self showUIData:YES];
        [strongSelf.wholePointMutableArray removeAllObjects];
        [weakSelf.collectionview.mj_header endRefreshing];
        //判断请求回来是否有数据
        //if (mutableArray &&mutableArray.count>0) {
            [mutableArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [strongSelf.wholePointMutableArray addObject:obj];
            }];
            [strongSelf.collectionview reloadSections:[NSIndexSet indexSetWithIndex:1]];
        //}
    } ofFail:^{
        [self showUIData:NO];
        [weakSelf.collectionview.mj_header endRefreshing];
    }];
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
            
            NSMutableArray *indexPathArray = [NSMutableArray array];
            for (NSInteger i = count; i < strongSelf.adviceListMutableArray.count; i ++) {
                NSIndexPath *index = [NSIndexPath indexPathForItem:i inSection:4];
                [indexPathArray addObject:index];
            }
            [strongSelf.collectionview insertItemsAtIndexPaths:indexPathArray];
            weakSelf.page += 1;
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
        
    }];
}

- (void)showUIData:(BOOL)isShow
{
    [self showNoControl:!isShow titleString:@"网络错误,点击重新加载" imageString:@"ico_no-wifi"];
    self.collectionview.hidden = !isShow;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent];
    //先发送版本跟新
    [Fcgo_publicNetworkTools postRequestViesion];
    
    [self setupUI];
    [self reloadRequest];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    CGFloat y = self.collectionview.contentOffset.y;
    CGFloat alpha = y/170;
    if (alpha>0.7) {
        [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleDefault];
    }
    else{
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleDefault];
}


- (void)setupUI
{
    self.page =  1;
    
    [self startTimer];
    
    WEAKSELF(weakSelf)
    Fcgo_HomeNavView *navView = [[Fcgo_HomeNavView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 64) ofScan:^{
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
    [self.navigationView addSubview:self.navView = navView];
    self.navigationView.alphaImageView.backgroundColor = UIFontWhiteColor;
    self.navigationView.bgAlpha = 0;
    //添加collectionview
    [self setupCollectionView];
}

- (void)setupCollectionView
{
    WEAKSELF(weakSelf)
    [self.collectionview registerClass:[Fcgo_HomeCollectionCycleHearderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"homeCollectionCycleHearderView"];
    
    [self.collectionview registerNib:[UINib nibWithNibName:NSStringFromClass([Fcgo_Home_H5_CollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:@"home_H5_CollectionViewCell"];
    
    [self.collectionview registerNib:[UINib nibWithNibName:NSStringFromClass([Fcgo_HomeCollectionSortCell class]) bundle:nil] forCellWithReuseIdentifier:@"homeCollectionSortCell"];
    
    [self.collectionview registerClass:[Fcgo_HomeCollectionTitleHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"homeCollectionTitleHeaderView"];
    
    [self.collectionview registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
    
    [self.collectionview registerNib:[UINib nibWithNibName:NSStringFromClass([Fcgo_HomeCollectionChoseSpecilCell class]) bundle:nil] forCellWithReuseIdentifier:@"homeCollectionChoseSpecilCell"];
    
    [self.collectionview registerNib:[UINib nibWithNibName:NSStringFromClass([HotCollectionCell class]) bundle:nil] forCellWithReuseIdentifier:@"hotCollectionCell"];
    
    
    [self.collectionview registerNib:[UINib nibWithNibName:NSStringFromClass([Fcgo_HomeCollectionWholePointCell class]) bundle:nil] forCellWithReuseIdentifier:@"homeCollectionWholePointCell"];
    
    [self.collectionview registerNib:[UINib nibWithNibName:NSStringFromClass([Fcgo_HomeCollectionActivityCell class]) bundle:nil] forCellWithReuseIdentifier:@"homeCollectionActivityCell"];
    self.collectionview.mj_header = [Fcgo_RefreshNormalHeader headerRefreshBlock:^{
        [weakSelf reloadRequest];
    }];
    
    self.collectionview.mj_footer = [MJRefreshBackStateFooter footerWithRefreshingBlock:^{
        [weakSelf loadAdviceListRequest];
    }];
    [self.view insertSubview:self.collectionview belowSubview:self.navigationView];
}

#pragma mark - collectionview delegate datasource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section == 1) {
        //return self.wholePointMutableArray.count;
        return 0;
    }
    
    if(section == 2)
    {
        return 0;
        //return 1;
    }
    
    if(section == 3)
    {
        return self.choseSpecilMutableArray.count;
    }
    if (section == 4) {
        return self.adviceListMutableArray.count;
    }
    return  1;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 5;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    WEAKSELF(weakSelf);
    if (indexPath.section == 0)
    {
        Fcgo_Home_H5_CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"home_H5_CollectionViewCell" forIndexPath:indexPath];
        if (self.h5Dict) {
             cell.urlString = [NSString stringWithFormat:@"%@%@?merId=%@&token=%@",NSShortUrl,self.h5Dict[@"url"],MerId,Token];
            
        }
        cell.returnHeightBlock = ^(CGFloat height) {
            weakSelf.h5Height = height;
            [collectionView reloadData];
            //[collectionView reloadItemsAtIndexPaths:@[[NSIndexPath indexPathForItem:0 inSection:0]]];
        };
        
        return cell;
    }
    
//    if (indexPath.section == 0) {
//        Fcgo_HomeCollectionSortCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"homeCollectionSortCell" forIndexPath:indexPath];
//        if (self.sortIconMutableArray.count>0) {
//            cell.sortIconArray = self.sortIconMutableArray;
//        }
//        cell.sortIconBlock = ^(Fcgo_HomeSortIconModel *sortIconModel)
//        {
//            Fcgo_GoodsListVC *vc = [[Fcgo_GoodsListVC alloc]init];
//            vc.hidesBottomBarWhenPushed = 1;
//            vc.cateIds = [NSString stringWithFormat:@"%@",sortIconModel.f_id];
//            vc.key = @"cate";
//            [self.navigationController pushViewController:vc animated:YES];
//        };
//        return cell;
//    }
//    if (indexPath.section == 1) {
//        Fcgo_HomeCollectionWholePointCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"homeCollectionWholePointCell" forIndexPath:indexPath];
//        if (self.wholePointMutableArray.count>0) {
//            cell.wholePointModel = self.wholePointMutableArray[indexPath.item];
//        }
//        cell.pushWholePointDetailVC = ^{
//            Home_WholePointDetailVC *vc = [[Home_WholePointDetailVC alloc]init];
//            vc.hidesBottomBarWhenPushed = 1;
//            [weakSelf.navigationController pushViewController:vc animated:YES];
//        };
//        cell.timeFinishBlock = ^{
//            [weakSelf requestWholePoint];
//        };
//        return cell;
//    }
//    if (indexPath.section == 2) {
//        Fcgo_HomeCollectionActivityCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"homeCollectionActivityCell" forIndexPath:indexPath];
//        if (self.promoteMutableArray.count>0) {
//            cell.promoteMutableArray = self.promoteMutableArray;
//        }
//        cell.didTouchBlock = ^(NSDictionary *dict){
//            NSString *href = dict[@"href"];
//            NSString *url = [NSString stringWithFormat:@"%@%@?merId=%@&token=%@",NSShortUrl,href,MerId,Token];
//           
//            Fcgo_FromHomeWebVC *fromHomeWebVC = [[Fcgo_FromHomeWebVC alloc]init];
//            fromHomeWebVC.hidesBottomBarWhenPushed = 1;
//            fromHomeWebVC.urlString = url;
//            [weakSelf.navigationController pushViewController:fromHomeWebVC animated:YES];
//        };
//        return cell;
//    }
    if (indexPath.section == 3) {
        Fcgo_HomeCollectionChoseSpecilCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"homeCollectionChoseSpecilCell" forIndexPath:indexPath];
        if (self.choseSpecilMutableArray.count>0) {
            cell.model = self.choseSpecilMutableArray[indexPath.item];
        }
        cell.specialBlock = ^(Fcgo_HomeTopicModel *model){
            [Fcgo_App_acrossTools app_acrossWithJsonString:model.f_href webView:nil parentVC:self];
        };
        cell.selectItemBlock = ^(Fcgo_HomeGoodsModel *model){
            
            Fcgo_GoodsDetailVC *vc = [[Fcgo_GoodsDetailVC alloc]init];
            vc.hidesBottomBarWhenPushed = 1;
            vc.goodsType = @"normal";
            vc.goodsValue = [NSString stringWithFormat:@"%@",model.f_goods_id];
            [self.navigationController pushViewController:vc animated:YES];
        };
        cell.backgroundColor =[UIColor whiteColor];
        return cell;
    }
    HotCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"hotCollectionCell" forIndexPath:indexPath];
    if (self.adviceListMutableArray.count>0) {
        cell.goodsModel = self.adviceListMutableArray[indexPath.item];
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    if (indexPath.section == 1) {
//        Home_WholePointDetailVC *vc = [[Home_WholePointDetailVC alloc]init];
//        vc.hidesBottomBarWhenPushed = 1;
//        [self.navigationController pushViewController:vc animated:YES];
    }
    if (indexPath.section == 4) {
        if (self.adviceListMutableArray.count>0) {
            Fcgo_HomeGoodsModel *model = self.adviceListMutableArray[indexPath.item];
            Fcgo_GoodsDetailVC *vc = [[Fcgo_GoodsDetailVC alloc]init];
            vc.hidesBottomBarWhenPushed = 1;
            vc.goodsType = @"normal";
            vc.goodsValue = [NSString stringWithFormat:@"%@",model.f_goods_id];
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if (kind == UICollectionElementKindSectionHeader) {
        if (indexPath.section == 0) {
            Fcgo_HomeCollectionCycleHearderView *cycleHeaderView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"homeCollectionCycleHearderView" forIndexPath:indexPath];
            HYImageScrollView *cycleView = [cycleHeaderView viewWithTag:400];
            if (!cycleView) {
                [cycleHeaderView addSubview:self.cycleView];
            }
            return cycleHeaderView;
        }
        else if (indexPath.section == 1) {
            //整点抢
        }
        else if (indexPath.section == 3 || indexPath.section == 4)
            
        {
            NSArray *titleArray  = @[@[@"精选专题",@"thumb_home"],
                                     @[@"热门推荐",@"diamond_home"]];
            Fcgo_HomeCollectionTitleHeaderView *titleHeaderView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"homeCollectionTitleHeaderView" forIndexPath:indexPath];
            titleHeaderView.backgroundColor = UIFontWhiteColor;
            [titleHeaderView addSubview:titleHeaderView.topLineView];
            [titleHeaderView addSubview:titleHeaderView.titleImageView];
            [titleHeaderView addSubview:titleHeaderView.titleLabel];
            
            [titleHeaderView.topLineView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.mas_offset(0);
                make.top.mas_offset(0);
                make.height.mas_offset(5);
            }];
            [titleHeaderView.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.mas_equalTo(titleHeaderView.mas_centerX).mas_offset(13);
                make.top.mas_offset(15);
                make.height.mas_offset(22);
            }];
            [titleHeaderView.titleImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(titleHeaderView.titleLabel.mas_left).mas_offset(-5);
                make.width.mas_offset(18);
                make.height.mas_offset(18);
                make.centerY.mas_equalTo(titleHeaderView.titleLabel.mas_centerY);
            }];
            
            titleHeaderView.titleLabel.text = titleArray[indexPath.section - 3][0];
            titleHeaderView.titleImageView.image = [UIImage imageNamed:titleArray[indexPath.section - 3][1]];
            
            return titleHeaderView;
        }
    }
    return nil;
}

#pragma mark - UICollectionViewFlowLayout delegate

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        //return CGSizeMake(kScreenWidth, ItemHeight*2 + kAutoWidth6(15)*2 + 15);
        if (self.h5Dict) {
            CGFloat height = [self.h5Dict[@"height"] floatValue];
            CGFloat width  = [self.h5Dict[@"width"] floatValue];
            if (width<=0) {
                width = 1;
            }
            
             //return CGSizeMake(kScreenWidth,kScreenWidth * height/width);
            
            return CGSizeMake(kScreenWidth,self.h5Height);
        }
        return CGSizeMake(kScreenWidth, 0);
    }
    else if (indexPath.section == 1) {
        //return CGSizeMake(kScreenWidth, kAutoWidth6(250));
        return CGSizeMake(kScreenWidth, 0);
    }
    else if (indexPath.section == 2) {
//        CGFloat height = (kScreenWidth-10)/2*300/612;
//        return CGSizeMake(kScreenWidth, height + 20);
        
        return CGSizeMake(kScreenWidth, 0);
    }
    else if (indexPath.section == 3) {
        return  CGSizeMake(kScreenWidth, kScreenWidth*290/621 + kAutoWidth6px(300)+65);
    }
    CGFloat width = (kScreenWidth - 21)/2;
    return CGSizeMake(width, width + 75);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if(section == 0)
    {
        return CGSizeMake(kScreenWidth, kScreenWidth*580/1242);
    }
    else if (section == 1)
    {
        return CGSizeMake(kScreenWidth, 0);
    }
    else if (section == 3 || section == 4) {
        return CGSizeMake(kScreenWidth, 45) ;
    }
    return CGSizeMake(kScreenWidth, 0) ;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    if (section == 4) {
        return UIEdgeInsetsMake(0, 7, 12, 7);
    }
    return UIEdgeInsetsMake(0, 0, 0, 0);
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
        [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent];
    }
    self.navView.bgAlpha = alpha;
    self.navigationView.bgAlpha = alpha;
}

#pragma mark - SDCycleScrollViewDelegate


//区头滑动视图图片点击
- (void)ImageScrollUserClickedAtPage:(NSInteger)currentPage
{
    Fcgo_HomeCycleModel *cycleModel   = [self.cycleMutableArray objectAtIndex:currentPage];
    [Fcgo_App_acrossTools app_acrossWithJsonString:cycleModel.hrefIos webView:nil  parentVC:self];
}

#pragma mark - Lazy method

- (UICollectionView *)collectionview
{
    if (!_collectionview) {
        UICollectionViewFlowLayout *flowLayout= [[UICollectionViewFlowLayout alloc]init];
        flowLayout.minimumInteritemSpacing = 7;
        flowLayout.minimumLineSpacing = 7;
        _collectionview = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, KScreenHeight-49) collectionViewLayout:flowLayout];
        _collectionview.backgroundColor = UIFontWhiteColor;
        _collectionview.delegate = self;
        _collectionview.dataSource = self;
        _collectionview.hidden = 1;
        if (@available(iOS 11.0, *)) {
            _collectionview.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return _collectionview;
}

- (HYImageScrollView *)cycleView
{
    if (!_cycleView)
    {
        _cycleView = [[HYImageScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth,kScreenWidth*580/1242) marrImages:[NSMutableArray array]];
        _cycleView.tag = 400;
        _cycleView.delegate = self;
    }
    return _cycleView;
}

- (NSMutableArray *)cycleMutableArray
{
    if (!_cycleMutableArray) {
        _cycleMutableArray = [[NSMutableArray alloc]init];
    }
    return _cycleMutableArray;
}

- (NSMutableArray *)sortIconMutableArray
{
    if (!_sortIconMutableArray) {
        _sortIconMutableArray = [[NSMutableArray alloc]init];
    }
    return _sortIconMutableArray;
}

- (NSMutableArray *)wholePointMutableArray
{
    if (!_wholePointMutableArray) {
        _wholePointMutableArray = [[NSMutableArray alloc]init];
    }
    return _wholePointMutableArray;
}

- (NSMutableArray *)promoteMutableArray
{
    if (!_promoteMutableArray) {
        _promoteMutableArray = [[NSMutableArray alloc]init];
    }
    return _promoteMutableArray;
}

- (NSMutableArray *)choseSpecilMutableArray
{
    if (!_choseSpecilMutableArray) {
        _choseSpecilMutableArray = [[NSMutableArray alloc]init];
    }
    return _choseSpecilMutableArray;
}

- (NSMutableArray *)adviceListMutableArray
{
    if (!_adviceListMutableArray) {
        _adviceListMutableArray = [[NSMutableArray alloc]init];
    }
    return _adviceListMutableArray;
}

- (void)startTimer

{
    //全局的秒倒计时
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.f target:self selector:@selector(refreshLessTime) userInfo:@"" repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:UITrackingRunLoopMode];
    
    //全局的毫秒秒倒计时
    _timer1 = [NSTimer scheduledTimerWithTimeInterval:0.1f target:self selector:@selector(refreshLessTime1) userInfo:@"" repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_timer1 forMode:UITrackingRunLoopMode];
}

- (void)refreshLessTime
{
    //倒计时发送通知
    [[NSNotificationCenter defaultCenter]postNotificationName:@"countdown" object:nil];
}

- (void)refreshLessTime1
{
    //倒计时发送通知
    [[NSNotificationCenter defaultCenter]postNotificationName:@"countdown1" object:nil];
}

- (void)dealloc
{
    [_timer invalidate];
    _timer = nil;
    
    [_timer1 invalidate];
    _timer1 = nil;

}
@end
