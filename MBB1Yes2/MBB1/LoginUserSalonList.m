//
//  LoginUserSalonList.m
//
//  Created by  豆蒙萌 on 15/9/23
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "LoginUserSalonList.h"


NSString *const kLoginUserSalonListSalonentercount = @"salonentercount";
NSString *const kLoginUserSalonListSalonguest = @"salonguest";
NSString *const kLoginUserSalonListSalonupdatetime = @"salonupdatetime";
NSString *const kLoginUserSalonListSalonimg = @"salonimg";
NSString *const kLoginUserSalonListSalontopic = @"salontopic";
NSString *const kLoginUserSalonListSalontagimg = @"salontagimg";
NSString *const kLoginUserSalonListSalonid = @"salonid";
NSString *const kLoginUserSalonListSalontime = @"salontime";
NSString *const kLoginUserSalonListSalonaddress = @"salonaddress";
NSString *const kLoginUserSalonListSalongdesc = @"salongdesc";
NSString *const kLoginUserSalonListSalonimgidx = @"salonimgidx";
NSString *const kLoginUserSalonListSalonmapidx = @"salonmapidx";
NSString *const kLoginUserSalonListSignupendtme = @"signupendtme";
NSString *const kLoginUserSalonListContactperson = @"contactperson";
NSString *const kLoginUserSalonListSalonindex = @"salonindex";
NSString *const kLoginUserSalonListSalonversion = @"salonversion";
NSString *const kLoginUserSalonListContactmobile = @"contactmobile";


@interface LoginUserSalonList ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation LoginUserSalonList

