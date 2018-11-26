//
//  Fcgo_SearchVC.m
//  Fcgo
//
//  Created by huafanxiao on 2017/6/14.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_SearchVC.h"
#import "Fcgo_SiftMainCollectionCell.h"
#import "Fcgo_SearchCollectionTitleHeaderView.h"
#import "Fcgo_SortRightBrandCollectionViewCell.h"
#import "Fcgo_SearchHistoryCollectionViewCell.h"
#import "Fcgo_SearchHistoryDeleteCollectionViewCell.h"
#import "Fcgo_SearchNavView.h"
#import "Fcgo_SetupTableViewCell.h"
#import "Fcgo_GoodsListVC.h"

@interface Fcgo_SearchVC ()<UICollectionViewDelegate,UICollectionViewDataSource,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

@property (nonatomic,strong) UICollectionView   *collectionview;
@property (nonatomic,strong) UITableView        *table;
@property (nonatomic,strong) Fcgo_SearchNavView *navView;
@property (nonatomic,strong) NSArray            *titleArray;
@property (nonatomic,strong) NSMutableArray     *wordsArray;
@property (nonatomic,strong) NSMutableArray     *brandArray;
@property (nonatomic,strong) NSMutableArray     *historyArray;
@property (nonatomic,strong) NSArray            *keywordsArray;

@end

@implementation Fcgo_SearchVC

- (void)reloadRequest
{
    if (![Fcgo_Tools isNetworkConnected]) {
        [WSProgressHUD showImage:nil status:@"亲,没联网啊"];
        [self showUIData:NO];
        return;
    }
    WEAKSELF(weakSelf)
    [self.wordsArray removeAllObjects];
    [Fcgo_NetworkManager postRequest:NSFormatHeardMeThodUrl(ServiceLocalTypeOne, HOTSEARCHMETHOD, @"list") parametersContentCommon:nil successBlock:^(BOOL success, id responseObject, NSString *msg) {
        [weakSelf showUIData:1];
        if (success) {
            NSArray *wordsArray = responseObject[@"data"];
            for (int i = 0; i < wordsArray.count; i ++) {
                NSDictionary *wordsDict = wordsArray[i];
                if (weakSelf.wordsArray.count<8) {
                    [weakSelf.wordsArray addObject:wordsDict[@"name"]];
                }
            }
            [weakSelf.collectionview reloadSections:[NSIndexSet indexSetWithIndex:0]];
        }
        else{
            [weakSelf showUIData:0];
        }
    } failureBlock:^(NSString *description) {
        [weakSelf showUIData:0];
    }];
    [Fcgo_NetworkManager postRequest:NSFormatHeardMeThodUrl(ServiceLocalTypeOne, GOODMETHOD, @"brand/hot/list") parametersContentCommon:nil successBlock:^(BOOL success, id responseObject, NSString *msg) {
        [weakSelf showUIData:1];
        if (success) {
            NSArray *dataArray = responseObject[@"data"];
            for (int i = 0; i < dataArray.count; i ++) {
                NSDictionary *dataDict = dataArray[i];
                if (weakSelf.brandArray.count<8) {
                    Fcgo_BrandModel *model = [ Fcgo_BrandModel shareWithNSDictionary:dataDict];
                    [weakSelf.brandArray addObject:model];
                }
            }
            [weakSelf.collectionview reloadSections:[NSIndexSet indexSetWithIndex:1]];
        }else{
            [weakSelf showUIData:0];
        }
    } failureBlock:^(NSString *description) {
        [weakSelf showUIData:0];
    }];
}

- (void)getHistoryWordsList
{
    WEAKSELF(weakSelf)
    [self.historyArray removeAllObjects];
    NSArray *array = [OBJC_Defaults objectForKey:@"history_words"];
    if (!array || array.count<=0) {
        self.titleArray = @[@"大家都在搜",@"热门品牌"];
    }
    else
    {
       self.titleArray = @[@"大家都在搜",@"热门品牌",@"最近搜索",@""];
        [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
           [weakSelf.historyArray addObject:obj];
        }];
    }
    [self.collectionview reloadData];
}


