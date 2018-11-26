//
//  Fcgo_GoodsListVC.m
//  Fcgo
//
//  Created by huafanxiao on 2017/6/1.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_GoodsListVC.h"
#import "Fcgo_GoodsListNavView.h"
#import "Fcgo_GoodsListTypeView.h"
#import "HotCollectionCell.h"
#import "Fcgo_GoodsListTableCell.h"
#import "Fcgo_GoodsDetailVC.h"
#import "Fcgo_GoodsInfoVC.h"
#import "Fcgo_HomeViewModel.h"

#import "Fcgo_SiftVC.h"
#import "Fcgo_SearchVC.h"
#import "Fcgo_SiftCateModel.h"//一级分类
#import "Fcgo_SiftCatemModel.h"//二级分类
#import "Fcgo_BrandModel.h"


@interface Fcgo_GoodsListVC ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,XRWaterfallLayoutDelegate>
{
    CGFloat _collectionView_lastContentOffset;
    BOOL    _collectionView_isDrag;
    
    CGFloat _table_lastContentOffset;
    BOOL    _table_isDrag;
    BOOL    _isUpAnimation;
    BOOL    _isDownAnimation;
    
}
@property (nonatomic,strong) Fcgo_GoodsListNavView  *navView;
@property (nonatomic,strong) Fcgo_GoodsListTypeView *typeView;

@property (nonatomic,strong) UITableView      *table;
@property (nonatomic,strong) UICollectionView *collectionview;
@property (nonatomic,strong) Fcgo_SiftVC      *siftVC;




@property (nonatomic,copy) NSString *f_goodsIds;
@property (nonatomic,copy) NSString *f_cateIds;
@property (nonatomic,copy) NSString *f_catemIds;
@property (nonatomic,copy) NSString *f_brandIds;
@property (nonatomic,copy) NSString *f_texe;
@property (nonatomic,assign) int     f_page;
@property (nonatomic,copy) NSString *f_row;
@property (nonatomic,copy) NSString *f_orderby;
@property (nonatomic,copy) NSString *f_asc;
@property (nonatomic,copy) NSString *f_words;
@property (nonatomic,copy) NSString *f_key;
@property (nonatomic,copy) NSString *f_attrs;

@property (nonatomic,assign) BOOL    isMix;//记录是否已经选择。除了words进来是no,其他都是yes,在筛选界面发送请求用的到

@property (nonatomic,strong) NSMutableArray   *attrArray;
@property (nonatomic,strong) NSMutableArray   *goodsListArray;

@end

@implementation Fcgo_GoodsListVC

//数据解析
- (void)basicDataAnalysis
{
    self.isMix = YES;
    
    self.goodsIds = !self.goodsIds?@"":self.goodsIds;
    self.cateIds  = !self.cateIds? @"":self.cateIds;
    self.catemIds = !self.catemIds?@"":self.catemIds;
    self.brandIds = !self.brandIds?@"":self.brandIds;
    self.texe     = !self.texe?    @"":self.texe;
    self.page     = !self.page?      1:self.page;
    self.row      = !self.row?     @"10":self.row;
    self.orderby  = !self.orderby? @"":self.orderby;
    self.asc      = !self.asc?     @"":self.asc;
    if (!self.words) {
        self.isMix = NO;
    }
    else{
        self.navView.textLabel.text = self.words;
    }
    self.words    = !self.words?   @"":self.words;
    self.key      = !self.key?     @"":self.key;
    self.attrs    = !self.attrs?   @"":self.attrs;
    
    self.f_goodsIds = self.goodsIds;
    self.f_cateIds  = self.cateIds;
    self.f_catemIds = self.catemIds;
    self.f_brandIds = self.brandIds;
    self.f_texe     = self.texe;
    self.f_page     = self.page;
    self.f_row      = self.row;
    self.f_orderby  = self.orderby;
    self.f_asc      = self.asc;
    self.f_words    = self.words;
    self.f_key      = self.key;
    self.f_attrs    = self.attrs;
    [self.attrArray removeAllObjects];
}

