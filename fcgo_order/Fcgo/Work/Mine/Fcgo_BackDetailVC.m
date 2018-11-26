//
//  Fcgo_BackDetailVC.m
//  Fcgo
//
//  Created by fcg on 2017/10/26.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_BackDetailVC.h"
#import "Fcgo_BackDetailCell.h"
#import "Fcgo_uploadPicTabCell.h"
#import "Fcgo_AfterSaleVC.h"
#import "Fcgo_BackPictureCollectionCell.h"
#import "HXPhotoViewController.h"
#import "Fcgo_UploadPicVC.h"
#import "Fcgo_RefoundWebVC.h"

@interface Fcgo_BackDetailVC ()<UITableViewDelegate,UITableViewDataSource,HXPhotoViewControllerDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UINavigationControllerDelegate,UIImagePickerControllerDelegate,Fcgo_UploadImageManagerDelegate>

@property (nonatomic,strong) UIView         *mainScrollContentView;
@property (nonatomic,strong) UIView         *backMoneyView;
@property (nonatomic,strong) UITableView    *table;
@property (nonatomic,strong) UITableView    *table1;
@property (nonatomic,strong) UILabel        *backMoneyLab;

@property(nonatomic,strong) UICollectionView *collectionview;
@property(nonatomic,strong) NSMutableArray   *collectionDataArray;
@property(nonatomic,strong) NSArray          *currentTableDataArr1;//赔付金额详情
@property(nonatomic,strong) NSArray          *currentTableDataArr2;//破损照片分类
@property(nonatomic,strong) NSNumber         *returnPrice;
@property(nonatomic,strong) NSMutableArray   *returnPriceArr;
@property(nonatomic,assign) BOOL             isShowPrice;
@property(nonatomic,strong) NSMutableArray   *imgUploadArr;//图片是否上传
@property(nonatomic,strong) NSMutableArray   *imgArr;//所有图片集合
@property(nonatomic,assign) int              packageNum;
@property(nonatomic,assign) BOOL             isFirst;//第一次显示 无理由退货的提示
//@property (nonatomic, strong) UILongPressGestureRecognizer *longPress;
@property (strong, nonatomic) HXPhotoManager *manager;
@property (strong, nonatomic) NSMutableArray<HXPhotoModel *> *photosArr;
@end

@implementation Fcgo_BackDetailVC
-(void)viewDidAppear:(BOOL)animated{
    if (!_isFirst) {
        return;
    }
    WEAKSELF(weakSelf)
    if ([_reason isEqualToString:@"无理由退货"]) {
        [Fcgo_AlertAnimationView showWithTitle:@"提示" text:@"无理由退货需要扣除运费和手续费，大贸手续费为15元，保税直邮手续费为商品总价的30%。" cancelTitle:@"返回" confirmTitle:@"确定" cancelBlock:^{
            [weakSelf.navigationController popViewControllerAnimated:YES];
        } block:^{
        }];
    }
    _isFirst = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _packageNum = [[self intBetweenString:self.model.properties] intValue];
    NSArray *array = @[@"申请补偿",@"仅退款",@"退货退款"];
    _isShowPrice = YES;
    _isFirst = YES;
    _photosArr = [[NSMutableArray alloc] init];
    if ((_type == 0&&[_reason isEqualToString:@"效期不符"])||(_type == 0&&[_reason isEqualToString:@"商品发错"])) {
        _isShowPrice = NO;
    }
    WEAKSELF(weakSelf)
    [self.navigationView setupBackBtnBlock:^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    }];
    [self.navigationView setupTitleLabelWithTitle:array[_type]];
    self.navigationView.isShowLine = 1;
    
    _currentTableDataArr1 = @[@"申请数量"];
    if (_type == 0) {
        _currentTableDataArr1 = @[@"补偿数量"];
    }
    _returnPrice = @0.00;
    _returnPriceArr = [[NSMutableArray alloc] init];
    [_returnPriceArr addObject:@0];
    if (_type == 0) {
        //申请补偿需要填
        if ([_reason isEqualToString:@"包装破损"]) {
            _currentTableDataArr1 = @[@"轻微破损，不影响售卖",@"中度破损，影响售卖",@"严重破损，严重影响售卖"];
            [_returnPriceArr removeAllObjects];
            for (int i=0; i<3; i++) {
                [_returnPriceArr addObject:@0];
            }
        }else if ([_reason isEqualToString:@"瘪罐(仅奶粉)"]){
            _currentTableDataArr1 = @[@"10%以下",@"10%-30%",@"30%-50%"];
            [_returnPriceArr removeAllObjects];
            for (int i=0; i<3; i++) {
                [_returnPriceArr addObject:@0];
            }
        }
    }
    NSString *file = [[NSBundle mainBundle] pathForResource:@"Fcgo_AfterSale" ofType:@"plist"];
    NSArray *tmpArray = [NSArray arrayWithContentsOfFile:file];
    NSDictionary *tmpDic = tmpArray[_type];
    _currentTableDataArr2 = [tmpDic objectForKey:_reason];
    if ([_reason containsString:@"爆罐"]||[_reason containsString:@"瘪罐"]) {
        if ([self.model.texe intValue] == 1) {
            _currentTableDataArr2 = [tmpDic objectForKey:_reason][0];
        }else{
            _currentTableDataArr2 = [tmpDic objectForKey:_reason][1];
        }
    }
    _imgUploadArr = [[NSMutableArray alloc] init];
    _imgArr = [[NSMutableArray alloc] init];
    
    for (int i=0; i<_currentTableDataArr2.count; i++) {
        [_imgUploadArr addObject:@0];
        NSArray *array = @[];
        [_imgArr addObject:array];
    }
    if (_imgArr.count == 0) {
        [_imgUploadArr addObject:@0];
        [_imgArr addObject:@[]];
    }
    
    if (@available(iOS 11.0, *)) {
        _table.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        _table1.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    self.automaticallyAdjustsScrollViewInsets = NO;

    [self setInterface];
    [self setUpTableView0];
    NSArray *collectContentArr = @[@"订单拦截",@"没有收到商品",@"拒收该商品(商品破损等)",@"拒收该商品(无理由拒收)",@"无理由退货"];
    
    if ([collectContentArr containsObject:_reason]) {
        [self setupCollectionView];
    }else{
        [self setUpTableView1];
    }
  
    [self setSubmitBtn];
   
    
    // Do any additional setup after loading the view.
}
-(void)setSubmitBtn{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundColor:UIFontRedColor];
    [button setTitle:@"提交" forState:UIControlStateNormal];
    [button.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [button setTitleColor:UIFontWhiteColor forState:UIControlStateNormal];
    [button addTarget:self action:@selector(submit) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    [self.view bringSubviewToFront:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view);
        make.width.and.centerX.equalTo(self.view);
        make.height.mas_equalTo(kAutoHeight6(50));
    }];
}
//提交

