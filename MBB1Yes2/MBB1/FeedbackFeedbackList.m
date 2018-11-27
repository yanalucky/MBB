//
//  FeedbackFeedbackList.m
//
//  Created by  豆蒙萌 on 15/10/29
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "FeedbackFeedbackList.h"


NSString *const kFeedbackFeedbackListBacktype = @"backtype";
NSString *const kFeedbackFeedbackListIsnew = @"isnew";
NSString *const kFeedbackFeedbackListUserid = @"userid";
NSString *const kFeedbackFeedbackListBackcontent = @"backcontent";
NSString *const kFeedbackFeedbackListBacktime = @"backtime";
NSString *const kFeedbackFeedbackListFeedbackid = @"feedbackid";


@interface FeedbackFeedbackList ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation FeedbackFeedbackList

@synthesize backtype = _backtype;
@synthesize isnew = _isnew;
@synthesize userid = _userid;
@synthesize backcontent = _backcontent;
@synthesize backtime = _backtime;
@synthesize feedbackid = _feedbackid;


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
            self.backtype = [self objectOrNilForKey:kFeedbackFeedbackListBacktype fromDictionary:dict];
            self.isnew = [self objectOrNilForKey:kFeedbackFeedbackListIsnew fromDictionary:dict];
            self.userid = [self objectOrNilForKey:kFeedbackFeedbackListUserid fromDictionary:dict];
            self.backcontent = [self objectOrNilForKey:kFeedbackFeedbackListBackcontent fromDictionary:dict];
            self.backtime = [self objectOrNilForKey:kFeedbackFeedbackListBacktime fromDictionary:dict];
            self.feedbackid = [self objectOrNilForKey:kFeedbackFeedbackListFeedbackid fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.backtype forKey:kFeedbackFeedbackListBacktype];
    [mutableDict setValue:self.isnew forKey:kFeedbackFeedbackListIsnew];
    [mutableDict setValue:self.userid forKey:kFeedbackFeedbackListUserid];
    [mutableDict setValue:self.backcontent forKey:kFeedbackFeedbackListBackcontent];
    [mutableDict setValue:self.backtime forKey:kFeedbackFeedbackListBacktime];
    [mutableDict setValue:self.feedbackid forKey:kFeedbackFeedbackListFeedbackid];

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

    self.backtype = [aDecoder decodeObjectForKey:kFeedbackFeedbackListBacktype];
    self.isnew = [aDecoder decodeObjectForKey:kFeedbackFeedbackListIsnew];
    self.userid = [aDecoder decodeObjectForKey:kFeedbackFeedbackListUserid];
    self.backcontent = [aDecoder decodeObjectForKey:kFeedbackFeedbackListBackcontent];
    self.backtime = [aDecoder decodeObjectForKey:kFeedbackFeedbackListBacktime];
    self.feedbackid = [aDecoder decodeObjectForKey:kFeedbackFeedbackListFeedbackid];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_backtype forKey:kFeedbackFeedbackListBacktype];
    [aCoder encodeObject:_isnew forKey:kFeedbackFeedbackListIsnew];
    [aCoder encodeObject:_userid forKey:kFeedbackFeedbackListUserid];
    [aCoder encodeObject:_backcontent forKey:kFeedbackFeedbackListBackcontent];
    [aCoder encodeObject:_backtime forKey:kFeedbackFeedbackListBacktime];
    [aCoder encodeObject:_feedbackid forKey:kFeedbackFeedbackListFeedbackid];
}

- (id)copyWithZone:(NSZone *)zone
{
    FeedbackFeedbackList *copy = [[FeedbackFeedbackList alloc] init];
    
    if (copy) {

        copy.backtype = [self.backtype copyWithZone:zone];
        copy.isnew = [self.isnew copyWithZone:zone];
        copy.userid = [self.userid copyWithZone:zone];
        copy.backcontent = [self.backcontent copyWithZone:zone];
        copy.backtime = [self.backtime copyWithZone:zone];
        copy.feedbackid = [self.feedbackid copyWithZone:zone];
    }
    
    return copy;
}


@end