- (void)resetbasicDataAnalysis
{
    self.isMix = NO;
    
    self.goodsIds = nil;
    self.cateIds  = nil;
    self.catemIds = nil;
    self.brandIds = nil;
    self.texe     = nil;
    self.page     = 1;
    self.row      = nil;
    self.orderby  = nil;
    self.asc      = nil;
    if (!self.words) {
        self.isMix = NO;
    }
    self.words    = nil;
    self.key      = nil;
    self.attrs    = nil;
}



- (void)reloadRequest
{
    self.f_page = 1;
    [self.goodsListArray removeAllObjects];
    [self loadGoodsListRequest];
}

- (void)loadGoodsListRequest
{
    if (![Fcgo_Tools isNetworkConnected]) {
        [WSProgressHUD showImage:nil status:@"亲,没联网啊"];
        [self showUIData:NO];
        return;
    }
    WEAKSELF(weakSelf)
    NSMutableDictionary  *muatble = [NSMutableDictionary dictionary];
    [muatble setObjectWithNullValidate:self.f_goodsIds forKey:@"goodsIds"];
    [muatble setObjectWithNullValidate:self.f_cateIds forKey:@"cateIds"];
    [muatble setObjectWithNullValidate:self.f_catemIds forKey:@"catemIds"];
    [muatble setObjectWithNullValidate:self.f_brandIds forKey:@"brandIds"];
    [muatble setObjectWithNullValidate:self.f_texe forKey:@"texe"];
    [muatble setObjectWithNullValidate:[NSString stringWithFormat:@"%d",self.f_page] forKey:@"page"];
    [muatble setObjectWithNullValidate:self.f_row forKey:@"row"];
    [muatble setObjectWithNullValidate:self.f_orderby forKey:@"orderby"];
    [muatble setObjectWithNullValidate:self.f_asc forKey:@"asc"];
    [muatble setObjectWithNullValidate:self.f_words forKey:@"words"];
    [muatble setObjectWithNullValidate:self.f_key forKey:@"key"];
    
    NSMutableString *attrs = [NSMutableString string];
    if (weakSelf.attrArray.count<=0) {
        [attrs setString:@""];
    }
    else{
        for (int i = 0; i < weakSelf.attrArray.count; i ++) {
            NSString *attrString = weakSelf.attrArray[i];
            if (i == 0) {
                [attrs setString:attrString];
            }
            else{
                [attrs appendString:[NSString stringWithFormat:@",%@",attrString]];
            }
        }
    }
    [muatble setObjectWithNullValidate:attrs forKey:@"attrs"];
    [WSProgressHUD showWithStatus:@"数据加载..." maskType:WSProgressHUDMaskTypeClear];
    [Fcgo_NetworkManager postRequest:NSFormatHeardMeThodUrl(ServiceLocalTypeOne, GOODMETHOD, @"search") parametersContentCommon:muatble successBlock:^(BOOL success, id responseObject, NSString *msg) {
        [WSProgressHUD dismiss];
        if (success) {
            
            
            NSDictionary *dataDict = responseObject[@"data"];
            //商品列表解析

            //NSDictionary *listDict = dataDict[@"goodsInfoForList"];
            NSArray *goodsInfoForListArray = dataDict[@"goodsInfoForList"];//listDict[@"resultlist"];

            if (self.f_page == 1) {
                [self.goodsListArray removeAllObjects];
            }
            NSInteger count = weakSelf.goodsListArray.count;
            for (int i = 0; i < goodsInfoForListArray.count; i ++) {
                NSDictionary *goodsListDict = goodsInfoForListArray[i];
                Fcgo_HomeGoodsModel *model = [Fcgo_HomeGoodsModel yy_modelWithDictionary:goodsListDict];
                [weakSelf.goodsListArray addObject:model];
            }
            NSMutableArray *indexPathArray = [NSMutableArray array];
            for (NSInteger i = count; i < weakSelf.goodsListArray.count; i ++) {
                NSIndexPath *index = [NSIndexPath indexPathForItem:i inSection:0];
                [indexPathArray addObject:index];
            }
            if(weakSelf.f_page == 1)
            {
                [weakSelf.table   reloadData];
                [weakSelf.collectionview reloadData];
            }else{
                [weakSelf.collectionview reloadData];
                
                //[weakSelf.collectionview insertItemsAtIndexPaths:indexPathArray];
                
                [weakSelf.table insertRowsAtIndexPaths:indexPathArray withRowAnimation:UITableViewRowAnimationFade];
            }
            
            [weakSelf.collectionview.mj_header endRefreshing];
            [weakSelf.table.mj_header endRefreshing];
            
            
            [weakSelf.collectionview.mj_footer resetNoMoreData];
            [weakSelf.table.mj_footer resetNoMoreData];
            
            
            if (goodsInfoForListArray.count < 10) {
                [weakSelf.collectionview.mj_footer endRefreshingWithNoMoreData];
                [weakSelf.table.mj_footer endRefreshingWithNoMoreData];
            }
            else{
                [weakSelf.collectionview.mj_footer endRefreshing];
                [weakSelf.table.mj_footer endRefreshing];
                weakSelf.f_page += 1;
            }
            
            if (weakSelf.goodsListArray.count>0) {
                [weakSelf showUIData:1];
            }else{
                [weakSelf showMoreUIData:0];
            }
            NSMutableArray *siftArray = [NSMutableArray array];
            //手动添加贸易类型
            NSArray *tradeArray = @[@"一般贸易",@"跨境保税",@"海外直邮"];
            NSString *type = self.isMix?@"text":@"mix";
            NSDictionary *tradeDict = @{@"name":@"贸易类型",@"type":type,@"list":tradeArray};
            [siftArray addObject:tradeDict];
            
            //筛选解析
            NSArray *keys = [dataDict allKeys];
            [keys enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                //商品列表的key值不做处理
                if ([obj isEqualToString:@"goodsCateList"])
                {
                    NSMutableArray *siftCateArray = [NSMutableArray array];
                    NSArray *cateArray = dataDict[@"goodsCateList"];
                    for (int i = 0; i < cateArray.count; i ++) {
                        NSDictionary *cateDict = cateArray[i];
                        Fcgo_SiftCateModel *model  = [Fcgo_SiftCateModel yy_modelWithDictionary:cateDict];
                        
                        if (model.selected.intValue == 1) {
                            self.cateIds = [NSString stringWithFormat:@"%@",model.f_cate_id];
                        }
                        
                        [siftCateArray addObject:model];
                    }
                    if (siftCateArray.count>0) {
                        NSString *type = self.isMix?@"cate":@"mix";
                        NSDictionary *cateDict = @{@"name":@"分类",@"type":type,@"list":siftCateArray};
                        [siftArray addObject:cateDict];
                    }
                }
                else if ([obj isEqualToString:@"goodsBrandList"])
                {
                    NSMutableArray *siftBrandArray = [NSMutableArray array];
                    NSArray *brandArray = dataDict[@"goodsBrandList"];
                    for (int i = 0; i < brandArray.count; i ++) {
                        NSDictionary *brandDict = brandArray[i];
                        Fcgo_BrandModel *model  = [Fcgo_BrandModel shareWithNSDictionary:brandDict];
                        if (model.selected.intValue == 1) {
                            self.brandIds = [NSString stringWithFormat:@"%@",model.brand_id];
                        }
                        [siftBrandArray addObject:model];
                    }
                    if (siftBrandArray.count>0) {
                        NSString *type = self.isMix?@"brand":@"mix";
                        NSDictionary *siftBrandDict = @{@"name":@"品牌",@"type":type,@"list":siftBrandArray};
                        [siftArray addObject:siftBrandDict];
                    }
                }
                else if ([obj isEqualToString:@"goodsCateDetailList"])
                {
                    NSMutableArray *siftCatemArray = [NSMutableArray array];
                    NSArray *catemArray = dataDict[@"goodsCateDetailList"];
                    for (int i = 0; i < catemArray.count; i ++) {
                        NSDictionary *catemDict = catemArray[i];
                        Fcgo_SiftCatemModel *model  = [Fcgo_SiftCatemModel yy_modelWithDictionary:catemDict];
                        if (model.selected.intValue == 1) {
                            self.catemIds = [NSString stringWithFormat:@"%@",model.f_catem_Id];
                        }
                        [siftCatemArray addObject:model];
                    }
                    if (siftCatemArray.count>0) {
                        NSString *type = self.isMix?@"catem":@"mix";
                        NSDictionary *catemDict = @{@"name":@"详细分类",@"type":type,@"list":siftCatemArray};
                        [siftArray addObject:catemDict];
                    }
                }
                else if ([obj isEqualToString:@"pros"])
                {
                    //商品属性是一个大数组，数组里面是各个属性的大字典，所以在加入筛选条件是，解析后的字典要额外添加一个属性type，记录他是attr,在发送筛选请求的时候用的到
                    NSArray *prosArray = dataDict[@"pros"];
                    for (int i = 0; i < prosArray.count; i ++) {
                        NSDictionary *prosDict = prosArray[i];
                        NSString *name = prosDict[@"name"];
                        NSArray  *attrArray = prosDict[@"dataList"];
                        NSString *type = self.isMix?@"attr":@"mix";
                        NSDictionary *attrDict = @{@"name":name,@"type":type,@"list":attrArray};
                        [siftArray addObject:attrDict];
                    }
                }
                else if ([obj isEqualToString:@"sgplist"])
                {
                    
                }
            }];
            weakSelf.siftVC.siftArray = siftArray;
            
        }
        else
        {
            [weakSelf showUIData:0];
        }
        
    } failureBlock:^(NSString *description) {
        [weakSelf showUIData:0];
    }];
}