-(void)submit{
    WEAKSELF(weakSelf)
    int totalNum = 0;
    for (id obj in _returnPriceArr) {
        totalNum = totalNum + [obj intValue];
    }
    if (totalNum <= 0) {
        [WSProgressHUD showImage:nil status:@"未有商品赔付"];
        return;
    }
    for (int i=0; i<_imgUploadArr.count; i++) {
        if ([_imgUploadArr[i] boolValue] == 0) {
            [WSProgressHUD showImage:nil status:@"部分图片未上传"];
            return;
        }
    }
    if (_collectionDataArray && _collectionDataArray.count > 0) {
        [WSProgressHUD showWithStatus:@"照片上传中..." maskType:WSProgressHUDMaskTypeClear];
        [self startUploadImageWithImage:_collectionDataArray];
    }else{
        [self submitMesg];
    }
    
   
    
    
}
-(void)submitMesg{
    [WSProgressHUD showImage:nil status:@"售后申请提交中..."];
    NSMutableDictionary *paremeters =[NSMutableDictionary  dictionary];
    [paremeters setObjectWithNullValidate:self.model.f_apply_id forKey:@"orderChildId"];
    [paremeters setObjectWithNullValidate:(_type == 0)?@"申请补偿":((_type == 1)?@"仅退款":@"退货退款") forKey:@"afterSaleType"];
    [paremeters setObjectWithNullValidate:_reason forKey:@"reason"];
    [paremeters setObjectWithNullValidate:self.model.goodsBuynum forKey:@"refundNumber"];
    [paremeters setObjectWithNullValidate:_returnPrice forKey:@"refundPrice"];
    
    NSMutableDictionary   *tempDic = [NSMutableDictionary dictionary];
    for (int i=0; i<_currentTableDataArr1.count; i++) {
        [tempDic  setObjectWithNullValidate:_returnPriceArr[i] forKey:_currentTableDataArr1[i]];
    }
    [paremeters setObjectWithNullValidate:[Fcgo_publicNetworkTools dictionaryToJson:tempDic] forKey:@"destoryReason"];
    //    NSMutableString *imgStr = [[NSMutableString alloc] init];
    //    for (int i=0; i<_imgArr.count; i++) {
    //        NSArray *tempArr = _imgArr[i];
    //        for (int j=0; j<tempArr.count; j++) {
    //            [imgStr appendString:tempArr[j]];
    //            [imgStr appendString:@","];
    //        }
    //    }
    //    [paremeters setObjectWithNullValidate:imgStr forKey:@"picurls"];
    
    NSMutableDictionary   *tempDic1 = [NSMutableDictionary dictionary];
    if (_currentTableDataArr2 && _currentTableDataArr2.count > 0) {
        for (int i=0; i<_currentTableDataArr2.count; i++) {
            NSMutableString *imgStr = [[NSMutableString alloc] init];
            NSArray *tempArr = _imgArr[i];
            for (int j=0; j<tempArr.count; j++) {
                [imgStr appendString:tempArr[j]];
                [imgStr appendString:@","];
            }
            [tempDic1  setObjectWithNullValidate:imgStr forKey:_currentTableDataArr2[i]];
            
        }
    }else{
        NSMutableString *imgStr = [[NSMutableString alloc] init];
        NSArray *tempArr = _imgArr[0];
        for (int j=0; j<tempArr.count; j++) {
            [imgStr appendString:tempArr[j]];
            [imgStr appendString:@","];
        }
        [tempDic1  setObjectWithNullValidate:imgStr forKey:@"picurls"];
    }
    
    [paremeters setObject:[Fcgo_publicNetworkTools dictionaryToJson:tempDic1] forKey:@"picurls"];
    
    [Fcgo_NetworkManager postRequest:NSFormatHeardMeThodUrl(ServiceLocalTypeOne, ORDERMETHOD, @"addAfterSale") parametersContentCommon:paremeters successBlock:^(BOOL success, id responseObject, NSString *msg) {
        if (success) {
            [WSProgressHUD showImage:nil status:@"申请成功"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popToViewController:self.backVC animated:YES];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"applyFinish" object:nil];
            });
        }else{
            [WSProgressHUD showWithStatus:responseObject[@"errorMsg"]];
        }
    } failureBlock:^(NSString *description) {
        
    }];
    
    
}
-(void)setUpTableView0{
    _table = [[UITableView alloc] initWithFrame:CGRectMake(0, 193, kScreenWidth, 220) style:UITableViewStylePlain];
    _table.delegate = self;
    _table.dataSource = self;
    _table.bounces = NO;
    _table.scrollEnabled = NO;
    _table.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_mainScrollContentView addSubview:_table];
    [self.table mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(_mainScrollContentView);
        make.top.equalTo(_backMoneyView.mas_bottom);
        make.height.mas_equalTo((_currentTableDataArr1.count == 1)?kAutoHeight6(88):kAutoHeight6(220));
    }];
    
}
-(void)setUpTableView1{
    _table1 = [[UITableView alloc] initWithFrame:CGRectMake(0, 440, kScreenWidth, 220) style:UITableViewStylePlain];
    _table1.delegate = self;
    _table1.dataSource = self;
    _table1.bounces = NO;
    _table1.scrollEnabled = NO;
    _table1.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_mainScrollContentView addSubview:_table1];
    [self.table1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(_mainScrollContentView);
        make.top.equalTo(_table.mas_bottom);
        make.height.mas_equalTo(kAutoHeight6(44*_currentTableDataArr2.count + 29));
    }];
    
    
    [_mainScrollContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_table1).offset(100);
    }];
}
- (void)setupCollectionView
{
    //    WEAKSELF(weakSelf)
    _collectionDataArray = [[NSMutableArray alloc] init];
    UICollectionViewFlowLayout *flowLayout= [[UICollectionViewFlowLayout alloc]init];
    flowLayout.minimumInteritemSpacing = 12;
    flowLayout.minimumLineSpacing = 12;
    _collectionview = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 415, kScreenWidth, KScreenHeight - 415 - 40) collectionViewLayout:flowLayout];
    _collectionview.backgroundColor = UIFontWhiteColor;
    _collectionview.delegate = self;
    _collectionview.dataSource = self;
    _collectionview.bounces = NO;
    [_collectionview setScrollEnabled:NO];
    _collectionview.userInteractionEnabled = YES;
    if (@available(iOS 11.0, *)) {
        _collectionview.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }

    [_collectionview registerClass:[Fcgo_BackPictureCollectionCell class] forCellWithReuseIdentifier:@"backDetailCollectionCell"];
    //注册headerView
    [_collectionview registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"backDetailCollectionHeaderView"];
    
    

    [_mainScrollContentView addSubview:_collectionview];
    CGFloat width = (kScreenWidth - 60)/4;

    [_collectionview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo((_collectionDataArray.count>3)?@(width*2 + 36 + 30):@(width + 24 + 30));
        make.width.and.centerX.equalTo(_mainScrollContentView);
        make.top.equalTo(_table.mas_bottom);
    }];
    
    [_mainScrollContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_collectionview).offset(100);
    }];
    
    
    //长按手势
