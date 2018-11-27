//
//  ServerConfigDoctorList.m
//
//  Created by  豆蒙萌 on 15/9/21
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "ServerConfigDoctorList.h"


NSString *const kServerConfigDoctorListDoctordesc = @"doctordesc";
NSString *const kServerConfigDoctorListDoctorname = @"doctorname";
NSString *const kServerConfigDoctorListDoctorcode = @"doctorcode";
NSString *const kServerConfigDoctorListHeadversion = @"headversion";
NSString *const kServerConfigDoctorListCertificatecode = @"certificatecode";
NSString *const kServerConfigDoctorListSpeciality = @"speciality";
NSString *const kServerConfigDoctorListLoginpwd = @"loginpwd";
NSString *const kServerConfigDoctorListDoctorauthority = @"doctorauthority";
NSString *const kServerConfigDoctorListHospitalid = @"hospitalid";
NSString *const kServerConfigDoctorListRoleid = @"roleid";
NSString *const kServerConfigDoctorListState = @"state";
NSString *const kServerConfigDoctorListDoctorphone = @"doctorphone";
NSString *const kServerConfigDoctorListDoctororder = @"doctororder";
NSString *const kServerConfigDoctorListCertificateidx = @"certificateidx";
NSString *const kServerConfigDoctorListPositionaltitles = @"positionaltitles";
NSString *const kServerConfigDoctorListHead = @"head";
NSString *const kServerConfigDoctorListCost = @"cost";
NSString *const kServerConfigDoctorListDoctorimgidx = @"doctorimgidx";
NSString *const kServerConfigDoctorListAccountemail = @"accountemail";
NSString *const kServerConfigDoctorListDoctorid = @"doctorid";


@interface ServerConfigDoctorList ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ServerConfigDoctorList

