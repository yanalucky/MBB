//
//  LoginUserBodycheckAppraisalList.h
//
//  Created by  豆蒙萌 on 15/9/23
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface LoginUserBodycheckAppraisalList : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *bodycheckappeaisalurl;
@property (nonatomic, strong) NSString *bodycheckappeaisalid;
@property (nonatomic, strong) NSString *bodycheckappeaisalurlversion;
@property (nonatomic, strong) NSString *userid;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
