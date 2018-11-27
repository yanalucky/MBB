//
//  OnlineAppraisalImgdata.h
//
//  Created by   on 16/7/18
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface OnlineAppraisalImgdata : NSObject <NSCoding, NSCopying>

@property (nonatomic, assign) double age;
@property (nonatomic, assign) double monthDay;
@property (nonatomic, strong) NSString *weight;
@property (nonatomic, strong) NSString *height;
@property (nonatomic, strong) NSString *submitTime;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
