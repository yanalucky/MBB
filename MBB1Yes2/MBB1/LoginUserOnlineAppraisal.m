//
//  LoginUserOnlineAppraisal.m
//
//  Created by  豆蒙萌 on 15/9/23
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "LoginUserOnlineAppraisal.h"
#import "LoginUserImgdata.h"


NSString *const kLoginUserOnlineAppraisalUserid = @"userid";
NSString *const kLoginUserOnlineAppraisalAppraisalstatus = @"appraisalstatus";
NSString *const kLoginUserOnlineAppraisalOnlineid = @"onlineid";
NSString *const kLoginUserOnlineAppraisalImgdata = @"imgdata";
NSString *const kLoginUserOnlineAppraisalAppraisalage = @"appraisalage";
NSString *const kLoginUserOnlineAppraisalStar = @"star";
NSString *const kLoginUserOnlineAppraisalGrowthappraisal = @"growthappraisal";
NSString *const kLoginUserOnlineAppraisalRecordid = @"recordid";
NSString *const kLoginUserOnlineAppraisalMindappraisal = @"mindappraisal";
NSString *const kLoginUserOnlineAppraisalFeedingtype = @"feedingtype";
NSString *const kLoginUserOnlineAppraisalAppraisaltime = @"appraisaltime";


@interface LoginUserOnlineAppraisal ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation LoginUserOnlineAppraisal

