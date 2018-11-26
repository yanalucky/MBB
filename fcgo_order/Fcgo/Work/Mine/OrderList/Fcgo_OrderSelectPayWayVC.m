//
//  Fcgo_OrderSelectPayWayVC.m
//  Fcgo
//
//  Created by huafanxiao on 2017/6/25.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_OrderSelectPayWayVC.h"
#import "Fcgo_OrderPaySection2Row1Cell.h"
#import <objc/message.h>
#import "Fcgo_OrderPaySuccessVC.h"
#import "Fcgo_OrderLinePayVC.h"

@interface Fcgo_OrderSelectPayWayVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView    *table;
@property (nonatomic,strong) NSArray        *titleArray;
@property (nonatomic,strong) UIButton       *payBtn;
@property (nonatomic,assign) NSInteger       selectIndex;

@end

@implementation Fcgo_OrderSelectPayWayVC

- (void)addPaySuccessNotification {
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(acceptPay) name:@"pay" object:nil];
}

- (void)acceptPay {
    
    if (self.paySuccessBlock) {
        self.paySuccessBlock();
    }
    
    Fcgo_OrderPaySuccessVC *vc = [[Fcgo_OrderPaySuccessVC alloc]init];
    vc.hidesBottomBarWhenPushed = 1;
    if (self.orderDetailModel) {
        vc.orderId = [NSString stringWithFormat:@"%@",self.orderDetailModel.ID];
    }
    
    if (self.model.ID) {
        vc.orderId = [NSString stringWithFormat:@"%@",self.model.ID];
    }
    [self.navigationController pushViewController:vc animated:1];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupUI];
    
    [self addPaySuccessNotification];
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)setupUI;
{
    self.selectIndex = 0;
    self.titleArray = @[
                        @[@"支付宝",  @"aliPay"],
                        @[@"微信支付",@"weixinPay"],
                        @[@"线下支付",@"linePay"],
                        ];
    WEAKSELF(weakSelf)
    [self.navigationView setupBackBtnBlock:^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    }];
    [self.navigationView setupTitleLabelWithTitle:@"支付中心"];
    
    [self.table registerNib:[UINib nibWithNibName:NSStringFromClass([Fcgo_OrderPaySection2Row1Cell class]) bundle:nil] forCellReuseIdentifier:@"orderPaySection2Row1Cell"];
    [self.view insertSubview:self.table belowSubview:self.navigationView];
    
    [self.payBtn addTarget:self action:@selector(pay) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.payBtn];
    [self.payBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_offset(0);
        make.height.mas_offset(kAutoWidth6(50));
    }];
}

