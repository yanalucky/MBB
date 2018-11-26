//
//  Fcgo_CateModel.h
//  Fcgo
//
//  Created by huafanxiao on 2017/6/18.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Fcgo_CateModel : NSObject

@property (nonatomic,strong) NSNumber *cate_id;
@property (nonatomic,copy)   NSString *cate_logo,*cate_name;

+ (Fcgo_CateModel *)shareWithNSDictionary:(NSDictionary *)dic;

@end
