//
//  RecordStarRecordStar.m
//
//  Created by   on 16/7/15
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "RecordStarRecordStar.h"


NSString *const kRecordStarRecordStarFeature = @"feature";
NSString *const kRecordStarRecordStarOther = @"other";
NSString *const kRecordStarRecordStarUserid = @"userid";
NSString *const kRecordStarRecordStarWeight = @"weight";
NSString *const kRecordStarRecordStarCacation = @"cacation";
NSString *const kRecordStarRecordStarHeadcircumference = @"headcircumference";
NSString *const kRecordStarRecordStarChestcircumference = @"chestcircumference";
NSString *const kRecordStarRecordStarUrinate = @"urinate";
NSString *const kRecordStarRecordStarBreastfeedingml = @"breastfeedingml";
NSString *const kRecordStarRecordStarMilkfeedingcount = @"milkfeedingcount";
NSString *const kRecordStarRecordStarMonthday = @"monthday";
NSString *const kRecordStarRecordStarMilkfeedingml = @"milkfeedingml";
NSString *const kRecordStarRecordStarQuestionid = @"questionid";
NSString *const kRecordStarRecordStarSubmittime = @"submittime";
NSString *const kRecordStarRecordStarRecordstatus = @"recordstatus";
NSString *const kRecordStarRecordStarCacationdays = @"cacationdays";
NSString *const kRecordStarRecordStarHeadCircumference = @"headCircumference";
NSString *const kRecordStarRecordStarReadtag = @"readtag";
NSString *const kRecordStarRecordStarHeight = @"height";
NSString *const kRecordStarRecordStarMonthendtime = @"monthendtime";
NSString *const kRecordStarRecordStarDaytimesleep = @"daytimesleep";
NSString *const kRecordStarRecordStarRecordtime = @"recordtime";
NSString *const kRecordStarRecordStarAge = @"age";
NSString *const kRecordStarRecordStarStar = @"star";
NSString *const kRecordStarRecordStarComplementarytype = @"complementarytype";
NSString *const kRecordStarRecordStarMonthstarttime = @"monthstarttime";
NSString *const kRecordStarRecordStarRecordid = @"recordid";
NSString *const kRecordStarRecordStarBreastfeedingcount = @"breastfeedingcount";
NSString *const kRecordStarRecordStarNighttimesleep = @"nighttimesleep";


@interface RecordStarRecordStar ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation RecordStarRecordStar

