//
//  Fcgo_Market_ShopManngerVC.m
//  Fcgo
//
//  Created by huafanxiao on 2017/8/2.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_Market_ShopManngerVC.h"

#import "Fcgo_SetupTableViewCell.h"
#import "Fcgo_MarketShopManngerHeaderImgCell.h"
#import <objc/message.h>

#import "Fcgo_MarketShopManngerCell.h"


#import "Fcgo_Market_SetShopNameVC.h"
#import "Fcgo_Market_SetShopBGVC.h"

@interface Fcgo_Market_ShopManngerVC ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate,HXPhotoViewControllerDelegate,UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate,UIImagePickerControllerDelegate,Fcgo_UploadImageManagerDelegate>

@property (nonatomic,strong) UITableView *table;
@property (nonatomic,strong) NSArray     *titleArray;
@property (nonatomic,copy)   NSString    *headImageString;

@end

@implementation Fcgo_Market_ShopManngerVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupUI];
}

- (void)setupUI;
{
    self.titleArray = @[
                        @[@"店铺头像", @"headImage"],
                        @[@"店铺名称", @"shopName"],
                        @[@"店铺背景",@"shopBg"],
                        @[@"店铺联系人",@""],
                        @[@"店铺手机号",@""]
                        ];
    WEAKSELF(weakSelf)
    [self.navigationView setupBackBtnBlock:^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    }];
    [self.navigationView setupTitleLabelWithTitle:@"店铺管理"];
    
    [self.table registerNib:[UINib nibWithNibName:NSStringFromClass([Fcgo_SetupTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"setupTableViewCell"];
    [self.table registerNib:[UINib nibWithNibName:NSStringFromClass([Fcgo_MarketShopManngerHeaderImgCell class]) bundle:nil] forCellReuseIdentifier:@"marketShopManngerHeaderImgCell"];
    [self.table registerNib:[UINib nibWithNibName:NSStringFromClass([Fcgo_MarketShopManngerCell class]) bundle:nil] forCellReuseIdentifier:@"marketShopManngerCell"];
    
    self.table.mj_header = [Fcgo_RefreshNormalHeader headerRefreshBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf.table.mj_header endRefreshing];
            [weakSelf.table reloadData];
        });
    }];
    [self.view insertSubview:self.table belowSubview:self.navigationView];
}

#pragma mark table delegate datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.titleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        Fcgo_MarketShopManngerHeaderImgCell *cell = [tableView dequeueReusableCellWithIdentifier:@"marketShopManngerHeaderImgCell"];
        cell.titleString = self.titleArray[indexPath.row][0];
        if (self.headImageString) {
            cell.headImageString = self.headImageString;
        }
        return cell;
    }
    if (indexPath.row < 3 && indexPath.row>0) {
        Fcgo_SetupTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"setupTableViewCell"];
        cell.titleString = self.titleArray[indexPath.row][0];
        if( indexPath.row == 1)
        {
            cell.cacheLabel.alpha = 1;
            cell.cacheLabel.text = @"南京母婴儿童店";
            
        }
        else{
            cell.cacheLabel.alpha = 0;

        }
        return cell;
    }
    
    
    Fcgo_MarketShopManngerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"marketShopManngerCell"];
    cell.titleLabel.text = self.titleArray[indexPath.row][0];
    cell.descriptionLabel.text = self.titleArray[indexPath.row][0];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0)
    {
        return kAutoWidth6(60);
    }
    return kAutoWidth6(50);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *meoth = self.titleArray[indexPath.row][1];
    //清除缓存
    if ([meoth isEqualToString:@""])
    {
        return;
    }
    SEL meth = NSSelectorFromString(meoth);
    if ([self respondsToSelector:meth]) {
        ((void (*)(id, SEL))objc_msgSend)(self, meth);
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.5;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footerView = [[UIView alloc]init];
    footerView.backgroundColor = UINavSepratorLineColor;
    return footerView;
}

- (void)headImage
{
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
            HXPhotoManager *manager = [[HXPhotoManager alloc] initWithType:HXPhotoManagerSelectedTypePhoto];
            manager.photoMaxNum = 1;
            manager.rowCount = 4;
            manager.openCamera = 0;
            vc.manager = manager;
            [self presentViewController:[[UINavigationController alloc] initWithRootViewController:vc] animated:YES completion:nil];
        }
    }];
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    if ([type isEqualToString:@"public.image"]) {
        UIImage *image = [info objectForKey:@"UIImagePickerControllerEditedImage"];
        [self uploadHeadImageWithImage:image];
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
    [HXPhotoTools fetchOriginalForSelectedPhoto:photos completion:^(NSArray<UIImage *> *images) {
        [self uploadHeadImageWithImage:images[0]];
    }];
}

- (void)uploadHeadImageWithImage:(UIImage *)image
{
    UIImage *headImage = [Fcgo_Tools imageDealHandleWithImage:image];
    [WSProgressHUD showWithStatus:@"头像上传中..." maskType:WSProgressHUDMaskTypeClear];
    [self startUploadImageWithImage:headImage];
}

- (void)startUploadImageWithImage:(UIImage *)image
{
    [[Fcgo_UploadImageManager shareInstance] uploadImageFromImageArray:[NSMutableArray arrayWithObjects:image, nil]];
    [Fcgo_UploadImageManager shareInstance].delegate = self;
}

-(void)uploadImagesSucceed:(NSMutableArray *)array
{
    self.headImageString = [array objectAtIndex:0];
    [self.table reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
    [self  requestUpLoadHeadImg];
}

- (void)requestUpLoadHeadImg
{
    [WSProgressHUD showImage:nil status:@"上传成功"];
    return;
    /*
    NSMutableDictionary  *paremetwers = [NSMutableDictionary dictionary];
    [paremetwers setObjectWithNullValidate:self.headImageString forKey:@"f_headerimg"];
    [Fcgo_NetworkManager postRequest:NSFormatHeardUrl(@"mer/shop/upHeadImg") parameters:paremetwers successBlock:^(BOOL success, id responseObject, NSString *msg) {
        [WSProgressHUD showImage:nil status:@"上传成功"];
        if (success) {
            
        }
        else
        {
            
        }
    } failureBlock:^(NSString *description) {
        
    }];*/
}

- (void)shopName
{
    Fcgo_Market_SetShopNameVC *vc = [[Fcgo_Market_SetShopNameVC alloc]init];
    vc.hidesBottomBarWhenPushed = 1;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)shopBg
{
    Fcgo_Market_SetShopBGVC *vc = [[Fcgo_Market_SetShopBGVC alloc]init];
    vc.hidesBottomBarWhenPushed = 1;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark Lazy method

- (UITableView *)table
{
    if (!_table) {
        UITableView *table = [[UITableView alloc]initWithFrame:CGRectMake(0, kNavigationHeight, kScreenWidth, KScreenHeight - kNavigationHeight) style:UITableViewStylePlain];
        table.delegate = self;
        table.dataSource = self;
        table.backgroundColor = UIBackGroundColor;
        _table = table;
        if (@available(iOS 11.0, *)) {
            table.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return _table;
}

@end


