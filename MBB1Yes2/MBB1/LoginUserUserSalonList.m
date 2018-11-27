//
//  LoginUserUserSalonList.m
//
//  Created by  豆蒙萌 on 15/9/23
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "LoginUserUserSalonList.h"


NSString *const kLoginUserUserSalonListId = @"id";
NSString *const kLoginUserUserSalonListUserid = @"userid";
NSString *const kLoginUserUserSalonListSalonid = @"salonid";
NSString *const kLoginUserUserSalonListSignuptime = @"signuptime";
NSString *const kLoginUserUserSalonListIsconfirm = @"isconfirm";


@interface LoginUserUserSalonList ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation LoginUserUserSalonList

@synthesize userSalonListIdentifier = _userSalonListIdentifier;
@synthesize userid = _userid;
@synthesize salonid = _salonid;
@synthesize signuptime = _signuptime;
@synthesize isconfirm = _isconfirm;


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
            self.userSalonListIdentifier = [self objectOrNilForKey:kLoginUserUserSalonListId fromDictionary:dict];
            self.userid = [self objectOrNilForKey:kLoginUserUserSalonListUserid fromDictionary:dict];
            self.salonid = [self objectOrNilForKey:kLoginUserUserSalonListSalonid fromDictionary:dict];
            self.signuptime = [self objectOrNilForKey:kLoginUserUserSalonListSignuptime fromDictionary:dict];
            self.isconfirm = [self objectOrNilForKey:kLoginUserUserSalonListIsconfirm fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.userSalonListIdentifier forKey:kLoginUserUserSalonListId];
    [mutableDict setValue:self.userid forKey:kLoginUserUserSalonListUserid];
    [mutableDict setValue:self.salonid forKey:kLoginUserUserSalonListSalonid];
    [mutableDict setValue:self.signuptime forKey:kLoginUserUserSalonListSignuptime];
    [mutableDict setValue:self.isconfirm forKey:kLoginUserUserSalonListIsconfirm];

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

    self.userSalonListIdentifier = [aDecoder decodeObjectForKey:kLoginUserUserSalonListId];
    self.userid = [aDecoder decodeObjectForKey:kLoginUserUserSalonListUserid];
    self.salonid = [aDecoder decodeObjectForKey:kLoginUserUserSalonListSalonid];
    self.signuptime = [aDecoder decodeObjectForKey:kLoginUserUserSalonListSignuptime];
    self.isconfirm = [aDecoder decodeObjectForKey:kLoginUserUserSalonListIsconfirm];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_userSalonListIdentifier forKey:kLoginUserUserSalonListId];
    [aCoder encodeObject:_userid forKey:kLoginUserUserSalonListUserid];
    [aCoder encodeObject:_salonid forKey:kLoginUserUserSalonListSalonid];
    [aCoder encodeObject:_signuptime forKey:kLoginUserUserSalonListSignuptime];
    [aCoder encodeObject:_isconfirm forKey:kLoginUserUserSalonListIsconfirm];
}

- (id)copyWithZone:(NSZone *)zone
{
    LoginUserUserSalonList *copy = [[LoginUserUserSalonList alloc] init];
    
    if (copy) {

        copy.userSalonListIdentifier = [self.userSalonListIdentifier copyWithZone:zone];
        copy.userid = [self.userid copyWithZone:zone];
        copy.salonid = [self.salonid copyWithZone:zone];
        copy.signuptime = [self.signuptime copyWithZone:zone];
        copy.isconfirm = [self.isconfirm copyWithZone:zone];
    }
    
    return copy;
}


@end
