//
//  LoginUserRecordHelp.m
//
//  Created by  豆蒙萌 on 15/9/23
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "LoginUserRecordHelp.h"


NSString *const kLoginUserRecordHelpHeadcircumference = @"headcircumference";
NSString *const kLoginUserRecordHelpWeight = @"weight";
NSString *const kLoginUserRecordHelpHeight = @"height";
NSString *const kLoginUserRecordHelpId = @"id";
NSString *const kLoginUserRecordHelpAge = @"age";
NSString *const kLoginUserRecordHelpCacation = @"cacation";
NSString *const kLoginUserRecordHelpChestcircumference = @"chestcircumference";
NSString *const kLoginUserRecordHelpMilkamount = @"milkamount";
NSString *const kLoginUserRecordHelpShowitem = @"showitem";
NSString *const kLoginUserRecordHelpSleep = @"sleep";
NSString *const kLoginUserRecordHelpUrinate = @"urinate";


@interface LoginUserRecordHelp ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation LoginUserRecordHelp

@synthesize headcircumference = _headcircumference;
@synthesize weight = _weight;
@synthesize height = _height;
@synthesize recordHelpIdentifier = _recordHelpIdentifier;
@synthesize age = _age;
@synthesize cacation = _cacation;
@synthesize chestcircumference = _chestcircumference;
@synthesize milkamount = _milkamount;
@synthesize showitem = _showitem;
@synthesize sleep = _sleep;
@synthesize urinate = _urinate;


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
            self.headcircumference = [self objectOrNilForKey:kLoginUserRecordHelpHeadcircumference fromDictionary:dict];
            self.weight = [self objectOrNilForKey:kLoginUserRecordHelpWeight fromDictionary:dict];
            self.height = [self objectOrNilForKey:kLoginUserRecordHelpHeight fromDictionary:dict];
            self.recordHelpIdentifier = [self objectOrNilForKey:kLoginUserRecordHelpId fromDictionary:dict];
            self.age = [self objectOrNilForKey:kLoginUserRecordHelpAge fromDictionary:dict];
            self.cacation = [self objectOrNilForKey:kLoginUserRecordHelpCacation fromDictionary:dict];
            self.chestcircumference = [self objectOrNilForKey:kLoginUserRecordHelpChestcircumference fromDictionary:dict];
            self.milkamount = [self objectOrNilForKey:kLoginUserRecordHelpMilkamount fromDictionary:dict];
            self.showitem = [self objectOrNilForKey:kLoginUserRecordHelpShowitem fromDictionary:dict];
            self.sleep = [self objectOrNilForKey:kLoginUserRecordHelpSleep fromDictionary:dict];
            self.urinate = [self objectOrNilForKey:kLoginUserRecordHelpUrinate fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.headcircumference forKey:kLoginUserRecordHelpHeadcircumference];
    [mutableDict setValue:self.weight forKey:kLoginUserRecordHelpWeight];
    [mutableDict setValue:self.height forKey:kLoginUserRecordHelpHeight];
    [mutableDict setValue:self.recordHelpIdentifier forKey:kLoginUserRecordHelpId];
    [mutableDict setValue:self.age forKey:kLoginUserRecordHelpAge];
    [mutableDict setValue:self.cacation forKey:kLoginUserRecordHelpCacation];
    [mutableDict setValue:self.chestcircumference forKey:kLoginUserRecordHelpChestcircumference];
    [mutableDict setValue:self.milkamount forKey:kLoginUserRecordHelpMilkamount];
    [mutableDict setValue:self.showitem forKey:kLoginUserRecordHelpShowitem];
    [mutableDict setValue:self.sleep forKey:kLoginUserRecordHelpSleep];
    [mutableDict setValue:self.urinate forKey:kLoginUserRecordHelpUrinate];

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

    self.headcircumference = [aDecoder decodeObjectForKey:kLoginUserRecordHelpHeadcircumference];
    self.weight = [aDecoder decodeObjectForKey:kLoginUserRecordHelpWeight];
    self.height = [aDecoder decodeObjectForKey:kLoginUserRecordHelpHeight];
    self.recordHelpIdentifier = [aDecoder decodeObjectForKey:kLoginUserRecordHelpId];
    self.age = [aDecoder decodeObjectForKey:kLoginUserRecordHelpAge];
    self.cacation = [aDecoder decodeObjectForKey:kLoginUserRecordHelpCacation];
    self.chestcircumference = [aDecoder decodeObjectForKey:kLoginUserRecordHelpChestcircumference];
    self.milkamount = [aDecoder decodeObjectForKey:kLoginUserRecordHelpMilkamount];
    self.showitem = [aDecoder decodeObjectForKey:kLoginUserRecordHelpShowitem];
    self.sleep = [aDecoder decodeObjectForKey:kLoginUserRecordHelpSleep];
    self.urinate = [aDecoder decodeObjectForKey:kLoginUserRecordHelpUrinate];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_headcircumference forKey:kLoginUserRecordHelpHeadcircumference];
    [aCoder encodeObject:_weight forKey:kLoginUserRecordHelpWeight];
    [aCoder encodeObject:_height forKey:kLoginUserRecordHelpHeight];
    [aCoder encodeObject:_recordHelpIdentifier forKey:kLoginUserRecordHelpId];
    [aCoder encodeObject:_age forKey:kLoginUserRecordHelpAge];
    [aCoder encodeObject:_cacation forKey:kLoginUserRecordHelpCacation];
    [aCoder encodeObject:_chestcircumference forKey:kLoginUserRecordHelpChestcircumference];
    [aCoder encodeObject:_milkamount forKey:kLoginUserRecordHelpMilkamount];
    [aCoder encodeObject:_showitem forKey:kLoginUserRecordHelpShowitem];
    [aCoder encodeObject:_sleep forKey:kLoginUserRecordHelpSleep];
    [aCoder encodeObject:_urinate forKey:kLoginUserRecordHelpUrinate];
}

- (id)copyWithZone:(NSZone *)zone
{
    LoginUserRecordHelp *copy = [[LoginUserRecordHelp alloc] init];
    
    if (copy) {

        copy.headcircumference = [self.headcircumference copyWithZone:zone];
        copy.weight = [self.weight copyWithZone:zone];
        copy.height = [self.height copyWithZone:zone];
        copy.recordHelpIdentifier = [self.recordHelpIdentifier copyWithZone:zone];
        copy.age = [self.age copyWithZone:zone];
        copy.cacation = [self.cacation copyWithZone:zone];
        copy.chestcircumference = [self.chestcircumference copyWithZone:zone];
        copy.milkamount = [self.milkamount copyWithZone:zone];
        copy.showitem = [self.showitem copyWithZone:zone];
        copy.sleep = [self.sleep copyWithZone:zone];
        copy.urinate = [self.urinate copyWithZone:zone];
    }
    
    return copy;
}


@end
