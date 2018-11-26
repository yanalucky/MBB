//
//  Fcgo_GoodsDetailVC.m
//  Fcgo
//
//  Created by huafanxiao on 2017/6/1.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_GoodsDetailVC.h"
#import "Fcgo_GoodsDetailNavView.h"
#import "Fcgo_GoodsDetailBottomView.h"

#import "Fcgo_GoodsDetailSection0Cell0.h"
#import "Fcgo_GoodsDetailSection4Cell0.h"
#import "Fcgo_GoodsDetailSection1Cell.h"
#import "Fcgo_GoodsDetailSection2Cell0.h"
#import "Fcgo_GoodsDetailSection3Cell0.h"

#import "Fcgo_BrandModel.h"
#import "Fcgo_GoodsInfoModel.h"
#import "Fcgo_AttrModel.h"
#import "Fcgo_GoodsAttrModel.h"
#import "Fcgo_BestSKUModel.h"
#import "Fcgo_ActivityModel.h"


#import "Fcgo_MsgVC.h"
#import "Fcgo_CollectVC.h"
#import "Fcgo_GoodsListVC.h"
#import "Fcgo_ContactServiceVC.h"

#import "Fcgo_GoodsSKUVC.h"

#import "Fcgo_OrderBuyModel.h"
#import "Fcgo_OrderConfirmVC.h"

#import "Fcgo_FromHomeWebVC.h"
#import "Fcgo_IntegralModel.h"
#import "Fcgo_AddressView.h"
#import "Fcgo_AddNewAdressVC.h"
#import "Fcgo_CartOfAddVC.h"

#import "Fcgo_AddressModel.h"

@interface Fcgo_GoodsDetailVC ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,SDCycleScrollViewDelegate,LrdOutputViewDelegate,UIWebViewDelegate>

//@property (nonatomic,strong) Fcgo_ExterAddressPickerView *pickerView;

@property (nonatomic,strong) Fcgo_AddressView *addressView;
@property (nonatomic,strong) UITableView       *table;
@property (nonatomic,strong) Fcgo_GoodsDetailNavView *navView;
@property (nonatomic,strong) FDDemoScrollView  *horizontalScrollView;//横向
@property (nonatomic,strong) UIScrollView      *verticalScrollView; //竖向

@property (nonatomic,strong) UIWebView         *horizontalWebView;
@property (nonatomic,strong) UIWebView         *verticalWebView;

@property (nonatomic,strong) SDCycleScrollView *bgCycleView;
@property (nonatomic,strong) UILabel           *goodsStatus;
@property (nonatomic,strong) SDCycleScrollView *tableCycleView;

@property (nonatomic,strong) NSArray           *picurlsArray;
@property (nonatomic,strong) UILabel           *advicePrice; //建议价

@property (nonatomic,strong) Fcgo_GoodsDetailBottomView *bottomView;

@property (nonatomic,strong) Fcgo_BrandModel     *brandModel;
@property (nonatomic,strong) Fcgo_GoodsInfoModel *infoModel;
@property (nonatomic,strong) Fcgo_BestSKUModel   *bestSKUModel;

@property (nonatomic,strong) Fcgo_AddressModel   *selectedAddressModel;
@property (nonatomic,strong) NSMutableArray      *addressListArray;



@property (nonatomic,strong) NSMutableArray      *activityArray;
@property (nonatomic,strong) NSMutableArray      *attrArray;
@property (nonatomic,strong) NSMutableArray      *save_attrArray;

@property (nonatomic,copy)   NSString            *msg;
@property (nonatomic,assign) NSInteger           cartCount;
@property (nonatomic,assign) NSInteger           addCount;
@property (nonatomic,assign) BOOL   isSKU;//判断sku是否有数据

@property (nonatomic,strong) Fcgo_GoodsSKUVC      *goodsSKUVC ;

@property (nonatomic,strong) UILabel *timeLabel,*timeStatusLabel;

@property (nonatomic,strong) Fcgo_IntegralModel *integralModel;



//chenyan
@property (nonatomic,assign)  BOOL isLowerPrice;
@end


@implementation Fcgo_GoodsDetailVC

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self postRequestGoodsCarNum];
    [self setAddressView];
}

- (void)reloadRequest
{
    if (![Fcgo_Tools isNetworkConnected]) {
        [WSProgressHUD showImage:nil status:@"亲,没联网啊"];
        [self showUIData:NO];
        return;
    }
    [self postRequestGoodsBasicMsg];
    [self postRequestGoodsCarNum];
}

-(void)postRequestIsCollect{
    
    WEAKSELF(weakSelf)
    NSMutableDictionary   *paremtes = [NSMutableDictionary dictionary];
    [paremtes  setObjectWithNullValidate:self.infoModel.goods_id forKey:@"goodsId"];
    [Fcgo_NetworkManager postRequest:NSFormatHeardMeThodUrl(ServiceLocalTypeOne, @"mch/favorite/", @"exist") parametersContentCommon:paremtes successBlock:^(BOOL success, id responseObject, NSString *msg) {
        if (success) {
            [weakSelf showUIData:1];
            weakSelf.bottomView.isFavourite = [[responseObject objectForKey:@"data"] intValue];
        }
    } failureBlock:^(NSString *description) {
        
    }];
    
}

