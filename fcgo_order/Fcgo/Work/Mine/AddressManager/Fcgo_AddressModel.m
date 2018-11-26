//
//  Fcgo_AddressModel.m
//  Fcgo
//
//  Created by huafanxiao on 2017/6/16.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_AddressModel.h"

@implementation Fcgo_AddressModel
//@property (nonatomic,copy)  NSString *addressEmail,*totaladdress,*updateTime,*addressDetail,*consigee,*createTime,*consigeePhone;
//@property (nonatomic,strong) NSNumber *deFault,*storeId,*f_address_id,*addressCode,*mchId,*merchantDefault;
//
//@property (nonatomic, assign) BOOL isOpen;
//@property (nonatomic, assign) BOOL haveData;

+ (NSDictionary *)modelCustomPropertyMapper
{
    return @{@"f_address_id" :@"id",
//             @"addressCode":@"f_address_area",@"":@"",@"":@""
             };
    
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    return [self yy_modelInitWithCoder:aDecoder];
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [self yy_modelEncodeWithCoder:aCoder];
}

@end
