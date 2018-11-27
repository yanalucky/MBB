//
//  LoginUserUserRecord.h
//
//  Created by  豆蒙萌 on 15/9/23
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LoginUserRecordHelp;

@interface LoginUserUserRecord : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *feature;
@property (nonatomic, strong) NSString *other;
@property (nonatomic, strong) NSString *userid;
@property (nonatomic, strong) NSString *weight;
@property (nonatomic, strong) NSString *cacation;
@property (nonatomic, strong) NSString *headcircumference;
@property (nonatomic, strong) NSString *breastfeedingcount;
@property (nonatomic, strong) NSString *urinate;
@property (nonatomic, strong) NSString *breastfeedingml;
@property (nonatomic, strong) NSString *milkfeedingml;
@property (nonatomic, strong) NSString *questionid;
@property (nonatomic, strong) NSString *submittime;
@property (nonatomic, strong) NSString *recordstatus;
@property (nonatomic, strong) NSArray *featureList;
@property (nonatomic, strong) NSString *readtag;
@property (nonatomic, strong) NSString *height;
@property (nonatomic, strong) NSString *daytimesleep;
@property (nonatomic, strong) NSString *recordtime;
@property (nonatomic, strong) LoginUserRecordHelp *recordHelp;
@property (nonatomic, strong) NSString *recordid;
@property (nonatomic, strong) NSString *age;
@property (nonatomic, strong) NSString *chestcircumference;
@property (nonatomic, strong) NSString *nighttimesleep;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
