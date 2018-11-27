//
//  RecordStarRecordStar.h
//
//  Created by   on 16/7/15
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface RecordStarRecordStar : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *feature;
@property (nonatomic, strong) NSString *other;
@property (nonatomic, strong) NSString *userid;
@property (nonatomic, strong) NSString *weight;
@property (nonatomic, strong) NSString *cacation;
@property (nonatomic, strong) NSString *headcircumference;
@property (nonatomic, strong) NSString *chestcircumference;
@property (nonatomic, strong) NSString *urinate;
@property (nonatomic, strong) NSString *breastfeedingml;
@property (nonatomic, strong) NSString *milkfeedingcount;
@property (nonatomic, strong) NSString *monthday;
@property (nonatomic, strong) NSString *milkfeedingml;
@property (nonatomic, strong) NSString *questionid;
@property (nonatomic, strong) NSString *submittime;
@property (nonatomic, strong) NSString *recordstatus;
@property (nonatomic, strong) NSString *cacationdays;
@property (nonatomic, strong) NSString *headCircumference;
@property (nonatomic, strong) NSString *readtag;
@property (nonatomic, strong) NSString *height;
@property (nonatomic, strong) NSString *monthendtime;
@property (nonatomic, strong) NSString *daytimesleep;
@property (nonatomic, strong) NSString *recordtime;
@property (nonatomic, strong) NSString *age;
@property (nonatomic, strong) NSString *star;
@property (nonatomic, strong) NSString *complementarytype;
@property (nonatomic, strong) NSString *monthstarttime;
@property (nonatomic, strong) NSString *recordid;
@property (nonatomic, strong) NSString *breastfeedingcount;
@property (nonatomic, strong) NSString *nighttimesleep;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