@synthesize salonentercount = _salonentercount;
@synthesize salonguest = _salonguest;
@synthesize salonupdatetime = _salonupdatetime;
@synthesize salonimg = _salonimg;
@synthesize salontopic = _salontopic;
@synthesize salontagimg = _salontagimg;
@synthesize salonid = _salonid;
@synthesize salontime = _salontime;
@synthesize salonaddress = _salonaddress;
@synthesize salongdesc = _salongdesc;
@synthesize salonimgidx = _salonimgidx;
@synthesize salonmapidx = _salonmapidx;
@synthesize signupendtme = _signupendtme;
@synthesize contactperson = _contactperson;
@synthesize salonindex = _salonindex;
@synthesize salonversion = _salonversion;
@synthesize contactmobile = _contactmobile;


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
            self.salonentercount = [self objectOrNilForKey:kLoginUserSalonListSalonentercount fromDictionary:dict];
            self.salonguest = [self objectOrNilForKey:kLoginUserSalonListSalonguest fromDictionary:dict];
            self.salonupdatetime = [self objectOrNilForKey:kLoginUserSalonListSalonupdatetime fromDictionary:dict];
            self.salonimg = [self objectOrNilForKey:kLoginUserSalonListSalonimg fromDictionary:dict];
            self.salontopic = [self objectOrNilForKey:kLoginUserSalonListSalontopic fromDictionary:dict];
            self.salontagimg = [self objectOrNilForKey:kLoginUserSalonListSalontagimg fromDictionary:dict];
            self.salonid = [self objectOrNilForKey:kLoginUserSalonListSalonid fromDictionary:dict];
            self.salontime = [self objectOrNilForKey:kLoginUserSalonListSalontime fromDictionary:dict];
            self.salonaddress = [self objectOrNilForKey:kLoginUserSalonListSalonaddress fromDictionary:dict];
            self.salongdesc = [self objectOrNilForKey:kLoginUserSalonListSalongdesc fromDictionary:dict];
            self.salonimgidx = [self objectOrNilForKey:kLoginUserSalonListSalonimgidx fromDictionary:dict];
            self.salonmapidx = [self objectOrNilForKey:kLoginUserSalonListSalonmapidx fromDictionary:dict];
            self.signupendtme = [self objectOrNilForKey:kLoginUserSalonListSignupendtme fromDictionary:dict];
            self.contactperson = [self objectOrNilForKey:kLoginUserSalonListContactperson fromDictionary:dict];
            self.salonindex = [self objectOrNilForKey:kLoginUserSalonListSalonindex fromDictionary:dict];
            self.salonversion = [self objectOrNilForKey:kLoginUserSalonListSalonversion fromDictionary:dict];
            self.contactmobile = [self objectOrNilForKey:kLoginUserSalonListContactmobile fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.salonentercount forKey:kLoginUserSalonListSalonentercount];
    [mutableDict setValue:self.salonguest forKey:kLoginUserSalonListSalonguest];
    [mutableDict setValue:self.salonupdatetime forKey:kLoginUserSalonListSalonupdatetime];
    [mutableDict setValue:self.salonimg forKey:kLoginUserSalonListSalonimg];
    [mutableDict setValue:self.salontopic forKey:kLoginUserSalonListSalontopic];
    [mutableDict setValue:self.salontagimg forKey:kLoginUserSalonListSalontagimg];
    [mutableDict setValue:self.salonid forKey:kLoginUserSalonListSalonid];
    [mutableDict setValue:self.salontime forKey:kLoginUserSalonListSalontime];
    [mutableDict setValue:self.salonaddress forKey:kLoginUserSalonListSalonaddress];
    [mutableDict setValue:self.salongdesc forKey:kLoginUserSalonListSalongdesc];
    [mutableDict setValue:self.salonimgidx forKey:kLoginUserSalonListSalonimgidx];
    [mutableDict setValue:self.salonmapidx forKey:kLoginUserSalonListSalonmapidx];
    [mutableDict setValue:self.signupendtme forKey:kLoginUserSalonListSignupendtme];
    [mutableDict setValue:self.contactperson forKey:kLoginUserSalonListContactperson];
    [mutableDict setValue:self.salonindex forKey:kLoginUserSalonListSalonindex];
    [mutableDict setValue:self.salonversion forKey:kLoginUserSalonListSalonversion];
    [mutableDict setValue:self.contactmobile forKey:kLoginUserSalonListContactmobile];

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

    self.salonentercount = [aDecoder decodeObjectForKey:kLoginUserSalonListSalonentercount];
    self.salonguest = [aDecoder decodeObjectForKey:kLoginUserSalonListSalonguest];
    self.salonupdatetime = [aDecoder decodeObjectForKey:kLoginUserSalonListSalonupdatetime];
    self.salonimg = [aDecoder decodeObjectForKey:kLoginUserSalonListSalonimg];
    self.salontopic = [aDecoder decodeObjectForKey:kLoginUserSalonListSalontopic];
    self.salontagimg = [aDecoder decodeObjectForKey:kLoginUserSalonListSalontagimg];
    self.salonid = [aDecoder decodeObjectForKey:kLoginUserSalonListSalonid];
    self.salontime = [aDecoder decodeObjectForKey:kLoginUserSalonListSalontime];
    self.salonaddress = [aDecoder decodeObjectForKey:kLoginUserSalonListSalonaddress];
    self.salongdesc = [aDecoder decodeObjectForKey:kLoginUserSalonListSalongdesc];
    self.salonimgidx = [aDecoder decodeObjectForKey:kLoginUserSalonListSalonimgidx];
    self.salonmapidx = [aDecoder decodeObjectForKey:kLoginUserSalonListSalonmapidx];
    self.signupendtme = [aDecoder decodeObjectForKey:kLoginUserSalonListSignupendtme];
    self.contactperson = [aDecoder decodeObjectForKey:kLoginUserSalonListContactperson];
    self.salonindex = [aDecoder decodeObjectForKey:kLoginUserSalonListSalonindex];
    self.salonversion = [aDecoder decodeObjectForKey:kLoginUserSalonListSalonversion];
    self.contactmobile = [aDecoder decodeObjectForKey:kLoginUserSalonListContactmobile];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_salonentercount forKey:kLoginUserSalonListSalonentercount];
    [aCoder encodeObject:_salonguest forKey:kLoginUserSalonListSalonguest];
    [aCoder encodeObject:_salonupdatetime forKey:kLoginUserSalonListSalonupdatetime];
    [aCoder encodeObject:_salonimg forKey:kLoginUserSalonListSalonimg];
    [aCoder encodeObject:_salontopic forKey:kLoginUserSalonListSalontopic];
    [aCoder encodeObject:_salontagimg forKey:kLoginUserSalonListSalontagimg];
    [aCoder encodeObject:_salonid forKey:kLoginUserSalonListSalonid];
    [aCoder encodeObject:_salontime forKey:kLoginUserSalonListSalontime];
    [aCoder encodeObject:_salonaddress forKey:kLoginUserSalonListSalonaddress];
    [aCoder encodeObject:_salongdesc forKey:kLoginUserSalonListSalongdesc];
    [aCoder encodeObject:_salonimgidx forKey:kLoginUserSalonListSalonimgidx];
    [aCoder encodeObject:_salonmapidx forKey:kLoginUserSalonListSalonmapidx];
    [aCoder encodeObject:_signupendtme forKey:kLoginUserSalonListSignupendtme];
    [aCoder encodeObject:_contactperson forKey:kLoginUserSalonListContactperson];
    [aCoder encodeObject:_salonindex forKey:kLoginUserSalonListSalonindex];
    [aCoder encodeObject:_salonversion forKey:kLoginUserSalonListSalonversion];
    [aCoder encodeObject:_contactmobile forKey:kLoginUserSalonListContactmobile];
}

- (id)copyWithZone:(NSZone *)zone
{
    LoginUserSalonList *copy = [[LoginUserSalonList alloc] init];
    
    if (copy) {

        copy.salonentercount = [self.salonentercount copyWithZone:zone];
        copy.salonguest = [self.salonguest copyWithZone:zone];
        copy.salonupdatetime = [self.salonupdatetime copyWithZone:zone];
        copy.salonimg = [self.salonimg copyWithZone:zone];
        copy.salontopic = [self.salontopic copyWithZone:zone];
        copy.salontagimg = [self.salontagimg copyWithZone:zone];
        copy.salonid = [self.salonid copyWithZone:zone];
        copy.salontime = [self.salontime copyWithZone:zone];
        copy.salonaddress = [self.salonaddress copyWithZone:zone];
        copy.salongdesc = [self.salongdesc copyWithZone:zone];
        copy.salonimgidx = [self.salonimgidx copyWithZone:zone];
        copy.salonmapidx = [self.salonmapidx copyWithZone:zone];
        copy.signupendtme = [self.signupendtme copyWithZone:zone];
        copy.contactperson = [self.contactperson copyWithZone:zone];
        copy.salonindex = [self.salonindex copyWithZone:zone];
        copy.salonversion = [self.salonversion copyWithZone:zone];
        copy.contactmobile = [self.contactmobile copyWithZone:zone];
    }
    
    return copy;
}


@end
