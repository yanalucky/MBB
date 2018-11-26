//
//  Fcgo_AddRealNameVC.m
//  Fcgo
//
//  Created by huafanxiao on 2017/6/8.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_AddRealNameVC.h"
#import "Fcgo_AddNewAddressTextFieldTableCell.h"
#import "Fcgo_AddRealNameImageTableCell.h"

@interface Fcgo_AddRealNameVC ()<UITableViewDelegate,UITableViewDataSource,Fcgo_UploadImageManagerDelegate>
{
    int   _uploadIndex;
}
@property (nonatomic,strong) UITableView      *table;
@property (nonatomic,strong) NSArray          *titleArray;
@property (nonatomic,strong) Fcgo_IndexButton *defultBtn;
@property (nonatomic,strong) UIButton         *confirmBtn;
@property (nonatomic,strong) Fcgo_ExterAddressPickerView *pickerView;

@property (nonatomic,strong) UITextField *nameTF;
@property (nonatomic,strong) UITextField *cardTF;
@property (nonatomic,strong) UIImage        *realNameMainImage;
@property (nonatomic,strong) UIImage        *realNameBackImage;
@property(nonatomic,strong)  NSString  *realNameMainUrl;
@property(nonatomic,strong)  NSString  *realNameBackUrl;
@property (nonatomic,strong) NSDictionary    *addressDict;


@end

@implementation Fcgo_AddRealNameVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (void)setupUI;
{
    WEAKSELF(weakSelf)
    [self.navigationView setupBackBtnBlock:^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    }];

    self.titleArray = @[@[@"姓       名:",@"请输入姓名"],
                        @[@"身份证号:",@"请输入身份证号码"],
                        ];
    
    [self.table registerNib:[UINib nibWithNibName:NSStringFromClass([Fcgo_AddNewAddressTextFieldTableCell class]) bundle:nil] forCellReuseIdentifier:@"addNewAddressTextFieldTableCell"];
    [self.table registerNib:[UINib nibWithNibName:NSStringFromClass([Fcgo_AddRealNameImageTableCell class]) bundle:nil] forCellReuseIdentifier:@"addRealNameImageTableCell"];
    
    [self.view addSubview:self.table];
    
    if (self.model) {
        self.defultBtn.select = self.model.f_default.intValue;
        if (self.defultBtn.select == NO) {
            [self.defultBtn setBackgroundImage:[UIImage imageNamed:@"select_off"] forState:UIControlStateNormal];
        }
        else
        {
            self.table.tableFooterView.hidden = 1;
            [self.defultBtn setBackgroundImage:[UIImage imageNamed:@"select_on"] forState:UIControlStateNormal];
        }
        [self.navigationView setupTitleLabelWithTitle:@"编辑实名认证"];
        self.realNameMainUrl = self.model.mchPicurlW;
        self.realNameBackUrl = self.model.mchPicurlB;
        
        NSOperationQueue *loadQueue = [[NSOperationQueue alloc] init];
        loadQueue.maxConcurrentOperationCount = 5;
        
        [loadQueue addOperationWithBlock:^{
            
            NSData *data1 = [NSData dataWithContentsOfURL:[NSURL URLWithString:self.model.mchPicurlW]];
            if (data1) {
                //下载完毕后，先存储到内存。
                weakSelf.realNameMainImage = [UIImage imageWithData:data1];
            }
            
            NSData *data2 = [NSData dataWithContentsOfURL:[NSURL URLWithString:self.model.mchPicurlB]];
            
            if (data2) {
                //下载完毕后，先存储到内存。
                weakSelf.realNameBackImage = [UIImage imageWithData:data2];
                
            }
            
        }];
    }else{
        [self.navigationView setupTitleLabelWithTitle:@"添加实名认证"];
    }
    
    [self.confirmBtn addTarget:self action:@selector(confirm) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.confirmBtn];
    [self.confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_offset(0);
        make.height.mas_offset(kAutoWidth6(50));
    }];
    [self.view addSubview:self.pickerView];
}

