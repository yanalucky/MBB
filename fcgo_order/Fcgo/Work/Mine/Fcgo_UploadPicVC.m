//
//  Fcgo_UploadPicVC.m
//  Fcgo
//
//  Created by fcg on 2017/10/28.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_UploadPicVC.h"
#import "Fcgo_BackPictureCollectionCell.h"

@interface Fcgo_UploadPicVC ()<UICollectionViewDelegate,UICollectionViewDataSource,HXPhotoViewControllerDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,Fcgo_UploadImageManagerDelegate>

@property(nonatomic,strong) UICollectionView *collectionview;
//@property (nonatomic, strong) UILongPressGestureRecognizer *longPress;
@property (strong, nonatomic) HXPhotoManager *manager;
@property (strong, nonatomic) NSMutableArray<HXPhotoModel *> *photosArr;

@end

@implementation Fcgo_UploadPicVC

//获取拼音首字母(传入汉字字符串, 返回大写拼音首字母)
- (NSString *)firstCharactor:(NSString *)str
{
    // 转成可变
    NSMutableString * mStr = [NSMutableString stringWithString:str];
    // 转为带声调的拼音
    CFStringTransform((CFMutableStringRef)mStr, NULL, kCFStringTransformMandarinLatin, NO);
    // 再转换为不带声调的拼音
    CFStringTransform((CFMutableStringRef)mStr, NULL, kCFStringTransformStripDiacritics, NO);
    // 转化为大写拼音
    NSString * pinyin  = [mStr capitalizedString];
    // 做判断找出所有小写字母
    NSMutableString * First = [NSMutableString stringWithString:pinyin];
    NSString * ABC =[[NSString alloc]init];
    for (int i = 0; i<First.length; i++) {
        unichar C = [First characterAtIndex:i];
        // 找出所有的大写字母
        if(C<= 'Z' && C>='A') {
            ABC = [ABC stringByAppendingFormat:@"%C",C];
        }
    }
    // 获取并返回首字母
    return [ABC lowercaseString];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _photosArr = [[NSMutableArray alloc] init];

    WEAKSELF(weakSelf)
    [self.navigationView setupBackBtnBlock:^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    }];
    [self.navigationView setupTitleLabelWithTitle:_titleStr];
    self.navigationView.isShowLine = 1;
    
    self.view.backgroundColor = UIRGBColor(246, 244, 242, 1);
    [self setupCollectionView];
    [self setSubmitBtn];
    
}
-(void)setSubmitBtn{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundColor:UIFontRedColor];
    [button setTitle:@"提交" forState:UIControlStateNormal];
    [button.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [button setTitleColor:UIFontWhiteColor forState:UIControlStateNormal];
    [button addTarget:self action:@selector(submitPic:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    [self.view bringSubviewToFront:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view);
        make.width.and.centerX.equalTo(self.view);
        make.height.mas_equalTo(kAutoHeight6(50));
    }];
}
-(void)submitPic:(UIButton *)button{
    if (_collectionDataArray.count > 0 ) {
            [WSProgressHUD showWithStatus:@"照片上传中..." maskType:WSProgressHUDMaskTypeClear];
            [self startUploadImageWithImage:_collectionDataArray];
    }
}

