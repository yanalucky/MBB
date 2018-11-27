//
//  LoginUserSalonList.h
//
//  Created by  豆蒙萌 on 15/9/23
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface LoginUserSalonList : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *salonentercount;
@property (nonatomic, strong) NSString *salonguest;
@property (nonatomic, strong) NSString *salonupdatetime;
@property (nonatomic, strong) NSString *salonimg;
@property (nonatomic, strong) NSString *salontopic;
@property (nonatomic, strong) NSString *salontagimg;
@property (nonatomic, strong) NSString *salonid;
@property (nonatomic, strong) NSString *salontime;
@property (nonatomic, strong) NSString *salonaddress;
@property (nonatomic, strong) NSString *salongdesc;
@property (nonatomic, strong) NSString *salonimgidx;
@property (nonatomic, strong) NSString *salonmapidx;
@property (nonatomic, strong) NSString *signupendtme;
@property (nonatomic, strong) NSString *contactperson;
@property (nonatomic, strong) NSString *salonindex;
@property (nonatomic, strong) NSString *salonversion;
@property (nonatomic, strong) NSString *contactmobile;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
