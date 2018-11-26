//
//  Fcgo_RegistVC.m
//  Fcgo
//
//  Created by huafanxiao on 2017/5/16.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_RegistVC.h"
#import "Fcgo_AddNewAddressTextFieldTableCell.h"
#import "Fcgo_GoodsDetailSection1Cell.h"
#import "Fcgo_AddNewAddressTextViewTableCell.h"

#import "Fcgo_RegistMianImageCell.h"
#import "Fcgo_RegistBackImageCell.h"
#import "Fcgo_RegistLicenceCell.h"
#import "Fcgo_RegistIDCardCell.h"

#import "Fcgo_RegistWaitVC.h"

@interface Fcgo_RegistVC ()<UITableViewDelegate,UITableViewDataSource,Fcgo_UploadImageManagerDelegate>
{
    int   _uploadIndex;
}
@property (nonatomic,strong) UITableView    *table;
@property (nonatomic,strong) NSArray        *titleArray;
@property (nonatomic,strong) UIButton       *rigistBtn;
@property (nonatomic,strong) Fcgo_ExterAddressPickerView *pickerView;
@property (nonatomic,strong) NSDictionary   *addressDict;
@property (nonatomic,strong) NSArray        *mainImageArray;
@property (nonatomic,strong) NSArray        *backImageArray;
@property (nonatomic,strong) UIImage        *licenceImage;
@property (nonatomic,strong) UIImage        *realNameMainImage;
@property (nonatomic,strong) UIImage        *realNameBackImage;


@property(nonatomic,strong)NSMutableArray   *mainImageUrlArray;
@property(nonatomic,strong)NSMutableArray   *backImageUrlArray;
@property(nonatomic,strong)NSString  *licenceUrl;
@property(nonatomic,strong)NSString  *realNameMainUrl;
@property(nonatomic,strong)NSString  *realNameBackUrl;

@property (nonatomic,strong) UITextField *busTF;
@property (nonatomic,strong) UITextField *nameTF;
@property (nonatomic,strong) UITextField *telTF;
@property (nonatomic,strong) Fcgo_UITextView *addressTV;

@end

@implementation Fcgo_RegistVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupUI];
}

- (void)setupUI;
{
    self.titleArray = @[
                        @[@"店铺名称:", @"请输入店铺名称"],
                        @[@"联  系  人:", @"请输入联系人姓名"],
                        @[@"联系电话:", @"请输入手机号码"]
                        ];
    
    WEAKSELF(weakSelf)
    [self.navigationView setupBackBtnBlock:^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    }];
    [self.navigationView setupTitleLabelWithTitle:@"DDH合作店申请"];
    [self.table registerNib:[UINib nibWithNibName:NSStringFromClass([Fcgo_AddNewAddressTextFieldTableCell class]) bundle:nil] forCellReuseIdentifier:@"addNewAddressTextFieldTableCell"];
    [self.table registerNib:[UINib nibWithNibName:NSStringFromClass([Fcgo_GoodsDetailSection1Cell class]) bundle:nil] forCellReuseIdentifier:@"goodsDetailSection1Cell"];
    [self.table registerNib:[UINib nibWithNibName:NSStringFromClass([Fcgo_AddNewAddressTextViewTableCell class]) bundle:nil] forCellReuseIdentifier:@"addNewAddressTextViewTableCell"];
    
    [self.table registerNib:[UINib nibWithNibName:NSStringFromClass([Fcgo_RegistMianImageCell class]) bundle:nil] forCellReuseIdentifier:@"registMianImageCell"];
    [self.table registerNib:[UINib nibWithNibName:NSStringFromClass([Fcgo_RegistBackImageCell class]) bundle:nil] forCellReuseIdentifier:@"registBackImageCell"];
    [self.table registerNib:[UINib nibWithNibName:NSStringFromClass([ Fcgo_RegistLicenceCell class]) bundle:nil] forCellReuseIdentifier:@"registLicenceCell"];
   [self.table registerNib:[UINib nibWithNibName:NSStringFromClass([Fcgo_RegistIDCardCell class]) bundle:nil] forCellReuseIdentifier:@"registIDCardCell"];
    
    [self.view insertSubview:self.table belowSubview:self.navigationView];
    
    [self.rigistBtn addTarget:self action:@selector(rigist) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.rigistBtn];
    [self.rigistBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_offset(0);
        make.height.mas_offset(kAutoWidth6(50));
    }];
    [self.view addSubview:self.pickerView];
}

