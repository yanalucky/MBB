//
//  ServerConfigDoctorList.h
//
//  Created by  豆蒙萌 on 15/9/21
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ServerConfigDoctorList : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *doctordesc;
@property (nonatomic, strong) NSString *doctorname;
@property (nonatomic, strong) NSString *doctorcode;
@property (nonatomic, strong) NSString *headversion;
@property (nonatomic, strong) NSString *certificatecode;
@property (nonatomic, strong) NSString *speciality;
@property (nonatomic, strong) NSString *loginpwd;
@property (nonatomic, strong) NSString *doctorauthority;
@property (nonatomic, strong) NSString *hospitalid;
@property (nonatomic, strong) NSString *roleid;
@property (nonatomic, strong) NSString *state;
@property (nonatomic, strong) NSString *doctorphone;
@property (nonatomic, strong) NSString *doctororder;
@property (nonatomic, strong) NSString *certificateidx;
@property (nonatomic, strong) NSString *positionaltitles;
@property (nonatomic, strong) NSString *head;
@property (nonatomic, strong) NSString *cost;
@property (nonatomic, strong) NSString *doctorimgidx;
@property (nonatomic, strong) NSString *accountemail;
@property (nonatomic, strong) NSString *doctorid;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
