//
//  RecordStarTheLatestRecord.m
//
//  Created by   on 16/7/15
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "RecordStarTheLatestRecord.h"


NSString *const kRecordStarTheLatestRecordRecordstatus = @"recordstatus";
NSString *const kRecordStarTheLatestRecordRecordid = @"recordid";
NSString *const kRecordStarTheLatestRecordWeight = @"weight";
NSString *const kRecordStarTheLatestRecordHeight = @"height";


@interface RecordStarTheLatestRecord ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation RecordStarTheLatestRecord

@synthesize recordstatus = _recordstatus;
@synthesize recordid = _recordid;
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
            self.recordstatus = [self objectOrNilForKey:kRecordStarTheLatestRecordRecordstatus fromDictionary:dict];
            self.recordid = [self objectOrNilForKey:kRecordStarTheLatestRecordRecordid fromDictionary:dict];
            self.weight = [self objectOrNilForKey:kRecordStarTheLatestRecordWeight fromDictionary:dict];
            self.height = [self objectOrNilForKey:kRecordStarTheLatestRecordHeight fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.recordstatus forKey:kRecordStarTheLatestRecordRecordstatus];
    [mutableDict setValue:self.recordid forKey:kRecordStarTheLatestRecordRecordid];
    [mutableDict setValue:self.weight forKey:kRecordStarTheLatestRecordWeight];
    [mutableDict setValue:self.height forKey:kRecordStarTheLatestRecordHeight];

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

    self.recordstatus = [aDecoder decodeObjectForKey:kRecordStarTheLatestRecordRecordstatus];
    self.recordid = [aDecoder decodeObjectForKey:kRecordStarTheLatestRecordRecordid];
    self.weight = [aDecoder decodeObjectForKey:kRecordStarTheLatestRecordWeight];
    self.height = [aDecoder decodeObjectForKey:kRecordStarTheLatestRecordHeight];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_recordstatus forKey:kRecordStarTheLatestRecordRecordstatus];
    [aCoder encodeObject:_recordid forKey:kRecordStarTheLatestRecordRecordid];
    [aCoder encodeObject:_weight forKey:kRecordStarTheLatestRecordWeight];
    [aCoder encodeObject:_height forKey:kRecordStarTheLatestRecordHeight];
}

- (id)copyWithZone:(NSZone *)zone
{
    RecordStarTheLatestRecord *copy = [[RecordStarTheLatestRecord alloc] init];
    
    if (copy) {

        copy.recordstatus = [self.recordstatus copyWithZone:zone];
        copy.recordid = [self.recordid copyWithZone:zone];
        copy.weight = [self.weight copyWithZone:zone];
        copy.height = [self.height copyWithZone:zone];
    }
    
    return copy;
}


@end
