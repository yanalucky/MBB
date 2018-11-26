//
//  Fcgo_ApplyAfterSalesServiceVC.m
//  Fcgo
//
//  Created by huafanxiao on 2017/6/14.
//  Copyright © 2017年 huafanxiao. All rights reserved.


#import "Fcgo_ApplyAfterSalesServiceVC.h"
#import "Fcgo_AfterSalesService_ReviewVC.h"
#import "Fcgo_AddNewAddressTextFieldTableCell.h"
#import "Fcgo_GoodsDetailSection1Cell.h"
#import "Fcgo_AddNewAddressTextViewTableCell.h"

#import "Fcgo_RegistBackImageCell.h"

@interface Fcgo_ApplyAfterSalesServiceVC ()<UITableViewDelegate,UITableViewDataSource,Fcgo_UploadImageManagerDelegate>

@property (nonatomic,strong) UITableView    *table;
@property (nonatomic,strong) UIButton       *applyBtn;

@property (nonatomic,strong) UILabel *typeLabel;
@property (nonatomic,strong) NSString *typeString;
@property (nonatomic,strong) UITextField *moneyTF;
@property (nonatomic,strong) UITextField *countTF;
@property (nonatomic,strong) Fcgo_UITextView *textView;

@property (nonatomic,strong) NSArray          *applyImageArray;
@property(nonatomic,strong)  NSMutableArray   *applyImageUrlArray;


@end

@implementation Fcgo_ApplyAfterSalesServiceVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupUI];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.fd_fullscreenPopGestureRecognizer.enabled = NO;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.fd_fullscreenPopGestureRecognizer.enabled = YES;
}

- (void)setupUI;
{
    WEAKSELF(weakSelf)
    [self.navigationView setupBackBtnBlock:^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    }];
    [self.navigationView setupTitleLabelWithTitle:@"申请售后"];
    
    [self.table registerNib:[UINib nibWithNibName:NSStringFromClass([Fcgo_AddNewAddressTextFieldTableCell class]) bundle:nil] forCellReuseIdentifier:@"addNewAddressTextFieldTableCell"];
    [self.table registerNib:[UINib nibWithNibName:NSStringFromClass([Fcgo_GoodsDetailSection1Cell class]) bundle:nil] forCellReuseIdentifier:@"goodsDetailSection1Cell"];
    [self.table registerNib:[UINib nibWithNibName:NSStringFromClass([Fcgo_AddNewAddressTextViewTableCell class]) bundle:nil] forCellReuseIdentifier:@"addNewAddressTextViewTableCell"];
    
    [self.table registerNib:[UINib nibWithNibName:NSStringFromClass([Fcgo_RegistBackImageCell class]) bundle:nil] forCellReuseIdentifier:@"registBackImageCell"];
    
    [self.view insertSubview:self.table belowSubview:self.navigationView];
    
    [self.applyBtn addTarget:self action:@selector(apply) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.applyBtn];
    [self.applyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_offset(0);
        make.height.mas_offset(kAutoWidth6(50));
    }];
}

- (void)apply
{
    if ([Fcgo_Tools isNullString:self.typeString])
    {
        [WSProgressHUD showImage:nil status:@"请选择售后类型"];
        return;
    }
    
    if ([Fcgo_Tools isNullString:self.textView.text])
    {
        [WSProgressHUD showImage:nil status:@"请填写售后原因"];
        return;
    }
    
    if (self.textView.text.length<10)
    {
        [WSProgressHUD showImage:nil status:@"售后原因字数不少小于10个"];
        return;
    }
    
    if ([Fcgo_Tools isNullString:self.moneyTF.text]) {
        [WSProgressHUD showImage:nil status:@"请填写退款金额"];
        return;
    }
//    if (![Fcgo_Tools judgeTextcharacterstextLegal:self.moneyTF.text]) {
//        [WSProgressHUD showImage:nil status:@"金额必须是数字"];
//        return;
//    }
    
    if ([Fcgo_Tools isNullString:self.countTF.text]) {
        [WSProgressHUD showImage:nil status:@"请填写退款数量"];
        return;
    }
    if (![Fcgo_Tools judgeTextcharacterstextLegal:self.countTF.text]) {
        [WSProgressHUD showImage:nil status:@"数量必须是数字"];
        return;
    }
    
    if (self.countTF.text.intValue > self.model.num.intValue) {
        [WSProgressHUD showImage:nil status:@"退款数量不能大于商品数量"];
        return;
    }
    
    [WSProgressHUD showWithStatus:@"申请提交中,请勿退出..." maskType:WSProgressHUDMaskTypeClear];
    [self  startUploadImage];
}

-(void)startUploadImage
{
    if (self.applyImageArray && self.applyImageArray.count>0) {
        [[Fcgo_UploadImageManager shareInstance] uploadImageFromImageArray:[NSMutableArray arrayWithArray:self.applyImageArray]];
        [Fcgo_UploadImageManager shareInstance].delegate = self;
    }
    else{
        [self  confrim];
    }
}

- (void)uploadImagesSucceed:(NSMutableArray *)array
{
    self.applyImageUrlArray = array;
    [self  confrim];
    
}