//    _longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(lonePressMoving:)];
//    [self.collectionview addGestureRecognizer:_longPress];
    
}

//长按手势响应事件
/*
- (void)lonePressMoving:(UILongPressGestureRecognizer *)longPress
{
    
    switch (_longPress.state) {
        case UIGestureRecognizerStateBegan: {
            {
                NSIndexPath *selectIndexPath = [self.collectionview indexPathForItemAtPoint:[_longPress locationInView:self.collectionview]];
                // 找到当前的cell
                if ((selectIndexPath.row != _collectionDataArray.count)||_collectionDataArray.count == 6) {
                    Fcgo_BackPictureCollectionCell *cell = (Fcgo_BackPictureCollectionCell *)[self.collectionview cellForItemAtIndexPath:selectIndexPath];
                    // 定义cell的时候btn是隐藏的, 在这里设置为NO
                    [cell.btnDelete setHidden:NO];
                    //添加删除的点击事件
                    [cell.btnDelete addTarget:self action:@selector(btnDelete:) forControlEvents:UIControlEventTouchUpInside];
                    
                    [_collectionview beginInteractiveMovementForItemAtIndexPath:selectIndexPath];
                }
               
            }
            break;
        }
        case UIGestureRecognizerStateChanged: {
            [self.collectionview updateInteractiveMovementTargetPosition:[longPress locationInView:_longPress.view]];
            break;
        }
        case UIGestureRecognizerStateEnded: {
            [self.collectionview endInteractiveMovement];
            break;
        }
        default: [self.collectionview cancelInteractiveMovement];
            break;
    }
}
 */
