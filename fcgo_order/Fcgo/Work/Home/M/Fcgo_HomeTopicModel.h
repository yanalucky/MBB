//
//  Fcgo_HomeTopicModel.h
//  Fcgo
//
//  Created by huafanxiao on 2017/6/19.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Fcgo_HomeTopicModel : NSObject

@property (nonatomic,strong) NSString *f_href,*f_status,*href;
@property (nonatomic,strong) NSNumber *f_topic_id;
@property (nonatomic,strong) NSArray  *datas;

+ (Fcgo_HomeTopicModel *)shareWithNSDictionary:(NSDictionary *)dic;
@end