- (void)confirm
{
    if ([Fcgo_Tools isNullString:self.nameTF.text]) {
        [WSProgressHUD showImage:nil status:@"请填写姓名"];
        return;
    }
    
    if ([Fcgo_Tools isNullString:self.cardTF.text]) {
        [WSProgressHUD showImage:nil status:@"请填写身份证号码"];
        return;
    }
    
//    if (![Fcgo_Tools accurateVerifyIDCardNumber:self.cardTF.text] ) {
//        [WSProgressHUD showImage:nil status:@"请填写规范的身份证号码"];
//        return;
//    }
    [WSProgressHUD showWithStatus:@"数据上传中,请勿退出..." maskType:WSProgressHUDMaskTypeClear];
    
    if(!self.realNameMainImage && !self.realNameBackImage)
    {
        self.realNameMainUrl = @"";
        self.realNameBackUrl = @"";
        [self  requestRegist];
    }
    else
    {
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
         [self  startUploadImage];
    }
}

- (void)startUploadImage
{
    _uploadIndex=1;
    [[Fcgo_UploadImageManager  shareInstance] uploadImageFromImageArray:[NSMutableArray arrayWithObjects:self.realNameMainImage, nil]];
    [Fcgo_UploadImageManager shareInstance].delegate = self;
}

- (void)uploadImagesSucceed:(NSMutableArray *)array
{
     if (_uploadIndex == 1)
    {
        self.realNameMainUrl = [array objectAtIndex:0];
        _uploadIndex=2;
        [[Fcgo_UploadImageManager  shareInstance] uploadImageFromImageArray:[NSMutableArray arrayWithObjects:self.realNameBackImage, nil]];
    }
    else if (_uploadIndex == 2)
    {
        self.realNameBackUrl = [array objectAtIndex:0];
        [self  requestRegist];
    }
}

- (void)requestRegist
{
    NSMutableDictionary  *paremetwers = [NSMutableDictionary dictionary];
    [paremetwers setObjectWithNullValidate:self.nameTF.text forKey:@"name"];
    [paremetwers setObjectWithNullValidate:self.cardTF.text forKey:@"idCard"];
    [paremetwers  setObjectWithNullValidate:self.realNameMainUrl forKey:@"picurlW"];
    [paremetwers  setObjectWithNullValidate:self.realNameBackUrl forKey:@"picurlB"];
    [paremetwers setObjectWithNullValidate:[NSString stringWithFormat:@"%d",self.defultBtn.select] forKey:@"isDefault"];
   NSString *url;
    if (self.model) {
        [paremetwers setObjectWithNullValidate:self.model.f_realName_id forKey:@"id"];
        url = NSFormatHeardMeThodUrl(ServiceLocalTypeOne,REALNAMEMETHOD, @"update");
    }
    else{
        url = NSFormatHeardMeThodUrl(ServiceLocalTypeOne,REALNAMEMETHOD, @"add");
    }
    [Fcgo_NetworkManager postRequest:url parametersContentCommon:paremetwers successBlock:^(BOOL success, id responseObject, NSString *msg) {
        [WSProgressHUD dismiss];
        if (success) {
            [WSProgressHUD showSuccessWithStatus:@"添加成功"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];
                if ([_delegate respondsToSelector:@selector(finishAddOrEditRealName)]) {
                    [_delegate finishAddOrEditRealName];
                }
            });
        }
    } failureBlock:^(NSString *description) {
        
    }];
}

