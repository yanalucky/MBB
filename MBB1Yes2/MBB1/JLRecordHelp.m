//
//  JLRecordHelp.m
//
//  Created by  豆蒙萌 on 15/10/16
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "JLRecordHelp.h"


NSString *const kJLRecordHelpHeadcircumference = @"headcircumference";
NSString *const kJLRecordHelpWeight = @"weight";
NSString *const kJLRecordHelpHeight = @"height";
NSString *const kJLRecordHelpId = @"id";
NSString *const kJLRecordHelpAge = @"age";
NSString *const kJLRecordHelpCacation = @"cacation";
NSString *const kJLRecordHelpChestcircumference = @"chestcircumference";
NSString *const kJLRecordHelpMilkamount = @"milkamount";
NSString *const kJLRecordHelpShowitem = @"showitem";
NSString *const kJLRecordHelpSleep = @"sleep";
NSString *const kJLRecordHelpUrinate = @"urinate";


@interface JLRecordHelp ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation JLRecordHelp

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
            self.headcircumference = [self objectOrNilForKey:kJLRecordHelpHeadcircumference fromDictionary:dict];
            self.weight = [self objectOrNilForKey:kJLRecordHelpWeight fromDictionary:dict];
            self.height = [self objectOrNilForKey:kJLRecordHelpHeight fromDictionary:dict];
            self.recordHelpIdentifier = [self objectOrNilForKey:kJLRecordHelpId fromDictionary:dict];
            self.age = [self objectOrNilForKey:kJLRecordHelpAge fromDictionary:dict];
            self.cacation = [self objectOrNilForKey:kJLRecordHelpCacation fromDictionary:dict];
            self.chestcircumference = [self objectOrNilForKey:kJLRecordHelpChestcircumference fromDictionary:dict];
            self.milkamount = [self objectOrNilForKey:kJLRecordHelpMilkamount fromDictionary:dict];
            self.showitem = [self objectOrNilForKey:kJLRecordHelpShowitem fromDictionary:dict];
            self.sleep = [self objectOrNilForKey:kJLRecordHelpSleep fromDictionary:dict];
            self.urinate = [self objectOrNilForKey:kJLRecordHelpUrinate fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.headcircumference forKey:kJLRecordHelpHeadcircumference];
    [mutableDict setValue:self.weight forKey:kJLRecordHelpWeight];
    [mutableDict setValue:self.height forKey:kJLRecordHelpHeight];
    [mutableDict setValue:self.recordHelpIdentifier forKey:kJLRecordHelpId];
    [mutableDict setValue:self.age forKey:kJLRecordHelpAge];
    [mutableDict setValue:self.cacation forKey:kJLRecordHelpCacation];
    [mutableDict setValue:self.chestcircumference forKey:kJLRecordHelpChestcircumference];
    [mutableDict setValue:self.milkamount forKey:kJLRecordHelpMilkamount];
    [mutableDict setValue:self.showitem forKey:kJLRecordHelpShowitem];
    [mutableDict setValue:self.sleep forKey:kJLRecordHelpSleep];
    [mutableDict setValue:self.urinate forKey:kJLRecordHelpUrinate];

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

    self.headcircumference = [aDecoder decodeObjectForKey:kJLRecordHelpHeadcircumference];
    self.weight = [aDecoder decodeObjectForKey:kJLRecordHelpWeight];
    self.height = [aDecoder decodeObjectForKey:kJLRecordHelpHeight];
    self.recordHelpIdentifier = [aDecoder decodeObjectForKey:kJLRecordHelpId];
    self.age = [aDecoder decodeObjectForKey:kJLRecordHelpAge];
    self.cacation = [aDecoder decodeObjectForKey:kJLRecordHelpCacation];
    self.chestcircumference = [aDecoder decodeObjectForKey:kJLRecordHelpChestcircumference];
    self.milkamount = [aDecoder decodeObjectForKey:kJLRecordHelpMilkamount];
    self.showitem = [aDecoder decodeObjectForKey:kJLRecordHelpShowitem];
    self.sleep = [aDecoder decodeObjectForKey:kJLRecordHelpSleep];
    self.urinate = [aDecoder decodeObjectForKey:kJLRecordHelpUrinate];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_headcircumference forKey:kJLRecordHelpHeadcircumference];
    [aCoder encodeObject:_weight forKey:kJLRecordHelpWeight];
    [aCoder encodeObject:_height forKey:kJLRecordHelpHeight];
    [aCoder encodeObject:_recordHelpIdentifier forKey:kJLRecordHelpId];
    [aCoder encodeObject:_age forKey:kJLRecordHelpAge];
    [aCoder encodeObject:_cacation forKey:kJLRecordHelpCacation];
    [aCoder encodeObject:_chestcircumference forKey:kJLRecordHelpChestcircumference];
    [aCoder encodeObject:_milkamount forKey:kJLRecordHelpMilkamount];
    [aCoder encodeObject:_showitem forKey:kJLRecordHelpShowitem];
    [aCoder encodeObject:_sleep forKey:kJLRecordHelpSleep];
    [aCoder encodeObject:_urinate forKey:kJLRecordHelpUrinate];
}

- (id)copyWithZone:(NSZone *)zone
{
    JLRecordHelp *copy = [[JLRecordHelp alloc] init];
    
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
