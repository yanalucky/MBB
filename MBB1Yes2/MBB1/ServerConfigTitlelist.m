//
//  ServerConfigTitlelist.m
//
//  Created by  豆蒙萌 on 15/9/21
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "ServerConfigTitlelist.h"


NSString *const kServerConfigTitlelistId = @"id";
NSString *const kServerConfigTitlelistQuestionnaireid = @"questionnaireid";
NSString *const kServerConfigTitlelistTitle = @"title";
NSString *const kServerConfigTitlelistTitleorder = @"titleorder";
NSString *const kServerConfigTitlelistTitleid = @"titleid";


@interface ServerConfigTitlelist ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ServerConfigTitlelist

@synthesize titlelistIdentifier = _titlelistIdentifier;
@synthesize questionnaireid = _questionnaireid;
@synthesize title = _title;
@synthesize titleorder = _titleorder;
@synthesize titleid = _titleid;


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
            self.titlelistIdentifier = [self objectOrNilForKey:kServerConfigTitlelistId fromDictionary:dict];
            self.questionnaireid = [self objectOrNilForKey:kServerConfigTitlelistQuestionnaireid fromDictionary:dict];
            self.title = [self objectOrNilForKey:kServerConfigTitlelistTitle fromDictionary:dict];
            self.titleorder = [self objectOrNilForKey:kServerConfigTitlelistTitleorder fromDictionary:dict];
            self.titleid = [self objectOrNilForKey:kServerConfigTitlelistTitleid fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.titlelistIdentifier forKey:kServerConfigTitlelistId];
    [mutableDict setValue:self.questionnaireid forKey:kServerConfigTitlelistQuestionnaireid];
    [mutableDict setValue:self.title forKey:kServerConfigTitlelistTitle];
    [mutableDict setValue:self.titleorder forKey:kServerConfigTitlelistTitleorder];
    [mutableDict setValue:self.titleid forKey:kServerConfigTitlelistTitleid];

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

    self.titlelistIdentifier = [aDecoder decodeObjectForKey:kServerConfigTitlelistId];
    self.questionnaireid = [aDecoder decodeObjectForKey:kServerConfigTitlelistQuestionnaireid];
    self.title = [aDecoder decodeObjectForKey:kServerConfigTitlelistTitle];
    self.titleorder = [aDecoder decodeObjectForKey:kServerConfigTitlelistTitleorder];
    self.titleid = [aDecoder decodeObjectForKey:kServerConfigTitlelistTitleid];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_titlelistIdentifier forKey:kServerConfigTitlelistId];
    [aCoder encodeObject:_questionnaireid forKey:kServerConfigTitlelistQuestionnaireid];
    [aCoder encodeObject:_title forKey:kServerConfigTitlelistTitle];
    [aCoder encodeObject:_titleorder forKey:kServerConfigTitlelistTitleorder];
    [aCoder encodeObject:_titleid forKey:kServerConfigTitlelistTitleid];
}

- (id)copyWithZone:(NSZone *)zone
{
    ServerConfigTitlelist *copy = [[ServerConfigTitlelist alloc] init];
    
    if (copy) {

        copy.titlelistIdentifier = [self.titlelistIdentifier copyWithZone:zone];
        copy.questionnaireid = [self.questionnaireid copyWithZone:zone];
        copy.title = [self.title copyWithZone:zone];
        copy.titleorder = [self.titleorder copyWithZone:zone];
        copy.titleid = [self.titleid copyWithZone:zone];
    }
    
    return copy;
}


@end
