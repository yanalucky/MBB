//
//  ServerConfigTheLatestThreeSalonList.m
//
//  Created by   on 16/7/5
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "ServerConfigTheLatestThreeSalonList.h"


NSString *const kServerConfigTheLatestThreeSalonListSalonindex = @"salonindex";
NSString *const kServerConfigTheLatestThreeSalonListContactmobile = @"contactmobile";
NSString *const kServerConfigTheLatestThreeSalonListGuestid = @"guestid";
NSString *const kServerConfigTheLatestThreeSalonListSalonupdatetime = @"salonupdatetime";
NSString *const kServerConfigTheLatestThreeSalonListSalontagimg = @"salontagimg";
NSString *const kServerConfigTheLatestThreeSalonListSalonvideourl = @"salonvideourl";
NSString *const kServerConfigTheLatestThreeSalonListSalonentercount = @"salonentercount";
NSString *const kServerConfigTheLatestThreeSalonListSalonbannerimg = @"salonbannerimg";
NSString *const kServerConfigTheLatestThreeSalonListSalonmapidx = @"salonmapidx";
NSString *const kServerConfigTheLatestThreeSalonListSalonversion = @"salonversion";
NSString *const kServerConfigTheLatestThreeSalonListSalonimg = @"salonimg";
NSString *const kServerConfigTheLatestThreeSalonListSalonguest = @"salonguest";
NSString *const kServerConfigTheLatestThreeSalonListSignupendtme = @"signupendtme";
NSString *const kServerConfigTheLatestThreeSalonListSalontopic = @"salontopic";
NSString *const kServerConfigTheLatestThreeSalonListSalongdesc = @"salongdesc";
NSString *const kServerConfigTheLatestThreeSalonListSalontime = @"salontime";
NSString *const kServerConfigTheLatestThreeSalonListSalonimgidx = @"salonimgidx";
NSString *const kServerConfigTheLatestThreeSalonListSalonaddress = @"salonaddress";
NSString *const kServerConfigTheLatestThreeSalonListContactperson = @"contactperson";
NSString *const kServerConfigTheLatestThreeSalonListSalonid = @"salonid";


@interface ServerConfigTheLatestThreeSalonList ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ServerConfigTheLatestThreeSalonList

