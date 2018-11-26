//
//  Fcgo_OrderConfirmVC.m
//  Fcgo
//
//  Created by huafanxiao on 2017/6/12.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_OrderConfirmVC.h"
#import "Fcgo_AddNewAdressTableViewCell.h"
#import "Fcgo_OrderConfirmAdressTableCell.h"
#import "Fcgo_OrderConfirmNoneAdressTableCell.h"
#import "Fcgo_OrderConfirmRealNameTableCell.h"
#import "Fcgo_OrderConfirmNoneImageRealNameTableCell.h"
#import "Fcgo_OrderConfirmNoneRealNameTableCell.h"

#import "Fcgo_OrderConfirmGoodsTableCell.h"
#import "Fcgo_OrderConfirmTotalTableCell.h"
#import "Fcgo_OrderConfirmSection2Row1Cell.h"
#import "Fcgo_OrderConfirmSection2Row2Cell.h"

#import "Fcgo_OrderConfirmBottomView.h"

#import "Fcgo_OrderPayVC.h"

#import "Fcgo_GoodsDetailVC.h"
#import "Fcgo_RealNameVC.h"

#import "Fcgo_OrderPayModel.h"

#import "Fcgo_OrderUseAdressVC.h"
#import "Fcgo_OrderUseRealNameVC.h"
#import "Fcgo_OrderUseCouponVC.h"
#import "Fcgo_AddressModel.h"
#import "Fcgo_RealNameModel.h"
#import "Fcgo_CouponModel.h"

@interface Fcgo_OrderConfirmVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView    *table;
@property (nonatomic,strong) Fcgo_OrderConfirmBottomView *bottomView;
@property (nonatomic,strong) UITextField   *remarksTF;
@property (nonatomic,strong) Fcgo_RealNameModel *useRealNameModel;
@property (nonatomic,strong) Fcgo_CouponModel   *useCouponModel;
@property (nonatomic,strong) NSMutableArray   *couponArray;
@property (nonatomic, strong) NSDictionary  *activityDictionary;



@property (nonatomic,assign) BOOL receiveUseRealNameData;
//@property (nonatomic,assign) float freight;
@end

@implementation Fcgo_OrderConfirmVC