-(void)postRequestGoodsCarNum{
    
    WEAKSELF(weakSelf)
    [Fcgo_NetworkManager postRequest:NSFormatHeardMeThodUrl(ServiceLocalTypeOne, SHOPCARMETHOD, @"shopcarNum") parametersContentCommon:nil
                        successBlock:^(BOOL success, id responseObject, NSString *msg) {
                            
                            if (success) {
                                [weakSelf showUIData:1];
                                NSNumber *shopcarnum = responseObject[@"data"];
                                weakSelf.cartCount = [shopcarnum integerValue];
                                [weakSelf.table reloadData];
                            }
                        } failureBlock:^(NSString *description) {
                            
                        }];
}
- (void)postRequestGoodsBasicMsg
{
    WEAKSELF(weakSelf);
    [self.activityArray removeAllObjects];
    NSMutableDictionary   *paremtes = [NSMutableDictionary dictionary];
    [paremtes  setObjectWithNullValidate:self.goodsValue forKey:@"goodsValue"];
    [paremtes  setObjectWithNullValidate:self.goodsType forKey:@"goodsType"];
    [Fcgo_NetworkManager postRequest:NSFormatHeardMeThodUrl(ServiceLocalTypeOne,GOODMETHOD, @"goodsDetail") parametersContentCommon:paremtes successBlock:^(BOOL success, id responseObject, NSString *msg) {
        [WSProgressHUD dismiss];
        if (success) {
           [weakSelf showUIData:1];
            NSNumber *status = responseObject[@"data"][@"status"];
            if (status.intValue == 2){
                weakSelf.bottomView.isIntegral = 1;
                self.navigationView.alphaImageView.image = [UIImage imageNamed:@""];
                self.navigationView.isShowWhiteTitle = 0;
                self.navView.mainColor = UIFontMainGrayColor;
                self.navigationView.isShowLine = 1;
                self.bottomView.imageString = @"";
                self.navigationView.bgAlpha = 0.95;
            }
            if (responseObject[@"data"][@"end"]) {
                weakSelf.integralModel = [[Fcgo_IntegralModel alloc]init];
                weakSelf.integralModel.end = responseObject[@"data"][@"end"];
                weakSelf.integralModel.start = responseObject[@"data"][@"start"];
                weakSelf.integralModel.now = responseObject[@"data"][@"now"];
                weakSelf.integralModel.status = responseObject[@"data"][@"status"];
                
                NSTimeInterval time = [[NSDate date] timeIntervalSince1970];
                long long dTime = [[NSNumber numberWithDouble:time] longLongValue];
                long long nowTime = weakSelf.integralModel.now.longLongValue / 1000.0;
                weakSelf.integralModel.time_interval = nowTime - dTime;
                
                if (weakSelf.integralModel.status.intValue == 1) {
                    weakSelf.bottomView.isIntegral = 1;
                }else  if (weakSelf.integralModel.status.intValue == 0){
                    weakSelf.bottomView.isIntegral = 0;
                }
                
            }
            NSString *f_html_content = (NSString *)responseObject[@"data"][@"goodsDetail"][@"htmlContent"];
            NSString * head = @"<head><style>p{text-align:center;}img{width:100%;}</style></head>";
            f_html_content = [NSString stringWithFormat:@"<html>%@<body>%@</body></html>",head,f_html_content];
            
            [weakSelf.horizontalWebView loadHTMLString:f_html_content baseURL:nil];
            [weakSelf.verticalWebView loadHTMLString:f_html_content baseURL:nil];
            
            NSArray *picurlsArray = (NSArray *)responseObject[@"data"][@"urls"];
            weakSelf.picurlsArray = picurlsArray;
            weakSelf.bgCycleView.imageURLStringsGroup = picurlsArray;
            
            // weakSelf.bottomView.isFavourite = [(NSNumber *)responseObject[@"data"][@"isFavourite"] intValue];
            NSMutableArray *table_picurlsArray = [NSMutableArray arrayWithCapacity:picurlsArray.count];
            
            for (int i = 0; i < picurlsArray.count; i++) {
                [table_picurlsArray addObject:@""];
            }
            weakSelf.tableCycleView.imageURLStringsGroup = table_picurlsArray;
            weakSelf.advicePrice.text = [NSString stringWithFormat:@"¥ %@",(NSString *)responseObject[@"data"][@"goodsInfo"][@"jpriceYUAN"]];
            Fcgo_BrandModel *brandModel = [Fcgo_BrandModel shareWithNSDictionary:(NSDictionary *)responseObject[@"data"][@"goodsBrand"]];
            brandModel.brandSaleNum = responseObject[@"data"][@"brandSaleNum"];
            weakSelf.brandModel = brandModel;
            
            Fcgo_GoodsInfoModel *infoModel = [Fcgo_GoodsInfoModel yy_modelWithDictionary:responseObject[@"data"][@"goodsInfo"]];
            infoModel.minprice = responseObject[@"data"][@"minprice"];
            infoModel.minpriceYUAN = responseObject[@"data"][@"minpriceYUAN"];
            infoModel.freight_s = @"--";
            infoModel.stock_s   = @"--";
            infoModel.picUrl = self.picurlsArray;
            
            weakSelf.infoModel = infoModel;
            weakSelf.goodsSKUVC.infoModel = self.infoModel;
            
            [weakSelf.activityArray removeAllObjects];
            NSArray *activityArray = responseObject[@"data"][@"activity"];
            if (activityArray.count>0) {
                for (int i = 0; i < activityArray.count; i ++) {
                    NSDictionary *activityDict = activityArray[i];
                    Fcgo_ActivityModel *model = [Fcgo_ActivityModel yy_modelWithDictionary:activityDict];
                    [weakSelf.activityArray addObject:model];
                }
            }
            
            //用于验证整点抢的商品的id,如整点抢商品进入，在收藏接口我们需要传入goodsid,故只能从goods_detail返回数据获得，故在此调用收藏接口
            [self postRequestIsCollect];
            [weakSelf.table reloadData];
            
        }else{
            [weakSelf showUIData:0];
        }
        
    } failureBlock:^(NSString *description) {
        [weakSelf showUIData:0];
    }];
}

- (void)setCartCount:(NSInteger)cartCount
{
    _cartCount = cartCount;
    self.bottomView.cartCount = cartCount;
}


- (void)postRequestGoodsSKUMsg
{
    WEAKSELF(weakSelf);
   NSMutableDictionary   *paremtes = [NSMutableDictionary dictionary];
    NSMutableString *attrs = [NSMutableString string];
    if (self.save_attrArray.count<=0) {
        [attrs setString:@""];
    }
    else{
        for (int i = 0; i < self.save_attrArray.count; i ++) {
            NSDictionary *dict = self.save_attrArray[i];
            NSString *attr_name = dict[@"attr_name"];
            if (i == 0) {
                [attrs setString:attr_name];
            }
            else{
                [attrs appendString:[NSString stringWithFormat:@",%@",attr_name]];
            }
        }
    }
    [paremtes setObjectWithNullValidate:attrs forKey:@"chooseProperty"];
    NSMutableDictionary   *tempDic = [NSMutableDictionary dictionary];
    
    if (self.infoModel.texes.intValue == 2||self.infoModel.texes.intValue == 3) {
        [tempDic  setObjectWithNullValidate:@"1" forKey:@"goodsNumber"];
    }
    else{
        [tempDic  setObjectWithNullValidate:[NSString stringWithFormat:@"%ld",(long)self.addCount] forKey:@"goodsNumber"];
    }
    
    
    [tempDic  setObjectWithNullValidate:self.goodsType forKey:@"goodsType"];
    [tempDic  setObjectWithNullValidate:self.goodsValue forKey:@"goodsValue"];
    
    [paremtes setObject:[Fcgo_publicNetworkTools dictionaryToJson:tempDic] forKey:@"goods"];
    if (!self.selectedAddressModel) {
        [WSProgressHUD showImage:nil status:@"获取地址错误"];
        return;
    }
    [paremtes  setObjectWithNullValidate:self.selectedAddressModel.addressArea forKey:@"area"];
    [paremtes setObjectWithNullValidate:[NSNumber numberWithBool:self.isLowerPrice] forKey:@"lowest"];
    [Fcgo_NetworkManager postRequest:NSFormatHeardMeThodUrl(ServiceLocalTypeOne,GOODMETHOD, @"skus") parametersContentCommon:paremtes successBlock:^(BOOL success, id responseObject, NSString *msg) {
        [WSProgressHUD dismiss];
        if (success) {
            [weakSelf.attrArray removeAllObjects];
            //[weakSelf showUIData:1];
            NSDictionary *dataDict= responseObject[@"data"];
            
            NSArray *skusArray_t = dataDict[@"sku"];
            if (skusArray_t.count<=0) {
                self.isSKU = NO;
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    NSString *areaId = self.selectedAddressModel.addressArea;
                    NSString *areaId_default = [Fcgo_UserTools shared].userAddressDict[@"area"][@"areaId"];
                    if ([areaId isEqualToString:areaId_default]) {
                        weakSelf.bottomView.isDefaultAddress = 1;
                        [Fcgo_AlertAnimationView showWithTitle:@"提示" text:@"亲,门店所在地区暂不供货哦" cancelTitle:@"返回" confirmTitle:@"查看其它地区" cancelBlock:^{
                            [weakSelf.navigationController popViewControllerAnimated:YES];
                        } block:^{
                            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                //                                [weakSelf.pickerView show];
                                [weakSelf.addressView show];
                                
                            });
                            
                        }];
                    }
                    else{
                        [WSProgressHUD showImage:nil status:@"亲,所选地区暂不供货哦"];
                        weakSelf.bottomView.isDefaultAddress = 0;
                    }
                });
            }
            if (dataDict.count>0) {
                if ([[dataDict objectForKey:@"ret"] isKindOfClass:[NSDictionary class]]) {
                    NSDictionary *bestSkuDict = [dataDict objectForKey:@"ret"][@"data"][@"bestSku"];
                    Fcgo_BestSKUModel *bestSKUModel = [Fcgo_BestSKUModel yy_modelWithDictionary:bestSkuDict];
                    
                    weakSelf.bestSKUModel = bestSKUModel;
                    
                    if(![self.goodsType isEqualToString:@"normal"])
                    {
                        if ([self.goodsType isEqualToString:@"integral"]) {
                            if (self.integralModel) {
                                if (self.integralModel.status.intValue == 2) {
                                    weakSelf.goodsSKUVC.goodsType = @"normal";
                                }else
                                {
                                    weakSelf.goodsSKUVC.goodsType = @"";
                                }
                            }
                            else{
                                weakSelf.goodsSKUVC.goodsType = @"normal";
                            }
                        }
                        else{
                            weakSelf.goodsSKUVC.goodsType = self.goodsType;
                        }
                        
                    }else{
                        weakSelf.goodsSKUVC.goodsType = @"normal";
                    }
                    
                    if ([weakSelf.goodsSKUVC.goodsType isEqualToString:@"normal"]) {
                        if (bestSKUModel.remain.intValue / bestSKUModel.time.intValue <= 0) {
                            self.goodsStatus.hidden = 0;
                            weakSelf.bottomView.isSoldOut = 1;
                        }else{
                            weakSelf.goodsStatus.hidden = 1;
                            weakSelf.bottomView.isSoldOut = 0;
                        }
                    }
                    else{
                        if (bestSKUModel.remain.intValue <= 0) {
                            self.goodsStatus.hidden = 0;
                            weakSelf.bottomView.isSoldOut = 1;
                        }else{
                            weakSelf.goodsStatus.hidden = 1;
                            weakSelf.bottomView.isSoldOut = 0;
                        }
                    }
                    
                    
                    weakSelf.goodsSKUVC.bestSKUModel = bestSKUModel;
                }
                else{
                    weakSelf.goodsStatus.hidden = 1;
                    weakSelf.bestSKUModel = nil;
                }
                
                NSArray *skuArray = dataDict[@"sku"];
                if(skuArray.count<=0)
                {
                    self.isSKU = NO;
                    
                }else{
                    self.isSKU = YES;
                    for (int i = 0; i < skuArray.count; i ++) {
                        NSDictionary *skuDict = skuArray[i];
                        Fcgo_GoodsAttrModel *model = [Fcgo_GoodsAttrModel  shareWithNSDictionary:skuDict];
                        for (int i = 0;  i < model.dataArray.count; i ++) {
                            Fcgo_AttrModel *attrModel = model.dataArray[i];
                            if (model.dataArray.count == 1) {
                                attrModel.clas = @"item selected";
                            }
                            if ([attrModel.clas isEqualToString:@"item selected"]) {
                                BOOL isSame = NO;
                                for (int j = 0; j < self.save_attrArray.count; j ++) {
                                    NSDictionary *addDict = self.save_attrArray[j];
                                    NSString *properties_name = addDict[@"properties_name"];
                                    NSString *attr = addDict[@"attr_name"];
                                    if ([model.f_properties_name isEqualToString:properties_name] && [attrModel.f_value_name isEqualToString:attr]) {
                                        isSame = YES;
                                    }
                                }
                                if (!isSame) {
                                    NSDictionary *addDict1 = @{@"properties_name":model.f_properties_name,@"attr_name":attrModel.f_value_name};
                                    [self.save_attrArray addObject:addDict1];
                                }
                            }
                        }
                        [weakSelf.attrArray addObject:model];
                    }
                }                
            }
            weakSelf.bottomView.isSKU = self.isSKU;
            [weakSelf.table reloadData];
            weakSelf.goodsSKUVC.attrArray = weakSelf.attrArray;
            weakSelf.goodsSKUVC.saveAttrArray = weakSelf.save_attrArray;
            
            //[WSProgressHUD dismiss];
        }else{
            //[weakSelf showUIData:0];
        }
        
    } failureBlock:^(NSString *description) {
        //[weakSelf showUIData:0];
    }];
}

