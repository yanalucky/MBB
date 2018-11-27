//
//  ServerConfigHospitalList.m
//
//  Created by   on 16/6/21
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "ServerConfigHospitalList.h"


NSString *const kServerConfigHospitalListHospitalmapidx = @"hospitalmapidx";
NSString *const kServerConfigHospitalListState = @"state";
NSString *const kServerConfigHospitalListIconversion = @"iconversion";
NSString *const kServerConfigHospitalListHospitaliconidx = @"hospitaliconidx";
NSString *const kServerConfigHospitalListMap = @"map";
NSString *const kServerConfigHospitalListHospitalurl = @"hospitalurl";
NSString *const kServerConfigHospitalListHospitaltype = @"hospitaltype";
NSString *const kServerConfigHospitalListHospitaldesc = @"hospitaldesc";
NSString *const kServerConfigHospitalListArea = @"area";
NSString *const kServerConfigHospitalListHospitalphone = @"hospitalphone";
NSString *const kServerConfigHospitalListHospitaladdress = @"hospitaladdress";
NSString *const kServerConfigHospitalListHospitalid = @"hospitalid";
NSString *const kServerConfigHospitalListHospitalname = @"hospitalname";
NSString *const kServerConfigHospitalListIcon = @"icon";
NSString *const kServerConfigHospitalListMapversion = @"mapversion";
NSString *const kServerConfigHospitalListHospitalorder = @"hospitalorder";
NSString *const kServerConfigHospitalListPediatricsdesc = @"pediatricsdesc";
NSString *const kServerConfigHospitalListShowtag = @"showtag";
NSString *const kServerConfigHospitalListProvince = @"province";


@interface ServerConfigHospitalList ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ServerConfigHospitalList