@synthesize userid = _userid;
@synthesize appraisalstatus = _appraisalstatus;
@synthesize onlineid = _onlineid;
@synthesize imgdata = _imgdata;
@synthesize appraisalage = _appraisalage;
@synthesize star = _star;
@synthesize growthappraisal = _growthappraisal;
@synthesize recordid = _recordid;
@synthesize mindappraisal = _mindappraisal;
@synthesize feedingtype = _feedingtype;
@synthesize appraisaltime = _appraisaltime;


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
            self.userid = [self objectOrNilForKey:kLoginUserOnlineAppraisalUserid fromDictionary:dict];
            self.appraisalstatus = [self objectOrNilForKey:kLoginUserOnlineAppraisalAppraisalstatus fromDictionary:dict];
            self.onlineid = [self objectOrNilForKey:kLoginUserOnlineAppraisalOnlineid fromDictionary:dict];
    NSObject *receivedLoginUserImgdata = [dict objectForKey:kLoginUserOnlineAppraisalImgdata];
    NSMutableArray *parsedLoginUserImgdata = [NSMutableArray array];
    if ([receivedLoginUserImgdata isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedLoginUserImgdata) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedLoginUserImgdata addObject:[LoginUserImgdata modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedLoginUserImgdata isKindOfClass:[NSDictionary class]]) {
       [parsedLoginUserImgdata addObject:[LoginUserImgdata modelObjectWithDictionary:(NSDictionary *)receivedLoginUserImgdata]];
    }

    self.imgdata = [NSArray arrayWithArray:parsedLoginUserImgdata];
            self.appraisalage = [self objectOrNilForKey:kLoginUserOnlineAppraisalAppraisalage fromDictionary:dict];
            self.star = [self objectOrNilForKey:kLoginUserOnlineAppraisalStar fromDictionary:dict];
            self.growthappraisal = [self objectOrNilForKey:kLoginUserOnlineAppraisalGrowthappraisal fromDictionary:dict];
            self.recordid = [self objectOrNilForKey:kLoginUserOnlineAppraisalRecordid fromDictionary:dict];
            self.mindappraisal = [self objectOrNilForKey:kLoginUserOnlineAppraisalMindappraisal fromDictionary:dict];
            self.feedingtype = [self objectOrNilForKey:kLoginUserOnlineAppraisalFeedingtype fromDictionary:dict];
            self.appraisaltime = [self objectOrNilForKey:kLoginUserOnlineAppraisalAppraisaltime fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.userid forKey:kLoginUserOnlineAppraisalUserid];
    [mutableDict setValue:self.appraisalstatus forKey:kLoginUserOnlineAppraisalAppraisalstatus];
    [mutableDict setValue:self.onlineid forKey:kLoginUserOnlineAppraisalOnlineid];
    NSMutableArray *tempArrayForImgdata = [NSMutableArray array];
    for (NSObject *subArrayObject in self.imgdata) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForImgdata addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForImgdata addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForImgdata] forKey:kLoginUserOnlineAppraisalImgdata];
    [mutableDict setValue:self.appraisalage forKey:kLoginUserOnlineAppraisalAppraisalage];
    [mutableDict setValue:self.star forKey:kLoginUserOnlineAppraisalStar];
    [mutableDict setValue:self.growthappraisal forKey:kLoginUserOnlineAppraisalGrowthappraisal];
    [mutableDict setValue:self.recordid forKey:kLoginUserOnlineAppraisalRecordid];
    [mutableDict setValue:self.mindappraisal forKey:kLoginUserOnlineAppraisalMindappraisal];
    [mutableDict setValue:self.feedingtype forKey:kLoginUserOnlineAppraisalFeedingtype];
    [mutableDict setValue:self.appraisaltime forKey:kLoginUserOnlineAppraisalAppraisaltime];

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

    self.userid = [aDecoder decodeObjectForKey:kLoginUserOnlineAppraisalUserid];
    self.appraisalstatus = [aDecoder decodeObjectForKey:kLoginUserOnlineAppraisalAppraisalstatus];
    self.onlineid = [aDecoder decodeObjectForKey:kLoginUserOnlineAppraisalOnlineid];
    self.imgdata = [aDecoder decodeObjectForKey:kLoginUserOnlineAppraisalImgdata];
    self.appraisalage = [aDecoder decodeObjectForKey:kLoginUserOnlineAppraisalAppraisalage];
    self.star = [aDecoder decodeObjectForKey:kLoginUserOnlineAppraisalStar];
    self.growthappraisal = [aDecoder decodeObjectForKey:kLoginUserOnlineAppraisalGrowthappraisal];
    self.recordid = [aDecoder decodeObjectForKey:kLoginUserOnlineAppraisalRecordid];
    self.mindappraisal = [aDecoder decodeObjectForKey:kLoginUserOnlineAppraisalMindappraisal];
    self.feedingtype = [aDecoder decodeObjectForKey:kLoginUserOnlineAppraisalFeedingtype];
    self.appraisaltime = [aDecoder decodeObjectForKey:kLoginUserOnlineAppraisalAppraisaltime];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_userid forKey:kLoginUserOnlineAppraisalUserid];
    [aCoder encodeObject:_appraisalstatus forKey:kLoginUserOnlineAppraisalAppraisalstatus];
    [aCoder encodeObject:_onlineid forKey:kLoginUserOnlineAppraisalOnlineid];
    [aCoder encodeObject:_imgdata forKey:kLoginUserOnlineAppraisalImgdata];
    [aCoder encodeObject:_appraisalage forKey:kLoginUserOnlineAppraisalAppraisalage];
    [aCoder encodeObject:_star forKey:kLoginUserOnlineAppraisalStar];
    [aCoder encodeObject:_growthappraisal forKey:kLoginUserOnlineAppraisalGrowthappraisal];
    [aCoder encodeObject:_recordid forKey:kLoginUserOnlineAppraisalRecordid];
    [aCoder encodeObject:_mindappraisal forKey:kLoginUserOnlineAppraisalMindappraisal];
    [aCoder encodeObject:_feedingtype forKey:kLoginUserOnlineAppraisalFeedingtype];
    [aCoder encodeObject:_appraisaltime forKey:kLoginUserOnlineAppraisalAppraisaltime];
}

- (id)copyWithZone:(NSZone *)zone
{
    LoginUserOnlineAppraisal *copy = [[LoginUserOnlineAppraisal alloc] init];
    
    if (copy) {

        copy.userid = [self.userid copyWithZone:zone];
        copy.appraisalstatus = [self.appraisalstatus copyWithZone:zone];
        copy.onlineid = [self.onlineid copyWithZone:zone];
        copy.imgdata = [self.imgdata copyWithZone:zone];
        copy.appraisalage = [self.appraisalage copyWithZone:zone];
        copy.star = [self.star copyWithZone:zone];
        copy.growthappraisal = [self.growthappraisal copyWithZone:zone];
        copy.recordid = [self.recordid copyWithZone:zone];
        copy.mindappraisal = [self.mindappraisal copyWithZone:zone];
        copy.feedingtype = [self.feedingtype copyWithZone:zone];
        copy.appraisaltime = [self.appraisaltime copyWithZone:zone];
    }
    
    return copy;
}


@end