- (void)showUIData:(BOOL)isShow
{
    [self showNoControl:!isShow titleString:@"网络错误,点击重新加载" imageString:@"ico_no-wifi"];
    self.verticalScrollView.hidden = !isShow;
    self.horizontalScrollView.hidden = !isShow;
    self.bottomView.hidden = !isShow;
}


#pragma mark 地址选择

-(void)setAddressView{
    WEAKSELF(weakSelf)
    _addressView = [[Fcgo_AddressView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, KScreenHeight) title:@"配送至" isCanAddAddress:YES successBlock:^(Fcgo_AddressModel *model) {
        [WSProgressHUD showImage:nil status:@"加载中"];
        weakSelf.selectedAddressModel = model;
        [weakSelf postRequestGoodsSKUMsg];
        
    } cancelBlock:^{
        
    }];
    _addressView.addNewAddressBlock = ^{
        [weakSelf.addressView removeFromSuperview];
        [weakSelf setAddressView];
        Fcgo_AddNewAdressVC *vc = [[Fcgo_AddNewAdressVC alloc]init];
        vc.hidesBottomBarWhenPushed = 1;
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
   [self.view addSubview:_addressView];
    _addressView.hidden = YES;
    [_addressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(self.view);
        make.center.equalTo(self.view);
    }];
    
    [self loadRequestAddress];
}
-(void)loadRequestAddress
{
    WEAKSELF(weakSelf)
    NSMutableDictionary  *muatble = [NSMutableDictionary dictionary];
    [Fcgo_NetworkManager postRequest:NSFormatHeardMeThodUrl(ServiceLocalTypeOne,ADDRESSMETHOD, @"storeAddressList") parametersContentCommon:muatble successBlock:^(BOOL success, id responseObject, NSString *msg) {
        if (success) {
            [weakSelf.addressListArray removeAllObjects];
            weakSelf.selectedAddressModel = nil;
            NSArray  *listArray = responseObject[@"data"];
            if (!listArray || listArray.count<=0) {
                [WSProgressHUD showImage:nil status:@"获取地址错误"];
                return ;
            }
            
            for (int i = 0; i < listArray.count; i++) {
                NSMutableDictionary *dic = listArray[i];
                Fcgo_AddressModel *model = [Fcgo_AddressModel yy_modelWithDictionary:dic];
                [weakSelf.addressListArray addObject:model];
                if ([[dic objectForKey:@"deFault"] intValue] == 1) {
                    weakSelf.selectedAddressModel = model;
                }
            }
            if (!weakSelf.selectedAddressModel) {
               weakSelf.selectedAddressModel = weakSelf.addressListArray[0];
            }
            
            
            weakSelf.addressView.dataArray = weakSelf.addressListArray;
            [weakSelf postRequestGoodsSKUMsg];
        }
        
    } failureBlock:^(NSString *description) {
        
    }];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(refreshLessTime) name:@"countdown" object:nil];
    
    self.addCount = 1;
    [self setupUI];
    
    [self reloadRequest];
    _isLowerPrice = NO;
}