- (void)rigist
{
    if ([Fcgo_Tools isNullString:self.busTF.text]) {
        [WSProgressHUD showImage:nil status:@"请填写店铺名称"];
        return;
    }
   
    if ([Fcgo_Tools isNullString:self.nameTF.text]) {
        [WSProgressHUD showImage:nil status:@"请填写联系人姓名"];
        return;
    }
   
    if ([Fcgo_Tools isNullString:self.telTF.text]) {
        [WSProgressHUD showImage:nil status:@"请填写联系电话"];
        return;
    }
    
    if (![Fcgo_Tools valiMobile:self.telTF.text]) {
        [WSProgressHUD showImage:nil status:@"请填写正确的手机号码"];
        return;
    }
    
    if (!self.addressDict) {
        [WSProgressHUD showImage:nil status:@"请选择地区"];
        return;
    }
    
    if ([Fcgo_Tools isNullString:self.addressTV.text] || self.addressTV.text.length<5) {
        [WSProgressHUD showImage:nil status:@"请填写详细地,不能少于五个字"];
        return;
    }
    
    if (!self.mainImageArray || self.mainImageArray.count<=0)
    {
        [WSProgressHUD showImage:nil status:@"请选择门店正面图片"];
        return;
    }
    
    if (!self.backImageArray ||self.backImageArray.count<=0)
    {
        [WSProgressHUD showImage:nil status:@"请选择门店内部图片"];
        return;
    }
    
    if (!self.backImageArray ||self.backImageArray.count<=3)
    {
        [WSProgressHUD showImage:nil status:@"请选择4-6张门店内部图片"];
        return;
    }
    
    if (!self.licenceImage)
    {
        [WSProgressHUD showImage:nil status:@"请选择营业执照"];
        return;
    }
    
    if (!self.realNameMainImage)
    {
        [WSProgressHUD showImage:nil status:@"请选择身份证正面图片"];
        return;
    }
    
    if (!self.realNameBackImage)
    {
        [WSProgressHUD showImage:nil status:@"请选择身份证反面图片"];
        return;
    }
    
    [WSProgressHUD showWithStatus:@"数据上传中,请勿退出..." maskType:WSProgressHUDMaskTypeClear];
    [self  startUploadImage];
}

-(void)startUploadImage
{
    _uploadIndex=1;
   [[Fcgo_UploadImageManager shareInstance] uploadImageFromImageArray:[NSMutableArray arrayWithArray:self.mainImageArray]];
    [Fcgo_UploadImageManager shareInstance].delegate = self;
}

-(void)uploadImagesSucceed:(NSMutableArray *)array
{
    if (_uploadIndex == 1) {
        self.mainImageUrlArray = array;
        _uploadIndex = 2;
        [[Fcgo_UploadImageManager  shareInstance] uploadImageFromImageArray:[NSMutableArray arrayWithArray:self.backImageArray]];
    }
    else if (_uploadIndex == 2)
    {
        self.backImageUrlArray = array;
        _uploadIndex = 3;
        [[Fcgo_UploadImageManager  shareInstance] uploadImageFromImageArray:[NSMutableArray arrayWithObjects:self.licenceImage, nil]];
    }
    else if (_uploadIndex == 3)
    {
        self.licenceUrl = [array objectAtIndex:0];
        _uploadIndex=4;
        [[Fcgo_UploadImageManager  shareInstance] uploadImageFromImageArray:[NSMutableArray arrayWithObjects:self.realNameMainImage, nil]];
    }
    else if (_uploadIndex==4)
    {
        self.realNameMainUrl = [array objectAtIndex:0];
        _uploadIndex=5;
        [[Fcgo_UploadImageManager  shareInstance] uploadImageFromImageArray:[NSMutableArray arrayWithObjects:self.realNameBackImage, nil]];
    }
    else if (_uploadIndex==5)
    {
        self.realNameBackUrl = [array objectAtIndex:0];
        [self  requestRegist];
    }
}

