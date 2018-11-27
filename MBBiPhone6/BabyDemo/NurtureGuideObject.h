//
//  NurtureGuideObject.h
//
//  Created by   on 16/5/17
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NurtureGuideResult;

@interface NurtureGuideObject : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NurtureGuideResult *result;
@property (nonatomic, assign) double errorId;
@property (nonatomic, strong) NSString *serverTime;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