- (void)requestContactWords:(NSString *)string
{
    WEAKSELF(weakSelf)
    NSMutableDictionary *paremeters =[NSMutableDictionary  dictionary];
    [paremeters setObjectWithNullValidate:string forKey:@"keyWords"];
    
    [Fcgo_NetworkManager postRequest:NSFormatHeardMeThodUrl(ServiceLocalTypeOne, GOODMETHOD, @"searchKey") parametersContentCommon:paremeters successBlock:^(BOOL success, id responseObject, NSString *msg) {
        
        if (success) {
            NSNumber *errCode = responseObject[@"errorCode"];
            if (errCode.intValue == 0) {
                weakSelf.keywordsArray = responseObject[@"data"];
                if (weakSelf.keywordsArray) {
                    [weakSelf.table reloadData];
                }
            }
        }
    } failureBlock:^(NSString *description) {}];
}

- (void)showUIData:(BOOL)isShow
{
    [self showNoControl:!isShow titleString:@"网络错误,点击重新加载" imageString:@"ico_no-wifi"];
    self.collectionview.hidden = !isShow;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self getHistoryWordsList];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupUI];
    [self reloadRequest];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField.text.length>0) {
        [self saveWordsToLocalWithWords:textField.text];
    }
    if (self.isnopush == YES) {
        if (self.searchBlock) {
            self.searchBlock(textField.text);
        }
        [self.view removeFromSuperview];
        [self removeFromParentViewController];
    }
    else{
        [self pushGoodsListWithWords:textField.text brandID:@""];
    }
    self.table.hidden = 1;
    [textField resignFirstResponder];
    return YES;
}

- (void)saveWordsToLocalWithWords:(NSString *)words
{
    for (int i = 0;  i < self.historyArray.count;i ++) {
        NSString *str = self.historyArray[i];
        if ([str isEqualToString:words]) {
            [self.historyArray removeObject:str];
        }
    }
    if (self.historyArray.count>=10) {
        [self.historyArray removeObjectAtIndex:0];
    }
    [self.historyArray addObject:words];
    [OBJC_Defaults setObject:self.historyArray forKey:@"history_words"];
}