#pragma mark---btn的删除cell事件

- (void)btnDelete:(UIButton *)button{
    
//    cell的隐藏删除设置
    Fcgo_BackPictureCollectionCell *cell = (Fcgo_BackPictureCollectionCell *)[button superview];
    
    NSIndexPath *selectIndexPath = [self.collectionview indexPathForCell:cell];
    // 找到当前的cell
//    Fcgo_BackPictureCollectionCell *cell = (Fcgo_BackPictureCollectionCell *)[self.collectionview cellForItemAtIndexPath:selectIndexPath];
    cell.btnDelete.hidden = NO;
    
    //取出源item数据
    id objc = [self.collectionDataArray objectAtIndex:selectIndexPath.row];
    //从资源数组中移除该数据
    [self.collectionDataArray removeObject:objc];
    if (_collectionDataArray.count) {
        [_imgUploadArr replaceObjectAtIndex:0 withObject:@1];
    }else{
        [_imgUploadArr replaceObjectAtIndex:0 withObject:@0];
    }
    [self.collectionview reloadData];
   
    [self.manager deleteSpecifiedModel:[_photosArr objectAtIndex:selectIndexPath.item]];
    if (selectIndexPath.row < _photosArr.count) {
        [_photosArr removeObject:[_photosArr objectAtIndex:selectIndexPath.row]];
    }
    [self changeSelectedListModelIndex];

    [self photoViewControllerDidNext:_photosArr Photos:_photosArr Videos:nil Original:1];
    
}
- (void)changeSelectedListModelIndex
{
    int i = 0, j = 0, k = 0;
    for (HXPhotoModel *model in self.manager.endSelectedList) {
        if ((model.type == HXPhotoModelMediaTypePhoto || model.type == HXPhotoModelMediaTypePhotoGif) || (model.type == HXPhotoModelMediaTypeCameraPhoto || model.type == HXPhotoModelMediaTypeLivePhoto)) {
            model.endIndex = i++;
        }else if (model.type == HXPhotoModelMediaTypeVideo || model.type == HXPhotoModelMediaTypeCameraVideo) {
            model.endIndex = j++;
        }
        model.endCollectionIndex = k++;
    }
}
#pragma mark - collectionView代理方法



- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
 
    if (_collectionDataArray.count < 6) {
        return _collectionDataArray.count + 1;
    }
    return 6;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *str = @"backDetailCollectionCell";
    Fcgo_BackPictureCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:str forIndexPath:indexPath];
    if ((indexPath.row == _collectionDataArray.count)&&_collectionDataArray.count!=6) {
        cell.imgView.image = [UIImage imageNamed:@"pic-"];
    }else{
        cell.imgView.image = _collectionDataArray[indexPath.row];
    }
    [cell.btnDelete addTarget:self action:@selector(btnDelete:) forControlEvents:UIControlEventTouchUpInside];
    if ((indexPath.row == _collectionDataArray.count)&&_collectionDataArray.count!=6) {
        cell.btnDelete.hidden = YES;
    }else{
        cell.btnDelete.hidden = NO;
    }
    
    return cell;
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"backDetailCollectionHeaderView" forIndexPath:indexPath];
    headerView.backgroundColor =UIRGBColor(246, 244, 242, 1);
    UILabel *label = [[UILabel alloc] init];
    label.text = @"上传图片";
    label.textColor = UIStringColor(@"#7b7b7b");
    label.font = [UIFont systemFontOfSize:12];
    [headerView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headerView).offset(kAutoWidth6(12));
        make.centerY.equalTo(headerView);
        make.size.mas_equalTo(CGSizeMake(200, 25));
    }];
    
    UILabel *label1 = [[UILabel alloc] init];
    label1.text = @"请按图例要求上传图片";
    label1.textColor = UIFontRedColor;
    label1.textAlignment = NSTextAlignmentRight;
    label1.font = [UIFont systemFontOfSize:11];
    [headerView addSubview:label1];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(headerView).offset(kAutoWidth6(-12));
        make.centerY.equalTo(headerView);
        make.size.mas_equalTo(CGSizeMake(200, 25));
    }];
    return headerView;
}

//点击item方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
 
    if (_collectionDataArray.count != 6 && indexPath.row == _collectionDataArray.count) {
        
        
        WEAKSELF(weakSelf)
        [Fcgo_SheetAnimationView showWithArray:@[@"相机",@"相册"] DidSelectedBlock:^(NSInteger index) {
            if (index == 0) {
                UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
                if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                    UIImagePickerController *picker = [[UIImagePickerController alloc]init];
                    picker.delegate = weakSelf;
                    picker.allowsEditing = YES;
                    picker.sourceType = sourceType;
                    [self  presentViewController:picker animated:YES completion:nil];
                }
                else {
                    
                }
            }
            else
            {
                HXPhotoViewController *vc = [[HXPhotoViewController alloc] init];
                vc.delegate = self;
                vc.manager = self.manager;
                [self presentViewController:[[UINavigationController alloc] initWithRootViewController:vc] animated:YES completion:nil];
            }
        }];
        
    }
   
}
- (HXPhotoManager *)manager
{
    if (!_manager) {
        _manager = [[HXPhotoManager alloc] initWithType:HXPhotoManagerSelectedTypePhoto];
        _manager.outerCamera = YES;
        _manager.openCamera = NO;
        _manager.maxNum = 6;
        _manager.photoMaxNum = 6;
    }
    return _manager;
}

