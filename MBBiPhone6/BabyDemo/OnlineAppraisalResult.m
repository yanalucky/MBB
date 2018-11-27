//
//  OnlineAppraisalResult.m
//
//  Created by   on 16/7/18
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "OnlineAppraisalResult.h"
#import "OnlineAppraisalOnlineAppraisal.h"
#import "OnlineAppraisalImgdata.h"


NSString *const kOnlineAppraisalResultOnlineAppraisal = @"OnlineAppraisal";
NSString *const kOnlineAppraisalResultImgdata = @"imgdata";
NSString *const kOnlineAppraisalResultFirstRecordStatus = @"firstRecordStatus";


@interface OnlineAppraisalResult ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation OnlineAppraisalResult

@synthesize onlineAppraisal = _onlineAppraisal;
@synthesize imgdata = _imgdata;
@synthesize firstRecordStatus = _firstRecordStatus;


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
    NSObject *receivedOnlineAppraisalOnlineAppraisal = [dict objectForKey:kOnlineAppraisalResultOnlineAppraisal];
    NSMutableArray *parsedOnlineAppraisalOnlineAppraisal = [NSMutableArray array];
    if ([receivedOnlineAppraisalOnlineAppraisal isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedOnlineAppraisalOnlineAppraisal) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedOnlineAppraisalOnlineAppraisal addObject:[OnlineAppraisalOnlineAppraisal modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedOnlineAppraisalOnlineAppraisal isKindOfClass:[NSDictionary class]]) {
       [parsedOnlineAppraisalOnlineAppraisal addObject:[OnlineAppraisalOnlineAppraisal modelObjectWithDictionary:(NSDictionary *)receivedOnlineAppraisalOnlineAppraisal]];
    }

    self.onlineAppraisal = [NSArray arrayWithArray:parsedOnlineAppraisalOnlineAppraisal];
    NSObject *receivedOnlineAppraisalImgdata = [dict objectForKey:kOnlineAppraisalResultImgdata];
    NSMutableArray *parsedOnlineAppraisalImgdata = [NSMutableArray array];
    if ([receivedOnlineAppraisalImgdata isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedOnlineAppraisalImgdata) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedOnlineAppraisalImgdata addObject:[OnlineAppraisalImgdata modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedOnlineAppraisalImgdata isKindOfClass:[NSDictionary class]]) {
       [parsedOnlineAppraisalImgdata addObject:[OnlineAppraisalImgdata modelObjectWithDictionary:(NSDictionary *)receivedOnlineAppraisalImgdata]];
    }

    self.imgdata = [NSArray arrayWithArray:parsedOnlineAppraisalImgdata];
            self.firstRecordStatus = [self objectOrNilForKey:kOnlineAppraisalResultFirstRecordStatus fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    NSMutableArray *tempArrayForOnlineAppraisal = [NSMutableArray array];
    for (NSObject *subArrayObject in self.onlineAppraisal) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForOnlineAppraisal addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForOnlineAppraisal addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForOnlineAppraisal] forKey:kOnlineAppraisalResultOnlineAppraisal];
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
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForImgdata] forKey:kOnlineAppraisalResultImgdata];
    [mutableDict setValue:self.firstRecordStatus forKey:kOnlineAppraisalResultFirstRecordStatus];

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

    self.onlineAppraisal = [aDecoder decodeObjectForKey:kOnlineAppraisalResultOnlineAppraisal];
    self.imgdata = [aDecoder decodeObjectForKey:kOnlineAppraisalResultImgdata];
    self.firstRecordStatus = [aDecoder decodeObjectForKey:kOnlineAppraisalResultFirstRecordStatus];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_onlineAppraisal forKey:kOnlineAppraisalResultOnlineAppraisal];
    [aCoder encodeObject:_imgdata forKey:kOnlineAppraisalResultImgdata];
    [aCoder encodeObject:_firstRecordStatus forKey:kOnlineAppraisalResultFirstRecordStatus];
}

- (id)copyWithZone:(NSZone *)zone
{
    OnlineAppraisalResult *copy = [[OnlineAppraisalResult alloc] init];
    
    if (copy) {

        copy.onlineAppraisal = [self.onlineAppraisal copyWithZone:zone];
        copy.imgdata = [self.imgdata copyWithZone:zone];
        copy.firstRecordStatus = [self.firstRecordStatus copyWithZone:zone];
    }
    
    return copy;
}


@end
