//
//  Fcgo_OrderLinePayVC.m
//  Fcgo
//
//  Created by huafanxiao on 2017/6/12.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_OrderLinePayVC.h"
#import "Fcgo_OrderLinePayRow0Cell.h"
#import "Fcgo_RegistBackImageCell.h"
#import "Fcgo_ReviewLinePayVC.h"

@interface Fcgo_OrderLinePayVC ()<UITableViewDelegate,UITableViewDataSource,Fcgo_UploadImageManagerDelegate>
@property (nonatomic,strong) UITableView    *table;
@property (nonatomic,strong) UIButton       *cofirmBtn;
@property (nonatomic,strong) NSArray        *payImageArray;
@property (nonatomic,strong) NSMutableArray *payImageUrlsArray;
@end

@implementation Fcgo_OrderLinePayVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.fd_fullscreenPopGestureRecognizer.enabled = NO;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.fd_fullscreenPopGestureRecognizer.enabled = YES;
}

#pragma mark - private method
- (void)cofirm {
    if (!self.payImageArray ||self.payImageArray.count <= 0) {
        [WSProgressHUD showImage:nil status:@"请选择支付凭证图片"];
        return;
    }
    [self startUploadImage];
}

-(void)startUploadImage {
    [WSProgressHUD showWithStatus:@"提交中..." maskType:WSProgressHUDMaskTypeClear];
    [[Fcgo_UploadImageManager shareInstance] uploadImageFromImageArray:[NSMutableArray arrayWithArray:self.payImageArray]];
    [Fcgo_UploadImageManager shareInstance].delegate = self;
}

- (void)sumbit {
    NSMutableDictionary  *paremetwers = [NSMutableDictionary dictionary];
    NSString  *urls = @"";
    for (int i = 0; i < self.payImageUrlsArray.count; i++ ) {
        urls = [urls stringByAppendingString:self.payImageUrlsArray[i]];
        if (i < self.payImageUrlsArray.count - 1) {
            urls = [urls stringByAppendingString:@","];
        }
    }
    [paremetwers  setObjectWithNullValidate:urls forKey:@"picurl"];
    
    NSString *payType = @"offline";
    if (self.model) {
        [paremetwers  setObjectWithNullValidate:self.model.orderId forKey:@"order"];
        [paremetwers setObjectWithNullValidate:self.model.orderNo forKey:@"orderNo"];
    }
    else {
        [paremetwers  setObjectWithNullValidate:self.listModel.ID forKey:@"order"];
        [paremetwers setObjectWithNullValidate:self.listModel.orderNo forKey:@"orderNo"];
    }
    [paremetwers  setObjectWithNullValidate:payType forKey:@"payType"];
    [WSProgressHUD showWithStatus:@"加载中..." maskType:(WSProgressHUDMaskTypeDefault)];
    [Fcgo_NetworkManager postRequest:NSFormatHeardMeThodUrl(ServiceLocalTypeOne, ORDERMETHOD, @"payDo") parametersContentCommon:paremetwers successBlock:^(BOOL success, id responseObject, NSString *msg) {
        if (success) {
            NSNumber *errCode = responseObject[@"errorCode"];
            if (errCode.intValue == 0) {
                [WSProgressHUD showImage:nil status:@"资料提交成功"];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [WSProgressHUD dismiss];
                    Fcgo_ReviewLinePayVC *vc = [[Fcgo_ReviewLinePayVC alloc]init];
                    vc.hidesBottomBarWhenPushed = 1;
                    [self.navigationController pushViewController:vc animated:YES];
                });
            }
        }
    } failureBlock:^(NSString *description) {
    
    }];
}
#pragma mark - delegate
#pragma mark table delegate datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WEAKSELF(weakSelf);
    if (indexPath.row == 0) {
        Fcgo_OrderLinePayRow0Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"orderLinePayRow0Cell"];
        if (self.model) {
             cell.model = self.model;
        }
        if (self.listModel) {
            cell.listModel = self.listModel;
        }
        if (self.orderDetailModel) {
            cell.orderDetailModel = self.orderDetailModel;
        }
        return cell;
    }
    Fcgo_RegistBackImageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"registBackImageCell"];
    cell.imageBlock = ^(NSArray *imageArray){
        weakSelf.payImageArray = imageArray;
    };
    cell.titleLabel.text = @"请上传图片";
    cell.descLabel.text = @"一至六张(超过三张可左滑)";
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.row == 0) {
        return 160;
    }
    CGFloat itemW = (kScreenWidth- 48) / 3;
    return 74 + itemW;;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    return;
}

#pragma mark Fcgo_UploadImageManagerDelegate
-(void)uploadImagesSucceed:(NSMutableArray *)array {
    self.payImageUrlsArray = array;
    [self sumbit];
}

#pragma mark - UI
- (void)setupUI {
    WEAKSELF(weakSelf)
    [self.navigationView setupBackBtnBlock:^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    }];
    [self.navigationView setupTitleLabelWithTitle:@"线下支付"];
    
    [self.table registerNib:[UINib nibWithNibName:NSStringFromClass([Fcgo_OrderLinePayRow0Cell class]) bundle:nil] forCellReuseIdentifier:@"orderLinePayRow0Cell"];
    [self.table registerNib:[UINib nibWithNibName:NSStringFromClass([Fcgo_RegistBackImageCell class]) bundle:nil] forCellReuseIdentifier:@"registBackImageCell"];
    [self.view addSubview:self.table];
    
    
    [self.cofirmBtn addTarget:self action:@selector(cofirm) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.cofirmBtn];
    [self.cofirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_offset(0);
        make.height.mas_offset(kAutoWidth6(50));
    }];
}
#pragma mark - Lazy method
- (UITableView *)table {
    if (!_table) {
        UITableView *table = [[UITableView alloc]initWithFrame:CGRectMake(0, kNavigationHeight, kScreenWidth, KScreenHeight - kNavigationHeight - kAutoWidth6(50)) style:UITableViewStylePlain];
        table.delegate = self;
        table.dataSource = self;
        table.separatorStyle = 0;
        _table = table;
        if (@available(iOS 11.0, *)) {
            table.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return _table;
}

- (UIButton *)cofirmBtn {
    if (!_cofirmBtn) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        btn.titleLabel.font = UIFontSize(16);
        [btn setTitle:@"确定" forState:UIControlStateNormal];
        [btn setTitleColor:UIFontWhiteColor forState:UIControlStateNormal];
        [btn setBackgroundColor:UIFontRedColor];
        _cofirmBtn = btn;
    }
    return _cofirmBtn;
}

@end