/**
 点击下一步执行的代理  数组里面装的都是 HXPhotoModel 对象
 
 @param allList 所有对象 - 之前选择的所有对象
 @param photos 图片对象 - 之前选择的所有图片
 @param videos 视频对象 - 之前选择的所有视频
 @param original 是否原图
 */
#pragma mark - 上传图片代理方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    if ([type isEqualToString:@"public.image"]) {
        UIImage *image = [info objectForKey:@"UIImagePickerControllerEditedImage"];
        [self uploadHeadImageWithImage:@[image]];
        [picker dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}
- (void)photoViewControllerDidNext:(NSArray *)allList Photos:(NSArray *)photos Videos:(NSArray *)videos Original:(BOOL)original
{
    if (photos.count<=0) {
        return;
    }
    WEAKSELF(weakSelf)
    [HXPhotoTools fetchOriginalForSelectedPhoto:photos completion:^(NSArray<UIImage *> *images) {
    
        weakSelf.photosArr = photos.mutableCopy;
        [weakSelf uploadHeadImageWithImage:images];
    }];
    
}

- (void)uploadHeadImageWithImage:(NSArray<UIImage *> *)images
{
    NSMutableArray *imgeArr = [[NSMutableArray alloc] init];
    
    for (int i=0; i<images.count; i++) {
        UIImage *headImage = [Fcgo_Tools imageDealHandleWithImage:images[i]];
        [imgeArr addObject:headImage];
    }
    if (_collectionDataArray.count>0) {
        [_collectionDataArray removeAllObjects];
    }
    [_collectionDataArray addObjectsFromArray:imgeArr];
    if (_collectionDataArray.count) {
        [_imgUploadArr replaceObjectAtIndex:0 withObject:@1];
    }else{
        [_imgUploadArr replaceObjectAtIndex:0 withObject:@0];
    }
    [_collectionview reloadData];
    CGFloat width = (kScreenWidth - 60)/4;
    [_collectionview mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo((_collectionDataArray.count>3)?@(width*2 + 36 + 30):@(width + 24 + 30));
    }];
}

- (void)startUploadImageWithImage:(NSMutableArray *)images
{
    [[Fcgo_UploadImageManager shareInstance] uploadImageFromImageArray:[[NSMutableArray alloc]initWithArray:images]];
    [Fcgo_UploadImageManager shareInstance].delegate = self;
    
}

-(void)uploadImagesSucceed:(NSMutableArray *)array
{
   

    [self  requestUpLoadHeadImg:array];
    
}

- (void)requestUpLoadHeadImg:(NSMutableArray *)array
{
//    [WSProgressHUD showImage:nil status:@"上传成功"];

    [self.imgArr replaceObjectAtIndex:0 withObject:array];

    [self submitMesg];
    return;
    
}

#pragma mark - UICollectionViewFlowLayout delegate

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    CGFloat width = (kScreenWidth - 60)/4;
    return CGSizeMake(width, width);
}

//header的size
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(0, 30);
}


//设置每个item的UIEdgeInsets
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(12, 12, 12, 12);
}



#pragma mark - 头部界面

