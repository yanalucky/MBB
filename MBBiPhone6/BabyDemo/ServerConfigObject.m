//
//  ServerConfigObject.m
//
//  Created by   on 16/6/21
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "ServerConfigObject.h"
#import "ServerConfigResult.h"


NSString *const kServerConfigObjectResult = @"result";
NSString *const kServerConfigObjectErrorId = @"errorId";
NSString *const kServerConfigObjectServerTime = @"serverTime";


@interface ServerConfigObject ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ServerConfigObject

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
            self.result = [ServerConfigResult modelObjectWithDictionary:[dict objectForKey:kServerConfigObjectResult]];
            self.errorId = [[self objectOrNilForKey:kServerConfigObjectErrorId fromDictionary:dict] doubleValue];
            self.serverTime = [self objectOrNilForKey:kServerConfigObjectServerTime fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[self.result dictionaryRepresentation] forKey:kServerConfigObjectResult];
    [mutableDict setValue:[NSNumber numberWithDouble:self.errorId] forKey:kServerConfigObjectErrorId];
    [mutableDict setValue:self.serverTime forKey:kServerConfigObjectServerTime];

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

    self.result = [aDecoder decodeObjectForKey:kServerConfigObjectResult];
    self.errorId = [aDecoder decodeDoubleForKey:kServerConfigObjectErrorId];
    self.serverTime = [aDecoder decodeObjectForKey:kServerConfigObjectServerTime];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_result forKey:kServerConfigObjectResult];
    [aCoder encodeDouble:_errorId forKey:kServerConfigObjectErrorId];
    [aCoder encodeObject:_serverTime forKey:kServerConfigObjectServerTime];
}

- (id)copyWithZone:(NSZone *)zone
{
    ServerConfigObject *copy = [[ServerConfigObject alloc] init];
    
    if (copy) {

        copy.result = [self.result copyWithZone:zone];
        copy.errorId = self.errorId;
        copy.serverTime = [self.serverTime copyWithZone:zone];
    }
    
    return copy;
}


@end
