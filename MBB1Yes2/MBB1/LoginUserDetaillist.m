//
//  LoginUserDetaillist.m
//
//  Created by  豆蒙萌 on 15/9/23
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "LoginUserDetaillist.h"


NSString *const kLoginUserDetaillistImgidx = @"imgidx";
NSString *const kLoginUserDetaillistUserid = @"userid";
NSString *const kLoginUserDetaillistImgurl = @"imgurl";
NSString *const kLoginUserDetaillistId = @"id";
NSString *const kLoginUserDetaillistAppraisaltitle = @"appraisaltitle";
NSString *const kLoginUserDetaillistImgurlversion = @"imgurlversion";
NSString *const kLoginUserDetaillistRecordid = @"recordid";
NSString *const kLoginUserDetaillistNurturetype = @"nurturetype";
NSString *const kLoginUserDetaillistAppraisalorder = @"appraisalorder";
NSString *const kLoginUserDetaillistAppraisalcontent = @"appraisalcontent";
NSString *const kLoginUserDetaillistAppraisaltime = @"appraisaltime";


@interface LoginUserDetaillist ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation LoginUserDetaillist

@synthesize imgidx = _imgidx;
@synthesize userid = _userid;
@synthesize imgurl = _imgurl;
@synthesize detaillistIdentifier = _detaillistIdentifier;
@synthesize appraisaltitle = _appraisaltitle;
@synthesize imgurlversion = _imgurlversion;
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
            self.imgidx = [self objectOrNilForKey:kLoginUserDetaillistImgidx fromDictionary:dict];
            self.userid = [self objectOrNilForKey:kLoginUserDetaillistUserid fromDictionary:dict];
            self.imgurl = [self objectOrNilForKey:kLoginUserDetaillistImgurl fromDictionary:dict];
            self.detaillistIdentifier = [self objectOrNilForKey:kLoginUserDetaillistId fromDictionary:dict];
            self.appraisaltitle = [self objectOrNilForKey:kLoginUserDetaillistAppraisaltitle fromDictionary:dict];
            self.imgurlversion = [self objectOrNilForKey:kLoginUserDetaillistImgurlversion fromDictionary:dict];
            self.recordid = [self objectOrNilForKey:kLoginUserDetaillistRecordid fromDictionary:dict];
            self.nurturetype = [self objectOrNilForKey:kLoginUserDetaillistNurturetype fromDictionary:dict];
            self.appraisalorder = [self objectOrNilForKey:kLoginUserDetaillistAppraisalorder fromDictionary:dict];
            self.appraisalcontent = [self objectOrNilForKey:kLoginUserDetaillistAppraisalcontent fromDictionary:dict];
            self.appraisaltime = [self objectOrNilForKey:kLoginUserDetaillistAppraisaltime fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.imgidx forKey:kLoginUserDetaillistImgidx];
    [mutableDict setValue:self.userid forKey:kLoginUserDetaillistUserid];
    [mutableDict setValue:self.imgurl forKey:kLoginUserDetaillistImgurl];
    [mutableDict setValue:self.detaillistIdentifier forKey:kLoginUserDetaillistId];
    [mutableDict setValue:self.appraisaltitle forKey:kLoginUserDetaillistAppraisaltitle];
    [mutableDict setValue:self.imgurlversion forKey:kLoginUserDetaillistImgurlversion];
    [mutableDict setValue:self.recordid forKey:kLoginUserDetaillistRecordid];
    [mutableDict setValue:self.nurturetype forKey:kLoginUserDetaillistNurturetype];
    [mutableDict setValue:self.appraisalorder forKey:kLoginUserDetaillistAppraisalorder];
    [mutableDict setValue:self.appraisalcontent forKey:kLoginUserDetaillistAppraisalcontent];
    [mutableDict setValue:self.appraisaltime forKey:kLoginUserDetaillistAppraisaltime];

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

    self.imgidx = [aDecoder decodeObjectForKey:kLoginUserDetaillistImgidx];
    self.userid = [aDecoder decodeObjectForKey:kLoginUserDetaillistUserid];
    self.imgurl = [aDecoder decodeObjectForKey:kLoginUserDetaillistImgurl];
    self.detaillistIdentifier = [aDecoder decodeObjectForKey:kLoginUserDetaillistId];
    self.appraisaltitle = [aDecoder decodeObjectForKey:kLoginUserDetaillistAppraisaltitle];
    self.imgurlversion = [aDecoder decodeObjectForKey:kLoginUserDetaillistImgurlversion];
    self.recordid = [aDecoder decodeObjectForKey:kLoginUserDetaillistRecordid];
    self.nurturetype = [aDecoder decodeObjectForKey:kLoginUserDetaillistNurturetype];
    self.appraisalorder = [aDecoder decodeObjectForKey:kLoginUserDetaillistAppraisalorder];
    self.appraisalcontent = [aDecoder decodeObjectForKey:kLoginUserDetaillistAppraisalcontent];
    self.appraisaltime = [aDecoder decodeObjectForKey:kLoginUserDetaillistAppraisaltime];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_imgidx forKey:kLoginUserDetaillistImgidx];
    [aCoder encodeObject:_userid forKey:kLoginUserDetaillistUserid];
    [aCoder encodeObject:_imgurl forKey:kLoginUserDetaillistImgurl];
    [aCoder encodeObject:_detaillistIdentifier forKey:kLoginUserDetaillistId];
    [aCoder encodeObject:_appraisaltitle forKey:kLoginUserDetaillistAppraisaltitle];
    [aCoder encodeObject:_imgurlversion forKey:kLoginUserDetaillistImgurlversion];
    [aCoder encodeObject:_recordid forKey:kLoginUserDetaillistRecordid];
    [aCoder encodeObject:_nurturetype forKey:kLoginUserDetaillistNurturetype];
    [aCoder encodeObject:_appraisalorder forKey:kLoginUserDetaillistAppraisalorder];
    [aCoder encodeObject:_appraisalcontent forKey:kLoginUserDetaillistAppraisalcontent];
    [aCoder encodeObject:_appraisaltime forKey:kLoginUserDetaillistAppraisaltime];
}

- (id)copyWithZone:(NSZone *)zone
{
    LoginUserDetaillist *copy = [[LoginUserDetaillist alloc] init];
    
    if (copy) {

        copy.imgidx = [self.imgidx copyWithZone:zone];
        copy.userid = [self.userid copyWithZone:zone];
        copy.imgurl = [self.imgurl copyWithZone:zone];
        copy.detaillistIdentifier = [self.detaillistIdentifier copyWithZone:zone];
        copy.appraisaltitle = [self.appraisaltitle copyWithZone:zone];
        copy.imgurlversion = [self.imgurlversion copyWithZone:zone];
        copy.recordid = [self.recordid copyWithZone:zone];
        copy.nurturetype = [self.nurturetype copyWithZone:zone];
        copy.appraisalorder = [self.appraisalorder copyWithZone:zone];
        copy.appraisalcontent = [self.appraisalcontent copyWithZone:zone];
        copy.appraisaltime = [self.appraisaltime copyWithZone:zone];
    }
    
    return copy;
}


@end