- (void)requestRegist
{
    
    NSMutableDictionary  *paremetwers = [NSMutableDictionary dictionary];
    [paremetwers setObjectWithNullValidate:self.busTF.text forKey:@"shopName"];
    [paremetwers setObjectWithNullValidate:self.nameTF.text forKey:@"contract"];
    [paremetwers setObjectWithNullValidate:self.telTF.text forKey:@"tel"];
    [paremetwers setObjectWithNullValidate:self.addressTV.text forKey:@"addressDetail"];
   
    
    NSString *provinceID = self.addressDict[@"province"][@"areaId"];
    NSString *cityID     = self.addressDict[@"city"][@"areaId"];
    NSString *areaID     = self.addressDict[@"area"][@"areaId"];
    [paremetwers setObjectWithNullValidate:provinceID forKey:@"provinceCode"];
    [paremetwers setObjectWithNullValidate:cityID forKey:@"cityCode"];
    [paremetwers setObjectWithNullValidate:areaID forKey:@"areaCode"];
    
    
    NSString  *urls = @"";
    for (int i = 0; i < self.mainImageUrlArray.count; i++ )
    {
        urls=[urls stringByAppendingString:self.mainImageUrlArray[i]];
        if (i<self.mainImageUrlArray.count-1) {
            urls=[urls stringByAppendingString:@","];
        }
    }
    [paremetwers  setObjectWithNullValidate:urls forKey:@"front"];
    
    NSString  *sixUrls = @"";
    for (int i=0; i<self.backImageUrlArray.count; i++) {
        sixUrls=[sixUrls stringByAppendingString:self.backImageUrlArray[i]];
        if (i<self.backImageUrlArray.count-1) {
            sixUrls=[sixUrls stringByAppendingString:@","];
        }
    }
    [paremetwers  setObjectWithNullValidate:sixUrls forKey:@"insite"];
    [paremetwers  setObjectWithNullValidate:self.licenceUrl forKey:@"bisiness"];
    [paremetwers  setObjectWithNullValidate:self.realNameMainUrl forKey:@"idcardW"];
    [paremetwers  setObjectWithNullValidate:self.realNameBackUrl forKey:@"idcardB"];
    WEAKSELF(weakSelf)
    [Fcgo_NetworkManager postRequest:NSFormatHeardMeThodUrl(ServiceLocalTypeOne,INFOMETHOD,@"register") parametersContentCommon:paremetwers successBlock:^(BOOL success, id responseObject, NSString *msg) {
        [WSProgressHUD dismiss];
        if (success) {
            Fcgo_RegistWaitVC *vc = [[Fcgo_RegistWaitVC alloc]init];
            vc.hidesBottomBarWhenPushed = 1;
            [weakSelf.navigationController pushViewController:vc animated:YES];
        }
        else {
            [WSProgressHUD showImage:nil status:msg];
        }
    } failureBlock:^(NSString *description) {}];
}

