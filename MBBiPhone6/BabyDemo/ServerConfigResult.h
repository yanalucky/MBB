//
//  ServerConfigResult.h
//
//  Created by   on 16/6/21
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ServerConfigTheLatestRecord;

@interface ServerConfigResult : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) ServerConfigTheLatestRecord *theLatestRecord;
@property (nonatomic, strong) NSArray *doctorList;
@property (nonatomic, strong) NSString *lowestVersion;
@property (nonatomic, strong) NSArray *historyTime;
@property (nonatomic, strong) NSArray *hospitalList;
@property (nonatomic, strong) NSArray *noticeTime;
@property (nonatomic, strong) NSArray *featureList;
@property (nonatomic, strong) NSArray *historyRecordList;
@property (nonatomic, strong) NSArray *theLatestThreeSalonList;
@property (nonatomic, strong) NSString *currentVersion;
@property (nonatomic, strong) NSArray *featureListByAge;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