#pragma mark - lify cycle
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidAppear:(BOOL)animated {
    [self.bottomView showWithAnimation];
    [super viewDidAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    self.selectedAdressModel = nil;
    NSNumber *total = self.model.totalPrice;
    self.bottomView.totalString = [NSString stringWithFormat:@"¥ %.2f",round(total.floatValue*100)/10000];//  [NSString stringWithFormat:@"¥ %.2f",total.floatValue/100];
//    self.freight = 0.00;
//    self.bottomView.freightLabel.text = [NSString stringWithFormat:@"运费: ¥ %.2f",self.freight];
    dispatch_async(dispatch_get_main_queue(), ^{
        [WSProgressHUD showWithStatus:@"加载中..." maskType:WSProgressHUDMaskTypeClear];
    });
    dispatch_group_t group = dispatch_group_create();
//    //if (self.selectedAdressModel) {
//        dispatch_group_async(group, dispatch_get_global_queue(0, 0), ^{
//            dispatch_group_enter(group);
//            [self getCanUseActivity:self.selectedAdressModel.addressArea block:^{
//                dispatch_group_leave(group);
//            }];
//        });
//        dispatch_group_async(group, dispatch_get_global_queue(0, 0), ^{
//            dispatch_group_enter(group);
//            [self requestUseCoupon:^{
//                dispatch_group_leave(group);
//            } areaId:self.selectedAdressModel.addressArea];
//        });
//    //}
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        [self.table reloadData];
        NSNumber *activity = self.activityDictionary[@"loan"];
        [self setTotalPrice:self.model.totalPrice.floatValue/100 activity:activity ? activity.floatValue : 0 coupon:0 freight:[self getFreight]];
        [WSProgressHUD dismiss];
    });
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(receiveDeleteRealName:) name:@"deleteRealName" object:nil];
}
#pragma mark - private method
/// 删除会员通知
- (void)receiveDeleteRealName:(NSNotification *)notify {
    Fcgo_RealNameModel *model = (Fcgo_RealNameModel *)notify.object;
    if (model.f_realName_id.intValue == self.useRealNameModel.f_realName_id.intValue) {
        self.useRealNameModel = nil;
        [self.table reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:1 inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
    }
}

- (void)requestRealNameCanUse
{
    WEAKSELF(weakSelf);
    NSMutableDictionary   *paremtes = [NSMutableDictionary dictionary];
    [paremtes  setObjectWithNullValidate:self.useRealNameModel.mchIdcard forKey:@"idCard"];
    [Fcgo_NetworkManager postRequest:NSFormatHeardMeThodUrl(ServiceLocalTypeOne, REALNAMEMETHOD, @"getCanUseRealNameList")
                          parametersContentCommon:paremtes successBlock:^(BOOL success, id responseObject, NSString *msg) {
        NSNumber *errCode = responseObject[@"errorCode"];
        if (errCode.intValue == 0) {
            [weakSelf requestSumbitOrder];
        }
        else{
            [WSProgressHUD showImage:nil status:responseObject[@"errorMsg"]];
        }
    } failureBlock:^(NSString *description) {}];
}

/// 获取优惠券
- (void)requestUseCoupon:(void(^)(void))block areaId:(NSString *)areaId{
    WEAKSELF(weakSelf)
    NSMutableDictionary   *paremtes = [NSMutableDictionary dictionary];
    //[paremtes  setObjectWithNullValidate:self.model.goods forKey:@"goods"];
    
    
    NSString *jsonString = self.model.goods;
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSArray *array = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        [WSProgressHUD showImage:nil status:@"数据错误"];
        return;
    }
    [paremtes setObjectWithNullValidate:self.model.goods forKey:@"goodsInfo"];
    [paremtes setObjectWithNullValidate:areaId forKey:@"area"];
    [Fcgo_NetworkManager postRequest:NSFormatHeardMeThodUrl(ServiceLocalTypeOne, COUPON, @"getCanUseCouponList") parametersContentCommon:paremtes successBlock:^(BOOL success, id responseObject, NSString *msg) {
        if (success) {
            [weakSelf.couponArray removeAllObjects];
                NSArray *couponArray = responseObject[@"data"][@"canUseCoupons"];
                if (couponArray.count<=0) {
                    self.useCouponModel = nil;
                    !block?:block();
                    return ;
                }
                else {
                    for (int i = 0; i < couponArray.count; i ++) {
                        NSDictionary *couponDict = couponArray[i];
                        Fcgo_CouponModel *model = [Fcgo_CouponModel yy_modelWithDictionary:couponDict];
                        [weakSelf.couponArray addObject:model];
                    }
                    self.useCouponModel = [[Fcgo_CouponModel alloc]init];
                }
        }
        !block?:block();
    } failureBlock:^(NSString *description) {
        !block?:block();
    }];
}
/// 获取活动
- (void)getCanUseActivity:(NSString *)areaID block:(void(^)(void))block {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    NSMutableArray *jsonArray = [NSMutableArray array];
    
    NSString *jsonString = self.model.goods;
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSArray *array = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        [WSProgressHUD showImage:nil status:@"数据错误"];
        return;
    }
    for (int i = 0; i <self.model.listArray.count; i++) {
        Fcgo_OrderGoodsModel *obj = self.model.listArray[i];
        NSDictionary *dic = array[i];
        [jsonArray addObject:@{@"goodsId":obj.goodsId,
                               @"cate":obj.goodsCate,
                               @"brand":obj.goodsBrand,
                               @"texe":obj.texes,
                               @"price":@((obj.unitPrice.floatValue + obj.fright.floatValue + obj.mater.floatValue)),
                               @"goodsType":obj.goodsTypeBo.goodsType,
                               @"goodsNumber":dic[@"goodsNumber"],
                               }];
        
    }
    [dict setObjectWithNullValidate:[Fcgo_publicNetworkTools arrayToJson:jsonArray] forKey:@"goods"];
    [dict setObjectWithNullValidate:areaID forKey:@"area"];

    WEAKSELF(weakSelf);
    [Fcgo_NetworkManager postRequest:NSFormatHeardMeThodUrl(ServiceLocalTypeOne, ACTIVITY, @"getCanUseActivity") parametersContentCommon:dict successBlock:^(BOOL success, id responseObject, NSString *msg) {
        NSDictionary *dictionary = responseObject[@"data"];
        NSMutableDictionary *mutDict = dictionary.mutableCopy;
        NSNumber *loan = dictionary[@"loan"];
        if (loan) {
            [mutDict setObject:@(loan.floatValue / 100) forKey:@"loan"];
        }
        weakSelf.activityDictionary = mutDict.copy;
        !block?:block();
    } failureBlock:^(NSString *description) {
        !block?:block();
    }];
}
/// 提交订单
- (void)submitOrder {
    
    if (!self.selectedAdressModel) {
        [WSProgressHUD showImage:nil status:@"请选择收货地址"];
        return;
    }
    if (self.model.texe.intValue > 1) {
        if (!self.useRealNameModel) {
            [WSProgressHUD showImage:nil status:@"根据海关要求购买跨境、直邮商品需提供身份信息哦~"];
            return;
        }
        else if ([Fcgo_Tools isNullString:self.useRealNameModel.mchPicurlB]&&self.model.texe.intValue == 3) {
            [WSProgressHUD showImage:nil status:@"根据海关要求购买直邮商品需提供身份证照片哦~"];
            return;
        }
    }
    [WSProgressHUD showWithStatus:@"提交中..." maskType:WSProgressHUDMaskTypeClear];
    
    if (self.model.texe.intValue > 1){
        [self requestRealNameCanUse];
    }
    else{
        [self requestSumbitOrder];
    }
}

