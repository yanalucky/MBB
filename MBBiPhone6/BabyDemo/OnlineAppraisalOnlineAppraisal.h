//
//  OnlineAppraisalOnlineAppraisal.h
//
//  Created by   on 16/7/18
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface OnlineAppraisalOnlineAppraisal : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *appraisaltime;
@property (nonatomic, strong) NSString *userid;
@property (nonatomic, strong) NSString *feature;
@property (nonatomic, strong) NSString *star;
@property (nonatomic, strong) NSString *onlineid;
@property (nonatomic, strong) NSString *appraisalage;
@property (nonatomic, assign) double feedingType;
@property (nonatomic, strong) NSString *appraisalstatus;
@property (nonatomic, strong) NSString *feedingtype;
@property (nonatomic, strong) NSString *doctorid;
@property (nonatomic, strong) NSString *monthAge;
@property (nonatomic, strong) NSString *growthappraisal;
@property (nonatomic, strong) NSString *mindappraisal;
@property (nonatomic, strong) NSString *recordid;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
