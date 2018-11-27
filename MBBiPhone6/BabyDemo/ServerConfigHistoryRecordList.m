//
//  ServerConfigHistoryRecordList.m
//
//  Created by   on 16/6/21
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "ServerConfigHistoryRecordList.h"


NSString *const kServerConfigHistoryRecordListId = @"id";
NSString *const kServerConfigHistoryRecordListUserid = @"userid";
NSString *const kServerConfigHistoryRecordListHistorytype = @"historytype";
NSString *const kServerConfigHistoryRecordListHistorytime = @"historytime";


@interface ServerConfigHistoryRecordList ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ServerConfigHistoryRecordList

@synthesize historyRecordListIdentifier = _historyRecordListIdentifier;
@synthesize userid = _userid;
@synthesize historytype = _historytype;
@synthesize historytime = _historytime;


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
            self.historyRecordListIdentifier = [self objectOrNilForKey:kServerConfigHistoryRecordListId fromDictionary:dict];
            self.userid = [self objectOrNilForKey:kServerConfigHistoryRecordListUserid fromDictionary:dict];
            self.historytype = [self objectOrNilForKey:kServerConfigHistoryRecordListHistorytype fromDictionary:dict];
            self.historytime = [self objectOrNilForKey:kServerConfigHistoryRecordListHistorytime fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.historyRecordListIdentifier forKey:kServerConfigHistoryRecordListId];
    [mutableDict setValue:self.userid forKey:kServerConfigHistoryRecordListUserid];
    [mutableDict setValue:self.historytype forKey:kServerConfigHistoryRecordListHistorytype];
    [mutableDict setValue:self.historytime forKey:kServerConfigHistoryRecordListHistorytime];

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

    self.historyRecordListIdentifier = [aDecoder decodeObjectForKey:kServerConfigHistoryRecordListId];
    self.userid = [aDecoder decodeObjectForKey:kServerConfigHistoryRecordListUserid];
    self.historytype = [aDecoder decodeObjectForKey:kServerConfigHistoryRecordListHistorytype];
    self.historytime = [aDecoder decodeObjectForKey:kServerConfigHistoryRecordListHistorytime];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_historyRecordListIdentifier forKey:kServerConfigHistoryRecordListId];
    [aCoder encodeObject:_userid forKey:kServerConfigHistoryRecordListUserid];
    [aCoder encodeObject:_historytype forKey:kServerConfigHistoryRecordListHistorytype];
    [aCoder encodeObject:_historytime forKey:kServerConfigHistoryRecordListHistorytime];
}

- (id)copyWithZone:(NSZone *)zone
{
    ServerConfigHistoryRecordList *copy = [[ServerConfigHistoryRecordList alloc] init];
    
    if (copy) {

        copy.historyRecordListIdentifier = [self.historyRecordListIdentifier copyWithZone:zone];
        copy.userid = [self.userid copyWithZone:zone];
        copy.historytype = [self.historytype copyWithZone:zone];
        copy.historytime = [self.historytime copyWithZone:zone];
    }
    
    return copy;
}


@end