-(void)setInterface{
    
    UIScrollView *sc = [[UIScrollView alloc] init];
    sc.backgroundColor = UIRGBColor(246, 244, 242, 1);
    [self.view addSubview:sc];
    [self.view insertSubview:sc belowSubview:self.navigationView];
    [sc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self.view);
        make.top.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
    _mainScrollContentView = [[UIView alloc] init];
    _mainScrollContentView.backgroundColor = UIRGBColor(246, 244, 242, 1);
    [sc addSubview:_mainScrollContentView];
    [_mainScrollContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(sc);
        make.width.equalTo(sc);
    }];
    
    
    //商品信息
    UIView *goodView = [[UIView alloc] init];
    goodView.backgroundColor = UIFontWhiteColor;
    [_mainScrollContentView addSubview:goodView];
    [goodView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(_mainScrollContentView);
        make.top.equalTo(_mainScrollContentView).offset(kNavigationHeight);
        make.centerX.equalTo(_mainScrollContentView);
        make.height.mas_equalTo(kAutoHeight6(104));
    }];
    UIImageView *goodImg = [[UIImageView alloc] initWithFrame:CGRectMake(kAutoWidth6(12), kAutoHeight6(12), kAutoWidth6(80), kAutoWidth6(80))];
    [goodImg sd_setImageWithURL:[NSURL URLWithString:self.model.goodsSkuPicurl] placeholderImage:[UIImage imageNamed:@"580X580"]];
    [goodView addSubview:goodImg];
    [goodImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.and.height.mas_equalTo(kAutoWidth6(66));
        make.centerY.equalTo(goodView);
        make.left.equalTo(goodView).offset(kAutoWidth6(10));
    }];
    UILabel *goodNameLab = [[UILabel alloc] init];
    goodNameLab.text = self.model.goodsName;
    goodNameLab.numberOfLines = 2;
    goodNameLab.font = UIFontSize(16);
    goodNameLab.textColor = UIFontBlack282828;
    [goodView addSubview:goodNameLab];
    [goodNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(goodImg.mas_right).offset(kAutoWidth6(5));
        make.right.equalTo(goodView).offset(-kAutoWidth6(12));
        make.top.equalTo(goodImg);
    }];
    
    UILabel *goodSttr = [[UILabel alloc] init];
    goodSttr.text = self.model.properties;
    goodSttr.numberOfLines = 2;
    goodSttr.font = UIFontSize(12);
    goodSttr.textColor = UIStringColor(@"#7b7b7b");
    [goodView addSubview:goodSttr];
    [goodSttr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(goodImg.mas_right).offset(kAutoWidth6(5));
        make.right.equalTo(goodView).offset(-kAutoWidth6(12));
        make.top.equalTo(goodNameLab.mas_bottom).offset(12);
    }];
    
    UILabel *lineLab = [[UILabel alloc] init];
    lineLab.backgroundColor = UINavSepratorLineColor;
    [goodView addSubview:lineLab];
    [lineLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(goodView).offset(kAutoWidth6(12));
        make.bottom.equalTo(goodView);
        make.right.equalTo(goodView);
        make.height.mas_equalTo(0.5);
    }];
    
    
    
    _backMoneyView = [[UIView alloc] init];
    _backMoneyView.backgroundColor = UIFontWhiteColor;
    [_mainScrollContentView addSubview:_backMoneyView];
    [_backMoneyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(goodView.mas_bottom);
        make.width.and.centerX.equalTo(_mainScrollContentView);
        make.height.equalTo(@(kAutoHeight6(44)));
    }];
    //退款原因
    
    UILabel *backMoneyLab = [[UILabel alloc] init];
    backMoneyLab.text = @"退款原因";
    if (_type == 0) {
        backMoneyLab.text = @"补偿原因";
    }
    backMoneyLab.textColor = UIStringColor(@"#7b7b7b");
    backMoneyLab.font = [UIFont systemFontOfSize:15];
    [_backMoneyView addSubview:backMoneyLab];
    [backMoneyLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_backMoneyView).offset(kAutoWidth6(12));
        make.top.equalTo(_backMoneyView).offset(kAutoHeight6(7));
        make.size.mas_equalTo(CGSizeMake(kAutoWidth6(200), kAutoHeight6(30)));
    }];
    
    
    UIButton *resonBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    resonBtn.frame = CGRectMake(0, 0, 200, kAutoHeight6(40));
    [resonBtn setImage:[UIImage imageNamed:@"icon_arrow"] forState:UIControlStateNormal];
    resonBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    resonBtn.contentMode = UIViewContentModeRight;
    resonBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, kAutoWidth6(24));

    resonBtn.imageEdgeInsets = UIEdgeInsetsMake(0, kAutoWidth6(188), 0, 0);
//    resonBtn.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    [resonBtn setTitle:self.reason forState:UIControlStateNormal];
    [resonBtn setTitleColor: UIFontBlack282828 forState:UIControlStateNormal];
    resonBtn.titleLabel.font = UIFontSize(13);
    resonBtn.titleLabel.textAlignment = NSTextAlignmentRight;
    [resonBtn addTarget:self action:@selector(changeBackReason) forControlEvents:UIControlEventTouchUpInside];
    [_backMoneyView addSubview:resonBtn];
    [resonBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(200, kAutoHeight6(44)));
        make.top.equalTo(_backMoneyView);
        make.right.equalTo(_backMoneyView).offset(-kAutoWidth6(12));
    }];
    
    
    UILabel *lineLab1 = [[UILabel alloc] init];
    lineLab1.backgroundColor = UIRGBColor(246, 244, 242, 1);
    [_backMoneyView addSubview:lineLab1];
    [lineLab1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_backMoneyView);
        make.left.equalTo(_backMoneyView).offset(kAutoWidth6(12));
        make.right.equalTo(_backMoneyView);
        make.height.mas_equalTo(1);
    }];

}
-(void)changeBackReason{
    
    [self.navigationController popViewControllerAnimated:NO];
    
}