#pragma mark table delegate datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }
    else if (section == 1) {
        return 2;
    }
    else if (section == 2) {
        return self.activityArray.count;
    }
    else if (section == 3) {
        if (self.msg && self.msg.length>0) {
            return 1;
        }
        return 0;
    }
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        Fcgo_GoodsDetailSection0Cell0 *cell = [tableView dequeueReusableCellWithIdentifier:@"goodsDetailSection0Cell0"];
        if (self.infoModel) {
            cell.infoModel = self.infoModel;
        }
        
        if(![self.goodsType isEqualToString:@"normal"])
        {
            if ([self.goodsType isEqualToString:@"integral"]) {
                if (self.integralModel) {
                    if (self.integralModel.status.intValue == 2) {
                        cell.goodsType = @"normal";
                    }else
                    {
                        cell.goodsType = @"";
                    }
                }
                else{
                    cell.goodsType = @"normal";
                }
            }
            else{
                cell.goodsType = @"";
            }
        }else{
            cell.goodsType = @"normal";
        }
        if (self.bestSKUModel) {
            cell.bestSKUModel = self.bestSKUModel;
        }
        return cell;
    }
    else if (indexPath.section == 1) {
        NSString *selectString;
        NSString *addressString;
        if (!self.isSKU) {
            NSString *areaId = self.selectedAddressModel.addressArea;
            NSString *areaId_default = [Fcgo_UserTools shared].userAddressDict[@"area"][@"areaId"];
            if ([areaId isEqualToString:areaId_default])
            {
                selectString  = @"门店所在地区暂不供货";
                addressString = @"请选择其它地区";
                
            }else{
                selectString  = @"所选地区暂不供货";
                if (self.selectedAddressModel) {
                    addressString = self.selectedAddressModel.addressDetail;
                }
                else{
                    addressString = @"";
                }
                
                
            }
        }else{
            if (self.save_attrArray.count<=0) {
                selectString  = @"请选择属性";
            }else
            {
                NSMutableString *attrs = [NSMutableString string];
                if (self.save_attrArray.count<=0) {
                    [attrs setString:@""];
                }
                else{
                    for (int i = 0; i < self.save_attrArray.count; i ++) {
                        NSDictionary *dict = self.save_attrArray[i];
                        NSString *attr_name = dict[@"attr_name"];
                        if (i == 0) {
                            [attrs setString:attr_name];
                        }
                        else{
                            [attrs appendString:[NSString stringWithFormat:@" %@",attr_name]];
                        }
                    }
                }
                selectString  = attrs;
            }
            if (self.selectedAddressModel) {
                addressString = self.selectedAddressModel.addressDetail;
            }
            else{
                addressString = @"";
            }
            
        }
        NSArray *titleArray = @[@[@"已选:",selectString],
                                @[@"送至:",addressString]];
        if (indexPath.row == 0) {
            Fcgo_GoodsDetailSection1Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"goodsDetailSection1Cell"];
            cell.titleLabel.text = titleArray[indexPath.row][0];
            cell.choseLabel.text = titleArray[indexPath.row][1];
            return cell;
        }
        Fcgo_GoodsDetailSection3Cell0 *cell = [tableView dequeueReusableCellWithIdentifier:@"goodsDetailSection3Cell0"];
        cell.titleLabel.text = titleArray[indexPath.row][0];
        cell.choseLabel.text = titleArray[indexPath.row][1];
        cell.choseLabel.textColor = UIFontMainGrayColor;
        return cell;
    }
    else if (indexPath.section == 2) {
        Fcgo_GoodsDetailSection2Cell0 *cell = [tableView dequeueReusableCellWithIdentifier:@"goodsDetailSection2Cell0"];
        if (self.activityArray.count>0) {
            Fcgo_ActivityModel *model = self.activityArray[indexPath.row];
            cell.titleLabel.text = @"活动:";
            NSArray *actArray = [model.name componentsSeparatedByString:@"："];
            cell.subitLabel.text = actArray[0];
            cell.choseLabel.text = actArray[1];
            CGFloat width =  [cell.subitLabel.text boundingRectWithSize:CGSizeMake(100, 100) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingTruncatesLastVisibleLine attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:10]} context:nil].size.width;
            [cell.subitLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(cell.titleLabel.mas_right).mas_offset(5);
                make.centerY.mas_equalTo(cell.titleLabel.mas_centerY);
                make.width.mas_offset(width+10);
                make.height.mas_equalTo(cell.titleLabel.mas_height);
            }];
            [cell.choseLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(cell.subitLabel.mas_centerY);
                make.width.mas_offset(kAutoWidth6(200));
                make.left.mas_equalTo(cell.subitLabel.mas_right).mas_offset(5);
            }];
        }
        return cell;
    }
    else if (indexPath.section == 3) {
        NSArray *titleArray = @[@"消息:",@"满五件即可成团抢购"];
        Fcgo_GoodsDetailSection3Cell0 *cell = [tableView dequeueReusableCellWithIdentifier:@"goodsDetailSection3Cell0"];
        cell.titleLabel.text = titleArray[0];
        cell.choseLabel.text = titleArray[1];
        cell.choseLabel.textColor = UIFontRedColor;
        
        return cell;
    }
    
    Fcgo_GoodsDetailSection4Cell0 *cell = [tableView dequeueReusableCellWithIdentifier:@"goodsDetailSection4Cell0"];
    if (self.brandModel) {
        cell.brandModel = self.brandModel;
    }
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (self.infoModel) {
            CGFloat height = [self.infoModel.goodsName boundingRectWithSize:CGSizeMake(kScreenWidth - 30, 1000) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:UIFontSize(17)} context:nil].size.height;
            if (height< 30) {
                return 105;
            }
            return 105 + 21;
        }
        return 0;
    }
    else if (indexPath.section == 1) {
        return kAutoWidth6(50);
    }
    else if (indexPath.section == 2 || indexPath.section == 3) {
        return kAutoWidth6(50);;
    }
    return 65;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //WEAKSELF(weakSelf)
    NSInteger section = indexPath.section;
    NSInteger row     = indexPath.row;
    if (section == 1 ) {
        if (row == 0) {
            //已选
            [self.view addSubview:self.goodsSKUVC.view];
        }
        else if(row == 1){
            
            [self.addressView show];
        }
    }
    else if(section == 2){
        //活动
        if(self.activityArray.count>0)
        {
            Fcgo_ActivityModel *model = self.activityArray[indexPath.row];
            if ([model.href containsString:@"app_across"])
            {
                [Fcgo_App_acrossTools app_acrossWithJsonString:model.href webView:nil parentVC:self];
                
            }
            else if ([model.href containsString:@"html"])
            {
                Fcgo_FromHomeWebVC *fromHomeWebVC = [[Fcgo_FromHomeWebVC alloc]init];
                fromHomeWebVC.hidesBottomBarWhenPushed = 1;
                fromHomeWebVC.urlString = [NSString stringWithFormat:@"%@%@?merId=%@&token=%@",NSServiceShortUrl,model.href,MerId,Token];
                [self.navigationController pushViewController:fromHomeWebVC animated:YES];
            }
        }
    }
    else if(section == 3){
        //消息
        [Fcgo_TextAnimationView showWithTitle:@"消息" textString:@"满五件即可成团抢购"];
    }
    else if(section == 4){
        //品牌
        Fcgo_GoodsListVC *vc = [[Fcgo_GoodsListVC alloc]init];
        vc.hidesBottomBarWhenPushed = 1;
        if (self.brandModel) {
            vc.brandIds = [NSString stringWithFormat:@"%@",self.brandModel.brand_id];
            vc.key = @"brand";
        }
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIImageView *bgImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenWidth*148/1242)];
    bgImageView.image = [UIImage imageWithName:@"integral_goodsdetail" ofType:@"png"];
    
    UILabel *integralLabel = [[UILabel alloc]init];
    integralLabel.textColor = UIFontWhiteColor;
    integralLabel.font = UIBoldFontSize(18);
    integralLabel.textAlignment = NSTextAlignmentLeft;
    integralLabel.text = @"整点抢";
    [bgImageView addSubview:integralLabel];
    
    [integralLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(bgImageView.mas_centerY);
        make.left.mas_offset(15);
    }];
    
    UILabel *timeLabel = [[UILabel alloc]init];
    timeLabel.textColor = UIFontWhiteColor;
    timeLabel.font = UIBoldFontSize(18);
    timeLabel.textAlignment = NSTextAlignmentRight;
    [bgImageView addSubview:timeLabel];
    [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(bgImageView.mas_centerY);
        make.right.mas_offset(-15);
    }];
    self.timeLabel = timeLabel;
    
    
    UILabel *timeStatusLabel = [[UILabel alloc]init];
    timeStatusLabel.textColor = UIFontWhiteColor;
    timeStatusLabel.font = [UIFont systemFontOfSize:13];
    timeStatusLabel.textAlignment = NSTextAlignmentRight;
    [bgImageView addSubview:timeStatusLabel];
    [timeStatusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(bgImageView.mas_centerY);
        make.right.mas_offset(-100);
    }];
    self.timeStatusLabel = timeStatusLabel;
    
    return bgImageView;
}