- (void)setupUI
{
    //WEAKSELF(weakSelf)
    [self.navigationView addSubview:self.navView];
    self.navView.searchTextField.delegate = self;
    [self.navView.searchTextField becomeFirstResponder];

    [self.collectionview registerClass:[Fcgo_SearchCollectionTitleHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"searchCollectionTitleHeaderView"];
    
    [self.collectionview registerNib:[UINib nibWithNibName:NSStringFromClass([Fcgo_SiftMainCollectionCell class]) bundle:nil] forCellWithReuseIdentifier:@"siftMainCollectionCell"];
    [self.collectionview registerNib:[UINib nibWithNibName:NSStringFromClass([Fcgo_SortRightBrandCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:@"sortRightBrandCollectionViewCell"];
    [self.collectionview registerNib:[UINib nibWithNibName:NSStringFromClass([Fcgo_SearchHistoryCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:@"searchHistoryCollectionViewCell"];
    [self.collectionview registerNib:[UINib nibWithNibName:NSStringFromClass([Fcgo_SearchHistoryDeleteCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:@"searchHistoryDeleteCollectionViewCell"];
    [self.view addSubview:self.collectionview];
    
    [self.collectionview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(kNavigationHeight);
        make.bottom.mas_offset(0);
        make.left.mas_offset(0);
        make.right.mas_offset(0);
    }];
    
    [self.table registerNib:[UINib nibWithNibName:NSStringFromClass([Fcgo_SetupTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"setupTableViewCell"];
    [self.view addSubview:self.table];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if(section == 0)
    {
        return self.wordsArray.count;
    }
    if(section == 1)
    {
        return self.brandArray.count;
    }
    if(section == 2)
    {
        return self.historyArray.count;
    }
    return 1;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    if (self.titleArray.count>0) {
        return self.titleArray.count;
    }
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0)
    {
        Fcgo_SiftMainCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"siftMainCollectionCell" forIndexPath:indexPath];
        if (indexPath.item<4) {
            cell.select = YES;
        }else{
            cell.select = NO;

        }
        if (self.wordsArray.count>0) {
            cell.titleLabel.text = self.wordsArray[indexPath.item];

        }
        return cell;
    }
    else if(indexPath.section == 1)
    {
      Fcgo_SortRightBrandCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"sortRightBrandCollectionViewCell" forIndexPath:indexPath];
        if (self.brandArray.count>0) {
            Fcgo_BrandModel *model = self.brandArray[indexPath.item];
            cell.model = model;
        }
        return cell;
        
    }
    else if(indexPath.section == 2)
    {
        Fcgo_SearchHistoryCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"searchHistoryCollectionViewCell" forIndexPath:indexPath];
        if (self.historyArray.count>0) {
            cell.titleLabel.text = self.historyArray[self.historyArray.count-1-indexPath.item];
        }
        return cell;
    }
    Fcgo_SearchHistoryDeleteCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"searchHistoryDeleteCollectionViewCell" forIndexPath:indexPath];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if (kind == UICollectionElementKindSectionHeader) {
        Fcgo_SearchCollectionTitleHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"searchCollectionTitleHeaderView" forIndexPath:indexPath];
        headerView.titleLabel.text = self.titleArray[indexPath.section];
        headerView.backgroundColor = UIFontWhiteColor;
        [headerView addSubview:headerView.titleLabel];
        [headerView.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(15);
            make.top.mas_offset(0);
            make.bottom.mas_offset(0);
        }];
        return headerView;
    }
    return nil;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self.view endEditing:YES];
    self.table.hidden = 1;
    if (indexPath.section == 0)
    {
        if (self.wordsArray.count>0) {
            NSString *name = self.wordsArray[indexPath.item];
             [self saveWordsToLocalWithWords:name];
            self.navView.searchTextField.text = name;
            if (self.isnopush == YES) {
                if (self.searchBlock) {
                    self.searchBlock(name);
                }
                [self.view removeFromSuperview];
                [self removeFromParentViewController];
            }else{
                 [self pushGoodsListWithWords:name brandID:@""];
            }
           
        }
    }
    else if (indexPath.section == 1)
    {
        if (self.brandArray.count>0) {
            Fcgo_BrandModel *model = self.brandArray[indexPath.item];
             [self saveWordsToLocalWithWords:model.brand_name];
            self.navView.searchTextField.text = model.brand_name;
            
            if (self.isnopush == YES) {
                if (self.searchBlock) {
                    self.searchBlock(model.brand_name);
                }
                [self.view removeFromSuperview];
                [self removeFromParentViewController];
            }else{
                [self pushGoodsListWithWords:@"" brandID:[NSString stringWithFormat:@"%@",model.brand_id]];
            }
            
        }
    }
    else if (indexPath.section == 2)
    {
        if (self.historyArray.count>0) {
            NSString *name = self.historyArray[self.historyArray.count-1-indexPath.item];
            [self saveWordsToLocalWithWords:name];
            self.navView.searchTextField.text = name;
            if (self.isnopush == YES) {
                if (self.searchBlock) {
                    self.searchBlock(name);
                }
                [self.view removeFromSuperview];
                [self removeFromParentViewController];
            }else{
                [self pushGoodsListWithWords:name brandID:@""];
            }
        }
    }
    else if (indexPath.section == 3) {
        
        WEAKSELF(weakSelf)
        [Fcgo_AlertAnimationView showWithTitle:@"提示" text:@"确认删除全部历史记录" cancelTitle:@"取消" confirmTitle:@"确定" block:^{
            [weakSelf.historyArray removeAllObjects];
            weakSelf.titleArray = @[@"大家都在搜",@"热门品牌"];
            [OBJC_Defaults setObject:self.historyArray forKey:@"history_words"];
            [weakSelf.collectionview reloadData];
        }];
    }
}

- (void)pushGoodsListWithWords:(NSString *)words brandID:(NSString *)brand_id;
{
    Fcgo_GoodsListVC *vc = [[Fcgo_GoodsListVC alloc]init];
    if (words && ![words isEqualToString:@""]) {
        vc.words = words;
        vc.key = @"search";
    }
    else{
        vc.brandIds = brand_id;
        vc.key = @"brand";
    }
    [self.navigationController pushViewController:vc animated:YES];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (self.wordsArray.count>0) {
            NSString *name = self.wordsArray[indexPath.item];
            CGFloat width = [name boundingRectWithSize:CGSizeMake(1000, kAutoWidth6(25)) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:UIFontSize(12)} context:nil].size.width;
            if (width + kAutoWidth6(15)<kAutoWidth6(60)) {
                width = kAutoWidth6(60);
            }
            else{
                width = width + kAutoWidth6(15);
            }
            return CGSizeMake(width, 25);
        }
        return CGSizeMake(0, 25);
    }
    else if (indexPath.section == 1) {
        return CGSizeMake(kAutoWidth6(75), kAutoWidth6(40));
    }
    if (indexPath.section == 2) {
        return CGSizeMake(kScreenWidth, 50);
    }
    
    return CGSizeMake(120, 30);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if (section == 3) {
        return CGSizeMake(kScreenWidth, 0);
    }
    return CGSizeMake(kScreenWidth, 40);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    if (section < 2) {
        return UIEdgeInsetsMake(15, 12, 15, 12);
    }
    if (section == 3) {
        return UIEdgeInsetsMake(12, (kScreenWidth-120)/2, 12, (kScreenWidth-120)/2);
    }
    
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    if (section < 2) {
        return 15;
    }
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    if (section < 2) {
        return 15;
    }
    return 0;
}

#pragma mark table delegate datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.keywordsArray) {
        return self.keywordsArray.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Fcgo_SetupTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"setupTableViewCell"];
    if (self.keywordsArray.count>0) {
        cell.titleLabel.text = self.keywordsArray[indexPath.row];
    }
    cell.arrowImageView.hidden = 1;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kAutoWidth6(50);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.keywordsArray.count>0) {
        NSString *key = self.keywordsArray[indexPath.row];
        [self saveWordsToLocalWithWords:key];
        
        if (self.isnopush == YES) {
            if (self.searchBlock) {
                self.searchBlock(key);
            }
            [self.view removeFromSuperview];
            [self removeFromParentViewController];
        }
        else{
              [self pushGoodsListWithWords:key brandID:@""];
        }
        self.table.hidden = 1;
        [self.navView.searchTextField resignFirstResponder];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
   [self.view endEditing:YES];
}

