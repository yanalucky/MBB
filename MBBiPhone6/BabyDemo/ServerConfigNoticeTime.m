//
//  ServerConfigNoticeTime.m
//
//  Created by   on 16/6/21
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "ServerConfigNoticeTime.h"


NSString *const kServerConfigNoticeTimeHistorytime = @"historytime";


@interface ServerConfigNoticeTime ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ServerConfigNoticeTime

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
            self.historytime = [self objectOrNilForKey:kServerConfigNoticeTimeHistorytime fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.historytime forKey:kServerConfigNoticeTimeHistorytime];

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

    self.historytime = [aDecoder decodeObjectForKey:kServerConfigNoticeTimeHistorytime];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_historytime forKey:kServerConfigNoticeTimeHistorytime];
}

- (id)copyWithZone:(NSZone *)zone
{
    ServerConfigNoticeTime *copy = [[ServerConfigNoticeTime alloc] init];
    
    if (copy) {

        copy.historytime = [self.historytime copyWithZone:zone];
    }
    
    return copy;
}


@end
