//
//  LoginResult.m
//
//  Created by   on 16/6/13
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "LoginResult.h"
#import "LoginUser.h"


NSString *const kLoginResultBirthdayError = @"birthdayError";
NSString *const kLoginResultMenuid = @"menuid";
NSString *const kLoginResultUserRole = @"userRole";
NSString *const kLoginResultUser = @"User";
NSString *const kLoginResultSessionId = @"SessionId";


@interface LoginResult ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation LoginResult

@synthesize birthdayError = _birthdayError;
@synthesize menuid = _menuid;
@synthesize userRole = _userRole;
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
            self.birthdayError = [self objectOrNilForKey:kLoginResultBirthdayError fromDictionary:dict];
            self.menuid = [self objectOrNilForKey:kLoginResultMenuid fromDictionary:dict];
            self.userRole = [self objectOrNilForKey:kLoginResultUserRole fromDictionary:dict];
            self.user = [LoginUser modelObjectWithDictionary:[dict objectForKey:kLoginResultUser]];
            self.sessionId = [self objectOrNilForKey:kLoginResultSessionId fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.birthdayError forKey:kLoginResultBirthdayError];
    [mutableDict setValue:self.menuid forKey:kLoginResultMenuid];
    [mutableDict setValue:self.userRole forKey:kLoginResultUserRole];
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

    self.birthdayError = [aDecoder decodeObjectForKey:kLoginResultBirthdayError];
    self.menuid = [aDecoder decodeObjectForKey:kLoginResultMenuid];
    self.userRole = [aDecoder decodeObjectForKey:kLoginResultUserRole];
    self.user = [aDecoder decodeObjectForKey:kLoginResultUser];
    self.sessionId = [aDecoder decodeObjectForKey:kLoginResultSessionId];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_birthdayError forKey:kLoginResultBirthdayError];
    [aCoder encodeObject:_menuid forKey:kLoginResultMenuid];
    [aCoder encodeObject:_userRole forKey:kLoginResultUserRole];
    [aCoder encodeObject:_user forKey:kLoginResultUser];
    [aCoder encodeObject:_sessionId forKey:kLoginResultSessionId];
}

- (id)copyWithZone:(NSZone *)zone
{
    LoginResult *copy = [[LoginResult alloc] init];
    
    if (copy) {

        copy.birthdayError = [self.birthdayError copyWithZone:zone];
        copy.menuid = [self.menuid copyWithZone:zone];
        copy.userRole = [self.userRole copyWithZone:zone];
        copy.user = [self.user copyWithZone:zone];
        copy.sessionId = [self.sessionId copyWithZone:zone];
    }
    
    return copy;
}


@end
