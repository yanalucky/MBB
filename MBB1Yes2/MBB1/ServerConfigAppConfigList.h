//
//  ServerConfigAppConfigList.h
//
//  Created by  豆蒙萌 on 15/9/21
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ServerConfigAppConfigList : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *comfigimgversion;
@property (nonatomic, strong) NSString *configkey;
@property (nonatomic, strong) NSString *configtype;
@property (nonatomic, strong) NSString *comfigimg;
@property (nonatomic, strong) NSString *configvalue;
@property (nonatomic, strong) NSString *configid;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
