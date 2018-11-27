//
//  ServerConfigHospitalList.h
//
//  Created by  豆蒙萌 on 15/9/21
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ServerConfigHospitalList : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *hospitalmapidx;
@property (nonatomic, strong) NSString *state;
@property (nonatomic, strong) NSString *iconversion;
@property (nonatomic, strong) NSString *hospitaliconidx;
@property (nonatomic, strong) NSString *map;
@property (nonatomic, strong) NSString *hospitaltype;
@property (nonatomic, strong) NSString *hospitaldesc;
@property (nonatomic, strong) NSString *area;
@property (nonatomic, strong) NSString *hospitalphone;
@property (nonatomic, strong) NSString *hospitaladdress;
@property (nonatomic, strong) NSString *hospitalid;
@property (nonatomic, strong) NSString *hospitalname;
@property (nonatomic, strong) NSString *icon;
@property (nonatomic, strong) NSString *mapversion;
@property (nonatomic, strong) NSString *hospitalorder;
@property (nonatomic, strong) NSString *showtag;
@property (nonatomic, strong) NSString *province;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
