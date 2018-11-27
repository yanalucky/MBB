//
//  ServerConfigFeatureListByAge.m
//
//  Created by   on 16/6/21
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "ServerConfigFeatureListByAge.h"


NSString *const kServerConfigFeatureListByAgeId = @"id";
NSString *const kServerConfigFeatureListByAgeDetaildesc = @"detaildesc";
NSString *const kServerConfigFeatureListByAgeAge = @"age";
NSString *const kServerConfigFeatureListByAgeFeaturename = @"featurename";
NSString *const kServerConfigFeatureListByAgeExamplemovidx = @"examplemovidx";
NSString *const kServerConfigFeatureListByAgeFeatureorder = @"featureorder";
NSString *const kServerConfigFeatureListByAgeExampleimg = @"exampleimg";
NSString *const kServerConfigFeatureListByAgeExampleimgversion = @"exampleimgversion";
NSString *const kServerConfigFeatureListByAgePointtag = @"pointtag";
NSString *const kServerConfigFeatureListByAgeExamplemov = @"examplemov";
NSString *const kServerConfigFeatureListByAgeExampleidx = @"exampleidx";
NSString *const kServerConfigFeatureListByAgeMonthage = @"monthage";
NSString *const kServerConfigFeatureListByAgeExamplemovversion = @"examplemovversion";
NSString *const kServerConfigFeatureListByAgeTypeid = @"typeid";


@interface ServerConfigFeatureListByAge ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ServerConfigFeatureListByAge