@synthesize doctordesc = _doctordesc;
@synthesize doctorname = _doctorname;
@synthesize doctorcode = _doctorcode;
@synthesize headversion = _headversion;
@synthesize certificatecode = _certificatecode;
@synthesize speciality = _speciality;
@synthesize loginpwd = _loginpwd;
@synthesize doctorauthority = _doctorauthority;
@synthesize hospitalid = _hospitalid;
@synthesize roleid = _roleid;
@synthesize state = _state;
@synthesize doctorphone = _doctorphone;
@synthesize doctororder = _doctororder;
@synthesize certificateidx = _certificateidx;
@synthesize positionaltitles = _positionaltitles;
@synthesize head = _head;
@synthesize cost = _cost;
@synthesize doctorimgidx = _doctorimgidx;
@synthesize accountemail = _accountemail;
@synthesize doctorid = _doctorid;


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
            self.doctordesc = [self objectOrNilForKey:kServerConfigDoctorListDoctordesc fromDictionary:dict];
            self.doctorname = [self objectOrNilForKey:kServerConfigDoctorListDoctorname fromDictionary:dict];
            self.doctorcode = [self objectOrNilForKey:kServerConfigDoctorListDoctorcode fromDictionary:dict];
            self.headversion = [self objectOrNilForKey:kServerConfigDoctorListHeadversion fromDictionary:dict];
            self.certificatecode = [self objectOrNilForKey:kServerConfigDoctorListCertificatecode fromDictionary:dict];
            self.speciality = [self objectOrNilForKey:kServerConfigDoctorListSpeciality fromDictionary:dict];
            self.loginpwd = [self objectOrNilForKey:kServerConfigDoctorListLoginpwd fromDictionary:dict];
            self.doctorauthority = [self objectOrNilForKey:kServerConfigDoctorListDoctorauthority fromDictionary:dict];
            self.hospitalid = [self objectOrNilForKey:kServerConfigDoctorListHospitalid fromDictionary:dict];
            self.roleid = [self objectOrNilForKey:kServerConfigDoctorListRoleid fromDictionary:dict];
            self.state = [self objectOrNilForKey:kServerConfigDoctorListState fromDictionary:dict];
            self.doctorphone = [self objectOrNilForKey:kServerConfigDoctorListDoctorphone fromDictionary:dict];
            self.doctororder = [self objectOrNilForKey:kServerConfigDoctorListDoctororder fromDictionary:dict];
            self.certificateidx = [self objectOrNilForKey:kServerConfigDoctorListCertificateidx fromDictionary:dict];
            self.positionaltitles = [self objectOrNilForKey:kServerConfigDoctorListPositionaltitles fromDictionary:dict];
            self.head = [self objectOrNilForKey:kServerConfigDoctorListHead fromDictionary:dict];
            self.cost = [self objectOrNilForKey:kServerConfigDoctorListCost fromDictionary:dict];
            self.doctorimgidx = [self objectOrNilForKey:kServerConfigDoctorListDoctorimgidx fromDictionary:dict];
            self.accountemail = [self objectOrNilForKey:kServerConfigDoctorListAccountemail fromDictionary:dict];
            self.doctorid = [self objectOrNilForKey:kServerConfigDoctorListDoctorid fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.doctordesc forKey:kServerConfigDoctorListDoctordesc];
    [mutableDict setValue:self.doctorname forKey:kServerConfigDoctorListDoctorname];
    [mutableDict setValue:self.doctorcode forKey:kServerConfigDoctorListDoctorcode];
    [mutableDict setValue:self.headversion forKey:kServerConfigDoctorListHeadversion];
    [mutableDict setValue:self.certificatecode forKey:kServerConfigDoctorListCertificatecode];
    [mutableDict setValue:self.speciality forKey:kServerConfigDoctorListSpeciality];
    [mutableDict setValue:self.loginpwd forKey:kServerConfigDoctorListLoginpwd];
    [mutableDict setValue:self.doctorauthority forKey:kServerConfigDoctorListDoctorauthority];
    [mutableDict setValue:self.hospitalid forKey:kServerConfigDoctorListHospitalid];
    [mutableDict setValue:self.roleid forKey:kServerConfigDoctorListRoleid];
    [mutableDict setValue:self.state forKey:kServerConfigDoctorListState];
    [mutableDict setValue:self.doctorphone forKey:kServerConfigDoctorListDoctorphone];
    [mutableDict setValue:self.doctororder forKey:kServerConfigDoctorListDoctororder];
    [mutableDict setValue:self.certificateidx forKey:kServerConfigDoctorListCertificateidx];
    [mutableDict setValue:self.positionaltitles forKey:kServerConfigDoctorListPositionaltitles];
    [mutableDict setValue:self.head forKey:kServerConfigDoctorListHead];
    [mutableDict setValue:self.cost forKey:kServerConfigDoctorListCost];
    [mutableDict setValue:self.doctorimgidx forKey:kServerConfigDoctorListDoctorimgidx];
    [mutableDict setValue:self.accountemail forKey:kServerConfigDoctorListAccountemail];
    [mutableDict setValue:self.doctorid forKey:kServerConfigDoctorListDoctorid];

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

    self.doctordesc = [aDecoder decodeObjectForKey:kServerConfigDoctorListDoctordesc];
    self.doctorname = [aDecoder decodeObjectForKey:kServerConfigDoctorListDoctorname];
    self.doctorcode = [aDecoder decodeObjectForKey:kServerConfigDoctorListDoctorcode];
    self.headversion = [aDecoder decodeObjectForKey:kServerConfigDoctorListHeadversion];
    self.certificatecode = [aDecoder decodeObjectForKey:kServerConfigDoctorListCertificatecode];
    self.speciality = [aDecoder decodeObjectForKey:kServerConfigDoctorListSpeciality];
    self.loginpwd = [aDecoder decodeObjectForKey:kServerConfigDoctorListLoginpwd];
    self.doctorauthority = [aDecoder decodeObjectForKey:kServerConfigDoctorListDoctorauthority];
    self.hospitalid = [aDecoder decodeObjectForKey:kServerConfigDoctorListHospitalid];
    self.roleid = [aDecoder decodeObjectForKey:kServerConfigDoctorListRoleid];
    self.state = [aDecoder decodeObjectForKey:kServerConfigDoctorListState];
    self.doctorphone = [aDecoder decodeObjectForKey:kServerConfigDoctorListDoctorphone];
    self.doctororder = [aDecoder decodeObjectForKey:kServerConfigDoctorListDoctororder];
    self.certificateidx = [aDecoder decodeObjectForKey:kServerConfigDoctorListCertificateidx];
    self.positionaltitles = [aDecoder decodeObjectForKey:kServerConfigDoctorListPositionaltitles];
    self.head = [aDecoder decodeObjectForKey:kServerConfigDoctorListHead];
    self.cost = [aDecoder decodeObjectForKey:kServerConfigDoctorListCost];
    self.doctorimgidx = [aDecoder decodeObjectForKey:kServerConfigDoctorListDoctorimgidx];
    self.accountemail = [aDecoder decodeObjectForKey:kServerConfigDoctorListAccountemail];
    self.doctorid = [aDecoder decodeObjectForKey:kServerConfigDoctorListDoctorid];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_doctordesc forKey:kServerConfigDoctorListDoctordesc];
    [aCoder encodeObject:_doctorname forKey:kServerConfigDoctorListDoctorname];
    [aCoder encodeObject:_doctorcode forKey:kServerConfigDoctorListDoctorcode];
    [aCoder encodeObject:_headversion forKey:kServerConfigDoctorListHeadversion];
    [aCoder encodeObject:_certificatecode forKey:kServerConfigDoctorListCertificatecode];
    [aCoder encodeObject:_speciality forKey:kServerConfigDoctorListSpeciality];
    [aCoder encodeObject:_loginpwd forKey:kServerConfigDoctorListLoginpwd];
    [aCoder encodeObject:_doctorauthority forKey:kServerConfigDoctorListDoctorauthority];
    [aCoder encodeObject:_hospitalid forKey:kServerConfigDoctorListHospitalid];
    [aCoder encodeObject:_roleid forKey:kServerConfigDoctorListRoleid];
    [aCoder encodeObject:_state forKey:kServerConfigDoctorListState];
    [aCoder encodeObject:_doctorphone forKey:kServerConfigDoctorListDoctorphone];
    [aCoder encodeObject:_doctororder forKey:kServerConfigDoctorListDoctororder];
    [aCoder encodeObject:_certificateidx forKey:kServerConfigDoctorListCertificateidx];
    [aCoder encodeObject:_positionaltitles forKey:kServerConfigDoctorListPositionaltitles];
    [aCoder encodeObject:_head forKey:kServerConfigDoctorListHead];
    [aCoder encodeObject:_cost forKey:kServerConfigDoctorListCost];
    [aCoder encodeObject:_doctorimgidx forKey:kServerConfigDoctorListDoctorimgidx];
    [aCoder encodeObject:_accountemail forKey:kServerConfigDoctorListAccountemail];
    [aCoder encodeObject:_doctorid forKey:kServerConfigDoctorListDoctorid];
}