@synthesize salonindex = _salonindex;
@synthesize contactmobile = _contactmobile;
@synthesize guestid = _guestid;
@synthesize salonupdatetime = _salonupdatetime;
@synthesize salontagimg = _salontagimg;
@synthesize salonvideourl = _salonvideourl;
@synthesize salonentercount = _salonentercount;
@synthesize salonbannerimg = _salonbannerimg;
@synthesize salonmapidx = _salonmapidx;
@synthesize salonversion = _salonversion;
@synthesize salonimg = _salonimg;
@synthesize salonguest = _salonguest;
@synthesize signupendtme = _signupendtme;
@synthesize salontopic = _salontopic;
@synthesize salongdesc = _salongdesc;
@synthesize salontime = _salontime;
@synthesize salonimgidx = _salonimgidx;
@synthesize salonaddress = _salonaddress;
@synthesize contactperson = _contactperson;
@synthesize salonid = _salonid;


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
            self.salonindex = [self objectOrNilForKey:kServerConfigTheLatestThreeSalonListSalonindex fromDictionary:dict];
            self.contactmobile = [self objectOrNilForKey:kServerConfigTheLatestThreeSalonListContactmobile fromDictionary:dict];
            self.guestid = [self objectOrNilForKey:kServerConfigTheLatestThreeSalonListGuestid fromDictionary:dict];
            self.salonupdatetime = [self objectOrNilForKey:kServerConfigTheLatestThreeSalonListSalonupdatetime fromDictionary:dict];
            self.salontagimg = [self objectOrNilForKey:kServerConfigTheLatestThreeSalonListSalontagimg fromDictionary:dict];
            self.salonvideourl = [self objectOrNilForKey:kServerConfigTheLatestThreeSalonListSalonvideourl fromDictionary:dict];
            self.salonentercount = [self objectOrNilForKey:kServerConfigTheLatestThreeSalonListSalonentercount fromDictionary:dict];
            self.salonbannerimg = [self objectOrNilForKey:kServerConfigTheLatestThreeSalonListSalonbannerimg fromDictionary:dict];
            self.salonmapidx = [self objectOrNilForKey:kServerConfigTheLatestThreeSalonListSalonmapidx fromDictionary:dict];
            self.salonversion = [self objectOrNilForKey:kServerConfigTheLatestThreeSalonListSalonversion fromDictionary:dict];
            self.salonimg = [self objectOrNilForKey:kServerConfigTheLatestThreeSalonListSalonimg fromDictionary:dict];
            self.salonguest = [self objectOrNilForKey:kServerConfigTheLatestThreeSalonListSalonguest fromDictionary:dict];
            self.signupendtme = [self objectOrNilForKey:kServerConfigTheLatestThreeSalonListSignupendtme fromDictionary:dict];
            self.salontopic = [self objectOrNilForKey:kServerConfigTheLatestThreeSalonListSalontopic fromDictionary:dict];
            self.salongdesc = [self objectOrNilForKey:kServerConfigTheLatestThreeSalonListSalongdesc fromDictionary:dict];
            self.salontime = [self objectOrNilForKey:kServerConfigTheLatestThreeSalonListSalontime fromDictionary:dict];
            self.salonimgidx = [self objectOrNilForKey:kServerConfigTheLatestThreeSalonListSalonimgidx fromDictionary:dict];
            self.salonaddress = [self objectOrNilForKey:kServerConfigTheLatestThreeSalonListSalonaddress fromDictionary:dict];
            self.contactperson = [self objectOrNilForKey:kServerConfigTheLatestThreeSalonListContactperson fromDictionary:dict];
            self.salonid = [self objectOrNilForKey:kServerConfigTheLatestThreeSalonListSalonid fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.salonindex forKey:kServerConfigTheLatestThreeSalonListSalonindex];
    [mutableDict setValue:self.contactmobile forKey:kServerConfigTheLatestThreeSalonListContactmobile];
    [mutableDict setValue:self.guestid forKey:kServerConfigTheLatestThreeSalonListGuestid];
    [mutableDict setValue:self.salonupdatetime forKey:kServerConfigTheLatestThreeSalonListSalonupdatetime];
    [mutableDict setValue:self.salontagimg forKey:kServerConfigTheLatestThreeSalonListSalontagimg];
    [mutableDict setValue:self.salonvideourl forKey:kServerConfigTheLatestThreeSalonListSalonvideourl];
    [mutableDict setValue:self.salonentercount forKey:kServerConfigTheLatestThreeSalonListSalonentercount];
    [mutableDict setValue:self.salonbannerimg forKey:kServerConfigTheLatestThreeSalonListSalonbannerimg];
    [mutableDict setValue:self.salonmapidx forKey:kServerConfigTheLatestThreeSalonListSalonmapidx];
    [mutableDict setValue:self.salonversion forKey:kServerConfigTheLatestThreeSalonListSalonversion];
    [mutableDict setValue:self.salonimg forKey:kServerConfigTheLatestThreeSalonListSalonimg];
    [mutableDict setValue:self.salonguest forKey:kServerConfigTheLatestThreeSalonListSalonguest];
    [mutableDict setValue:self.signupendtme forKey:kServerConfigTheLatestThreeSalonListSignupendtme];
    [mutableDict setValue:self.salontopic forKey:kServerConfigTheLatestThreeSalonListSalontopic];
    [mutableDict setValue:self.salongdesc forKey:kServerConfigTheLatestThreeSalonListSalongdesc];
    [mutableDict setValue:self.salontime forKey:kServerConfigTheLatestThreeSalonListSalontime];
    [mutableDict setValue:self.salonimgidx forKey:kServerConfigTheLatestThreeSalonListSalonimgidx];
    [mutableDict setValue:self.salonaddress forKey:kServerConfigTheLatestThreeSalonListSalonaddress];
    [mutableDict setValue:self.contactperson forKey:kServerConfigTheLatestThreeSalonListContactperson];
    [mutableDict setValue:self.salonid forKey:kServerConfigTheLatestThreeSalonListSalonid];

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

    self.salonindex = [aDecoder decodeObjectForKey:kServerConfigTheLatestThreeSalonListSalonindex];
    self.contactmobile = [aDecoder decodeObjectForKey:kServerConfigTheLatestThreeSalonListContactmobile];
    self.guestid = [aDecoder decodeObjectForKey:kServerConfigTheLatestThreeSalonListGuestid];
    self.salonupdatetime = [aDecoder decodeObjectForKey:kServerConfigTheLatestThreeSalonListSalonupdatetime];
    self.salontagimg = [aDecoder decodeObjectForKey:kServerConfigTheLatestThreeSalonListSalontagimg];
    self.salonvideourl = [aDecoder decodeObjectForKey:kServerConfigTheLatestThreeSalonListSalonvideourl];
    self.salonentercount = [aDecoder decodeObjectForKey:kServerConfigTheLatestThreeSalonListSalonentercount];
    self.salonbannerimg = [aDecoder decodeObjectForKey:kServerConfigTheLatestThreeSalonListSalonbannerimg];
    self.salonmapidx = [aDecoder decodeObjectForKey:kServerConfigTheLatestThreeSalonListSalonmapidx];
    self.salonversion = [aDecoder decodeObjectForKey:kServerConfigTheLatestThreeSalonListSalonversion];
    self.salonimg = [aDecoder decodeObjectForKey:kServerConfigTheLatestThreeSalonListSalonimg];
    self.salonguest = [aDecoder decodeObjectForKey:kServerConfigTheLatestThreeSalonListSalonguest];
    self.signupendtme = [aDecoder decodeObjectForKey:kServerConfigTheLatestThreeSalonListSignupendtme];
    self.salontopic = [aDecoder decodeObjectForKey:kServerConfigTheLatestThreeSalonListSalontopic];
    self.salongdesc = [aDecoder decodeObjectForKey:kServerConfigTheLatestThreeSalonListSalongdesc];
    self.salontime = [aDecoder decodeObjectForKey:kServerConfigTheLatestThreeSalonListSalontime];
    self.salonimgidx = [aDecoder decodeObjectForKey:kServerConfigTheLatestThreeSalonListSalonimgidx];
    self.salonaddress = [aDecoder decodeObjectForKey:kServerConfigTheLatestThreeSalonListSalonaddress];
    self.contactperson = [aDecoder decodeObjectForKey:kServerConfigTheLatestThreeSalonListContactperson];
    self.salonid = [aDecoder decodeObjectForKey:kServerConfigTheLatestThreeSalonListSalonid];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_salonindex forKey:kServerConfigTheLatestThreeSalonListSalonindex];
    [aCoder encodeObject:_contactmobile forKey:kServerConfigTheLatestThreeSalonListContactmobile];
    [aCoder encodeObject:_guestid forKey:kServerConfigTheLatestThreeSalonListGuestid];
    [aCoder encodeObject:_salonupdatetime forKey:kServerConfigTheLatestThreeSalonListSalonupdatetime];
    [aCoder encodeObject:_salontagimg forKey:kServerConfigTheLatestThreeSalonListSalontagimg];
    [aCoder encodeObject:_salonvideourl forKey:kServerConfigTheLatestThreeSalonListSalonvideourl];
    [aCoder encodeObject:_salonentercount forKey:kServerConfigTheLatestThreeSalonListSalonentercount];
    [aCoder encodeObject:_salonbannerimg forKey:kServerConfigTheLatestThreeSalonListSalonbannerimg];
    [aCoder encodeObject:_salonmapidx forKey:kServerConfigTheLatestThreeSalonListSalonmapidx];
    [aCoder encodeObject:_salonversion forKey:kServerConfigTheLatestThreeSalonListSalonversion];
    [aCoder encodeObject:_salonimg forKey:kServerConfigTheLatestThreeSalonListSalonimg];
    [aCoder encodeObject:_salonguest forKey:kServerConfigTheLatestThreeSalonListSalonguest];
    [aCoder encodeObject:_signupendtme forKey:kServerConfigTheLatestThreeSalonListSignupendtme];
    [aCoder encodeObject:_salontopic forKey:kServerConfigTheLatestThreeSalonListSalontopic];
    [aCoder encodeObject:_salongdesc forKey:kServerConfigTheLatestThreeSalonListSalongdesc];
    [aCoder encodeObject:_salontime forKey:kServerConfigTheLatestThreeSalonListSalontime];
    [aCoder encodeObject:_salonimgidx forKey:kServerConfigTheLatestThreeSalonListSalonimgidx];
    [aCoder encodeObject:_salonaddress forKey:kServerConfigTheLatestThreeSalonListSalonaddress];
    [aCoder encodeObject:_contactperson forKey:kServerConfigTheLatestThreeSalonListContactperson];
    [aCoder encodeObject:_salonid forKey:kServerConfigTheLatestThreeSalonListSalonid];
}