- (void)refreshLessTime
{
    //已过期
    if (!self.integralModel) {
        return;
    }
    WEAKSELF(weakSelf);
    NSDate* serverDate = [NSDate dateWithTimeIntervalSinceNow:self.integralModel.time_interval];
    NSDate *endDate = [NSDate dateWithTimeIntervalSince1970:self.integralModel.end.doubleValue/1000];
    NSDate *startDate = [NSDate dateWithTimeIntervalSince1970:self.integralModel.start.doubleValue/1000];
    
    NSString *status;
    NSTimeInterval timeInterval = 0.0;
    if (self.integralModel.status.intValue == 1) {
        status = @"距离结束还剩";
        timeInterval = [endDate timeIntervalSinceDate:serverDate];
    }
    if (self.integralModel.status.intValue == 0)
    {
        status = @"距离开始还剩";
        timeInterval = [startDate timeIntervalSinceDate:serverDate];
    }
    
    long long timeout = timeInterval;
    if(timeout<=0){ //倒计时结束，关闭
        dispatch_async(dispatch_get_main_queue(), ^{
            //倒计时完成。用block回调刷新表格
            weakSelf.integralModel = nil;
            [weakSelf postRequestGoodsBasicMsg];
        });
    }else{
        int days = (int)(timeout/(3600*24));
        int hours = (int)((timeout-days*24*3600)/3600);
        int minutes = (int)(timeout-days*24*3600-hours*3600)/60;
        int seconds = (int)timeout-days*24*3600-hours*3600-minutes*60;
        dispatch_async(dispatch_get_main_queue(), ^{
            NSString *hour = nil;
            NSString *mintue = nil;
            NSString *second = nil;
            int hour_s = hours+ (days*24);
            if (hour_s<10) {
                hour = [NSString stringWithFormat:@"0%d",hour_s];
            }else{
                hour = [NSString stringWithFormat:@"%d",hour_s];
            }
            if (minutes<10) {
                mintue = [NSString stringWithFormat:@"0%d",minutes];
            }else{
                mintue = [NSString stringWithFormat:@"%d",minutes];
            }
            if (seconds<10) {
                second = [NSString stringWithFormat:@"0%d",seconds];
            }else{
                second = [NSString stringWithFormat:@"%d",seconds];
            }
            weakSelf.timeStatusLabel.text = status;
            weakSelf.timeLabel.text = [NSString stringWithFormat:@"%@:%@:%@",hour,mintue,second];
        });
        timeout--;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0 && self.integralModel) {
        return kScreenWidth*148/1242;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 1) {
        return 0;
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footerView = [[UIView alloc]init];
    footerView.backgroundColor = UIBackGroundColor;
    return footerView;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.tag == 500) {
        CGFloat scroll_x = scrollView.contentOffset.x;
        self.navView.scroll_x = scroll_x;
        
        
    }
    else if (scrollView.tag == 501) {
        CGFloat scroll_y = scrollView.contentOffset.y;
        self.bgCycleView.frame = CGRectMake(0, kNavigationHeight-((kNavigationHeight+scroll_y)*0.5), kScreenWidth, kScreenWidth);
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (scrollView.tag == 501) {
        CGFloat scroll_height = KScreenHeight;
        CGFloat offset_y = scrollView.contentOffset.y+kNavigationHeight;
        CGFloat size_height = scrollView.contentSize.height;
        if (offset_y+scroll_height-size_height>180) {
            [self.verticalScrollView setContentOffset:CGPointMake(0, KScreenHeight) animated:YES];
            [self.navView.scrollView setContentOffset:CGPointMake(0, self.navView.mj_h) animated:YES];
        }
    }
}

#pragma mark setupUI

- (void)setupUI;
{
    WEAKSELF(weakSelf)
    [self.navigationView setupBackBtnBlock:^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    }];
    
    [self.navigationView setupMoreBtnBlock:^{
        [weakSelf more];
    }];
    
    if (![self.goodsType isEqualToString:@"normal"]) {
        self.navigationView.alphaImageView.image = [UIImage imageWithName:@"integral_goodsdetail" ofType:@"png"];//  .backgroundColor = UIFontRedColor;
        self.navigationView.isShowWhiteTitle = 1;
        self.navView.mainColor = UIFontWhiteColor;
        self.navigationView.isShowLine = 0;
        self.bottomView.imageString = @"integral_goodsdetail";
    }else{
        self.navigationView.bgAlpha = 0.95;
    }
    self.navView.didTouchBlock = ^(GoodsDetailTouchType touchType)
    {
        if (touchType == GoodsDetailTouchGoodsType)
        {
            [weakSelf.horizontalScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
        }else if (touchType == GoodsDetailTouchDetailType)
        {
            [weakSelf.horizontalScrollView setContentOffset:CGPointMake(kScreenWidth, 0) animated:YES];
        }
    };
    [self.navigationView addSubview:self.navView];
    
    MJRefreshNormalHeader * header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf.verticalWebView.scrollView.mj_header  endRefreshing];
        [self.navView.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
        [weakSelf.verticalScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    }];
    header.arrowView.alpha = 0;
    header.lastUpdatedTimeLabel.hidden = YES;
    [header setTitle:@"下拉回到商品详情" forState:1];
    [header setTitle:@"释放回到商品详情" forState:2];
    [header setTitle:@"" forState:3];
    self.verticalWebView.scrollView.mj_header = header;
    [self.verticalScrollView addSubview:self.verticalWebView];
    
    
    [self.view insertSubview:self.verticalScrollView belowSubview:self.navigationView];
    
    [self.horizontalScrollView addSubview:self.horizontalWebView];
    
    [self.verticalScrollView addSubview:self.horizontalScrollView];
    
    [self.horizontalScrollView addSubview:self.bgCycleView];
    [self.horizontalScrollView addSubview:self.table];
    
    [self.table registerNib:[UINib nibWithNibName:NSStringFromClass([Fcgo_GoodsDetailSection0Cell0 class]) bundle:nil] forCellReuseIdentifier:@"goodsDetailSection0Cell0"];
    [self.table registerNib:[UINib nibWithNibName:NSStringFromClass([Fcgo_GoodsDetailSection4Cell0 class]) bundle:nil] forCellReuseIdentifier:@"goodsDetailSection4Cell0"];
    [self.table registerNib:[UINib nibWithNibName:NSStringFromClass([Fcgo_GoodsDetailSection1Cell class]) bundle:nil] forCellReuseIdentifier:@"goodsDetailSection1Cell"];
    [self.table registerNib:[UINib nibWithNibName:NSStringFromClass([Fcgo_GoodsDetailSection2Cell0 class]) bundle:nil] forCellReuseIdentifier:@"goodsDetailSection2Cell0"];
    [self.table registerNib:[UINib nibWithNibName:NSStringFromClass([Fcgo_GoodsDetailSection3Cell0 class]) bundle:nil] forCellReuseIdentifier:@"goodsDetailSection3Cell0"];
    [self.view addSubview:self.bottomView];
}

- (void)more
{
    CGFloat x = kScreenWidth - 12;
    CGFloat y = kNavigationHeight+6.5;
    NSArray *dataArray = @[ [[LrdCellModel alloc] initWithTitle:@"消息" imageName:@"icon_white_msg_"],
                            [[LrdCellModel alloc] initWithTitle:@"首页" imageName:@"icon_home_"],
                            [[LrdCellModel alloc] initWithTitle:@"我的收藏" imageName:@"icon_white_love_"],
                            [[LrdCellModel alloc] initWithTitle:@"联系我们" imageName:@"icon_kefu_"]];
    
    
    LrdOutputView *outputView = [[LrdOutputView alloc] initWithDataArray:dataArray origin:CGPointMake(x, y) width:110 height:40 direction:kLrdOutputViewDirectionRight];
    outputView.delegate = self;
    [outputView pop];
}

- (void)didSelectedAtIndexPath:(NSIndexPath *)indexPath
{
    WEAKSELF(weakSelf)
    switch (indexPath.row) {
        case 0:
        {
            Fcgo_MsgVC *msgVC = [[Fcgo_MsgVC alloc]init];
            msgVC.hidesBottomBarWhenPushed =  YES;
            [self.navigationController pushViewController:msgVC animated:YES];
        }
            break;
        case 1:
        {
            
            // 必须放在前面，先选择，再pop，否则因为执行顺序会发生BUG
            Fcgo_Delegate.tabVC.selectedIndex = 0;
            
            [self.navigationController popToRootViewControllerAnimated:YES];
            
            
        }
            break;
        case 2:
        {
            Fcgo_CollectVC *vc = [[Fcgo_CollectVC alloc]init];
            vc.cancelBlock = ^(NSString *goodsId,BOOL isAllCancel){
                weakSelf.bottomView.isFavourite = 0;
            };
            vc.hidesBottomBarWhenPushed = 1;
            [self.navigationController pushViewController:vc animated:1];
        }
            break;
        case 3:
        {
            //            UIWebView *webview = [[UIWebView alloc] init];
            //            [webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",[[Fcgo_UserTools shared] tel]]]]];
            //            [[[UIApplication sharedApplication] keyWindow] addSubview:webview];
            Fcgo_ContactServiceVC *vc = [[Fcgo_ContactServiceVC alloc]init];
            vc.hidesBottomBarWhenPushed = 1;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
            
        default:
            break;
    }
}

#pragma mark - SDCycleScrollViewDelegate

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    if (self.picurlsArray) {
        //利用XLImageViewer显示本地图片
        [[XLImageViewer shareInstanse]  showNetImages:self.picurlsArray index:index fromImageContainer:self.bgCycleView.mainView];
    }
}

