//
//  LoginUserResult.m
//
//  Created by  豆蒙萌 on 15/10/14
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "LoginUserResult.h"
#import "LoginUserTreatBooking.h"
#import "LoginUserNurtureGuideList.h"
#import "LoginUserUserSalonList.h"
#import "LoginUserOnlineAppraisal.h"
#import "LoginUserBodycheckBooking.h"
#import "LoginUserSalonList.h"
#import "LoginUserUser.h"
#import "LoginUserBodycheckAppraisalList.h"
#import "LoginUserUserRecord.h"


NSString *const kLoginUserResultTreatBooking = @"TreatBooking";
NSString *const kLoginUserResultNurtureGuideList = @"NurtureGuideList";
NSString *const kLoginUserResultUserSalonList = @"UserSalonList";
NSString *const kLoginUserResultOnlineAppraisal = @"OnlineAppraisal";
NSString *const kLoginUserResultBodycheckBooking = @"BodycheckBooking";
NSString *const kLoginUserResultSalonList = @"SalonList";
NSString *const kLoginUserResultSessionId = @"SessionId";
NSString *const kLoginUserResultUser = @"User";
NSString *const kLoginUserResultBodycheckAppraisalList = @"BodycheckAppraisalList";
NSString *const kLoginUserResultUserRecord = @"UserRecord";


@interface LoginUserResult ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation LoginUserResult

