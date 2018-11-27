//
//  JLResult.h
//
//  Created by  豆蒙萌 on 15/10/21
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class JLUserRecord, JLUser;

@interface JLResult : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) JLUserRecord *userRecord;
@property (nonatomic, strong) NSString *showTime;
@property (nonatomic, strong) JLUser *user;
@property (nonatomic, strong) NSString *sessionId;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
