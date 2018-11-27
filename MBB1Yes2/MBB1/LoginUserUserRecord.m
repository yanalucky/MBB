//
//  LoginUserUserRecord.m
//
//  Created by  豆蒙萌 on 15/9/23
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "LoginUserUserRecord.h"
#import "LoginUserRecordHelp.h"


NSString *const kLoginUserUserRecordFeature = @"feature";
NSString *const kLoginUserUserRecordOther = @"other";
NSString *const kLoginUserUserRecordUserid = @"userid";
NSString *const kLoginUserUserRecordWeight = @"weight";
NSString *const kLoginUserUserRecordCacation = @"cacation";
NSString *const kLoginUserUserRecordHeadcircumference = @"headcircumference";
NSString *const kLoginUserUserRecordBreastfeedingcount = @"breastfeedingcount";
NSString *const kLoginUserUserRecordUrinate = @"urinate";
NSString *const kLoginUserUserRecordBreastfeedingml = @"breastfeedingml";
NSString *const kLoginUserUserRecordMilkfeedingml = @"milkfeedingml";
NSString *const kLoginUserUserRecordQuestionid = @"questionid";
NSString *const kLoginUserUserRecordSubmittime = @"submittime";
NSString *const kLoginUserUserRecordRecordstatus = @"recordstatus";
NSString *const kLoginUserUserRecordFeatureList = @"featureList";
NSString *const kLoginUserUserRecordReadtag = @"readtag";
NSString *const kLoginUserUserRecordHeight = @"height";
NSString *const kLoginUserUserRecordDaytimesleep = @"daytimesleep";
NSString *const kLoginUserUserRecordRecordtime = @"recordtime";
NSString *const kLoginUserUserRecordRecordHelp = @"recordHelp";
NSString *const kLoginUserUserRecordRecordid = @"recordid";
NSString *const kLoginUserUserRecordAge = @"age";
NSString *const kLoginUserUserRecordChestcircumference = @"chestcircumference";
NSString *const kLoginUserUserRecordNighttimesleep = @"nighttimesleep";


@interface LoginUserUserRecord ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation LoginUserUserRecord