@synthesize treatBooking = _treatBooking;
@synthesize nurtureGuideList = _nurtureGuideList;
@synthesize userSalonList = _userSalonList;
@synthesize onlineAppraisal = _onlineAppraisal;
@synthesize bodycheckBooking = _bodycheckBooking;
@synthesize salonList = _salonList;
@synthesize sessionId = _sessionId;
@synthesize user = _user;
@synthesize bodycheckAppraisalList = _bodycheckAppraisalList;
@synthesize userRecord = _userRecord;


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
            self.treatBooking = [LoginUserTreatBooking modelObjectWithDictionary:[dict objectForKey:kLoginUserResultTreatBooking]];
    NSObject *receivedLoginUserNurtureGuideList = [dict objectForKey:kLoginUserResultNurtureGuideList];
    NSMutableArray *parsedLoginUserNurtureGuideList = [NSMutableArray array];
    if ([receivedLoginUserNurtureGuideList isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedLoginUserNurtureGuideList) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedLoginUserNurtureGuideList addObject:[LoginUserNurtureGuideList modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedLoginUserNurtureGuideList isKindOfClass:[NSDictionary class]]) {
       [parsedLoginUserNurtureGuideList addObject:[LoginUserNurtureGuideList modelObjectWithDictionary:(NSDictionary *)receivedLoginUserNurtureGuideList]];
    }

    self.nurtureGuideList = [NSArray arrayWithArray:parsedLoginUserNurtureGuideList];
    NSObject *receivedLoginUserUserSalonList = [dict objectForKey:kLoginUserResultUserSalonList];
    NSMutableArray *parsedLoginUserUserSalonList = [NSMutableArray array];
    if ([receivedLoginUserUserSalonList isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedLoginUserUserSalonList) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedLoginUserUserSalonList addObject:[LoginUserUserSalonList modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedLoginUserUserSalonList isKindOfClass:[NSDictionary class]]) {
       [parsedLoginUserUserSalonList addObject:[LoginUserUserSalonList modelObjectWithDictionary:(NSDictionary *)receivedLoginUserUserSalonList]];
    }

    self.userSalonList = [NSArray arrayWithArray:parsedLoginUserUserSalonList];
            self.onlineAppraisal = [LoginUserOnlineAppraisal modelObjectWithDictionary:[dict objectForKey:kLoginUserResultOnlineAppraisal]];
            self.bodycheckBooking = [LoginUserBodycheckBooking modelObjectWithDictionary:[dict objectForKey:kLoginUserResultBodycheckBooking]];
    NSObject *receivedLoginUserSalonList = [dict objectForKey:kLoginUserResultSalonList];
    NSMutableArray *parsedLoginUserSalonList = [NSMutableArray array];
    if ([receivedLoginUserSalonList isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedLoginUserSalonList) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedLoginUserSalonList addObject:[LoginUserSalonList modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedLoginUserSalonList isKindOfClass:[NSDictionary class]]) {
       [parsedLoginUserSalonList addObject:[LoginUserSalonList modelObjectWithDictionary:(NSDictionary *)receivedLoginUserSalonList]];
    }

    self.salonList = [NSArray arrayWithArray:parsedLoginUserSalonList];
            self.sessionId = [self objectOrNilForKey:kLoginUserResultSessionId fromDictionary:dict];
            self.user = [LoginUserUser modelObjectWithDictionary:[dict objectForKey:kLoginUserResultUser]];
    NSObject *receivedLoginUserBodycheckAppraisalList = [dict objectForKey:kLoginUserResultBodycheckAppraisalList];
    NSMutableArray *parsedLoginUserBodycheckAppraisalList = [NSMutableArray array];
    if ([receivedLoginUserBodycheckAppraisalList isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedLoginUserBodycheckAppraisalList) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedLoginUserBodycheckAppraisalList addObject:[LoginUserBodycheckAppraisalList modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedLoginUserBodycheckAppraisalList isKindOfClass:[NSDictionary class]]) {
       [parsedLoginUserBodycheckAppraisalList addObject:[LoginUserBodycheckAppraisalList modelObjectWithDictionary:(NSDictionary *)receivedLoginUserBodycheckAppraisalList]];
    }

    self.bodycheckAppraisalList = [NSArray arrayWithArray:parsedLoginUserBodycheckAppraisalList];
            self.userRecord = [LoginUserUserRecord modelObjectWithDictionary:[dict objectForKey:kLoginUserResultUserRecord]];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[self.treatBooking dictionaryRepresentation] forKey:kLoginUserResultTreatBooking];
    NSMutableArray *tempArrayForNurtureGuideList = [NSMutableArray array];
    for (NSObject *subArrayObject in self.nurtureGuideList) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForNurtureGuideList addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForNurtureGuideList addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForNurtureGuideList] forKey:kLoginUserResultNurtureGuideList];
    NSMutableArray *tempArrayForUserSalonList = [NSMutableArray array];
    for (NSObject *subArrayObject in self.userSalonList) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForUserSalonList addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForUserSalonList addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForUserSalonList] forKey:kLoginUserResultUserSalonList];
    [mutableDict setValue:[self.onlineAppraisal dictionaryRepresentation] forKey:kLoginUserResultOnlineAppraisal];
    [mutableDict setValue:[self.bodycheckBooking dictionaryRepresentation] forKey:kLoginUserResultBodycheckBooking];
    NSMutableArray *tempArrayForSalonList = [NSMutableArray array];
    for (NSObject *subArrayObject in self.salonList) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForSalonList addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForSalonList addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForSalonList] forKey:kLoginUserResultSalonList];
    [mutableDict setValue:self.sessionId forKey:kLoginUserResultSessionId];
    [mutableDict setValue:[self.user dictionaryRepresentation] forKey:kLoginUserResultUser];
    NSMutableArray *tempArrayForBodycheckAppraisalList = [NSMutableArray array];
    for (NSObject *subArrayObject in self.bodycheckAppraisalList) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForBodycheckAppraisalList addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForBodycheckAppraisalList addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForBodycheckAppraisalList] forKey:kLoginUserResultBodycheckAppraisalList];
    [mutableDict setValue:[self.userRecord dictionaryRepresentation] forKey:kLoginUserResultUserRecord];

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

    self.treatBooking = [aDecoder decodeObjectForKey:kLoginUserResultTreatBooking];
    self.nurtureGuideList = [aDecoder decodeObjectForKey:kLoginUserResultNurtureGuideList];
    self.userSalonList = [aDecoder decodeObjectForKey:kLoginUserResultUserSalonList];
    self.onlineAppraisal = [aDecoder decodeObjectForKey:kLoginUserResultOnlineAppraisal];
    self.bodycheckBooking = [aDecoder decodeObjectForKey:kLoginUserResultBodycheckBooking];
    self.salonList = [aDecoder decodeObjectForKey:kLoginUserResultSalonList];
    self.sessionId = [aDecoder decodeObjectForKey:kLoginUserResultSessionId];
    self.user = [aDecoder decodeObjectForKey:kLoginUserResultUser];
    self.bodycheckAppraisalList = [aDecoder decodeObjectForKey:kLoginUserResultBodycheckAppraisalList];
    self.userRecord = [aDecoder decodeObjectForKey:kLoginUserResultUserRecord];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_treatBooking forKey:kLoginUserResultTreatBooking];
    [aCoder encodeObject:_nurtureGuideList forKey:kLoginUserResultNurtureGuideList];
    [aCoder encodeObject:_userSalonList forKey:kLoginUserResultUserSalonList];
    [aCoder encodeObject:_onlineAppraisal forKey:kLoginUserResultOnlineAppraisal];
    [aCoder encodeObject:_bodycheckBooking forKey:kLoginUserResultBodycheckBooking];
    [aCoder encodeObject:_salonList forKey:kLoginUserResultSalonList];
    [aCoder encodeObject:_sessionId forKey:kLoginUserResultSessionId];
    [aCoder encodeObject:_user forKey:kLoginUserResultUser];
    [aCoder encodeObject:_bodycheckAppraisalList forKey:kLoginUserResultBodycheckAppraisalList];
    [aCoder encodeObject:_userRecord forKey:kLoginUserResultUserRecord];
}

- (id)copyWithZone:(NSZone *)zone
{
    LoginUserResult *copy = [[LoginUserResult alloc] init];
    
    if (copy) {

        copy.treatBooking = [self.treatBooking copyWithZone:zone];
        copy.nurtureGuideList = [self.nurtureGuideList copyWithZone:zone];
        copy.userSalonList = [self.userSalonList copyWithZone:zone];
        copy.onlineAppraisal = [self.onlineAppraisal copyWithZone:zone];
        copy.bodycheckBooking = [self.bodycheckBooking copyWithZone:zone];
        copy.salonList = [self.salonList copyWithZone:zone];
        copy.sessionId = [self.sessionId copyWithZone:zone];
        copy.user = [self.user copyWithZone:zone];
        copy.bodycheckAppraisalList = [self.bodycheckAppraisalList copyWithZone:zone];
        copy.userRecord = [self.userRecord copyWithZone:zone];
    }
    
    return copy;
}


@end
