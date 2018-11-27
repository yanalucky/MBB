//
//  LoginResult.h
//
//  Created by   on 16/6/13
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LoginUser;

@interface LoginResult : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *birthdayError;
@property (nonatomic, strong) NSString *menuid;
@property (nonatomic, strong) NSString *userRole;
@property (nonatomic, strong) LoginUser *user;
@property (nonatomic, strong) NSString *sessionId;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
