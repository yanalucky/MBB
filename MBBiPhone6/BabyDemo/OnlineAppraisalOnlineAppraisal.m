//
//  OnlineAppraisalOnlineAppraisal.m
//
//  Created by   on 16/7/18
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "OnlineAppraisalOnlineAppraisal.h"


NSString *const kOnlineAppraisalOnlineAppraisalAppraisaltime = @"appraisaltime";
NSString *const kOnlineAppraisalOnlineAppraisalUserid = @"userid";
NSString *const kOnlineAppraisalOnlineAppraisalFeature = @"feature";
NSString *const kOnlineAppraisalOnlineAppraisalStar = @"star";
NSString *const kOnlineAppraisalOnlineAppraisalOnlineid = @"onlineid";
NSString *const kOnlineAppraisalOnlineAppraisalAppraisalage = @"appraisalage";
NSString *const kOnlineAppraisalOnlineAppraisalFeedingType = @"feedingType";
NSString *const kOnlineAppraisalOnlineAppraisalAppraisalstatus = @"appraisalstatus";
NSString *const kOnlineAppraisalOnlineAppraisalFeedingtype = @"feedingtype";
NSString *const kOnlineAppraisalOnlineAppraisalDoctorid = @"doctorid";
NSString *const kOnlineAppraisalOnlineAppraisalMonthAge = @"monthAge";
NSString *const kOnlineAppraisalOnlineAppraisalGrowthappraisal = @"growthappraisal";
NSString *const kOnlineAppraisalOnlineAppraisalMindappraisal = @"mindappraisal";
NSString *const kOnlineAppraisalOnlineAppraisalRecordid = @"recordid";


@interface OnlineAppraisalOnlineAppraisal ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation OnlineAppraisalOnlineAppraisal

