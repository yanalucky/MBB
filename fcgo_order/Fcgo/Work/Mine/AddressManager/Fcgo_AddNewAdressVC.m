//
//  Fcgo_AddNewAdressVC.m
//  Fcgo
//
//  Created by huafanxiao on 2017/5/27.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_AddNewAdressVC.h"
#import "Fcgo_AddNewAddressTextFieldTableCell.h"
#import "Fcgo_GoodsDetailSection1Cell.h"
#import "Fcgo_AddNewAddressTextViewTableCell.h"

@interface Fcgo_AddNewAdressVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView      *table;
@property (nonatomic,strong) NSArray          *titleArray;
@property (nonatomic,strong) Fcgo_IndexButton *defultBtn;
@property (nonatomic,strong) UIButton         *confirmBtn;
@property (nonatomic,strong) Fcgo_ExterAddressPickerView *pickerView;

@property (nonatomic,strong) UITextField *nameTF;
@property (nonatomic,strong) UITextField *telTF;
@property (nonatomic,strong) Fcgo_UITextView *addressTV;
@property (nonatomic,strong) NSDictionary    *addressDict;

@end

@implementation Fcgo_AddNewAdressVC

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
    
    
    self.titleArray = @[@[@"收  件  人:",@"请输入姓名"],
                        @[@"联系电话:",@"请输入号码"],
                        @[@"所在地区:",@"请选择地区"]
                        ];
    
    [self.table registerNib:[UINib nibWithNibName:NSStringFromClass([Fcgo_AddNewAddressTextFieldTableCell class]) bundle:nil] forCellReuseIdentifier:@"addNewAddressTextFieldTableCell"];
    [self.table registerNib:[UINib nibWithNibName:NSStringFromClass([Fcgo_GoodsDetailSection1Cell class]) bundle:nil] forCellReuseIdentifier:@"goodsDetailSection1Cell"];
    [self.table registerNib:[UINib nibWithNibName:NSStringFromClass([Fcgo_AddNewAddressTextViewTableCell class]) bundle:nil] forCellReuseIdentifier:@"addNewAddressTextViewTableCell"];
    
    [self.view addSubview:self.table];
    if (self.model) {
        self.addressDict = @{@"province":@{@"areaName":@"",
                                           @"areaId":self.model.addressProvince
                                           },
                             @"city":@{@"areaName":@"",
                                       @"areaId":self.model.addressCity
                                       },
                             @"area":@{@"areaName":@"",
                                       @"areaId":self.model.addressArea
                                       }
                             };
        
        self.defultBtn.select = self.model.deFault.intValue;
        if (self.defultBtn.select == NO) {
            [self.defultBtn setBackgroundImage:[UIImage imageNamed:@"select_off"] forState:UIControlStateNormal];
        }
        else
        {
           self.table.tableFooterView.hidden = 1;
            [self.defultBtn setBackgroundImage:[UIImage imageNamed:@"select_on"] forState:UIControlStateNormal];
        }
        [self.navigationView setupTitleLabelWithTitle:@"编辑地址"];
    }else{
        [self.navigationView setupTitleLabelWithTitle:@"添加新地址"];
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
    
    NSMutableDictionary  *muatble = [NSMutableDictionary dictionary];
//    NSString *provinceID = self.addressDict[@"province"][@"areaId"];
//    NSString *cityID     = self.addressDict[@"city"][@"areaId"];
    NSString *areaID     = self.addressDict[@"area"][@"areaId"];
//    [muatble setObjectWithNullValidate:provinceID forKey:@"province"];
//    [muatble setObjectWithNullValidate:cityID forKey:@"citys"];
    [muatble setObjectWithNullValidate:areaID forKey:@"areaCode"];
    [muatble setObjectWithNullValidate:self.addressTV.text forKey:@"addressDetail"];
    [muatble setObjectWithNullValidate:self.nameTF.text forKey:@"consigee"];
    [muatble setObjectWithNullValidate:self.telTF.text forKey:@"consigeePhone"];
    [muatble setObjectWithNullValidate:[NSString stringWithFormat:@"%d",self.defultBtn.select] forKey:@"setDefault"];
    
    [WSProgressHUD showWithStatus:@"地址上传中..." maskType:WSProgressHUDMaskTypeClear];
    
    WEAKSELF(weakSelf);
    NSString *url;
    if (self.model) {
        url = NSFormatHeardMeThodUrl(ServiceLocalTypeOne,ADDRESSMETHOD, @"updateAddress");
        [muatble setObjectWithNullValidate:self.model.f_address_id forKey:@"id"];
        
    }else{
        url = NSFormatHeardMeThodUrl(ServiceLocalTypeOne,ADDRESSMETHOD, @"addAddress");
    }
    [Fcgo_NetworkManager postRequest:url parametersContentCommon:muatble successBlock:^(BOOL success, id responseObject, NSString *msg) {
        [WSProgressHUD dismiss];
        if (success) {
            [WSProgressHUD showSuccessWithStatus:@"添加成功"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                if (self.reloadBlock) {
                    self.reloadBlock();
                }
                [weakSelf.navigationController popViewControllerAnimated:YES];
            });
        }
    } failureBlock:^(NSString *description) {}];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //WEAKSELF(weakSelf)
    if (indexPath.row < 2) {
        Fcgo_AddNewAddressTextFieldTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"addNewAddressTextFieldTableCell"];
        cell.titleLabel.text = self.titleArray[indexPath.row][0];
        cell.inputLabel.placeholder = self.titleArray[indexPath.row][1] ;
        
        if (indexPath.row == 0) {
            if (self.model) {
                cell.inputLabel.text = self.model.consigee;
            }
            self.nameTF = cell.inputLabel;
        }else{
            if (self.model) {
                cell.inputLabel.text = self.model.consigeePhone;
            }
            self.telTF = cell.inputLabel;
        }
        
        return cell;
    }
    else if(indexPath.row == 2)
    {
        Fcgo_GoodsDetailSection1Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"goodsDetailSection1Cell"];
        cell.bottomLineView.hidden = 1;
        cell.titleLabel.text = self.titleArray[indexPath.row][0];
        cell.choseLabel.text = self.titleArray[indexPath.row][1];
        cell.choseLabel.textColor = UIRGBColor(190, 190, 190, 1);
        [cell.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(15);
            make.top.bottom.mas_offset(0);
        }];
        if (self.model) {
            cell.choseLabel.textColor = UIFontMainGrayColor;
            cell.choseLabel.text = self.model.addressFormal;
        }
        
        return cell;
    }
    
    Fcgo_AddNewAddressTextViewTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"addNewAddressTextViewTableCell"];
    cell.textView.placeholder = @"请写下详细地址，不能少于五个字";
    if(self.model)
    {
        cell.textView.text = self.model.addressDetail;
    }
    
    self.addressTV = cell.textView;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 2)
    {
        [self.view endEditing:YES];
        [self.pickerView show];
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row < 3)
    {
        return kAutoWidth6(50);
    }
    return 100;
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

