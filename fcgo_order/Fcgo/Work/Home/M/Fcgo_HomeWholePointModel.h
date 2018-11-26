//
//  Fcgo_HomeWholePointModel.h
//  Fcgo
//
//  Created by huafanxiao on 2017/5/15.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Fcgo_HomeWholePointModel : NSObject

@property (nonatomic,copy)   NSString *name;
@property (nonatomic,strong) NSNumber *f_integral_id,*end,*now;
@property (nonatomic,strong) NSArray  *datas;
@property (nonatomic,assign) NSTimeInterval time_interval;//记录服务器当前时间与手机本地时间的时间差
+ (Fcgo_HomeWholePointModel *)shareWithNSDictionary:(NSDictionary *)dic;

@end
