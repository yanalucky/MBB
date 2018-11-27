//
//  LoginUserUserSalonList.h
//
//  Created by  豆蒙萌 on 15/9/23
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface LoginUserUserSalonList : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *userSalonListIdentifier;
@property (nonatomic, strong) NSString *userid;
@property (nonatomic, strong) NSString *salonid;
@property (nonatomic, strong) NSString *signuptime;
@property (nonatomic, strong) NSString *isconfirm;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
