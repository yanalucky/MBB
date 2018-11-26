//
//  Fcgo_AddressModel.h
//  Fcgo
//
//  Created by huafanxiao on 2017/6/16.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Fcgo_AddressModel : NSObject<NSCoding>

@property (nonatomic,copy)  NSString    *addressEmail;
@property (nonatomic, copy) NSString    *totaladdress;
@property (nonatomic, copy) NSString    *updateTime;
@property (nonatomic, copy) NSString    *addressDetail;
@property (nonatomic, copy) NSString    *createTime;
@property (nonatomic, copy) NSString    *consigeePhone;
@property (nonatomic,strong) NSNumber   *deFault;
@property (nonatomic, strong) NSNumber  *storeId;
@property (nonatomic, strong) NSNumber  *f_address_id;
//@property (nonatomic, strong) NSNumber  *addressCode;
@property (nonatomic, strong) NSNumber  *mchId;
@property (nonatomic, strong) NSNumber  *merchantDefault;
@property (nonatomic, copy) NSString    *consigee;
@property (nonatomic, copy) NSString    *addressCity;
@property (nonatomic, copy) NSString    *addressArea;
@property (nonatomic, copy) NSString    *addressProvince;
@property (nonatomic, copy) NSString    *addressFormal;
@property (nonatomic, assign) BOOL isOpen;
@property (nonatomic, assign) BOOL haveData;
@property (nonatomic, assign) BOOL  selected;
@end