#pragma mark tableview delegate



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == self.table) {
         return _currentTableDataArr1.count;
    }else{
        return _currentTableDataArr2.count;
    }
   
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (tableView == self.table) {
        static NSString  *str = @"Fcgo_BackDetailCell";
        Fcgo_BackDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
        if (cell == nil) {
            cell = [[Fcgo_BackDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell makeCellWithTitle:_currentTableDataArr1[indexPath.row] andNum:_returnPriceArr[indexPath.row] isBackNum:(_currentTableDataArr1.count == 1)?YES:NO];
        
        cell.countBlock = ^(Fcgo_BackDetailCell *cell, NSString *number) {
            //控制商品数量总和小于购买数量
            int totalNum = 0;
            NSMutableArray *tempReturnArr = [_returnPriceArr mutableCopy];
            [tempReturnArr replaceObjectAtIndex:indexPath.row withObject:number];
            //            cell.numberButton.maxValue = MAX_INPUT;
            for (id obj in tempReturnArr) {
                totalNum = totalNum + [obj intValue];
            }
            int maxNum = [self.model.goodsBuynum integerValue]*((_packageNum == 0)?1:_packageNum);
            if (totalNum > maxNum) {
                cell.numberButton.currentNumber = [_returnPriceArr[indexPath.row] intValue];
                number = _returnPriceArr[indexPath.row];
            }else{
                [_returnPriceArr replaceObjectAtIndex:indexPath.row withObject:number];
                
            }
            
            //商品的赔付价格
            if ([_reason isEqualToString:@"包装破损"]&&(_type == 0)) {
                _returnPrice = @((([_returnPriceArr[0] intValue]*5)+([_returnPriceArr[1] intValue]*10)+([_returnPriceArr[2] intValue]*20))*100);
            }else if ([_reason isEqualToString:@"瘪罐(仅奶粉)"]&&self.type == 0){
                if ([self.model.texe intValue] == 1) {
                    _returnPrice = @((([_returnPriceArr[0] intValue]*5)+([_returnPriceArr[1] intValue]*15)+([_returnPriceArr[2] intValue]*30))*100);
                }else{
                    _returnPrice = @((([_returnPriceArr[0] intValue]*5)+([_returnPriceArr[1] intValue]*10)+([_returnPriceArr[2] intValue]*20))*100);
                }
            }else if (_type == 0&&[_reason isEqualToString:@"效期不符"]){
                _returnPrice = @(500*[number intValue]);
            }else if ([_reason isEqualToString:@"无理由退货"]){
                
                double shouxuf = ([self.model.texe intValue] == 1)?15:(([self.model.allPriceYUAN doubleValue]/maxNum * [number intValue])*0.3);
                double yunfei = [self.model.freightYUAN doubleValue];
                double yuan = (([self.model.allPriceYUAN doubleValue]/maxNum * [number intValue])-shouxuf-yunfei);
                if (yuan > 0) {
                    _returnPrice = [NSNumber numberWithInt:(yuan*100)];
                }else{
                    _returnPrice = @0;
                }
            }else{
                _returnPrice = [NSNumber numberWithInt:(([self.model.allPriceYUAN doubleValue]/maxNum * [number intValue])*100)];
            }
            
            _backMoneyLab.text = (_isShowPrice)?[NSString stringWithFormat:@"退款金额: ￥%.2f",[_returnPrice floatValue]*0.01]:([_reason isEqualToString:@"商品发错"]?@"按商品实际差价补偿":@"具体金额以退款标准为准");
            if ([_backMoneyLab.text containsString:@"退款金额"]) {
                NSMutableAttributedString *content = [[NSMutableAttributedString alloc]initWithString:_backMoneyLab.text];
                [content addAttribute:NSForegroundColorAttributeName value:UIFontRedColor range:NSMakeRange(5, _backMoneyLab.text.length - 5)];
                [content addAttribute:NSFontAttributeName value:UIFontSize(16) range:NSMakeRange(5, _backMoneyLab.text.length - 5)];
                _backMoneyLab.attributedText = content;
            }
            CGSize size = [_backMoneyLab sizeThatFits:CGSizeMake(2000, kAutoHeight6(30))];
            [_backMoneyLab mas_updateConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(CGSizeMake(kAutoWidth6(size.width), kAutoHeight6(30)));
            }];
           
        };
        return cell;
    }else{
        static NSString  *str = @"Fcgo_uploadPicTabCell";
        Fcgo_uploadPicTabCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
        if (cell == nil) {
            cell = [[Fcgo_uploadPicTabCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell makeCellWithTitle:_currentTableDataArr2[indexPath.row] andDidload:[_imgUploadArr[indexPath.row] boolValue]];
        return cell;
    }
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return kAutoHeight6(44);
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (tableView == self.table) {
        if (_currentTableDataArr1.count == 3) {
            return kAutoHeight6(44);
        }else{
            return 0;
        }
    }else{
        return kAutoHeight6(30);
    }
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (tableView == self.table) {
        return kAutoHeight6(44);
    }else{
        return 0;
    }

}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.table) {
        
    }else{
        Fcgo_UploadPicVC *vc = [[Fcgo_UploadPicVC alloc] init];
        vc.titleStr = _currentTableDataArr2[indexPath.row];
        NSMutableArray *mutArr = [[NSMutableArray alloc] init];
        NSArray *tempArr = _imgArr[indexPath.row];
        if (tempArr.count > 0) {
            for (int i=0; i<tempArr.count; i++) {
                [mutArr addObject:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:tempArr[i]]]]];
            }
        }
        vc.collectionDataArray = mutArr;
        vc.uploadImgSuccessBLock = ^ (NSMutableArray *imgArr){
            [_imgUploadArr replaceObjectAtIndex:indexPath.row withObject:@1];
            [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationTop];
            [self.imgArr replaceObjectAtIndex:indexPath.row withObject:imgArr];
        };
        [self.navigationController pushViewController:vc animated:YES];
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (tableView == self.table) {
        UIView *view = [[UIView alloc] init];
        
        UILabel *backMoneyLab = [[UILabel alloc] init];
        backMoneyLab.text = @"损坏程度";
        if ([_reason isEqualToString:@"瘪罐(仅奶粉)"]) {
            backMoneyLab.text = @"瘪罐程度";
        }
        backMoneyLab.textColor = UIFontBlack282828;
        backMoneyLab.font = [UIFont systemFontOfSize:15];
        [view addSubview:backMoneyLab];
        [backMoneyLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(view).offset(kAutoWidth6(12));
            make.centerY.equalTo(view);
            make.size.mas_equalTo(CGSizeMake(200, kAutoHeight6(30)));
        }];
        
        UILabel *lineLab = [[UILabel alloc] init];
        lineLab.backgroundColor = UIRGBColor(246, 244, 242, 1);
        [view addSubview:lineLab];
        [lineLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(view);
            make.left.equalTo(view).offset(kAutoWidth6(12));
            make.right.equalTo(view);
            make.height.mas_equalTo(0.5);
        }];
        return view;
    }else{
        UIView *headerView = [[UIView alloc] init];
        headerView.backgroundColor =UIRGBColor(246, 244, 242, 1);
        UILabel *label = [[UILabel alloc] init];
        label.text = @"上传图片";
        label.textColor = UIStringColor(@"#7b7b7b");
        label.font = [UIFont systemFontOfSize:12];
        [headerView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(headerView).offset(kAutoWidth6(12));
            make.centerY.equalTo(headerView);
            make.size.mas_equalTo(CGSizeMake(200, 25));
        }];
        return headerView;
    }
    
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    
    UIView *view = [[UIView alloc] init];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"退款金额标准" forState:UIControlStateNormal];
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    button.titleLabel.font = UIFontSize(12);
    [button setTitleColor:UIFontRedColor forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"icon_question"] forState:UIControlStateNormal];
    [button setImageEdgeInsets:UIEdgeInsetsMake(0, -kAutoHeight6(6), 0, 0)];
    NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc]initWithString:button.titleLabel.text];
    NSRange contentRange = {0,[attributeStr length]};
    [attributeStr addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:contentRange];
    button.titleLabel.attributedText = attributeStr;
    [button addTarget:self action:@selector(refoundAction) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view).offset(kAutoWidth6(18));
        make.centerY.equalTo(view);
        make.size.mas_equalTo(CGSizeMake(200, kAutoHeight6(30)));
    }];
    _backMoneyLab = [[UILabel alloc] init];
    _backMoneyLab.font = UIFontSize(12);
    _backMoneyLab.textColor = UIFontBlack282828;
    _backMoneyLab.text = (_isShowPrice)?[NSString stringWithFormat:@"退款金额: ￥%.2f",0.00]:([_reason isEqualToString:@"商品发错"]?@"按商品实际差价补偿":@"具体金额以退款标准为准");
    if ([_backMoneyLab.text containsString:@"退款金额"]) {
        NSMutableAttributedString *content = [[NSMutableAttributedString alloc]initWithString:_backMoneyLab.text];
        //    [content addAttribute:NSForegroundColorAttributeName value:UIFontMiddleGrayColor range:NSMakeRange(0, 5)];
        [content addAttribute:NSForegroundColorAttributeName value:UIFontRedColor range:NSMakeRange(5, _backMoneyLab.text.length - 5)];
        [content addAttribute:NSFontAttributeName value:UIFontSize(16) range:NSMakeRange(5, _backMoneyLab.text.length - 5)];
        _backMoneyLab.attributedText = content;
    }
  
    _backMoneyLab.textAlignment = NSTextAlignmentRight;
    [view addSubview:_backMoneyLab];
    CGSize size = [_backMoneyLab sizeThatFits:CGSizeMake(2000, kAutoHeight6(30))];

    [_backMoneyLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(view).offset(-kAutoWidth6(12));
        make.size.mas_equalTo(CGSizeMake(kAutoWidth6(size.width), kAutoHeight6(30)));
        make.centerY.equalTo(view);
    }];
    
    
    
    
    return view;
}


