//
//  Home_WholePointDetailVC.m
//  Fcgo
//
//  Created by huafanxiao on 2017/6/12.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Home_WholePointDetailVC.h"
#import "Fcgo_WholePointDetailView.h"
#import "Fcgo_GoodsDetailVC.h"

#import "Fcgo_GoodsInfoVC.h"
#import "Fcgo_WholePointModel.h"
#import "Fcgo_WholePointGoodsModel.h"

@interface Home_WholePointDetailVC ()<UIScrollViewDelegate>

@property (nonatomic,strong) ZKSegment    *zkSegment;
@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) NSMutableArray *wholePointArray;



@end

@implementation Home_WholePointDetailVC


- (void)reloadRequest
{
    if (![Fcgo_Tools isNetworkConnected]) {
        [self showUIData:NO];
        return;
    }
    WEAKSELF(weakSelf)
    [WSProgressHUD showWithStatus:@"加载中..." maskType:WSProgressHUDMaskTypeClear];
    [Fcgo_NetworkManager postRequest:NSFormatHeardMeThodUrl(ServiceLocalTypeOne,@"bis/promote/", @"integral/list") parametersContentCommon:nil successBlock:^(BOOL success, id responseObject, NSString *msg) {
        [WSProgressHUD dismiss];
        if(success)
        {
            NSDictionary *dataDict = (NSDictionary *)responseObject[@"data"];
            if (dataDict.count<=0) {
                return ;
            }
            [weakSelf.wholePointArray removeAllObjects];
            NSNumber *now =  dataDict[@"now"];
            NSArray *dataArray = dataDict[@"data"];
            for (int i = 0; i < dataArray.count; i ++) {
                NSDictionary *dict = dataArray[i];
                Fcgo_WholePointModel *model = [Fcgo_WholePointModel shareWithNSDictionary:dict];
                NSTimeInterval time = [[NSDate date] timeIntervalSince1970];
                long long dTime = [[NSNumber numberWithDouble:time] longLongValue];
                long long nowTime = now.longLongValue / 1000.0;
                model.time_interval = nowTime - dTime;
                [weakSelf.wholePointArray addObject:model];
            }
            [weakSelf reloadData];
        }
        else
        {
            [self showUIData:NO];
        }
    } failureBlock:^(NSString *description) {
       [self showUIData:NO];
    }];
}

- (void)reloadData
{
    WEAKSELF(weakSelf)
    [self.scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    self.scrollView.contentSize = CGSizeMake(kScreenWidth*self.wholePointArray.count, 0);
    NSMutableArray *titleArray = [NSMutableArray array];
    for (int i = 0; i < self.wholePointArray.count; i++) {
        Fcgo_WholePointModel *model = self.wholePointArray[i];
        //已结束
        NSArray *subTitle = @[model.name,model.tyeName];
        [titleArray addObject:subTitle];
        Fcgo_WholePointDetailView *view = [[Fcgo_WholePointDetailView alloc]initWithFrame:CGRectMake(kScreenWidth *i, 0, self.scrollView.mj_w, self.scrollView.mj_h)];
        view.selectedBlock = ^(Fcgo_WholePointGoodsModel *goodsModel){
//            Fcgo_GoodsInfoVC *vc = [[Fcgo_GoodsInfoVC alloc]init];
//            vc.hidesBottomBarWhenPushed = YES;
//            vc.goodsValue =  [NSString stringWithFormat:@"%@",goodsModel.f_integral_id];
//            vc.goodsType = @"integral";
//            [weakSelf.navigationController pushViewController:vc animated:YES];
            Fcgo_GoodsDetailVC *vc = [[Fcgo_GoodsDetailVC alloc]init];
            vc.hidesBottomBarWhenPushed = 1;
            vc.goodsValue =  [NSString stringWithFormat:@"%@",goodsModel.f_integral_id];
            vc.goodsType = @"integral";
            [weakSelf.navigationController pushViewController:vc animated:YES];
        };
        view.timeFinishBlock = ^{
            [weakSelf reloadRequest];
        };
        WholePointType type = WholePointEndType;
        if (model.type.intValue == 3) {
            type = WholePointEndType;
        }
        if (model.type.intValue == 2)
        {
            type = WholePointStartType;
        }
        if (model.type.intValue == 0)
        {
            type = WholePointNotStartType;
        }
        [view reloadTableDataWithModel:model type:type];
        [self.scrollView addSubview:view];
    }
    [self.zkSegment zk_setItems:titleArray];
    for (int i = 0; i < self.wholePointArray.count; i++) {
        
        Fcgo_WholePointModel *model = self.wholePointArray[i];
        if (model.type.intValue == 2)
        {
            [self.zkSegment zk_itemClickByIndex:i scroll:NO];
            [self.scrollView  setContentOffset:CGPointMake(kScreenWidth *i, 0) animated:0];
        }
    }
}

- (void)showUIData:(BOOL)isShow
{
    [self showNoControl:!isShow titleString:@"网络错误,点击重新加载" imageString:@"ico_no-wifi"];
    self.scrollView.hidden = !isShow;
    self.zkSegment.hidden = !isShow;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupUI];
    [self reloadRequest];
}

- (void)setupUI;
{
   WEAKSELF(weakSelf)
    [self.navigationView setupBackBtnBlock:^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    }];
    //[self.navigationView setupTitleLabelWithTitle:@"限时购  整点抢"];
    
    UIImageView *titleImageView = [[UIImageView alloc]init];
    titleImageView.center = CGPointMake(kScreenWidth/2, kNavigationSubY(42));
    titleImageView.bounds = CGRectMake(0, 0, kAutoWidth6(100), kAutoWidth6(100) *362/1400);
    
    titleImageView.image = [UIImage imageNamed:@"sekill_title_wholepoint"];
    [self.navigationView addSubview:titleImageView];
    
    self.zkSegment.zk_itemClickBlock = ^(NSString *itemName, NSInteger itemIndex)
    {
       [weakSelf.scrollView  setContentOffset:CGPointMake(kScreenWidth *itemIndex, 0) animated:0];
    };
    [self.view addSubview:self.zkSegment];
    [self.view addSubview:self.scrollView];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.tag == 300) {
    int index = scrollView.contentOffset.x/kScreenWidth;
    
    int  x = (int)scrollView.contentOffset.x % (int)kScreenWidth;
    if (x>kScreenWidth/2) {
        index = index+1;
    }
    [self.zkSegment zk_itemClickByIndex:index scroll:YES];
    }
}

- (ZKSegment *)zkSegment
{
    if (!_zkSegment) {
        ZKSegment *zkSegment = [ZKSegment
         zk_segmentWithFrame:CGRectMake(0, kNavigationHeight, self.view.bounds.size.width, 55)
         style:ZKSegmentRectangleStyle];
        zkSegment.zk_backgroundColor = UIStringColor(@"#595959");
        zkSegment.zk_itemStyleSelectedColor = UIFontRedColor;
        _zkSegment = zkSegment;
    }
    return _zkSegment;
}

- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, kNavigationHeight+55, kScreenWidth, KScreenHeight-kNavigationHeight-55)];
        scrollView.bounces = 1;
        scrollView.delegate = self;
        scrollView.pagingEnabled = 1;
        
        scrollView.tag = 300;
        _scrollView = scrollView;
        if (@available(iOS 11.0, *)) {
            scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return _scrollView;
}

- (NSMutableArray *)wholePointArray
{
    if (!_wholePointArray) {
        _wholePointArray = [[NSMutableArray alloc]init];
    }
    return _wholePointArray;
}

@end
