//
//  RecordStarObject.m
//
//  Created by   on 16/7/15
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "RecordStarObject.h"
#import "RecordStarResult.h"


NSString *const kRecordStarObjectResult = @"result";
NSString *const kRecordStarObjectErrorId = @"errorId";
NSString *const kRecordStarObjectServerTime = @"serverTime";


@interface RecordStarObject ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation RecordStarObject

@synthesize result = _result;
@synthesize errorId = _errorId;
@synthesize serverTime = _serverTime;


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
            self.result = [RecordStarResult modelObjectWithDictionary:[dict objectForKey:kRecordStarObjectResult]];
            self.errorId = [[self objectOrNilForKey:kRecordStarObjectErrorId fromDictionary:dict] doubleValue];
            self.serverTime = [self objectOrNilForKey:kRecordStarObjectServerTime fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[self.result dictionaryRepresentation] forKey:kRecordStarObjectResult];
    [mutableDict setValue:[NSNumber numberWithDouble:self.errorId] forKey:kRecordStarObjectErrorId];
    [mutableDict setValue:self.serverTime forKey:kRecordStarObjectServerTime];

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

    self.result = [aDecoder decodeObjectForKey:kRecordStarObjectResult];
    self.errorId = [aDecoder decodeDoubleForKey:kRecordStarObjectErrorId];
    self.serverTime = [aDecoder decodeObjectForKey:kRecordStarObjectServerTime];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_result forKey:kRecordStarObjectResult];
    [aCoder encodeDouble:_errorId forKey:kRecordStarObjectErrorId];
    [aCoder encodeObject:_serverTime forKey:kRecordStarObjectServerTime];
}

- (id)copyWithZone:(NSZone *)zone
{
    RecordStarObject *copy = [[RecordStarObject alloc] init];
    
    if (copy) {

        copy.result = [self.result copyWithZone:zone];
        copy.errorId = self.errorId;
        copy.serverTime = [self.serverTime copyWithZone:zone];
    }
    
    return copy;
}


@end