- (void)requestSumbitOrder
{
    WEAKSELF(weakSelf)
    NSMutableDictionary   *paremtes = [NSMutableDictionary dictionary];
    if (self.model.texe.intValue > 1) {
        [paremtes  setObjectWithNullValidate:self.useRealNameModel.f_realName_id forKey:@"declationId"];
    }
    [paremtes  setObjectWithNullValidate:self.selectedAdressModel.f_address_id forKey:@"addressId"];
    //    [paremtes  setObjectWithNullValidate:@"" forKey:@"activity"];
    
    [paremtes  setObjectWithNullValidate:@"IOS" forKey:@"resource"];
    if (self.useCouponModel.couponId) {
        [paremtes  setObjectWithNullValidate:self.useCouponModel.couponId forKey:@"coupon"];
    }
    
    NSData *jsonData = [self.model.goods dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSArray *array = [NSJSONSerialization JSONObjectWithData:jsonData
                                                     options:NSJSONReadingMutableContainers
                                                       error:&err];
    if(err) {
        [WSProgressHUD showImage:nil status:@"数据错误"];
        return;
    }
    NSMutableArray *_array = [NSMutableArray array];
    for (int i = 0; i <array.count; i++) {
        NSDictionary *dic = array[i];
        NSMutableDictionary *dic_m = [NSMutableDictionary dictionaryWithDictionary:dic];
        [dic_m  setObjectWithNullValidate:self.remarksTF.text forKey:@"message"];
        [_array addObject:dic_m];
    }
    
    NSError *error = nil;
    NSData *_jsonData = [NSJSONSerialization dataWithJSONObject:_array options:NSJSONWritingPrettyPrinted error:&error];
    NSString *goodsString = [[NSString alloc] initWithData:_jsonData encoding:NSUTF8StringEncoding];
    [paremtes  setObjectWithNullValidate:goodsString forKey:@"goods"];
    [WSProgressHUD showWithStatus:@"加载中..." maskType:(WSProgressHUDMaskTypeDefault)];
    [Fcgo_NetworkManager postRequest:NSFormatHeardMeThodUrl(ServiceLocalTypeOne, ORDERMETHOD, @"add") parametersContentCommon:paremtes successBlock:^(BOOL success, id responseObject, NSString *msg) {
        if (success) {
            NSDictionary *data = responseObject[@"data"];
            if (data.count<=0) {
                return ;
            }
            Fcgo_OrderPayModel *model = [Fcgo_OrderPayModel yy_modelWithDictionary:data];
            Fcgo_OrderPayVC *vc = [[Fcgo_OrderPayVC alloc]init];
            vc.hidesBottomBarWhenPushed = 1;
            vc.orderNo = model.orderNo;
            [weakSelf.navigationController pushViewController:vc animated:YES];
        }
    } failureBlock:^(NSString *description) {}];
}

/// 预下单接口 用于选择地址后调用
- (void)requestPrepar:(NSString *)areaId block:(void(^)(void))block
{
    if (!self.paremtes) {
        [WSProgressHUD showImage:nil status:@"数据错误,稍后再试"];
        return;
    }
    [self.paremtes setObjectWithNullValidate:self.selectedAdressModel.addressArea forKey:@"area"];
    [Fcgo_NetworkManager postRequest:NSFormatHeardMeThodUrl(ServiceLocalTypeOne, ORDERMETHOD, @"prepare") parametersContentCommon:self.paremtes successBlock:^(BOOL success, id responseObject, NSString *msg) {
        if (success) {
            NSNumber *errCode = responseObject[@"errorCode"];
            if (errCode.intValue == 0) {
                NSDictionary *data = responseObject[@"data"];
                if (!data) {
                    [WSProgressHUD showImage:nil status:@"没有数据"];
                    return;
                }
                Fcgo_OrderBuyModel *model = [Fcgo_OrderBuyModel yy_modelWithDictionary:data];
                self.model = model;
            }
            else {
                [WSProgressHUD showWithStatus:responseObject[@"errorMsg"]];
            }
        }
        !block?:block();
    } failureBlock:^(NSString *description) {
        !block?:block();
    }];
}

- (void)setTotalPrice:(CGFloat)totalPrice activity:(CGFloat)activity coupon:(CGFloat)coupon freight:(CGFloat)freight {
    if (activity > 0) {
        totalPrice -= activity;
    }
    if (coupon > 0) {
        totalPrice -= coupon;
    }
    if (freight > 0) {
//        totalPrice += freight;
    }
    if (totalPrice <= 0) {
        totalPrice = 0.01;
    }
    self.bottomView.totalString = [NSString stringWithFormat:@"¥ %.2f",totalPrice]; //@(totalPrice).stringValue;
//    self.bottomView.totalString =  [NSString stringWithFormat:@"¥ %.2f",round(totalPrice*100)/100];//   [NSString stringWithFormat:@"¥ %@",@(totalPrice)]; //@(totalPrice).stringValue;
}
/// 获取运费
- (float)getFreight {
    CGFloat freight = 0.0;
    for (Fcgo_OrderGoodsModel *obj in self.model.listArray) {
        freight += obj.fright.floatValue / 100;
    }
    return freight;
}
/// 获取包装费
- (float)getMater {
    CGFloat mater = 0.0;
    for (Fcgo_OrderGoodsModel *obj in self.model.listArray) {
        mater += obj.materYuan.floatValue;
    }
    return mater;
}

#pragma mark - delegate
#pragma mark table delegate datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        if (self.model.texe.intValue <=1) {
            return 1;
        }
        return 2;
    }
    if (section == 1) {
        return self.model.listArray.count;
    }
    if (section == 2) {
        return 3;
    }
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            if (!self.selectedAdressModel) {
                Fcgo_AddNewAdressTableViewCell*cell = [tableView dequeueReusableCellWithIdentifier:@"addNewAdressTableViewCell"];
                cell.isNoneSelected = YES;
                return cell;
            }
            Fcgo_OrderConfirmAdressTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"orderConfirmAdressTableCell"];
            cell.model = self.selectedAdressModel;
            return cell;
            
        }
        if (indexPath.row == 1) {
            if (!self.useRealNameModel) {
                Fcgo_OrderConfirmNoneRealNameTableCell*cell = [tableView dequeueReusableCellWithIdentifier:@"orderConfirmNoneRealNameTableCell"];
                return cell;
            }
            else {
                if (self.useRealNameModel.mchPicurlB && ![self.useRealNameModel.mchPicurlB isEqualToString:@""]) {
                    Fcgo_OrderConfirmRealNameTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"orderConfirmRealNameTableCell"];
                    cell.model = self.useRealNameModel;
                    return cell;
                }
                Fcgo_OrderConfirmNoneImageRealNameTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"orderConfirmNoneImageRealNameTableCell"];
                cell.model = self.useRealNameModel;
                return cell;
            }
        }
    }
    if (indexPath.section == 1) {
        Fcgo_OrderConfirmGoodsTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"orderConfirmGoodsTableCell"];
        Fcgo_OrderGoodsModel *model = self.model.listArray[indexPath.row];
        cell.model = model;
        return cell;
    }
    if (indexPath.section == 2) {
        if (indexPath.row == 0 || indexPath.row == 1) {
            Fcgo_OrderConfirmSection2Row1Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"orderConfirmSection2Row1Cell"];
            if(indexPath.row == 0) {
                cell.titleLabel.text = @"活动";
                cell.descriptionLabel.text = @"暂无优惠";
                cell.descriptionLabel.textColor = UIFontMiddleGrayColor;
                cell.isShowArrowImage = 0;
                if (self.activityDictionary) {
                    NSString *loan = @([self.activityDictionary[@"loan"] doubleValue]).stringValue;
                    if (loan.doubleValue > 0) {
                        cell.descriptionLabel.text = [NSString stringWithFormat:@"%@  -%.2f元", self.activityDictionary[@"name"], loan.doubleValue];
                        cell.descriptionLabel.textColor = UIFontRedColor;
                    }
                }
            }
            else {
                cell.titleLabel.text = @"优惠";
                if (!self.useCouponModel) {
                    cell.isShowArrowImage = 0;
                    cell.descriptionLabel.text = @"无可用的优惠券";
                    cell.descriptionLabel.textColor = UIFontMiddleGrayColor;
               }
                else {
                    cell.isShowArrowImage = 1;
                    cell.descriptionLabel.textColor = UIFontRedColor;
                    if (self.useCouponModel.couponId) {
                        cell.descriptionLabel.text  =[NSString stringWithFormat:@"-%@元",self.useCouponModel.couponLoanYuan];
                    }
                    else {
                        cell.descriptionLabel.text = @"有可用的优惠券";
                    }
                }
            }
            return cell;
        }
        Fcgo_OrderConfirmSection2Row2Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"orderConfirmSection2Row2Cell"];
        self.remarksTF = cell.textField;
        return cell;
    }
    Fcgo_OrderConfirmTotalTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"orderConfirmTotalTableCell"];
    cell.goodsCount.text = [NSString stringWithFormat:@"X%@",self.model.totalNum];
    cell.freight.text = [NSString stringWithFormat:@"¥ %.2f",[self getFreight]];
    //cell.mater.text = [NSString stringWithFormat:@"¥ %.2f",[self getMater]];
    double total;
    total = self.model.totalPrice.doubleValue / 100 - [self getFreight]; //- [self getMater];// * self.model.totalNum.doubleValue;
