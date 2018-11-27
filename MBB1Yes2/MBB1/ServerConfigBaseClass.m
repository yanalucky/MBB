//
//  ServerConfigBaseClass.m
//
//  Created by  豆蒙萌 on 15/9/21
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "ServerConfigBaseClass.h"
#import "ServerConfigResult.h"


NSString *const kServerConfigBaseClassResult = @"result";
NSString *const kServerConfigBaseClassErrorId = @"errorId";
NSString *const kServerConfigBaseClassServerTime = @"serverTime";


@interface ServerConfigBaseClass ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ServerConfigBaseClass

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
            self.result = [ServerConfigResult modelObjectWithDictionary:[dict objectForKey:kServerConfigBaseClassResult]];
            self.errorId = [[self objectOrNilForKey:kServerConfigBaseClassErrorId fromDictionary:dict] doubleValue];
            self.serverTime = [self objectOrNilForKey:kServerConfigBaseClassServerTime fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[self.result dictionaryRepresentation] forKey:kServerConfigBaseClassResult];
    [mutableDict setValue:[NSNumber numberWithDouble:self.errorId] forKey:kServerConfigBaseClassErrorId];
    [mutableDict setValue:self.serverTime forKey:kServerConfigBaseClassServerTime];

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

    self.result = [aDecoder decodeObjectForKey:kServerConfigBaseClassResult];
    self.errorId = [aDecoder decodeDoubleForKey:kServerConfigBaseClassErrorId];
    self.serverTime = [aDecoder decodeObjectForKey:kServerConfigBaseClassServerTime];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_result forKey:kServerConfigBaseClassResult];
    [aCoder encodeDouble:_errorId forKey:kServerConfigBaseClassErrorId];
    [aCoder encodeObject:_serverTime forKey:kServerConfigBaseClassServerTime];
}

- (id)copyWithZone:(NSZone *)zone
{
    ServerConfigBaseClass *copy = [[ServerConfigBaseClass alloc] init];
    
    if (copy) {

        copy.result = [self.result copyWithZone:zone];
        copy.errorId = self.errorId;
        copy.serverTime = [self.serverTime copyWithZone:zone];
    }
    
    return copy;
}


@end