#pragma mark Lazy method

- (UITableView *)table
{
    if (!_table) {
        UITableView *table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, KScreenHeight-50) style:UITableViewStylePlain];
        table.delegate = self;
        table.dataSource = self;
        table.tag = 501;
        table.separatorStyle = 0;
        table.backgroundColor = UIFontClearColor;
        table.showsVerticalScrollIndicator = NO;
        table.contentInset = UIEdgeInsetsMake(kNavigationHeight, 0, 0, 0);
        table.tableHeaderView = self.tableCycleView;
        if (@available(iOS 11.0, *)) {
            table.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        
        UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 50)];
        UILabel *titleLabel = [[UILabel alloc]init];
        titleLabel.text = @"上拉查看图文详情";
        titleLabel.textColor = UIFontMiddleGrayColor;
        titleLabel.font = [UIFont systemFontOfSize:14];
        [footerView addSubview:titleLabel];
        
        UIImageView *iconImageView = [[UIImageView alloc]init];
        iconImageView.image = [UIImage imageWithName:@"up_arrow_detail" ofType:@"png"];
        [footerView addSubview:iconImageView];
        
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(footerView.mas_centerX).mas_offset(15);
            make.left.mas_equalTo(iconImageView.mas_right).mas_offset(5);
            make.centerY.mas_equalTo(footerView.mas_centerY);
        }];
        
        [iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(titleLabel.mas_left).mas_offset(0);
            make.centerY.mas_equalTo(footerView.mas_centerY);
            make.width.mas_offset(30);
            make.height.mas_offset(20);
            
        }];
        table.tableFooterView = footerView;
        _table = table;
        if (@available(iOS 11.0, *)) {
            table.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return _table;
}

- (Fcgo_GoodsDetailNavView *)navView
{
    
    if (!_navView) {
        _navView = [[Fcgo_GoodsDetailNavView alloc]initWithFrame:CGRectMake(50, kNavigationSubY(20), kScreenWidth - 100, 44)];
    }
    return _navView;
}

- (FDDemoScrollView *)horizontalScrollView
{
    if (!_horizontalScrollView) {
        FDDemoScrollView *scrollView = [[FDDemoScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, KScreenHeight)];
        scrollView.bounces = 0;
        scrollView.delegate = self;
        scrollView.tag = 500;
        scrollView.pagingEnabled = 1;
        scrollView.hidden = 1;
        scrollView.showsHorizontalScrollIndicator = 0;
        scrollView.contentSize = CGSizeMake(kScreenWidth*2, 0);
        _horizontalScrollView = scrollView;
    }
    return _horizontalScrollView;
}

- (UIScrollView *)verticalScrollView
{
    if (!_verticalScrollView) {
        UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, KScreenHeight)];
        scrollView.bounces = 0;
        scrollView.scrollEnabled = 0;
        scrollView.pagingEnabled = 1;
        scrollView.showsVerticalScrollIndicator = 0;
        scrollView.hidden = 1;
        scrollView.contentSize = CGSizeMake(0, KScreenHeight*2);
        if (@available(iOS 11.0, *)) {
            scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        _verticalScrollView = scrollView;
    }
    return _verticalScrollView;
}

- (UIWebView *)verticalWebView
{
    if (!_verticalWebView) {
        _verticalWebView = [[UIWebView alloc]initWithFrame:CGRectMake(0, KScreenHeight, kScreenWidth, KScreenHeight-50)];
        _verticalWebView.scalesPageToFit = 1;
        _verticalWebView.backgroundColor = UIFontWhiteColor;
        _verticalWebView.hidden = 0;
        _verticalWebView.delegate = self;
        _verticalWebView.scrollView.contentInset = UIEdgeInsetsMake(kNavigationHeight, 0, 0, 0);
        if (@available(iOS 11.0, *)) {
            _verticalWebView.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return _verticalWebView;
}

- (UIWebView *)horizontalWebView
{
    if (!_horizontalWebView) {
        _horizontalWebView = [[UIWebView alloc]initWithFrame:CGRectMake(kScreenWidth, 0, kScreenWidth, KScreenHeight-50)];
        _horizontalWebView.scalesPageToFit = 1;
        _horizontalWebView.hidden = 0;
        _horizontalWebView.delegate = self;
        _horizontalWebView.backgroundColor = UIFontWhiteColor;
        _horizontalWebView.scrollView.contentInset = UIEdgeInsetsMake(kNavigationHeight, 0, 0,0);
        if (@available(iOS 11.0, *)) {
            _horizontalWebView.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return _horizontalWebView;
}


- (void)addCartOrBuyWithWay:(NSInteger)type
{
    //type 0 是加入购物车，1是结算
    self.goodsType = self.goodsType?self.goodsType:@"normal";
    if (!self.bestSKUModel)
    {
        [WSProgressHUD showImage:nil status:@"请选择完整属性"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.view addSubview:self.goodsSKUVC.view];
        });
        return;
    }
    if (self.addCount <= 0) {
        [WSProgressHUD showImage:nil status:@"商品数量不足"];
        return;
    }
    NSMutableDictionary   *paremtes = [NSMutableDictionary dictionary];
    NSString              *urlString;
    if (type == 0) {
        NSString *goodsType;
        if(![self.goodsType isEqualToString:@"normal"])
        {
            if (self.integralModel) {
                if (self.integralModel.status.intValue == 2) {
                    [paremtes  setObjectWithNullValidate:self.bestSKUModel.skuid forKey:@"goodsValue"];
                    goodsType = @"normal";
                    
                }
                else{
                    [paremtes  setObjectWithNullValidate:self.goodsValue forKey:@"goodsValue"];
                }
            }else{
                [paremtes  setObjectWithNullValidate:self.goodsValue forKey:@"goodsValue"];
            }
            
            
        }
        else{
            [paremtes  setObjectWithNullValidate:self.bestSKUModel.skuid forKey:@"goodsValue"];
        }
        [paremtes  setObjectWithNullValidate:self.goodsType forKey:@"goodsType"];
        
        if (self.infoModel.texes.intValue == 2|| self.infoModel.texes.intValue == 3) {
            [paremtes setObjectWithNullValidate:@"1" forKey:@"goodsNumber"];
        }
        else{
           [paremtes setObjectWithNullValidate:[NSString stringWithFormat:@"%ld",(long)self.addCount] forKey:@"goodsNumber"];
        }
        [paremtes setObjectWithNullValidate:self.infoModel.goods_id forKey:@"goodsId"];
        [paremtes setObjectWithNullValidate:self.bestSKUModel.skuid forKey:@"goodsGskuId"];
        urlString = NSFormatHeardMeThodUrl(ServiceLocalTypeOne, SHOPCARMETHOD, @"addShopCar");
        [self prepareWithUrl:urlString parameters:paremtes];
    }
    else if (type == 1)
    {
        NSInteger count = 1;
        if (self.infoModel.texes.intValue == 2|| self.infoModel.texes.intValue == 3) {
            count = 1;
        }else{
            count = self.addCount;
        }
        NSDictionary *dict;
        if(![self.goodsType isEqualToString:@"normal"])
        {
            if (self.integralModel) {
                if (self.integralModel.status.intValue == 2) {
                    dict = @{@"goodsNumber":[NSString stringWithFormat:@"%ld",(long)count],
                             @"goodsType":@"normal",
                             @"goodsValue":self.bestSKUModel.skuid,
                             };
                }else{
                    dict = @{@"goodsNumber":[NSString stringWithFormat:@"%ld",(long)count],
                             @"goodsType":self.goodsType,
                             @"goodsValue":self.goodsValue,
                             };
                }
            }else{
                dict = @{@"goodsNumber":[NSString stringWithFormat:@"%ld",(long)count],
                         @"goodsType":self.goodsType,
                         @"goodsValue":self.goodsValue,
                         };
            }
        }else{
            dict = @{@"goodsNumber":[NSString stringWithFormat:@"%ld",(long)count],
                     @"goodsType":self.goodsType,
                     @"goodsValue":self.bestSKUModel.skuid,
                     };
        }
        NSArray *array = @[dict];
        NSString *jsonStr=[Fcgo_publicNetworkTools arrayToJson:array];
        [paremtes  setObjectWithNullValidate:jsonStr forKey:@"goods"];
        [paremtes setObjectWithNullValidate:self.selectedAddressModel.addressArea forKey:@"area"];
        urlString = NSFormatHeardMeThodUrl(ServiceLocalTypeOne, ORDERMETHOD, @"prepare");
        if (self.infoModel.texes.intValue == 2|| self.infoModel.texes.intValue == 3) {
            [WSProgressHUD showImage:nil status:@"根据规定:跨境和海外商品单次下单商品数量限制为1" maskType:WSProgressHUDMaskTypeClear];
           dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self prepareWithUrl:urlString parameters:paremtes];
            });
        }else{
           [self prepareWithUrl:urlString parameters:paremtes];
        }
    }
}

