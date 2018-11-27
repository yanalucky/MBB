//
//  RecordStarObject.h
//
//  Created by   on 16/7/15
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RecordStarResult;

@interface RecordStarObject : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) RecordStarResult *result;
@property (nonatomic, assign) double errorId;
@property (nonatomic, strong) NSString *serverTime;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
