//
//  OnlineAppraisalObject.h
//
//  Created by   on 16/7/18
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class OnlineAppraisalResult;

@interface OnlineAppraisalObject : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) OnlineAppraisalResult *result;
@property (nonatomic, assign) double errorId;
@property (nonatomic, strong) NSString *serverTime;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