#pragma mark - 包装数
-(NSString *)intBetweenString:(NSString *)str{
    if ([Fcgo_Tools isNullString:str]) {
        return nil;
    }
    NSMutableString *mutStr = [[NSMutableString alloc] initWithString:str];
    mutStr = [mutStr stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString *shuzi = [[str componentsSeparatedByString:@"包装数:"] lastObject];
    NSMutableString *temp = [[NSMutableString alloc] init];
    for (int i=0; i<shuzi.length; i++) {
        if ([self isPureInt:[NSString stringWithFormat:@"%c",[shuzi characterAtIndex:i]]]) {
            [temp appendFormat:@"%c",[shuzi characterAtIndex:i]];
        }else{
            break;
        }
    }
    return temp;
}
//判断是否为数字
- (BOOL)isPureInt:(NSString*)string{
    
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return[scan scanInt:&val] && [scan isAtEnd];
    
}
#pragma mark - 退款金额标准

-(void)refoundAction{
    Fcgo_RefoundWebVC *refoundWebVC = [[Fcgo_RefoundWebVC alloc]init];
    refoundWebVC.urlString =  NSFormatHeardMeThodUrl(ServiceLocalTypeOne,COMMONMETHOD,@"refound");
    refoundWebVC.isShowNavBar = YES;
    [self.navigationController pushViewController:refoundWebVC animated:YES];
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
