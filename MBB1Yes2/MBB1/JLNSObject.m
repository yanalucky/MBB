//
//  JLNSObject.m
//
//  Created by  豆蒙萌 on 15/10/16
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "JLNSObject.h"
#import "JLResult.h"


NSString *const kJLNSObjectResult = @"result";
NSString *const kJLNSObjectErrorId = @"errorId";
NSString *const kJLNSObjectServerTime = @"serverTime";


@interface JLNSObject ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation JLNSObject

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
            self.result = [JLResult modelObjectWithDictionary:[dict objectForKey:kJLNSObjectResult]];
            self.errorId = [[self objectOrNilForKey:kJLNSObjectErrorId fromDictionary:dict] doubleValue];
            self.serverTime = [self objectOrNilForKey:kJLNSObjectServerTime fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[self.result dictionaryRepresentation] forKey:kJLNSObjectResult];
    [mutableDict setValue:[NSNumber numberWithDouble:self.errorId] forKey:kJLNSObjectErrorId];
    [mutableDict setValue:self.serverTime forKey:kJLNSObjectServerTime];

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

    self.result = [aDecoder decodeObjectForKey:kJLNSObjectResult];
    self.errorId = [aDecoder decodeDoubleForKey:kJLNSObjectErrorId];
    self.serverTime = [aDecoder decodeObjectForKey:kJLNSObjectServerTime];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_result forKey:kJLNSObjectResult];
    [aCoder encodeDouble:_errorId forKey:kJLNSObjectErrorId];
    [aCoder encodeObject:_serverTime forKey:kJLNSObjectServerTime];
}

- (id)copyWithZone:(NSZone *)zone
{
    JLNSObject *copy = [[JLNSObject alloc] init];
    
    if (copy) {

        copy.result = [self.result copyWithZone:zone];
        copy.errorId = self.errorId;
        copy.serverTime = [self.serverTime copyWithZone:zone];
    }
    
    return copy;
}


@end
