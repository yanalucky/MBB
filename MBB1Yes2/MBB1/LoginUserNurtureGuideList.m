//
//  LoginUserNurtureGuideList.m
//
//  Created by  豆蒙萌 on 15/9/23
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "LoginUserNurtureGuideList.h"
#import "LoginUserDetaillist.h"


NSString *const kLoginUserNurtureGuideListAge = @"age";
NSString *const kLoginUserNurtureGuideListId = @"id";
NSString *const kLoginUserNurtureGuideListNurturename = @"nurturename";
NSString *const kLoginUserNurtureGuideListNurtureorder = @"nurtureorder";
NSString *const kLoginUserNurtureGuideListDetaillist = @"detaillist";


@interface LoginUserNurtureGuideList ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation LoginUserNurtureGuideList

@synthesize age = _age;
@synthesize nurtureGuideListIdentifier = _nurtureGuideListIdentifier;
@synthesize nurturename = _nurturename;
@synthesize nurtureorder = _nurtureorder;
@synthesize detaillist = _detaillist;


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
            self.age = [self objectOrNilForKey:kLoginUserNurtureGuideListAge fromDictionary:dict];
            self.nurtureGuideListIdentifier = [self objectOrNilForKey:kLoginUserNurtureGuideListId fromDictionary:dict];
            self.nurturename = [self objectOrNilForKey:kLoginUserNurtureGuideListNurturename fromDictionary:dict];
            self.nurtureorder = [self objectOrNilForKey:kLoginUserNurtureGuideListNurtureorder fromDictionary:dict];
    NSObject *receivedLoginUserDetaillist = [dict objectForKey:kLoginUserNurtureGuideListDetaillist];
    NSMutableArray *parsedLoginUserDetaillist = [NSMutableArray array];
    if ([receivedLoginUserDetaillist isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedLoginUserDetaillist) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedLoginUserDetaillist addObject:[LoginUserDetaillist modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedLoginUserDetaillist isKindOfClass:[NSDictionary class]]) {
       [parsedLoginUserDetaillist addObject:[LoginUserDetaillist modelObjectWithDictionary:(NSDictionary *)receivedLoginUserDetaillist]];
    }

    self.detaillist = [NSArray arrayWithArray:parsedLoginUserDetaillist];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.age forKey:kLoginUserNurtureGuideListAge];
    [mutableDict setValue:self.nurtureGuideListIdentifier forKey:kLoginUserNurtureGuideListId];
    [mutableDict setValue:self.nurturename forKey:kLoginUserNurtureGuideListNurturename];
    [mutableDict setValue:self.nurtureorder forKey:kLoginUserNurtureGuideListNurtureorder];
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
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForDetaillist] forKey:kLoginUserNurtureGuideListDetaillist];

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

    self.age = [aDecoder decodeObjectForKey:kLoginUserNurtureGuideListAge];
    self.nurtureGuideListIdentifier = [aDecoder decodeObjectForKey:kLoginUserNurtureGuideListId];
    self.nurturename = [aDecoder decodeObjectForKey:kLoginUserNurtureGuideListNurturename];
    self.nurtureorder = [aDecoder decodeObjectForKey:kLoginUserNurtureGuideListNurtureorder];
    self.detaillist = [aDecoder decodeObjectForKey:kLoginUserNurtureGuideListDetaillist];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_age forKey:kLoginUserNurtureGuideListAge];
    [aCoder encodeObject:_nurtureGuideListIdentifier forKey:kLoginUserNurtureGuideListId];
    [aCoder encodeObject:_nurturename forKey:kLoginUserNurtureGuideListNurturename];
    [aCoder encodeObject:_nurtureorder forKey:kLoginUserNurtureGuideListNurtureorder];
    [aCoder encodeObject:_detaillist forKey:kLoginUserNurtureGuideListDetaillist];
}

- (id)copyWithZone:(NSZone *)zone
{
    LoginUserNurtureGuideList *copy = [[LoginUserNurtureGuideList alloc] init];
    
    if (copy) {

        copy.age = [self.age copyWithZone:zone];
        copy.nurtureGuideListIdentifier = [self.nurtureGuideListIdentifier copyWithZone:zone];
        copy.nurturename = [self.nurturename copyWithZone:zone];
        copy.nurtureorder = [self.nurtureorder copyWithZone:zone];
        copy.detaillist = [self.detaillist copyWithZone:zone];
    }
    
    return copy;
}


@end
