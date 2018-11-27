//
//  LoginUserBodycheckBooking.m
//
//  Created by  豆蒙萌 on 15/9/23
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "LoginUserBodycheckBooking.h"


NSString *const kLoginUserBodycheckBookingUserid = @"userid";
NSString *const kLoginUserBodycheckBookingBookingtime = @"bookingtime";
NSString *const kLoginUserBodycheckBookingCheckbookingid = @"checkbookingid";
NSString *const kLoginUserBodycheckBookingContactperson = @"contactperson";
NSString *const kLoginUserBodycheckBookingContactmobile = @"contactmobile";
NSString *const kLoginUserBodycheckBookingIsbodycheck = @"isbodycheck";
NSString *const kLoginUserBodycheckBookingHospitalid = @"hospitalid";
NSString *const kLoginUserBodycheckBookingDoctorid = @"doctorid";


@interface LoginUserBodycheckBooking ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation LoginUserBodycheckBooking

@synthesize userid = _userid;
@synthesize bookingtime = _bookingtime;
@synthesize checkbookingid = _checkbookingid;
@synthesize contactperson = _contactperson;
@synthesize contactmobile = _contactmobile;
@synthesize isbodycheck = _isbodycheck;
@synthesize hospitalid = _hospitalid;
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
            self.userid = [self objectOrNilForKey:kLoginUserBodycheckBookingUserid fromDictionary:dict];
            self.bookingtime = [self objectOrNilForKey:kLoginUserBodycheckBookingBookingtime fromDictionary:dict];
            self.checkbookingid = [self objectOrNilForKey:kLoginUserBodycheckBookingCheckbookingid fromDictionary:dict];
            self.contactperson = [self objectOrNilForKey:kLoginUserBodycheckBookingContactperson fromDictionary:dict];
            self.contactmobile = [self objectOrNilForKey:kLoginUserBodycheckBookingContactmobile fromDictionary:dict];
            self.isbodycheck = [self objectOrNilForKey:kLoginUserBodycheckBookingIsbodycheck fromDictionary:dict];
            self.hospitalid = [self objectOrNilForKey:kLoginUserBodycheckBookingHospitalid fromDictionary:dict];
            self.doctorid = [self objectOrNilForKey:kLoginUserBodycheckBookingDoctorid fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.userid forKey:kLoginUserBodycheckBookingUserid];
    [mutableDict setValue:self.bookingtime forKey:kLoginUserBodycheckBookingBookingtime];
    [mutableDict setValue:self.checkbookingid forKey:kLoginUserBodycheckBookingCheckbookingid];
    [mutableDict setValue:self.contactperson forKey:kLoginUserBodycheckBookingContactperson];
    [mutableDict setValue:self.contactmobile forKey:kLoginUserBodycheckBookingContactmobile];
    [mutableDict setValue:self.isbodycheck forKey:kLoginUserBodycheckBookingIsbodycheck];
    [mutableDict setValue:self.hospitalid forKey:kLoginUserBodycheckBookingHospitalid];
    [mutableDict setValue:self.doctorid forKey:kLoginUserBodycheckBookingDoctorid];

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

    self.userid = [aDecoder decodeObjectForKey:kLoginUserBodycheckBookingUserid];
    self.bookingtime = [aDecoder decodeObjectForKey:kLoginUserBodycheckBookingBookingtime];
    self.checkbookingid = [aDecoder decodeObjectForKey:kLoginUserBodycheckBookingCheckbookingid];
    self.contactperson = [aDecoder decodeObjectForKey:kLoginUserBodycheckBookingContactperson];
    self.contactmobile = [aDecoder decodeObjectForKey:kLoginUserBodycheckBookingContactmobile];
    self.isbodycheck = [aDecoder decodeObjectForKey:kLoginUserBodycheckBookingIsbodycheck];
    self.hospitalid = [aDecoder decodeObjectForKey:kLoginUserBodycheckBookingHospitalid];
    self.doctorid = [aDecoder decodeObjectForKey:kLoginUserBodycheckBookingDoctorid];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_userid forKey:kLoginUserBodycheckBookingUserid];
    [aCoder encodeObject:_bookingtime forKey:kLoginUserBodycheckBookingBookingtime];
    [aCoder encodeObject:_checkbookingid forKey:kLoginUserBodycheckBookingCheckbookingid];
    [aCoder encodeObject:_contactperson forKey:kLoginUserBodycheckBookingContactperson];
    [aCoder encodeObject:_contactmobile forKey:kLoginUserBodycheckBookingContactmobile];
    [aCoder encodeObject:_isbodycheck forKey:kLoginUserBodycheckBookingIsbodycheck];
    [aCoder encodeObject:_hospitalid forKey:kLoginUserBodycheckBookingHospitalid];
    [aCoder encodeObject:_doctorid forKey:kLoginUserBodycheckBookingDoctorid];
}

- (id)copyWithZone:(NSZone *)zone
{
    LoginUserBodycheckBooking *copy = [[LoginUserBodycheckBooking alloc] init];
    
    if (copy) {

        copy.userid = [self.userid copyWithZone:zone];
        copy.bookingtime = [self.bookingtime copyWithZone:zone];
        copy.checkbookingid = [self.checkbookingid copyWithZone:zone];
        copy.contactperson = [self.contactperson copyWithZone:zone];
        copy.contactmobile = [self.contactmobile copyWithZone:zone];
        copy.isbodycheck = [self.isbodycheck copyWithZone:zone];
        copy.hospitalid = [self.hospitalid copyWithZone:zone];
        copy.doctorid = [self.doctorid copyWithZone:zone];
    }
    
    return copy;
}


@end
