//
//  NurtureGuideResult.m
//
//  Created by   on 16/5/17
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "NurtureGuideResult.h"
#import "NurtureGuideNurtureGuideList.h"

NSString *const kNurtureGuideResultFirstRecordStatus = @"firstRecordStatus";

NSString *const kNurtureGuideResultNurtureGuideList = @"NurtureGuideList";


@interface NurtureGuideResult ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation NurtureGuideResult

@synthesize nurtureGuideList = _nurtureGuideList;
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
    NSObject *receivedNurtureGuideNurtureGuideList = [dict objectForKey:kNurtureGuideResultNurtureGuideList];
    NSMutableArray *parsedNurtureGuideNurtureGuideList = [NSMutableArray array];
    if ([receivedNurtureGuideNurtureGuideList isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedNurtureGuideNurtureGuideList) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedNurtureGuideNurtureGuideList addObject:[NurtureGuideNurtureGuideList modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedNurtureGuideNurtureGuideList isKindOfClass:[NSDictionary class]]) {
       [parsedNurtureGuideNurtureGuideList addObject:[NurtureGuideNurtureGuideList modelObjectWithDictionary:(NSDictionary *)receivedNurtureGuideNurtureGuideList]];
    }

    self.nurtureGuideList = [NSArray arrayWithArray:parsedNurtureGuideNurtureGuideList];
    self.firstRecordStatus = [self objectOrNilForKey:kNurtureGuideResultFirstRecordStatus fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
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
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForNurtureGuideList] forKey:kNurtureGuideResultNurtureGuideList];
    [mutableDict setValue:self.firstRecordStatus forKey:kNurtureGuideResultFirstRecordStatus];

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
    self.firstRecordStatus = [aDecoder decodeObjectForKey:kNurtureGuideResultFirstRecordStatus];

    self.nurtureGuideList = [aDecoder decodeObjectForKey:kNurtureGuideResultNurtureGuideList];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_firstRecordStatus forKey:kNurtureGuideResultFirstRecordStatus];

    [aCoder encodeObject:_nurtureGuideList forKey:kNurtureGuideResultNurtureGuideList];
}

- (id)copyWithZone:(NSZone *)zone
{
    NurtureGuideResult *copy = [[NurtureGuideResult alloc] init];
    
    if (copy) {
        copy.firstRecordStatus = [self.firstRecordStatus copyWithZone:zone];

        copy.nurtureGuideList = [self.nurtureGuideList copyWithZone:zone];
    }
    
    return copy;
}


@end