- (void)prepareWithUrl:(NSString *)urlString parameters:(NSMutableDictionary *)paremtes
{
    WEAKSELF(weakSelf);
    [WSProgressHUD showWithStatus:@"加载中..." maskType:WSProgressHUDMaskTypeClear];
    [Fcgo_NetworkManager postRequest:urlString parametersContentCommon:paremtes successBlock:^(BOOL success, id responseObject, NSString *msg) {
        if (success) {
            NSNumber *errCode = responseObject[@"errorCode"];
            if (errCode.intValue == 0) {
                if ([urlString containsString:@"mch/shopcar/addShopCar"]) {
                    [WSProgressHUD showSuccessWithStatus:@"加入购物车成功"];
                    weakSelf.bottomView.cartCount += 1;
                    [weakSelf.bottomView addCartAnimation];
                    //向购物车发送刷新通知
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"addCartSuccess" object:nil];
                }
                else if ([urlString containsString:@"order/prepare"]) {
                    
                    NSDictionary *data = responseObject[@"data"];
                    if (!data) {
                        [WSProgressHUD showImage:nil status:@"没有数据"];
                        return;
                    }
                    Fcgo_OrderBuyModel *model = [Fcgo_OrderBuyModel yy_modelWithDictionary:data];
                    Fcgo_OrderConfirmVC *vc = [[Fcgo_OrderConfirmVC alloc]init];
                    vc.model = model;
                    vc.selectedAdressModel = weakSelf.selectedAddressModel;
                    vc.paremtes = paremtes;
                    vc.hidesBottomBarWhenPushed = 1;
                    [weakSelf.navigationController pushViewController:vc animated:1];
                }
            }
            else {
                [WSProgressHUD showWithStatus:responseObject[@"errorMsg"]];
            }
        }
    } failureBlock:^(NSString *description) {} ];
}

- (Fcgo_GoodsDetailBottomView *)bottomView
{
    WEAKSELF(weakSelf);
    if (!_bottomView) {
        _bottomView = [[Fcgo_GoodsDetailBottomView alloc]initWithFrame:CGRectMake(0, KScreenHeight - 50, kScreenWidth, 50)];
        _bottomView.hidden = 1;
        _bottomView.didTouchBlock = ^(GoodsDetailBottomType touchType,BOOL isSelect){
            if (touchType == GoodsDetailTouchBuyType) {
                [weakSelf addCartOrBuyWithWay:1];
            }
            else if (touchType == GoodsDetailTouchAddCartType)
            {
                [weakSelf addCartOrBuyWithWay:0];
            }
            else if (touchType == GoodsDetailTouchCartType) {
                //                if ([weakSelf.tabBarController viewControllers].count == 5) {
                //                    weakSelf.tabBarController.selectedIndex = 3;
                //                }
                //                else{
                //                    weakSelf.tabBarController.selectedIndex = 2;
                //                }
                //                [weakSelf.navigationController popToRootViewControllerAnimated:YES];
                Fcgo_CartOfAddVC *cartVC = [[Fcgo_CartOfAddVC alloc] init];
                cartVC.isNotTabbar = YES;
                cartVC.hidesBottomBarWhenPushed = 1;
                [weakSelf.navigationController pushViewController:cartVC animated:YES];
            }
            else if (touchType == GoodsDetailTouchShowAddressType) {
                //                [weakSelf.pickerView show];
              
                
                [weakSelf.addressView show];
                
            }
            else if (touchType == GoodsDetailTouchShowSoldOutType) {
                [weakSelf.view addSubview:weakSelf.goodsSKUVC.view];
            }
            
            else if (touchType == GoodsDetailTouchCollectType) {
                //选择收藏
                if(isSelect)
                {
                    [weakSelf requestAddCollect];
                }
                //取消收藏
                else{
                    [weakSelf requestCancelCollect];
                }
            }
        };
    }
    return _bottomView;
}

- (void)requestAddCollect
{
    WEAKSELF(weakSelf);
    if (!self.infoModel) {
        [WSProgressHUD showImage:nil status:@"数据错误，稍后再试"];
        return;
    }
    NSMutableDictionary   *paremtes = [NSMutableDictionary dictionary];
    [paremtes  setObjectWithNullValidate:self.infoModel.goods_id forKey:@"goodsId"];
    [paremtes  setObjectWithNullValidate:@"ios" forKey:@"source"];
    [Fcgo_NetworkManager postRequest:NSFormatHeardMeThodUrl(ServiceLocalTypeOne, @"mch/favorite/", @"add") parametersContentCommon:paremtes successBlock:^(BOOL success, id responseObject, NSString *msg) {
        if (success) {
            NSNumber *errCode = responseObject[@"errorCode"];
            if (errCode.intValue == 0) {
                [WSProgressHUD showImage:nil status:@"收藏成功"];
                [weakSelf.bottomView collectAnimation];
            }
        }
        
    } failureBlock:^(NSString *description) {
        
    }];
}
- (void)requestCancelCollect
{
    if (!self.infoModel) {
        [WSProgressHUD showImage:nil status:@"数据错误，稍后再试"];
        return;
    }
    
    WEAKSELF(weakSelf);
    NSMutableDictionary   *paremtes = [NSMutableDictionary dictionary];
    [paremtes  setObjectWithNullValidate:self.infoModel.goods_id forKey:@"goodsId"];
    [Fcgo_NetworkManager postRequest:NSFormatHeardMeThodUrl(ServiceLocalTypeOne, @"mch/favorite/", @"del") parametersContentCommon:paremtes successBlock:^(BOOL success, id responseObject, NSString *msg) {
        if (success) {
            NSNumber *errCode = responseObject[@"errorCode"];
            if (errCode.intValue == 0) {
                [WSProgressHUD showImage:nil status:@"取消成功"];
                [weakSelf.bottomView collectAnimation];
                
            }
        }
    } failureBlock:^(NSString *description) {
        
    }];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    //这里是js，主要目的实现对url的获取
    static  NSString * const jsGetImages =
    @"function getImages(){\
    var objs = document.getElementsByTagName(\"img\");\
    var imgScr = '';\
    for(var i=0;i<objs.length;i++){\
    imgScr = imgScr + objs[i].src + '+';\
    };\
    return imgScr;\
    };";
    
    [webView stringByEvaluatingJavaScriptFromString:jsGetImages];//注入js方法
    NSString *urlResurlt = [webView stringByEvaluatingJavaScriptFromString:@"getImages()"];
    NSMutableArray *mUrlArray = [NSMutableArray arrayWithArray:[urlResurlt componentsSeparatedByString:@"+"]];
    if (mUrlArray.count >= 2) {
        [mUrlArray removeLastObject];
    }
    //urlResurlt 就是获取到得所有图片的url的拼接；mUrlArray就是所有Url的数组
    
    //添加图片可点击js
    [webView stringByEvaluatingJavaScriptFromString:@"function registerImageClickAction(){\
     var imgs=document.getElementsByTagName('img');\
     var length=imgs.length;\
     for(var i=0;i<length;i++){\
     img=imgs[i];\
     img.onclick=function(){\
     window.location.href='image-preview:'+this.src}\
     }\
     }"];
    [webView stringByEvaluatingJavaScriptFromString:@"registerImageClickAction();"];
}

