//
//  ServerConfigResult.m
//
//  Created by   on 16/6/21
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "ServerConfigResult.h"
#import "ServerConfigTheLatestRecord.h"
#import "ServerConfigDoctorList.h"
#import "ServerConfigHospitalList.h"
#import "ServerConfigNoticeTime.h"
#import "ServerConfigFeatureList.h"
#import "ServerConfigHistoryRecordList.h"
#import "ServerConfigTheLatestThreeSalonList.h"
#import "ServerConfigFeatureListByAge.h"


NSString *const kServerConfigResultTheLatestRecord = @"theLatestRecord";
NSString *const kServerConfigResultDoctorList = @"DoctorList";
NSString *const kServerConfigResultLowestVersion = @"LowestVersion";
NSString *const kServerConfigResultHistoryTime = @"historyTime";
NSString *const kServerConfigResultHospitalList = @"HospitalList";
NSString *const kServerConfigResultNoticeTime = @"noticeTime";
NSString *const kServerConfigResultFeatureList = @"FeatureList";
NSString *const kServerConfigResultHistoryRecordList = @"historyRecordList";
NSString *const kServerConfigResultTheLatestThreeSalonList = @"TheLatestThreeSalonList";
NSString *const kServerConfigResultCurrentVersion = @"CurrentVersion";
NSString *const kServerConfigResultFeatureListByAge = @"FeatureListByAge";


@interface ServerConfigResult ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ServerConfigResult