- (void)defultClick
{
    self.defultBtn.select = !self.defultBtn.select;
    if (self.defultBtn.select) {
        [self.defultBtn setBackgroundImage:[UIImage imageNamed:@"select_on"] forState:UIControlStateNormal];
    }else{
        [self.defultBtn setBackgroundImage:[UIImage imageNamed:@"select_off"] forState:UIControlStateNormal];
    }
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
        defultLabel.font = [UIFont systemFontOfSize:15];
        defultLabel.text = @"设为默认地址";
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

- (Fcgo_ExterAddressPickerView *)pickerView
{
     WEAKSELF(weakSelf)
    if (!_pickerView) {
        _pickerView = [[Fcgo_ExterAddressPickerView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, KScreenHeight) selectAddressBlock:^(NSMutableDictionary *addressDict) {
           //NSLog(@">>>>>%@",addressDict);
           weakSelf.addressDict = addressDict;
            Fcgo_GoodsDetailSection1Cell *cell = [weakSelf.table cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
            cell.choseLabel.text = [NSString stringWithFormat:@"%@%@%@",addressDict[@"province"][@"areaName"],addressDict[@"city"][@"areaName"],addressDict[@"area"][@"areaName"]];
            
            cell.choseLabel.textColor = UIFontMainGrayColor;
        }];
    }
    return _pickerView;
}

@end