- (void)setupCollectionView
{
    //    WEAKSELF(weakSelf)
    
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
    
    
    
    [self.view addSubview:_collectionview];
    CGFloat width = (kScreenWidth - 60)/4;

    [_collectionview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo((_collectionDataArray.count>=3)?@(width*2 + 36 + 30):@(width + 24 + 30));
        make.width.and.centerX.equalTo(self.view);
        make.top.equalTo(self.view).offset(kNavigationHeight);
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
                if (selectIndexPath.row == 0) {
                    break;
                }
                if ((selectIndexPath.row != _collectionDataArray.count + 1)||_collectionDataArray.count == 6) {
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

- (void)btnDelete:(UIButton *)btn{
    
    Fcgo_BackPictureCollectionCell *cell = (Fcgo_BackPictureCollectionCell *)[btn superview];
    
    NSIndexPath *selectIndexPath = [self.collectionview indexPathForCell:cell];
    //cell的隐藏删除设置
//    NSIndexPath *selectIndexPath = [self.collectionview indexPathForItemAtPoint:[_longPress locationInView:self.collectionview]];
    // 找到当前的cell
//    Fcgo_BackPictureCollectionCell *cell = (Fcgo_BackPictureCollectionCell *)[self.collectionview cellForItemAtIndexPath:selectIndexPath];
    cell.btnDelete.hidden = NO;
    
    //取出源item数据
    id objc = [self.collectionDataArray objectAtIndex:(selectIndexPath.row - 1)];
    //从资源数组中移除该数据
    [self.collectionDataArray removeObject:objc];
    
    [self.collectionview reloadData];
    
    [self.manager deleteSpecifiedModel:[_photosArr objectAtIndex:(selectIndexPath.row - 1)]];
    if ((selectIndexPath.row - 1) < _photosArr.count) {
        [_photosArr removeObject:[_photosArr objectAtIndex:(selectIndexPath.row - 1)]];
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

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    if (_collectionDataArray.count < 6) {
        return _collectionDataArray.count + 2;
    }
    return 7;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *str = @"backDetailCollectionCell";
    Fcgo_BackPictureCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:str forIndexPath:indexPath];
    if ((indexPath.row == _collectionDataArray.count + 1)&&_collectionDataArray.count!=6) {
        cell.imgView.image = [UIImage imageNamed:@"pic-"];
    }else if (indexPath.row == 0){
        cell.imgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",[self firstCharactor:_titleStr]]];
    }
    else{
        cell.imgView.image = _collectionDataArray[indexPath.row - 1];
    }
    [cell.btnDelete addTarget:self action:@selector(btnDelete:) forControlEvents:UIControlEventTouchUpInside];
    if ((indexPath.row == 0)||((indexPath.row == _collectionDataArray.count + 1)&&_collectionDataArray.count!=6)) {
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
    //点击添加图片按钮item
    if (_collectionDataArray.count != 6 && indexPath.row == _collectionDataArray.count + 1) {
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
#pragma mark - 上传图片
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
        [self uploadHeadImageWithImage:images];
    }];
}

- (void)uploadHeadImageWithImage:(NSArray<UIImage *> *)images
{
    NSMutableArray *imgeArr = [[NSMutableArray alloc] init];
    
    for (int i=0; i<images.count; i++) {
        UIImage *headImage = [Fcgo_Tools imageDealHandleWithImage:images[i]];
        [imgeArr addObject:headImage];
    }
//    [WSProgressHUD showWithStatus:@"头像上传中..." maskType:WSProgressHUDMaskTypeClear];
//    [self startUploadImageWithImage:imgeArr];
    if (_collectionDataArray.count>0) {
        [_collectionDataArray removeAllObjects];
    }
    
    [_collectionDataArray addObjectsFromArray:imgeArr];
    [_collectionview reloadData];
    CGFloat width = (kScreenWidth - 60)/4;
    [_collectionview mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo((_collectionDataArray.count>=3)?@(width*2 + 36 + 30):@(width + 24 + 30));
    }];
}

- (void)startUploadImageWithImage:(NSMutableArray *)images
{
    [[Fcgo_UploadImageManager shareInstance] uploadImageFromImageArray:[[NSMutableArray alloc]initWithArray:images]];
    [Fcgo_UploadImageManager shareInstance].delegate = self;
    
}

-(void)uploadImagesSucceed:(NSMutableArray *)array
{
    [self  requestUpLoadHeadImg];
    !self.uploadImgSuccessBLock?:self.uploadImgSuccessBLock(array);
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)requestUpLoadHeadImg
{
    [WSProgressHUD showImage:nil status:@"上传成功"];
    
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
    return UIEdgeInsetsMake(10, 10, 10, 10);
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
