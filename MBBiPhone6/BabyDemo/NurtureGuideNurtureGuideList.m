//
//  NurtureGuideNurtureGuideList.m
//
//  Created by   on 16/5/17
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "NurtureGuideNurtureGuideList.h"
#import "NurtureGuideDetaillist.h"


NSString *const kNurtureGuideNurtureGuideListAge = @"age";
NSString *const kNurtureGuideNurtureGuideListId = @"id";
NSString *const kNurtureGuideNurtureGuideListNurtureorder = @"nurtureorder";
NSString *const kNurtureGuideNurtureGuideListDetaillist = @"detaillist";
NSString *const kNurtureGuideNurtureGuideListNurturename = @"nurturename";


@interface NurtureGuideNurtureGuideList ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation NurtureGuideNurtureGuideList

@synthesize age = _age;
@synthesize nurtureGuideListIdentifier = _nurtureGuideListIdentifier;
@synthesize nurtureorder = _nurtureorder;
@synthesize detaillist = _detaillist;
@synthesize nurturename = _nurturename;


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
            self.age = [self objectOrNilForKey:kNurtureGuideNurtureGuideListAge fromDictionary:dict];
            self.nurtureGuideListIdentifier = [self objectOrNilForKey:kNurtureGuideNurtureGuideListId fromDictionary:dict];
            self.nurtureorder = [self objectOrNilForKey:kNurtureGuideNurtureGuideListNurtureorder fromDictionary:dict];
    NSObject *receivedNurtureGuideDetaillist = [dict objectForKey:kNurtureGuideNurtureGuideListDetaillist];
    NSMutableArray *parsedNurtureGuideDetaillist = [NSMutableArray array];
    if ([receivedNurtureGuideDetaillist isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedNurtureGuideDetaillist) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedNurtureGuideDetaillist addObject:[NurtureGuideDetaillist modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedNurtureGuideDetaillist isKindOfClass:[NSDictionary class]]) {
       [parsedNurtureGuideDetaillist addObject:[NurtureGuideDetaillist modelObjectWithDictionary:(NSDictionary *)receivedNurtureGuideDetaillist]];
    }

    self.detaillist = [NSArray arrayWithArray:parsedNurtureGuideDetaillist];
            self.nurturename = [self objectOrNilForKey:kNurtureGuideNurtureGuideListNurturename fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.age forKey:kNurtureGuideNurtureGuideListAge];
    [mutableDict setValue:self.nurtureGuideListIdentifier forKey:kNurtureGuideNurtureGuideListId];
    [mutableDict setValue:self.nurtureorder forKey:kNurtureGuideNurtureGuideListNurtureorder];
    NSMutableArray *tempArrayForDetaillist = [NSMutableArray array];
    for (NSObject *subArrayObject in self.detaillist) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForDetaillist addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForDetaillist addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForDetaillist] forKey:kNurtureGuideNurtureGuideListDetaillist];
    [mutableDict setValue:self.nurturename forKey:kNurtureGuideNurtureGuideListNurturename];

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

    self.age = [aDecoder decodeObjectForKey:kNurtureGuideNurtureGuideListAge];
    self.nurtureGuideListIdentifier = [aDecoder decodeObjectForKey:kNurtureGuideNurtureGuideListId];
    self.nurtureorder = [aDecoder decodeObjectForKey:kNurtureGuideNurtureGuideListNurtureorder];
    self.detaillist = [aDecoder decodeObjectForKey:kNurtureGuideNurtureGuideListDetaillist];
    self.nurturename = [aDecoder decodeObjectForKey:kNurtureGuideNurtureGuideListNurturename];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_age forKey:kNurtureGuideNurtureGuideListAge];
    [aCoder encodeObject:_nurtureGuideListIdentifier forKey:kNurtureGuideNurtureGuideListId];
    [aCoder encodeObject:_nurtureorder forKey:kNurtureGuideNurtureGuideListNurtureorder];
    [aCoder encodeObject:_detaillist forKey:kNurtureGuideNurtureGuideListDetaillist];
    [aCoder encodeObject:_nurturename forKey:kNurtureGuideNurtureGuideListNurturename];
}

- (id)copyWithZone:(NSZone *)zone
{
    NurtureGuideNurtureGuideList *copy = [[NurtureGuideNurtureGuideList alloc] init];
    
    if (copy) {

        copy.age = [self.age copyWithZone:zone];
        copy.nurtureGuideListIdentifier = [self.nurtureGuideListIdentifier copyWithZone:zone];
        copy.nurtureorder = [self.nurtureorder copyWithZone:zone];
        copy.detaillist = [self.detaillist copyWithZone:zone];
        copy.nurturename = [self.nurturename copyWithZone:zone];
    }
    
    return copy;
}


@end