@synthesize featureListByAgeIdentifier = _featureListByAgeIdentifier;
@synthesize detaildesc = _detaildesc;
@synthesize age = _age;
@synthesize featurename = _featurename;
@synthesize examplemovidx = _examplemovidx;
@synthesize featureorder = _featureorder;
@synthesize exampleimg = _exampleimg;
@synthesize exampleimgversion = _exampleimgversion;
@synthesize pointtag = _pointtag;
@synthesize examplemov = _examplemov;
@synthesize exampleidx = _exampleidx;
@synthesize monthage = _monthage;
@synthesize examplemovversion = _examplemovversion;
@synthesize typeid = _typeid;


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
            self.featureListByAgeIdentifier = [self objectOrNilForKey:kServerConfigFeatureListByAgeId fromDictionary:dict];
            self.detaildesc = [self objectOrNilForKey:kServerConfigFeatureListByAgeDetaildesc fromDictionary:dict];
            self.age = [self objectOrNilForKey:kServerConfigFeatureListByAgeAge fromDictionary:dict];
            self.featurename = [self objectOrNilForKey:kServerConfigFeatureListByAgeFeaturename fromDictionary:dict];
            self.examplemovidx = [self objectOrNilForKey:kServerConfigFeatureListByAgeExamplemovidx fromDictionary:dict];
            self.featureorder = [self objectOrNilForKey:kServerConfigFeatureListByAgeFeatureorder fromDictionary:dict];
            self.exampleimg = [self objectOrNilForKey:kServerConfigFeatureListByAgeExampleimg fromDictionary:dict];
            self.exampleimgversion = [self objectOrNilForKey:kServerConfigFeatureListByAgeExampleimgversion fromDictionary:dict];
            self.pointtag = [self objectOrNilForKey:kServerConfigFeatureListByAgePointtag fromDictionary:dict];
            self.examplemov = [self objectOrNilForKey:kServerConfigFeatureListByAgeExamplemov fromDictionary:dict];
            self.exampleidx = [self objectOrNilForKey:kServerConfigFeatureListByAgeExampleidx fromDictionary:dict];
            self.monthage = [[self objectOrNilForKey:kServerConfigFeatureListByAgeMonthage fromDictionary:dict] doubleValue];
            self.examplemovversion = [self objectOrNilForKey:kServerConfigFeatureListByAgeExamplemovversion fromDictionary:dict];
            self.typeid = [self objectOrNilForKey:kServerConfigFeatureListByAgeTypeid fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.featureListByAgeIdentifier forKey:kServerConfigFeatureListByAgeId];
    [mutableDict setValue:self.detaildesc forKey:kServerConfigFeatureListByAgeDetaildesc];
    [mutableDict setValue:self.age forKey:kServerConfigFeatureListByAgeAge];
    [mutableDict setValue:self.featurename forKey:kServerConfigFeatureListByAgeFeaturename];
    [mutableDict setValue:self.examplemovidx forKey:kServerConfigFeatureListByAgeExamplemovidx];
    [mutableDict setValue:self.featureorder forKey:kServerConfigFeatureListByAgeFeatureorder];
    [mutableDict setValue:self.exampleimg forKey:kServerConfigFeatureListByAgeExampleimg];
    [mutableDict setValue:self.exampleimgversion forKey:kServerConfigFeatureListByAgeExampleimgversion];
    [mutableDict setValue:self.pointtag forKey:kServerConfigFeatureListByAgePointtag];
    [mutableDict setValue:self.examplemov forKey:kServerConfigFeatureListByAgeExamplemov];
    [mutableDict setValue:self.exampleidx forKey:kServerConfigFeatureListByAgeExampleidx];
    [mutableDict setValue:[NSNumber numberWithDouble:self.monthage] forKey:kServerConfigFeatureListByAgeMonthage];
    [mutableDict setValue:self.examplemovversion forKey:kServerConfigFeatureListByAgeExamplemovversion];
    [mutableDict setValue:self.typeid forKey:kServerConfigFeatureListByAgeTypeid];

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

    self.featureListByAgeIdentifier = [aDecoder decodeObjectForKey:kServerConfigFeatureListByAgeId];
    self.detaildesc = [aDecoder decodeObjectForKey:kServerConfigFeatureListByAgeDetaildesc];
    self.age = [aDecoder decodeObjectForKey:kServerConfigFeatureListByAgeAge];
    self.featurename = [aDecoder decodeObjectForKey:kServerConfigFeatureListByAgeFeaturename];
    self.examplemovidx = [aDecoder decodeObjectForKey:kServerConfigFeatureListByAgeExamplemovidx];
    self.featureorder = [aDecoder decodeObjectForKey:kServerConfigFeatureListByAgeFeatureorder];
    self.exampleimg = [aDecoder decodeObjectForKey:kServerConfigFeatureListByAgeExampleimg];
    self.exampleimgversion = [aDecoder decodeObjectForKey:kServerConfigFeatureListByAgeExampleimgversion];
    self.pointtag = [aDecoder decodeObjectForKey:kServerConfigFeatureListByAgePointtag];
    self.examplemov = [aDecoder decodeObjectForKey:kServerConfigFeatureListByAgeExamplemov];
    self.exampleidx = [aDecoder decodeObjectForKey:kServerConfigFeatureListByAgeExampleidx];
    self.monthage = [aDecoder decodeDoubleForKey:kServerConfigFeatureListByAgeMonthage];
    self.examplemovversion = [aDecoder decodeObjectForKey:kServerConfigFeatureListByAgeExamplemovversion];
    self.typeid = [aDecoder decodeObjectForKey:kServerConfigFeatureListByAgeTypeid];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_featureListByAgeIdentifier forKey:kServerConfigFeatureListByAgeId];
    [aCoder encodeObject:_detaildesc forKey:kServerConfigFeatureListByAgeDetaildesc];
    [aCoder encodeObject:_age forKey:kServerConfigFeatureListByAgeAge];
    [aCoder encodeObject:_featurename forKey:kServerConfigFeatureListByAgeFeaturename];
    [aCoder encodeObject:_examplemovidx forKey:kServerConfigFeatureListByAgeExamplemovidx];
    [aCoder encodeObject:_featureorder forKey:kServerConfigFeatureListByAgeFeatureorder];
    [aCoder encodeObject:_exampleimg forKey:kServerConfigFeatureListByAgeExampleimg];
    [aCoder encodeObject:_exampleimgversion forKey:kServerConfigFeatureListByAgeExampleimgversion];
    [aCoder encodeObject:_pointtag forKey:kServerConfigFeatureListByAgePointtag];
    [aCoder encodeObject:_examplemov forKey:kServerConfigFeatureListByAgeExamplemov];
    [aCoder encodeObject:_exampleidx forKey:kServerConfigFeatureListByAgeExampleidx];
    [aCoder encodeDouble:_monthage forKey:kServerConfigFeatureListByAgeMonthage];
    [aCoder encodeObject:_examplemovversion forKey:kServerConfigFeatureListByAgeExamplemovversion];
    [aCoder encodeObject:_typeid forKey:kServerConfigFeatureListByAgeTypeid];
}

- (id)copyWithZone:(NSZone *)zone
{
    ServerConfigFeatureListByAge *copy = [[ServerConfigFeatureListByAge alloc] init];
    
    if (copy) {

        copy.featureListByAgeIdentifier = [self.featureListByAgeIdentifier copyWithZone:zone];
        copy.detaildesc = [self.detaildesc copyWithZone:zone];
        copy.age = [self.age copyWithZone:zone];
        copy.featurename = [self.featurename copyWithZone:zone];
        copy.examplemovidx = [self.examplemovidx copyWithZone:zone];
        copy.featureorder = [self.featureorder copyWithZone:zone];
        copy.exampleimg = [self.exampleimg copyWithZone:zone];
        copy.exampleimgversion = [self.exampleimgversion copyWithZone:zone];
        copy.pointtag = [self.pointtag copyWithZone:zone];
        copy.examplemov = [self.examplemov copyWithZone:zone];
        copy.exampleidx = [self.exampleidx copyWithZone:zone];
        copy.monthage = self.monthage;
        copy.examplemovversion = [self.examplemovversion copyWithZone:zone];
        copy.typeid = [self.typeid copyWithZone:zone];
    }
    
    return copy;
}


@end