- (id)copyWithZone:(NSZone *)zone
{
    ServerConfigDoctorList *copy = [[ServerConfigDoctorList alloc] init];
    
    if (copy) {

        copy.doctordesc = [self.doctordesc copyWithZone:zone];
        copy.doctorname = [self.doctorname copyWithZone:zone];
        copy.doctorcode = [self.doctorcode copyWithZone:zone];
        copy.headversion = [self.headversion copyWithZone:zone];
        copy.certificatecode = [self.certificatecode copyWithZone:zone];
        copy.speciality = [self.speciality copyWithZone:zone];
        copy.loginpwd = [self.loginpwd copyWithZone:zone];
        copy.doctorauthority = [self.doctorauthority copyWithZone:zone];
        copy.hospitalid = [self.hospitalid copyWithZone:zone];
        copy.roleid = [self.roleid copyWithZone:zone];
        copy.state = [self.state copyWithZone:zone];
        copy.doctorphone = [self.doctorphone copyWithZone:zone];
        copy.doctororder = [self.doctororder copyWithZone:zone];
        copy.certificateidx = [self.certificateidx copyWithZone:zone];
        copy.positionaltitles = [self.positionaltitles copyWithZone:zone];
        copy.head = [self.head copyWithZone:zone];
        copy.cost = [self.cost copyWithZone:zone];
        copy.doctorimgidx = [self.doctorimgidx copyWithZone:zone];
        copy.accountemail = [self.accountemail copyWithZone:zone];
        copy.doctorid = [self.doctorid copyWithZone:zone];
    }
    
    return copy;
}


@end