@synthesize theLatestRecord = _theLatestRecord;
@synthesize doctorList = _doctorList;
@synthesize lowestVersion = _lowestVersion;
@synthesize historyTime = _historyTime;
@synthesize hospitalList = _hospitalList;
@synthesize noticeTime = _noticeTime;
@synthesize featureList = _featureList;
@synthesize historyRecordList = _historyRecordList;
@synthesize theLatestThreeSalonList = _theLatestThreeSalonList;
@synthesize currentVersion = _currentVersion;
@synthesize featureListByAge = _featureListByAge;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.theLatestRecord = [ServerConfigTheLatestRecord modelObjectWithDictionary:[dict objectForKey:kServerConfigResultTheLatestRecord]];
    NSObject *receivedServerConfigDoctorList = [dict objectForKey:kServerConfigResultDoctorList];
    NSMutableArray *parsedServerConfigDoctorList = [NSMutableArray array];
    if ([receivedServerConfigDoctorList isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedServerConfigDoctorList) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedServerConfigDoctorList addObject:[ServerConfigDoctorList modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedServerConfigDoctorList isKindOfClass:[NSDictionary class]]) {
       [parsedServerConfigDoctorList addObject:[ServerConfigDoctorList modelObjectWithDictionary:(NSDictionary *)receivedServerConfigDoctorList]];
    }

    self.doctorList = [NSArray arrayWithArray:parsedServerConfigDoctorList];
            self.lowestVersion = [self objectOrNilForKey:kServerConfigResultLowestVersion fromDictionary:dict];
            self.historyTime = [self objectOrNilForKey:kServerConfigResultHistoryTime fromDictionary:dict];
    NSObject *receivedServerConfigHospitalList = [dict objectForKey:kServerConfigResultHospitalList];
    NSMutableArray *parsedServerConfigHospitalList = [NSMutableArray array];
    if ([receivedServerConfigHospitalList isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedServerConfigHospitalList) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedServerConfigHospitalList addObject:[ServerConfigHospitalList modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedServerConfigHospitalList isKindOfClass:[NSDictionary class]]) {
       [parsedServerConfigHospitalList addObject:[ServerConfigHospitalList modelObjectWithDictionary:(NSDictionary *)receivedServerConfigHospitalList]];
    }

    self.hospitalList = [NSArray arrayWithArray:parsedServerConfigHospitalList];
    NSObject *receivedServerConfigNoticeTime = [dict objectForKey:kServerConfigResultNoticeTime];
    NSMutableArray *parsedServerConfigNoticeTime = [NSMutableArray array];
    if ([receivedServerConfigNoticeTime isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedServerConfigNoticeTime) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedServerConfigNoticeTime addObject:[ServerConfigNoticeTime modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedServerConfigNoticeTime isKindOfClass:[NSDictionary class]]) {
       [parsedServerConfigNoticeTime addObject:[ServerConfigNoticeTime modelObjectWithDictionary:(NSDictionary *)receivedServerConfigNoticeTime]];
    }

    self.noticeTime = [NSArray arrayWithArray:parsedServerConfigNoticeTime];
    NSObject *receivedServerConfigFeatureList = [dict objectForKey:kServerConfigResultFeatureList];
    NSMutableArray *parsedServerConfigFeatureList = [NSMutableArray array];
    if ([receivedServerConfigFeatureList isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedServerConfigFeatureList) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedServerConfigFeatureList addObject:[ServerConfigFeatureList modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedServerConfigFeatureList isKindOfClass:[NSDictionary class]]) {
       [parsedServerConfigFeatureList addObject:[ServerConfigFeatureList modelObjectWithDictionary:(NSDictionary *)receivedServerConfigFeatureList]];
    }

    self.featureList = [NSArray arrayWithArray:parsedServerConfigFeatureList];
    NSObject *receivedServerConfigHistoryRecordList = [dict objectForKey:kServerConfigResultHistoryRecordList];
    NSMutableArray *parsedServerConfigHistoryRecordList = [NSMutableArray array];
    if ([receivedServerConfigHistoryRecordList isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedServerConfigHistoryRecordList) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedServerConfigHistoryRecordList addObject:[ServerConfigHistoryRecordList modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedServerConfigHistoryRecordList isKindOfClass:[NSDictionary class]]) {
       [parsedServerConfigHistoryRecordList addObject:[ServerConfigHistoryRecordList modelObjectWithDictionary:(NSDictionary *)receivedServerConfigHistoryRecordList]];
    }

    self.historyRecordList = [NSArray arrayWithArray:parsedServerConfigHistoryRecordList];
    NSObject *receivedServerConfigTheLatestThreeSalonList = [dict objectForKey:kServerConfigResultTheLatestThreeSalonList];
    NSMutableArray *parsedServerConfigTheLatestThreeSalonList = [NSMutableArray array];
    if ([receivedServerConfigTheLatestThreeSalonList isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedServerConfigTheLatestThreeSalonList) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedServerConfigTheLatestThreeSalonList addObject:[ServerConfigTheLatestThreeSalonList modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedServerConfigTheLatestThreeSalonList isKindOfClass:[NSDictionary class]]) {
       [parsedServerConfigTheLatestThreeSalonList addObject:[ServerConfigTheLatestThreeSalonList modelObjectWithDictionary:(NSDictionary *)receivedServerConfigTheLatestThreeSalonList]];
    }

    self.theLatestThreeSalonList = [NSArray arrayWithArray:parsedServerConfigTheLatestThreeSalonList];
            self.currentVersion = [self objectOrNilForKey:kServerConfigResultCurrentVersion fromDictionary:dict];
    NSObject *receivedServerConfigFeatureListByAge = [dict objectForKey:kServerConfigResultFeatureListByAge];
    NSMutableArray *parsedServerConfigFeatureListByAge = [NSMutableArray array];
    if ([receivedServerConfigFeatureListByAge isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedServerConfigFeatureListByAge) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedServerConfigFeatureListByAge addObject:[ServerConfigFeatureListByAge modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedServerConfigFeatureListByAge isKindOfClass:[NSDictionary class]]) {
       [parsedServerConfigFeatureListByAge addObject:[ServerConfigFeatureListByAge modelObjectWithDictionary:(NSDictionary *)receivedServerConfigFeatureListByAge]];
    }

    self.featureListByAge = [NSArray arrayWithArray:parsedServerConfigFeatureListByAge];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[self.theLatestRecord dictionaryRepresentation] forKey:kServerConfigResultTheLatestRecord];
    NSMutableArray *tempArrayForDoctorList = [NSMutableArray array];
    for (NSObject *subArrayObject in self.doctorList) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForDoctorList addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForDoctorList addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForDoctorList] forKey:kServerConfigResultDoctorList];
    [mutableDict setValue:self.lowestVersion forKey:kServerConfigResultLowestVersion];
    NSMutableArray *tempArrayForHistoryTime = [NSMutableArray array];
    for (NSObject *subArrayObject in self.historyTime) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForHistoryTime addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForHistoryTime addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForHistoryTime] forKey:kServerConfigResultHistoryTime];
    NSMutableArray *tempArrayForHospitalList = [NSMutableArray array];
    for (NSObject *subArrayObject in self.hospitalList) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForHospitalList addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForHospitalList addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForHospitalList] forKey:kServerConfigResultHospitalList];
    NSMutableArray *tempArrayForNoticeTime = [NSMutableArray array];
    for (NSObject *subArrayObject in self.noticeTime) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForNoticeTime addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForNoticeTime addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForNoticeTime] forKey:kServerConfigResultNoticeTime];
    NSMutableArray *tempArrayForFeatureList = [NSMutableArray array];
    for (NSObject *subArrayObject in self.featureList) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForFeatureList addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForFeatureList addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForFeatureList] forKey:kServerConfigResultFeatureList];
    NSMutableArray *tempArrayForHistoryRecordList = [NSMutableArray array];
    for (NSObject *subArrayObject in self.historyRecordList) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForHistoryRecordList addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForHistoryRecordList addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForHistoryRecordList] forKey:kServerConfigResultHistoryRecordList];
    NSMutableArray *tempArrayForTheLatestThreeSalonList = [NSMutableArray array];
    for (NSObject *subArrayObject in self.theLatestThreeSalonList) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForTheLatestThreeSalonList addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForTheLatestThreeSalonList addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForTheLatestThreeSalonList] forKey:kServerConfigResultTheLatestThreeSalonList];
    [mutableDict setValue:self.currentVersion forKey:kServerConfigResultCurrentVersion];
    NSMutableArray *tempArrayForFeatureListByAge = [NSMutableArray array];
    for (NSObject *subArrayObject in self.featureListByAge) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForFeatureListByAge addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForFeatureListByAge addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForFeatureListByAge] forKey:kServerConfigResultFeatureListByAge];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description 
{
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}