#pragma mark Lazy method

- (UITableView *)table
{
    if (!_table) {
        UITableView *table = [[UITableView alloc]initWithFrame:CGRectMake(0, kNavigationHeight, kScreenWidth, KScreenHeight - kNavigationHeight) style:UITableViewStylePlain];
        table.delegate = self;
        table.dataSource = self;
        table.backgroundColor = UIFontWhiteColor;
        //table.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
        table.hidden = 1;
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
        UICollectionViewLeftAlignedLayout *flowLayout= [[UICollectionViewLeftAlignedLayout alloc]init];
        _collectionview = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _collectionview.backgroundColor = UIFontWhiteColor;
        _collectionview.delegate = self;
        _collectionview.dataSource = self;
        _collectionview.tag = 350;
        _collectionview.showsHorizontalScrollIndicator = NO;
        _collectionview.alwaysBounceVertical = YES;
        if (@available(iOS 11.0, *)) {
            _collectionview.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return _collectionview;
}

- (Fcgo_SearchNavView *)navView
{
    WEAKSELF(weakSelf)
    if (!_navView) {
        _navView = [[Fcgo_SearchNavView alloc]initWithFrame:CGRectMake(0, kNavigationSubY(20), kScreenWidth, 44) cancel:^{
            if (weakSelf.isnopush == YES) {
                [weakSelf.view removeFromSuperview];
                [weakSelf removeFromParentViewController];
            }else{
                 [weakSelf.navigationController popViewControllerAnimated:YES];
            }
           
        } start:^(BOOL containText,NSString *string){
            [weakSelf requestContactWords:string];
            weakSelf.table.hidden = !containText;
        } search:^(NSString *string) {
            if (weakSelf.isnopush == YES) {
                if (weakSelf.searchBlock) {
                    weakSelf.searchBlock(string);
                }
                [weakSelf.view removeFromSuperview];
                [weakSelf removeFromParentViewController];
            }
            else{
                
            }
        }];
    }
    return _navView;
}

- (NSMutableArray *)wordsArray
{
    if (!_wordsArray) {
        _wordsArray = [[NSMutableArray alloc]init];
    }
    return _wordsArray;
}

- (NSMutableArray *)brandArray
{
    if (!_brandArray) {
        _brandArray = [[NSMutableArray alloc]init];
    }
    return _brandArray;
}

- (NSMutableArray *)historyArray
{
    if (!_historyArray) {
        _historyArray = [[NSMutableArray alloc]init];
    }
    return _historyArray;
}

@end