- (void)pay
{
    //WEAKSELF(weakSelf);
    //线下支付
    if (self.selectIndex == 2)
    {
        Fcgo_OrderLinePayVC *vc = [[Fcgo_OrderLinePayVC alloc]init];
        vc.hidesBottomBarWhenPushed = 1;
        if (self.model) {
            vc.listModel = self.model;
        }else{
            vc.orderDetailModel = self.orderDetailModel;
        }
        [self.navigationController pushViewController:vc animated:1];
        return;
    }
    
    NSString *payType;
    if (self.selectIndex == 0 )
    {
        payType = @"appzfb";
    }
    if (self.selectIndex == 1)
    {
        payType = @"appweixin";
    }
    
    NSMutableDictionary   *paremtes = [NSMutableDictionary dictionary];
    NSNumber *orderId;
    NSString *orderNo;
    if (self.model) {
        orderId = self.model.ID;
        orderNo = self.model.orderNo;
    }
    else
    {
        orderId = self.orderDetailModel.ID;
        orderNo = self.orderDetailModel.orderNo;
    }
    [paremtes  setObjectWithNullValidate:orderId forKey:@"order"];
    [paremtes  setObjectWithNullValidate:payType forKey:@"payType"];
    [paremtes setObjectWithNullValidate:orderNo forKey:@"orderNo"];
    WEAKSELF(weakSelf);
    [Fcgo_NetworkManager postRequest:NSFormatHeardMeThodUrl(ServiceLocalTypeOne, ORDERMETHOD, @"payDo") parametersContentCommon:paremtes successBlock:^(BOOL success, id responseObject, NSString *msg) {
        if (success)
        {
            if (weakSelf.selectIndex == 0) {
                NSString *siginKey = responseObject[@"data"][@"data"];
                NSString *appScheme=@"openfcgo";
                [[AlipaySDK defaultService] payOrder:siginKey fromScheme:appScheme callback:^(NSDictionary *resultDic) {
                    if (![resultDic isKindOfClass:[NSNull  class]]) {
                        NSInteger  resultStatus = [[resultDic  objectForKey:@"resultStatus"] integerValue];
                        if (![Fcgo_Tools isNullString:[resultDic  objectForKey:@"memo"]]) {
                            [WSProgressHUD  showImage:nil status:[resultDic  objectForKey:@"memo"]];
                        }
                        if (resultStatus == 9000)
                        {
                            [WSProgressHUD  showImage:nil status:[resultDic  objectForKey:@"支付成功"]];
                            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                Fcgo_OrderPaySuccessVC *vc = [[Fcgo_OrderPaySuccessVC alloc]init];
                                vc.hidesBottomBarWhenPushed = 1;
                                if (weakSelf.orderDetailModel) {
                                    vc.orderId = [NSString stringWithFormat:@"%@",weakSelf.orderDetailModel.ID];
                                }
                                
                                if (weakSelf.model.ID) {
                                    vc.orderId = [NSString stringWithFormat:@"%@",weakSelf.model.ID];
                                }
                                [self.navigationController pushViewController:vc animated:1];
                            });
                            
                        }
                    }
                }];
            }
            if (weakSelf.selectIndex == 1) {
                
                NSDictionary  *dataDict = (NSDictionary *)[responseObject objectForKey:@"data"][@"data"];
                PayReq *request = [[PayReq alloc] init];
                request.partnerId = dataDict[@"partnerid"];
                request.prepayId  = dataDict[@"prepayid"];
                request.package   = dataDict[@"package"];
                request.nonceStr  = dataDict[@"nonceStr"];
                request.timeStamp = [dataDict[@"timeStamp"] unsignedIntValue];
                request.sign = dataDict[@"sign"];
                [WXApi sendReq:request];
            }
        }
        
    } failureBlock:^(NSString *description) {
        
    }];
}

#pragma mark table delegate datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.titleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Fcgo_OrderPaySection2Row1Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"orderPaySection2Row1Cell"];
    cell.titleLabel.text = self.titleArray[indexPath.row][0];
    cell.titleImageView.image = [UIImage imageNamed:self.titleArray[indexPath.row][1]];
    if (self.selectIndex == indexPath.row) {
        cell.selectImageView.hidden = 0;
    }else{
        cell.selectImageView.hidden = 1;
    }
    if (indexPath.row == 2) {
        cell.titleDescLabel.hidden = 0;
        cell.titleDescLabel.text = @"需上传支付截图凭证，等待财务确认";
    }else
    {
        cell.titleDescLabel.hidden = 1;
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kAutoWidth6(50);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Fcgo_OrderPaySection2Row1Cell *deselectCell = [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:self.selectIndex inSection:0]];
    deselectCell.selectImageView.hidden = 1;
    Fcgo_OrderPaySection2Row1Cell *selectCell = [tableView cellForRowAtIndexPath:indexPath];
    selectCell.selectImageView.hidden = 0;
    self.selectIndex = indexPath.row;
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark Lazy method

- (UITableView *)table
{
    if (!_table) {
        UITableView *table = [[UITableView alloc]initWithFrame:CGRectMake(0, kNavigationHeight, kScreenWidth, KScreenHeight - kNavigationHeight-kAutoWidth6(50)) style:UITableViewStylePlain];
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

- (UIButton *)payBtn
{
    if (!_payBtn) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        btn.titleLabel.font = UIFontSize(16);
        [btn setTitle:@"立即支付" forState:UIControlStateNormal];
        [btn setTitleColor:UIFontWhiteColor forState:UIControlStateNormal];
        [btn setBackgroundColor:UIFontRedColor];
        _payBtn = btn;
    }
    return _payBtn;
}

@end


