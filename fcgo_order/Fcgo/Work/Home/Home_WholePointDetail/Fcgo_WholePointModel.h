//
//  Fcgo_WholePointModel.h
//  Fcgo
//
//  Created by huafanxiao on 2017/6/26.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Fcgo_WholePointModel : NSObject

@property (nonatomic,copy)   NSString *name;
@property (nonatomic,strong) NSNumber *f_integral_id,*end,*start,*type,*tyeName;
@property (nonatomic,strong) NSArray  *datas;
@property (nonatomic,assign) NSTimeInterval time_interval;//记录服务器当前时间与手机本地时间的时间差

+ (Fcgo_WholePointModel *)shareWithNSDictionary:(NSDictionary *)dic;

@end
