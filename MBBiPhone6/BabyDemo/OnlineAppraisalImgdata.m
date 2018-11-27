//
//  OnlineAppraisalImgdata.m
//
//  Created by   on 16/7/18
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "OnlineAppraisalImgdata.h"


NSString *const kOnlineAppraisalImgdataAge = @"age";
NSString *const kOnlineAppraisalImgdataMonthDay = @"monthDay";
NSString *const kOnlineAppraisalImgdataWeight = @"weight";
NSString *const kOnlineAppraisalImgdataHeight = @"height";
NSString *const kOnlineAppraisalImgdataSubmitTime = @"submitTime";


@interface OnlineAppraisalImgdata ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation OnlineAppraisalImgdata

@synthesize age = _age;
@synthesize monthDay = _monthDay;
@synthesize weight = _weight;
@synthesize height = _height;
@synthesize submitTime = _submitTime;


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
            self.age = [[self objectOrNilForKey:kOnlineAppraisalImgdataAge fromDictionary:dict] doubleValue];
            self.monthDay = [[self objectOrNilForKey:kOnlineAppraisalImgdataMonthDay fromDictionary:dict] doubleValue];
            self.weight = [self objectOrNilForKey:kOnlineAppraisalImgdataWeight fromDictionary:dict];
            self.height = [self objectOrNilForKey:kOnlineAppraisalImgdataHeight fromDictionary:dict];
            self.submitTime = [self objectOrNilForKey:kOnlineAppraisalImgdataSubmitTime fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.age] forKey:kOnlineAppraisalImgdataAge];
    [mutableDict setValue:[NSNumber numberWithDouble:self.monthDay] forKey:kOnlineAppraisalImgdataMonthDay];
    [mutableDict setValue:self.weight forKey:kOnlineAppraisalImgdataWeight];
    [mutableDict setValue:self.height forKey:kOnlineAppraisalImgdataHeight];
    [mutableDict setValue:self.submitTime forKey:kOnlineAppraisalImgdataSubmitTime];

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

    self.age = [aDecoder decodeDoubleForKey:kOnlineAppraisalImgdataAge];
    self.monthDay = [aDecoder decodeDoubleForKey:kOnlineAppraisalImgdataMonthDay];
    self.weight = [aDecoder decodeObjectForKey:kOnlineAppraisalImgdataWeight];
    self.height = [aDecoder decodeObjectForKey:kOnlineAppraisalImgdataHeight];
    self.submitTime = [aDecoder decodeObjectForKey:kOnlineAppraisalImgdataSubmitTime];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_age forKey:kOnlineAppraisalImgdataAge];
    [aCoder encodeDouble:_monthDay forKey:kOnlineAppraisalImgdataMonthDay];
    [aCoder encodeObject:_weight forKey:kOnlineAppraisalImgdataWeight];
    [aCoder encodeObject:_height forKey:kOnlineAppraisalImgdataHeight];
    [aCoder encodeObject:_submitTime forKey:kOnlineAppraisalImgdataSubmitTime];
}

- (id)copyWithZone:(NSZone *)zone
{
    OnlineAppraisalImgdata *copy = [[OnlineAppraisalImgdata alloc] init];
    
    if (copy) {

        copy.age = self.age;
        copy.monthDay = self.monthDay;
        copy.weight = [self.weight copyWithZone:zone];
        copy.height = [self.height copyWithZone:zone];
        copy.submitTime = [self.submitTime copyWithZone:zone];
    }
    
    return copy;
}


@end
