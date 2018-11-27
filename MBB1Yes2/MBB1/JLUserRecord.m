//
//  JLUserRecord.m
//
//  Created by  豆蒙萌 on 15/10/29
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "JLUserRecord.h"
#import "JLFeatureList.h"
#import "JLRecordHelp.h"


NSString *const kJLUserRecordFeature = @"feature";
NSString *const kJLUserRecordOther = @"other";
NSString *const kJLUserRecordUserid = @"userid";
NSString *const kJLUserRecordWeight = @"weight";
NSString *const kJLUserRecordCacation = @"cacation";
NSString *const kJLUserRecordHeadcircumference = @"headcircumference";
NSString *const kJLUserRecordChestcircumference = @"chestcircumference";
NSString *const kJLUserRecordUrinate = @"urinate";
NSString *const kJLUserRecordBreastfeedingml = @"breastfeedingml";
NSString *const kJLUserRecordMilkfeedingml = @"milkfeedingml";
NSString *const kJLUserRecordQuestionid = @"questionid";
NSString *const kJLUserRecordSubmittime = @"submittime";
NSString *const kJLUserRecordRecordstatus = @"recordstatus";
NSString *const kJLUserRecordFeatureList = @"featureList";
NSString *const kJLUserRecordReadtag = @"readtag";
NSString *const kJLUserRecordHeight = @"height";
NSString *const kJLUserRecordDaytimesleep = @"daytimesleep";
NSString *const kJLUserRecordRecordtime = @"recordtime";
NSString *const kJLUserRecordAge = @"age";
NSString *const kJLUserRecordRecordHelp = @"recordHelp";
NSString *const kJLUserRecordRecordid = @"recordid";
NSString *const kJLUserRecordBreastfeedingcount = @"breastfeedingcount";
NSString *const kJLUserRecordNighttimesleep = @"nighttimesleep";


@interface JLUserRecord ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation JLUserRecord

