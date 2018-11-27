//
//  FeedbackNSObject.m
//
//  Created by  豆蒙萌 on 15/10/29
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "FeedbackNSObject.h"
#import "FeedbackResult.h"


NSString *const kFeedbackNSObjectResult = @"result";
NSString *const kFeedbackNSObjectErrorId = @"errorId";
NSString *const kFeedbackNSObjectServerTime = @"serverTime";


@interface FeedbackNSObject ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation FeedbackNSObject

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
            self.result = [FeedbackResult modelObjectWithDictionary:[dict objectForKey:kFeedbackNSObjectResult]];
            self.errorId = [[self objectOrNilForKey:kFeedbackNSObjectErrorId fromDictionary:dict] doubleValue];
            self.serverTime = [self objectOrNilForKey:kFeedbackNSObjectServerTime fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[self.result dictionaryRepresentation] forKey:kFeedbackNSObjectResult];
    [mutableDict setValue:[NSNumber numberWithDouble:self.errorId] forKey:kFeedbackNSObjectErrorId];
    [mutableDict setValue:self.serverTime forKey:kFeedbackNSObjectServerTime];

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

    self.result = [aDecoder decodeObjectForKey:kFeedbackNSObjectResult];
    self.errorId = [aDecoder decodeDoubleForKey:kFeedbackNSObjectErrorId];
    self.serverTime = [aDecoder decodeObjectForKey:kFeedbackNSObjectServerTime];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_result forKey:kFeedbackNSObjectResult];
    [aCoder encodeDouble:_errorId forKey:kFeedbackNSObjectErrorId];
    [aCoder encodeObject:_serverTime forKey:kFeedbackNSObjectServerTime];
}

- (id)copyWithZone:(NSZone *)zone
{
    FeedbackNSObject *copy = [[FeedbackNSObject alloc] init];
    
    if (copy) {

        copy.result = [self.result copyWithZone:zone];
        copy.errorId = self.errorId;
        copy.serverTime = [self.serverTime copyWithZone:zone];
    }
    
    return copy;
}


@end
