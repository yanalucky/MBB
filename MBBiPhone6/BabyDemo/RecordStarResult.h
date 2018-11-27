//
//  RecordStarResult.h
//
//  Created by   on 16/7/15
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RecordStarTheLatestRecord, RecordStarFirstRecordAge, RecordStarUserRecord;

@interface RecordStarResult : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) RecordStarTheLatestRecord *theLatestRecord;
@property (nonatomic, strong) RecordStarFirstRecordAge *firstRecordAge;
@property (nonatomic, strong) NSArray *babyBeforeRecord;
@property (nonatomic, assign) id isSubmitRecord;
@property (nonatomic, strong) NSString *showTime;
@property (nonatomic, strong) NSArray *recordStar;
@property (nonatomic, assign) double timeStatus;
@property (nonatomic, strong) RecordStarUserRecord *userRecord;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