@synthesize feature = _feature;
@synthesize other = _other;
@synthesize userid = _userid;
@synthesize weight = _weight;
@synthesize cacation = _cacation;
@synthesize headcircumference = _headcircumference;
@synthesize breastfeedingcount = _breastfeedingcount;
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
@synthesize recordHelp = _recordHelp;
@synthesize recordid = _recordid;
@synthesize age = _age;
@synthesize chestcircumference = _chestcircumference;
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
            self.feature = [self objectOrNilForKey:kLoginUserUserRecordFeature fromDictionary:dict];
            self.other = [self objectOrNilForKey:kLoginUserUserRecordOther fromDictionary:dict];
            self.userid = [self objectOrNilForKey:kLoginUserUserRecordUserid fromDictionary:dict];
            self.weight = [self objectOrNilForKey:kLoginUserUserRecordWeight fromDictionary:dict];
            self.cacation = [self objectOrNilForKey:kLoginUserUserRecordCacation fromDictionary:dict];
            self.headcircumference = [self objectOrNilForKey:kLoginUserUserRecordHeadcircumference fromDictionary:dict];
            self.breastfeedingcount = [self objectOrNilForKey:kLoginUserUserRecordBreastfeedingcount fromDictionary:dict];
            self.urinate = [self objectOrNilForKey:kLoginUserUserRecordUrinate fromDictionary:dict];
            self.breastfeedingml = [self objectOrNilForKey:kLoginUserUserRecordBreastfeedingml fromDictionary:dict];
            self.milkfeedingml = [self objectOrNilForKey:kLoginUserUserRecordMilkfeedingml fromDictionary:dict];
            self.questionid = [self objectOrNilForKey:kLoginUserUserRecordQuestionid fromDictionary:dict];
            self.submittime = [self objectOrNilForKey:kLoginUserUserRecordSubmittime fromDictionary:dict];
            self.recordstatus = [self objectOrNilForKey:kLoginUserUserRecordRecordstatus fromDictionary:dict];
            self.featureList = [self objectOrNilForKey:kLoginUserUserRecordFeatureList fromDictionary:dict];
            self.readtag = [self objectOrNilForKey:kLoginUserUserRecordReadtag fromDictionary:dict];
            self.height = [self objectOrNilForKey:kLoginUserUserRecordHeight fromDictionary:dict];
            self.daytimesleep = [self objectOrNilForKey:kLoginUserUserRecordDaytimesleep fromDictionary:dict];
            self.recordtime = [self objectOrNilForKey:kLoginUserUserRecordRecordtime fromDictionary:dict];
            self.recordHelp = [LoginUserRecordHelp modelObjectWithDictionary:[dict objectForKey:kLoginUserUserRecordRecordHelp]];
            self.recordid = [self objectOrNilForKey:kLoginUserUserRecordRecordid fromDictionary:dict];
            self.age = [self objectOrNilForKey:kLoginUserUserRecordAge fromDictionary:dict];
            self.chestcircumference = [self objectOrNilForKey:kLoginUserUserRecordChestcircumference fromDictionary:dict];
            self.nighttimesleep = [self objectOrNilForKey:kLoginUserUserRecordNighttimesleep fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.feature forKey:kLoginUserUserRecordFeature];
    [mutableDict setValue:self.other forKey:kLoginUserUserRecordOther];
    [mutableDict setValue:self.userid forKey:kLoginUserUserRecordUserid];
    [mutableDict setValue:self.weight forKey:kLoginUserUserRecordWeight];
    [mutableDict setValue:self.cacation forKey:kLoginUserUserRecordCacation];
    [mutableDict setValue:self.headcircumference forKey:kLoginUserUserRecordHeadcircumference];
    [mutableDict setValue:self.breastfeedingcount forKey:kLoginUserUserRecordBreastfeedingcount];
    [mutableDict setValue:self.urinate forKey:kLoginUserUserRecordUrinate];
    [mutableDict setValue:self.breastfeedingml forKey:kLoginUserUserRecordBreastfeedingml];
    [mutableDict setValue:self.milkfeedingml forKey:kLoginUserUserRecordMilkfeedingml];
    [mutableDict setValue:self.questionid forKey:kLoginUserUserRecordQuestionid];
    [mutableDict setValue:self.submittime forKey:kLoginUserUserRecordSubmittime];
    [mutableDict setValue:self.recordstatus forKey:kLoginUserUserRecordRecordstatus];
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
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForFeatureList] forKey:kLoginUserUserRecordFeatureList];
    [mutableDict setValue:self.readtag forKey:kLoginUserUserRecordReadtag];
    [mutableDict setValue:self.height forKey:kLoginUserUserRecordHeight];
    [mutableDict setValue:self.daytimesleep forKey:kLoginUserUserRecordDaytimesleep];
    [mutableDict setValue:self.recordtime forKey:kLoginUserUserRecordRecordtime];
    [mutableDict setValue:[self.recordHelp dictionaryRepresentation] forKey:kLoginUserUserRecordRecordHelp];
    [mutableDict setValue:self.recordid forKey:kLoginUserUserRecordRecordid];
    [mutableDict setValue:self.age forKey:kLoginUserUserRecordAge];
    [mutableDict setValue:self.chestcircumference forKey:kLoginUserUserRecordChestcircumference];
    [mutableDict setValue:self.nighttimesleep forKey:kLoginUserUserRecordNighttimesleep];

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

    self.feature = [aDecoder decodeObjectForKey:kLoginUserUserRecordFeature];
    self.other = [aDecoder decodeObjectForKey:kLoginUserUserRecordOther];
    self.userid = [aDecoder decodeObjectForKey:kLoginUserUserRecordUserid];
    self.weight = [aDecoder decodeObjectForKey:kLoginUserUserRecordWeight];
    self.cacation = [aDecoder decodeObjectForKey:kLoginUserUserRecordCacation];
    self.headcircumference = [aDecoder decodeObjectForKey:kLoginUserUserRecordHeadcircumference];
    self.breastfeedingcount = [aDecoder decodeObjectForKey:kLoginUserUserRecordBreastfeedingcount];
    self.urinate = [aDecoder decodeObjectForKey:kLoginUserUserRecordUrinate];
    self.breastfeedingml = [aDecoder decodeObjectForKey:kLoginUserUserRecordBreastfeedingml];
    self.milkfeedingml = [aDecoder decodeObjectForKey:kLoginUserUserRecordMilkfeedingml];
    self.questionid = [aDecoder decodeObjectForKey:kLoginUserUserRecordQuestionid];
    self.submittime = [aDecoder decodeObjectForKey:kLoginUserUserRecordSubmittime];
    self.recordstatus = [aDecoder decodeObjectForKey:kLoginUserUserRecordRecordstatus];
    self.featureList = [aDecoder decodeObjectForKey:kLoginUserUserRecordFeatureList];
    self.readtag = [aDecoder decodeObjectForKey:kLoginUserUserRecordReadtag];
    self.height = [aDecoder decodeObjectForKey:kLoginUserUserRecordHeight];
    self.daytimesleep = [aDecoder decodeObjectForKey:kLoginUserUserRecordDaytimesleep];
    self.recordtime = [aDecoder decodeObjectForKey:kLoginUserUserRecordRecordtime];
    self.recordHelp = [aDecoder decodeObjectForKey:kLoginUserUserRecordRecordHelp];
    self.recordid = [aDecoder decodeObjectForKey:kLoginUserUserRecordRecordid];
    self.age = [aDecoder decodeObjectForKey:kLoginUserUserRecordAge];
    self.chestcircumference = [aDecoder decodeObjectForKey:kLoginUserUserRecordChestcircumference];
    self.nighttimesleep = [aDecoder decodeObjectForKey:kLoginUserUserRecordNighttimesleep];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_feature forKey:kLoginUserUserRecordFeature];
    [aCoder encodeObject:_other forKey:kLoginUserUserRecordOther];
    [aCoder encodeObject:_userid forKey:kLoginUserUserRecordUserid];
    [aCoder encodeObject:_weight forKey:kLoginUserUserRecordWeight];
    [aCoder encodeObject:_cacation forKey:kLoginUserUserRecordCacation];
    [aCoder encodeObject:_headcircumference forKey:kLoginUserUserRecordHeadcircumference];
    [aCoder encodeObject:_breastfeedingcount forKey:kLoginUserUserRecordBreastfeedingcount];
    [aCoder encodeObject:_urinate forKey:kLoginUserUserRecordUrinate];
    [aCoder encodeObject:_breastfeedingml forKey:kLoginUserUserRecordBreastfeedingml];
    [aCoder encodeObject:_milkfeedingml forKey:kLoginUserUserRecordMilkfeedingml];
    [aCoder encodeObject:_questionid forKey:kLoginUserUserRecordQuestionid];
    [aCoder encodeObject:_submittime forKey:kLoginUserUserRecordSubmittime];
    [aCoder encodeObject:_recordstatus forKey:kLoginUserUserRecordRecordstatus];
    [aCoder encodeObject:_featureList forKey:kLoginUserUserRecordFeatureList];
    [aCoder encodeObject:_readtag forKey:kLoginUserUserRecordReadtag];
    [aCoder encodeObject:_height forKey:kLoginUserUserRecordHeight];
    [aCoder encodeObject:_daytimesleep forKey:kLoginUserUserRecordDaytimesleep];
    [aCoder encodeObject:_recordtime forKey:kLoginUserUserRecordRecordtime];
    [aCoder encodeObject:_recordHelp forKey:kLoginUserUserRecordRecordHelp];
    [aCoder encodeObject:_recordid forKey:kLoginUserUserRecordRecordid];
    [aCoder encodeObject:_age forKey:kLoginUserUserRecordAge];
    [aCoder encodeObject:_chestcircumference forKey:kLoginUserUserRecordChestcircumference];
    [aCoder encodeObject:_nighttimesleep forKey:kLoginUserUserRecordNighttimesleep];
}

- (id)copyWithZone:(NSZone *)zone
{
    LoginUserUserRecord *copy = [[LoginUserUserRecord alloc] init];
    
    if (copy) {

        copy.feature = [self.feature copyWithZone:zone];
        copy.other = [self.other copyWithZone:zone];
        copy.userid = [self.userid copyWithZone:zone];
        copy.weight = [self.weight copyWithZone:zone];
        copy.cacation = [self.cacation copyWithZone:zone];
        copy.headcircumference = [self.headcircumference copyWithZone:zone];
        copy.breastfeedingcount = [self.breastfeedingcount copyWithZone:zone];
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
        copy.recordHelp = [self.recordHelp copyWithZone:zone];
        copy.recordid = [self.recordid copyWithZone:zone];
        copy.age = [self.age copyWithZone:zone];
        copy.chestcircumference = [self.chestcircumference copyWithZone:zone];
        copy.nighttimesleep = [self.nighttimesleep copyWithZone:zone];
    }
    
    return copy;
}


@end
