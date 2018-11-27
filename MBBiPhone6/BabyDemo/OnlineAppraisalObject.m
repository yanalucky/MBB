//
//  OnlineAppraisalObject.m
//
//  Created by   on 16/7/18
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "OnlineAppraisalObject.h"
#import "OnlineAppraisalResult.h"


NSString *const kOnlineAppraisalObjectResult = @"result";
NSString *const kOnlineAppraisalObjectErrorId = @"errorId";
NSString *const kOnlineAppraisalObjectServerTime = @"serverTime";


@interface OnlineAppraisalObject ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation OnlineAppraisalObject

@synthesize result = _result;
@synthesize errorId = _errorId;
@synthesize serverTime = _serverTime;


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
            self.result = [OnlineAppraisalResult modelObjectWithDictionary:[dict objectForKey:kOnlineAppraisalObjectResult]];
            self.errorId = [[self objectOrNilForKey:kOnlineAppraisalObjectErrorId fromDictionary:dict] doubleValue];
            self.serverTime = [self objectOrNilForKey:kOnlineAppraisalObjectServerTime fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[self.result dictionaryRepresentation] forKey:kOnlineAppraisalObjectResult];
    [mutableDict setValue:[NSNumber numberWithDouble:self.errorId] forKey:kOnlineAppraisalObjectErrorId];
    [mutableDict setValue:self.serverTime forKey:kOnlineAppraisalObjectServerTime];

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

    self.result = [aDecoder decodeObjectForKey:kOnlineAppraisalObjectResult];
    self.errorId = [aDecoder decodeDoubleForKey:kOnlineAppraisalObjectErrorId];
    self.serverTime = [aDecoder decodeObjectForKey:kOnlineAppraisalObjectServerTime];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_result forKey:kOnlineAppraisalObjectResult];
    [aCoder encodeDouble:_errorId forKey:kOnlineAppraisalObjectErrorId];
    [aCoder encodeObject:_serverTime forKey:kOnlineAppraisalObjectServerTime];
}

- (id)copyWithZone:(NSZone *)zone
{
    OnlineAppraisalObject *copy = [[OnlineAppraisalObject alloc] init];
    
    if (copy) {

        copy.result = [self.result copyWithZone:zone];
        copy.errorId = self.errorId;
        copy.serverTime = [self.serverTime copyWithZone:zone];
    }
    
    return copy;
}


@end