- (void)defultClick
{
    self.defultBtn.select = !self.defultBtn.select;
    if (self.defultBtn.select) {
        [self.defultBtn setBackgroundImage:[UIImage imageNamed:@"select_on"] forState:UIControlStateNormal];
    }else{
        [self.defultBtn setBackgroundImage:[UIImage imageNamed:@"select_off"] forState:UIControlStateNormal];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WEAKSELF(weakSelf)
    if (indexPath.row<2) {
        Fcgo_AddNewAddressTextFieldTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"addNewAddressTextFieldTableCell"];
        cell.titleLabel.text = self.titleArray[indexPath.row][0];
        cell.inputLabel.placeholder = self.titleArray[indexPath.row][1];
        if (self.model) {
            if (indexPath.row == 0) {
                cell.inputLabel.text = self.model.mchRealName;
            }
            else{
                 cell.inputLabel.text = self.model.mchIdcard;
            }
        }
        if (indexPath.row == 0) {
            self.nameTF = cell.inputLabel;
        }
        else{
            self.cardTF = cell.inputLabel;
        }
        return cell;
    }
    Fcgo_AddRealNameImageTableCell  *cell = [tableView dequeueReusableCellWithIdentifier:@"addRealNameImageTableCell"];
    if (self.model) {
        cell.model = self.model;
    }
    cell.imageBlock = ^(UIImage *mainImage,UIImage *backImage){
       
        weakSelf.realNameMainImage = mainImage;
        weakSelf.realNameBackImage = backImage;
    };
    cell.resignBlock = ^{
        [weakSelf.nameTF resignFirstResponder];
        [weakSelf.cardTF resignFirstResponder];
    };
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row < 2)
    {
        return kAutoWidth6(50);
    }
    
    NSString *string0 = @"温馨提示:请上传原始比例,清晰有效的身份证正反面照片";
     CGFloat height0 = [string0 boundingRectWithSize:CGSizeMake(kScreenWidth - 30, 1000) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:UIFontSize(12)} context:nil].size.height;
     NSString *string1 = @"1.根据海关规定:购买跨境或海外商品需要办理清关手续,请您配合进行实名认证,以确保您购买的商品顺利通过海关检查.";
    CGFloat height1 = [string1 boundingRectWithSize:CGSizeMake(kScreenWidth - 30, 1000) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:UIFontSize(12)} context:nil].size.height;
     NSString *string2 = @"2.声明:备货通只负责提交信息.我们会对您的个人信息进行保密处理,绝不传播或做其它用途,请您放心填写.";
    CGFloat height2 = [string2 boundingRectWithSize:CGSizeMake(kScreenWidth - 30, 1000) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:UIFontSize(12)} context:nil].size.height;
    
    return 2*((kScreenWidth-30-10)/2/1.6)+height0+height1+height2+122;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.5;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footerView = [[UIView alloc]init];
    footerView.backgroundColor = UIBackGroundColor;
    return footerView;
}

#pragma mark Lazy method

- (UITableView *)table
{
    if (!_table) {
        UITableView *table    = [[UITableView alloc]initWithFrame:CGRectMake(0, kNavigationHeight, kScreenWidth, KScreenHeight - kNavigationHeight-kAutoWidth6(50)) style:UITableViewStylePlain];
        table.backgroundColor = UIBackGroundColor;
        table.delegate        = self;
        table.dataSource      = self;
        table.alpha           = 1;
        UIView *footerView   = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 50)];
        self.defultBtn = [Fcgo_IndexButton buttonWithType:UIButtonTypeSystem];
        [self.defultBtn setBackgroundImage:[UIImage imageNamed:@"select_off"] forState:UIControlStateNormal];
        [self.defultBtn addTarget:self action:@selector(defultClick) forControlEvents:UIControlEventTouchUpInside];
        self.defultBtn.frame = CGRectMake(12, 10, 30, 30);
        [footerView addSubview:self.defultBtn];
        
        UILabel *defultLabel = [[UILabel alloc]init];
        defultLabel.font = [UIFont systemFontOfSize:14];
        defultLabel.text = @"默认实名人";
        defultLabel.textColor = UIFontRedColor;
        defultLabel.frame = CGRectMake(self.defultBtn.mj_x+self.defultBtn.mj_w+5, 10, 100, 30);
        [footerView addSubview:defultLabel];
        table.tableFooterView = footerView;
        _table                = table;
        if (@available(iOS 11.0, *)) {
            table.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return _table;
}

- (UIButton *)confirmBtn
{
    if (!_confirmBtn) {
        _confirmBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        _confirmBtn.titleLabel.font = UIFontSize(16);
        [_confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_confirmBtn setTitleColor:UIFontWhiteColor forState:UIControlStateNormal];
        [_confirmBtn setBackgroundColor:UIFontRedColor];
    }
    return _confirmBtn;
}

@end