//    if (self.useCouponModel.couponId) {
//        total = [self.model.totalPrice doubleValue] / 100 - [self.useCouponModel.couponLoan doubleValue];
//    }
//    else {
//        total = [self.model.totalPrice doubleValue] / 100;
//        NSNumber *loan = self.activityDictionary[@"loan"];
//        if (loan && loan.floatValue > 0) {
//            total -= loan.floatValue;
//            if (total <= 0) {
//                total = 0.01;
//            }
//        }
//    }
    cell.total.text = [NSString stringWithFormat:@"¥ %.2f",total];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            if (!self.selectedAdressModel) {
                return 135;
            }
            return 96;
        }
        if (indexPath.row == 1) {
            
//            if (!self.receiveUseRealNameData) {
//                return  0;
//            }
            if (!self.useRealNameModel) {
                return kAutoWidth6(50)+5;
            }
            else {
                if (self.useRealNameModel.mchPicurlB && ![self.useRealNameModel.mchPicurlB isEqualToString:@""]) {
                    return kAutoWidth6(60)+93;
                }
                return 83;
            }
        }
    }
    if (indexPath.section == 1) {
        return 80+26;
    }
    if (indexPath.section == 2) {
        return kAutoWidth6(50);
    }
    //return 121;
    return 100;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    WEAKSELF(weakSelf)
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            Fcgo_OrderUseAdressVC *vc = [[Fcgo_OrderUseAdressVC alloc]init];
            vc.hidesBottomBarWhenPushed = 1;
            vc.model = self.model;
            vc.selectedBlock = ^(Fcgo_AddressModel *model){
                weakSelf.selectedAdressModel = model;
                dispatch_async(dispatch_get_main_queue(), ^{
                    [WSProgressHUD showWithStatus:@"加载中..." maskType:WSProgressHUDMaskTypeClear];
                });
                dispatch_group_t group = dispatch_group_create();
                dispatch_group_enter(group);
                [weakSelf requestPrepar:model.addressArea block:^{
                    dispatch_group_leave(group);
                }];
                dispatch_group_enter(group);
                [weakSelf getCanUseActivity:model.addressArea block:^{
                    dispatch_group_leave(group);
                }];
                /// 暂时优惠券针对所有，不用重复调用
                dispatch_group_enter(group);
                [weakSelf requestUseCoupon:^{
                    dispatch_group_leave(group);
                } areaId:model.addressArea];
                dispatch_group_notify(group, dispatch_get_main_queue(), ^{
                    [weakSelf.table reloadData];
                    NSNumber *activity = weakSelf.activityDictionary[@"loan"];
                    [weakSelf setTotalPrice:weakSelf.model.totalPrice.floatValue/100 activity:activity ? activity.floatValue : 0 coupon:weakSelf.useCouponModel.couponLoanYuan.floatValue freight:[weakSelf getFreight]];
                    
                    [WSProgressHUD dismiss];
                });
                [weakSelf.table reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
            };
            [self.navigationController pushViewController:vc animated:YES];
        }
        else {
            Fcgo_OrderUseRealNameVC *vc = [[Fcgo_OrderUseRealNameVC alloc]init];
            vc.hidesBottomBarWhenPushed = 1;
            vc.selectedBlock = ^(Fcgo_RealNameModel *model){
                weakSelf.useRealNameModel = model;
                [weakSelf.table reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:1 inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
            };
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
    else if (indexPath.section == 1) {
        Fcgo_OrderGoodsModel *model = self.model.listArray[indexPath.row];
        Fcgo_GoodsDetailVC *vc = [[Fcgo_GoodsDetailVC alloc]init];
        vc.goodsValue = [NSString stringWithFormat:@"%@",model.goodsId];
        vc.goodsType = @"normal";
        vc.hidesBottomBarWhenPushed = 1;
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (indexPath.section == 2) {
        if(indexPath.row == 1) {
            if (!self.useCouponModel) {
                [WSProgressHUD showImage:nil status:@"没有可用的优惠券选择"];
                return;
            }
            else {
                Fcgo_OrderUseCouponVC *vc = [[Fcgo_OrderUseCouponVC alloc]init];
                vc.hidesBottomBarWhenPushed = 1;
                vc.listArray = self.couponArray;
                vc.selectedBlock = ^(Fcgo_CouponModel *model) {
                    weakSelf.useCouponModel = model;
                    [weakSelf.table reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:1 inSection:2]] withRowAnimation:UITableViewRowAnimationFade];
//                    NSNumber *f_coupon_loan = model.f_coupon_loan;
//                    NSNumber *total = weakSelf.model.totalPrice;
//
//                    CGFloat f_total = 0.00;
//                    if (f_coupon_loan.floatValue > total.floatValue + weakSelf.freight) {
//                        f_total = 0.01;
//                    }
//                    else {
//                        f_total = total.floatValue + weakSelf.freight - f_coupon_loan.floatValue;
//                    }
//                    CGFloat loan = [weakSelf.activityDictionary[@"loan"] floatValue];
//                    if (loan > 0) {
//                        f_total -= loan;
//                    }
//                    weakSelf.bottomView.totalString = [NSString stringWithFormat:@"¥ %.2f",f_total];
                    NSNumber *activity = weakSelf.activityDictionary[@"loan"];
                    [weakSelf setTotalPrice:weakSelf.model.totalPrice.floatValue/100 activity:activity ? activity.floatValue : 0 coupon:weakSelf.useCouponModel.couponLoanYuan.floatValue freight:[weakSelf getFreight]];
                };
                [self.navigationController pushViewController:vc animated:YES];
            }
        }
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 1) {
        return 5;
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *footerView = [[UIView alloc]init];
    footerView.backgroundColor = UIBackGroundColor;
    return footerView;
}
#pragma mark - UI
- (void)setupUI {
    WEAKSELF(weakSelf)
    [self.navigationView setupBackBtnBlock:^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    }];
    [self.navigationView setupTitleLabelWithTitle:@"确认订单"];
    
    [self setupTableCell];
    [self.view addSubview:self.bottomView];
    
    UIView *topView = [[UIView alloc] init];
    topView.backgroundColor = UIFontMiddleGrayColor;
    topView.clipsToBounds = YES;
    [self.view insertSubview:topView belowSubview:self.navigationView];
    
    UIImageView *tipImgView = [[UIImageView alloc] init];
    tipImgView.image = [UIImage imageNamed:@"icon_cue"];
    [topView addSubview:tipImgView];
    
    UILabel *tipLabel = [[UILabel alloc] init];
    tipLabel.textColor = [UIColor whiteColor];
    tipLabel.font = [UIFont systemFontOfSize:12];
    tipLabel.numberOfLines = 0;
    [topView addSubview:tipLabel];
    
    NSString *tmpString = @"根据海关规定：购买跨境、直邮商品同一实名认证一天不得超过两单、单笔订单交易额不得超过2000元、年度交易额不得超过20000元；祝您购物愉快！";
    NSRange firstRange = [tmpString rangeOfString:@"2000元"];
    NSRange secondRange = [tmpString rangeOfString:@"20000元"];
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:tmpString];
    [attri addAttributes:@{NSForegroundColorAttributeName:UIStringColor(@"#ffc800")} range:firstRange];
    [attri addAttributes:@{NSForegroundColorAttributeName:UIStringColor(@"#ffc800")} range:secondRange];
    NSMutableParagraphStyle * paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle1 setLineSpacing:6];
    [attri addAttributes:@{NSParagraphStyleAttributeName:paragraphStyle1} range:NSMakeRange(0, tmpString.length)];
    tipLabel.attributedText = attri;
    
    [tipImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_offset(10);
        make.size.mas_equalTo(CGSizeMake(15, 15));
    }];
    [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(tipImgView.mas_right).offset(5);
        make.top.mas_equalTo(5);
        make.bottom.mas_equalTo(-5);
        make.right.mas_equalTo(-5);
    }];
    [self.table mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(topView.mas_bottom);
        make.bottom.mas_equalTo(_bottomView.mas_top);
    }];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.height.mas_equalTo(kAutoWidth6(50));
    }];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(kNavigationHeight);
        if (self.model.texe.integerValue == 1) {
            make.height.mas_equalTo(0);
        }
    }];
}