@synthesize hospitalmapidx = _hospitalmapidx;
@synthesize state = _state;
@synthesize iconversion = _iconversion;
@synthesize hospitaliconidx = _hospitaliconidx;
@synthesize map = _map;
@synthesize hospitalurl = _hospitalurl;
@synthesize hospitaltype = _hospitaltype;
@synthesize hospitaldesc = _hospitaldesc;
@synthesize area = _area;
@synthesize hospitalphone = _hospitalphone;
@synthesize hospitaladdress = _hospitaladdress;
@synthesize hospitalid = _hospitalid;
@synthesize hospitalname = _hospitalname;
@synthesize icon = _icon;
@synthesize mapversion = _mapversion;
@synthesize hospitalorder = _hospitalorder;
@synthesize pediatricsdesc = _pediatricsdesc;
@synthesize showtag = _showtag;
@synthesize province = _province;


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
            self.hospitalmapidx = [self objectOrNilForKey:kServerConfigHospitalListHospitalmapidx fromDictionary:dict];
            self.state = [self objectOrNilForKey:kServerConfigHospitalListState fromDictionary:dict];
            self.iconversion = [self objectOrNilForKey:kServerConfigHospitalListIconversion fromDictionary:dict];
            self.hospitaliconidx = [self objectOrNilForKey:kServerConfigHospitalListHospitaliconidx fromDictionary:dict];
            self.map = [self objectOrNilForKey:kServerConfigHospitalListMap fromDictionary:dict];
            self.hospitalurl = [self objectOrNilForKey:kServerConfigHospitalListHospitalurl fromDictionary:dict];
            self.hospitaltype = [self objectOrNilForKey:kServerConfigHospitalListHospitaltype fromDictionary:dict];
            self.hospitaldesc = [self objectOrNilForKey:kServerConfigHospitalListHospitaldesc fromDictionary:dict];
            self.area = [self objectOrNilForKey:kServerConfigHospitalListArea fromDictionary:dict];
            self.hospitalphone = [self objectOrNilForKey:kServerConfigHospitalListHospitalphone fromDictionary:dict];
            self.hospitaladdress = [self objectOrNilForKey:kServerConfigHospitalListHospitaladdress fromDictionary:dict];
            self.hospitalid = [self objectOrNilForKey:kServerConfigHospitalListHospitalid fromDictionary:dict];
            self.hospitalname = [self objectOrNilForKey:kServerConfigHospitalListHospitalname fromDictionary:dict];
            self.icon = [self objectOrNilForKey:kServerConfigHospitalListIcon fromDictionary:dict];
            self.mapversion = [self objectOrNilForKey:kServerConfigHospitalListMapversion fromDictionary:dict];
            self.hospitalorder = [self objectOrNilForKey:kServerConfigHospitalListHospitalorder fromDictionary:dict];
            self.pediatricsdesc = [self objectOrNilForKey:kServerConfigHospitalListPediatricsdesc fromDictionary:dict];
            self.showtag = [self objectOrNilForKey:kServerConfigHospitalListShowtag fromDictionary:dict];
            self.province = [self objectOrNilForKey:kServerConfigHospitalListProvince fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.hospitalmapidx forKey:kServerConfigHospitalListHospitalmapidx];
    [mutableDict setValue:self.state forKey:kServerConfigHospitalListState];
    [mutableDict setValue:self.iconversion forKey:kServerConfigHospitalListIconversion];
    [mutableDict setValue:self.hospitaliconidx forKey:kServerConfigHospitalListHospitaliconidx];
    [mutableDict setValue:self.map forKey:kServerConfigHospitalListMap];
    [mutableDict setValue:self.hospitalurl forKey:kServerConfigHospitalListHospitalurl];
    [mutableDict setValue:self.hospitaltype forKey:kServerConfigHospitalListHospitaltype];
    [mutableDict setValue:self.hospitaldesc forKey:kServerConfigHospitalListHospitaldesc];
    [mutableDict setValue:self.area forKey:kServerConfigHospitalListArea];
    [mutableDict setValue:self.hospitalphone forKey:kServerConfigHospitalListHospitalphone];
    [mutableDict setValue:self.hospitaladdress forKey:kServerConfigHospitalListHospitaladdress];
    [mutableDict setValue:self.hospitalid forKey:kServerConfigHospitalListHospitalid];
    [mutableDict setValue:self.hospitalname forKey:kServerConfigHospitalListHospitalname];
    [mutableDict setValue:self.icon forKey:kServerConfigHospitalListIcon];
    [mutableDict setValue:self.mapversion forKey:kServerConfigHospitalListMapversion];
    [mutableDict setValue:self.hospitalorder forKey:kServerConfigHospitalListHospitalorder];
    [mutableDict setValue:self.pediatricsdesc forKey:kServerConfigHospitalListPediatricsdesc];
    [mutableDict setValue:self.showtag forKey:kServerConfigHospitalListShowtag];
    [mutableDict setValue:self.province forKey:kServerConfigHospitalListProvince];

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

    self.hospitalmapidx = [aDecoder decodeObjectForKey:kServerConfigHospitalListHospitalmapidx];
    self.state = [aDecoder decodeObjectForKey:kServerConfigHospitalListState];
    self.iconversion = [aDecoder decodeObjectForKey:kServerConfigHospitalListIconversion];
    self.hospitaliconidx = [aDecoder decodeObjectForKey:kServerConfigHospitalListHospitaliconidx];
    self.map = [aDecoder decodeObjectForKey:kServerConfigHospitalListMap];
    self.hospitalurl = [aDecoder decodeObjectForKey:kServerConfigHospitalListHospitalurl];
    self.hospitaltype = [aDecoder decodeObjectForKey:kServerConfigHospitalListHospitaltype];
    self.hospitaldesc = [aDecoder decodeObjectForKey:kServerConfigHospitalListHospitaldesc];
    self.area = [aDecoder decodeObjectForKey:kServerConfigHospitalListArea];
    self.hospitalphone = [aDecoder decodeObjectForKey:kServerConfigHospitalListHospitalphone];
    self.hospitaladdress = [aDecoder decodeObjectForKey:kServerConfigHospitalListHospitaladdress];
    self.hospitalid = [aDecoder decodeObjectForKey:kServerConfigHospitalListHospitalid];
    self.hospitalname = [aDecoder decodeObjectForKey:kServerConfigHospitalListHospitalname];
    self.icon = [aDecoder decodeObjectForKey:kServerConfigHospitalListIcon];
    self.mapversion = [aDecoder decodeObjectForKey:kServerConfigHospitalListMapversion];
    self.hospitalorder = [aDecoder decodeObjectForKey:kServerConfigHospitalListHospitalorder];
    self.pediatricsdesc = [aDecoder decodeObjectForKey:kServerConfigHospitalListPediatricsdesc];
    self.showtag = [aDecoder decodeObjectForKey:kServerConfigHospitalListShowtag];
    self.province = [aDecoder decodeObjectForKey:kServerConfigHospitalListProvince];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_hospitalmapidx forKey:kServerConfigHospitalListHospitalmapidx];
    [aCoder encodeObject:_state forKey:kServerConfigHospitalListState];
    [aCoder encodeObject:_iconversion forKey:kServerConfigHospitalListIconversion];
    [aCoder encodeObject:_hospitaliconidx forKey:kServerConfigHospitalListHospitaliconidx];
    [aCoder encodeObject:_map forKey:kServerConfigHospitalListMap];
    [aCoder encodeObject:_hospitalurl forKey:kServerConfigHospitalListHospitalurl];
    [aCoder encodeObject:_hospitaltype forKey:kServerConfigHospitalListHospitaltype];
    [aCoder encodeObject:_hospitaldesc forKey:kServerConfigHospitalListHospitaldesc];
    [aCoder encodeObject:_area forKey:kServerConfigHospitalListArea];
    [aCoder encodeObject:_hospitalphone forKey:kServerConfigHospitalListHospitalphone];
    [aCoder encodeObject:_hospitaladdress forKey:kServerConfigHospitalListHospitaladdress];
    [aCoder encodeObject:_hospitalid forKey:kServerConfigHospitalListHospitalid];
    [aCoder encodeObject:_hospitalname forKey:kServerConfigHospitalListHospitalname];
    [aCoder encodeObject:_icon forKey:kServerConfigHospitalListIcon];
    [aCoder encodeObject:_mapversion forKey:kServerConfigHospitalListMapversion];
    [aCoder encodeObject:_hospitalorder forKey:kServerConfigHospitalListHospitalorder];
    [aCoder encodeObject:_pediatricsdesc forKey:kServerConfigHospitalListPediatricsdesc];
    [aCoder encodeObject:_showtag forKey:kServerConfigHospitalListShowtag];
    [aCoder encodeObject:_province forKey:kServerConfigHospitalListProvince];
}

