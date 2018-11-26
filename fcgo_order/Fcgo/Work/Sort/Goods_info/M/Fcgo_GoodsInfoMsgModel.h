//
//  Fcgo_GoodsInfoMsgModel.h
//  Fcgo
//
//  Created by huafanxiao on 2017/12/25.
//  Copyright © 2017年 Fcg. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Fcgo_BrandModel.h"
#import "Fcgo_GoodsInfoActivityModel.h"
@interface Fcgo_GoodsInfoMsgModel : NSObject

@property (nonatomic,copy)   NSString *goodsName,*price,*freight_s,*stock_s,*f_html_content;
@property (nonatomic,strong) NSNumber *goodsSaleNum,*freight,*freightYUAN,*stock,*minprice,*maxprice,*goods_id,*goodsVirtualNum,*texes,*priceYUAN,*minpriceYUAN,*maxpriceYUAN,*jprice,*goodsSalenum,*goodsScannum;
@property (nonatomic,strong) NSArray *picUrl;
@property (nonatomic,copy)   NSString *goodsType;
@property (nonatomic,strong) Fcgo_BrandModel *brandModel;
@property (nonatomic,strong) NSMutableArray *activityArray;
@property (nonatomic,strong) Fcgo_GoodsInfoActivityModel *activityModel;
@property (nonatomic,strong) NSNumber *addCount;
@property (nonatomic,strong) NSNumber *isLowerPrice;
@end