@synthesize feature = _feature;
@synthesize other = _other;
@synthesize userid = _userid;
@synthesize weight = _weight;
@synthesize cacation = _cacation;
@synthesize headcircumference = _headcircumference;
@synthesize chestcircumference = _chestcircumference;
@synthesize urinate = _urinate;
@synthesize breastfeedingml = _breastfeedingml;
@synthesize milkfeedingml = _milkfeedingml;
@synthesize questionid = _questionid;
@synthesize submittime = _submittime;
@synthesize recordstatus = _recordstatus;
@synthesize featureList = _featureList;
@synthesize readtag = _readtag;
@synthesize height = _height;
@synthesize daytimesleep = _daytimesleep;
@synthesize recordtime = _recordtime;
@synthesize age = _age;
@synthesize recordHelp = _recordHelp;
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
            self.feature = [self objectOrNilForKey:kJLUserRecordFeature fromDictionary:dict];
            self.other = [self objectOrNilForKey:kJLUserRecordOther fromDictionary:dict];
            self.userid = [self objectOrNilForKey:kJLUserRecordUserid fromDictionary:dict];
            self.weight = [self objectOrNilForKey:kJLUserRecordWeight fromDictionary:dict];
            self.cacation = [self objectOrNilForKey:kJLUserRecordCacation fromDictionary:dict];
            self.headcircumference = [self objectOrNilForKey:kJLUserRecordHeadcircumference fromDictionary:dict];
            self.chestcircumference = [self objectOrNilForKey:kJLUserRecordChestcircumference fromDictionary:dict];
            self.urinate = [self objectOrNilForKey:kJLUserRecordUrinate fromDictionary:dict];
            self.breastfeedingml = [self objectOrNilForKey:kJLUserRecordBreastfeedingml fromDictionary:dict];
            self.milkfeedingml = [self objectOrNilForKey:kJLUserRecordMilkfeedingml fromDictionary:dict];
            self.questionid = [self objectOrNilForKey:kJLUserRecordQuestionid fromDictionary:dict];
            self.submittime = [self objectOrNilForKey:kJLUserRecordSubmittime fromDictionary:dict];
            self.recordstatus = [self objectOrNilForKey:kJLUserRecordRecordstatus fromDictionary:dict];
    NSObject *receivedJLFeatureList = [dict objectForKey:kJLUserRecordFeatureList];
    NSMutableArray *parsedJLFeatureList = [NSMutableArray array];
    if ([receivedJLFeatureList isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedJLFeatureList) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedJLFeatureList addObject:[JLFeatureList modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedJLFeatureList isKindOfClass:[NSDictionary class]]) {
       [parsedJLFeatureList addObject:[JLFeatureList modelObjectWithDictionary:(NSDictionary *)receivedJLFeatureList]];
    }

    self.featureList = [NSArray arrayWithArray:parsedJLFeatureList];
            self.readtag = [self objectOrNilForKey:kJLUserRecordReadtag fromDictionary:dict];
            self.height = [self objectOrNilForKey:kJLUserRecordHeight fromDictionary:dict];
            self.daytimesleep = [self objectOrNilForKey:kJLUserRecordDaytimesleep fromDictionary:dict];
            self.recordtime = [self objectOrNilForKey:kJLUserRecordRecordtime fromDictionary:dict];
            self.age = [self objectOrNilForKey:kJLUserRecordAge fromDictionary:dict];
            self.recordHelp = [JLRecordHelp modelObjectWithDictionary:[dict objectForKey:kJLUserRecordRecordHelp]];
            self.recordid = [self objectOrNilForKey:kJLUserRecordRecordid fromDictionary:dict];
            self.breastfeedingcount = [self objectOrNilForKey:kJLUserRecordBreastfeedingcount fromDictionary:dict];
            self.nighttimesleep = [self objectOrNilForKey:kJLUserRecordNighttimesleep fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.feature forKey:kJLUserRecordFeature];
    [mutableDict setValue:self.other forKey:kJLUserRecordOther];
    [mutableDict setValue:self.userid forKey:kJLUserRecordUserid];
    [mutableDict setValue:self.weight forKey:kJLUserRecordWeight];
    [mutableDict setValue:self.cacation forKey:kJLUserRecordCacation];
    [mutableDict setValue:self.headcircumference forKey:kJLUserRecordHeadcircumference];
    [mutableDict setValue:self.chestcircumference forKey:kJLUserRecordChestcircumference];
    [mutableDict setValue:self.urinate forKey:kJLUserRecordUrinate];
    [mutableDict setValue:self.breastfeedingml forKey:kJLUserRecordBreastfeedingml];
    [mutableDict setValue:self.milkfeedingml forKey:kJLUserRecordMilkfeedingml];
    [mutableDict setValue:self.questionid forKey:kJLUserRecordQuestionid];
    [mutableDict setValue:self.submittime forKey:kJLUserRecordSubmittime];
    [mutableDict setValue:self.recordstatus forKey:kJLUserRecordRecordstatus];
    NSMutableArray *tempArrayForFeatureList = [NSMutableArray array];
    for (NSObject *subArrayObject in self.featureList) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForFeatureList addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForFeatureList addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForFeatureList] forKey:kJLUserRecordFeatureList];
    [mutableDict setValue:self.readtag forKey:kJLUserRecordReadtag];
    [mutableDict setValue:self.height forKey:kJLUserRecordHeight];
    [mutableDict setValue:self.daytimesleep forKey:kJLUserRecordDaytimesleep];
    [mutableDict setValue:self.recordtime forKey:kJLUserRecordRecordtime];
    [mutableDict setValue:self.age forKey:kJLUserRecordAge];
    [mutableDict setValue:[self.recordHelp dictionaryRepresentation] forKey:kJLUserRecordRecordHelp];
    [mutableDict setValue:self.recordid forKey:kJLUserRecordRecordid];
    [mutableDict setValue:self.breastfeedingcount forKey:kJLUserRecordBreastfeedingcount];
    [mutableDict setValue:self.nighttimesleep forKey:kJLUserRecordNighttimesleep];

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

    self.feature = [aDecoder decodeObjectForKey:kJLUserRecordFeature];
    self.other = [aDecoder decodeObjectForKey:kJLUserRecordOther];
    self.userid = [aDecoder decodeObjectForKey:kJLUserRecordUserid];
    self.weight = [aDecoder decodeObjectForKey:kJLUserRecordWeight];
    self.cacation = [aDecoder decodeObjectForKey:kJLUserRecordCacation];
    self.headcircumference = [aDecoder decodeObjectForKey:kJLUserRecordHeadcircumference];
    self.chestcircumference = [aDecoder decodeObjectForKey:kJLUserRecordChestcircumference];
    self.urinate = [aDecoder decodeObjectForKey:kJLUserRecordUrinate];
    self.breastfeedingml = [aDecoder decodeObjectForKey:kJLUserRecordBreastfeedingml];
    self.milkfeedingml = [aDecoder decodeObjectForKey:kJLUserRecordMilkfeedingml];
    self.questionid = [aDecoder decodeObjectForKey:kJLUserRecordQuestionid];
    self.submittime = [aDecoder decodeObjectForKey:kJLUserRecordSubmittime];
    self.recordstatus = [aDecoder decodeObjectForKey:kJLUserRecordRecordstatus];
    self.featureList = [aDecoder decodeObjectForKey:kJLUserRecordFeatureList];
    self.readtag = [aDecoder decodeObjectForKey:kJLUserRecordReadtag];
    self.height = [aDecoder decodeObjectForKey:kJLUserRecordHeight];
    self.daytimesleep = [aDecoder decodeObjectForKey:kJLUserRecordDaytimesleep];
    self.recordtime = [aDecoder decodeObjectForKey:kJLUserRecordRecordtime];
    self.age = [aDecoder decodeObjectForKey:kJLUserRecordAge];
    self.recordHelp = [aDecoder decodeObjectForKey:kJLUserRecordRecordHelp];
    self.recordid = [aDecoder decodeObjectForKey:kJLUserRecordRecordid];
    self.breastfeedingcount = [aDecoder decodeObjectForKey:kJLUserRecordBreastfeedingcount];
    self.nighttimesleep = [aDecoder decodeObjectForKey:kJLUserRecordNighttimesleep];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_feature forKey:kJLUserRecordFeature];
    [aCoder encodeObject:_other forKey:kJLUserRecordOther];
    [aCoder encodeObject:_userid forKey:kJLUserRecordUserid];
    [aCoder encodeObject:_weight forKey:kJLUserRecordWeight];
    [aCoder encodeObject:_cacation forKey:kJLUserRecordCacation];
    [aCoder encodeObject:_headcircumference forKey:kJLUserRecordHeadcircumference];
    [aCoder encodeObject:_chestcircumference forKey:kJLUserRecordChestcircumference];
    [aCoder encodeObject:_urinate forKey:kJLUserRecordUrinate];
    [aCoder encodeObject:_breastfeedingml forKey:kJLUserRecordBreastfeedingml];
    [aCoder encodeObject:_milkfeedingml forKey:kJLUserRecordMilkfeedingml];
    [aCoder encodeObject:_questionid forKey:kJLUserRecordQuestionid];
    [aCoder encodeObject:_submittime forKey:kJLUserRecordSubmittime];
    [aCoder encodeObject:_recordstatus forKey:kJLUserRecordRecordstatus];
    [aCoder encodeObject:_featureList forKey:kJLUserRecordFeatureList];
    [aCoder encodeObject:_readtag forKey:kJLUserRecordReadtag];
    [aCoder encodeObject:_height forKey:kJLUserRecordHeight];
    [aCoder encodeObject:_daytimesleep forKey:kJLUserRecordDaytimesleep];
    [aCoder encodeObject:_recordtime forKey:kJLUserRecordRecordtime];
    [aCoder encodeObject:_age forKey:kJLUserRecordAge];
    [aCoder encodeObject:_recordHelp forKey:kJLUserRecordRecordHelp];
    [aCoder encodeObject:_recordid forKey:kJLUserRecordRecordid];
    [aCoder encodeObject:_breastfeedingcount forKey:kJLUserRecordBreastfeedingcount];
    [aCoder encodeObject:_nighttimesleep forKey:kJLUserRecordNighttimesleep];
}

- (id)copyWithZone:(NSZone *)zone
{
    JLUserRecord *copy = [[JLUserRecord alloc] init];
    
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
        copy.milkfeedingml = [self.milkfeedingml copyWithZone:zone];
        copy.questionid = [self.questionid copyWithZone:zone];
        copy.submittime = [self.submittime copyWithZone:zone];
        copy.recordstatus = [self.recordstatus copyWithZone:zone];
        copy.featureList = [self.featureList copyWithZone:zone];
        copy.readtag = [self.readtag copyWithZone:zone];
        copy.height = [self.height copyWithZone:zone];
        copy.daytimesleep = [self.daytimesleep copyWithZone:zone];
        copy.recordtime = [self.recordtime copyWithZone:zone];
        copy.age = [self.age copyWithZone:zone];
        copy.recordHelp = [self.recordHelp copyWithZone:zone];
        copy.recordid = [self.recordid copyWithZone:zone];
        copy.breastfeedingcount = [self.breastfeedingcount copyWithZone:zone];
        copy.nighttimesleep = [self.nighttimesleep copyWithZone:zone];
    }
    
    return copy;
}


@end
