//
//  RecordStarUserRecord.m
//
//  Created by   on 16/7/15
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "RecordStarUserRecord.h"
#import "RecordStarRecordHelp.h"


NSString *const kRecordStarUserRecordFeature = @"feature";
NSString *const kRecordStarUserRecordOther = @"other";
NSString *const kRecordStarUserRecordUserid = @"userid";
NSString *const kRecordStarUserRecordWeight = @"weight";
NSString *const kRecordStarUserRecordCacation = @"cacation";
NSString *const kRecordStarUserRecordHeadcircumference = @"headcircumference";
NSString *const kRecordStarUserRecordChestcircumference = @"chestcircumference";
NSString *const kRecordStarUserRecordUrinate = @"urinate";
NSString *const kRecordStarUserRecordBreastfeedingml = @"breastfeedingml";
NSString *const kRecordStarUserRecordMilkfeedingcount = @"milkfeedingcount";
NSString *const kRecordStarUserRecordMonthday = @"monthday";
NSString *const kRecordStarUserRecordMilkfeedingml = @"milkfeedingml";
NSString *const kRecordStarUserRecordQuestionid = @"questionid";
NSString *const kRecordStarUserRecordSubmittime = @"submittime";
NSString *const kRecordStarUserRecordRecordstatus = @"recordstatus";
NSString *const kRecordStarUserRecordCacationdays = @"cacationdays";
NSString *const kRecordStarUserRecordReadtag = @"readtag";
NSString *const kRecordStarUserRecordHeight = @"height";
NSString *const kRecordStarUserRecordMonthendtime = @"monthendtime";
NSString *const kRecordStarUserRecordDaytimesleep = @"daytimesleep";
NSString *const kRecordStarUserRecordRecordtime = @"recordtime";
NSString *const kRecordStarUserRecordAge = @"age";
NSString *const kRecordStarUserRecordRecordHelp = @"recordHelp";
NSString *const kRecordStarUserRecordComplementarytype = @"complementarytype";
NSString *const kRecordStarUserRecordMonthstarttime = @"monthstarttime";
NSString *const kRecordStarUserRecordRecordid = @"recordid";
NSString *const kRecordStarUserRecordBreastfeedingcount = @"breastfeedingcount";
NSString *const kRecordStarUserRecordNighttimesleep = @"nighttimesleep";


