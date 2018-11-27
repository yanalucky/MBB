//
//  LoginUserTreatBooking.m
//
//  Created by  豆蒙萌 on 15/10/14
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "LoginUserTreatBooking.h"


NSString *const kLoginUserTreatBookingUserid = @"userid";
NSString *const kLoginUserTreatBookingBookingtime = @"bookingtime";
NSString *const kLoginUserTreatBookingContactperson = @"contactperson";
NSString *const kLoginUserTreatBookingContactmobile = @"contactmobile";
NSString *const kLoginUserTreatBookingTreatbookingid = @"treatbookingid";
NSString *const kLoginUserTreatBookingDoctorid = @"doctorid";
NSString *const kLoginUserTreatBookingHospitalid = @"hospitalid";
NSString *const kLoginUserTreatBookingIstreat = @"istreat";


@interface LoginUserTreatBooking ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation LoginUserTreatBooking

@synthesize userid = _userid;
@synthesize bookingtime = _bookingtime;
@synthesize contactperson = _contactperson;
@synthesize contactmobile = _contactmobile;
@synthesize treatbookingid = _treatbookingid;
@synthesize doctorid = _doctorid;
@synthesize hospitalid = _hospitalid;
@synthesize istreat = _istreat;


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
            self.userid = [self objectOrNilForKey:kLoginUserTreatBookingUserid fromDictionary:dict];
            self.bookingtime = [self objectOrNilForKey:kLoginUserTreatBookingBookingtime fromDictionary:dict];
            self.contactperson = [self objectOrNilForKey:kLoginUserTreatBookingContactperson fromDictionary:dict];
            self.contactmobile = [self objectOrNilForKey:kLoginUserTreatBookingContactmobile fromDictionary:dict];
            self.treatbookingid = [self objectOrNilForKey:kLoginUserTreatBookingTreatbookingid fromDictionary:dict];
            self.doctorid = [self objectOrNilForKey:kLoginUserTreatBookingDoctorid fromDictionary:dict];
            self.hospitalid = [self objectOrNilForKey:kLoginUserTreatBookingHospitalid fromDictionary:dict];
            self.istreat = [self objectOrNilForKey:kLoginUserTreatBookingIstreat fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.userid forKey:kLoginUserTreatBookingUserid];
    [mutableDict setValue:self.bookingtime forKey:kLoginUserTreatBookingBookingtime];
    [mutableDict setValue:self.contactperson forKey:kLoginUserTreatBookingContactperson];
    [mutableDict setValue:self.contactmobile forKey:kLoginUserTreatBookingContactmobile];
    [mutableDict setValue:self.treatbookingid forKey:kLoginUserTreatBookingTreatbookingid];
    [mutableDict setValue:self.doctorid forKey:kLoginUserTreatBookingDoctorid];
    [mutableDict setValue:self.hospitalid forKey:kLoginUserTreatBookingHospitalid];
    [mutableDict setValue:self.istreat forKey:kLoginUserTreatBookingIstreat];

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

    self.userid = [aDecoder decodeObjectForKey:kLoginUserTreatBookingUserid];
    self.bookingtime = [aDecoder decodeObjectForKey:kLoginUserTreatBookingBookingtime];
    self.contactperson = [aDecoder decodeObjectForKey:kLoginUserTreatBookingContactperson];
    self.contactmobile = [aDecoder decodeObjectForKey:kLoginUserTreatBookingContactmobile];
    self.treatbookingid = [aDecoder decodeObjectForKey:kLoginUserTreatBookingTreatbookingid];
    self.doctorid = [aDecoder decodeObjectForKey:kLoginUserTreatBookingDoctorid];
    self.hospitalid = [aDecoder decodeObjectForKey:kLoginUserTreatBookingHospitalid];
    self.istreat = [aDecoder decodeObjectForKey:kLoginUserTreatBookingIstreat];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_userid forKey:kLoginUserTreatBookingUserid];
    [aCoder encodeObject:_bookingtime forKey:kLoginUserTreatBookingBookingtime];
    [aCoder encodeObject:_contactperson forKey:kLoginUserTreatBookingContactperson];
    [aCoder encodeObject:_contactmobile forKey:kLoginUserTreatBookingContactmobile];
    [aCoder encodeObject:_treatbookingid forKey:kLoginUserTreatBookingTreatbookingid];
    [aCoder encodeObject:_doctorid forKey:kLoginUserTreatBookingDoctorid];
    [aCoder encodeObject:_hospitalid forKey:kLoginUserTreatBookingHospitalid];
    [aCoder encodeObject:_istreat forKey:kLoginUserTreatBookingIstreat];
}

- (id)copyWithZone:(NSZone *)zone
{
    LoginUserTreatBooking *copy = [[LoginUserTreatBooking alloc] init];
    
    if (copy) {

        copy.userid = [self.userid copyWithZone:zone];
        copy.bookingtime = [self.bookingtime copyWithZone:zone];
        copy.contactperson = [self.contactperson copyWithZone:zone];
        copy.contactmobile = [self.contactmobile copyWithZone:zone];
        copy.treatbookingid = [self.treatbookingid copyWithZone:zone];
        copy.doctorid = [self.doctorid copyWithZone:zone];
        copy.hospitalid = [self.hospitalid copyWithZone:zone];
        copy.istreat = [self.istreat copyWithZone:zone];
    }
    
    return copy;
}


@end
