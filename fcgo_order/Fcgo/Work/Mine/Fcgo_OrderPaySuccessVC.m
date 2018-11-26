//
//  Fcgo_OrderPaySuccessVC.m
//  Fcgo
//
//  Created by huafanxiao on 2017/6/12.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_OrderPaySuccessVC.h"
#import "Fcgo_HomeGoodsModel.h"
#import "Fcgo_OrderPaySuccessCell.h"
#import "ShopCartNoneHeaderView.h"
#import "ShopCartNoneFooterView.h"
#import "HotCollectionCell.h"
#import "Fcgo_GoodsDetailVC.h"

#import "Fcgo_OrderDetailVC.h"
@interface Fcgo_OrderPaySuccessVC ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,strong) NSMutableArray   *goodsNewArray;
@property (nonatomic,strong) UICollectionView *collectionview;

@end

@implementation Fcgo_OrderPaySuccessVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    
    [self requestNewGoods];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.navigationController.fd_fullscreenPopGestureRecognizer.enabled = NO;
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    self.navigationController.fd_fullscreenPopGestureRecognizer.enabled = YES;
}

-(void)requestNewGoods {
    WEAKSELF(weakSelf);
    NSMutableDictionary *mutaDict=[[NSMutableDictionary alloc]init];
    [mutaDict setObjectWithNullValidate:@1 forKey:@"page"];
    [mutaDict setObjectWithNullValidate:@12 forKey:@"rows"];
    [Fcgo_NetworkManager postRequest:NSFormatHeardMeThodUrl(ServiceLocalTypeOne, GOODMETHOD, @"goodsScanlist")
                          parametersContentCommon:mutaDict successBlock:^(BOOL success, id responseObject, NSString *msg) {
         if (success) {
             NSNumber *errCode = responseObject[@"errorCode"];
             if (errCode.intValue == 0) {
                 NSArray *dataArray = responseObject[@"data"];
                 for (int i=0; i<dataArray.count; i++) {
                     NSDictionary *goodsDict = dataArray[i];
                     Fcgo_HomeGoodsModel *model = [Fcgo_HomeGoodsModel yy_modelWithDictionary:goodsDict];
                     [weakSelf.goodsNewArray addObject:model];
                 }
             }
         }
         [self.collectionview reloadData];
         [self.collectionview.mj_header endRefreshing];
     } failureBlock:^(NSString *description) {

     }];
}

- (void)setupUI; {
    WEAKSELF(weakSelf)
    [self.navigationView setupBackBtnBlock:^{
        Fcgo_BasicNavVC *nav = weakSelf.tabBarController.viewControllers[0];
        [nav popToRootViewControllerAnimated:YES];
        weakSelf.tabBarController.selectedIndex = 0;
        [weakSelf.navigationController popToRootViewControllerAnimated:YES];
    }];
    [self.navigationView setupBackTitle:@"返回首页"];
    [self.navigationView setupTitleLabelWithTitle:@"支付成功"];
    
    self.collectionview.mj_header = [Fcgo_RefreshNormalHeader headerRefreshBlock:^{
        [weakSelf requestNewGoods];
    }];
    [self.view addSubview:self.collectionview];
}

