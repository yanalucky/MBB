//
//  NurtureGuideObject.m
//
//  Created by   on 16/5/17
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "NurtureGuideObject.h"
#import "NurtureGuideResult.h"


NSString *const kNurtureGuideObjectResult = @"result";
NSString *const kNurtureGuideObjectErrorId = @"errorId";
NSString *const kNurtureGuideObjectServerTime = @"serverTime";


@interface NurtureGuideObject ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation NurtureGuideObject

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
            self.result = [NurtureGuideResult modelObjectWithDictionary:[dict objectForKey:kNurtureGuideObjectResult]];
            self.errorId = [[self objectOrNilForKey:kNurtureGuideObjectErrorId fromDictionary:dict] doubleValue];
            self.serverTime = [self objectOrNilForKey:kNurtureGuideObjectServerTime fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[self.result dictionaryRepresentation] forKey:kNurtureGuideObjectResult];
    [mutableDict setValue:[NSNumber numberWithDouble:self.errorId] forKey:kNurtureGuideObjectErrorId];
    [mutableDict setValue:self.serverTime forKey:kNurtureGuideObjectServerTime];

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

    self.result = [aDecoder decodeObjectForKey:kNurtureGuideObjectResult];
    self.errorId = [aDecoder decodeDoubleForKey:kNurtureGuideObjectErrorId];
    self.serverTime = [aDecoder decodeObjectForKey:kNurtureGuideObjectServerTime];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_result forKey:kNurtureGuideObjectResult];
    [aCoder encodeDouble:_errorId forKey:kNurtureGuideObjectErrorId];
    [aCoder encodeObject:_serverTime forKey:kNurtureGuideObjectServerTime];
}

- (id)copyWithZone:(NSZone *)zone
{
    NurtureGuideObject *copy = [[NurtureGuideObject alloc] init];
    
    if (copy) {

        copy.result = [self.result copyWithZone:zone];
        copy.errorId = self.errorId;
        copy.serverTime = [self.serverTime copyWithZone:zone];
    }
    
    return copy;
}


@end
