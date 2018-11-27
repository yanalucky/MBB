//
//  JLResult.m
//
//  Created by  豆蒙萌 on 15/10/21
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "JLResult.h"
#import "JLUserRecord.h"
#import "JLUser.h"


NSString *const kJLResultUserRecord = @"UserRecord";
NSString *const kJLResultShowTime = @"ShowTime";
NSString *const kJLResultUser = @"User";
NSString *const kJLResultSessionId = @"SessionId";


@interface JLResult ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation JLResult

@synthesize userRecord = _userRecord;
@synthesize showTime = _showTime;
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
            self.userRecord = [JLUserRecord modelObjectWithDictionary:[dict objectForKey:kJLResultUserRecord]];
            self.showTime = [self objectOrNilForKey:kJLResultShowTime fromDictionary:dict];
            self.user = [JLUser modelObjectWithDictionary:[dict objectForKey:kJLResultUser]];
            self.sessionId = [self objectOrNilForKey:kJLResultSessionId fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[self.userRecord dictionaryRepresentation] forKey:kJLResultUserRecord];
    [mutableDict setValue:self.showTime forKey:kJLResultShowTime];
    [mutableDict setValue:[self.user dictionaryRepresentation] forKey:kJLResultUser];
    [mutableDict setValue:self.sessionId forKey:kJLResultSessionId];

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

    self.userRecord = [aDecoder decodeObjectForKey:kJLResultUserRecord];
    self.showTime = [aDecoder decodeObjectForKey:kJLResultShowTime];
    self.user = [aDecoder decodeObjectForKey:kJLResultUser];
    self.sessionId = [aDecoder decodeObjectForKey:kJLResultSessionId];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_userRecord forKey:kJLResultUserRecord];
    [aCoder encodeObject:_showTime forKey:kJLResultShowTime];
    [aCoder encodeObject:_user forKey:kJLResultUser];
    [aCoder encodeObject:_sessionId forKey:kJLResultSessionId];
}

- (id)copyWithZone:(NSZone *)zone
{
    JLResult *copy = [[JLResult alloc] init];
    
    if (copy) {

        copy.userRecord = [self.userRecord copyWithZone:zone];
        copy.showTime = [self.showTime copyWithZone:zone];
        copy.user = [self.user copyWithZone:zone];
        copy.sessionId = [self.sessionId copyWithZone:zone];
    }
    
    return copy;
}


@end
