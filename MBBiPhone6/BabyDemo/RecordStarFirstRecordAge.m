//
//  RecordStarFirstRecordAge.m
//
//  Created by   on 16/7/15
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "RecordStarFirstRecordAge.h"


NSString *const kRecordStarFirstRecordAgeAge = @"age";


@interface RecordStarFirstRecordAge ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation RecordStarFirstRecordAge

@synthesize age = _age;


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
            self.age = [self objectOrNilForKey:kRecordStarFirstRecordAgeAge fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.age forKey:kRecordStarFirstRecordAgeAge];

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

    self.age = [aDecoder decodeObjectForKey:kRecordStarFirstRecordAgeAge];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_age forKey:kRecordStarFirstRecordAgeAge];
}

- (id)copyWithZone:(NSZone *)zone
{
    RecordStarFirstRecordAge *copy = [[RecordStarFirstRecordAge alloc] init];
    
    if (copy) {

        copy.age = [self.age copyWithZone:zone];
    }
    
    return copy;
}


@end
