//
//  LoginUserNurtureGuideList.h
//
//  Created by  豆蒙萌 on 15/9/23
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface LoginUserNurtureGuideList : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *age;
@property (nonatomic, strong) NSString *nurtureGuideListIdentifier;
@property (nonatomic, strong) NSString *nurturename;
@property (nonatomic, strong) NSString *nurtureorder;
@property (nonatomic, strong) NSArray *detaillist;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
