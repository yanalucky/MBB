//
//  ServerConfigFeatureList.m
//
//  Created by   on 16/6/21
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "ServerConfigFeatureList.h"


NSString *const kServerConfigFeatureListId = @"id";
NSString *const kServerConfigFeatureListDetaildesc = @"detaildesc";
NSString *const kServerConfigFeatureListAge = @"age";
NSString *const kServerConfigFeatureListFeaturename = @"featurename";
NSString *const kServerConfigFeatureListExamplemovidx = @"examplemovidx";
NSString *const kServerConfigFeatureListFeatureorder = @"featureorder";
NSString *const kServerConfigFeatureListExampleimg = @"exampleimg";
NSString *const kServerConfigFeatureListExampleimgversion = @"exampleimgversion";
NSString *const kServerConfigFeatureListPointtag = @"pointtag";
NSString *const kServerConfigFeatureListExamplemov = @"examplemov";
NSString *const kServerConfigFeatureListExampleidx = @"exampleidx";
NSString *const kServerConfigFeatureListMonthage = @"monthage";
NSString *const kServerConfigFeatureListExamplemovversion = @"examplemovversion";
NSString *const kServerConfigFeatureListTypeid = @"typeid";


@interface ServerConfigFeatureList ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ServerConfigFeatureList

@synthesize featureListIdentifier = _featureListIdentifier;
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
            self.featureListIdentifier = [self objectOrNilForKey:kServerConfigFeatureListId fromDictionary:dict];
            self.detaildesc = [self objectOrNilForKey:kServerConfigFeatureListDetaildesc fromDictionary:dict];
            self.age = [self objectOrNilForKey:kServerConfigFeatureListAge fromDictionary:dict];
            self.featurename = [self objectOrNilForKey:kServerConfigFeatureListFeaturename fromDictionary:dict];
            self.examplemovidx = [self objectOrNilForKey:kServerConfigFeatureListExamplemovidx fromDictionary:dict];
            self.featureorder = [self objectOrNilForKey:kServerConfigFeatureListFeatureorder fromDictionary:dict];
            self.exampleimg = [self objectOrNilForKey:kServerConfigFeatureListExampleimg fromDictionary:dict];
            self.exampleimgversion = [self objectOrNilForKey:kServerConfigFeatureListExampleimgversion fromDictionary:dict];
            self.pointtag = [self objectOrNilForKey:kServerConfigFeatureListPointtag fromDictionary:dict];
            self.examplemov = [self objectOrNilForKey:kServerConfigFeatureListExamplemov fromDictionary:dict];
            self.exampleidx = [self objectOrNilForKey:kServerConfigFeatureListExampleidx fromDictionary:dict];
            self.monthage = [[self objectOrNilForKey:kServerConfigFeatureListMonthage fromDictionary:dict] doubleValue];
            self.examplemovversion = [self objectOrNilForKey:kServerConfigFeatureListExamplemovversion fromDictionary:dict];
            self.typeid = [self objectOrNilForKey:kServerConfigFeatureListTypeid fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.featureListIdentifier forKey:kServerConfigFeatureListId];
    [mutableDict setValue:self.detaildesc forKey:kServerConfigFeatureListDetaildesc];
    [mutableDict setValue:self.age forKey:kServerConfigFeatureListAge];
    [mutableDict setValue:self.featurename forKey:kServerConfigFeatureListFeaturename];
    [mutableDict setValue:self.examplemovidx forKey:kServerConfigFeatureListExamplemovidx];
    [mutableDict setValue:self.featureorder forKey:kServerConfigFeatureListFeatureorder];
    [mutableDict setValue:self.exampleimg forKey:kServerConfigFeatureListExampleimg];
    [mutableDict setValue:self.exampleimgversion forKey:kServerConfigFeatureListExampleimgversion];
    [mutableDict setValue:self.pointtag forKey:kServerConfigFeatureListPointtag];
    [mutableDict setValue:self.examplemov forKey:kServerConfigFeatureListExamplemov];
    [mutableDict setValue:self.exampleidx forKey:kServerConfigFeatureListExampleidx];
    [mutableDict setValue:[NSNumber numberWithDouble:self.monthage] forKey:kServerConfigFeatureListMonthage];
    [mutableDict setValue:self.examplemovversion forKey:kServerConfigFeatureListExamplemovversion];
    [mutableDict setValue:self.typeid forKey:kServerConfigFeatureListTypeid];

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

    self.featureListIdentifier = [aDecoder decodeObjectForKey:kServerConfigFeatureListId];
    self.detaildesc = [aDecoder decodeObjectForKey:kServerConfigFeatureListDetaildesc];
    self.age = [aDecoder decodeObjectForKey:kServerConfigFeatureListAge];
    self.featurename = [aDecoder decodeObjectForKey:kServerConfigFeatureListFeaturename];
    self.examplemovidx = [aDecoder decodeObjectForKey:kServerConfigFeatureListExamplemovidx];
    self.featureorder = [aDecoder decodeObjectForKey:kServerConfigFeatureListFeatureorder];
    self.exampleimg = [aDecoder decodeObjectForKey:kServerConfigFeatureListExampleimg];
    self.exampleimgversion = [aDecoder decodeObjectForKey:kServerConfigFeatureListExampleimgversion];
    self.pointtag = [aDecoder decodeObjectForKey:kServerConfigFeatureListPointtag];
    self.examplemov = [aDecoder decodeObjectForKey:kServerConfigFeatureListExamplemov];
    self.exampleidx = [aDecoder decodeObjectForKey:kServerConfigFeatureListExampleidx];
    self.monthage = [aDecoder decodeDoubleForKey:kServerConfigFeatureListMonthage];
    self.examplemovversion = [aDecoder decodeObjectForKey:kServerConfigFeatureListExamplemovversion];
    self.typeid = [aDecoder decodeObjectForKey:kServerConfigFeatureListTypeid];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_featureListIdentifier forKey:kServerConfigFeatureListId];
    [aCoder encodeObject:_detaildesc forKey:kServerConfigFeatureListDetaildesc];
    [aCoder encodeObject:_age forKey:kServerConfigFeatureListAge];
    [aCoder encodeObject:_featurename forKey:kServerConfigFeatureListFeaturename];
    [aCoder encodeObject:_examplemovidx forKey:kServerConfigFeatureListExamplemovidx];
    [aCoder encodeObject:_featureorder forKey:kServerConfigFeatureListFeatureorder];
    [aCoder encodeObject:_exampleimg forKey:kServerConfigFeatureListExampleimg];
    [aCoder encodeObject:_exampleimgversion forKey:kServerConfigFeatureListExampleimgversion];
    [aCoder encodeObject:_pointtag forKey:kServerConfigFeatureListPointtag];
    [aCoder encodeObject:_examplemov forKey:kServerConfigFeatureListExamplemov];
    [aCoder encodeObject:_exampleidx forKey:kServerConfigFeatureListExampleidx];
    [aCoder encodeDouble:_monthage forKey:kServerConfigFeatureListMonthage];
    [aCoder encodeObject:_examplemovversion forKey:kServerConfigFeatureListExamplemovversion];
    [aCoder encodeObject:_typeid forKey:kServerConfigFeatureListTypeid];
}

- (id)copyWithZone:(NSZone *)zone
{
    ServerConfigFeatureList *copy = [[ServerConfigFeatureList alloc] init];
    
    if (copy) {

        copy.featureListIdentifier = [self.featureListIdentifier copyWithZone:zone];
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
