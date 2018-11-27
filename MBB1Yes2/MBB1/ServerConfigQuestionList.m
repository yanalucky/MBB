//
//  ServerConfigQuestionList.m
//
//  Created by  豆蒙萌 on 15/9/21
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "ServerConfigQuestionList.h"
#import "ServerConfigTitlelist.h"


NSString *const kServerConfigQuestionListId = @"id";
NSString *const kServerConfigQuestionListTitle = @"title";
NSString *const kServerConfigQuestionListTitlelist = @"titlelist";
NSString *const kServerConfigQuestionListStartmonth = @"startmonth";
NSString *const kServerConfigQuestionListEndmonth = @"endmonth";
NSString *const kServerConfigQuestionListIsuse = @"isuse";
NSString *const kServerConfigQuestionListId0 = @"id0";

@interface ServerConfigQuestionList ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ServerConfigQuestionList

@synthesize questionListIdentifier = _questionListIdentifier;
@synthesize title = _title;
@synthesize titlelist = _titlelist;
@synthesize startmonth = _startmonth;
@synthesize endmonth = _endmonth;
@synthesize isuse = _isuse;
@synthesize id0 = _id0;

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
            self.questionListIdentifier = [self objectOrNilForKey:kServerConfigQuestionListId fromDictionary:dict];
            self.title = [self objectOrNilForKey:kServerConfigQuestionListTitle fromDictionary:dict];
    NSObject *receivedServerConfigTitlelist = [dict objectForKey:kServerConfigQuestionListTitlelist];
    NSMutableArray *parsedServerConfigTitlelist = [NSMutableArray array];
    if ([receivedServerConfigTitlelist isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedServerConfigTitlelist) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedServerConfigTitlelist addObject:[ServerConfigTitlelist modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedServerConfigTitlelist isKindOfClass:[NSDictionary class]]) {
       [parsedServerConfigTitlelist addObject:[ServerConfigTitlelist modelObjectWithDictionary:(NSDictionary *)receivedServerConfigTitlelist]];
    }

    self.titlelist = [NSArray arrayWithArray:parsedServerConfigTitlelist];
            self.startmonth = [self objectOrNilForKey:kServerConfigQuestionListStartmonth fromDictionary:dict];
            self.endmonth = [self objectOrNilForKey:kServerConfigQuestionListEndmonth fromDictionary:dict];
            self.isuse = [self objectOrNilForKey:kServerConfigQuestionListIsuse fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.questionListIdentifier forKey:kServerConfigQuestionListId];
    [mutableDict setValue:self.title forKey:kServerConfigQuestionListTitle];
    NSMutableArray *tempArrayForTitlelist = [NSMutableArray array];
    for (NSObject *subArrayObject in self.titlelist) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForTitlelist addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForTitlelist addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForTitlelist] forKey:kServerConfigQuestionListTitlelist];
    [mutableDict setValue:self.startmonth forKey:kServerConfigQuestionListStartmonth];
    [mutableDict setValue:self.endmonth forKey:kServerConfigQuestionListEndmonth];
    [mutableDict setValue:self.isuse forKey:kServerConfigQuestionListIsuse];

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

    self.questionListIdentifier = [aDecoder decodeObjectForKey:kServerConfigQuestionListId];
    self.title = [aDecoder decodeObjectForKey:kServerConfigQuestionListTitle];
    self.titlelist = [aDecoder decodeObjectForKey:kServerConfigQuestionListTitlelist];
    self.startmonth = [aDecoder decodeObjectForKey:kServerConfigQuestionListStartmonth];
    self.endmonth = [aDecoder decodeObjectForKey:kServerConfigQuestionListEndmonth];
    self.isuse = [aDecoder decodeObjectForKey:kServerConfigQuestionListIsuse];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_questionListIdentifier forKey:kServerConfigQuestionListId];
    [aCoder encodeObject:_title forKey:kServerConfigQuestionListTitle];
    [aCoder encodeObject:_titlelist forKey:kServerConfigQuestionListTitlelist];
    [aCoder encodeObject:_startmonth forKey:kServerConfigQuestionListStartmonth];
    [aCoder encodeObject:_endmonth forKey:kServerConfigQuestionListEndmonth];
    [aCoder encodeObject:_isuse forKey:kServerConfigQuestionListIsuse];
}

- (id)copyWithZone:(NSZone *)zone
{
    ServerConfigQuestionList *copy = [[ServerConfigQuestionList alloc] init];
    
    if (copy) {

        copy.questionListIdentifier = [self.questionListIdentifier copyWithZone:zone];
        copy.title = [self.title copyWithZone:zone];
        copy.titlelist = [self.titlelist copyWithZone:zone];
        copy.startmonth = [self.startmonth copyWithZone:zone];
        copy.endmonth = [self.endmonth copyWithZone:zone];
        copy.isuse = [self.isuse copyWithZone:zone];
    }
    
    return copy;
}


@end
