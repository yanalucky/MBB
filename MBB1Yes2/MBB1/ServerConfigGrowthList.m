//
//  ServerConfigGrowthList.m
//
//  Created by  豆蒙萌 on 15/9/21
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "ServerConfigGrowthList.h"


NSString *const kServerConfigGrowthListAge = @"age";
NSString *const kServerConfigGrowthListObservecontent = @"observecontent";
NSString *const kServerConfigGrowthListObserveupdatetime = @"observeupdatetime";
NSString *const kServerConfigGrowthListObserveid = @"observeid";
NSString *const kServerConfigGrowthListObserveorder = @"observeorder";


@interface ServerConfigGrowthList ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ServerConfigGrowthList

@synthesize age = _age;
@synthesize observecontent = _observecontent;
@synthesize observeupdatetime = _observeupdatetime;
@synthesize observeid = _observeid;
@synthesize observeorder = _observeorder;


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
            self.age = [self objectOrNilForKey:kServerConfigGrowthListAge fromDictionary:dict];
            self.observecontent = [self objectOrNilForKey:kServerConfigGrowthListObservecontent fromDictionary:dict];
            self.observeupdatetime = [self objectOrNilForKey:kServerConfigGrowthListObserveupdatetime fromDictionary:dict];
            self.observeid = [self objectOrNilForKey:kServerConfigGrowthListObserveid fromDictionary:dict];
            self.observeorder = [self objectOrNilForKey:kServerConfigGrowthListObserveorder fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.age forKey:kServerConfigGrowthListAge];
    [mutableDict setValue:self.observecontent forKey:kServerConfigGrowthListObservecontent];
    [mutableDict setValue:self.observeupdatetime forKey:kServerConfigGrowthListObserveupdatetime];
    [mutableDict setValue:self.observeid forKey:kServerConfigGrowthListObserveid];
    [mutableDict setValue:self.observeorder forKey:kServerConfigGrowthListObserveorder];

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

    self.age = [aDecoder decodeObjectForKey:kServerConfigGrowthListAge];
    self.observecontent = [aDecoder decodeObjectForKey:kServerConfigGrowthListObservecontent];
    self.observeupdatetime = [aDecoder decodeObjectForKey:kServerConfigGrowthListObserveupdatetime];
    self.observeid = [aDecoder decodeObjectForKey:kServerConfigGrowthListObserveid];
    self.observeorder = [aDecoder decodeObjectForKey:kServerConfigGrowthListObserveorder];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_age forKey:kServerConfigGrowthListAge];
    [aCoder encodeObject:_observecontent forKey:kServerConfigGrowthListObservecontent];
    [aCoder encodeObject:_observeupdatetime forKey:kServerConfigGrowthListObserveupdatetime];
    [aCoder encodeObject:_observeid forKey:kServerConfigGrowthListObserveid];
    [aCoder encodeObject:_observeorder forKey:kServerConfigGrowthListObserveorder];
}

- (id)copyWithZone:(NSZone *)zone
{
    ServerConfigGrowthList *copy = [[ServerConfigGrowthList alloc] init];
    
    if (copy) {

        copy.age = [self.age copyWithZone:zone];
        copy.observecontent = [self.observecontent copyWithZone:zone];
        copy.observeupdatetime = [self.observeupdatetime copyWithZone:zone];
        copy.observeid = [self.observeid copyWithZone:zone];
        copy.observeorder = [self.observeorder copyWithZone:zone];
    }
    
    return copy;
}


@end
