//
//  ServerConfigBaseClass.h
//
//  Created by  豆蒙萌 on 15/9/21
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ServerConfigResult;

@interface ServerConfigBaseClass : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) ServerConfigResult *result;
@property (nonatomic, assign) double errorId;
@property (nonatomic, strong) NSString *serverTime;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
