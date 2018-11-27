//
//  LoginObject.m
//
//  Created by   on 16/6/13
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "LoginObject.h"
#import "LoginResult.h"


NSString *const kLoginObjectResult = @"result";
NSString *const kLoginObjectErrorId = @"errorId";
NSString *const kLoginObjectServerTime = @"serverTime";


@interface LoginObject ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation LoginObject

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
            self.result = [LoginResult modelObjectWithDictionary:[dict objectForKey:kLoginObjectResult]];
            self.errorId = [[self objectOrNilForKey:kLoginObjectErrorId fromDictionary:dict] doubleValue];
            self.serverTime = [self objectOrNilForKey:kLoginObjectServerTime fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[self.result dictionaryRepresentation] forKey:kLoginObjectResult];
    [mutableDict setValue:[NSNumber numberWithDouble:self.errorId] forKey:kLoginObjectErrorId];
    [mutableDict setValue:self.serverTime forKey:kLoginObjectServerTime];

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

    self.result = [aDecoder decodeObjectForKey:kLoginObjectResult];
    self.errorId = [aDecoder decodeDoubleForKey:kLoginObjectErrorId];
    self.serverTime = [aDecoder decodeObjectForKey:kLoginObjectServerTime];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_result forKey:kLoginObjectResult];
    [aCoder encodeDouble:_errorId forKey:kLoginObjectErrorId];
    [aCoder encodeObject:_serverTime forKey:kLoginObjectServerTime];
}

- (id)copyWithZone:(NSZone *)zone
{
    LoginObject *copy = [[LoginObject alloc] init];
    
    if (copy) {

        copy.result = [self.result copyWithZone:zone];
        copy.errorId = self.errorId;
        copy.serverTime = [self.serverTime copyWithZone:zone];
    }
    
    return copy;
}


@end