#pragma mark table delegate datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 9;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WEAKSELF(weakSelf);
    if (indexPath.row <=2) {
        Fcgo_AddNewAddressTextFieldTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"addNewAddressTextFieldTableCell"];
        cell.titleLabel.text = self.titleArray[indexPath.row][0];
        cell.inputLabel.placeholder = self.titleArray[indexPath.row][1];
        if (indexPath.row == 0) {
            self.busTF = cell.inputLabel;
        }
        else if (indexPath.row == 1) {
            self.nameTF = cell.inputLabel;
        }
        else if (indexPath.row == 2) {
            self.telTF = cell.inputLabel;
        }
        return cell;
    }
    else if (indexPath.row == 3) {
        Fcgo_GoodsDetailSection1Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"goodsDetailSection1Cell"];
        cell.titleLabel.text = @"所在地区:";
        
        if (!self.addressDict) {
            cell.choseLabel.text = @"请选择地区";
             cell.choseLabel.textColor = UIRGBColor(190, 190, 190, 1);
        }else{
           cell.choseLabel.text = [NSString  stringWithFormat:@"%@%@%@",self.addressDict[@"province"][@"areaName"],self.addressDict[@"city"][@"areaName"],self.addressDict[@"area"][@"areaName"]];
            cell.choseLabel.textColor = UIFontMainGrayColor;
        }
        return cell;
    }
    else if (indexPath.row == 4) {
        Fcgo_AddNewAddressTextViewTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"addNewAddressTextViewTableCell"];
        cell.textView.placeholder = @"请写下详细地址，不能少于五个字";
        self.addressTV  =cell.textView;
        return cell;
    }
    else if (indexPath.row == 5) {
        Fcgo_RegistMianImageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"registMianImageCell"];
        cell.imageBlock = ^(NSArray *imageArray){
            weakSelf.mainImageArray = imageArray;
        };
        
       return cell;
    }
    else if (indexPath.row == 6) {
        Fcgo_RegistBackImageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"registBackImageCell"];
        cell.imageBlock = ^(NSArray *imageArray){
            weakSelf.backImageArray = imageArray;
        };
        return cell;
    }
    else if (indexPath.row == 7) {
        Fcgo_RegistLicenceCell *cell = [tableView dequeueReusableCellWithIdentifier:@"registLicenceCell"];
        cell.imageBlock = ^(UIImage *image){
            weakSelf.licenceImage = image;
        };
        return cell;
    }
    Fcgo_RegistIDCardCell  *cell = [tableView dequeueReusableCellWithIdentifier:@"registIDCardCell"];
    cell.imageBlock = ^(UIImage *mainImage,UIImage *backImage){
        weakSelf.realNameMainImage = mainImage;
        weakSelf.realNameBackImage = backImage;
    };
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row <= 3)
    {
        return kAutoWidth6(50);
    }else if (indexPath.row == 4)
    {
        return kAutoWidth6(100);
    }
    else if (indexPath.row == 5 || indexPath.row == 6)
    {
        CGFloat itemW = (kScreenWidth- 48) / 3;
        return 74 + itemW;
    }
    else if (indexPath.row == 7)
    {
        return 50 + 110;
    }
    return 2*((kScreenWidth-24-10)/2/1.6)+(345-212.5);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.view endEditing:YES];
    if (indexPath.row == 3) {
       [self.pickerView show];
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


#pragma mark Lazy method

- (UITableView *)table
{
    if (!_table) {
        UITableView *table = [[UITableView alloc]initWithFrame:CGRectMake(0, kNavigationHeight, kScreenWidth, KScreenHeight - kNavigationHeight - kAutoWidth6(50)) style:UITableViewStylePlain];
        table.delegate = self;
        table.dataSource = self;
        _table = table;
        if (@available(iOS 11.0, *)) {
            table.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return _table;
}

- (UIButton *)rigistBtn
{
    if (!_rigistBtn) {
        _rigistBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        _rigistBtn.titleLabel.font = UIFontSize(16);
        [_rigistBtn setTitle:@"确认注册" forState:UIControlStateNormal];
        [_rigistBtn setTitleColor:UIFontWhiteColor forState:UIControlStateNormal];
        [_rigistBtn setBackgroundColor:UIFontRedColor];
    }
    return _rigistBtn;
}

- (Fcgo_ExterAddressPickerView *)pickerView
{
    WEAKSELF(weakSelf)
    if (!_pickerView) {
        
        _pickerView = [[Fcgo_ExterAddressPickerView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, KScreenHeight) selectAddressBlock:^(NSMutableDictionary *addressDict) {
            
            weakSelf.addressDict = addressDict;
            Fcgo_GoodsDetailSection1Cell *cell = [weakSelf.table cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
            cell.choseLabel.text = [NSString  stringWithFormat:@"%@%@%@",addressDict[@"province"][@"areaName"],addressDict[@"city"][@"areaName"],addressDict[@"area"][@"areaName"]];
            cell.choseLabel.textColor = UIFontMainGrayColor;
        }];
    }
    return _pickerView;
}

@end