- (void)showUIData:(BOOL)isShow
{
    [self showNoControl:!isShow titleString:@"网络错误,点击重新加载" imageString:@"ico_no-wifi"];
    self.collectionview.hidden = !isShow;
    self.typeView.hidden = !isShow;
}

- (void)showMoreUIData:(BOOL)isShow
{
    [self showNoControl:!isShow titleString:@"暂无商品哦" imageString:@"ico_no_box@2x"];
    self.collectionview.hidden = !isShow;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.page = 1;
    [self setupUI];
    [self basicDataAnalysis];
    [self reloadRequest];
}

- (void)setupUI;
{
    WEAKSELF(weakSelf)
    [self.navigationView addSubview:self.navView];
    self.navigationView.lineColor =  UIRGBColor(234, 234, 234, 1);
    
    [self.collectionview registerNib:[UINib nibWithNibName:NSStringFromClass([HotCollectionCell class]) bundle:nil] forCellWithReuseIdentifier:@"hotCollectionCell"];
    
    self.collectionview.mj_header = [Fcgo_RefreshNormalHeader headerRefreshBlock:^{
        [weakSelf reloadRequest];
    }];
    self.collectionview.mj_footer = [MJRefreshBackStateFooter footerWithRefreshingBlock:^{
        [weakSelf loadGoodsListRequest];
    }];
    [self.view insertSubview:self.collectionview belowSubview:self.navigationView];
    
    [self.table registerNib:[UINib nibWithNibName:NSStringFromClass([Fcgo_GoodsListTableCell class]) bundle:nil] forCellReuseIdentifier:@"goodsListTableCell"];
    
    self.table.mj_header = [Fcgo_RefreshNormalHeader headerRefreshBlock:^{
        [weakSelf reloadRequest];
    }];
    self.table.mj_footer = [MJRefreshBackStateFooter footerWithRefreshingBlock:^{
        [weakSelf loadGoodsListRequest];
    }];
    [self.view insertSubview:self.table belowSubview:self.navigationView];
    
    [self.view addSubview:self.typeView];
}