#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}


#pragma mark - NSCoding Methods

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];

    self.theLatestRecord = [aDecoder decodeObjectForKey:kServerConfigResultTheLatestRecord];
    self.doctorList = [aDecoder decodeObjectForKey:kServerConfigResultDoctorList];
    self.lowestVersion = [aDecoder decodeObjectForKey:kServerConfigResultLowestVersion];
    self.historyTime = [aDecoder decodeObjectForKey:kServerConfigResultHistoryTime];
    self.hospitalList = [aDecoder decodeObjectForKey:kServerConfigResultHospitalList];
    self.noticeTime = [aDecoder decodeObjectForKey:kServerConfigResultNoticeTime];
    self.featureList = [aDecoder decodeObjectForKey:kServerConfigResultFeatureList];
    self.historyRecordList = [aDecoder decodeObjectForKey:kServerConfigResultHistoryRecordList];
    self.theLatestThreeSalonList = [aDecoder decodeObjectForKey:kServerConfigResultTheLatestThreeSalonList];
    self.currentVersion = [aDecoder decodeObjectForKey:kServerConfigResultCurrentVersion];
    self.featureListByAge = [aDecoder decodeObjectForKey:kServerConfigResultFeatureListByAge];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_theLatestRecord forKey:kServerConfigResultTheLatestRecord];
    [aCoder encodeObject:_doctorList forKey:kServerConfigResultDoctorList];
    [aCoder encodeObject:_lowestVersion forKey:kServerConfigResultLowestVersion];
    [aCoder encodeObject:_historyTime forKey:kServerConfigResultHistoryTime];
    [aCoder encodeObject:_hospitalList forKey:kServerConfigResultHospitalList];
    [aCoder encodeObject:_noticeTime forKey:kServerConfigResultNoticeTime];
    [aCoder encodeObject:_featureList forKey:kServerConfigResultFeatureList];
    [aCoder encodeObject:_historyRecordList forKey:kServerConfigResultHistoryRecordList];
    [aCoder encodeObject:_theLatestThreeSalonList forKey:kServerConfigResultTheLatestThreeSalonList];
    [aCoder encodeObject:_currentVersion forKey:kServerConfigResultCurrentVersion];
    [aCoder encodeObject:_featureListByAge forKey:kServerConfigResultFeatureListByAge];
}

- (id)copyWithZone:(NSZone *)zone
{
    ServerConfigResult *copy = [[ServerConfigResult alloc] init];
    
    if (copy) {

        copy.theLatestRecord = [self.theLatestRecord copyWithZone:zone];
        copy.doctorList = [self.doctorList copyWithZone:zone];
        copy.lowestVersion = [self.lowestVersion copyWithZone:zone];
        copy.historyTime = [self.historyTime copyWithZone:zone];
        copy.hospitalList = [self.hospitalList copyWithZone:zone];
        copy.noticeTime = [self.noticeTime copyWithZone:zone];
        copy.featureList = [self.featureList copyWithZone:zone];
        copy.historyRecordList = [self.historyRecordList copyWithZone:zone];
        copy.theLatestThreeSalonList = [self.theLatestThreeSalonList copyWithZone:zone];
        copy.currentVersion = [self.currentVersion copyWithZone:zone];
        copy.featureListByAge = [self.featureListByAge copyWithZone:zone];
    }
    
    return copy;
}


@end