- (void)setupTableCell {
    [self.table registerNib:[UINib nibWithNibName:NSStringFromClass([Fcgo_OrderConfirmAdressTableCell class]) bundle:nil] forCellReuseIdentifier:@"orderConfirmAdressTableCell"];
    [self.table registerNib:[UINib nibWithNibName:NSStringFromClass([Fcgo_AddNewAdressTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"addNewAdressTableViewCell"];
    [self.table registerNib:[UINib nibWithNibName:NSStringFromClass([Fcgo_OrderConfirmNoneAdressTableCell class]) bundle:nil] forCellReuseIdentifier:@"orderConfirmNoneAdressTableCell"];
    [self.table registerNib:[UINib nibWithNibName:NSStringFromClass([Fcgo_OrderConfirmRealNameTableCell class]) bundle:nil] forCellReuseIdentifier:@"orderConfirmRealNameTableCell"];
    [self.table registerNib:[UINib nibWithNibName:NSStringFromClass([Fcgo_OrderConfirmNoneImageRealNameTableCell class]) bundle:nil] forCellReuseIdentifier:@"orderConfirmNoneImageRealNameTableCell"];
    
    [self.table registerNib:[UINib nibWithNibName:NSStringFromClass([Fcgo_OrderConfirmNoneRealNameTableCell class]) bundle:nil] forCellReuseIdentifier:@"orderConfirmNoneRealNameTableCell"];
    [self.table registerNib:[UINib nibWithNibName:NSStringFromClass([Fcgo_OrderConfirmGoodsTableCell class]) bundle:nil] forCellReuseIdentifier:@"orderConfirmGoodsTableCell"];
    [self.table registerNib:[UINib nibWithNibName:NSStringFromClass([Fcgo_OrderConfirmTotalTableCell class]) bundle:nil] forCellReuseIdentifier:@"orderConfirmTotalTableCell"];
    [self.table registerNib:[UINib nibWithNibName:NSStringFromClass([Fcgo_OrderConfirmSection2Row1Cell class]) bundle:nil] forCellReuseIdentifier:@"orderConfirmSection2Row1Cell"];
    [self.table registerNib:[UINib nibWithNibName:NSStringFromClass([Fcgo_OrderConfirmSection2Row2Cell class]) bundle:nil] forCellReuseIdentifier:@"orderConfirmSection2Row2Cell"];
    [self.view insertSubview:self.table belowSubview:self.navigationView];
}
#pragma mark Lazy method
- (UITableView *)table {
    if (!_table) {
        UITableView *table = [[UITableView alloc]initWithFrame:CGRectMake(0, kNavigationHeight + 40, kScreenWidth, KScreenHeight - kNavigationHeight - 40 -kAutoWidth6(50)) style:UITableViewStylePlain];
        table.delegate = self;
        table.dataSource = self;
        table.separatorStyle = 0;
        table.backgroundColor = UIFontWhiteColor;
        table.showsVerticalScrollIndicator = NO;
        _table = table;
        if (@available(iOS 11.0, *)) {
            table.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return _table;
}

- (Fcgo_OrderConfirmBottomView *)bottomView {
    WEAKSELF(weakSelf)
    if (!_bottomView) {
        _bottomView = [[Fcgo_OrderConfirmBottomView alloc]initWithFrame:CGRectMake(0, KScreenHeight, kScreenWidth, kAutoWidth6(50))];
        _bottomView.backgroundColor = UIBackGroundColor;
        _bottomView.submitBlock = ^{
            [weakSelf submitOrder];
        };
    }
    return _bottomView;
}

- (NSMutableArray *)couponArray {
    if (!_couponArray) {
        _couponArray = [[NSMutableArray alloc]init];
    }
    return _couponArray;
}
@end
