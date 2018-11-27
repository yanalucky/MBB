//
//  LoginUserImgdata.h
//
//  Created by  豆蒙萌 on 15/9/23
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface LoginUserImgdata : NSObject <NSCoding, NSCopying>

@property (nonatomic, assign) double age;
@property (nonatomic, strong) NSString *height;
@property (nonatomic, strong) NSString *weight;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
