//
//  LoginUserOnlineAppraisal.h
//
//  Created by  豆蒙萌 on 15/9/23
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface LoginUserOnlineAppraisal : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *userid;
@property (nonatomic, strong) NSString *appraisalstatus;
@property (nonatomic, strong) NSString *onlineid;
@property (nonatomic, strong) NSArray *imgdata;
@property (nonatomic, strong) NSString *appraisalage;
@property (nonatomic, strong) NSString *star;
@property (nonatomic, strong) NSString *growthappraisal;
@property (nonatomic, strong) NSString *recordid;
@property (nonatomic, strong) NSString *mindappraisal;
@property (nonatomic, strong) NSString *feedingtype;
@property (nonatomic, strong) NSString *appraisaltime;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
