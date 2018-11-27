//
//  ServerConfigResult.m
//
//  Created by  豆蒙萌 on 15/9/21
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "ServerConfigResult.h"
#import "ServerConfigAppConfigList.h"
#import "ServerConfigDoctorList.h"
#import "ServerConfigGrowthList.h"
#import "ServerConfigHospitalList.h"
#import "ServerConfigFeatureList.h"
#import "ServerConfigQuestionList.h"


NSString *const kServerConfigResultAppConfigList = @"AppConfigList";
NSString *const kServerConfigResultDoctorList = @"DoctorList";
NSString *const kServerConfigResultCurrentVersion = @"CurrentVersion";
NSString *const kServerConfigResultGrowthList = @"GrowthList";
NSString *const kServerConfigResultLowestVersion = @"LowestVersion";
NSString *const kServerConfigResultHospitalList = @"HospitalList";
NSString *const kServerConfigResultFeatureList = @"FeatureList";
NSString *const kServerConfigResultQuestionList = @"QuestionList";


@interface ServerConfigResult ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ServerConfigResult

@synthesize appConfigList = _appConfigList;
@synthesize doctorList = _doctorList;
@synthesize currentVersion = _currentVersion;
@synthesize growthList = _growthList;
@synthesize lowestVersion = _lowestVersion;
@synthesize hospitalList = _hospitalList;
@synthesize featureList = _featureList;
@synthesize questionList = _questionList;


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
    NSObject *receivedServerConfigAppConfigList = [dict objectForKey:kServerConfigResultAppConfigList];
    NSMutableArray *parsedServerConfigAppConfigList = [NSMutableArray array];
    if ([receivedServerConfigAppConfigList isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedServerConfigAppConfigList) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedServerConfigAppConfigList addObject:[ServerConfigAppConfigList modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedServerConfigAppConfigList isKindOfClass:[NSDictionary class]]) {
       [parsedServerConfigAppConfigList addObject:[ServerConfigAppConfigList modelObjectWithDictionary:(NSDictionary *)receivedServerConfigAppConfigList]];
    }

    self.appConfigList = [NSArray arrayWithArray:parsedServerConfigAppConfigList];
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
            self.currentVersion = [self objectOrNilForKey:kServerConfigResultCurrentVersion fromDictionary:dict];
    NSObject *receivedServerConfigGrowthList = [dict objectForKey:kServerConfigResultGrowthList];
    NSMutableArray *parsedServerConfigGrowthList = [NSMutableArray array];
    if ([receivedServerConfigGrowthList isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedServerConfigGrowthList) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedServerConfigGrowthList addObject:[ServerConfigGrowthList modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedServerConfigGrowthList isKindOfClass:[NSDictionary class]]) {
       [parsedServerConfigGrowthList addObject:[ServerConfigGrowthList modelObjectWithDictionary:(NSDictionary *)receivedServerConfigGrowthList]];
    }

    self.growthList = [NSArray arrayWithArray:parsedServerConfigGrowthList];
            self.lowestVersion = [self objectOrNilForKey:kServerConfigResultLowestVersion fromDictionary:dict];
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
    NSObject *receivedServerConfigQuestionList = [dict objectForKey:kServerConfigResultQuestionList];
    NSMutableArray *parsedServerConfigQuestionList = [NSMutableArray array];
    if ([receivedServerConfigQuestionList isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedServerConfigQuestionList) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedServerConfigQuestionList addObject:[ServerConfigQuestionList modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedServerConfigQuestionList isKindOfClass:[NSDictionary class]]) {
       [parsedServerConfigQuestionList addObject:[ServerConfigQuestionList modelObjectWithDictionary:(NSDictionary *)receivedServerConfigQuestionList]];
    }

    self.questionList = [NSArray arrayWithArray:parsedServerConfigQuestionList];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    NSMutableArray *tempArrayForAppConfigList = [NSMutableArray array];
    for (NSObject *subArrayObject in self.appConfigList) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForAppConfigList addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForAppConfigList addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForAppConfigList] forKey:kServerConfigResultAppConfigList];
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
    [mutableDict setValue:self.currentVersion forKey:kServerConfigResultCurrentVersion];
    NSMutableArray *tempArrayForGrowthList = [NSMutableArray array];
    for (NSObject *subArrayObject in self.growthList) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForGrowthList addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForGrowthList addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForGrowthList] forKey:kServerConfigResultGrowthList];
    [mutableDict setValue:self.lowestVersion forKey:kServerConfigResultLowestVersion];
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
    NSMutableArray *tempArrayForQuestionList = [NSMutableArray array];
    for (NSObject *subArrayObject in self.questionList) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForQuestionList addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForQuestionList addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForQuestionList] forKey:kServerConfigResultQuestionList];

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

    self.appConfigList = [aDecoder decodeObjectForKey:kServerConfigResultAppConfigList];
    self.doctorList = [aDecoder decodeObjectForKey:kServerConfigResultDoctorList];
    self.currentVersion = [aDecoder decodeObjectForKey:kServerConfigResultCurrentVersion];
    self.growthList = [aDecoder decodeObjectForKey:kServerConfigResultGrowthList];
    self.lowestVersion = [aDecoder decodeObjectForKey:kServerConfigResultLowestVersion];
    self.hospitalList = [aDecoder decodeObjectForKey:kServerConfigResultHospitalList];
    self.featureList = [aDecoder decodeObjectForKey:kServerConfigResultFeatureList];
    self.questionList = [aDecoder decodeObjectForKey:kServerConfigResultQuestionList];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_appConfigList forKey:kServerConfigResultAppConfigList];
    [aCoder encodeObject:_doctorList forKey:kServerConfigResultDoctorList];
    [aCoder encodeObject:_currentVersion forKey:kServerConfigResultCurrentVersion];
    [aCoder encodeObject:_growthList forKey:kServerConfigResultGrowthList];
    [aCoder encodeObject:_lowestVersion forKey:kServerConfigResultLowestVersion];
    [aCoder encodeObject:_hospitalList forKey:kServerConfigResultHospitalList];
    [aCoder encodeObject:_featureList forKey:kServerConfigResultFeatureList];
    [aCoder encodeObject:_questionList forKey:kServerConfigResultQuestionList];
}

- (id)copyWithZone:(NSZone *)zone
{
    ServerConfigResult *copy = [[ServerConfigResult alloc] init];
    
    if (copy) {

        copy.appConfigList = [self.appConfigList copyWithZone:zone];
        copy.doctorList = [self.doctorList copyWithZone:zone];
        copy.currentVersion = [self.currentVersion copyWithZone:zone];
        copy.growthList = [self.growthList copyWithZone:zone];
        copy.lowestVersion = [self.lowestVersion copyWithZone:zone];
        copy.hospitalList = [self.hospitalList copyWithZone:zone];
        copy.featureList = [self.featureList copyWithZone:zone];
        copy.questionList = [self.questionList copyWithZone:zone];
    }
    
    return copy;
}


@end
