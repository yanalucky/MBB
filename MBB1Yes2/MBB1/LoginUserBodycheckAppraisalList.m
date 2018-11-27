//
//  LoginUserBodycheckAppraisalList.m
//
//  Created by  豆蒙萌 on 15/9/23
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "LoginUserBodycheckAppraisalList.h"


NSString *const kLoginUserBodycheckAppraisalListBodycheckappeaisalurl = @"bodycheckappeaisalurl";
NSString *const kLoginUserBodycheckAppraisalListBodycheckappeaisalid = @"bodycheckappeaisalid";
NSString *const kLoginUserBodycheckAppraisalListBodycheckappeaisalurlversion = @"bodycheckappeaisalurlversion";
NSString *const kLoginUserBodycheckAppraisalListUserid = @"userid";


@interface LoginUserBodycheckAppraisalList ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation LoginUserBodycheckAppraisalList

@synthesize bodycheckappeaisalurl = _bodycheckappeaisalurl;
@synthesize bodycheckappeaisalid = _bodycheckappeaisalid;
@synthesize bodycheckappeaisalurlversion = _bodycheckappeaisalurlversion;
@synthesize userid = _userid;


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
            self.bodycheckappeaisalurl = [self objectOrNilForKey:kLoginUserBodycheckAppraisalListBodycheckappeaisalurl fromDictionary:dict];
            self.bodycheckappeaisalid = [self objectOrNilForKey:kLoginUserBodycheckAppraisalListBodycheckappeaisalid fromDictionary:dict];
            self.bodycheckappeaisalurlversion = [self objectOrNilForKey:kLoginUserBodycheckAppraisalListBodycheckappeaisalurlversion fromDictionary:dict];
            self.userid = [self objectOrNilForKey:kLoginUserBodycheckAppraisalListUserid fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.bodycheckappeaisalurl forKey:kLoginUserBodycheckAppraisalListBodycheckappeaisalurl];
    [mutableDict setValue:self.bodycheckappeaisalid forKey:kLoginUserBodycheckAppraisalListBodycheckappeaisalid];
    [mutableDict setValue:self.bodycheckappeaisalurlversion forKey:kLoginUserBodycheckAppraisalListBodycheckappeaisalurlversion];
    [mutableDict setValue:self.userid forKey:kLoginUserBodycheckAppraisalListUserid];

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

    self.bodycheckappeaisalurl = [aDecoder decodeObjectForKey:kLoginUserBodycheckAppraisalListBodycheckappeaisalurl];
    self.bodycheckappeaisalid = [aDecoder decodeObjectForKey:kLoginUserBodycheckAppraisalListBodycheckappeaisalid];
    self.bodycheckappeaisalurlversion = [aDecoder decodeObjectForKey:kLoginUserBodycheckAppraisalListBodycheckappeaisalurlversion];
    self.userid = [aDecoder decodeObjectForKey:kLoginUserBodycheckAppraisalListUserid];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_bodycheckappeaisalurl forKey:kLoginUserBodycheckAppraisalListBodycheckappeaisalurl];
    [aCoder encodeObject:_bodycheckappeaisalid forKey:kLoginUserBodycheckAppraisalListBodycheckappeaisalid];
    [aCoder encodeObject:_bodycheckappeaisalurlversion forKey:kLoginUserBodycheckAppraisalListBodycheckappeaisalurlversion];
    [aCoder encodeObject:_userid forKey:kLoginUserBodycheckAppraisalListUserid];
}

- (id)copyWithZone:(NSZone *)zone
{
    LoginUserBodycheckAppraisalList *copy = [[LoginUserBodycheckAppraisalList alloc] init];
    
    if (copy) {

        copy.bodycheckappeaisalurl = [self.bodycheckappeaisalurl copyWithZone:zone];
        copy.bodycheckappeaisalid = [self.bodycheckappeaisalid copyWithZone:zone];
        copy.bodycheckappeaisalurlversion = [self.bodycheckappeaisalurlversion copyWithZone:zone];
        copy.userid = [self.userid copyWithZone:zone];
    }
    
    return copy;
}


@end
