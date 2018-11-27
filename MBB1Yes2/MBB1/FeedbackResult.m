//
//  FeedbackResult.m
//
//  Created by  豆蒙萌 on 15/10/29
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "FeedbackResult.h"
#import "FeedbackFeedbackList.h"


NSString *const kFeedbackResultFeedbackList = @"FeedbackList";


@interface FeedbackResult ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation FeedbackResult

@synthesize feedbackList = _feedbackList;


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
    NSObject *receivedFeedbackFeedbackList = [dict objectForKey:kFeedbackResultFeedbackList];
    NSMutableArray *parsedFeedbackFeedbackList = [NSMutableArray array];
    if ([receivedFeedbackFeedbackList isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedFeedbackFeedbackList) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedFeedbackFeedbackList addObject:[FeedbackFeedbackList modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedFeedbackFeedbackList isKindOfClass:[NSDictionary class]]) {
       [parsedFeedbackFeedbackList addObject:[FeedbackFeedbackList modelObjectWithDictionary:(NSDictionary *)receivedFeedbackFeedbackList]];
    }

    self.feedbackList = [NSArray arrayWithArray:parsedFeedbackFeedbackList];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    NSMutableArray *tempArrayForFeedbackList = [NSMutableArray array];
    for (NSObject *subArrayObject in self.feedbackList) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForFeedbackList addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForFeedbackList addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForFeedbackList] forKey:kFeedbackResultFeedbackList];

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

    self.feedbackList = [aDecoder decodeObjectForKey:kFeedbackResultFeedbackList];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_feedbackList forKey:kFeedbackResultFeedbackList];
}

- (id)copyWithZone:(NSZone *)zone
{
    FeedbackResult *copy = [[FeedbackResult alloc] init];
    
    if (copy) {

        copy.feedbackList = [self.feedbackList copyWithZone:zone];
    }
    
    return copy;
}


@end
