//
//  ServerConfigTheLatestRecord.m
//
//  Created by   on 16/6/21
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "ServerConfigTheLatestRecord.h"


NSString *const kServerConfigTheLatestRecordRecordstatus = @"recordstatus";
NSString *const kServerConfigTheLatestRecordRecordid = @"recordid";


@interface ServerConfigTheLatestRecord ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ServerConfigTheLatestRecord

@synthesize recordstatus = _recordstatus;
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
            self.recordstatus = [self objectOrNilForKey:kServerConfigTheLatestRecordRecordstatus fromDictionary:dict];
            self.recordid = [self objectOrNilForKey:kServerConfigTheLatestRecordRecordid fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.recordstatus forKey:kServerConfigTheLatestRecordRecordstatus];
    [mutableDict setValue:self.recordid forKey:kServerConfigTheLatestRecordRecordid];

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

    self.recordstatus = [aDecoder decodeObjectForKey:kServerConfigTheLatestRecordRecordstatus];
    self.recordid = [aDecoder decodeObjectForKey:kServerConfigTheLatestRecordRecordid];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_recordstatus forKey:kServerConfigTheLatestRecordRecordstatus];
    [aCoder encodeObject:_recordid forKey:kServerConfigTheLatestRecordRecordid];
}

- (id)copyWithZone:(NSZone *)zone
{
    ServerConfigTheLatestRecord *copy = [[ServerConfigTheLatestRecord alloc] init];
    
    if (copy) {

        copy.recordstatus = [self.recordstatus copyWithZone:zone];
        copy.recordid = [self.recordid copyWithZone:zone];
    }
    
    return copy;
}


@end
