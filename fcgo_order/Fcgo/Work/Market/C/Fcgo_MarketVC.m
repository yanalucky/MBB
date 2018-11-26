//
//  Fcgo_MarketVC.m
//  Fcgo
//
//  Created by huafanxiao on 2017/5/10.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_MarketVC.h"
#import "Fcgo_MarketTopCell.h"
#import "Fcgo_MarketNormalCell.h"

#import "Fcgo_Market_GoodsManngerVC.h"
#import "Fcgo_Market_OrderManngerVC.h"
#import "Fcgo_Market_ShopManngerVC.h"
#import "Fcgo_Market_CustomerManngerVC.h"
#import "Fcgo_Market_DataStatisticsVC.h"

#import <objc/message.h>

@interface Fcgo_MarketVC ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,strong) UICollectionView *collectionview;
@property (nonatomic,strong) NSArray *titleArray;


@end

@implementation Fcgo_MarketVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupUI];
}

- (void)setupUI;
{
    
    WEAKSELF(weakSelf);
    [self.navigationView setupTitleLabelWithTitle:@"微商城"];
    self.navigationView.alphaImageView.backgroundColor = UIBackGroundColor;
    
    self.titleArray = @[@[@"market_icon_goods",@"商品管理",@"goodsMannger"],@[@"market_icon_orders",@"订单管理",@"orderMannger"],@[@"market_icon_shop",@"店铺管理",@"shopMannger"],@[@"market_icon_clients",@"客户管理",@"customerMannger"],@[@"market_icon_data",@"数据统计",@"DataStatistics"],@[@"market_icon_developing",@"新功能正在开发中,敬请期待"],];
    [self.view addSubview:self.collectionview];
    
    [self.collectionview registerNib:[UINib nibWithNibName:NSStringFromClass([Fcgo_MarketTopCell class]) bundle:nil] forCellWithReuseIdentifier:@"marketTopCell"];
   [self.collectionview registerNib:[UINib nibWithNibName:NSStringFromClass([Fcgo_MarketNormalCell class]) bundle:nil] forCellWithReuseIdentifier:@"marketNormalCell"];
    self.collectionview.frame =  CGRectMake(0, kNavigationHeight, kScreenWidth, KScreenHeight-kNavigationHeight-kTabBarHeight);
    
    self.collectionview.mj_header = [Fcgo_RefreshNormalHeader headerRefreshBlock:^{
        [weakSelf.collectionview.mj_header endRefreshing];
        
        //[weakSelf reloadRequest];
    }];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 1;
    }
    return 6;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
       Fcgo_MarketTopCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"marketTopCell" forIndexPath:indexPath];
        WEAKSELF(weakSelf);
        cell.shareBlock = ^{
            [weakSelf share];
        };
        return cell;
    }
    Fcgo_MarketNormalCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"marketNormalCell" forIndexPath:indexPath];
    cell.imgView.image = [UIImage imageNamed:self.titleArray[indexPath.item][0]];
    cell.titleLabel.text = self.titleArray[indexPath.item][1];
    return cell;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1 && indexPath.row < 5) {
        NSString *meoth = self.titleArray[indexPath.item][2];
        SEL meth = NSSelectorFromString(meoth);
        if ([self respondsToSelector:meth]) {
            ((void (*)(id, SEL))objc_msgSend)(self, meth);
        }
        [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
       return CGSizeMake(kScreenWidth, kAutoWidth6(167));
    }
    CGFloat width = (kScreenWidth - 3)/4;
    if (indexPath.item<5) {
        return CGSizeMake(width, width);
    }
    return CGSizeMake(width*3+2, width);
}

- (void)share
{
    NSString *urlString = @"http://www.baidu.com";
    ShareAnimationView *shareview =  [[ShareAnimationView alloc]initWithFrame:CGRectMake(0, KScreenHeight - 240, kScreenWidth, 240)];
    __weak typeof(shareview)wshareview = shareview;
    shareview.shareBlock = ^(ShareType shareType){
        if (shareType == ShareWeiXinType) {
            //[ShareClass shareWithContent:contentString images:imageString title:@"菲常购微店" type:3 url:urlString wxUrl:urlString];
        }
        else if (shareType == ShareWeiXinTimeLineType)
        {
            //[ShareClass shareWithContent:contentString images:imageString title:@"菲常购微店" type:4 url:urlString wxUrl:urlString];
        }
        else if (shareType == ShareScanType)
        {
            [wshareview dismissWithComplation:^{
                ScanAnimationVew *scanview =  [[ScanAnimationVew alloc]initWithFrame:CGRectMake(0, kAutoWidth6px(644), kScreenWidth, kAutoWidth6(250)+ 20+160+ kAutoWidth6px(50))];
                NSOperationQueue *loadQueue = [[NSOperationQueue alloc] init];
                loadQueue.maxConcurrentOperationCount = 5;
                [loadQueue addOperationWithBlock:^{
                    UIImage *image =  [Fcgo_Tools creatQRImageWithString:urlString];
                    //执行complation，把图片设置到imageView上。
                    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                        scanview.image = image;
                    }];
                }];
                [scanview show];
            }];
            
        }
        else if (shareType == ShareCopyLinkType)
        {
            UIPasteboard* pasteboard = [UIPasteboard generalPasteboard];
            [pasteboard setString:urlString];
            [WSProgressHUD showImage:nil status:@"链接已复制，请在微信中打开"];
        }
    };
    [shareview show];
}
- (void)goodsMannger
{
    [self pushToViewController:@"Fcgo_Market_GoodsManngerVC"];
}

- (void)orderMannger
{
    [self pushToViewController:@"Fcgo_Market_OrderManngerVC"];
}

- (void)shopMannger
{
    [self pushToViewController:@"Fcgo_Market_ShopManngerVC"];
}

- (void)customerMannger
{
    [self pushToViewController:@"Fcgo_Market_CustomerManngerVC"];
    
}

- (void)DataStatistics
{
    [self pushToViewController:@"Fcgo_Market_DataStatisticsVC"];
}

- (void)pushToViewController:(NSString *)vcClass;
{
    Class class = NSClassFromString(vcClass);
    if ([class isSubclassOfClass:[UIViewController class]]) {
        
        UIViewController *vc = [[class alloc]init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark Lazy method

- (UICollectionView *)collectionview
{
    if (!_collectionview) {
        UICollectionViewLeftAlignedLayout *flowLayout= [[UICollectionViewLeftAlignedLayout alloc]init];
        flowLayout.minimumInteritemSpacing = 1;
        flowLayout.minimumLineSpacing = 1;
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _collectionview = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _collectionview.backgroundColor = UIBackGroundColor;
        _collectionview.delegate = self;
        _collectionview.dataSource = self;
        _collectionview.alwaysBounceVertical = YES;
        _collectionview.showsHorizontalScrollIndicator = NO;
        if (@available(iOS 11.0, *)) {
            _collectionview.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return _collectionview;
}

@end


