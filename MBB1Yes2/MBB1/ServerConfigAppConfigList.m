//
//  ServerConfigAppConfigList.m
//
//  Created by  豆蒙萌 on 15/9/21
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "ServerConfigAppConfigList.h"


NSString *const kServerConfigAppConfigListComfigimgversion = @"comfigimgversion";
NSString *const kServerConfigAppConfigListConfigkey = @"configkey";
NSString *const kServerConfigAppConfigListConfigtype = @"configtype";
NSString *const kServerConfigAppConfigListComfigimg = @"comfigimg";
NSString *const kServerConfigAppConfigListConfigvalue = @"configvalue";
NSString *const kServerConfigAppConfigListConfigid = @"configid";


@interface ServerConfigAppConfigList ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ServerConfigAppConfigList

@synthesize comfigimgversion = _comfigimgversion;
@synthesize configkey = _configkey;
@synthesize configtype = _configtype;
@synthesize comfigimg = _comfigimg;
@synthesize configvalue = _configvalue;
@synthesize configid = _configid;


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
            self.comfigimgversion = [self objectOrNilForKey:kServerConfigAppConfigListComfigimgversion fromDictionary:dict];
            self.configkey = [self objectOrNilForKey:kServerConfigAppConfigListConfigkey fromDictionary:dict];
            self.configtype = [self objectOrNilForKey:kServerConfigAppConfigListConfigtype fromDictionary:dict];
            self.comfigimg = [self objectOrNilForKey:kServerConfigAppConfigListComfigimg fromDictionary:dict];
            self.configvalue = [self objectOrNilForKey:kServerConfigAppConfigListConfigvalue fromDictionary:dict];
            self.configid = [self objectOrNilForKey:kServerConfigAppConfigListConfigid fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.comfigimgversion forKey:kServerConfigAppConfigListComfigimgversion];
    [mutableDict setValue:self.configkey forKey:kServerConfigAppConfigListConfigkey];
    [mutableDict setValue:self.configtype forKey:kServerConfigAppConfigListConfigtype];
    [mutableDict setValue:self.comfigimg forKey:kServerConfigAppConfigListComfigimg];
    [mutableDict setValue:self.configvalue forKey:kServerConfigAppConfigListConfigvalue];
    [mutableDict setValue:self.configid forKey:kServerConfigAppConfigListConfigid];

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

    self.comfigimgversion = [aDecoder decodeObjectForKey:kServerConfigAppConfigListComfigimgversion];
    self.configkey = [aDecoder decodeObjectForKey:kServerConfigAppConfigListConfigkey];
    self.configtype = [aDecoder decodeObjectForKey:kServerConfigAppConfigListConfigtype];
    self.comfigimg = [aDecoder decodeObjectForKey:kServerConfigAppConfigListComfigimg];
    self.configvalue = [aDecoder decodeObjectForKey:kServerConfigAppConfigListConfigvalue];
    self.configid = [aDecoder decodeObjectForKey:kServerConfigAppConfigListConfigid];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_comfigimgversion forKey:kServerConfigAppConfigListComfigimgversion];
    [aCoder encodeObject:_configkey forKey:kServerConfigAppConfigListConfigkey];
    [aCoder encodeObject:_configtype forKey:kServerConfigAppConfigListConfigtype];
    [aCoder encodeObject:_comfigimg forKey:kServerConfigAppConfigListComfigimg];
    [aCoder encodeObject:_configvalue forKey:kServerConfigAppConfigListConfigvalue];
    [aCoder encodeObject:_configid forKey:kServerConfigAppConfigListConfigid];
}

- (id)copyWithZone:(NSZone *)zone
{
    ServerConfigAppConfigList *copy = [[ServerConfigAppConfigList alloc] init];
    
    if (copy) {

        copy.comfigimgversion = [self.comfigimgversion copyWithZone:zone];
        copy.configkey = [self.configkey copyWithZone:zone];
        copy.configtype = [self.configtype copyWithZone:zone];
        copy.comfigimg = [self.comfigimg copyWithZone:zone];
        copy.configvalue = [self.configvalue copyWithZone:zone];
        copy.configid = [self.configid copyWithZone:zone];
    }
    
    return copy;
}


@end
