//
//  LoginUserResult.h
//
//  Created by  豆蒙萌 on 15/10/14
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LoginUserTreatBooking, LoginUserOnlineAppraisal, LoginUserBodycheckBooking, LoginUserUser, LoginUserUserRecord;

@interface LoginUserResult : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) LoginUserTreatBooking *treatBooking;
@property (nonatomic, strong) NSArray *nurtureGuideList;
@property (nonatomic, strong) NSArray *userSalonList;
@property (nonatomic, strong) LoginUserOnlineAppraisal *onlineAppraisal;
@property (nonatomic, strong) LoginUserBodycheckBooking *bodycheckBooking;
@property (nonatomic, strong) NSArray *salonList;
@property (nonatomic, strong) NSString *sessionId;
@property (nonatomic, strong) LoginUserUser *user;
@property (nonatomic, strong) NSArray *bodycheckAppraisalList;
@property (nonatomic, strong) LoginUserUserRecord *userRecord;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
