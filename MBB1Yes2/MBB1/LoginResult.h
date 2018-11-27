//
//  LoginResult.h
//
//  Created by  豆蒙萌 on 15/9/21
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LoginUser;

@interface LoginResult : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) LoginUser *user;
@property (nonatomic, strong) NSString *sessionId;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
