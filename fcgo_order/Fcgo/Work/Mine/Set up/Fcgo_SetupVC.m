//
//  Fcgo_SetupVC.m
//  Fcgo
//
//  Created by huafanxiao on 2017/5/16.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_SetupVC.h"
#import "Fcgo_SetupTableViewCell.h"
#import "Fcgo_SetupHeadImageTableViewCell.h"
#import <objc/message.h>
#import "Fcgo_ShopInformationVC.h"
#import "Fcgo_SafeVC.h"
#import "Fcgo_VersionIntroduceVC.h"
#import "UMMobClick/MobClick.h"

@interface Fcgo_SetupVC ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate,HXPhotoViewControllerDelegate,UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate,UIImagePickerControllerDelegate,Fcgo_UploadImageManagerDelegate>

@property (nonatomic,strong) UITableView    *table;
@property (nonatomic,strong) NSArray        *titleArray;
@property (nonatomic,strong) UIButton       *loginoutBtn;
@end

@implementation Fcgo_SetupVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupUI];
}

- (void)setupUI;
{
    self.titleArray = @[
                        @[@"用户头像", @"headImage"],
                        //@[@"店铺信息", @"shopInformation"],
//                        @[@"安全中心",@"safeCenter"],
                        @[@"清除缓存",@"clearCache"],
                        @[@"版本介绍",@"versionIntroduction"],
                        @[@"去  评  分",@"goScore"]
                        ];
    WEAKSELF(weakSelf)
    [self.navigationView setupBackBtnBlock:^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    }];
    [self.navigationView setupTitleLabelWithTitle:@"设置中心"];
    
    [self.table registerNib:[UINib nibWithNibName:NSStringFromClass([Fcgo_SetupTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"setupTableViewCell"];
    [self.table registerNib:[UINib nibWithNibName:NSStringFromClass([Fcgo_SetupHeadImageTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"setupHeadImageTableViewCell"];
    
    self.table.mj_header = [Fcgo_RefreshNormalHeader headerRefreshBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf.table.mj_header endRefreshing];
            [weakSelf.table reloadData];
        });
    }];
    [self.view insertSubview:self.table belowSubview:self.navigationView];
    
    [self.loginoutBtn addTarget:self action:@selector(loginout) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.loginoutBtn];
    [self.loginoutBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_offset(0);
        make.height.mas_offset(kAutoWidth6(50));
    }];
}

- (void)loginout
{
    WEAKSELF(weakSelf);
    [Fcgo_AlertAnimationView showWithTitle:@"提示" text:@"是否安全退出？" cancelTitle:@"取消" confirmTitle:@"确定" block:^{
        //发送退出请求
        [weakSelf postRequestLoginout];
    }];
}



- (void)postRequestLoginout
{
    //假退出
    [WSProgressHUD showWithStatus:@"正在安全退出"];
    [Fcgo_NetworkManager postRequest:NSFormatHeardMeThodUrl(ServiceLocalTypeOne, @"mch/user/", @"logOutMchStoreUser") parametersContentCommon:nil successBlock:^(BOOL success, id responseObject, NSString *msg) {
        
        [WSProgressHUD dismiss];
        if (success) {
            NSNumber *errCode = responseObject[@"errorCode"];
            if (errCode.intValue == 0) {
                [[Fcgo_UserTools shared]clearUserInfomation];
                [MobClick profileSignOff];
                [[Fcgo_UserTools shared]setIsLogin:0];
                [Fcgo_Delegate  setLoginVCToRootVC];
                [[QYSDK sharedSDK] logout:^{}];

            }
        }
    } failureBlock:^(NSString *description) {
        [WSProgressHUD showImage:nil status:@"退出失败"];
    }];
}

#pragma mark table delegate datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.titleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        Fcgo_SetupHeadImageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"setupHeadImageTableViewCell"];
        cell.titleString = self.titleArray[indexPath.row][0];
        if (self.headImageString) {
            cell.headImageString = self.headImageString;
        }
        return cell;
    }
    Fcgo_SetupTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"setupTableViewCell"];
    cell.titleString = self.titleArray[indexPath.row][0];
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
    if ([meoth isEqualToString:@"clearCache"])
    {
        if ((float)[[SDImageCache sharedImageCache] getSize]/1024/1024 <= 0) {
            [WSProgressHUD showImage:nil status:@"暂无缓存哦"];
            [tableView deselectRowAtIndexPath:indexPath animated:YES];
            return;
        }
        Fcgo_SetupTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        [cell startActivityIndicatorView];
        [[SDImageCache sharedImageCache]clearMemory];
        [[SDImageCache sharedImageCache]clearDiskOnCompletion:^{
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [tableView deselectRowAtIndexPath:indexPath animated:YES];
                [cell stopActivityIndicatorView];
                [WSProgressHUD showSuccessWithStatus:@"主人,打扫好啦"];
            });
        }];
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

-(void)startUploadImageWithImage:(UIImage *)image
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
    
    [Fcgo_UserTools shared].userHeaderImageUrl = self.headImageString;
    [WSProgressHUD showImage:nil status:@"上传成功"];
    
  /*  NSMutableDictionary  *paremetwers = [NSMutableDictionary dictionary];
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



- (void)shopInformation
{
    Fcgo_ShopInformationVC *vc = [[Fcgo_ShopInformationVC alloc]init];
    vc.hidesBottomBarWhenPushed = 1;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)safeCenter
{
    Fcgo_SafeVC *safeVC = [[Fcgo_SafeVC alloc]init];
    [self.navigationController pushViewController:safeVC animated:YES];
}

- (void)versionIntroduction
{
    Fcgo_VersionIntroduceVC *vc = [[Fcgo_VersionIntroduceVC alloc]init];
    vc.hidesBottomBarWhenPushed = 1;
    NSString *currentAppVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    vc.urlString = [NSString stringWithFormat:@"%@?version=%@&token=%@",NSFormatHeardMeThodUrl(ServiceLocalTypeOne, COMMONMETHOD, @"version_introduce"),currentAppVersion, Token];
//    vc.isShowNavBar = YES;
    vc.isShowNavBar = YES;
    [self.navigationController pushViewController:vc animated:1];
}

- (void)goScore
{
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"https://itunes.apple.com/cn/app/%E5%A4%87%E8%B4%A7%E9%80%9A/id1216582803?mt=8"]];
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

- (UIButton *)loginoutBtn
{
    if (!_loginoutBtn) {
        _loginoutBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        _loginoutBtn.titleLabel.font = UIFontSize(16);
        [_loginoutBtn setTitle:@"安全退出" forState:UIControlStateNormal];
        [_loginoutBtn setTitleColor:UIFontWhiteColor forState:UIControlStateNormal];
        [_loginoutBtn setBackgroundColor:UIFontRedColor];
    }
    return _loginoutBtn;
}

@end