@synthesize appraisaltime = _appraisaltime;
@synthesize userid = _userid;
@synthesize feature = _feature;
@synthesize star = _star;
@synthesize onlineid = _onlineid;
@synthesize appraisalage = _appraisalage;
@synthesize feedingType = _feedingType;
@synthesize appraisalstatus = _appraisalstatus;
@synthesize feedingtype = _feedingtype;
@synthesize doctorid = _doctorid;
@synthesize monthAge = _monthAge;
@synthesize growthappraisal = _growthappraisal;
@synthesize mindappraisal = _mindappraisal;
@synthesize recordid = _recordid;


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
            self.appraisaltime = [self objectOrNilForKey:kOnlineAppraisalOnlineAppraisalAppraisaltime fromDictionary:dict];
            self.userid = [self objectOrNilForKey:kOnlineAppraisalOnlineAppraisalUserid fromDictionary:dict];
            self.feature = [self objectOrNilForKey:kOnlineAppraisalOnlineAppraisalFeature fromDictionary:dict];
            self.star = [self objectOrNilForKey:kOnlineAppraisalOnlineAppraisalStar fromDictionary:dict];
            self.onlineid = [self objectOrNilForKey:kOnlineAppraisalOnlineAppraisalOnlineid fromDictionary:dict];
            self.appraisalage = [self objectOrNilForKey:kOnlineAppraisalOnlineAppraisalAppraisalage fromDictionary:dict];
            self.feedingType = [[self objectOrNilForKey:kOnlineAppraisalOnlineAppraisalFeedingType fromDictionary:dict] doubleValue];
            self.appraisalstatus = [self objectOrNilForKey:kOnlineAppraisalOnlineAppraisalAppraisalstatus fromDictionary:dict];
            self.feedingtype = [self objectOrNilForKey:kOnlineAppraisalOnlineAppraisalFeedingtype fromDictionary:dict];
            self.doctorid = [self objectOrNilForKey:kOnlineAppraisalOnlineAppraisalDoctorid fromDictionary:dict];
            self.monthAge = [self objectOrNilForKey:kOnlineAppraisalOnlineAppraisalMonthAge fromDictionary:dict];
            self.growthappraisal = [self objectOrNilForKey:kOnlineAppraisalOnlineAppraisalGrowthappraisal fromDictionary:dict];
            self.mindappraisal = [self objectOrNilForKey:kOnlineAppraisalOnlineAppraisalMindappraisal fromDictionary:dict];
            self.recordid = [self objectOrNilForKey:kOnlineAppraisalOnlineAppraisalRecordid fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.appraisaltime forKey:kOnlineAppraisalOnlineAppraisalAppraisaltime];
    [mutableDict setValue:self.userid forKey:kOnlineAppraisalOnlineAppraisalUserid];
    [mutableDict setValue:self.feature forKey:kOnlineAppraisalOnlineAppraisalFeature];
    [mutableDict setValue:self.star forKey:kOnlineAppraisalOnlineAppraisalStar];
    [mutableDict setValue:self.onlineid forKey:kOnlineAppraisalOnlineAppraisalOnlineid];
    [mutableDict setValue:self.appraisalage forKey:kOnlineAppraisalOnlineAppraisalAppraisalage];
    [mutableDict setValue:[NSNumber numberWithDouble:self.feedingType] forKey:kOnlineAppraisalOnlineAppraisalFeedingType];
    [mutableDict setValue:self.appraisalstatus forKey:kOnlineAppraisalOnlineAppraisalAppraisalstatus];
    [mutableDict setValue:self.feedingtype forKey:kOnlineAppraisalOnlineAppraisalFeedingtype];
    [mutableDict setValue:self.doctorid forKey:kOnlineAppraisalOnlineAppraisalDoctorid];
    [mutableDict setValue:self.monthAge forKey:kOnlineAppraisalOnlineAppraisalMonthAge];
    [mutableDict setValue:self.growthappraisal forKey:kOnlineAppraisalOnlineAppraisalGrowthappraisal];
    [mutableDict setValue:self.mindappraisal forKey:kOnlineAppraisalOnlineAppraisalMindappraisal];
    [mutableDict setValue:self.recordid forKey:kOnlineAppraisalOnlineAppraisalRecordid];

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

    self.appraisaltime = [aDecoder decodeObjectForKey:kOnlineAppraisalOnlineAppraisalAppraisaltime];
    self.userid = [aDecoder decodeObjectForKey:kOnlineAppraisalOnlineAppraisalUserid];
    self.feature = [aDecoder decodeObjectForKey:kOnlineAppraisalOnlineAppraisalFeature];
    self.star = [aDecoder decodeObjectForKey:kOnlineAppraisalOnlineAppraisalStar];
    self.onlineid = [aDecoder decodeObjectForKey:kOnlineAppraisalOnlineAppraisalOnlineid];
    self.appraisalage = [aDecoder decodeObjectForKey:kOnlineAppraisalOnlineAppraisalAppraisalage];
    self.feedingType = [aDecoder decodeDoubleForKey:kOnlineAppraisalOnlineAppraisalFeedingType];
    self.appraisalstatus = [aDecoder decodeObjectForKey:kOnlineAppraisalOnlineAppraisalAppraisalstatus];
    self.feedingtype = [aDecoder decodeObjectForKey:kOnlineAppraisalOnlineAppraisalFeedingtype];
    self.doctorid = [aDecoder decodeObjectForKey:kOnlineAppraisalOnlineAppraisalDoctorid];
    self.monthAge = [aDecoder decodeObjectForKey:kOnlineAppraisalOnlineAppraisalMonthAge];
    self.growthappraisal = [aDecoder decodeObjectForKey:kOnlineAppraisalOnlineAppraisalGrowthappraisal];
    self.mindappraisal = [aDecoder decodeObjectForKey:kOnlineAppraisalOnlineAppraisalMindappraisal];
    self.recordid = [aDecoder decodeObjectForKey:kOnlineAppraisalOnlineAppraisalRecordid];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_appraisaltime forKey:kOnlineAppraisalOnlineAppraisalAppraisaltime];
    [aCoder encodeObject:_userid forKey:kOnlineAppraisalOnlineAppraisalUserid];
    [aCoder encodeObject:_feature forKey:kOnlineAppraisalOnlineAppraisalFeature];
    [aCoder encodeObject:_star forKey:kOnlineAppraisalOnlineAppraisalStar];
    [aCoder encodeObject:_onlineid forKey:kOnlineAppraisalOnlineAppraisalOnlineid];
    [aCoder encodeObject:_appraisalage forKey:kOnlineAppraisalOnlineAppraisalAppraisalage];
    [aCoder encodeDouble:_feedingType forKey:kOnlineAppraisalOnlineAppraisalFeedingType];
    [aCoder encodeObject:_appraisalstatus forKey:kOnlineAppraisalOnlineAppraisalAppraisalstatus];
    [aCoder encodeObject:_feedingtype forKey:kOnlineAppraisalOnlineAppraisalFeedingtype];
    [aCoder encodeObject:_doctorid forKey:kOnlineAppraisalOnlineAppraisalDoctorid];
    [aCoder encodeObject:_monthAge forKey:kOnlineAppraisalOnlineAppraisalMonthAge];
    [aCoder encodeObject:_growthappraisal forKey:kOnlineAppraisalOnlineAppraisalGrowthappraisal];
    [aCoder encodeObject:_mindappraisal forKey:kOnlineAppraisalOnlineAppraisalMindappraisal];
    [aCoder encodeObject:_recordid forKey:kOnlineAppraisalOnlineAppraisalRecordid];
}

- (id)copyWithZone:(NSZone *)zone
{
    OnlineAppraisalOnlineAppraisal *copy = [[OnlineAppraisalOnlineAppraisal alloc] init];
    
    if (copy) {

        copy.appraisaltime = [self.appraisaltime copyWithZone:zone];
        copy.userid = [self.userid copyWithZone:zone];
        copy.feature = [self.feature copyWithZone:zone];
        copy.star = [self.star copyWithZone:zone];
        copy.onlineid = [self.onlineid copyWithZone:zone];
        copy.appraisalage = [self.appraisalage copyWithZone:zone];
        copy.feedingType = self.feedingType;
        copy.appraisalstatus = [self.appraisalstatus copyWithZone:zone];
        copy.feedingtype = [self.feedingtype copyWithZone:zone];
        copy.doctorid = [self.doctorid copyWithZone:zone];
        copy.monthAge = [self.monthAge copyWithZone:zone];
        copy.growthappraisal = [self.growthappraisal copyWithZone:zone];
        copy.mindappraisal = [self.mindappraisal copyWithZone:zone];
        copy.recordid = [self.recordid copyWithZone:zone];
    }
    
    return copy;
}


@end