@synthesize feature = _feature;
@synthesize other = _other;
@synthesize userid = _userid;
@synthesize weight = _weight;
@synthesize cacation = _cacation;
@synthesize headcircumference = _headcircumference;
@synthesize chestcircumference = _chestcircumference;
@synthesize urinate = _urinate;
@synthesize breastfeedingml = _breastfeedingml;
@synthesize milkfeedingcount = _milkfeedingcount;
@synthesize monthday = _monthday;
@synthesize milkfeedingml = _milkfeedingml;
@synthesize questionid = _questionid;
@synthesize submittime = _submittime;
@synthesize recordstatus = _recordstatus;
@synthesize cacationdays = _cacationdays;
@synthesize headCircumference = _headCircumference;
@synthesize readtag = _readtag;
@synthesize height = _height;
@synthesize monthendtime = _monthendtime;
@synthesize daytimesleep = _daytimesleep;
@synthesize recordtime = _recordtime;
@synthesize age = _age;
@synthesize star = _star;
@synthesize complementarytype = _complementarytype;
@synthesize monthstarttime = _monthstarttime;
@synthesize recordid = _recordid;
@synthesize breastfeedingcount = _breastfeedingcount;
@synthesize nighttimesleep = _nighttimesleep;


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
            self.feature = [self objectOrNilForKey:kRecordStarRecordStarFeature fromDictionary:dict];
            self.other = [self objectOrNilForKey:kRecordStarRecordStarOther fromDictionary:dict];
            self.userid = [self objectOrNilForKey:kRecordStarRecordStarUserid fromDictionary:dict];
            self.weight = [self objectOrNilForKey:kRecordStarRecordStarWeight fromDictionary:dict];
            self.cacation = [self objectOrNilForKey:kRecordStarRecordStarCacation fromDictionary:dict];
            self.headcircumference = [self objectOrNilForKey:kRecordStarRecordStarHeadcircumference fromDictionary:dict];
            self.chestcircumference = [self objectOrNilForKey:kRecordStarRecordStarChestcircumference fromDictionary:dict];
            self.urinate = [self objectOrNilForKey:kRecordStarRecordStarUrinate fromDictionary:dict];
            self.breastfeedingml = [self objectOrNilForKey:kRecordStarRecordStarBreastfeedingml fromDictionary:dict];
            self.milkfeedingcount = [self objectOrNilForKey:kRecordStarRecordStarMilkfeedingcount fromDictionary:dict];
            self.monthday = [self objectOrNilForKey:kRecordStarRecordStarMonthday fromDictionary:dict];
            self.milkfeedingml = [self objectOrNilForKey:kRecordStarRecordStarMilkfeedingml fromDictionary:dict];
            self.questionid = [self objectOrNilForKey:kRecordStarRecordStarQuestionid fromDictionary:dict];
            self.submittime = [self objectOrNilForKey:kRecordStarRecordStarSubmittime fromDictionary:dict];
            self.recordstatus = [self objectOrNilForKey:kRecordStarRecordStarRecordstatus fromDictionary:dict];
            self.cacationdays = [self objectOrNilForKey:kRecordStarRecordStarCacationdays fromDictionary:dict];
            self.headCircumference = [self objectOrNilForKey:kRecordStarRecordStarHeadCircumference fromDictionary:dict];
            self.readtag = [self objectOrNilForKey:kRecordStarRecordStarReadtag fromDictionary:dict];
            self.height = [self objectOrNilForKey:kRecordStarRecordStarHeight fromDictionary:dict];
            self.monthendtime = [self objectOrNilForKey:kRecordStarRecordStarMonthendtime fromDictionary:dict];
            self.daytimesleep = [self objectOrNilForKey:kRecordStarRecordStarDaytimesleep fromDictionary:dict];
            self.recordtime = [self objectOrNilForKey:kRecordStarRecordStarRecordtime fromDictionary:dict];
            self.age = [self objectOrNilForKey:kRecordStarRecordStarAge fromDictionary:dict];
            self.star = [self objectOrNilForKey:kRecordStarRecordStarStar fromDictionary:dict];
            self.complementarytype = [self objectOrNilForKey:kRecordStarRecordStarComplementarytype fromDictionary:dict];
            self.monthstarttime = [self objectOrNilForKey:kRecordStarRecordStarMonthstarttime fromDictionary:dict];
            self.recordid = [self objectOrNilForKey:kRecordStarRecordStarRecordid fromDictionary:dict];
            self.breastfeedingcount = [self objectOrNilForKey:kRecordStarRecordStarBreastfeedingcount fromDictionary:dict];
            self.nighttimesleep = [self objectOrNilForKey:kRecordStarRecordStarNighttimesleep fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.feature forKey:kRecordStarRecordStarFeature];
    [mutableDict setValue:self.other forKey:kRecordStarRecordStarOther];
    [mutableDict setValue:self.userid forKey:kRecordStarRecordStarUserid];
    [mutableDict setValue:self.weight forKey:kRecordStarRecordStarWeight];
    [mutableDict setValue:self.cacation forKey:kRecordStarRecordStarCacation];
    [mutableDict setValue:self.headcircumference forKey:kRecordStarRecordStarHeadcircumference];
    [mutableDict setValue:self.chestcircumference forKey:kRecordStarRecordStarChestcircumference];
    [mutableDict setValue:self.urinate forKey:kRecordStarRecordStarUrinate];
    [mutableDict setValue:self.breastfeedingml forKey:kRecordStarRecordStarBreastfeedingml];
    [mutableDict setValue:self.milkfeedingcount forKey:kRecordStarRecordStarMilkfeedingcount];
    [mutableDict setValue:self.monthday forKey:kRecordStarRecordStarMonthday];
    [mutableDict setValue:self.milkfeedingml forKey:kRecordStarRecordStarMilkfeedingml];
    [mutableDict setValue:self.questionid forKey:kRecordStarRecordStarQuestionid];
    [mutableDict setValue:self.submittime forKey:kRecordStarRecordStarSubmittime];
    [mutableDict setValue:self.recordstatus forKey:kRecordStarRecordStarRecordstatus];
    [mutableDict setValue:self.cacationdays forKey:kRecordStarRecordStarCacationdays];
    [mutableDict setValue:self.headCircumference forKey:kRecordStarRecordStarHeadCircumference];
    [mutableDict setValue:self.readtag forKey:kRecordStarRecordStarReadtag];
    [mutableDict setValue:self.height forKey:kRecordStarRecordStarHeight];
    [mutableDict setValue:self.monthendtime forKey:kRecordStarRecordStarMonthendtime];
    [mutableDict setValue:self.daytimesleep forKey:kRecordStarRecordStarDaytimesleep];
    [mutableDict setValue:self.recordtime forKey:kRecordStarRecordStarRecordtime];
    [mutableDict setValue:self.age forKey:kRecordStarRecordStarAge];
    [mutableDict setValue:self.star forKey:kRecordStarRecordStarStar];
    [mutableDict setValue:self.complementarytype forKey:kRecordStarRecordStarComplementarytype];
    [mutableDict setValue:self.monthstarttime forKey:kRecordStarRecordStarMonthstarttime];
    [mutableDict setValue:self.recordid forKey:kRecordStarRecordStarRecordid];
    [mutableDict setValue:self.breastfeedingcount forKey:kRecordStarRecordStarBreastfeedingcount];
    [mutableDict setValue:self.nighttimesleep forKey:kRecordStarRecordStarNighttimesleep];

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

    self.feature = [aDecoder decodeObjectForKey:kRecordStarRecordStarFeature];
    self.other = [aDecoder decodeObjectForKey:kRecordStarRecordStarOther];
    self.userid = [aDecoder decodeObjectForKey:kRecordStarRecordStarUserid];
    self.weight = [aDecoder decodeObjectForKey:kRecordStarRecordStarWeight];
    self.cacation = [aDecoder decodeObjectForKey:kRecordStarRecordStarCacation];
    self.headcircumference = [aDecoder decodeObjectForKey:kRecordStarRecordStarHeadcircumference];
    self.chestcircumference = [aDecoder decodeObjectForKey:kRecordStarRecordStarChestcircumference];
    self.urinate = [aDecoder decodeObjectForKey:kRecordStarRecordStarUrinate];
    self.breastfeedingml = [aDecoder decodeObjectForKey:kRecordStarRecordStarBreastfeedingml];
    self.milkfeedingcount = [aDecoder decodeObjectForKey:kRecordStarRecordStarMilkfeedingcount];
    self.monthday = [aDecoder decodeObjectForKey:kRecordStarRecordStarMonthday];
    self.milkfeedingml = [aDecoder decodeObjectForKey:kRecordStarRecordStarMilkfeedingml];
    self.questionid = [aDecoder decodeObjectForKey:kRecordStarRecordStarQuestionid];
    self.submittime = [aDecoder decodeObjectForKey:kRecordStarRecordStarSubmittime];
    self.recordstatus = [aDecoder decodeObjectForKey:kRecordStarRecordStarRecordstatus];
    self.cacationdays = [aDecoder decodeObjectForKey:kRecordStarRecordStarCacationdays];
    self.headCircumference = [aDecoder decodeObjectForKey:kRecordStarRecordStarHeadCircumference];
    self.readtag = [aDecoder decodeObjectForKey:kRecordStarRecordStarReadtag];
    self.height = [aDecoder decodeObjectForKey:kRecordStarRecordStarHeight];
    self.monthendtime = [aDecoder decodeObjectForKey:kRecordStarRecordStarMonthendtime];
    self.daytimesleep = [aDecoder decodeObjectForKey:kRecordStarRecordStarDaytimesleep];
    self.recordtime = [aDecoder decodeObjectForKey:kRecordStarRecordStarRecordtime];
    self.age = [aDecoder decodeObjectForKey:kRecordStarRecordStarAge];
    self.star = [aDecoder decodeObjectForKey:kRecordStarRecordStarStar];
    self.complementarytype = [aDecoder decodeObjectForKey:kRecordStarRecordStarComplementarytype];
    self.monthstarttime = [aDecoder decodeObjectForKey:kRecordStarRecordStarMonthstarttime];
    self.recordid = [aDecoder decodeObjectForKey:kRecordStarRecordStarRecordid];
    self.breastfeedingcount = [aDecoder decodeObjectForKey:kRecordStarRecordStarBreastfeedingcount];
    self.nighttimesleep = [aDecoder decodeObjectForKey:kRecordStarRecordStarNighttimesleep];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_feature forKey:kRecordStarRecordStarFeature];
    [aCoder encodeObject:_other forKey:kRecordStarRecordStarOther];
    [aCoder encodeObject:_userid forKey:kRecordStarRecordStarUserid];
    [aCoder encodeObject:_weight forKey:kRecordStarRecordStarWeight];
    [aCoder encodeObject:_cacation forKey:kRecordStarRecordStarCacation];
    [aCoder encodeObject:_headcircumference forKey:kRecordStarRecordStarHeadcircumference];
    [aCoder encodeObject:_chestcircumference forKey:kRecordStarRecordStarChestcircumference];
    [aCoder encodeObject:_urinate forKey:kRecordStarRecordStarUrinate];
    [aCoder encodeObject:_breastfeedingml forKey:kRecordStarRecordStarBreastfeedingml];
    [aCoder encodeObject:_milkfeedingcount forKey:kRecordStarRecordStarMilkfeedingcount];
    [aCoder encodeObject:_monthday forKey:kRecordStarRecordStarMonthday];
    [aCoder encodeObject:_milkfeedingml forKey:kRecordStarRecordStarMilkfeedingml];
    [aCoder encodeObject:_questionid forKey:kRecordStarRecordStarQuestionid];
    [aCoder encodeObject:_submittime forKey:kRecordStarRecordStarSubmittime];
    [aCoder encodeObject:_recordstatus forKey:kRecordStarRecordStarRecordstatus];
    [aCoder encodeObject:_cacationdays forKey:kRecordStarRecordStarCacationdays];
    [aCoder encodeObject:_headCircumference forKey:kRecordStarRecordStarHeadCircumference];
    [aCoder encodeObject:_readtag forKey:kRecordStarRecordStarReadtag];
    [aCoder encodeObject:_height forKey:kRecordStarRecordStarHeight];
    [aCoder encodeObject:_monthendtime forKey:kRecordStarRecordStarMonthendtime];
    [aCoder encodeObject:_daytimesleep forKey:kRecordStarRecordStarDaytimesleep];
    [aCoder encodeObject:_recordtime forKey:kRecordStarRecordStarRecordtime];
    [aCoder encodeObject:_age forKey:kRecordStarRecordStarAge];
    [aCoder encodeObject:_star forKey:kRecordStarRecordStarStar];
    [aCoder encodeObject:_complementarytype forKey:kRecordStarRecordStarComplementarytype];
    [aCoder encodeObject:_monthstarttime forKey:kRecordStarRecordStarMonthstarttime];
    [aCoder encodeObject:_recordid forKey:kRecordStarRecordStarRecordid];
    [aCoder encodeObject:_breastfeedingcount forKey:kRecordStarRecordStarBreastfeedingcount];
    [aCoder encodeObject:_nighttimesleep forKey:kRecordStarRecordStarNighttimesleep];
}

