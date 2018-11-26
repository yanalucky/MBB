//
//  Fcgo_HomeAdModel.h
//  Fcgo
//
//  Created by by_r on 2017/9/25.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Fcgo_HomeAdModel : NSObject<NSCoding>
@property (nonatomic, copy) NSString *merchantId;
@property (nonatomic, copy) NSString *version;
@property (nonatomic, assign) NSInteger onuse;
@property (nonatomic, copy) NSString *picurlMobile; ///< 图片地址
@property (nonatomic, strong) NSData *picurl_data; ///< 图片数据流
@property (nonatomic, strong) NSString *hrefMobile; ///< json字符串
@property (nonatomic, strong) NSString *provinceId; ///< 省份ID
@property (nonatomic, strong) NSString *cityId; ///< 城市ID
@property (nonatomic, strong) NSString *areaId; ///< 地区ID
@end