- (id)copyWithZone:(NSZone *)zone
{
    ServerConfigHospitalList *copy = [[ServerConfigHospitalList alloc] init];
    
    if (copy) {

        copy.hospitalmapidx = [self.hospitalmapidx copyWithZone:zone];
        copy.state = [self.state copyWithZone:zone];
        copy.iconversion = [self.iconversion copyWithZone:zone];
        copy.hospitaliconidx = [self.hospitaliconidx copyWithZone:zone];
        copy.map = [self.map copyWithZone:zone];
        copy.hospitalurl = [self.hospitalurl copyWithZone:zone];
        copy.hospitaltype = [self.hospitaltype copyWithZone:zone];
        copy.hospitaldesc = [self.hospitaldesc copyWithZone:zone];
        copy.area = [self.area copyWithZone:zone];
        copy.hospitalphone = [self.hospitalphone copyWithZone:zone];
        copy.hospitaladdress = [self.hospitaladdress copyWithZone:zone];
        copy.hospitalid = [self.hospitalid copyWithZone:zone];
        copy.hospitalname = [self.hospitalname copyWithZone:zone];
        copy.icon = [self.icon copyWithZone:zone];
        copy.mapversion = [self.mapversion copyWithZone:zone];
        copy.hospitalorder = [self.hospitalorder copyWithZone:zone];
        copy.pediatricsdesc = [self.pediatricsdesc copyWithZone:zone];
        copy.showtag = [self.showtag copyWithZone:zone];
        copy.province = [self.province copyWithZone:zone];
    }
    
    return copy;
}


@end