- (void)confrim
{
    NSMutableDictionary  *paremetwers = [NSMutableDictionary dictionary];
    [paremetwers setObjectWithNullValidate:self.orderId forKey:@"orderId"];
    [paremetwers setObjectWithNullValidate:self.textView.text forKey:@"refundReson"];
    [paremetwers setObjectWithNullValidate:self.moneyTF.text forKey:@"refundMoney"];
    [paremetwers setObjectWithNullValidate:self.countTF.text forKey:@"refundNum"];
    [paremetwers setObjectWithNullValidate:self.model.orderChildId forKey:@"orderGoodsId"];
    if (self.applyImageUrlArray&& self.applyImageUrlArray.count>0 ) {
        NSString  *urls = @"";
        for (int i = 0; i < self.applyImageUrlArray.count; i++ )
        {
            urls=[urls stringByAppendingString:self.applyImageUrlArray[i]];
            if (i<self.applyImageArray.count-1) {
                urls=[urls stringByAppendingString:@","];
            }
        }
        [paremetwers  setObjectWithNullValidate:urls forKey:@"refundPicurl"];
    }
    [Fcgo_NetworkManager postRequest:NSFormatHeardUrl(@"order/addOrderRefund") parametersContentCommon:paremetwers successBlock:^(BOOL success, id responseObject, NSString *msg) {
        [WSProgressHUD dismiss];
        if (success) {
            if(self.applyBlock)
            {
                self.applyBlock();
            }
            Fcgo_AfterSalesService_ReviewVC *vc = [[Fcgo_AfterSalesService_ReviewVC alloc]init];
            vc.hidesBottomBarWhenPushed = 1;
            [self.navigationController pushViewController:vc animated:YES];
        }
        else
        {
            
        }
    } failureBlock:^(NSString *description) {
        
    }];
}

#pragma mark table delegate datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WEAKSELF(weakSelf)
    if (indexPath.row == 0) {
        Fcgo_GoodsDetailSection1Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"goodsDetailSection1Cell"];
        cell.titleLabel.text = @"售后类型:";
        cell.choseLabel.text = @"请选择类型";
        cell.choseLabel.textColor = UIRGBColor(190, 190, 190, 1);
        self.typeLabel = cell.choseLabel;
        return cell;
    }
    else if (indexPath.row == 1 ) {
        Fcgo_AddNewAddressTextViewTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"addNewAddressTextViewTableCell"];
        cell.textView.placeholder = @"请写下退款详细说明，不能少于十个字";
        self.textView = cell.textView;
        return cell;
    }
    else if (indexPath.row == 3|| indexPath.row == 2) {
        Fcgo_AddNewAddressTextFieldTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"addNewAddressTextFieldTableCell"];
        //cell.inputLabel.keyboardType = UIKeyboardTypeASCIICapableNumberPad;
        if (indexPath.row == 2) {
            cell.titleLabel.text = @"退款金额:";
            cell.inputLabel.placeholder =@"请输入退货金额";
            self.moneyTF = cell.inputLabel;
        }
        else{
            cell.titleLabel.text = @"退货数量:";
            cell.inputLabel.placeholder =@"请输入退货数量";
            self.countTF = cell.inputLabel;
        }
        return cell;
    }
    Fcgo_RegistBackImageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"registBackImageCell"];
    cell.titleLabel.text = @"请上传申请售后凭证";
    cell.descLabel.text = @"一至六张(超过三张可左滑)";
    cell.imageBlock = ^(NSArray *imageArray)
    {
        weakSelf.applyImageArray = imageArray;
    };
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0 || indexPath.row == 2 || indexPath.row == 3)
    {
        return kAutoWidth6(50);
    }
    else if (indexPath.row == 1)
    {
        return kAutoWidth6(100);
    }
    CGFloat itemW = (kScreenWidth- 48) / 3;
    return 74 + itemW;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.view endEditing:YES];
    if (indexPath.row == 0) {
        [Fcgo_SheetAnimationView showWithArray:@[@"仅退款",@"退货退款"] DidSelectedBlock:^(NSInteger index) {
            self.typeLabel.textColor = UIFontMainGrayColor;
            if (index == 0) {
                 self.typeLabel.text = @"仅退款";
                 self.typeString = @"仅退款";
            }
            else{
                 self.typeLabel.text = @"退货退款";
                self.typeString = @"退货退款";
            }
        }];
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
}

#pragma mark Lazy method

- (UITableView *)table
{
    if (!_table) {
        UITableView *table = [[UITableView alloc]initWithFrame:CGRectMake(0, kNavigationHeight, kScreenWidth, KScreenHeight - kNavigationHeight - kAutoWidth6(50)) style:UITableViewStylePlain];
        table.delegate = self;
        table.dataSource = self;
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 0.5)];
        line.backgroundColor = UISepratorLineColor;
        table.tableFooterView = line;
        //table.contentInset = UIEdgeInsetsMake(0, 0, 5, 0);
        _table = table;
        if (@available(iOS 11.0, *)) {
            table.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return _table;
}

- (UIButton *)applyBtn
{
    if (!_applyBtn) {
        _applyBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        _applyBtn.titleLabel.font = UIFontSize(16);
        [_applyBtn setTitle:@"提交申请" forState:UIControlStateNormal];
        [_applyBtn setTitleColor:UIFontWhiteColor forState:UIControlStateNormal];
        [_applyBtn setBackgroundColor:UIFontRedColor];
    }
    return _applyBtn;
}

@end

