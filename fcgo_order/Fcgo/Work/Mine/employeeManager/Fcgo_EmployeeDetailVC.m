//
//  Fcgo_EmployeeDetailVC.m
//  Fcgo
//
//  Created by by_r on 2017/11/24.
//  Copyright © 2017年 Fcg. All rights reserved.
//

#import "Fcgo_EmployeeDetailVC.h"
#import "Fcgo_StoreSelectVC.h"
#import "Fcgo_EmployeeDetailCell.h"

static NSString *employeeDetailIdentifier = @"img";
static NSString *employeeTxtInfoIdentifier = @"txt";

static NSString *keyTipName = @"tip";
static NSString *keyType = @"type"; ///< 0 img, 1 txt, 2 工号
static NSString *keyColor = @"color";
static NSString *keyEdited = @"edited";
static NSString *keyPlaceholder = @"place";
static NSString *keyJumpType = @"jump";
static NSString *keyHiddenArrow = @"arrow";

@interface Fcgo_EmployeeDetailVC ()<UITableViewDataSource, UITableViewDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate, HXPhotoViewControllerDelegate>
@property (nonatomic, strong) UITableView         *myTableView;
@property (nonatomic, strong) NSMutableArray       *dataArray;
@property (nonatomic, strong) UIButton           *bottomButton;
@end

@implementation Fcgo_EmployeeDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupUI];
}
#pragma mark - private method
- (void)bottomButtonAction:(UIButton *)sender {
    
}

- (void)touchHeaderAction {
    [self.view endEditing:YES];
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

- (void)deleteAction {
    [self.view endEditing:YES];
}
#pragma mark - delegate
#pragma mark UITableView
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.view endEditing:YES];
    NSDictionary *dict = self.dataArray[indexPath.row];
    if (!dict[keyType] && ![dict[keyEdited] boolValue]) {
        if ([dict[keyJumpType] isEqualToString:@"store"]) {
            Fcgo_StoreSelectVC *vc = [[Fcgo_StoreSelectVC alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
        else if ([dict[keyJumpType] isEqualToString:@"job"]) {
            //店铺类型
            WEAKSELF(weakSelf)
            [Fcgo_SheetAnimationView showWithArray:@[@"店长",@"店员"] DidSelectedBlock:^(NSInteger index) {
                
            }];
        }
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *dict = self.dataArray[indexPath.row];
    if (dict[keyType] && [dict[keyType] integerValue] == 0) {
        Fcgo_EmployeeDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:employeeDetailIdentifier];
        WEAKSELF(weakSelf);
        cell.touchHeader = ^{
            [weakSelf touchHeaderAction];
        };
        return cell;
    }
    
    Fcgo_EmployeeTxtInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:employeeTxtInfoIdentifier];
    [cell setDetailColor:dict[keyColor] tip:dict[keyTipName] detail:nil edited:[dict[keyEdited] boolValue] placeholder:dict[keyPlaceholder] arrow:[dict[keyHiddenArrow] boolValue]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *dict = self.dataArray[indexPath.row];
    if (dict[keyType] && [dict[keyType] integerValue] == 0) {
        return UITableViewAutomaticDimension;
    }
    return 50.f;
}
#pragma mark HXPhotoViewControllerDelegate
- (void)photoViewControllerDidNext:(NSArray<HXPhotoModel *> *)allList Photos:(NSArray<HXPhotoModel *> *)photos Videos:(NSArray<HXPhotoModel *> *)videos Original:(BOOL)original {
    
}
#pragma mark UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    if ([type isEqualToString:@"public.image"]) {
//        UIImage *image = [info objectForKey:@"UIImagePickerControllerEditedImage"];
//        [self uploadHeadImageWithImage:image];
        [picker dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - UI
- (void)setupUI {
    WEAKSELF(weakSelf);
    self.view.backgroundColor = UIBackGroundColor;
    [self.navigationView setupTitleLabelWithTitle:@"员工管理"];
    [self.navigationView setupBackBtnBlock:^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    }];
    [self.navigationView setupRightBtnTitle:@"删除" Block:^{
        [weakSelf deleteAction];
    }];
    CGFloat bottomHeight = 50.f;
    // table
    UITableView *table = [[UITableView alloc] initWithFrame:CGRectMake(0, kNavigationHeight, kScreenWidth, KScreenHeight - kNavigationHeight - bottomHeight)];
    table.delegate = self;
    table.dataSource = self;
    table.backgroundColor = self.view.backgroundColor;
    table.tableFooterView = [UIView new];
    [table registerClass:[Fcgo_EmployeeDetailCell class] forCellReuseIdentifier:employeeDetailIdentifier];
    [table registerClass:[Fcgo_EmployeeTxtInfoCell class] forCellReuseIdentifier:employeeTxtInfoIdentifier];
    [self.view insertSubview:table belowSubview:self.navigationView];
    _myTableView = table;
    // bottomView
    UIButton *bottomButton = [UIButton buttonWithType:UIButtonTypeCustom];
    bottomButton.frame = CGRectMake(0, KScreenHeight - bottomHeight, kScreenWidth, bottomHeight);
    bottomButton.backgroundColor = UIFontRedColor;
    [bottomButton setTitle:@"保存" forState:UIControlStateNormal];
    [bottomButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [bottomButton addTarget:self action:@selector(bottomButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bottomButton];
    _bottomButton = bottomButton;
}

#pragma mark - lazy load
- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = @[@{keyTipName : @"员工照片",
                     keyType : @(0)
                     },
                   @{
                       keyTipName : @"所在门店",
                       keyPlaceholder : @"请选择所在门店",
                       keyJumpType : @"store",
                   },
                   @{
                       keyTipName : @"职位",
                       keyPlaceholder : @"请选择职位",
                       keyJumpType : @"job",
                   },
                   @{
                       keyTipName : @"员工姓名",
                       keyEdited : @(1),
                       keyPlaceholder : @"请输入员工姓名",
                       keyHiddenArrow : @(1),
                   },
                   @{
                       keyTipName : @"联系方式",
                       keyEdited : @(1),
                       keyPlaceholder : @"请输入联系方式",
                       keyHiddenArrow : @(1),
                   },
                   @{
                       keyTipName : @"工号",
                       keyType : @(2),
                       keyColor : UIFontRedColor,
                       keyHiddenArrow : @(1),
                   },
               ].mutableCopy;
    }
    return _dataArray;
}

@end