@interface RecordStarUserRecord ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation RecordStarUserRecord

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
@synthesize readtag = _readtag;
@synthesize height = _height;
@synthesize monthendtime = _monthendtime;
@synthesize daytimesleep = _daytimesleep;
@synthesize recordtime = _recordtime;
@synthesize age = _age;
@synthesize recordHelp = _recordHelp;
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
            self.feature = [self objectOrNilForKey:kRecordStarUserRecordFeature fromDictionary:dict];
            self.other = [self objectOrNilForKey:kRecordStarUserRecordOther fromDictionary:dict];
            self.userid = [self objectOrNilForKey:kRecordStarUserRecordUserid fromDictionary:dict];
            self.weight = [self objectOrNilForKey:kRecordStarUserRecordWeight fromDictionary:dict];
            self.cacation = [self objectOrNilForKey:kRecordStarUserRecordCacation fromDictionary:dict];
            self.headcircumference = [self objectOrNilForKey:kRecordStarUserRecordHeadcircumference fromDictionary:dict];
            self.chestcircumference = [self objectOrNilForKey:kRecordStarUserRecordChestcircumference fromDictionary:dict];
            self.urinate = [self objectOrNilForKey:kRecordStarUserRecordUrinate fromDictionary:dict];
            self.breastfeedingml = [self objectOrNilForKey:kRecordStarUserRecordBreastfeedingml fromDictionary:dict];
            self.milkfeedingcount = [self objectOrNilForKey:kRecordStarUserRecordMilkfeedingcount fromDictionary:dict];
            self.monthday = [self objectOrNilForKey:kRecordStarUserRecordMonthday fromDictionary:dict];
            self.milkfeedingml = [self objectOrNilForKey:kRecordStarUserRecordMilkfeedingml fromDictionary:dict];
            self.questionid = [self objectOrNilForKey:kRecordStarUserRecordQuestionid fromDictionary:dict];
            self.submittime = [self objectOrNilForKey:kRecordStarUserRecordSubmittime fromDictionary:dict];
            self.recordstatus = [self objectOrNilForKey:kRecordStarUserRecordRecordstatus fromDictionary:dict];
            self.cacationdays = [self objectOrNilForKey:kRecordStarUserRecordCacationdays fromDictionary:dict];
            self.readtag = [self objectOrNilForKey:kRecordStarUserRecordReadtag fromDictionary:dict];
            self.height = [self objectOrNilForKey:kRecordStarUserRecordHeight fromDictionary:dict];
            self.monthendtime = [self objectOrNilForKey:kRecordStarUserRecordMonthendtime fromDictionary:dict];
            self.daytimesleep = [self objectOrNilForKey:kRecordStarUserRecordDaytimesleep fromDictionary:dict];
            self.recordtime = [self objectOrNilForKey:kRecordStarUserRecordRecordtime fromDictionary:dict];
            self.age = [self objectOrNilForKey:kRecordStarUserRecordAge fromDictionary:dict];
            self.recordHelp = [RecordStarRecordHelp modelObjectWithDictionary:[dict objectForKey:kRecordStarUserRecordRecordHelp]];
            self.complementarytype = [self objectOrNilForKey:kRecordStarUserRecordComplementarytype fromDictionary:dict];
            self.monthstarttime = [self objectOrNilForKey:kRecordStarUserRecordMonthstarttime fromDictionary:dict];
            self.recordid = [self objectOrNilForKey:kRecordStarUserRecordRecordid fromDictionary:dict];
            self.breastfeedingcount = [self objectOrNilForKey:kRecordStarUserRecordBreastfeedingcount fromDictionary:dict];
            self.nighttimesleep = [self objectOrNilForKey:kRecordStarUserRecordNighttimesleep fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.feature forKey:kRecordStarUserRecordFeature];
    [mutableDict setValue:self.other forKey:kRecordStarUserRecordOther];
    [mutableDict setValue:self.userid forKey:kRecordStarUserRecordUserid];
    [mutableDict setValue:self.weight forKey:kRecordStarUserRecordWeight];
    [mutableDict setValue:self.cacation forKey:kRecordStarUserRecordCacation];
    [mutableDict setValue:self.headcircumference forKey:kRecordStarUserRecordHeadcircumference];
    [mutableDict setValue:self.chestcircumference forKey:kRecordStarUserRecordChestcircumference];
    [mutableDict setValue:self.urinate forKey:kRecordStarUserRecordUrinate];
    [mutableDict setValue:self.breastfeedingml forKey:kRecordStarUserRecordBreastfeedingml];
    [mutableDict setValue:self.milkfeedingcount forKey:kRecordStarUserRecordMilkfeedingcount];
    [mutableDict setValue:self.monthday forKey:kRecordStarUserRecordMonthday];
    [mutableDict setValue:self.milkfeedingml forKey:kRecordStarUserRecordMilkfeedingml];
    [mutableDict setValue:self.questionid forKey:kRecordStarUserRecordQuestionid];
    [mutableDict setValue:self.submittime forKey:kRecordStarUserRecordSubmittime];
    [mutableDict setValue:self.recordstatus forKey:kRecordStarUserRecordRecordstatus];
    [mutableDict setValue:self.cacationdays forKey:kRecordStarUserRecordCacationdays];
    [mutableDict setValue:self.readtag forKey:kRecordStarUserRecordReadtag];
    [mutableDict setValue:self.height forKey:kRecordStarUserRecordHeight];
    [mutableDict setValue:self.monthendtime forKey:kRecordStarUserRecordMonthendtime];
    [mutableDict setValue:self.daytimesleep forKey:kRecordStarUserRecordDaytimesleep];
    [mutableDict setValue:self.recordtime forKey:kRecordStarUserRecordRecordtime];
    [mutableDict setValue:self.age forKey:kRecordStarUserRecordAge];
    [mutableDict setValue:[self.recordHelp dictionaryRepresentation] forKey:kRecordStarUserRecordRecordHelp];
    [mutableDict setValue:self.complementarytype forKey:kRecordStarUserRecordComplementarytype];
    [mutableDict setValue:self.monthstarttime forKey:kRecordStarUserRecordMonthstarttime];
    [mutableDict setValue:self.recordid forKey:kRecordStarUserRecordRecordid];
    [mutableDict setValue:self.breastfeedingcount forKey:kRecordStarUserRecordBreastfeedingcount];
    [mutableDict setValue:self.nighttimesleep forKey:kRecordStarUserRecordNighttimesleep];

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

    self.feature = [aDecoder decodeObjectForKey:kRecordStarUserRecordFeature];
    self.other = [aDecoder decodeObjectForKey:kRecordStarUserRecordOther];
    self.userid = [aDecoder decodeObjectForKey:kRecordStarUserRecordUserid];
    self.weight = [aDecoder decodeObjectForKey:kRecordStarUserRecordWeight];
    self.cacation = [aDecoder decodeObjectForKey:kRecordStarUserRecordCacation];
    self.headcircumference = [aDecoder decodeObjectForKey:kRecordStarUserRecordHeadcircumference];
    self.chestcircumference = [aDecoder decodeObjectForKey:kRecordStarUserRecordChestcircumference];
    self.urinate = [aDecoder decodeObjectForKey:kRecordStarUserRecordUrinate];
    self.breastfeedingml = [aDecoder decodeObjectForKey:kRecordStarUserRecordBreastfeedingml];
    self.milkfeedingcount = [aDecoder decodeObjectForKey:kRecordStarUserRecordMilkfeedingcount];
    self.monthday = [aDecoder decodeObjectForKey:kRecordStarUserRecordMonthday];
    self.milkfeedingml = [aDecoder decodeObjectForKey:kRecordStarUserRecordMilkfeedingml];
    self.questionid = [aDecoder decodeObjectForKey:kRecordStarUserRecordQuestionid];
    self.submittime = [aDecoder decodeObjectForKey:kRecordStarUserRecordSubmittime];
    self.recordstatus = [aDecoder decodeObjectForKey:kRecordStarUserRecordRecordstatus];
    self.cacationdays = [aDecoder decodeObjectForKey:kRecordStarUserRecordCacationdays];
    self.readtag = [aDecoder decodeObjectForKey:kRecordStarUserRecordReadtag];
    self.height = [aDecoder decodeObjectForKey:kRecordStarUserRecordHeight];
    self.monthendtime = [aDecoder decodeObjectForKey:kRecordStarUserRecordMonthendtime];
    self.daytimesleep = [aDecoder decodeObjectForKey:kRecordStarUserRecordDaytimesleep];
    self.recordtime = [aDecoder decodeObjectForKey:kRecordStarUserRecordRecordtime];
    self.age = [aDecoder decodeObjectForKey:kRecordStarUserRecordAge];
    self.recordHelp = [aDecoder decodeObjectForKey:kRecordStarUserRecordRecordHelp];
    self.complementarytype = [aDecoder decodeObjectForKey:kRecordStarUserRecordComplementarytype];
    self.monthstarttime = [aDecoder decodeObjectForKey:kRecordStarUserRecordMonthstarttime];
    self.recordid = [aDecoder decodeObjectForKey:kRecordStarUserRecordRecordid];
    self.breastfeedingcount = [aDecoder decodeObjectForKey:kRecordStarUserRecordBreastfeedingcount];
    self.nighttimesleep = [aDecoder decodeObjectForKey:kRecordStarUserRecordNighttimesleep];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_feature forKey:kRecordStarUserRecordFeature];
    [aCoder encodeObject:_other forKey:kRecordStarUserRecordOther];
    [aCoder encodeObject:_userid forKey:kRecordStarUserRecordUserid];
    [aCoder encodeObject:_weight forKey:kRecordStarUserRecordWeight];
    [aCoder encodeObject:_cacation forKey:kRecordStarUserRecordCacation];
    [aCoder encodeObject:_headcircumference forKey:kRecordStarUserRecordHeadcircumference];
    [aCoder encodeObject:_chestcircumference forKey:kRecordStarUserRecordChestcircumference];
    [aCoder encodeObject:_urinate forKey:kRecordStarUserRecordUrinate];
    [aCoder encodeObject:_breastfeedingml forKey:kRecordStarUserRecordBreastfeedingml];
    [aCoder encodeObject:_milkfeedingcount forKey:kRecordStarUserRecordMilkfeedingcount];
    [aCoder encodeObject:_monthday forKey:kRecordStarUserRecordMonthday];
    [aCoder encodeObject:_milkfeedingml forKey:kRecordStarUserRecordMilkfeedingml];
    [aCoder encodeObject:_questionid forKey:kRecordStarUserRecordQuestionid];
    [aCoder encodeObject:_submittime forKey:kRecordStarUserRecordSubmittime];
    [aCoder encodeObject:_recordstatus forKey:kRecordStarUserRecordRecordstatus];
    [aCoder encodeObject:_cacationdays forKey:kRecordStarUserRecordCacationdays];
    [aCoder encodeObject:_readtag forKey:kRecordStarUserRecordReadtag];
    [aCoder encodeObject:_height forKey:kRecordStarUserRecordHeight];
    [aCoder encodeObject:_monthendtime forKey:kRecordStarUserRecordMonthendtime];
    [aCoder encodeObject:_daytimesleep forKey:kRecordStarUserRecordDaytimesleep];
    [aCoder encodeObject:_recordtime forKey:kRecordStarUserRecordRecordtime];
    [aCoder encodeObject:_age forKey:kRecordStarUserRecordAge];
    [aCoder encodeObject:_recordHelp forKey:kRecordStarUserRecordRecordHelp];
    [aCoder encodeObject:_complementarytype forKey:kRecordStarUserRecordComplementarytype];
    [aCoder encodeObject:_monthstarttime forKey:kRecordStarUserRecordMonthstarttime];
    [aCoder encodeObject:_recordid forKey:kRecordStarUserRecordRecordid];
    [aCoder encodeObject:_breastfeedingcount forKey:kRecordStarUserRecordBreastfeedingcount];
    [aCoder encodeObject:_nighttimesleep forKey:kRecordStarUserRecordNighttimesleep];
}

- (id)copyWithZone:(NSZone *)zone
{
    RecordStarUserRecord *copy = [[RecordStarUserRecord alloc] init];
    
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
        copy.readtag = [self.readtag copyWithZone:zone];
        copy.height = [self.height copyWithZone:zone];
        copy.monthendtime = [self.monthendtime copyWithZone:zone];
        copy.daytimesleep = [self.daytimesleep copyWithZone:zone];
        copy.recordtime = [self.recordtime copyWithZone:zone];
        copy.age = [self.age copyWithZone:zone];
        copy.recordHelp = [self.recordHelp copyWithZone:zone];
        copy.complementarytype = [self.complementarytype copyWithZone:zone];
        copy.monthstarttime = [self.monthstarttime copyWithZone:zone];
        copy.recordid = [self.recordid copyWithZone:zone];
        copy.breastfeedingcount = [self.breastfeedingcount copyWithZone:zone];
        copy.nighttimesleep = [self.nighttimesleep copyWithZone:zone];
    }
    
    return copy;
}


@end
