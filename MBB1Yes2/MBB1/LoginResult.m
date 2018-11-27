//
//  LoginResult.m
//
//  Created by  豆蒙萌 on 15/9/21
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "LoginResult.h"
#import "LoginUser.h"


NSString *const kLoginResultUser = @"User";
NSString *const kLoginResultSessionId = @"SessionId";


@interface LoginResult ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation LoginResult

@synthesize user = _user;
@synthesize sessionId = _sessionId;


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
            self.user = [LoginUser modelObjectWithDictionary:[dict objectForKey:kLoginResultUser]];
            self.sessionId = [self objectOrNilForKey:kLoginResultSessionId fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[self.user dictionaryRepresentation] forKey:kLoginResultUser];
    [mutableDict setValue:self.sessionId forKey:kLoginResultSessionId];

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

    self.user = [aDecoder decodeObjectForKey:kLoginResultUser];
    self.sessionId = [aDecoder decodeObjectForKey:kLoginResultSessionId];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_user forKey:kLoginResultUser];
    [aCoder encodeObject:_sessionId forKey:kLoginResultSessionId];
}

- (id)copyWithZone:(NSZone *)zone
{
    LoginResult *copy = [[LoginResult alloc] init];
    
    if (copy) {

        copy.user = [self.user copyWithZone:zone];
        copy.sessionId = [self.sessionId copyWithZone:zone];
    }
    
    return copy;
}


@end
