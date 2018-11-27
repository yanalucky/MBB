//
//  RecordStarResult.m
//
//  Created by   on 16/7/15
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "RecordStarResult.h"
#import "RecordStarTheLatestRecord.h"
#import "RecordStarFirstRecordAge.h"
#import "RecordStarBabyBeforeRecord.h"
#import "RecordStarRecordStar.h"
#import "RecordStarUserRecord.h"


NSString *const kRecordStarResultTheLatestRecord = @"theLatestRecord";
NSString *const kRecordStarResultFirstRecordAge = @"firstRecordAge";
NSString *const kRecordStarResultBabyBeforeRecord = @"babyBeforeRecord";
NSString *const kRecordStarResultIsSubmitRecord = @"isSubmitRecord";
NSString *const kRecordStarResultShowTime = @"ShowTime";
NSString *const kRecordStarResultRecordStar = @"recordStar";
NSString *const kRecordStarResultTimeStatus = @"TimeStatus";
NSString *const kRecordStarResultUserRecord = @"UserRecord";


@interface RecordStarResult ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation RecordStarResult

@synthesize theLatestRecord = _theLatestRecord;
@synthesize firstRecordAge = _firstRecordAge;
@synthesize babyBeforeRecord = _babyBeforeRecord;
@synthesize isSubmitRecord = _isSubmitRecord;
@synthesize showTime = _showTime;
@synthesize recordStar = _recordStar;
@synthesize timeStatus = _timeStatus;
@synthesize userRecord = _userRecord;


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
            self.theLatestRecord = [RecordStarTheLatestRecord modelObjectWithDictionary:[dict objectForKey:kRecordStarResultTheLatestRecord]];
            self.firstRecordAge = [RecordStarFirstRecordAge modelObjectWithDictionary:[dict objectForKey:kRecordStarResultFirstRecordAge]];
    NSObject *receivedRecordStarBabyBeforeRecord = [dict objectForKey:kRecordStarResultBabyBeforeRecord];
    NSMutableArray *parsedRecordStarBabyBeforeRecord = [NSMutableArray array];
    if ([receivedRecordStarBabyBeforeRecord isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedRecordStarBabyBeforeRecord) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedRecordStarBabyBeforeRecord addObject:[RecordStarBabyBeforeRecord modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedRecordStarBabyBeforeRecord isKindOfClass:[NSDictionary class]]) {
       [parsedRecordStarBabyBeforeRecord addObject:[RecordStarBabyBeforeRecord modelObjectWithDictionary:(NSDictionary *)receivedRecordStarBabyBeforeRecord]];
    }

    self.babyBeforeRecord = [NSArray arrayWithArray:parsedRecordStarBabyBeforeRecord];
            self.isSubmitRecord = [self objectOrNilForKey:kRecordStarResultIsSubmitRecord fromDictionary:dict];
            self.showTime = [self objectOrNilForKey:kRecordStarResultShowTime fromDictionary:dict];
    NSObject *receivedRecordStarRecordStar = [dict objectForKey:kRecordStarResultRecordStar];
    NSMutableArray *parsedRecordStarRecordStar = [NSMutableArray array];
    if ([receivedRecordStarRecordStar isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedRecordStarRecordStar) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedRecordStarRecordStar addObject:[RecordStarRecordStar modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedRecordStarRecordStar isKindOfClass:[NSDictionary class]]) {
       [parsedRecordStarRecordStar addObject:[RecordStarRecordStar modelObjectWithDictionary:(NSDictionary *)receivedRecordStarRecordStar]];
    }

    self.recordStar = [NSArray arrayWithArray:parsedRecordStarRecordStar];
            self.timeStatus = [[self objectOrNilForKey:kRecordStarResultTimeStatus fromDictionary:dict] doubleValue];
            self.userRecord = [RecordStarUserRecord modelObjectWithDictionary:[dict objectForKey:kRecordStarResultUserRecord]];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[self.theLatestRecord dictionaryRepresentation] forKey:kRecordStarResultTheLatestRecord];
    [mutableDict setValue:[self.firstRecordAge dictionaryRepresentation] forKey:kRecordStarResultFirstRecordAge];
    NSMutableArray *tempArrayForBabyBeforeRecord = [NSMutableArray array];
    for (NSObject *subArrayObject in self.babyBeforeRecord) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForBabyBeforeRecord addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForBabyBeforeRecord addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForBabyBeforeRecord] forKey:kRecordStarResultBabyBeforeRecord];
    [mutableDict setValue:self.isSubmitRecord forKey:kRecordStarResultIsSubmitRecord];
    [mutableDict setValue:self.showTime forKey:kRecordStarResultShowTime];
    NSMutableArray *tempArrayForRecordStar = [NSMutableArray array];
    for (NSObject *subArrayObject in self.recordStar) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForRecordStar addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForRecordStar addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForRecordStar] forKey:kRecordStarResultRecordStar];
    [mutableDict setValue:[NSNumber numberWithDouble:self.timeStatus] forKey:kRecordStarResultTimeStatus];
    [mutableDict setValue:[self.userRecord dictionaryRepresentation] forKey:kRecordStarResultUserRecord];

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

    self.theLatestRecord = [aDecoder decodeObjectForKey:kRecordStarResultTheLatestRecord];
    self.firstRecordAge = [aDecoder decodeObjectForKey:kRecordStarResultFirstRecordAge];
    self.babyBeforeRecord = [aDecoder decodeObjectForKey:kRecordStarResultBabyBeforeRecord];
    self.isSubmitRecord = [aDecoder decodeObjectForKey:kRecordStarResultIsSubmitRecord];
    self.showTime = [aDecoder decodeObjectForKey:kRecordStarResultShowTime];
    self.recordStar = [aDecoder decodeObjectForKey:kRecordStarResultRecordStar];
    self.timeStatus = [aDecoder decodeDoubleForKey:kRecordStarResultTimeStatus];
    self.userRecord = [aDecoder decodeObjectForKey:kRecordStarResultUserRecord];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_theLatestRecord forKey:kRecordStarResultTheLatestRecord];
    [aCoder encodeObject:_firstRecordAge forKey:kRecordStarResultFirstRecordAge];
    [aCoder encodeObject:_babyBeforeRecord forKey:kRecordStarResultBabyBeforeRecord];
    [aCoder encodeObject:_isSubmitRecord forKey:kRecordStarResultIsSubmitRecord];
    [aCoder encodeObject:_showTime forKey:kRecordStarResultShowTime];
    [aCoder encodeObject:_recordStar forKey:kRecordStarResultRecordStar];
    [aCoder encodeDouble:_timeStatus forKey:kRecordStarResultTimeStatus];
    [aCoder encodeObject:_userRecord forKey:kRecordStarResultUserRecord];
}

- (id)copyWithZone:(NSZone *)zone
{
    RecordStarResult *copy = [[RecordStarResult alloc] init];
    
    if (copy) {

        copy.theLatestRecord = [self.theLatestRecord copyWithZone:zone];
        copy.firstRecordAge = [self.firstRecordAge copyWithZone:zone];
        copy.babyBeforeRecord = [self.babyBeforeRecord copyWithZone:zone];
        copy.isSubmitRecord = [self.isSubmitRecord copyWithZone:zone];
        copy.showTime = [self.showTime copyWithZone:zone];
        copy.recordStar = [self.recordStar copyWithZone:zone];
        copy.timeStatus = self.timeStatus;
        copy.userRecord = [self.userRecord copyWithZone:zone];
    }
    
    return copy;
}


@end