//点击img的时候拦截一下获取url
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    //预览图片
    if ([request.URL.scheme isEqualToString:@"image-preview"]) {
        NSString* path = [request.URL.absoluteString substringFromIndex:[@"image-preview:" length]];
        path = [path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        if (path == nil || [path isEqualToString:@""]) {
            return NO;
        }
        [self showImageWithString:path loadView:webView]; //这个是我自己添加的方法
        //path 就是被点击图片的url
        return NO;
    }
    return YES;
}


- (void)showImageWithString:(NSString *)urlString loadView:(UIView *)view
{
    //利用XLImageViewer显示本地图片
    [[XLImageViewer shareInstanse]  showNetImages:@[urlString] index:0 fromImageContainer:nil];
}

- (SDCycleScrollView *)bgCycleView
{
    if (!_bgCycleView)
    {
        SDCycleScrollView *cycleView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, kNavigationHeight, kScreenWidth,kScreenWidth) delegate:self placeholderImage:nil];
        cycleView.autoScroll = 0;
        cycleView.pageControlStyle = SDCycleScrollViewPageContolStyleNone;
        cycleView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
        cycleView.mainView.tag = 502;
        
        self.goodsStatus = [[UILabel alloc]init];
        self.goodsStatus.center = CGPointMake(kScreenWidth/2, kScreenWidth/2);
        self.goodsStatus.bounds = CGRectMake(0, 0, kAutoWidth6(150), kAutoWidth6(150));
        self.goodsStatus.backgroundColor = UIRGBColor(0, 0, 0, 0.47);
        self.goodsStatus.layer.cornerRadius = kAutoWidth6(75);
        self.goodsStatus.layer.masksToBounds = YES;
        self.goodsStatus.textColor = UIFontWhiteColor;
        self.goodsStatus.font = UIBoldFontSize(19);
        self.goodsStatus.text = @"! 已售罄";
        self.goodsStatus.textAlignment = NSTextAlignmentCenter;
        self.goodsStatus.hidden = 1;
        [cycleView addSubview:self.goodsStatus];
        
        UIView *adviceView = [[UIView alloc]initWithFrame:CGRectMake(kScreenWidth - 75, cycleView.mj_h - 75, 45, 45)];
        adviceView.backgroundColor = UIRGBColor(249, 249, 249, 1);
        adviceView.layer.cornerRadius = 20;
        adviceView.layer.masksToBounds = YES;
        
        UILabel *adviceLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, 45, 12)];
        adviceLabel.text = @"建议价";
        adviceLabel.font = [UIFont systemFontOfSize:10];
        adviceLabel.textColor = UIStringColorAlpha(@"#777777", 1);
        adviceLabel.textAlignment = NSTextAlignmentCenter;
        [adviceView addSubview:adviceLabel];
        
        UILabel *advicePrice = [[UILabel alloc]initWithFrame:CGRectMake(0, 25, 45, 12)];
        advicePrice.font = [UIFont systemFontOfSize:10];;
        advicePrice.adjustsFontSizeToFitWidth = YES;
        advicePrice.textColor =UIStringColorAlpha(@"#f63378", 1);
        advicePrice.textAlignment = NSTextAlignmentCenter;
        [adviceView addSubview:self.advicePrice = advicePrice];
        
        [cycleView addSubview:adviceView];
        
        _bgCycleView = cycleView;
    }
    return _bgCycleView;
}

- (SDCycleScrollView *)tableCycleView
{
    if (!_tableCycleView)
    {
        SDCycleScrollView *cycleView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, kScreenWidth,kScreenWidth) delegate:self placeholderImage:nil];
        cycleView.autoScroll = 0;
        cycleView.backgroundColor = UIFontClearColor;
        cycleView.mainView.backgroundColor = UIFontClearColor;
        cycleView.currentPageDotColor = UIFontRedColor;
        cycleView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
        cycleView.mainView.tag = 503;
        cycleView.observeBlock = ^(CGFloat offsetX){
            [self.bgCycleView.mainView setContentOffset:CGPointMake(offsetX, 0)];
        };
        _tableCycleView = cycleView;
    }
    return _tableCycleView;
}

- (NSMutableArray *)activityArray
{
    if (!_activityArray) {
        _activityArray = [[NSMutableArray alloc]init];
    }
    return _activityArray;
}

- (NSMutableArray *)attrArray
{
    if (!_attrArray) {
        _attrArray = [[NSMutableArray alloc]init];
    }
    return _attrArray;
}

- (NSMutableArray *)save_attrArray
{
    if (!_save_attrArray) {
        _save_attrArray = [[NSMutableArray alloc]init];
    }
    return _save_attrArray;
}

- (NSMutableArray *)addressListArray
{
    if (!_addressListArray) {
        _addressListArray = [[NSMutableArray alloc]init];
    }
    return _addressListArray;
}



- (Fcgo_GoodsSKUVC *)goodsSKUVC
{
    WEAKSELF(weakSelf);
    if (!_goodsSKUVC) {
        
        _goodsSKUVC = [[Fcgo_GoodsSKUVC alloc]init];
        _goodsSKUVC.selectAttrItemBlock = ^(NSString *properties_name,NSString *attr,BOOL isSelected,NSInteger count){
            weakSelf.addCount = count;
            BOOL isSame = NO;
            _isLowerPrice = NO;
            
            for (int i = 0; i < weakSelf.save_attrArray.count; i ++) {
                NSDictionary *dict = weakSelf.save_attrArray[i];
                NSString *properties_name_t = dict[@"properties_name"];
                NSString *attr_name = dict[@"attr_name"];
                if ([properties_name_t isEqualToString:properties_name]) {
                    isSame = YES;
                    if (isSelected) {
                        if (![attr_name isEqualToString:attr]) {
                            [weakSelf.save_attrArray removeObject:dict];
                            NSDictionary *addDict = @{@"properties_name":properties_name,@"attr_name":attr};
                            [weakSelf.save_attrArray addObject:addDict];
                        }
                        weakSelf.isLowerPrice = NO;
                    }
                    else
                    {
                        if ([attr_name isEqualToString:attr]) {
                            [weakSelf.save_attrArray removeObject:dict];
                        }
                    }
                }
            }
            if (isSame == NO) {
                NSDictionary *addDict = @{@"properties_name":properties_name,@"attr_name":attr};
                [weakSelf.save_attrArray addObject:addDict];
            }
            
            [WSProgressHUD showWithStatus:@"加载中..." maskType:WSProgressHUDMaskTypeDefault];
            [weakSelf postRequestGoodsSKUMsg];
        };
        
        _goodsSKUVC.selectCountBlock = ^(NSInteger count) {
            weakSelf.addCount = count;
            [WSProgressHUD showWithStatus:@"加载中..." maskType:WSProgressHUDMaskTypeDefault];
            [weakSelf postRequestGoodsSKUMsg];
        };
        
        _goodsSKUVC.lowerPriceBlock = ^{
            if ((![self.goodsType isKindOfClass:[NSNull class]])&&[self.goodsType isEqualToString:@"normal"]) {
                [WSProgressHUD showWithStatus:@"加载中..." maskType:WSProgressHUDMaskTypeClear];

                weakSelf.isLowerPrice = YES;
                [weakSelf.save_attrArray removeAllObjects];
                [weakSelf postRequestGoodsSKUMsg];
            }
        };
    }
    return _goodsSKUVC;
}

//- (Fcgo_ExterAddressPickerView *)pickerView
//{
//    WEAKSELF(weakSelf)
//    if (!_pickerView) {
//        _pickerView = [[Fcgo_ExterAddressPickerView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, KScreenHeight) selectAddressBlock:^(NSMutableDictionary *addressDict) {
//            weakSelf.userAddressDict = addressDict;
//            [weakSelf postRequestGoodsSKUMsg];
//        }];
//    }
//    return _pickerView;
//}

@end