- (UICollectionView *)collectionview {
    if (!_collectionview) {
        UICollectionViewFlowLayout *flowLayout= [[UICollectionViewFlowLayout alloc]init];
        flowLayout.minimumInteritemSpacing = 7;
        flowLayout.minimumLineSpacing = 7;
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 7, 0, 7);
        _collectionview = [[UICollectionView alloc]initWithFrame:CGRectMake(0, kNavigationHeight, kScreenWidth, KScreenHeight-kNavigationHeight) collectionViewLayout:flowLayout];
        _collectionview.contentInset = UIEdgeInsetsMake(0, 0, 40, 0);
        _collectionview.backgroundColor = [UIColor clearColor];
        _collectionview.delegate = self;
        _collectionview.dataSource = self;
        [_collectionview registerNib:[UINib nibWithNibName:NSStringFromClass([Fcgo_OrderPaySuccessCell class]) bundle:nil] forCellWithReuseIdentifier:@"orderPaySuccessCell"];
        [_collectionview registerClass:[ShopCartNoneHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"shopCartNoneHeaderView"];
        [_collectionview registerClass:[ShopCartNoneFooterView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"shopCartNoneFooterView"];
        [_collectionview registerNib:[UINib nibWithNibName:NSStringFromClass([HotCollectionCell class]) bundle:nil] forCellWithReuseIdentifier:@"hotCollectionCell"];
        if (@available(iOS 11.0, *)) {
            _collectionview.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return _collectionview;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    if (self.goodsNewArray&&self.goodsNewArray.count>0) {
        return self.goodsNewArray.count;
    }
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        Fcgo_OrderPaySuccessCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"orderPaySuccessCell" forIndexPath:indexPath];
        WEAKSELF(weakSelf);
        cell.goToVisit = ^{
            Fcgo_OrderDetailVC *vc = [[Fcgo_OrderDetailVC alloc]init];
            vc.hidesBottomBarWhenPushed =  1;
            vc.orderId = weakSelf.orderId;
            [weakSelf.navigationController pushViewController:vc animated:1];
        };
        return cell;
    }
    HotCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"hotCollectionCell" forIndexPath:indexPath];
    if (self.goodsNewArray&&self.goodsNewArray.count>0) {
        Fcgo_HomeGoodsModel *model = self.goodsNewArray[indexPath.item];
        cell.goodsModel = model;
    }
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if (kind == UICollectionElementKindSectionHeader) {
        ShopCartNoneHeaderView *heardView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"shopCartNoneHeaderView" forIndexPath:indexPath];
        
        [heardView addSubview:heardView.likeLabel];
        [heardView.likeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(heardView.mas_centerY);
            make.centerX.mas_equalTo(heardView.mas_centerX).mas_offset(11);
        }];
        
        [heardView addSubview:heardView.imgView];
        [heardView.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(heardView.mas_centerY);
            make.right.mas_equalTo(heardView.likeLabel.mas_left).mas_offset(-4);
            make.width.mas_offset(18);
            make.height.mas_offset(18);
        }];
        return heardView;
    }
    if (kind == UICollectionElementKindSectionFooter) {
        ShopCartNoneFooterView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"shopCartNoneFooterView" forIndexPath:indexPath];
        
        [footerView addSubview:footerView.noMoreLabel];
        [footerView.noMoreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(footerView.mas_centerY);
            make.centerX.mas_equalTo(footerView.mas_centerX);
        }];
        return footerView;
    }
    return nil;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return;
    }
    if (self.goodsNewArray&&self.goodsNewArray.count>0) {
        Fcgo_HomeGoodsModel *model = self.goodsNewArray[indexPath.item];
        Fcgo_GoodsDetailVC *vc = [[Fcgo_GoodsDetailVC alloc]init];
        vc.hidesBottomBarWhenPushed = 1;
        vc.goodsType = @"normal";
        vc.goodsValue = [NSString stringWithFormat:@"%@",model.f_goods_id];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return CGSizeMake(kScreenWidth-14, kAutoWidth6px(962));
    }
    CGFloat width = (kScreenWidth - 21)/2;
    return CGSizeMake(width, width + 75);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        return CGSizeMake(kScreenWidth, 40);
    }
    return CGSizeZero;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    if (self.goodsNewArray &&self.goodsNewArray.count>0) {
        if (section == 1) {
            return CGSizeMake(kScreenWidth, 40);
        }
    }
    return CGSizeZero;
}

- (NSMutableArray *)goodsNewArray {
    if (!_goodsNewArray) {
        _goodsNewArray = [[NSMutableArray alloc]init];
    }
    return _goodsNewArray;
}

@end
