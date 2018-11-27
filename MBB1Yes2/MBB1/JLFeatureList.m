//
//  JLFeatureList.m
//
//  Created by  豆蒙萌 on 15/10/29
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "JLFeatureList.h"


NSString *const kJLFeatureListId = @"id";
NSString *const kJLFeatureListDetailid = @"detailid";
NSString *const kJLFeatureListRecordid = @"recordid";


@interface JLFeatureList ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation JLFeatureList

@synthesize featureListIdentifier = _featureListIdentifier;
@synthesize detailid = _detailid;
@synthesize recordid = _recordid;


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
            self.featureListIdentifier = [self objectOrNilForKey:kJLFeatureListId fromDictionary:dict];
            self.detailid = [self objectOrNilForKey:kJLFeatureListDetailid fromDictionary:dict];
            self.recordid = [self objectOrNilForKey:kJLFeatureListRecordid fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.featureListIdentifier forKey:kJLFeatureListId];
    [mutableDict setValue:self.detailid forKey:kJLFeatureListDetailid];
    [mutableDict setValue:self.recordid forKey:kJLFeatureListRecordid];

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

    self.featureListIdentifier = [aDecoder decodeObjectForKey:kJLFeatureListId];
    self.detailid = [aDecoder decodeObjectForKey:kJLFeatureListDetailid];
    self.recordid = [aDecoder decodeObjectForKey:kJLFeatureListRecordid];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_featureListIdentifier forKey:kJLFeatureListId];
    [aCoder encodeObject:_detailid forKey:kJLFeatureListDetailid];
    [aCoder encodeObject:_recordid forKey:kJLFeatureListRecordid];
}

- (id)copyWithZone:(NSZone *)zone
{
    JLFeatureList *copy = [[JLFeatureList alloc] init];
    
    if (copy) {

        copy.featureListIdentifier = [self.featureListIdentifier copyWithZone:zone];
        copy.detailid = [self.detailid copyWithZone:zone];
        copy.recordid = [self.recordid copyWithZone:zone];
    }
    
    return copy;
}


@end
