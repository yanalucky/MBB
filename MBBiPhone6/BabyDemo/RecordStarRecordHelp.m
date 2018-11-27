//
//  RecordStarRecordHelp.m
//
//  Created by   on 16/7/15
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "RecordStarRecordHelp.h"


NSString *const kRecordStarRecordHelpHeadcircumference = @"headcircumference";
NSString *const kRecordStarRecordHelpWeight = @"weight";
NSString *const kRecordStarRecordHelpHeight = @"height";
NSString *const kRecordStarRecordHelpId = @"id";
NSString *const kRecordStarRecordHelpAge = @"age";
NSString *const kRecordStarRecordHelpCacation = @"cacation";
NSString *const kRecordStarRecordHelpChestcircumference = @"chestcircumference";
NSString *const kRecordStarRecordHelpMilkamount = @"milkamount";
NSString *const kRecordStarRecordHelpShowitem = @"showitem";
NSString *const kRecordStarRecordHelpSleep = @"sleep";
NSString *const kRecordStarRecordHelpUrinate = @"urinate";


@interface RecordStarRecordHelp ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation RecordStarRecordHelp

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
            self.headcircumference = [self objectOrNilForKey:kRecordStarRecordHelpHeadcircumference fromDictionary:dict];
            self.weight = [self objectOrNilForKey:kRecordStarRecordHelpWeight fromDictionary:dict];
            self.height = [self objectOrNilForKey:kRecordStarRecordHelpHeight fromDictionary:dict];
            self.recordHelpIdentifier = [self objectOrNilForKey:kRecordStarRecordHelpId fromDictionary:dict];
            self.age = [self objectOrNilForKey:kRecordStarRecordHelpAge fromDictionary:dict];
            self.cacation = [self objectOrNilForKey:kRecordStarRecordHelpCacation fromDictionary:dict];
            self.chestcircumference = [self objectOrNilForKey:kRecordStarRecordHelpChestcircumference fromDictionary:dict];
            self.milkamount = [self objectOrNilForKey:kRecordStarRecordHelpMilkamount fromDictionary:dict];
            self.showitem = [self objectOrNilForKey:kRecordStarRecordHelpShowitem fromDictionary:dict];
            self.sleep = [self objectOrNilForKey:kRecordStarRecordHelpSleep fromDictionary:dict];
            self.urinate = [self objectOrNilForKey:kRecordStarRecordHelpUrinate fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.headcircumference forKey:kRecordStarRecordHelpHeadcircumference];
    [mutableDict setValue:self.weight forKey:kRecordStarRecordHelpWeight];
    [mutableDict setValue:self.height forKey:kRecordStarRecordHelpHeight];
    [mutableDict setValue:self.recordHelpIdentifier forKey:kRecordStarRecordHelpId];
    [mutableDict setValue:self.age forKey:kRecordStarRecordHelpAge];
    [mutableDict setValue:self.cacation forKey:kRecordStarRecordHelpCacation];
    [mutableDict setValue:self.chestcircumference forKey:kRecordStarRecordHelpChestcircumference];
    [mutableDict setValue:self.milkamount forKey:kRecordStarRecordHelpMilkamount];
    [mutableDict setValue:self.showitem forKey:kRecordStarRecordHelpShowitem];
    [mutableDict setValue:self.sleep forKey:kRecordStarRecordHelpSleep];
    [mutableDict setValue:self.urinate forKey:kRecordStarRecordHelpUrinate];

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

    self.headcircumference = [aDecoder decodeObjectForKey:kRecordStarRecordHelpHeadcircumference];
    self.weight = [aDecoder decodeObjectForKey:kRecordStarRecordHelpWeight];
    self.height = [aDecoder decodeObjectForKey:kRecordStarRecordHelpHeight];
    self.recordHelpIdentifier = [aDecoder decodeObjectForKey:kRecordStarRecordHelpId];
    self.age = [aDecoder decodeObjectForKey:kRecordStarRecordHelpAge];
    self.cacation = [aDecoder decodeObjectForKey:kRecordStarRecordHelpCacation];
    self.chestcircumference = [aDecoder decodeObjectForKey:kRecordStarRecordHelpChestcircumference];
    self.milkamount = [aDecoder decodeObjectForKey:kRecordStarRecordHelpMilkamount];
    self.showitem = [aDecoder decodeObjectForKey:kRecordStarRecordHelpShowitem];
    self.sleep = [aDecoder decodeObjectForKey:kRecordStarRecordHelpSleep];
    self.urinate = [aDecoder decodeObjectForKey:kRecordStarRecordHelpUrinate];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_headcircumference forKey:kRecordStarRecordHelpHeadcircumference];
    [aCoder encodeObject:_weight forKey:kRecordStarRecordHelpWeight];
    [aCoder encodeObject:_height forKey:kRecordStarRecordHelpHeight];
    [aCoder encodeObject:_recordHelpIdentifier forKey:kRecordStarRecordHelpId];
    [aCoder encodeObject:_age forKey:kRecordStarRecordHelpAge];
    [aCoder encodeObject:_cacation forKey:kRecordStarRecordHelpCacation];
    [aCoder encodeObject:_chestcircumference forKey:kRecordStarRecordHelpChestcircumference];
    [aCoder encodeObject:_milkamount forKey:kRecordStarRecordHelpMilkamount];
    [aCoder encodeObject:_showitem forKey:kRecordStarRecordHelpShowitem];
    [aCoder encodeObject:_sleep forKey:kRecordStarRecordHelpSleep];
    [aCoder encodeObject:_urinate forKey:kRecordStarRecordHelpUrinate];
}

- (id)copyWithZone:(NSZone *)zone
{
    RecordStarRecordHelp *copy = [[RecordStarRecordHelp alloc] init];
    
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
