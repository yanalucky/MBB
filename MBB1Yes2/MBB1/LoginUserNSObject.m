//
//  LoginUserNSObject.m
//
//  Created by  豆蒙萌 on 15/9/23
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "LoginUserNSObject.h"
#import "LoginUserResult.h"


NSString *const kLoginUserNSObjectResult = @"result";
NSString *const kLoginUserNSObjectErrorId = @"errorId";
NSString *const kLoginUserNSObjectServerTime = @"serverTime";


@interface LoginUserNSObject ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation LoginUserNSObject

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
            self.result = [LoginUserResult modelObjectWithDictionary:[dict objectForKey:kLoginUserNSObjectResult]];
            self.errorId = [[self objectOrNilForKey:kLoginUserNSObjectErrorId fromDictionary:dict] doubleValue];
            self.serverTime = [self objectOrNilForKey:kLoginUserNSObjectServerTime fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[self.result dictionaryRepresentation] forKey:kLoginUserNSObjectResult];
    [mutableDict setValue:[NSNumber numberWithDouble:self.errorId] forKey:kLoginUserNSObjectErrorId];
    [mutableDict setValue:self.serverTime forKey:kLoginUserNSObjectServerTime];

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

    self.result = [aDecoder decodeObjectForKey:kLoginUserNSObjectResult];
    self.errorId = [aDecoder decodeDoubleForKey:kLoginUserNSObjectErrorId];
    self.serverTime = [aDecoder decodeObjectForKey:kLoginUserNSObjectServerTime];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_result forKey:kLoginUserNSObjectResult];
    [aCoder encodeDouble:_errorId forKey:kLoginUserNSObjectErrorId];
    [aCoder encodeObject:_serverTime forKey:kLoginUserNSObjectServerTime];
}

- (id)copyWithZone:(NSZone *)zone
{
    LoginUserNSObject *copy = [[LoginUserNSObject alloc] init];
    
    if (copy) {

        copy.result = [self.result copyWithZone:zone];
        copy.errorId = self.errorId;
        copy.serverTime = [self.serverTime copyWithZone:zone];
    }
    
    return copy;
}


@end
