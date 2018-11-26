//
//  Fcgo_RealNameModel.h
//  Fcgo
//
//  Created by huafanxiao on 2017/6/18.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Fcgo_RealNameModel : NSObject

@property (nonatomic, copy) NSString    *createTime;
@property (nonatomic, copy) NSString    *mchIdcard;
@property (nonatomic, copy) NSString    *mchPicurlB;
@property (nonatomic, copy) NSString    *mchRealName;
@property (nonatomic, copy) NSString    *mchPicurlW;
@property (nonatomic, strong) NSNumber  *mchMonthBuy;
@property (nonatomic, strong) NSNumber  *mchYearBuy;
@property (nonatomic, strong) NSNumber  *mchDayBuytime;
@property (nonatomic, copy) NSString    *updateTime;
@property (nonatomic,strong) NSNumber   *f_realName_id;
@property (nonatomic, strong) NSNumber  *f_default;
@property (nonatomic, strong) NSNumber  *storeId;
@property (nonatomic, strong) NSNumber  *mchId;






@end
