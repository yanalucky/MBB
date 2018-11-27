//
//  RecordStarBabyBeforeRecord.m
//
//  Created by   on 16/7/15
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "RecordStarBabyBeforeRecord.h"


NSString *const kRecordStarBabyBeforeRecordAge = @"age";
NSString *const kRecordStarBabyBeforeRecordId = @"id";
NSString *const kRecordStarBabyBeforeRecordUserid = @"userid";
NSString *const kRecordStarBabyBeforeRecordWeight = @"weight";
NSString *const kRecordStarBabyBeforeRecordHeight = @"height";


@interface RecordStarBabyBeforeRecord ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation RecordStarBabyBeforeRecord

@synthesize age = _age;
@synthesize babyBeforeRecordIdentifier = _babyBeforeRecordIdentifier;
@synthesize userid = _userid;
@synthesize weight = _weight;
@synthesize height = _height;


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
            self.age = [self objectOrNilForKey:kRecordStarBabyBeforeRecordAge fromDictionary:dict];
            self.babyBeforeRecordIdentifier = [self objectOrNilForKey:kRecordStarBabyBeforeRecordId fromDictionary:dict];
            self.userid = [self objectOrNilForKey:kRecordStarBabyBeforeRecordUserid fromDictionary:dict];
            self.weight = [self objectOrNilForKey:kRecordStarBabyBeforeRecordWeight fromDictionary:dict];
            self.height = [self objectOrNilForKey:kRecordStarBabyBeforeRecordHeight fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.age forKey:kRecordStarBabyBeforeRecordAge];
    [mutableDict setValue:self.babyBeforeRecordIdentifier forKey:kRecordStarBabyBeforeRecordId];
    [mutableDict setValue:self.userid forKey:kRecordStarBabyBeforeRecordUserid];
    [mutableDict setValue:self.weight forKey:kRecordStarBabyBeforeRecordWeight];
    [mutableDict setValue:self.height forKey:kRecordStarBabyBeforeRecordHeight];

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

    self.age = [aDecoder decodeObjectForKey:kRecordStarBabyBeforeRecordAge];
    self.babyBeforeRecordIdentifier = [aDecoder decodeObjectForKey:kRecordStarBabyBeforeRecordId];
    self.userid = [aDecoder decodeObjectForKey:kRecordStarBabyBeforeRecordUserid];
    self.weight = [aDecoder decodeObjectForKey:kRecordStarBabyBeforeRecordWeight];
    self.height = [aDecoder decodeObjectForKey:kRecordStarBabyBeforeRecordHeight];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_age forKey:kRecordStarBabyBeforeRecordAge];
    [aCoder encodeObject:_babyBeforeRecordIdentifier forKey:kRecordStarBabyBeforeRecordId];
    [aCoder encodeObject:_userid forKey:kRecordStarBabyBeforeRecordUserid];
    [aCoder encodeObject:_weight forKey:kRecordStarBabyBeforeRecordWeight];
    [aCoder encodeObject:_height forKey:kRecordStarBabyBeforeRecordHeight];
}

- (id)copyWithZone:(NSZone *)zone
{
    RecordStarBabyBeforeRecord *copy = [[RecordStarBabyBeforeRecord alloc] init];
    
    if (copy) {

        copy.age = [self.age copyWithZone:zone];
        copy.babyBeforeRecordIdentifier = [self.babyBeforeRecordIdentifier copyWithZone:zone];
        copy.userid = [self.userid copyWithZone:zone];
        copy.weight = [self.weight copyWithZone:zone];
        copy.height = [self.height copyWithZone:zone];
    }
    
    return copy;
}


@end