- (id)copyWithZone:(NSZone *)zone
{
    RecordStarRecordStar *copy = [[RecordStarRecordStar alloc] init];
    
    if (copy) {

        copy.feature = [self.feature copyWithZone:zone];
        copy.other = [self.other copyWithZone:zone];
        copy.userid = [self.userid copyWithZone:zone];
        copy.weight = [self.weight copyWithZone:zone];
        copy.cacation = [self.cacation copyWithZone:zone];
        copy.headcircumference = [self.headcircumference copyWithZone:zone];
        copy.chestcircumference = [self.chestcircumference copyWithZone:zone];
        copy.urinate = [self.urinate copyWithZone:zone];
        copy.breastfeedingml = [self.breastfeedingml copyWithZone:zone];
        copy.milkfeedingcount = [self.milkfeedingcount copyWithZone:zone];
        copy.monthday = [self.monthday copyWithZone:zone];
        copy.milkfeedingml = [self.milkfeedingml copyWithZone:zone];
        copy.questionid = [self.questionid copyWithZone:zone];
        copy.submittime = [self.submittime copyWithZone:zone];
        copy.recordstatus = [self.recordstatus copyWithZone:zone];
        copy.cacationdays = [self.cacationdays copyWithZone:zone];
        copy.headCircumference = [self.headCircumference copyWithZone:zone];
        copy.readtag = [self.readtag copyWithZone:zone];
        copy.height = [self.height copyWithZone:zone];
        copy.monthendtime = [self.monthendtime copyWithZone:zone];
        copy.daytimesleep = [self.daytimesleep copyWithZone:zone];
        copy.recordtime = [self.recordtime copyWithZone:zone];
        copy.age = [self.age copyWithZone:zone];
        copy.star = [self.star copyWithZone:zone];
        copy.complementarytype = [self.complementarytype copyWithZone:zone];
        copy.monthstarttime = [self.monthstarttime copyWithZone:zone];
        copy.recordid = [self.recordid copyWithZone:zone];
        copy.breastfeedingcount = [self.breastfeedingcount copyWithZone:zone];
        copy.nighttimesleep = [self.nighttimesleep copyWithZone:zone];
    }
    
    return copy;
}


@end
