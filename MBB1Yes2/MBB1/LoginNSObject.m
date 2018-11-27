//
//  LoginNSObject.m
//
//  Created by  豆蒙萌 on 15/9/21
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "LoginNSObject.h"
#import "LoginResult.h"


NSString *const kLoginNSObjectResult = @"result";
NSString *const kLoginNSObjectErrorId = @"errorId";
NSString *const kLoginNSObjectServerTime = @"serverTime";


@interface LoginNSObject ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation LoginNSObject

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
            self.result = [LoginResult modelObjectWithDictionary:[dict objectForKey:kLoginNSObjectResult]];
            self.errorId = [[self objectOrNilForKey:kLoginNSObjectErrorId fromDictionary:dict] doubleValue];
            self.serverTime = [self objectOrNilForKey:kLoginNSObjectServerTime fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[self.result dictionaryRepresentation] forKey:kLoginNSObjectResult];
    [mutableDict setValue:[NSNumber numberWithDouble:self.errorId] forKey:kLoginNSObjectErrorId];
    [mutableDict setValue:self.serverTime forKey:kLoginNSObjectServerTime];

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

    self.result = [aDecoder decodeObjectForKey:kLoginNSObjectResult];
    self.errorId = [aDecoder decodeDoubleForKey:kLoginNSObjectErrorId];
    self.serverTime = [aDecoder decodeObjectForKey:kLoginNSObjectServerTime];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_result forKey:kLoginNSObjectResult];
    [aCoder encodeDouble:_errorId forKey:kLoginNSObjectErrorId];
    [aCoder encodeObject:_serverTime forKey:kLoginNSObjectServerTime];
}

- (id)copyWithZone:(NSZone *)zone
{
    LoginNSObject *copy = [[LoginNSObject alloc] init];
    
    if (copy) {

        copy.result = [self.result copyWithZone:zone];
        copy.errorId = self.errorId;
        copy.serverTime = [self.serverTime copyWithZone:zone];
    }
    
    return copy;
}


@end