- (id)copyWithZone:(NSZone *)zone
{
    ServerConfigTheLatestThreeSalonList *copy = [[ServerConfigTheLatestThreeSalonList alloc] init];
    
    if (copy) {

        copy.salonindex = [self.salonindex copyWithZone:zone];
        copy.contactmobile = [self.contactmobile copyWithZone:zone];
        copy.guestid = [self.guestid copyWithZone:zone];
        copy.salonupdatetime = [self.salonupdatetime copyWithZone:zone];
        copy.salontagimg = [self.salontagimg copyWithZone:zone];
        copy.salonvideourl = [self.salonvideourl copyWithZone:zone];
        copy.salonentercount = [self.salonentercount copyWithZone:zone];
        copy.salonbannerimg = [self.salonbannerimg copyWithZone:zone];
        copy.salonmapidx = [self.salonmapidx copyWithZone:zone];
        copy.salonversion = [self.salonversion copyWithZone:zone];
        copy.salonimg = [self.salonimg copyWithZone:zone];
        copy.salonguest = [self.salonguest copyWithZone:zone];
        copy.signupendtme = [self.signupendtme copyWithZone:zone];
        copy.salontopic = [self.salontopic copyWithZone:zone];
        copy.salongdesc = [self.salongdesc copyWithZone:zone];
        copy.salontime = [self.salontime copyWithZone:zone];
        copy.salonimgidx = [self.salonimgidx copyWithZone:zone];
        copy.salonaddress = [self.salonaddress copyWithZone:zone];
        copy.contactperson = [self.contactperson copyWithZone:zone];
        copy.salonid = [self.salonid copyWithZone:zone];
    }
    
    return copy;
}


@end
