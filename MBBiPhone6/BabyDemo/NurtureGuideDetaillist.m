//
//  NurtureGuideDetaillist.m
//
//  Created by   on 16/5/17
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "NurtureGuideDetaillist.h"


NSString *const kNurtureGuideDetaillistUserid = @"userid";
NSString *const kNurtureGuideDetaillistImgidx = @"imgidx";
NSString *const kNurtureGuideDetaillistImgurlversion = @"imgurlversion";
NSString *const kNurtureGuideDetaillistId = @"id";
NSString *const kNurtureGuideDetaillistAppraisaltitle = @"appraisaltitle";
NSString *const kNurtureGuideDetaillistImgurl = @"imgurl";
NSString *const kNurtureGuideDetaillistRecordid = @"recordid";
NSString *const kNurtureGuideDetaillistNurturetype = @"nurturetype";
NSString *const kNurtureGuideDetaillistAppraisalorder = @"appraisalorder";
NSString *const kNurtureGuideDetaillistAppraisalcontent = @"appraisalcontent";
NSString *const kNurtureGuideDetaillistAppraisaltime = @"appraisaltime";


@interface NurtureGuideDetaillist ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation NurtureGuideDetaillist

@synthesize userid = _userid;
@synthesize imgidx = _imgidx;
@synthesize imgurlversion = _imgurlversion;
@synthesize detaillistIdentifier = _detaillistIdentifier;
@synthesize appraisaltitle = _appraisaltitle;
@synthesize imgurl = _imgurl;
@synthesize recordid = _recordid;
@synthesize nurturetype = _nurturetype;
@synthesize appraisalorder = _appraisalorder;
@synthesize appraisalcontent = _appraisalcontent;
@synthesize appraisaltime = _appraisaltime;


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
            self.userid = [self objectOrNilForKey:kNurtureGuideDetaillistUserid fromDictionary:dict];
            self.imgidx = [self objectOrNilForKey:kNurtureGuideDetaillistImgidx fromDictionary:dict];
            self.imgurlversion = [self objectOrNilForKey:kNurtureGuideDetaillistImgurlversion fromDictionary:dict];
            self.detaillistIdentifier = [self objectOrNilForKey:kNurtureGuideDetaillistId fromDictionary:dict];
            self.appraisaltitle = [self objectOrNilForKey:kNurtureGuideDetaillistAppraisaltitle fromDictionary:dict];
            self.imgurl = [self objectOrNilForKey:kNurtureGuideDetaillistImgurl fromDictionary:dict];
            self.recordid = [self objectOrNilForKey:kNurtureGuideDetaillistRecordid fromDictionary:dict];
            self.nurturetype = [self objectOrNilForKey:kNurtureGuideDetaillistNurturetype fromDictionary:dict];
            self.appraisalorder = [self objectOrNilForKey:kNurtureGuideDetaillistAppraisalorder fromDictionary:dict];
            self.appraisalcontent = [self objectOrNilForKey:kNurtureGuideDetaillistAppraisalcontent fromDictionary:dict];
            self.appraisaltime = [self objectOrNilForKey:kNurtureGuideDetaillistAppraisaltime fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.userid forKey:kNurtureGuideDetaillistUserid];
    [mutableDict setValue:self.imgidx forKey:kNurtureGuideDetaillistImgidx];
    [mutableDict setValue:self.imgurlversion forKey:kNurtureGuideDetaillistImgurlversion];
    [mutableDict setValue:self.detaillistIdentifier forKey:kNurtureGuideDetaillistId];
    [mutableDict setValue:self.appraisaltitle forKey:kNurtureGuideDetaillistAppraisaltitle];
    [mutableDict setValue:self.imgurl forKey:kNurtureGuideDetaillistImgurl];
    [mutableDict setValue:self.recordid forKey:kNurtureGuideDetaillistRecordid];
    [mutableDict setValue:self.nurturetype forKey:kNurtureGuideDetaillistNurturetype];
    [mutableDict setValue:self.appraisalorder forKey:kNurtureGuideDetaillistAppraisalorder];
    [mutableDict setValue:self.appraisalcontent forKey:kNurtureGuideDetaillistAppraisalcontent];
    [mutableDict setValue:self.appraisaltime forKey:kNurtureGuideDetaillistAppraisaltime];

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

    self.userid = [aDecoder decodeObjectForKey:kNurtureGuideDetaillistUserid];
    self.imgidx = [aDecoder decodeObjectForKey:kNurtureGuideDetaillistImgidx];
    self.imgurlversion = [aDecoder decodeObjectForKey:kNurtureGuideDetaillistImgurlversion];
    self.detaillistIdentifier = [aDecoder decodeObjectForKey:kNurtureGuideDetaillistId];
    self.appraisaltitle = [aDecoder decodeObjectForKey:kNurtureGuideDetaillistAppraisaltitle];
    self.imgurl = [aDecoder decodeObjectForKey:kNurtureGuideDetaillistImgurl];
    self.recordid = [aDecoder decodeObjectForKey:kNurtureGuideDetaillistRecordid];
    self.nurturetype = [aDecoder decodeObjectForKey:kNurtureGuideDetaillistNurturetype];
    self.appraisalorder = [aDecoder decodeObjectForKey:kNurtureGuideDetaillistAppraisalorder];
    self.appraisalcontent = [aDecoder decodeObjectForKey:kNurtureGuideDetaillistAppraisalcontent];
    self.appraisaltime = [aDecoder decodeObjectForKey:kNurtureGuideDetaillistAppraisaltime];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_userid forKey:kNurtureGuideDetaillistUserid];
    [aCoder encodeObject:_imgidx forKey:kNurtureGuideDetaillistImgidx];
    [aCoder encodeObject:_imgurlversion forKey:kNurtureGuideDetaillistImgurlversion];
    [aCoder encodeObject:_detaillistIdentifier forKey:kNurtureGuideDetaillistId];
    [aCoder encodeObject:_appraisaltitle forKey:kNurtureGuideDetaillistAppraisaltitle];
    [aCoder encodeObject:_imgurl forKey:kNurtureGuideDetaillistImgurl];
    [aCoder encodeObject:_recordid forKey:kNurtureGuideDetaillistRecordid];
    [aCoder encodeObject:_nurturetype forKey:kNurtureGuideDetaillistNurturetype];
    [aCoder encodeObject:_appraisalorder forKey:kNurtureGuideDetaillistAppraisalorder];
    [aCoder encodeObject:_appraisalcontent forKey:kNurtureGuideDetaillistAppraisalcontent];
    [aCoder encodeObject:_appraisaltime forKey:kNurtureGuideDetaillistAppraisaltime];
}

- (id)copyWithZone:(NSZone *)zone
{
    NurtureGuideDetaillist *copy = [[NurtureGuideDetaillist alloc] init];
    
    if (copy) {

        copy.userid = [self.userid copyWithZone:zone];
        copy.imgidx = [self.imgidx copyWithZone:zone];
        copy.imgurlversion = [self.imgurlversion copyWithZone:zone];
        copy.detaillistIdentifier = [self.detaillistIdentifier copyWithZone:zone];
        copy.appraisaltitle = [self.appraisaltitle copyWithZone:zone];
        copy.imgurl = [self.imgurl copyWithZone:zone];
        copy.recordid = [self.recordid copyWithZone:zone];
        copy.nurturetype = [self.nurturetype copyWithZone:zone];
        copy.appraisalorder = [self.appraisalorder copyWithZone:zone];
        copy.appraisalcontent = [self.appraisalcontent copyWithZone:zone];
        copy.appraisaltime = [self.appraisaltime copyWithZone:zone];
    }
    
    return copy;
}


@end