#pragma mark - collectionview delegate datasource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.goodsListArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HotCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"hotCollectionCell" forIndexPath:indexPath];
    if (self.goodsListArray.count>0) {
        cell.goodsModel = self.goodsListArray[indexPath.item];
        //[cell setGoodsDesLableHieghtIndex:indexPath.item];
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.goodsListArray.count>0) {
        Fcgo_HomeGoodsModel *model = self.goodsListArray[indexPath.item];
        //Fcgo_GoodsInfoVC *vc = [[Fcgo_GoodsInfoVC alloc]init];
        Fcgo_GoodsDetailVC *vc = [[Fcgo_GoodsDetailVC alloc]init];
        vc.hidesBottomBarWhenPushed = 1;
        vc.goodsType = @"normal";
        vc.goodsValue = [NSString stringWithFormat:@"%@",model.f_goods_id];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark - UICollectionViewFlowLayout delegate

//根据item的宽度与indexPath计算每一个item的高度
- (CGFloat)waterfallLayout:(XRWaterfallLayout *)waterfallLayout itemHeightForWidth:(CGFloat)itemWidth atIndexPath:(NSIndexPath *)indexPath {
    CGFloat width = (kScreenWidth - 21)/2;
//    if (indexPath.item == 5) {
//        return width + 120;
//    }
    return width + 75;
    
}

#pragma mark table delegate datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.goodsListArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Fcgo_GoodsListTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"goodsListTableCell"];
    
    if (self.goodsListArray.count>0) {
        cell.model = self.goodsListArray[indexPath.row];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 85+10;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.goodsListArray.count>0) {
        Fcgo_HomeGoodsModel *model = self.goodsListArray[indexPath.item];
        //Fcgo_GoodsInfoVC *vc = [[Fcgo_GoodsInfoVC alloc]init];
        Fcgo_GoodsDetailVC *vc = [[Fcgo_GoodsDetailVC alloc]init];
        vc.hidesBottomBarWhenPushed = 1;
        vc.goodsType = @"normal";
        vc.goodsValue = [NSString stringWithFormat:@"%@",model.f_goods_id];
        [self.navigationController pushViewController:vc animated:YES];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (!_collectionView_isDrag&&!_table_isDrag) {
        return;
    }
    if (scrollView == self.collectionview) {
        if (scrollView.contentOffset.y>_collectionView_lastContentOffset)
        {
            //向上
            if (!_collectionView_isDrag) {
                return;
            }
            [self upSlide];
        }
        else if (scrollView.contentOffset.y<_collectionView_lastContentOffset)
        {
            if (!_collectionView_isDrag) {
                return;
            }
            //向下
            [self downSlide];
        }
        
        if (self.collectionview.indexPathsForVisibleItems.count<=0||self.table.indexPathsForVisibleRows.count<=0)
        {
            return;
        }
        if (!self.collectionview.hidden)
        {
            if (self.table) {
                [self.table scrollToRowAtIndexPath:self.collectionview.indexPathsForVisibleItems.firstObject atScrollPosition:UITableViewScrollPositionMiddle animated:NO];
            }
        }
    }
    if (!self.table) {
        return;
    }
    if (scrollView == self.table) {
        if (scrollView.contentOffset.y>_table_lastContentOffset)
        {
            //向上
            if (!_table_isDrag) {
                return;
            }
            [self upSlide];
            
        }
        else if (scrollView.contentOffset.y<_table_lastContentOffset)
        {
            if (!_table_isDrag) {
                return;
            }
            //向下
            [self downSlide];
        }
        
        if (self.collectionview.indexPathsForVisibleItems.count<=0||self.table.indexPathsForVisibleRows.count<=0) {
            return;
        }
        if (!self.table.hidden)
        {
            [self.collectionview scrollToItemAtIndexPath:self.table.indexPathsForVisibleRows.firstObject atScrollPosition:UICollectionViewScrollPositionTop animated:NO];
        }
    }
}

- (void)upSlide
{
    WEAKSELF(weakSelf);
    if (_isUpAnimation) {
        return;
    }
    [UIView animateWithDuration:0.2 animations:^{
        _isUpAnimation = 1;
        weakSelf.navigationView.frame = CGRectMake(0, -kNavigationHeight, kScreenWidth, kNavigationHeight);
        weakSelf.typeView.frame = CGRectMake(0, kNavigationSubY(20), kScreenWidth, 40);
    }completion:^(BOOL finished) {
        _isUpAnimation = 0;
    }];
    weakSelf.collectionview.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    weakSelf.table.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
}

- (void)downSlide
{
    if (_isDownAnimation) {
        return;
    }
    WEAKSELF(weakSelf);
    [UIView animateWithDuration:0.2 animations:^{
        weakSelf.navigationView.frame = CGRectMake(0, 0, kScreenWidth, kNavigationHeight);
        weakSelf.typeView.frame = CGRectMake(0, kNavigationHeight, kScreenWidth, 40);
        _isDownAnimation = 1;
    }completion:^(BOOL finished) {
        _isDownAnimation = 0;
    }];
    weakSelf.collectionview.contentInset = UIEdgeInsetsMake(44, 0, 0, 0);;
    weakSelf.table.contentInset = UIEdgeInsetsMake(44, 0, 0, 0);
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if (scrollView == self.collectionview) {
        _collectionView_isDrag = YES;
        _collectionView_lastContentOffset = scrollView.contentOffset.y;
    }
    if (scrollView == self.table) {
        _table_isDrag = YES;
        _table_lastContentOffset = scrollView.contentOffset.y;
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (scrollView == self.collectionview) {
        _collectionView_isDrag = NO;
    }
    if (scrollView == self.table) {
        _table_isDrag = NO;
    }
    
}

#pragma mark - Lazy method
- (UITableView *)table
{
    if (!_table) {
        UITableView *table = [[UITableView alloc]initWithFrame:CGRectMake(0, kNavigationSubY(60), kScreenWidth, KScreenHeight - kNavigationSubY(60)) style:UITableViewStylePlain];
        table.delegate = self;
        table.dataSource = self;
        table.separatorStyle = 0;
        table.hidden = 1;
        table.backgroundColor = UIBackGroundColor;
        table.contentInset = UIEdgeInsetsMake(44, 0, 0, 0);
        table.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
        _table = table;
        if (@available(iOS 11.0, *)) {
            table.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return _table;
}

- (UICollectionView *)collectionview
{
    if (!_collectionview) {
        XRWaterfallLayout *waterfall = [[XRWaterfallLayout alloc]init];
        waterfall.rowSpacing = 7;
        waterfall.columnSpacing = 7;
        waterfall.sectionInset = UIEdgeInsetsMake(0, 7, 12, 7);
        waterfall.delegate = self;
        _collectionview = [[UICollectionView alloc]initWithFrame:CGRectMake(0, kNavigationSubY(60), kScreenWidth, KScreenHeight-kNavigationSubY(60)) collectionViewLayout:waterfall];
        _collectionview.backgroundColor = UIFontWhiteColor;
        _collectionview.contentInset = UIEdgeInsetsMake(44, 0, 0, 0);
        _collectionview.delegate = self;
        _collectionview.dataSource = self;
        if (@available(iOS 11.0, *)) {
            _collectionview.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return _collectionview;
}

- (Fcgo_GoodsListNavView *)navView
{
    WEAKSELF(weakSelf)
    if (!_navView) {
        _navView = [[Fcgo_GoodsListNavView alloc]initWithFrame:CGRectMake(0, kNavigationSubY(20), kScreenWidth, 30) back:^{
            [weakSelf.navigationController popViewControllerAnimated:YES];
        } changeList:^(BOOL selected){
            if (weakSelf.collectionview && weakSelf.table) {
                weakSelf.collectionview.hidden = selected;
                weakSelf.table.hidden = !selected;
            }
        } search:^(NSString *string) {
            Fcgo_SearchVC *vc = [[Fcgo_SearchVC alloc]init];
            vc.isnopush = YES;
            vc.searchBlock = ^(NSString *string)
            {
                [weakSelf resetbasicDataAnalysis];
                
                weakSelf.words = string;
                
                [weakSelf basicDataAnalysis];
                
                [weakSelf reloadRequest];
            };
            [weakSelf.view addSubview:vc.view];
            [weakSelf addChildViewController:vc];
        }];
    }
    return _navView;
}

- (Fcgo_GoodsListTypeView *)typeView
{
    WEAKSELF(weakSlef);
    if (!_typeView) {
        Fcgo_GoodsListTypeView *typeView = [[Fcgo_GoodsListTypeView alloc]initWithFrame:CGRectMake(0, kNavigationHeight, kScreenWidth, 40) rate:^{
            
        } sale:^(NSInteger type) {
            weakSlef.f_orderby = @"f_sale_num";
            if (type ==1) {
                weakSlef.f_asc = @"desc";
            }
            else{
                weakSlef.f_asc = @"asc";
            }
            [weakSlef reloadRequest];
        } price:^(NSInteger type) {
            weakSlef.f_orderby = @"f_price";
            if (type ==1) {
                weakSlef.f_asc = @"asc";
            }
            else{
                weakSlef.f_asc = @"desc";
            }
            [weakSlef reloadRequest];
        } sift:^{
            [weakSlef.view addSubview:weakSlef.siftVC.view];
        }];
        _typeView = typeView;
    }
    return _typeView;
}

- (NSMutableArray *)goodsListArray
{
    if (!_goodsListArray) {
        _goodsListArray = [[NSMutableArray alloc]init];
    }
    return _goodsListArray;
}

- (NSMutableArray *)attrArray
{
    if (!_attrArray) {
        _attrArray = [[NSMutableArray alloc]init];
    }
    return _attrArray;
}

- (Fcgo_SiftVC *)siftVC
{
    WEAKSELF(weakSelf);
    if (!_siftVC) {
        _siftVC = [[Fcgo_SiftVC alloc]init];
        _siftVC.selectTradeItemBlock = ^(NSString *tradeId,NSString *type)
        {
            weakSelf.f_texe = tradeId;
            weakSelf.f_key = type;
            [weakSelf reloadRequest];
        };
        
        _siftVC.selectCateItemBlock = ^(NSString *cateId,NSString *type)
        {
            weakSelf.f_cateIds = cateId;
            weakSelf.f_key = type;
            
            [weakSelf reloadRequest];
        };
        
        _siftVC.selectBrandItemBlock = ^(NSString *brandId,NSString *type)
        {
            weakSelf.f_brandIds = brandId;
            weakSelf.f_key = type;
            
            [weakSelf reloadRequest];
        };
        
        _siftVC.selectCatemItemBlock = ^(NSString *catemId,NSString *type)
        {
            weakSelf.f_catemIds = catemId;
            weakSelf.f_key = type;
            
            [weakSelf reloadRequest];
        };
        _siftVC.selectAttrItemBlock = ^(NSString *attr,NSString *type,BOOL isSelected)
        {
            weakSelf.f_key = type;
            
            if (isSelected) {
                [weakSelf.attrArray addObject:attr];
            }
            else{
                [weakSelf.attrArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    if ([obj isEqualToString:attr]) {
                        [weakSelf.attrArray removeObject:attr];
                    }
                    
                }];
            }
            [weakSelf reloadRequest];
        };
        _siftVC.resetBlock = ^{
            
            [weakSelf resetbasicDataAnalysis];
            [weakSelf basicDataAnalysis];
            [weakSelf reloadRequest];
        };
    }
    return _siftVC;
}

@end
